From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Add test-script for git-merge porcelain
Date: Sat, 22 Sep 2007 17:51:13 -0700
Message-ID: <7vwsuidx1a.fsf@gitster.siamese.dyndns.org>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
	<1190421186-21784-2-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 02:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZFgv-0003Cd-Kh
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 02:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbXIWAvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 20:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbXIWAvP
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 20:51:15 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:65271 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbXIWAvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 20:51:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070923005114.TEFY18654.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 22 Sep 2007 20:51:14 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id rcrD1X00N1gtr5g0000000; Sat, 22 Sep 2007 20:51:13 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58946>

Lars Hjemli <hjemli@gmail.com> writes:

> This test-script tries to excercise the porcelainish aspects of git-merge.

It does exercise; no need for "tries to" ;-).

> +test_expect_success 'verify merge result' '
> +	echo "
> +1 X
> +2
> +3
> +4
> +5
> +6
> +7
> +8
> +9
> +" > result.1 &&
> +	cmp -s file result.1
> +'

Unless there is a compelling reason otherwise, I'd prefer tests
with a test vector like this to be spelled like this:

	diff -u result.1 file

That is, compare to show the difference actual output might have
from the expected result.  It's easier to spot the difference
when you later break things this way.

> +test_expect_success 'merge c1 with c2' '
> +	git reset --hard c1 &&
> +	git merge c2 &&
> +	test "$c1" = "$(git rev-parse HEAD^1)" &&
> +	test "$c2" = "$(git rev-parse HEAD^2)"
> +'

We might also want to test:

 - the index is merged;

 - the working tree matches the index;

 - the merge message (e.g. "git show -s --pretty=format:%s
   HEAD") is as expected;

Otherwise I think it is a good idea to add these tests.

By the way, I think squash_message() leaves a wrong message
template for an Octopus, which might be worth fixing.
