From: Junio C Hamano <junkio@cox.net>
Subject: Re: Teach "git checkout" to use git-show-ref
Date: Sat, 16 Sep 2006 02:33:39 -0700
Message-ID: <7vpsdw9mvg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609151108560.4388@g5.osdl.org>
	<Pine.LNX.4.64.0609151455150.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 11:33:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOWYV-0007wW-5T
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 11:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWIPJdm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 05:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWIPJdm
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 05:33:42 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:56201 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964836AbWIPJdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 05:33:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916093341.ZLYN12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 05:33:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NxZh1V00i1kojtg0000000
	Sat, 16 Sep 2006 05:33:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609151455150.4388@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 15 Sep 2006 14:56:55 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27114>

Linus Torvalds <torvalds@osdl.org> writes:

> That way, it doesn't care how the refs are stored any more
>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> ---
>
> Just as an example of how to use git-show-ref rather than knowing about 
> "$GIT_DIR/refs/..." paths.
>
> This basically replaces my much hackier version that is in the "lt/refs" 
> branch, but can go into the master branch independently of the 
> refs-packing work.

I kind of liked the rev-parse one better for this particular
command, but only slightly (by using --verify on "$arg^0", you
were also making sure what's in refs/heads/ was a commit object,
but that check is gone with this patch.  It is not a loss,
because the original code did not check it, and nobody should be
placing anything but commits under refs/heads anyway).

> diff --git a/git-checkout.sh b/git-checkout.sh
> index 580a9e8..6e4c535 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
>...
> @@ -51,7 +51,7 @@ while [ "$#" != "0" ]; do
>  			fi
>  			new="$rev"
>  			new_name="$arg^0"
> -			if [ -f "$GIT_DIR/refs/heads/$arg" ]; then
> +			if git-show-ref --verify --quiet -- "refs/heads/$arg" ]; then
>  				branch="$arg"
>  			fi
>  		elif rev=$(git-rev-parse --verify "$arg^{tree}" 2>/dev/null)
