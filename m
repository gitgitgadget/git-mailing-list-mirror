From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 02:17:43 -0700
Message-ID: <7viquymg5k.fsf@gitster.siamese.dyndns.org>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca>
 <7vy73ur6pz.fsf@gitster.siamese.dyndns.org>
 <7vtzeir68z.fsf@gitster.siamese.dyndns.org>
 <20080722044157.GA20787@sigill.intra.peff.net>
 <20080722053921.GA4983@glandium.org>
 <20080722060643.GA25023@sigill.intra.peff.net>
 <20080722061807.GA6714@glandium.org>
 <20080722064603.GA25221@sigill.intra.peff.net>
 <20080722071009.GA3610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 11:18:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLE1E-0000gy-77
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 11:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbYGVJRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 05:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbYGVJRx
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 05:17:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYGVJRw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 05:17:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FAEA36D97;
	Tue, 22 Jul 2008 05:17:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0EB1236D94; Tue, 22 Jul 2008 05:17:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F1CDEB8-57CF-11DD-BEBE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89475>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 22, 2008 at 02:46:04AM -0400, Jeff King wrote:
>
>> I am tempted by the "order switching" I mentioned, but that would entail
>> the git process waiting to clean the pager, during which time it may be
>> consuming memory. But maybe that isn't worth worrying about.
>
> It feels very wrong proposing this during release freeze, but here is
> the "pager is child of git" implementation.

Another slight worry I have is if the now-parent git process does the
right thing when the user kills the pager without viewing the output to
the end.  git itself will get stuck with write() while the user is
reading, and then notice that the pipe does not have any more reader when
the pager is killed.  This fact itself won't change by swapping the
parent-child relationship, but would we get a sensible behaviour after
that, or have we been ignoring what happens afterwards only because our
exit status has been hidden behind the pager?  Running "git log" and
killing it by "q" (my pager is "less") makes it exit with 141.

I shouldn't worry, if everything is written correctly in the other parts
of the system, this swap should not have much ill effect.

By the way [2/2] was not signed-off.  Just forgotten?
