From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Error messages from 'git describe' shouldn't end up on the terminal
Date: Wed, 25 Jul 2007 16:09:57 -0700
Message-ID: <7vfy3ccc6y.fsf@assigned-by-dhcp.cox.net>
References: <11853733111502-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:10:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpzX-00077f-7t
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 01:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760246AbXGYXJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 19:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760174AbXGYXJ7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 19:09:59 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51249 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760067AbXGYXJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 19:09:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725230959.YCCT1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 25 Jul 2007 19:09:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Tz9y1X0071kojtg0000000; Wed, 25 Jul 2007 19:09:58 -0400
In-Reply-To: <11853733111502-git-send-email-Emilian.Medve@Freescale.com> (Emil
	Medve's message of "Wed, 25 Jul 2007 09:21:51 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53736>

Emil Medve <Emilian.Medve@Freescale.com> writes:

> As of now a failure to locate the closest tag to a commit (e.g because there is
> no tag in the repository) is handled explicitly by displaying an 'undefined' tag
> error message. However when git describe fails it will still display an
> undesirable  "fatal: cannot describe SHA1" message. This patch hides that
> message as git-submodule has an alternative and explicit error handling method
> in place for this situation
>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>  git-submodule.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 1f0cb99..3804f18 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -233,7 +233,7 @@ modules_list()
>  			say "-$sha1 $path"
>  			continue;
>  		fi
> -		revname=$(unset GIT_DIR && cd "$path" && git describe --tags $sha1)
> +		revname=$(unset GIT_DIR && cd "$path" && git describe --tags $sha1 2>/dev/null)
>  		set_name_rev "$path" "$sha1"
>  		if git diff-files --quiet -- "$path"
>  		then

It appears that set_name_rev does the moral equivalent of that
line you touched but more elaborately, to set the same
variable.  Shouldn't we be simply removing that line instead?
