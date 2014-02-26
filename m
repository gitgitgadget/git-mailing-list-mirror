From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Wed, 26 Feb 2014 12:30:36 -0800
Message-ID: <xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
References: <52E080C1.4030402@fb.com>
	<20140123225238.GB2567@sigill.intra.peff.net>
	<52E1A99D.6010809@fb.com> <52E1AB78.1000504@fb.com>
	<20140124022822.GC4521@sigill.intra.peff.net>
	<52E1D39B.4050103@fb.com>
	<20140128060954.GA26401@sigill.intra.peff.net>
	<xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
	<20140224082459.GA32594@sigill.intra.peff.net>
	<xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
	<20140226101353.GA25711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:30:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIl7t-0000aH-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbaBZUal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:30:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbaBZUak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:30:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB9096D762;
	Wed, 26 Feb 2014 15:30:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h6qrqczw5QT/vq8VTX4m/T75zOQ=; b=BiFIQ3
	tMf4L/oVp8KD4F62NUvwAwzXQU51Q3HJGLos+OJ980GQnfpJ7EansXnO98m3i+tF
	tLWFCrYfkAaf5eNuTYLdOlsOuWzXCnQR31lXxop0iiWi04MTNfQWhRjBEkcEaBVM
	kOm+ZvqTMW9JLb71Y9zet0j9y7jiGvisHj54c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kXYwq1+dvnlzBB5yK/p3c52FnnzGvobb
	sNpmxAKR3uOCHIAHPzj/xiwyTrqz7UNNRL9Z5lNHh+1OzyyZ8LQEMQ5vYQ0+2gKq
	9nfEi3H9moNMCG+KM0WEvZW/0VbE9CItQxZfS8mG7dKwudSrBoUhJrDqYcf5WgdE
	UXEc9ie/wPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C46B06D761;
	Wed, 26 Feb 2014 15:30:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 689246D760;
	Wed, 26 Feb 2014 15:30:38 -0500 (EST)
In-Reply-To: <20140226101353.GA25711@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Feb 2014 05:13:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DA7AF6BA-9F24-11E3-AA2B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242759>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 24, 2014 at 11:10:49AM -0800, Junio C Hamano wrote:
>
>> > The best name I could come up with is "--pack-keep-objects", since that
>> > is literally what it is doing. I'm not wild about the name because it is
>> > easy to read "keep" as a verb (and "pack" as a noun). I think it's OK,
>> > but suggestions are welcome.
>> 
>> pack-kept-objects then?
>
> Hmm. That does address my point above, but somehow the word "kept" feels
> awkward to me. I'm ambivalent between the two.

That word does make my backside somewhat itchy ;-)

Would it help to take a step back and think what the option really
does?  Perhaps we should call it --pack-all-objects, which is short
for --pack-all-objectsregardless-of-where-they-currently-are-stored,
or something?  The word "all" gives a wrong connotation in a
different way (e.g. "regardless of reachability" is a possible wrong
interpretation), so that does not sound too good, either.

"--repack-kept-objects"?  "--include-kept-objects"?
