From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 00:22:01 -0800
Message-ID: <7vbptrvo0m.fsf@gitster.siamese.dyndns.org>
References: <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
 <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
 <20090128020220.GE1321@spearce.org>
 <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
 <20090128033020.GF1321@spearce.org>
 <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org>
 <20090128044150.GI1321@spearce.org>
 <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
 <20090128075515.GA1133@coredump.intra.peff.net>
 <7vfxj3vos2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 09:23:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5hz-0002V6-UK
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 09:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbZA1IWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 03:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbZA1IWO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 03:22:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbZA1IWN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 03:22:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 30C451D6F9;
	Wed, 28 Jan 2009 03:22:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 65CDC1D6FE; Wed,
 28 Jan 2009 03:22:03 -0500 (EST)
In-Reply-To: <7vfxj3vos2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Jan 2009 00:05:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2A77C1A-ED14-11DD-97FF-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107506>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But in other cases, it silently gives you the wrong answer.  For
>> example, consider a history like:
>>
>>        C--D
>>       /
>>   A--B
>>       \
>>        E--F
>>
>> now let's suppose I have everything except 'E'. If I ask for
>>
>>   git rev-list F..D
>>
>> then it will not realize that A and B are uninteresting, and I will get
>> A-B-C-D. I think it is much better for git to complain loudly that it
>> could not compute the correct answer.
>
> Fair enough.  I think we can resurrect the conditional and the traversal
> option revs->ignore_missing_negative only for this hunk in my [2/2] patch
> to support that use case.
> ...

Nah, I take that back.

Even the original code does not consider this case an error.

If you really want that, the revision machinery needs major surgery, as I
already noted that the design of mark_parents_uninteresting() wants to
treat a missing uninteresting commit as a non-error event.
