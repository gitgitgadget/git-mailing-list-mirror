From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in git rebase -i where <upstream> is "HEAD" in 1.5.4?
Date: Thu, 07 Feb 2008 15:32:44 -0800
Message-ID: <7vlk5wmjfn.fsf@gitster.siamese.dyndns.org>
References: <D94A5309-3EB0-46FA-9114-D11376585DBB@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:33:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNGFX-0003gX-9l
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 00:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760998AbYBGXdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 18:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758283AbYBGXdE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 18:33:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760998AbYBGXdD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 18:33:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AE645B15;
	Thu,  7 Feb 2008 18:33:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C9DF95B13;
	Thu,  7 Feb 2008 18:32:56 -0500 (EST)
In-Reply-To: <D94A5309-3EB0-46FA-9114-D11376585DBB@apple.com> (Adam Roben's
	message of "Thu, 07 Feb 2008 16:47:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73018>

Adam Roben <aroben@apple.com> writes:

>    I've discovered a difference in behavior between `git rebase` and
> `git rebase -i`, and I believe the behavior exhibited by `git rebase -
> i` is incorrect and should be changed to match `git rebase`. The
> behavior difference occurs when running the command in the form:
>
> git rebase [-i] <upstream> <branch>
>
>    If <upstream> is "HEAD", `git rebase` seems to perform these
> (correct) steps:
>
> A=$(git rev-parse HEAD)
> git checkout <branch>
> git rebase $A

Yes, I remember writing that side carefully, taking exactly this
issue into account.

>    However, `git rebase -i` seems to perform these (incorrect) steps:

Yeah, I see that interactive side is sloppier.  In
git-rebase--interactive.sh, if you move

        HEAD=$(git rev-parse --verify HEAD) || die "No HEAD?"
        UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"

around l.481 up so that they come before if test !  -z "$2",
you would be Ok, although I didn't test it.
