Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18C37144
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908050; cv=none; b=hAdUBn1+k4/GIMI8i9uz1wzom0yXbgfD6GlZB8xQ1wk5bmZqPaXs/YML3drbmKDFoiTgX4yp/pq2yPnD25WjkeguHae4ltuyaPEgBklMITLbA3jPNT+SLtnQlzojQQkq6KPfTdvp8w+eccKuVJas8d27meR+xWZ7TdWFV45ByXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908050; c=relaxed/simple;
	bh=/pd5H51POKxQgUf6IA7s3y7g5TC1p1nwEWTHIL0nZ1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bDOiuE5x5shXT3PF0hM9JPg5mQs5cYhoCRVFOQNWGrHy4mt+eFvhGqsBJexGBvjI96VpyqL47jD4is2xGe8T0XUr0hOdpeU7qdkBY5PnEK+V1qJwPSc0/rYQr8mU1Iwv/mB/eH0uFSzShHloq2idjqV9OBbkkZc4IrN1VhcZh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yWZGGMVa; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yWZGGMVa"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EC2A419A87;
	Thu, 20 Jun 2024 14:27:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/pd5H51POKxQgUf6IA7s3y7g5TC1p1nwEWTHIL
	0nZ1w=; b=yWZGGMVaUHuJbonFG8LCMDA9HS4iRouIi95EKcJzX0WTD9K6+S7fBf
	l3RoJKN+5koLXsygW2cgrKfqf0Bg0h+cEo3CY/2eB8NNcg1zVybHrXqshonTdcia
	+JR44ATlYKkEgggX1Jly2TNKOZJ7lcQp0eA4VWjcd8e4PhORoJMEE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E49E619A86;
	Thu, 20 Jun 2024 14:27:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8D45819A84;
	Thu, 20 Jun 2024 14:27:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>,
  "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
In-Reply-To: <20240619172421.33548-2-randall.becker@nexbridge.ca> (Randall
	S. Becker's message of "Wed, 19 Jun 2024 13:24:21 -0400")
References: <20240619172421.33548-1-randall.becker@nexbridge.ca>
	<20240619172421.33548-2-randall.becker@nexbridge.ca>
Date: Thu, 20 Jun 2024 11:27:16 -0700
Message-ID: <xmqq8qyzv5a3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B9ECD6BC-2F32-11EF-ACD8-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

"Randall S. Becker" <the.n.e.key@gmail.com> writes:

> This change uses the OpenSSL supplied OPENSSL_VERSION_TEXT #define supplied
> for this purpose by that project. If the #define is not present, the version
> is not reported.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  help.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/help.c b/help.c
> index 1d057aa607..ce55aaa2c0 100644
> --- a/help.c
> +++ b/help.c
> @@ -757,6 +757,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
>  
>  		if (fsmonitor_ipc__is_supported())
>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
> +#if defined OPENSSL_VERSION_TEXT
> +		strbuf_addf(buf, "OpenSSL: %s\n", OPENSSL_VERSION_TEXT);
> +#endif
>  	}
>  }

It is kind-a surprising that we do not need to play with any
Makefile macros for this implementation.

If some unknown version (either in the long past or in the future)
of OpenSSL does not define the constant, this is just compiled out
and that would be OK.

If some unknown version of OpenSSL does define it but not as a
string constant, it would break the build, e.g.,

	#define OPENSSL_VERSION_TEXT 2 plus 4 is 6

We could stringify it ourselves, but that is probably not worth
worrying about.

Will queue.  Thanks.
