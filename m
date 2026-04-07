Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88FA21257F
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775542124; cv=none; b=Z43Jy6WOrTanDv1ohcVhQ672UztnX9vtJdCJuXB4Uu3Yd9WD/uh3l/53L1TevzbEiefBe+UoiIdfnZpSijN/Le3Fky2JX0QXS3V5Q/Z/nIr2v67JvO2dvrWOlprlgq6Et8R1680aqyz7vCUteiZP3qDVY4DTDVu0CNJkQ/Q9opY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775542124; c=relaxed/simple;
	bh=OUAwyHOM/wHDJ24O8ifZpDX3hTVdKq3cM1KNvRBVf6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Arq7+177eaQLI22zNPL7eIKv8gmPtb9VNCew+UMHbzhmBnaL8KPSKBo4BWc85+Q4rpC0hBrOV+AlqUneqjxoDoGemV2llCtjxIgTFIE5ZvUmPwwXdDHr0+9apehhf3VoG6KIjTRAaiQGlY2hX4vgYeINF0lCp8SXY6dTixfGi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dAZOcueh; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dAZOcueh"
Received: (qmail 269449 invoked by uid 106); 7 Apr 2026 06:08:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OUAwyHOM/wHDJ24O8ifZpDX3hTVdKq3cM1KNvRBVf6M=; b=dAZOcuehfEB18ebjBlkVc0mnZsU10esuJyxq+q01IkxGLPXzV3ZdA06wAFeEO2CHMgm9JxQ2cKWzxjDPENFr8Kq/PVXxqZvf6Z8wxA8vG3mfqdrmkc+PUeWbdCMGAKUh3O4t0i68laU9s7MCciit4vBlXmVJX1Oa5ktBb+XThjdzzXdmNZyKlOQvsQ3/RJOIZPCIx5tvhjTiQUL/cAGm959h+I36jtBsCQFL53OvqYrwyIHiiwolvlhFh6zQ3eIKpRX4y9Y5R+Vv8ZMPy7hn/5p9iEpyE4/ui9U9waWaOG1t4tYHSgaS931tU5Q/gQ5HTEWCQAx//bsje1SSb5DwFQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 06:08:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 441785 invoked by uid 111); 7 Apr 2026 06:08:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 02:08:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 02:08:42 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 10/16] repack-midx: extract
 `repack_fill_midx_stdin_packs()`
Message-ID: <20260407060842.GD714878@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cd5eba0f665a4d3a4febc47f1fe5f13200a4f941.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd5eba0f665a4d3a4febc47f1fe5f13200a4f941.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:41:16PM -0400, Taylor Blau wrote:

> This simplifies `write_midx_included_packs()` and prepares for a
> subsequent commit where the same helper is called with `cmd->out = -1`
> to capture the MIDX's checksum from the command's standard output,
> which is needed when writing MIDX layers with `--checksum-only`.

Hmm, that will involve us feeding both "in" and "out", so we'll have to
consider deadlock. We're not there yet, though... :)

-Peff
