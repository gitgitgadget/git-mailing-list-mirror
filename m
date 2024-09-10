Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEEB1755C
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986890; cv=none; b=eDyaJ/lTC7co9acm1FoLdyss3obMLOLAlnWJ+ZBkkc10ELsLIX3n8sPxQqmXo8PCVJ/04SukHH8/xAOSuT/RA9ugt5dgaZh2Ka/B3fwoBE2No+TRsfrif04s/9LwRxqVw+BLfhwBnXz05YG5BEiB+RkQt10mc55VQZpLzQ3pHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986890; c=relaxed/simple;
	bh=jdjKY00v727uGgEgAfZvi5inHD6C3fOglfDyoA4kfE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FEfrc4GGI+I41cNrX70xHzdqckwOADF2rIKzSnzj1GDw8dEwVu1UBvrqYKmmskw9cJZkV5SDmZ3UtFHXcJRul5u1Pf/8sqy8zQQQXjVwjadhTIMyosa9YNwyIKvFvS5if+JRg7USc1VFPcZtodLvMmtUE1avyMnLSEIKge7x21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=N3j0XwQt; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N3j0XwQt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A99A239424;
	Tue, 10 Sep 2024 12:48:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jdjKY00v727uGgEgAfZvi5inHD6C3fOglfDyoA
	4kfE8=; b=N3j0XwQtZtle6oc/GoGsKiqKGV6LG/yNqjJTZKg5Vqc6ClpddI0iYD
	qstCXTgezwnDODP160uj4Bx6RNXq/WiHuTB+oHU3ZS4Ow8T+nh7RD3mug29cq3cc
	byiLgr/NN6/vlf+Wx+X+sAJxIAY8XD04bhqEJBehoJO7/yTAqlY5k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B98F39423;
	Tue, 10 Sep 2024 12:48:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9F5439422;
	Tue, 10 Sep 2024 12:48:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/3] chainlint: don't be fooled by "?!...?!" in test
 body
In-Reply-To: <20240910041013.68948-2-ericsunshine@charter.net> (Eric
	Sunshine's message of "Tue, 10 Sep 2024 00:10:11 -0400")
References: <20240829091625.41297-1-ericsunshine@charter.net>
	<20240910041013.68948-1-ericsunshine@charter.net>
	<20240910041013.68948-2-ericsunshine@charter.net>
Date: Tue, 10 Sep 2024 09:48:04 -0700
Message-ID: <xmqqttenjvzv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 743DF45A-6F94-11EF-A579-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> However, when 73c768dae9 (chainlint: annotate original test definition
> rather than token stream, 2022-11-08) taught chainlint to output the
> original test text verbatim, it started collecting structured
> information about detected problems.
>
> Now that it is available, take advantage of the structured problem
> information to deterministically count the number of problems detected
> and to color the annotations directly, rather than scanning the output
> stream for "?!...?!" and performing these operations after-the-fact.

Makes sense.  Nicely done.

Will queue.  Thanks.
