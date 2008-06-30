From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: error out when given any good rev that is not an
 ancestor of the bad rev
Date: Mon, 30 Jun 2008 16:52:00 -0700
Message-ID: <7vej6etra7.fsf@gitster.siamese.dyndns.org>
References: <20080701004211.ba9b89c9.chriscool@tuxfamily.org>
 <200807010116.30214.chriscool@tuxfamily.org>
 <7vprpyts7j.fsf@gitster.siamese.dyndns.org>
 <200807010146.09206.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 01:53:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDTBI-0004Vt-Mp
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbYF3XwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 19:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753577AbYF3XwQ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:52:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173AbYF3XwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 19:52:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5033D192FD;
	Mon, 30 Jun 2008 19:52:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 62CFE192F9; Mon, 30 Jun 2008 19:52:02 -0400 (EDT)
In-Reply-To: <200807010146.09206.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue, 1 Jul 2008 01:46:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E87DD14-46FF-11DD-8AF5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86972>

Christian Couder <chriscool@tuxfamily.org> writes:

> Yes, but the fact is that the user may wrongly think that F is an ancestor 
> of D or he may not remember/know about the rule that saying "F is good" 
> means "everything from A to F is good". That's why this patch adds a safety 
> net by detecting end erroring out in this case.

Yeah, sorry about the confusion earlier.

But I do not think forbidding forked topology very early in bisection
process is a very good idea.  The user would be at loss when told:

	echo >&2 "Maybe you mistake good and bad revs?"

Aside from the "test a trial merge" idea I floated in the other message,
when we detect such a fork, perhaps we can suggest testing the merge base
version (B in your picture) first?  We would immediately know as the user
would say "B is bad" if the topology is problematic.

Then, we can suggest the user that breakage at D may not be a regression
but a longstanding bug that was recently fixed somewhere between B and F.

The user then can decide to bisect to find the fix (so that it can be
cherry picked on top of D) or merge F into D to propagate the fix forward
if it is not important to find out which exact commit fixed the issue.

Hmm?
