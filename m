Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BC1B810
	for <git@vger.kernel.org>; Sat, 10 Aug 2024 06:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723270265; cv=none; b=ZDwCPj96g2C9927cE4ZbbfdgNaDNzhXHVtbRNWuOxEWOoir/Gduhq2CiJgKmHTTm2DPrsGh0i/jcquRIZqnb1UpeD7Q3IdEyKGlCEJAiYEmNaAzOYNkWG2d4MiGXZkdmocGW2tmFjYB1uGsR3yj9bTpLDBrDjJ+vRDeE7yfWMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723270265; c=relaxed/simple;
	bh=5a9I+JLWfMhsfRosBekjf3RI/1cXlvwDJNX0Q9vV+Vg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MZZNuw/HMrXwCcA8RqUbv/JK1PDUYuVOf5R+3NrPo5DUBDPQa0xOXmVkL86KPQOlVq5D6ytvELw6Chvnf1Ik3nI3Ipy9MA+heOTIWBcRqY0nj9VIn6FbWOomh6FbomInhw0F12VhVkEm2Z6Zh8JH89qaLqoATaSNvLlMX6i9XSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pMTnmyqX; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pMTnmyqX"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 19FE632A39;
	Sat, 10 Aug 2024 02:11:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5a9I+JLWfMhsfRosBekjf3RI/1cXlvwDJNX0Q9
	vV+Vg=; b=pMTnmyqXShb2gZFDYmVdIAbvgfSZGx+36SFmklpHIjK1+bewrfo+21
	jCCzcGiQfM4Z96oyWWfGi/uDWAH66Kj6eJtIBWUX1YkZEUn7Sdp1br5lB0gHKH0s
	ofBf/H5yKKiZ2FVktXzwnO53NXgfD+aZBpQkjTy2gjn4geesnj248=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0491732A37;
	Sat, 10 Aug 2024 02:11:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E45332A35;
	Sat, 10 Aug 2024 02:11:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/4] t-reftable-readwrite: use free_names() instead
 of a for loop
In-Reply-To: <CA+J6zkSHX892NoNOyTDc-38_giBR=Q-Hf7+7nymU9GnPu1V-5Q@mail.gmail.com>
	(Chandra Pratap's message of "Sat, 10 Aug 2024 11:20:07 +0530")
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
	<20240809111312.4401-1-chandrapratap3519@gmail.com>
	<20240809111312.4401-3-chandrapratap3519@gmail.com>
	<xmqqjzgpcymq.fsf@gitster.g>
	<CA+J6zkSHX892NoNOyTDc-38_giBR=Q-Hf7+7nymU9GnPu1V-5Q@mail.gmail.com>
Date: Fri, 09 Aug 2024 23:10:59 -0700
Message-ID: <xmqqbk20aowc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 513F378E-56DF-11EF-951C-9B0F950A682E-77302942!pb-smtp2.pobox.com

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> On Sat, 10 Aug 2024 at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>>
>> > free_names() as defined by reftable/basics.{c,h} frees a NULL
>> > terminated array of malloced strings along with the array itself.
>> > Use this function instead of a for loop to free such an array.
>> ...
> This test is supposed to focus on reftable's read-write functionalities
> so it makes sense to explicitly #include only those headers that
> are directly responsible for those functionalities, namely 'reader.h',
> 'blocksource.h' and 'reftable-writer.h'. 'reftable-error.h' is thrown in
> there as well because some tests need to explicitly mention the
> various error codes and it doesn't make sense to rely on it being
> #included by others.

I think we are on the same page.  The code explicitly exercises
free_names() after this step, and that is exactly why I found it odd
to rely on basics.h happen to be included by some other header
file(s) we explicitly include.

Thanks.
