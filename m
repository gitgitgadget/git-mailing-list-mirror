From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetch --update-head-ok ?
Date: Tue, 10 Oct 2006 22:25:32 -0700
Message-ID: <7vzmc3whir.fsf@assigned-by-dhcp.cox.net>
References: <20061003123452.GK2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 07:25:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXWbD-0002ky-1S
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 07:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030796AbWJKFZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 01:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJKFZd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 01:25:33 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:7847 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932428AbWJKFZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 01:25:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011052532.ZQIC22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 01:25:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YtRb1V00P1kojtg0000000
	Wed, 11 Oct 2006 01:25:35 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20061003123452.GK2871@admingilde.org> (Martin Waitz's message of
	"Tue, 3 Oct 2006 14:34:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28693>

Martin Waitz <tali@admingilde.org> writes:

> I have no idea why there is a --update-head-ok, but the code looks
> like it has a typo:

I looked at it again, and indeed it looks like a typo.

> @@ -433,7 +433,7 @@ esac
>  # If the original head was empty (i.e. no "master" yet), or
>  # if we were told not to worry, we do not have to check.
>  case ",$update_head_ok,$orig_head," in
> -*,, | t,* )
> +*,, | ,t,* )
>         ;;
>  *)
>         curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)

Interestingly enough, when update_head_ok is set, orig_head
never is so the typo does not matter at all by pure accident (it
was there from the very first version that introduced this
feature).

It should just be something like this:

        case "$orig_head" in
        '')
                ;;
        ?*)
                curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)
                ...
