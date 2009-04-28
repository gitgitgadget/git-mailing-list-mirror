From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add --reference option to git submodule
Date: Tue, 28 Apr 2009 13:10:17 +0200
Message-ID: <49F6E419.1020308@drmicha.warpmail.net>
References: <20090428065237.GA5972@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 13:10:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LylD0-0005vg-Lp
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 13:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758078AbZD1LK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 07:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758213AbZD1LK2
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 07:10:28 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60110 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758032AbZD1LK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 07:10:27 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 3D20E327ECF;
	Tue, 28 Apr 2009 07:10:26 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 28 Apr 2009 07:10:26 -0400
X-Sasl-enc: kFUO0gkDbeJ7qUjpegnCTQFbTOG83jXy7bVS7fhxlC/k 1240917025
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4969A2AEEF;
	Tue, 28 Apr 2009 07:10:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090428065237.GA5972@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117762>

Michael S. Tsirkin venit, vidit, dixit 28.04.2009 08:52:
> This adds --reference option to 'git submodule add' and
> 'git submodule update' commands, which is passed on to git clone.
> This option is useful when the submodule is large, such as linux kernel.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> I noticed that there's no easy way to specify a reference
> for submodule repositories. Here's a patch to add this option.

Certainly useful. Just a few suggestions:

> 
>  Documentation/git-submodule.txt |   14 ++++++++++++--
>  git-submodule.sh                |   31 ++++++++++++++++++++++++++++---
>  2 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 3b8df44..0584cb7 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -9,10 +9,12 @@ git-submodule - Initialize, update or inspect submodules
>  SYNOPSIS
>  --------
>  [verse]
> -'git submodule' [--quiet] add [-b branch] [--] <repository> <path>
> +'git submodule' [--quiet] add [-b branch]
> +	      [--reference <repository>] [--] <repository> <path>
>  'git submodule' [--quiet] status [--cached] [--] [<path>...]
>  'git submodule' [--quiet] init [--] [<path>...]
> -'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--] [<path>...]
> +'git submodule' [--quiet] update [--init] [-N|--no-fetch]
> +	      [--reference <repository>] [--] [<path>...]
>  'git submodule' [--quiet] summary [--summary-limit <n>] [commit] [--] [<path>...]
>  'git submodule' [--quiet] foreach <command>
>  'git submodule' [--quiet] sync [--] [<path>...]
> @@ -177,6 +179,14 @@ OPTIONS
>  	This option is only valid for the update command.
>  	Don't fetch new objects from the remote site.
>  
> +--reference <repository>::
> +	This option is only valid for add and update commands.  These

This option applies only to add...

> +	commands sometimes need to clone a remote repository. In this case,
> +	this option will be passed to linkgit:git-clone[1] command.

...to the...

> ++
> +*NOTE*: Do *not* use this option unless you have read the note
> +for linkgit:git-clone[1] --reference and --shared options carefully.

...clone[1]\'s --reference...

> +
>  <path>...::
>  	Paths to submodule(s). When specified this will restrict the command

Either "Path(s) to submodule(s)" or "Paths to submodules". I prefer the
latter.

>  	to only operate on the submodules found at the specified paths.

..to operate on... paths only.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8e234a4..32be246 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -15,6 +15,7 @@ require_work_tree
>  command=
>  branch=
>  quiet=
> +reference=
>  cached=
>  nofetch=
>  
> @@ -91,6 +92,7 @@ module_clone()
>  {
>  	path=$1
>  	url=$2
> +	reference="$3"
>  
>  	# If there already is a directory at the submodule path,
>  	# expect it to be empty (since that is the default checkout
> @@ -106,7 +108,12 @@ module_clone()
>  	test -e "$path" &&
>  	die "A file already exist at path '$path'"
>  
> -	git-clone -n "$url" "$path" ||
> +	if test "reference"

I'm sure you want to test $reference here. I'm not sure how portable
testing for non-empty without -n is.

> +	then
> +		git-clone "$reference" -n "$url" "$path"
> +	else
> +		git-clone -n "$url" "$path"
> +	fi ||
>  	die "Clone of '$url' into submodule path '$path' failed"
>  }
>  
> @@ -131,6 +138,15 @@ cmd_add()
>  		-q|--quiet)
>  			quiet=1
>  			;;
> +		--reference)
> +			case "$2" in '') usage ;; esac
> +			reference="--reference=$2"
> +			shift
> +			;;
> +		--reference=*)
> +			reference="$1"
> +			shift
> +			;;
>  		--)
>  			shift
>  			break
> @@ -203,7 +219,7 @@ cmd_add()
>  		git config submodule."$path".url "$url"
>  	else
>  
> -		module_clone "$path" "$realrepo" || exit
> +		module_clone "$path" "$realrepo" "$reference" || exit
>  		(
>  			unset GIT_DIR
>  			cd "$path" &&
> @@ -321,6 +337,15 @@ cmd_update()
>  			shift
>  			nofetch=1
>  			;;
> +		--reference)
> +			case "$2" in '') usage ;; esac
> +			reference="$2"
> +			shift 2
> +			;;
> +		--reference=*)
> +			reference="$1"
> +			shift
> +			;;
>  		--)
>  			shift
>  			break
> @@ -351,7 +376,7 @@ cmd_update()
>  
>  		if ! test -d "$path"/.git -o -f "$path"/.git
>  		then
> -			module_clone "$path" "$url" || exit
> +			module_clone "$path" "$url" "$reference"|| exit
>  			subsha1=
>  		else
>  			subsha1=$(unset GIT_DIR; cd "$path" &&

Cheers,
Michael
