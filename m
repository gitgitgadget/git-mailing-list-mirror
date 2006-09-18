From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Sun, 17 Sep 2006 22:47:13 -0700
Message-ID: <7vpsdtu3oe.fsf@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 07:48:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPBz6-0006lG-2i
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 07:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965404AbWIRFrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 01:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965406AbWIRFrP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 01:47:15 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44267 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965404AbWIRFrO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 01:47:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918054714.JJEN6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Mon, 18 Sep 2006 01:47:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Phn11V00G1kojtg0000000
	Mon, 18 Sep 2006 01:47:01 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060918065429.6f4de06e.chriscool@tuxfamily.org> (Christian
	Couder's message of "Mon, 18 Sep 2006 06:54:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27226>

Christian Couder <chriscool@tuxfamily.org> writes:

> @@ -43,7 +46,8 @@ If you are sure you want to delete it, r
>  	    ;;
>  	esac
>  	rm -f "$GIT_DIR/logs/refs/heads/$branch_name"
> -	rm -f "$GIT_DIR/refs/heads/$branch_name"
> +	echo $NULL_SHA1 > "$GIT_DIR/refs/heads/$branch_name" || \
> +	    die "Failed to delete branch '$branch_name' !"

Don't you need mkdir -p somewhere?

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 5b04efc..150dfdc 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -47,7 +47,7 @@ test_expect_success \
>  test_expect_success \
>      'git branch -d d/e/f should delete a branch and a log' \
>  	'git-branch -d d/e/f &&
> -	 test ! -f .git/refs/heads/d/e/f &&
> +	 ! git-show-ref --verify --quiet -- "refs/heads/d/e/f" &&
>  	 test ! -f .git/logs/refs/heads/d/e/f'

I am old-fashioned and it makes me think twice when I see people
do "! command" in shell.  Bash and dash has support for it, and
opengroup has it in its base specification, so probably it is
Ok.

As usual, Solaris /bin/sh does not grok it ;-).
