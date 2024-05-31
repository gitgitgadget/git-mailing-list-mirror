Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0715688F
	for <git@vger.kernel.org>; Fri, 31 May 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146811; cv=none; b=NOiru697hrON7IYwuOhwn/ajSBjmxHdBNvEkPirPNCAMt9cqB3xWnX+ulFRPc6vAC3Vs0kiewVoNtQe17pj7q/3eClmGEEEkdyM38/HudgyWWHXJzSdQAojWvYGjMdd0qyPAvQAKbj0KtU0o2vwwB8G0IlPh4SwFkt+f1qYDQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146811; c=relaxed/simple;
	bh=/POsU5IpvsLPUiaEziPG8Q73Y0YcnUBWZXVObsdkYy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XejerQPgvrk1uufMMrA6ITgZdFeP6p1Pp78/rR+PhT9rii2a91ZTxUPQJmVOAyBjrCLCvw1tp0Oicr9GiFWUdopD95Fs7kfLGP3vf5pfk/THfnXyTelmdVoIZ8RVwHFH4CacWLDz72m+7c7L0MBmXDFoD1WADVWhWIZ9TrVKamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BiTKA3kZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BiTKA3kZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21F7B190BD;
	Fri, 31 May 2024 05:13:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/POsU5IpvsLPUiaEziPG8Q73Y0YcnUBWZXVObs
	dkYy0=; b=BiTKA3kZtQr87Pe8F8z2F4UGPvdDlFZH/sA2sOwhD/oDBXJFiFxVsh
	JGKAa0ULVBkwub+hU287Xp2SDdOmYZgn/bedIYGkK73K/rJkrwBgUoqKG/JsDS6N
	8cunpgd3lMaYQE7ElndzToNq/v9hx+MKEB6PmumnjjB7AoSB+Zy1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AE18190BC;
	Fri, 31 May 2024 05:13:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 878A1190BB;
	Fri, 31 May 2024 05:13:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/19] Compile with `-Wwrite-strings`
In-Reply-To: <cover.1717073346.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 30 May 2024 14:50:30 +0200")
References: <cover.1716983704.git.ps@pks.im> <cover.1717073346.git.ps@pks.im>
Date: Fri, 31 May 2024 02:13:27 -0700
Message-ID: <xmqqle3qjqdk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0B067EB4-1F2E-11EF-B380-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>      @@ reftable/readwrite_test.c: static void test_write_key_order(void)
>     + 	struct strbuf buf = STRBUF_INIT;
>     + 	struct reftable_writer *w =
>       		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
>     ++	char a[] = "a", b[] = "b", target[] = "target";

So you decided to go in the complete opposite direction, hmph...

I was hoping that we do not add more "writable" pieces of memory
like target[] only to please the constness-strict compilers.



 
