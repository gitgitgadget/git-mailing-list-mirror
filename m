Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293758F7D
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754122989; cv=none; b=AMfNTfm8QU/GHvuTcXSh/epGjyrCMJ4KAqnBxeRyA4ZzAcARCncWzneGsd7K7sgDtkdW8aus5/89Ea/C5ycmY3p2ispMYigAsxC+TjUEbHrioHTPFlDCD4X5DHCbt8xt3gz/Y40CoSunmSqEQTFglaXvyfbLahKjEGoiXqdgX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754122989; c=relaxed/simple;
	bh=Td4l5akMaWHrb4+SGV4oeSyODFNnZfeERym1nhrNbCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8xeYZ0SFueFwpYeoZ5mA0VtgVgtqc4f+EMRot6c3vW/WIeKun9O93m9P50ia9SWr75Y2hDRt5/07Hn+LfiJpNHzTLz9cIgG3ots2Or2YFI/I5JPayKue3j6TxTLRCRHx7osxthtHpljp2iYIxBDzRZd5FrksryxrPppTqduJqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SdcqChCS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SdcqChCS"
Received: (qmail 8582 invoked by uid 109); 2 Aug 2025 08:23:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Td4l5akMaWHrb4+SGV4oeSyODFNnZfeERym1nhrNbCA=; b=SdcqChCSFEDaLFVKAF0y3us0bd0KIbwDTl/ApHyT6byg86Vmb7cMM1Rby0qjXVx3ria50bVvPoSheIuru2ebKVDsCb3DrKDsdsOs1lo1/zAW8biPaIvj4iTX5vTdDD9g4yHZSdvuP/yedqOZEb0mC+QdLwsdPNyF00y+wxWVgZCYMw/76y1S9HdCjkUf/5vthxKe4gss4Vj6IwXNgDRwNNm5iBubZOF2OKd22FcmxCzpDBgeWqyi0/BXJu94bfF008oF7lrnI9yE1qrN5fbYOUNufBOsdQ8alIhRpTEGZzEKalHG2hPsgwSC670ofna/fkBG5LkI3o0adEPPXLSJQg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 08:22:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10547 invoked by uid 111); 2 Aug 2025 08:23:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 04:23:02 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 04:22:57 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/7] string-list: align string_list_split() with its
 _in_place() counterpart
Message-ID: <20250802082257.GA3711639@coredump.intra.peff.net>
References: <20250731224607.3942417-1-gitster@pobox.com>
 <20250801220423.1230969-1-gitster@pobox.com>
 <20250801220423.1230969-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801220423.1230969-3-gitster@pobox.com>

On Fri, Aug 01, 2025 at 03:04:18PM -0700, Junio C Hamano wrote:

> For some unknown reason, unlike string_list_split_in_place(),
> string_list_split() took only a single character as a field
> delimiter.  Before giving both functions more features in future
> commits, allow string_list_split() to take more than one delimiter
> characters to make them closer to each other.

You must know by now that writing "some unknown reason" in a commit
message is the best way to nerd-snipe me. ;)

It looks like 52acddf36c (string-list: multi-delimiter
`string_list_split_in_place()`, 2023-04-24) modified the in-place
variant, but left the original alone. It was needed for the in-place one
to replace strtok(). Probably the original _should_ have been updated
then too for consistency, but wasn't. The motivation isn't given there,
but I'd assume it was some combination of "didn't think of it",
laziness, and not wanting to update all of the callers.

I don't think there's a need to re-roll for this. Mostly I was curious
and thought I'd share my finding on the list.

-Peff
