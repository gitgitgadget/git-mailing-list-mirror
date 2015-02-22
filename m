From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: add disassociate alias to dissociate option
Date: Sun, 22 Feb 2015 10:32:22 -0800
Message-ID: <xmqqvbitx0eh.fsf@gitster.dls.corp.google.com>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
	<1424459423-11727-2-git-send-email-mattwhiteley@gmail.com>
	<20150221062754.GC29665@peff.net>
	<xmqqzj87wxck.fsf@gitster.dls.corp.google.com>
	<20150221073509.GA32548@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Matt Whiteley <mattwhiteley@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:32:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPbKX-0006iQ-Bh
	for gcvg-git-2@plane.gmane.org; Sun, 22 Feb 2015 19:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbbBVScc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2015 13:32:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752351AbbBVSca (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2015 13:32:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51B12386A5;
	Sun, 22 Feb 2015 13:32:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qjRMXSRm1/S8mJ/rwDL9v/8nQOw=; b=ebmaO3
	y+ZA8v65b1wSrm9VGXQsVp4x4RUyh1FNPYHk8sPMCC+tq98Duk3S/Bgij0AspR0a
	aeOtc/49jz36epoxBMyWxBUT9MRDDXwpauCXBxjMFRmuIZacgFPPj6pLVT5Y7rMa
	XlosrN8MNBObscR7borFPsvOpom41NxSqnKys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xFOfntAphIfMxuM2zztFGsG8b13w3t0c
	DuzUGYGEchuCXccZjzOg9qrx4u9KnfbUQAuIFFIM6vwweqnl1ZMpwfjBthlj/9zI
	u1kvh5CcamM7ii9sz62AxldmlfwiaMZlmWXk9LQu0w2OUcP03RUjk3E56tMAn6Qh
	g4dC7AWMlrw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48D93386A4;
	Sun, 22 Feb 2015 13:32:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C49CF386A3;
	Sun, 22 Feb 2015 13:32:23 -0500 (EST)
In-Reply-To: <20150221073509.GA32548@peff.net> (Jeff King's message of "Sat,
	21 Feb 2015 02:35:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 24E14FFC-BAC1-11E4-BF80-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264234>

Jeff King <peff@peff.net> writes:

> I wonder if there is some better word that could become a synonym for
> "--reference --dissociate". Maybe "--borrow", but that does not
> necessarily carry the implication that the relationship ends as soon as
> the clone is done.

You are retracing the exact line of the thinking that led me to a
cop-out that is a separate "--dissociate".

The original idea was to give "--borrow /local/repository/path", but
that would have made it unclear what the differences between that
new option and existing "--reference" were.  Both borrow the objects
in order to reduce the network cost, and the difference is that one
keeps borrowing while the other one limits the borrowing to strictly
the initial phase.  The two words, "borrow" and "reference", would
not convey that key distinction.  "Do the reference thing (which is
well understood from old days, even before v1.6.0) and then severe
the ties" was suboptimal but was easy to explain, and that is why I
call it a cop-out.

> What is really happening is that we are reusing
> objects in order to save bandwidth. Maybe "--reuse-from" would work?
>
> I dunno. I am not extremely happy with any of the suggestions I made,...

I dunno, either.

We are all on the same page.  We know the cop-out is suboptimal, we
understand why the cop-out is better than "--borrow", and we cannot
come up with a better name that contrasts with the existing
"--reference" to make it clear how the new thing is different.
