From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Fri, 14 Dec 2007 12:34:58 -0800
Message-ID: <7v63z1qakt.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
	<20071213180347.GE1224@artemis.madism.org>
	<1197570521.28742.0.camel@hinata.boston.redhat.com>
	<1197571656.28742.13.camel@hinata.boston.redhat.com>
	<20071214040803.GA10169@sigill.intra.peff.net>
	<7vir31vmsn.fsf@gitster.siamese.dyndns.org>
	<20071214083943.GA24475@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 21:35:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3HG3-0003QU-LN
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbXLNUfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 15:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbXLNUfT
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:35:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbXLNUfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 15:35:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 124BA9714;
	Fri, 14 Dec 2007 15:35:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 627BB9713;
	Fri, 14 Dec 2007 15:35:06 -0500 (EST)
In-Reply-To: <20071214083943.GA24475@artemis.madism.org> (Pierre Habouzit's
	message of "Fri, 14 Dec 2007 09:39:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68342>

Pierre Habouzit <madcoder@debian.org> writes:

> On Fri, Dec 14, 2007 at 05:59:52AM +0000, Junio C Hamano wrote:
>> 	git cmd --abbrev=10 -n=4
>
>   actually -n=4 isn't understood atm, only -n4 and -n 4 are.

Ah, my mistake.  And I do not think accepting -n=4 is a good idea (it is
not historically done).

After thinking about it a bit more, I think I was worried too much about
burdening the users to remember the differences between options with,
without and optional option-arguments [*1*].  They need to know the
difference between options with and without option-arguments already
because single letter options can be combined if they are without
option-arguments, and they have to write "shortlog -new72" but not
"shortlog -wen72".  If they want to be extra sure, they can be more
explicit and say "shortlog -n -e -w72".

So let's go with the version you outlined --- options that take optional
option-arguments must get their option-arguments stuck to them, but
otherwise option-arguments can also be given as a separate word that
follows the option.

[Footnote]

*1* The fact some of our commands support options with optional
option-arguments is already against Guideline #7 in "12.2 Utility Syntax
Guidelines", so other POSIX guidelines are not useful for us in deciding
what behaviour to model after.
