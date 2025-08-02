Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BE173
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754159916; cv=none; b=FjGaD4C/qMXrEAFwQIZoDZWh9ybrbv/bKRC4RbSBWfvi9EqTnV8IQVyGp+Wk/ZHBIB9IIqXDyD3Vk4tQAF0Y8lEFc/U0t8XybhXKdpYU5JJ4Zt+rmvu/t5IgiAou28n4hi4Qo9hmIcQJELARSrDzlRuFIJR7fbW2rTiA62AfKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754159916; c=relaxed/simple;
	bh=mqLlFilnw80bgnVHeHdz4dXCTlQazrHGCfmyQSl6NWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4S6/YnGMyvhOv29YsK1LUtP9IdtRD0RnvGG3Vkf4gBD+l/h8wCKtotjM/OV0ph5wKyxlCHuwPtqxTr1RAx0r7FP//FWeL9RupKbU59TIb27hIXW+03SSmZkoBfLdwsMgj0FT7gREPuwAmllarC/dpb74TneqNmn4gBDZGspsj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ScBF3j90; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ScBF3j90"
Received: (qmail 13683 invoked by uid 109); 2 Aug 2025 18:38:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mqLlFilnw80bgnVHeHdz4dXCTlQazrHGCfmyQSl6NWA=; b=ScBF3j90A60S9EL62UPR8VKBa4dGVtt3n7Bh4WVUFyH3wD51+yL3A76Yd9RXmj9v9pvSSdT043HLHLR8HuSPqlVRBzo62APvXIQL2yL2zM3ahZzexwc9cbc9beZsEDnxhRVfRIkaHywDDSh+ZXC4/E6VvMAxNE7W0piawK3ZrCmlMqsUp+VhhLsPQ/bPk72wrtYra7tFcFok4RX178OxP4w9Re+ST7DGkJn9AZaGnbbiD2XAYbWfljqvE4sa2dPCc53VyroZtoNGt8x8HDJNs5QnvBSfKU/bwwK2vU9fjBEzGn0A1TY89mw3jLM6s7JU/7EbzMwjcRLrxNv9RtF3uw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 18:38:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19190 invoked by uid 111); 2 Aug 2025 18:38:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 14:38:34 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 14:38:32 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/7] string-list: align string_list_split() with its
 _in_place() counterpart
Message-ID: <20250802183832.GA1773585@coredump.intra.peff.net>
References: <20250731224607.3942417-1-gitster@pobox.com>
 <20250801220423.1230969-1-gitster@pobox.com>
 <20250801220423.1230969-3-gitster@pobox.com>
 <20250802082257.GA3711639@coredump.intra.peff.net>
 <xmqq4iupk7i7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4iupk7i7.fsf@gitster.g>

On Sat, Aug 02, 2025 at 09:34:08AM -0700, Junio C Hamano wrote:

> > I don't think there's a need to re-roll for this. Mostly I was curious
> > and thought I'd share my finding on the list.
> 
> Thanks.  IIRC, the multi-delimiter capability was used only in one
> unit test or test helper that wanted to split at any whitespace.  As
> it did not look so important, I could have unified them in the other
> direction to only support a single delimiter (i.e. reverting that
> commit you found), but I think the end result of this series would
> give us more ergonomic API that we can apply at more places than
> before, so I am happy I didn't.

Agreed.

The commit I mentioned earlier said it was trying to get rid of
strtok(), so I assumed there were some real uses. But running "log
-Sstrtok", all of those strtok calls were in test helpers!

Well, at least it speaks well of us that we did not let strtok creep
into actual git code. ;)

-Peff
