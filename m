From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] user-manual: add advanced topic "bisecting merges"
Date: Sat, 10 Nov 2007 02:36:15 -0800
Message-ID: <7vsl3emlpc.fsf@gitster.siamese.dyndns.org>
References: <217E7104-312D-4D0C-BC66-C4829779C216@zib.de>
	<119468808499-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 11:36:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqnhh-0006we-PX
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 11:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbXKJKg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 05:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXKJKg1
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 05:36:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52483 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbXKJKg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 05:36:26 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 874362F2;
	Sat, 10 Nov 2007 05:36:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E291F9328A;
	Sat, 10 Nov 2007 05:36:38 -0500 (EST)
In-Reply-To: <119468808499-git-send-email-prohaska@zib.de> (Steffen Prohaska's
	message of "Sat, 10 Nov 2007 10:48:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64326>

Steffen Prohaska <prohaska@zib.de> writes:

> ...
> +A solution is to linearize the history by rebasing the lower
> +branch on top of the upper, instead of merging. There were no

Hmm.  When I wrote it, I did not mean this as a "solution", but
as an illustration of how a merge heavy history and a linear
history have impact on bisectability.  So it is more like...

    On the other hand, if you did not merge at C but rebased the
    history between Z to B on top of A, you would have get this
    linear history [illustration here].  Bisecting between Z and
    D* would hit a single culprit commit Y* instead.  This tends
    to be easier to understand why it is broken.

For this reason, many experienced git users, even when they are
working on an otherwise merge-heavy project, keep the histories
linear by rebasing their work on top of public upstreams before
publishing (when able).  An extreme example: merges from a few
top-level lieutenants to Linus in the kernel, e.g. David Miller,
are known to _almost always_ fast-forward for Linus.

IOW, the description is to mildly encourage private rebasing to
keep the job of later bisecting (for potentially others) easier.
I realize I originally wrote as if C (merge) was made by the
same person as the person who ends up bisecting, but that is
not necessarily the case.  Keeping the history without needless
merges tend to make _other_ people's lives simpler.

And after encouraging the private rebasing, I would continue
like...

    But if you already made a merge C instead of rebasing, all
    is not lost.  In the illustrated case, you can easily rebase
    one parent branch on top of the other after the fact, just
    to understand the history and to make the history more
    easily bisectable.  Even though the published history should
    not be rewound without consent with others in the project,
    nobody gets hurt if you rebased to create alternate history
    privately.  After understanding the breakage and coming up
    with a fix on top of D*, you can discard that rebased
    history, and apply the same fix on top of D, as D* and D
    should have the identical trees.
