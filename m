Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68D18C909
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370221; cv=none; b=OKrqBsWfzisqzKVijagIUX5uRhd2ZAu+KiV/K1lf5rhI3QVtg6VYA4qSKdwRebgnOCmNEYZ5DSze4Kt8pDOy2J/KpYxsLxy7CzT0b49nrYh7893tVp16MBAZ2NWFRiZCUhwvv3XdWLFAwC06z+kN+cZ1erwi2PjXmL5ikTjcibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370221; c=relaxed/simple;
	bh=wfQ3LtyKoC2ppjI0MM0svUhDmXMSuCLnKRDEkvItj+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQP41v6TDQqL9T73M8BxGxijQrxx7Z3enFmiSC2oWt+c4wZezGuPsPC9rOvYH/+mjvuGBz55xgRErR9uB+IN987HyX2alG22xcv7e0dqcst89BN/hoYDWq/JdEMW+wZXUu1JvhkZFe1EvQXCsOGpIv5gAxmg+O9Q6PgVB9ZqtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32589 invoked by uid 109); 30 Jul 2024 20:10:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jul 2024 20:10:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13992 invoked by uid 111); 30 Jul 2024 20:10:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2024 16:10:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jul 2024 16:10:17 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/3] safe.directory: normalize the configured path
Message-ID: <20240730201017.GB567852@coredump.intra.peff.net>
References: <20240723021900.388020-1-gitster@pobox.com>
 <20240720220915.2933266-1-gitster@pobox.com>
 <20240730011004.4030246-1-gitster@pobox.com>
 <20240730011004.4030246-3-gitster@pobox.com>
 <20240730074307.GB562212@coredump.intra.peff.net>
 <xmqqv80metou.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv80metou.fsf@gitster.g>

On Tue, Jul 30, 2024 at 09:22:09AM -0700, Junio C Hamano wrote:

> > Obviously not new in your patch, but maybe worth fixing while in the
> > area? I think it comes from an evil merge in b8bdb2f283 (Merge branch
> > 'jc/safe-directory-leading-path', 2024-06-12).
> 
> I think it deserves to be a separate change, probably a preliminary
> clean-up, as it predates that by a few years, and goes back to the
> initial introduction of the safe.directory feature.  The merge you
> found had this bit:

Ah, yeah, I was busy looking at the assignments and didn't notice the
ternary in the function call. So yeah, it comes from that earlier
commit, but I think it was equally useless there.

And yes, fixing it definitely should be a separate commit.

-Peff
