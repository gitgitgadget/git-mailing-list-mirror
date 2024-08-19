Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDEC49627
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098660; cv=none; b=iu8XugjNk2HeAzaN6xLRJW5VLkQB+yPM81P2Ep7Kle+GzHIhIRVL9OTjymFkAkuWbhqfDFEm4yW7Rx9yhA2lbPv+ohIQH6hwPOAS4ZYC0IHcaloa3VnXDCTsugrskvOJlyIHAD93eqR9MyGOCd1QoYK40jRrxoyAwrEbTcc+AGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098660; c=relaxed/simple;
	bh=0/RUAOvXBDGuecRdNrrAUOKVOcXYYwqLxxq3ZmT2w38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=edifb981DZUxa3ZtSwuzISB9kqtbw88XYsTIZqlXPCbggThc0A0Co9p7dHMqssXra4LB6GDYEGMEdfWukBj3Z0CwMiEk6EfmpRbamOl8HCZ6cUqH+FlhZwSOeCexXlDyEpmyM98RB9GbTP8f4w392lPZxZU+3fO6k7R2sKWrzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bGrubSYa; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bGrubSYa"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F9BE27B40;
	Mon, 19 Aug 2024 16:17:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0/RUAOvXBDGuecRdNrrAUOKVOcXYYwqLxxq3Zm
	T2w38=; b=bGrubSYamG8uxZ+/NJSE42/QzBVABsyErxoVlDc7zOS+LMlgBBLuI5
	PBnHpHdxL62Q3iiRRKQrF/rev8fcCGqmQfUMSZ4NX7rPf6u5DowVAUkO0AojUC34
	M/jPUDolaSTqmGBkwIfZ/YHHxvTaTpjMK7xobjrng3Kd9ROSSwR+Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9810E27B3F;
	Mon, 19 Aug 2024 16:17:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 24B6E27B3C;
	Mon, 19 Aug 2024 16:17:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Matheus Tavares Bernardino <matheus.tavb@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  newren@gmail.com,
  ps@pks.im,  Lincoln Yuji <lincolnyuji@hotmail.com>,  Rodrigo Siqueira
 <siqueirajordao@riseup.net>
Subject: Re: [PATCH v2] rebase -x: don't print "Executing:" msgs with --quiet
In-Reply-To: <08dc334a-e1d9-4aa1-945e-c543de549163@gmail.com> (Phillip Wood's
	message of "Mon, 19 Aug 2024 14:57:16 +0100")
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
	<be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
	<xmqq34n3jswh.fsf@gitster.g>
	<CAGdrTFhZ6KeDPDUoCsV3h5myPuoYf7RR8eFdbFFXGrUGCdEkEw@mail.gmail.com>
	<08dc334a-e1d9-4aa1-945e-c543de549163@gmail.com>
Date: Mon, 19 Aug 2024 13:17:27 -0700
Message-ID: <xmqqv7zwclns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0EEAC214-5E68-11EF-B530-BF444491E1BC-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 18/08/2024 14:03, Matheus Tavares Bernardino wrote:
>> ...
>> term_clean_line()", the correct approach would be to modify
>> "term_clean_line()" to return earlier "if (!isatty(1))". What do you
>> think?
>
> On the face of it that sounds like a good idea but I haven't thought
> too much about it. These messages are all going to stderr rather than
> stdout. If we do go that way we'll need to adjust
> launch_specified_editor() in editor.c to either suppress the hint or
> terminate it with '\n' if stderr is not a terminal.

Right.

The true reason why I brought it up was because (1) it looked really
funny to avoid doing that term_clean_line() under "--verbose" as
well as under "--quiet" and the code should explain what reasoning
backs such decision but it did not, and (2) that unexplained funny
pattern repeated, which probably was a sign that it needed to become
a small helper function with descriptive name to encapsulate the
logic to decide when to call and when not to call the clean-line,
which as a bonus would give a central place for us to explain the
reason behind not cleaning the line under "--verbose" and the same
for "--quiet" (as I suspect that these two want to omit the call for
different reasons).

Thanks.
