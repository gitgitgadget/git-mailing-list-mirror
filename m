Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1431D52C
	for <git@vger.kernel.org>; Mon,  6 May 2024 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017799; cv=none; b=IdZmXnoeUDbbyqm7ZDx5Wwj/EvqcK8eoI7kJPrGXW6kzY6VsX7sxc7qiLGrv3gN3ZtySPqkhLYt66+ghUlvXMbPRwBtXQC5Dkw+Faqgcguitx80yPc/qRGPwGbjAKU+yjSMxAk8Xxc6m92OxJya5K7jFXeHNKftTk+h2Z0z17GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017799; c=relaxed/simple;
	bh=ngzY9an2u0+Ciuz3yRuscXv2EGKAgsYkjlOCqcWWBEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShssrgS1ok1B8FBVqzMNyy+MWvROra0EK5+HoL3vNnajPhTtVLiCmJQw8NVi+9HKCkm5eypCiYnrPJ75gNFJvPuYb2mERNl6w0KEXqL5CI+sELgP8micy8Y9Nd+H/TwIHicLs8XLVY86TNANxJTgREw9oJMM6sVIc3zxWV9HjTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fjYuyNId; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fjYuyNId"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C8953EEA8;
	Mon,  6 May 2024 13:49:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ngzY9an2u0+Ciuz3yRuscXv2EGKAgsYkjlOCqc
	WWBEk=; b=fjYuyNIdqA6RJhFNQ2lBkyjfgx0C2pDlwLxSCJ5ufqW8JOGh2NF+it
	ZXRJc1QXiKFeXyYVwTLqDoGaN/pmj+xzhKrEREJEQamoBJywfxj/BDyaySZCvci/
	6pm+Z7o3U+5T8pyHf+X6QSG2as83f35ros5ENKbKZlxgRA9/Srdy8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 43CC43EEA7;
	Mon,  6 May 2024 13:49:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9FC83EEA6;
	Mon,  6 May 2024 13:49:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jtobler@gmail.com>
Subject: Re: [PATCH] ci: fix Python dependency on Ubuntu 24.04
In-Reply-To: <ZjjU_Gaum8iYLks8@tanuki> (Patrick Steinhardt's message of "Mon,
	6 May 2024 15:02:52 +0200")
References: <cb8cefc20f373a3516695e7cbee975132553ea95.1714973381.git.ps@pks.im>
	<c2dyqdqge3ypc7syissjm3mh6fqftojvincu4qizkuravc5ll6@bjgjlcas7n4k>
	<ZjjU_Gaum8iYLks8@tanuki>
Date: Mon, 06 May 2024 10:49:55 -0700
Message-ID: <xmqq7cg6zv7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D11C436-0BD1-11EF-B57C-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> So ultimately, it does not matter which jobs use what. But what does
> matter is whether the image even supports Python 2. And as we nowadays
> do have a fair split of jobs using "ubuntu:20.04" and "ubuntu:latest",
> I'd just use that the the criterium to pick the Python version.
>
> Once we drop support for Ubuntu 20.04, we can then more forward and stop
> supporting Python 2 altogether. Or maybe even earlier than that -- I do
> not think it is reasonable to ask Git to maintain compatibility with a
> project that is end of life already.

Yup.  If an distro sticks to Python 2 for whatever reason, they may
want to donate and dedicate CI resources, but otherwise it is not
really our job to keep compatibility on our side.

>> With this change, "linux-gcc" jobs using ubuntu 20.04 will now use
>> Python 2. Is that what we want?
>
> Well, as explained above, the selection was arbitrary in the first
> place. Now it's less so as the choice is mandated by what is actually
> supported.

Yup, as long as there is one that supports Python 2 among the
distros we happen to use for our CIs, we can pick that one.
Otherwise we should drop.

Dropping Python 2 support does not have to wait for Git 3.0, I would
say.

Thanks.
