From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Silence a bunch of format-zero-length warnings
Date: Wed, 07 May 2014 13:31:08 -0700
Message-ID: <xmqqr4458h6b.fsf@gitster.dls.corp.google.com>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
	<1399183975-2346-4-git-send-email-felipe.contreras@gmail.com>
	<20140504190121.GP75770@vauxhall.crustytoothpaste.net>
	<20140505052117.GC6569@sigill.intra.peff.net>
	<xmqq4n11bgf6.fsf@gitster.dls.corp.google.com>
	<20140507200542.GC4013@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed May 07 22:31:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8Uo-0006ay-DF
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbaEGUbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:31:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62615 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbaEGUbN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:31:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2925E16DB5;
	Wed,  7 May 2014 16:31:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=62wW6OKlHkHJTYjxPFLlHgCkzj4=; b=CPv5Js
	TYyUPXkpb+pBdZWVbERkeSSWqt1aS6QoS0lFG2jsXZl9l3JtgP4PaDFycGbV9Xcf
	PJnBGnWEIF4wz1uCcGBVIKRfVpi8Za9BaMJgs9mvhJn1WLlNTCLfAOzCzyPhRvYe
	QdTSh+6x7wIgOJH1zXA8ewDVt5BGXCQDd6Dx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E/d6B7CTPGXjR1v1lzJBM/TBwl03dARZ
	RsvRlNCIeyW438x+Ey+1aFLIknEDcDvqs6EWBiCe5qT0h75MJKkV3H8H0BhHoSx2
	MtS8LP948xAbBq6+E1ddakmI42NSmZ/6/wvBQnFQngKv+Zz/VhZ8g9YaMw7OBpR6
	fsCOobihmos=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0C0E816DB4;
	Wed,  7 May 2014 16:31:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B5D5616DAB;
	Wed,  7 May 2014 16:31:09 -0400 (EDT)
In-Reply-To: <20140507200542.GC4013@sandbox-ub> (Heiko Voigt's message of
	"Wed, 7 May 2014 22:05:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 861095EC-D626-11E3-8DE0-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248361>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Wed, May 07, 2014 at 11:19:09AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> ...
>> > Yeah, this started last summer when we added __attribute__((format)) to
>> > the status_printf_ln calls, and I posted essentially the same patch.  We
>> > kind of waffled between "eh, just set -Wno-format-zero-length" and doing
>> > something, and ended up at the former. I'd be fine with doing it this
>> > way; we're not likely to add a lot of new callsites that would make it a
>> > hassle to keep up with.
>> 
>> OK, so I'll take it as your Ack ;-)
>
> What happened to this patch? These warnings are still annoying me on my
> Ubuntu 14.04.

As Peff summarized, an earlier patch was dropped with "It is easy
for builders with such compilers to squelch the warning."  We are
reversing the course, with an updated log message like this ;-)

   The user have long been told to pass -Wno-format-zero-length, but a
   patch that avoids warning altogether is not too noisy, so let's do
   so.
