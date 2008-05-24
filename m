From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ALTERNATIVE PATCH] diff file1 file2: do not default to
 --no-index inside a git repository
Date: Sat, 24 May 2008 00:25:37 -0700
Message-ID: <7vskw8madq.fsf@gitster.siamese.dyndns.org>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com>
 <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org>
 <alpine.LFD.1.10.0805230942480.3081@woody.linux-foundation.org>
 <7vbq2wsxnk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805232309350.30431@racer>
 <alpine.DEB.1.00.0805232349410.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 24 09:27:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzo9k-0007HK-5H
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 09:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbYEXHZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 03:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYEXHZs
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 03:25:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbYEXHZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 03:25:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 15CC53CF8;
	Sat, 24 May 2008 03:25:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 33AFC3CF6; Sat, 24 May 2008 03:25:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9F84418A-2962-11DD-A203-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82798>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When calling "diff -- a b" where a exists in the index, but b does not,
> do not default to --no-index inside a git repository.
>
> For example,
>
> 	git mv a b && git diff a b
>
> would not have the expected result.

I think the rule should be much stricter and "git diff" should _not_ use
no-index if run in a repository without --no-index.

I also suspect that your updates to the testsuite are grossly inadequate.
Earlier "diff expect actual" was replaced with "git diff expect actual"
against my good taste (TM) in many tests, and they need to either be
replaced with "git diff --no-index" or (even better) "test_cmp".

No need to resend, as I did a rather unpleasant conversion of these places
back to "test_cmp" already, but I'd appreciate an extra set of eyeballs to
proofread that rather large fix to the testsuite.
