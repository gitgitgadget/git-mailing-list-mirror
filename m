From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add--interactive: allow diff colors without interactive colors
Date: Sat, 05 Jan 2008 01:28:25 -0800
Message-ID: <7v3atcd3k6.fsf@gitster.siamese.dyndns.org>
References: <20080104083521.GB3354@coredump.intra.peff.net>
	<7v3atdi0na.fsf@gitster.siamese.dyndns.org>
	<20080105033713.GA26806@coredump.intra.peff.net>
	<7vk5mod7kg.fsf@gitster.siamese.dyndns.org>
	<20080105085113.GA30598@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 10:29:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB5Kz-0000Qw-Pk
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 10:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbYAEJ2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 04:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYAEJ2j
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 04:28:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYAEJ2h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 04:28:37 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F9E0771D;
	Sat,  5 Jan 2008 04:28:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C80CA771C;
	Sat,  5 Jan 2008 04:28:32 -0500 (EST)
In-Reply-To: <20080105085113.GA30598@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 5 Jan 2008 03:51:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69658>

Jeff King <peff@peff.net> writes:

> But he doesn't have to care about that. He cares only that "color.diff"
> means "diffs are displayed in color." And "color.interactive" means
> "interactive menus are displayed in color."
> ...
>> If he told "git add -p" to be monochrome, he has every right to expect
>> the part to pick hunks to also stay monochrome.  To people who know
>
> But he didn't. He said "git menus should be monochrome."

Who said anything about "interactive is limited to interactive
menus" anywhere?  That is where we differ and what you do not
seem to be getting.  I am talking about color.interactive that
controls the whole user experience of interacting with "add -i".

> Moreover, this doesn't allow "I always want color in diffs,
> but I don't want menu coloring" which is the very thing I have
> been trying to accomplish (but yes, I can do that by
> individually setting color.interactive.* to plain).

As you said earlier you may also be minority, but yes the color
pallette would help you do that.

> I fail to see how this is less confusing than just adding a separate
> interactive-diff knob, since you are asking them to individually set
> each color preference to plain.

What I am aiming at in longer term is to simplify things this way:

 * Users are categorized broadly into two groups.  The ones who
   like colours and the ones who don't want colours at all.
   color.git would control this (with backward compatibility
   options per command such as color.diff and
   color.interactive);

 * Minorities who want to disable colours for particular parts
   of the UI have enough knobs to tweak in the form of palettes.
   By definition this needs to address "particular parts", so
   "color.$command.$context" variables (e.g. color.diff.new,
   color.interactive.new; if somebody really really wants to
   have different settings between diff/show/log, that person
   could add color.{show,log}.new as well) are needed if we want
   to do this.

> E.g., given
> config options:
> ...
>> Admittedly, it's more work.
>
> Of course. ;) But I am willing to implement what I said above if you
> agree that it is sensible.

I think we share the ultimate goal of introducing higher level
knobs and our difference is just about minor details of how to
get there and what the intermediate levels look like.

I am trying to avoid introducing new intermediate level knobs
(e.g. color.log vs color.diff), as it is enough to disable or in
general change the way particular parts of the UI is coloured by
palette setting that specifically states which part of the UI is
tweaked (e.g. color.interactive.prompt).
