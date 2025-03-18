Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147558F5A
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257215; cv=none; b=RKNOvmTDQg8JgkQ8ajGKPCnDuk0XGed38YnEEo0ALNHmgHcaYzH4J0XU5D56yPnw96uWiB26e/m+fBGl1tIOJOnUotblrLEJ0wa+RvstBMoHn0lIsJ5Hx581LiGUVRt4b/lyTvQuanh2AU2dmS76aRLbxVEw8WSMyze+kHr7an4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257215; c=relaxed/simple;
	bh=fr6QMbREzgNKD2ZP1ndZDsuf64g2V3l5lsgpBF4RsNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvfrlRj2WzMdTD0gPinFxaJAZThz5GS37j4AuehxravLwIlWUdvFaejTSQ3sEpAkA+5CRLueGbpZTquFpvEfrDWw6JpeFQv7ZiyaNsGUxKoR5feUmqCKWBDW16fFUaYvwaUnCJBKtROxhXOJK+dzEIA0xTQSzj3vSQd3kcvf0QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Fvx+/NKR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Fvx+/NKR"
Received: (qmail 25801 invoked by uid 109); 18 Mar 2025 00:20:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fr6QMbREzgNKD2ZP1ndZDsuf64g2V3l5lsgpBF4RsNE=; b=Fvx+/NKRivEa5hfrNvW1MDzkjiWQ3zI9459Y5FvMqYcAf9CBG6cnhDdgiaDWtB0Zj/EbHg1orLAvZ+XD+foMeWQOdKMqvXDLRLi/yCTmAK0fPoeEDrSaVcu+Cuph/o0VnhZzTv3a+j6J/+jqiXkAi8jYGRAijpvPfS8EDoVs+KsNCfKsCY+zH8ZZm8B3VUujfUqIGPvMqrC8A/siDXWQpu4Nee07E6MIK+FYr1giTdCL1P3e4ARgBTG65rW1p0UN1ipw/zi4W+LNP+fLfYsWYYsqBhgV+qb5eoJtSwM3sKK33r+uNuQ4D2UJTQNnX9bgnnxuLagMp/FaYEu0ShYWJg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 00:20:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2148 invoked by uid 111); 18 Mar 2025 00:20:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 20:20:12 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 20:20:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] git-compat-util: add NOT_CONSTANT macro and use
 it in atfork_prepare()
Message-ID: <20250318002012.GB1470172@coredump.intra.peff.net>
References: <20250314210909.3776678-1-gitster@pobox.com>
 <20250317235329.809302-1-gitster@pobox.com>
 <20250317235329.809302-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250317235329.809302-3-gitster@pobox.com>

On Mon, Mar 17, 2025 at 04:53:28PM -0700, Junio C Hamano wrote:

> Introduce NOT_CONSTANT() macro, with which, the developer can tell
> the compiler:

This name looks great to me.

>  compiler-tricks/not-a-constant.c |  2 ++

And this is much better, too. ;) I see you dropped the "a" in the macro
name; I don't know if it matters much to do it here, too.

-Peff
