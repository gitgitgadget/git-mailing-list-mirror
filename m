From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --patchdepth parameter to git-am.sh
Date: Wed, 07 Feb 2007 00:27:54 -0800
Message-ID: <7vfy9ibcdx.fsf@assigned-by-dhcp.cox.net>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
	<200702051924.39205.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 09:27:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEi9n-0005Vb-DB
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 09:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbXBGI14 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 03:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbXBGI14
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 03:27:56 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:45086 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752326AbXBGI1z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 03:27:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207082755.ZLX4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 03:27:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LYTu1W0091kojtg0000000; Wed, 07 Feb 2007 03:27:54 -0500
In-Reply-To: <200702051924.39205.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 5 Feb 2007 19:24:38 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38893>

Andy Parkins <andyparkins@gmail.com> writes:

> If the series of patches you are applying via git-am was based in a
> different directory there was no way to strip the directory (as you
> would with git-apply).
>
> This patch adds a --patchdepth option to git-am.sh whose argument is
> passed as a "-p" option to git-apply.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> I know git-apply isn't going anywhere, but git-applypatch is.  However, all
> this talk of it made me remember this patch.

I do not understand this remark, as applypatch does not have -p
either.  If we were to do this, I agree with others that this
should simply be called -p (we do not have name crash with
existing options, do we?).

I am not sure how useful applying a patch though git-am with -p
would be.  I can understand, 

After seeing that a patch does not apply because the patch was
generated at the wrong level, it would be very natural to use
"git apply -p0 --index .dotest/patch" and then continue with
"git am --resolved".  So obviously, -p to git-apply is very
useful, but -p given to "am" means all of the patches in your
mailbox has uniformly wrong patch depth.  I wonder how common
would that be in practice.

But other than that "how useful would that be in practice?"
issue, I do not think the patch is too bad, except one hunk:

> @@ -389,12 +392,12 @@ do
>  	fi
>  
>  	echo
> -	echo "Applying '$SUBJECT'"
> +	echo "Applying '$SUBJECT' at depth $patchdepth"
>  	echo
>  

This is wrong if you do not use any $patchdepth.
