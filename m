From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] t0303: immediately bail out w/o
 GIT_TEST_CREDENTIAL_HELPER
Date: Thu, 15 Mar 2012 10:50:05 -0700
Message-ID: <7vobrxkb3m.fsf@alter.siamese.dyndns.org>
References: <20120314141401.GC28595@in.waw.pl>
 <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
 <7v8vj2omiv.fsf@alter.siamese.dyndns.org>
 <20120315035405.GA4149@sigill.intra.peff.net>
 <7vk42ml5er.fsf@alter.siamese.dyndns.org>
 <20120315132428.GB8467@sigill.intra.peff.net>
 <20120315132642.GA8945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 18:50:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Eod-000161-Bk
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 18:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179Ab2CORuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 13:50:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031939Ab2CORuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 13:50:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24D7C6D6F;
	Thu, 15 Mar 2012 13:50:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5EingVwkkObeClBe3c96fx9N2s=; b=mX8FOt
	soGO3+Htpyf0NT2eE7lVb/fYjVjyH6zw2NhCHU3gr/FgqfTs9N/gCiwF8rRUf72d
	NVNsnltZnI7lVjr6I2NIkhDOSbCbKHs0B56NKZS0bnosIp2dZmyotwOnH5EwtQwc
	dN0pUJbdlxLlT15QXwdeNDsq6O6sYNSw92KXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orlZvVC5np+/oUdUAbLC+hAHuKPc6j+u
	X9oOGsIEAbWFVtHdDo/9QeEITW4qyUQo1rtKgzAVyqRvDKFNH//JML1mYcjbz5Qn
	kh88gCNxxS0p29lZsnzvKRbepsowCg0FeDwWFErbN1WbC13FWzCc8RIvG3eJ0z8t
	Ixh8Fee3pjs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CC286D6E;
	Thu, 15 Mar 2012 13:50:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC2DF6D6B; Thu, 15 Mar 2012
 13:50:06 -0400 (EDT)
In-Reply-To: <20120315132642.GA8945@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 15 Mar 2012 09:26:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CFF4334-6EC7-11E1-B744-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193218>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 15, 2012 at 09:24:28AM -0400, Jeff King wrote:
>
>> > >> 	make GIT_TEST_CREDENTIAL_HELPER=cache T=t0303-*.sh prove
>> > >> 
>> > >> seems to get stuck forever.
>> > >
>> > > It's because t0303 is the generic "test any helper" script, and does not
>> > > know how to clean up the credential-cache daemon. So the daemon sticks
>> > > around, holding onto a file descriptor that causes prove to hang.
>> > 
>> > And the reason why "sh t0303-*.sh" version does not have this problem is...?
>> [long-winded explanation from me]
>
> Oops. I read this as "why does t0301 not have the problem?". So ignore
> everything I said.
>
> The reason why running it via sh works is that we leave the daemon
> running in both cases, but only prove actually cares about the leaked
> file descriptor and blocks.

Ah, OK, the last part was what I was missing.  Thanks for a clarification.
