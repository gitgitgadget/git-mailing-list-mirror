Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1294A13C9DE
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994145; cv=none; b=htas2IfOCbtG23katS3e9RS9rnIoHzMDMDd65D7eRiFMZCXoKSiK1Qtjlida7AR1veZ2aDk39x41rstD8V9IQx/PphviP9J9HS8ZQEQUQXJzNZnosmqrTiiXDaOe5xhMoGbFoXmt3TYH/mDSeZbjnM2LAGQ66dH3cCzHl1/YiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994145; c=relaxed/simple;
	bh=79jgFU5GC3HZhWWOwGx80IMzMNwp69UKsWghfJmSzT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWKVsSLvKgBxBjJMZ3KMzdJDKXoi0XMncJMnhWarAqZr2gRzO59WIU/pBcrDLDpmrpj60kVHW5KGqlm00mREufD2PA8VvwCOiHiJyMQk+Cd812U+Kt4j19bW8lZx8AtO1Dhzn3YZCZIT1DTJX1QFjKT+uT5EXwKtzoYvyG1hoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AEcOtZzX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AEcOtZzX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DD131CAE1;
	Wed, 24 Apr 2024 17:29:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=79jgFU5GC3HZhWWOwGx80IMzMNwp69UKsWghfJ
	mSzT4=; b=AEcOtZzXkIPJ+hVoGVsYPDaMIWgcYfVpJi/iAc+T/kUIZDMC4uInOz
	le6vWsQIljSZHyPwppuAtUP+DNwO1YdXQBaeZqYvn/JWiFcNcnpLdWXPQcCHYT0s
	Q5WkxDn3psDCyGm+ICYi3eu7BRHJO3xNdTnv6rlkG5v4N4flqtlpE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 744B81CAE0;
	Wed, 24 Apr 2024 17:29:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8FAE41CADB;
	Wed, 24 Apr 2024 17:28:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] commit-graph: suggest deleting corrupt graphs
In-Reply-To: <sc4xgsvzioqglqtsaqww56vctehfzkomy7wr574y3su6optu6t@punugznrq7bk>
	(Josh Steadmon's message of "Wed, 24 Apr 2024 12:30:05 -0700")
References: <cover.1708643825.git.steadmon@google.com>
	<xmqqwmqw82pv.fsf@gitster.g>
	<sc4xgsvzioqglqtsaqww56vctehfzkomy7wr574y3su6optu6t@punugznrq7bk>
Date: Wed, 24 Apr 2024 14:28:57 -0700
Message-ID: <xmqqjzkmxxeu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9E33A1E-0281-11EF-84E5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> I believe that being able to examine the files after the corruption was
> detected did help us narrow down the issue, so I would lean towards not
> automatically deleting them upon detecting corruption.

Understood.

> I don't think that this case would be detectable without running a full
> `git commit-graph verify` up front.

OK, then that approach is not worth pursuing.  Thanks for a dose of
sanity.
