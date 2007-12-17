From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Sun, 16 Dec 2007 23:59:28 -0800
Message-ID: <7v3au1eopr.fsf@gitster.siamese.dyndns.org>
References: <20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
	<20071213180347.GE1224@artemis.madism.org>
	<1197570521.28742.0.camel@hinata.boston.redhat.com>
	<1197571656.28742.13.camel@hinata.boston.redhat.com>
	<20071214040803.GA10169@sigill.intra.peff.net>
	<7vir31vmsn.fsf@gitster.siamese.dyndns.org>
	<20071214083943.GA24475@artemis.madism.org>
	<7v63z1qakt.fsf@gitster.siamese.dyndns.org>
	<20071215110311.GA11321@artemis.madism.org>
	<7vir2xeq76.fsf@gitster.siamese.dyndns.org> <47662715.9070200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Jeff King <peff@peff.net>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Ata-0006et-6B
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825AbXLQH7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 02:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbXLQH7t
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 02:59:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129AbXLQH7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 02:59:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BAF785E45;
	Mon, 17 Dec 2007 02:59:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 124905E3D;
	Mon, 17 Dec 2007 02:59:33 -0500 (EST)
In-Reply-To: <47662715.9070200@op5.se> (Andreas Ericsson's message of "Mon, 17
	Dec 2007 08:36:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68514>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
> 
>> ...  The
>> "must stick" restriction feels Ok on paper but in practice it looks
>> rather draconian and very user unfriendly.
>
> Usually, optional arguments warrant adding a second parameter. This can
> often even improve usability, as it's never unclear or ambiguous what's
> happening. For the 'git tag -l' case, I'd use something like
> 'git tag -l --match="regex"' or some such,...

That is essentially arguing for POSIXly correct "do not allow optional
option-arguments" (utility syntax guidelines #7).  That position might
be politically correct, but I am already discussing beyond that:
usability.

For "git tag -l", the fix was rather simple, as the option would either
have taken a zero pattern (list all) or a single pattern (list matching
this pattern), and the command itself did not take any extra arguments,
so that was what I did in the patch.  Compare your POSIXly correct
version:

        git tag -l			(ok)
        git tag -l pattern		(not ok)
	git tag -l --match=pattern	(ok)

with the traditional (and fixed):

        git tag -l			(ok)
        git tag -l pattern		(ok)
	git tag -l pattern garbage	(not ok)

Which one is easier for the user?
