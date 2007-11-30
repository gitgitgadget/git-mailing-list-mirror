From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Allow update hooks to update refs on their own
Date: Thu, 29 Nov 2007 17:06:29 -0800
Message-ID: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org>
References: <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com>
	<20071128221403.GA3256@midwinter.com>
	<20071128230355.GB13964@coredump.intra.peff.net>
	<7vve7m0wfo.fsf@gitster.siamese.dyndns.org>
	<35C5BEA0-0D6C-4D2E-85E7-1B78FB0BEADA@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuLK-0002eN-0c
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762009AbXK3BGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760209AbXK3BGi
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:06:38 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:51995 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758311AbXK3BGh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:06:37 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 520FE2F9;
	Thu, 29 Nov 2007 20:06:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D2ECB9B3C2;
	Thu, 29 Nov 2007 20:06:54 -0500 (EST)
In-Reply-To: <35C5BEA0-0D6C-4D2E-85E7-1B78FB0BEADA@midwinter.com> (Steven
	Grimm's message of "Wed, 28 Nov 2007 22:44:59 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66590>

Steven Grimm <koreth@midwinter.com> writes:

> If any one of #1-5 wasn't true or was solvable in a different way,
> then #6 wouldn't be needed. For example, if git-svn kept its mapping
> of git revisions to svn revisions somewhere else it could leave the
> commit messages untouched, meaning the SHA1s wouldn't change.

That does sound like an unfortunate design problem with how git-svn
keeps track of the correlation between two systems.

But after thinking about this issue a bit more, I think I agree that
allowing to munge what was pushed inside update hook may make sense even
outside of git-svn context (iow, if this were an ugly workaround for
git-svn deficiency then I would be unhappy but I think there are valid
use cases).  "You push A, I inspect it and may rewrite it to A' but only
if A' is reasonable -- otherwise I reject your pushing of A" could be a
valid thing to do in other contexts.  A stupid example would be an update
hook that tries to cleanse what you pushed for whitespace breakage and
commit a cleaned-up result only if the result passes the testsuite.
