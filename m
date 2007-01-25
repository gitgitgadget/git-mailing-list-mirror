From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] merge-one-file: use 'wc' more portably
Date: Wed, 24 Jan 2007 16:09:07 -0800
Message-ID: <7v3b60dl24.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701240213330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 01:09:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9sB0-0000XL-0V
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 01:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbXAYAJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 19:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbXAYAJK
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 19:09:10 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39877 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbXAYAJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 19:09:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125000907.HUD16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 19:09:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FC9R1W01F1kojtg0000000; Wed, 24 Jan 2007 19:09:26 -0500
In-Reply-To: <Pine.LNX.4.63.0701240213330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 24 Jan 2007 02:13:55 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37694>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Some wc prefix the number by a tab. Be prepared for this.
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  git-merge-one-file.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index 7d62d79..bc7c5ef 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -87,9 +87,9 @@ case "${1:-.}${2:-.}${3:-.}" in
>  		# This extracts OUR file in $orig, and uses git-apply to
>  		# remove lines that are unique to ours.
>  		orig=`git-unpack-file $2`
> -		sz0=`wc -c <"$orig"`
> +		sz0=`wc -c <"$orig" | tr -dc 0-9`
>  		diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add 
> -		sz1=`wc -c <"$orig"`
> +		sz1=`wc -c <"$orig" | tr -dc 0-9`
>  
>  		# If we do not have enough common material, it is not
>  		# worth trying two-file merge using common subsections.

I would prefer losing dq around the $sz0 and $sz1 where they are
used, instead of spawning tr here, and also tighten error
checking by stringing these command sequence with && followed by
a || exit.
