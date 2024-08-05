Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3007524D7
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722873793; cv=none; b=gIQCwX7cC8LpMEBmz+2j96wY+EK4+Kz+PEqye3sp4KF5isyGTsi/5DlvXLBLKrCoxN4qUgZ/Yr5QwG84qg/amIEhiyUmw6fY9oluG8Sc6mwjCvADGSK1azSjfDXDYQSUotURp4Lx31SD70iMgCgu3JfB8J4phe6e4ouNacrIzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722873793; c=relaxed/simple;
	bh=c8sELPacnz3FR8n0Ypt3WBnNCPrf37yNFd828XNJxzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZK5z555jVJ/lo4FLJPHlZMMlLAjBCGmosT0+KEpx4IWwkHQKaBvJuB+b69TSeS6z+2XkXIVqJb9xPoCUUAcOd2uLb8cTjw1Nnc5EDJuFbiIjQnCb7hflLLFnmM85K9DGq4IFCZ7jWF1VJO4s5FtSrexbW0hvHgEylBWzAkY/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yHHDLI6t; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yHHDLI6t"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFDA835BB0;
	Mon,  5 Aug 2024 12:03:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c8sELPacnz3F
	R8n0Ypt3WBnNCPrf37yNFd828XNJxzE=; b=yHHDLI6txCe7iVGtfxP3oL3xg48Q
	jTDA8K/nE0a/8Wc8KEOIMYcAU5fqo8ZEDVdBB0dKRL+8TJwKxiLVXBdTMxCVdChQ
	mBVd6dujlZTXP/WYjq9VZOAo1uTjNWDNmTKJT2BCRGSserBphDgURKP/A8Sb2WV/
	ASMm7+1JOm8EqR4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C281835BAF;
	Mon,  5 Aug 2024 12:03:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCF2935BAE;
	Mon,  5 Aug 2024 12:03:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] log-tree: use decimal_width()
In-Reply-To: <Zq+oEby6ew3HrWFK@nand.local> (Taylor Blau's message of "Sun, 4
	Aug 2024 12:10:57 -0400")
References: <06783722-5184-41d5-8edd-94f97b2f2794@web.de>
	<Zq+oEby6ew3HrWFK@nand.local>
Date: Mon, 05 Aug 2024 09:03:08 -0700
Message-ID: <xmqqh6bz3qkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 35E14D86-5344-11EF-BB07-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Taylor Blau <me@ttaylorr.com> writes:

> On Sat, Aug 03, 2024 at 02:33:24PM +0200, Ren=C3=A9 Scharfe wrote:
>> ---
>>  log-tree.c | 13 ++-----------
>>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> This looks all very reasonable to me.
>
> Some history (if interesting): lineno_width(), which was the precursor
> to decimal_width() was introduced way back in cee7f245dc (git-pickaxe:
> blame rewritten., 2006-10-19). The piece this patch removes was added i=
n
> e00de24b10 (format-patch -n: make sorting easier by padding number,
> 2007-02-09), but lineno_width() did not become part of pager.h until
> ec7ff5ba27 (make lineno_width() from blame reusable for others,
> 2012-02-12), hence why it wasn't already used here.

Thanks.

I was wondering why the decimal_width() helper is in pager.c in the
first place, as there is no logical reason to tie it to the pager
infrastructure.
