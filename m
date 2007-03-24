From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] When creating branch c/d check that branch c does not already exists.
Date: Sat, 24 Mar 2007 06:34:13 +0100
Message-ID: <200703240634.14284.chriscool@tuxfamily.org>
References: <20070324063010.a114722e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:26:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUylP-0000La-4j
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 06:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbXCXF0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Mar 2007 01:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbXCXF0A
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 01:26:00 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60819 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391AbXCXFZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2007 01:25:59 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B3989B55E1;
	Sat, 24 Mar 2007 06:25:58 +0100 (CET)
User-Agent: KMail/1.9.5
In-Reply-To: <20070324063010.a114722e.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42982>

Oops, sorry this is an old mail that was in my Draft folder and should =
not=20
have been sent...

Christian.

Le samedi 24 mars 2007 06:30, Christian Couder a =E9crit :
> With packed refs, there may not be a ".git/refs/heads/c" file
> when branch c exists. And currently in this case, there is no check
> to prevent creation of branch c/d.
>
> This should probably be rewritten in C and done after the ref lock
> has been taken to make sure no race exists though.
>
> This is mainly to make all test cases in "t3210-pack-refs.sh" work.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  git-branch.sh |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/git-branch.sh b/git-branch.sh
> index 4826c75..4a1e7d9 100755
> --- a/git-branch.sh
> +++ b/git-branch.sh
> @@ -122,6 +122,16 @@ then
>  	done
>  fi
>
> +branchdir=3D$(dirname $branchname)
> +while test "$branchdir" !=3D "."
> +do
> +	if git-show-ref --verify --quiet -- "refs/heads/$branchdir"
> +	then
> +		die "$branchdir already exists."
> +	fi
> +	branchdir=3D$(dirname $branchdir)
> +done
> +
>  if git-show-ref --verify --quiet -- "refs/heads/$branchname"
>  then
>  	if test '' =3D "$force"
