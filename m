From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Wed, 27 Nov 2013 10:57:14 -0800
Message-ID: <xmqqeh61u0z9.fsf@gitster.dls.corp.google.com>
References: <20131120203350.GA31139@kitenet.net>
	<20131120213348.GA29004@sigill.intra.peff.net>
	<20131120222805.GC26468@kitenet.net>
	<20131121114157.GA7171@sigill.intra.peff.net>
	<20131121160426.GA21843@kitenet.net>
	<20131122020911.GA12042@sigill.intra.peff.net>
	<20131122172859.GA703@kitenet.net>
	<20131124084444.GA23238@sigill.intra.peff.net>
	<20131124090743.GA495@sigill.intra.peff.net>
	<xmqq7gbwz5w8.fsf@gitster.dls.corp.google.com>
	<20131127093043.GA23429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 27 19:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlkId-0001uy-Rt
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 19:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757758Ab3K0S5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Nov 2013 13:57:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757080Ab3K0S5S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Nov 2013 13:57:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A780755607;
	Wed, 27 Nov 2013 13:57:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0SVeaqtjxfjK
	T8R0LInunIDt9is=; b=oIOO/EViRZSVvjw8NhGe2nr5p9YGu/1GDxfV16FXRVS/
	LIYSC38AJB5OJ/2xZu3LG7pLf3zPfsULAvaFE+xX/I8vDAIwnt4p3aMrW/HAtFYl
	NmRWUq1CmTpb+rXUHPuTM1EHLC2nnkIfyrZhGxtniwqapx3/fM3A5L7qUtK5grk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=j4idsK
	nHs/+F7PO+a56x5VLCyq/AufEXzVRDmnNnxrY5FIzd5kBlm8stZ1g2K4fU98hpQF
	o2fgpkTxg+DFa6JxVRG+bmF8unEoYmzpceFkj2e8B7KNKx76jPlTImXBPdVRWrxr
	yfu9T3MGmxRV6s1BAHfQh7KaRsziPs3dYyPpY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9778255606;
	Wed, 27 Nov 2013 13:57:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF12B55603;
	Wed, 27 Nov 2013 13:57:16 -0500 (EST)
In-Reply-To: <20131127093043.GA23429@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Nov 2013 04:30:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC2041F6-5795-11E3-A22D-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238451>

Jeff King <peff@peff.net> writes:

> The vast majority of blobs in git.git will be stored as packed deltas=
=2E
> That means the streaming code will fall back to doing the regular
> in-core access. We _could_ therefore use that in-core copy to do our
> sha1 check rather than streaming; but of course we never get access t=
o
> it outside of stream_blob_to_fd, and it is discarded. However, we do
> keep a copy in the delta base cache. When we immediately ask to unpac=
k
> the exact same entry for check_sha1_signature, we can pull the copy
> straight out of the cache without having to re-inflate the object.

OK, that explains the overhead of 20% that is lower than one would
na=C3=AFvely expect.  Thanks.

> Yes, I think it is a reasonable addition to the streaming API. Howeve=
r,
> I do not think there are any callsites which would currently want it.
> All of the current users of stream_blob_to_fd use read_sha1_file as
> their alternative, and not parse_object. So we are not verifying the
> sha1 in either case (we may want to change that, of course, but that =
is
> a bigger decision than just trying to bring streaming and non-streami=
ng
> code-paths into parity).

True. I am not offhand sure if we want to make read_sha1_file() to
rehash, but I agree that it is a question different from what we are
asking in this discussion.

> I also wondered if parse_object itself had problems with double-readi=
ng
> or failing to verify. But its use goes the opposite direction; it wan=
ts
> to verify the sha1 of the blob object, but it knows that it does not
> actually need the data. So it streams (as of 090ea12) to check the
> signature, but then discards each buffer-full after hashing it.
>
> -Peff
