Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB27222D
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548516; cv=none; b=uDbkddxKjXyHsNV5pslWa8fiFEAmLohgOo609BXPTR7S7P5YbyXO4MwLvV4eCFbXF3j8BBO9G77cvX3ccuH/3fn3GEtjJ8PqvXQTcZH27QBM6JpOR+ayjaekH6P7230sPS1lG7s46SytPlDTQS9gXoYUDVt5K7RisPyFyDvxkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548516; c=relaxed/simple;
	bh=JR1KtJF61EjIpgIxL4CzR6yZiN7m7RSLmRCWEEmXEyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FJNSTwwn5+aD8LBseRbKFuWdqiXOFaVTambmwd9qcnxzF2mg/7CL/PrLG3oqYfIkb03KMYZBKO0mqqTLuDdbnM+tyTAeNLfgoNPbjbgx+6gyYgOq/dNewTM3gCqmgUEWWTzUoVwx6TG7cvyAjAdoGSePw7JFMcSRQ9tLPFbLvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oBMbo8PU; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oBMbo8PU"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4225D207CE;
	Mon, 29 Jan 2024 12:15:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JR1KtJF61EjIpgIxL4CzR6yZiN7m7RSLmRCWEE
	mXEyo=; b=oBMbo8PUu4nzTF7BakUxCedPO+Yr5+VPYW/4hlLp7xFuh6QUXX/No6
	7aC6iZ+6ZWRmmIDxywYfnyLHuND+5pWwKq6l4YIFwyGxDkvDTPOeaxDQNEHiWZsy
	xzM27t2PAkiLCismtvDe2bsVJBrmNMUMiGS2Bi0dvq2VzO1qUyfYE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 39036207CD;
	Mon, 29 Jan 2024 12:15:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 80AB9207CA;
	Mon, 29 Jan 2024 12:15:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reftable: honor core.fsync
In-Reply-To: <Zbd0i9nOeWWNQ2EW@tanuki> (Patrick Steinhardt's message of "Mon,
	29 Jan 2024 10:48:59 +0100")
References: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
	<Zbd0i9nOeWWNQ2EW@tanuki>
Date: Mon, 29 Jan 2024 09:15:02 -0800
Message-ID: <xmqqttmwjc2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F18EC064-BEC9-11EE-9529-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The topic is currently in `next`, but not yet in `master`, so we might
> still squash it in. Junio, please let me know whether you want to do so
> or whether I shall send this fix-up as a new patch. Thanks!

Any commit in 'next' gets improved only by piling incremental
updates on top with explanation (the idea is: if all of us thought
it has been seen enough eyeballs and yet we later find there was
something we all missed, that is worth a separate explanation---the
primary motivation of the change still was good, but for such and
such reasons we missed this case), unless it turns out that the
approach was fundamentally wrong and such an incremental update
boils down to almost reverting the earlier and replacing with the
newer (in which case, we do revert the earlier and replace it with
the newer, in 'next').

Thanks.
