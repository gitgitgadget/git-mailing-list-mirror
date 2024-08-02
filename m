Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403D16BE02
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615915; cv=none; b=Q86Dyw5SfXcrTTq0oMlLeHHkliz+GhQmZ/P7c/NF63wgVqQXX+/yNQJKTAR63hrySVmjeIAOYTWA5tnV/Uh79+cNA5ItXSzkiMHuB3qgx0m+wJsaCi+VALCgQ5HCRnlok7j1GTkXmHosVd6kHtVQh+KE1YAbqTDaM3HW+SMN5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615915; c=relaxed/simple;
	bh=dXtV2avVvvYopTD5of69ji5s0IeJJjKN/WhMqF5dNG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EZ8ffedgVXfCtnb5qh0BdnkhorhNcgsIW48Yk2xDnh400Xpd/LTDKcp+LtI65BDRZ5TTQxYt2A674oAdFu7FPzXkhr7F8I3bRUTrEfnb+L30BZZaIzV4VvSRaWRH56vgzCAjRfYnA+sNZ7UgLHVdGFzGQ0OHpehOXXNdeZkI2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=spNXOWAk; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="spNXOWAk"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA29234C94;
	Fri,  2 Aug 2024 12:25:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dXtV2avVvvYopTD5of69ji5s0IeJJjKN/WhMqF
	5dNG0=; b=spNXOWAk1RzLTU8H535MEqY4lViKSExc9U61wE/NE6E3RVCUuhy4AO
	xT1KMm6azpOknS10Pf4LkP8t4ZfWGQi9yK2D9TokGg+w6Qe5zWFTkwecj24+Hr/I
	osVTcHCEWAsupF7MN1/DzUmZebwHgglmgbAhXGe/eQ6zuc0ohP4iA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B2F1134C93;
	Fri,  2 Aug 2024 12:25:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79D6634C92;
	Fri,  2 Aug 2024 12:25:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 3/5] t-reftable-tree: split test_tree() into two
 sub-test functions
In-Reply-To: <20240802121318.4583-4-chandrapratap3519@gmail.com> (Chandra
	Pratap's message of "Fri, 2 Aug 2024 17:38:06 +0530")
References: <20240722061836.4176-1-chandrapratap3519@gmail.com>
	<20240802121318.4583-1-chandrapratap3519@gmail.com>
	<20240802121318.4583-4-chandrapratap3519@gmail.com>
Date: Fri, 02 Aug 2024 09:25:07 -0700
Message-ID: <xmqqikwievto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C937609E-50EB-11EF-BEE0-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> -	/* pseudo-randomly insert the pointers for elements between
> -	 * values[1] and values[10] (included) in the tree.
> +	/* Pseudo-randomly insert the pointers for elements between
> +	 * values[1] and values[10] (inclusive) in the tree.
>  	 */

If you are "fixing" the comment, let's fix its style as well.

	/*
         * Our multi-line comments begin with slash-asterisk, and
	 * end with asterisk-slash, on their own line.
	 */
