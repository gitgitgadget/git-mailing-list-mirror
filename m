Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DDD634E4
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847611; cv=none; b=cG764wyZ+Lg8nEJP26AjDmdXVYOHtWOeiNAySpcRDJSDaWA3mRWZ4GiHSAIVK1yzglyCNFqIUv9juES3wxK+cYtpn3UlcjcfLJQo9wqbXFtrNVaZWJ70ctpZlfejSsdbOiEIYAweGKA9nZEE+d/DB/XXQfC6BQSQD8WL7e1aZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847611; c=relaxed/simple;
	bh=OInqaWYtXAaFk+mdPujGdom0y6W+yUGM3daK3o4Da4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovQt5/Vq3z1IZDcsxSGb7migoVnK+bfvFfu/IUfXswt2Xvdv3kmdiGCF1VTPVvczkZLtnNvwHqfBN+FdUZHlM40PYcjFJRHXwcZPKgwSnQwKyrkti4t07Iys7B/v1L4Npmb6M9RUlByWtuiWe7UB+EfuAIufqqv3qyqutyzlfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qw6PNm9c; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qw6PNm9c"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C21B1EFC10;
	Thu,  7 Mar 2024 16:40:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OInqaWYtXAaFk+mdPujGdom0y6W+yUGM3daK3o
	4Da4s=; b=Qw6PNm9ca1FJCpixlVZyUQIF0Wvh7BVPruFVfY3VJ9Qewa/FMeVo0h
	GrR/qpR3GfM+5SFiWfEGuSysSc2+GwvaVRSjrWt64j2PQj85kc0F+mIyQ39PyjS/
	eNmfPU1G2BRnUbcCHm+KWfWnALzd9fcfiY3cO/psEGrgKbildC2Fo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0E3C1EFC0F;
	Thu,  7 Mar 2024 16:40:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2ABC91EFC0E;
	Thu,  7 Mar 2024 16:40:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ignacio Encinas <ignacio@iencinas.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] config: learn the "hostname:" includeIf condition
In-Reply-To: <20240307205006.467443-2-ignacio@iencinas.com> (Ignacio Encinas's
	message of "Thu, 7 Mar 2024 21:50:06 +0100")
References: <20240307205006.467443-1-ignacio@iencinas.com>
	<20240307205006.467443-2-ignacio@iencinas.com>
Date: Thu, 07 Mar 2024 13:40:04 -0800
Message-ID: <xmqqil1xk9fv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 43604650-DCCB-11EE-AD16-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ignacio Encinas <ignacio@iencinas.com> writes:

> Currently, customizing the configuration depending on the machine running
> git has to be done manually.
>
> Add support for a new includeIf keyword "hostname:" to conditionally
> include configuration files depending on the hostname.
>
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
>  Documentation/config.txt  |  9 +++++++++
>  config.c                  | 16 ++++++++++++++++
>  t/t1305-config-include.sh | 22 ++++++++++++++++++++++
>  3 files changed, 47 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e3a74dd1c1..9a22fd2609 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibility with
>  a naming scheme that supports more variable-based include conditions,
>  but currently Git only supports the exact keyword described above.

> +`hostname`::
> +	The data that follows the keyword `hostname:` is taken to be a
> +	pattern with standard globbing wildcards. If the current
> +	hostname matches the pattern, the include condition is met.
> +

OK.  This seems to copy its phrasing from the existing text for
"gitdir" and "onbranch", which greatly helps the description for
these features consistent.

> diff --git a/config.c b/config.c
> index 3cfeb3d8bd..e0611fc342 100644
> --- a/config.c
> +++ b/config.c
> @@ -317,6 +317,20 @@ static int include_by_branch(const char *cond, size_t cond_len)
>  	return ret;
>  }
>  
> +static int include_by_hostname(const char *cond, size_t cond_len)
> +{
> +	int ret;
> +	char my_host[HOST_NAME_MAX + 1];
> +	struct strbuf pattern = STRBUF_INIT;
> +	if (xgethostname(my_host, sizeof(my_host)))
> +		return 0;
> +
> +	strbuf_add(&pattern, cond, cond_len);
> +	ret = !wildmatch(pattern.buf, my_host, 0);
> +	strbuf_release(&pattern);
> +	return ret;
> +}

Have a blank line between the end of the decl block (our codebase
frowns upon decl-after-statement) and the first statement,
i.e. before "if (xgethostname...".

Otherwise this looks reasonable to me.

> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index 5cde79ef8c..ee78d9cade 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -357,4 +357,26 @@ test_expect_success 'include cycles are detected' '
>  	grep "exceeded maximum include depth" stderr
>  '
>  
> +test_expect_success 'conditional include, hostname' '
> +	echo "[includeIf \"hostname:$(hostname)a\"]path=bar12" >>.git/config &&
> +	echo "[test]twelve=12" >.git/bar12 &&
> +	test_must_fail git config test.twelve &&

Emulating other tests in this file that uses here document may make
it a bit easier to read?  E.g.,

	cat >>.gitconfig <<-EOF &&
	[includeIf "hostname:$(hostname)a"]
		path = bar12
	EOF

> +	echo "[includeIf \"hostname:$(hostname)\"]path=bar12" >>.git/config &&

Ditto for the remainder of the patch.

Thanks.

