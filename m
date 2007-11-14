From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Wed, 14 Nov 2007 11:32:32 -0800
Message-ID: <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<87myth58r5.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:33:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsNyw-000523-6x
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 20:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXKNTco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 14:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbXKNTco
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 14:32:44 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37531 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbXKNTcn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 14:32:43 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 357232F0;
	Wed, 14 Nov 2007 14:33:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6014595B9C;
	Wed, 14 Nov 2007 14:32:56 -0500 (EST)
In-Reply-To: <87myth58r5.fsf@osv.gnss.ru> (Sergei Organov's message of "Wed,
	14 Nov 2007 15:09:18 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64999>

Sergei Organov <osv@javad.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> His second point is also a real issue.  If you allowed cloning
>> an empty repo (either bare or non-bare), then you and Bill can
>> both clone from it, come up with an initial commit each.  Bill
>> pushes his initial commit first.  Your later attempt to push
>> will hopefully fail with "non fast forward", if you know better
>> than forcing such a push, but then what?  You need to fetch, and
>> merge (or rebase) your change on top of Bill's initial commit,
>> and at that point the history you are trying to merge does not
>> have any common ancestor with his history.
>
> Just a wild idea. Doesn't it make sense to introduce perfect ultimate
> common ancestor of the universe, probably calling it "the NULL commit"?
> At first glance it seems that it can help to avoid corner cases
> automagically.

The tools do not have problem with the multiple-root issue; we
can merge without common ancestor just fine.  So in that area,
we do not need to kludge like that at the physical level (you
can think of root commits having "the NULL" as their parents).

But cloning void to start the same project by multiple people
and pushing their initial commits as roots to start a project
indicates the lack of developer communication (besides, it just
feels like a bad style, a hangover from centralized SCM
mentality, but that is fine).

If the "feature" can be supported with zero cost, I do not have
a problem.  If that feature does something one does not agree
with (be it promoting a bad workflow or whatever), one does not
have to use it.  All one has to do is try not to recommend using
that feature to others.

But this time, the "feature" is not a zero cost thing.  As
Matthieu said in the thread, we do not let you do so right now.
Which means that it would involve new development, the code
changes would risk regressing behaviour existing users rely on,
and we would need testing for that.  These all take resources.

We already spent quite a lot of time on this thread, and at
least to me I feel that my time would have been better spent if
instead I were looking at patches on some other topics, or
working on cleaning up cherry-pick/revert implementation.
