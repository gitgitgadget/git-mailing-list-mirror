From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Wed, 08 Jun 2016 16:05:10 -0700
Message-ID: <xmqqtwh3jn89.fsf@gitster.mtv.corp.google.com>
References: <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
	<20160606203901.GA7667@Messiaen>
	<xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
	<20160606225847.GA22756@sigill.intra.peff.net>
	<xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
	<20160607090653.GA4665@Messiaen> <575845D9.2010604@alum.mit.edu>
	<20160608191918.GB19572@sigill.intra.peff.net>
	<xmqq37onlawb.fsf@gitster.mtv.corp.google.com>
	<20160608195248.GA4264@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 01:05:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAmXP-0001Ce-K8
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 01:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426257AbcFHXFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 19:05:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1424401AbcFHXFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 19:05:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E3C15201AD;
	Wed,  8 Jun 2016 19:05:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0SDoMYGFKbh1y4vdIuAtm+Ze3Zw=; b=dV8OTj
	dqztKWIh6lw5+P5p5P/FDToWijvz4Vk3bz8aOP+LNE0uJXWAJW+ONkvEBKO7AoVt
	0Wh3VsTvAWYuy4/yIAPd/5X4YY8Jb24JVR58QKhiWAPtX3ETokG4BjDFkuedssBx
	T3BDKf1rglzu3IFloUw9eNlOYuzKu2qOweYpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=INT6CZAEcmtNkhiGJQwut6sHN7bXm8ZR
	7IHU+8xb5RqqsSBM7//qbf24pDSiLzGRGYcTXKCvF9eKph1KMNwmJlq4L0W39OVm
	75XI8lvHM+jGQ1IanPc8ZyhXRVKIYT5+e9sn4LhKWggQDmR0qJn9wc7HkxS9+031
	B2UWokNLjFE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DA0B1201AC;
	Wed,  8 Jun 2016 19:05:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59C93201AB;
	Wed,  8 Jun 2016 19:05:12 -0400 (EDT)
In-Reply-To: <20160608195248.GA4264@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 8 Jun 2016 15:52:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7451B844-2DCD-11E6-BA61-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296858>

Jeff King <peff@peff.net> writes:

> I agree it can be confusing (especially on the output side your errors
> are likely deferred until the next flush). But in this particular case,
> I think it's an improvement (see the patch I just sent and its
> discussion of error handling).

Yes, for this one, the lifetime of the file descriptor is contained
within a single function and it is straight-forward to wrap it
correctly inside a FILE * via fdopen() and do the error check at the
end, so I think the patch is an improvement.

Will queue.
