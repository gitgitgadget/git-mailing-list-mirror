Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2841B8EA8
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652694; cv=none; b=Vkk6bj6D5i2uIuTojEz3LWoIJ1YNeh7DU9u1YqzhoNXU5xdQ1Eh5qfUNql5CBBIws0rj0V56FmJeZFtDJ4JxivzRHqB91f+dxS38kolrsa1K0Vi2Lqpf2JWeKM6rKrWknFoaEQKk8tqFL/6KQjSDZaDlYnquJTRk2GVFXeSQSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652694; c=relaxed/simple;
	bh=n+trDRhQmPrR3Dvo3Bhlo8C+QFC93+GUzWWzrRT66j8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Awat837bqma2ymq35lGTjN/EnUPMbcFhoQAp+Rml65PdLWrwJ33CVpNGNcaMe8nEfb0dTDWwTVVazn+w5B/vV9xoXelrXqG/23Gk42rBsa0tPtfLpZAFxN2RARtaNbDIDcEtIZh4vxnmk5L89QXy/mO0t2RUBrFByb1YxtJP8Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ArtVggY0; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ArtVggY0"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DA5F2291C7;
	Wed, 14 Aug 2024 12:24:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n+trDRhQmPrR3Dvo3Bhlo8C+QFC93+GUzWWzrR
	T66j8=; b=ArtVggY0AiUrbAsIerj/aUKOXIisPv4g83pAAxCU+mk6Cjwa/I7k5k
	3RFndx9LXF+Up3snHi6uozmi760obikDWES+g620UJdrq+jE7L0H6Malu1QrUW6v
	nApJmytEeccYeoZjNoaMUz4Ai4Ppgq9/dqTLZOvSEaT+FSssOQIUY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D3685291C6;
	Wed, 14 Aug 2024 12:24:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 492D1291C5;
	Wed, 14 Aug 2024 12:24:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 06/10] reftable/generic: move generic iterator code into
 iterator interface
In-Reply-To: <CAOLa=ZQ15h8bFRGGhzJUPNwkCrRmc2Y26n-0x+L_V_06xWgd7g@mail.gmail.com>
	(karthik nayak's message of "Tue, 13 Aug 2024 06:04:30 -0400")
References: <cover.1723528765.git.ps@pks.im>
	<14924604cebe20ac30d291399b0200016fa8b4e3.1723528765.git.ps@pks.im>
	<CAOLa=ZQ15h8bFRGGhzJUPNwkCrRmc2Y26n-0x+L_V_06xWgd7g@mail.gmail.com>
Date: Wed, 14 Aug 2024 09:24:42 -0700
Message-ID: <xmqqh6bn1391.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B726AD0C-5A59-11EF-82C5-E92ED1CD468F-77302942!pb-smtp21.pobox.com

karthik nayak <karthik.188@gmail.com> writes:

> Seems like the CI caught it too [1].
>
>> +	it->ops->close(it->iter_arg);
>> +	it->ops = NULL;
>> +	FREE_AND_NULL(it->iter_arg);
>> +}
>> +
>
> [snip]
>
> [1]: https://gitlab.com/gitlab-org/git/-/jobs/7563308943

Looking at it, the suggestions the CI job makes look hit-and-miss.

For examle, this one

-static int stack_compact_range_stats(struct reftable_stack *st,
-				     size_t first, size_t last,
+static int stack_compact_range_stats(struct reftable_stack *st, size_t first,
+				     size_t last,
 				     struct reftable_log_expiry_config *config,
 				     unsigned int flags)

is a degradation of readability.  "first" and "last" pretty
much act as a pair and they read better sitting together next to
each other.  The rewrite is reducing neither the total number of
lines or the maximum column width.

But this one

-static void write_n_ref_tables(struct reftable_stack *st,
-			       size_t n)
+static void write_n_ref_tables(struct reftable_stack *st, size_t n)

is certainly an improvement.

This one

 	struct reftable_record rec = {
 		.type = BLOCK_TYPE_REF,
-		.u = {
-			.ref = *ref
-		},
+		.u = { .ref = *ref },
 	};

is hard to generalize but in this case it made a good suggestion.

If we _expect_ that we will enumerate more members of .u, then the
way originally written (plus trailing comma after the ".ref = *ref")
would be easier to maintain.  But since .u is a union, we won't be
choosing more than one member to initialize by definition, so what
was suggested by the check-style linter is certainly much better.

Thanks.
