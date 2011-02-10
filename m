From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Thu, 10 Feb 2011 19:00:48 +0100
Message-ID: <vpqpqqzahwv.fsf@bauges.imag.fr>
References: <20110206051333.GA3458@sigill.intra.peff.net>
	<4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
	<7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
	<20110207055314.GA5511@sigill.intra.peff.net>
	<7vhbcguytf.fsf@alter.siamese.dyndns.org>
	<20110207195035.GA13461@sigill.intra.peff.net>
	<20110208100518.GA9505@neumann>
	<20110209210312.GB2083@sigill.intra.peff.net>
	<7vipwsomq8.fsf@alter.siamese.dyndns.org>
	<20110209234621.GA12575@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 10 19:03:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnarx-00041l-E8
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 19:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab1BJSDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 13:03:46 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46314 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab1BJSDp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 13:03:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p1AI0lOJ021429
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 10 Feb 2011 19:00:47 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Pnaoz-0008R9-BI; Thu, 10 Feb 2011 19:00:49 +0100
In-Reply-To: <20110209234621.GA12575@sigill.intra.peff.net> (Jeff King's message of "Wed\, 9 Feb 2011 18\:46\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 10 Feb 2011 19:00:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1AI0lOJ021429
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297965650.15286@LMcRJEYyBoSQl2GUegaErA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166490>

Jeff King <peff@peff.net> writes:

> I don't think it's worth moving ls-files/ls-tree. They're plumbing that
> people don't use frequently. So the cost of moving them is high (because
> we are breaking something meant to be scriptable) and the benefit is low
> (because users don't type them a lot).

Right. At some point, we may want to introduce a porcelain version of
"git ls-files", but we shouldn't change its default behavior.

> The archive behavior surprised me, and I would think it should be full-tree
> by default. But it is sort of plumbing-ish, in that people have probably
> scripted around and people _don't_ tend to create archives a lot.

Right. There are probably more calls to "git archive" in cron jobs and
web interface than directly from the command-line.

> That leaves clean. I would say from a consistency standpoint that it
> should go full-tree to match the other commands. But it is one of the
> most destructive commands, and making it full-tree makes it easier to
> accidentally delete, instead of accidentally fail to delete.

Agreed. That would be really bad surprise for an experience user to
upgrade Git, type "git clean -fdx" from a subdirectory, and to notice
the new behavior afterwards ;-).

> So depending on your view of the above, it may just be "add -u/-A" and
> "grep" that are worth switching.

Agreed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
