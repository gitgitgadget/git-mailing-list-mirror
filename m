Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450F1534FB
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301136; cv=none; b=P70HcW8pw7hsIEgDqWEIn2BiYpjT9gjbftiCvldg9ZhsvddHZiracTYMHbnOQOTz27DPyiQdjj2UbSa91tbjz4rDcjGpDX/BrhJ7Fb7IN9dq5HrxCFE5ciSB90n4Un7IyaV/tfg2GLY6IPdHhiwxBP2AA3E4ExpPVJZXtsHaGSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301136; c=relaxed/simple;
	bh=Z+/RQw9r1Hmlrbccu3h1RkjrUWPD6QqVvMgnnyjttNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EORB6HTz+qpTbLeOfBzXD4kXXftzM+r+3iM0eRhG1lpssq9wpY4LelqG5Fh60wfj7tllT/T+5x7BwRyFIlyoHyk5f6QHhNqYCv8hNpce1DQg6KuY7RWbz2C3qq52s5DQWbzSF0DLZL3vfWk06XMppbj7U0CGCeVvYLTuwzyzaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s/AoNupn; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s/AoNupn"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 69277312DE;
	Wed, 25 Sep 2024 17:52:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z+/RQw9r1Hml
	rbccu3h1RkjrUWPD6QqVvMgnnyjttNE=; b=s/AoNupnf6CmiFR1d7vIbP4XjAHR
	qd6tDdv1NyK8IogITW8bJ50V4pH+MGlgJqsSKtNKfglBKXmtWJ2VJ73jrf6c6eD2
	VuPIsSlylikX3WD/U5xq05FXlmpgn94E8Qjop0C76zq4Hnz5XuLza6YUvIRuN/TJ
	XG3NB006hLSSEps=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61D82312DD;
	Wed, 25 Sep 2024 17:52:13 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9D7A312DA;
	Wed, 25 Sep 2024 17:52:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Kohei Shibata
 <shiba200712@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] diff: report modified binary files as changes in
 builtin_diff()
In-Reply-To: <3192d8f4-4c7f-4b32-b564-7e075132c41c@virtuell-zuhause.de>
	(Thomas Braun's message of "Wed, 25 Sep 2024 23:24:18 +0200")
References: <CACpkL8WsNqhQ7SP27-XQwp1bzKjyUT6m2idFarZ2Z5rLVYg4pQ@mail.gmail.com>
	<500a8e0a-9fbd-4b7b-b2f2-026a4293bc9f@web.de>
	<3192d8f4-4c7f-4b32-b564-7e075132c41c@virtuell-zuhause.de>
Date: Wed, 25 Sep 2024 14:52:11 -0700
Message-ID: <xmqq7cazo0z8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 6BE68BDC-7B88-11EF-82B9-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> Am 21.09.2024 um 17:09 schrieb Ren=C3=A9 Scharfe:
>
> Hi Ren=C3=A9,
>
>> diff --git a/diff.c b/diff.c
>> index 3be927b073..84a6bb0868 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -3675,6 +3675,7 @@ static void builtin_diff(const char *name_a,
>>   			emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
>>   					 sb.buf, sb.len, 0);
>>   			strbuf_release(&sb);
>> +			o->found_changes =3D 1;
>>   			goto free_ab_and_return;
>>   		}
>>   		if (fill_mmfile(o->repo, &mf1, one) < 0 ||
>
> I poked at the same issue in parallel and had the same fix, but ...
>
>> ...
>>   	test_expect_success "git diff $option returns 1 for copied file" "
>>   		git reset --hard &&
>>   		cp a copy &&
>
> your test is nicer.
>
> The patch works here locally.
>
> For what it's worth:
>
> Reviewed-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
>
> Thomas

Thanks.
