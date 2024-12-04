Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C220FABF
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 23:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354874; cv=none; b=mO7qqRksi1BN3a27VFXvRqLHPLhWWoU5sAQmggH1bP4+w9zRpKvNV3yaL0KsxWoL0Ir+jGUr8oCh1yTTmis4VXQVhYGmZF3zV4kMA8OmcNDQ3BH7Jq6MCAxdYZSMdI+dYjgYqf/7CyiS5IBkYtOWp8llMVoT6AV92B23ePIzc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354874; c=relaxed/simple;
	bh=S249hvsKimzMvjAMvwh3o92BVf3Fkd7zQwvaekkKdiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJBKPYS/JaKWecsuyUCr5Rv0qwi9Hlaqo8rzGJ1g5Ie32j5m+IMw3ewZGDEyaJJOyf7GBYiak+L4q50hpsHlQnvbPOFOgZPCQOwHlQd+5FfE2HLnzIpFO0XKFkIG9VLvDDEhEqpecklg2ZqObJQrxVLe8LKQbtpjIWhHp1gfizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LMbIOZxy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LMbIOZxy"
Received: (qmail 18864 invoked by uid 109); 4 Dec 2024 23:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S249hvsKimzMvjAMvwh3o92BVf3Fkd7zQwvaekkKdiQ=; b=LMbIOZxy5v/BvFzUFqpXXRVR05SWsX1ssIDZds6KW/lBw1geg1uNTpDrn1CxgC2PG4slksExZus/QyppUFaqS35FWy+RI6LLOCuvASxnLXNAj74NUHP5xE6Wj12pB+htVVPD9xJtxKpqbHEz7GPMb8VpLp2gdlbLF8xnjY9yDH6dvg3cmOtfjeCE0L5Ste/6Hzo0HHKcZoNXeR3gDwBkCgtQmRC+GKQ8vFj/j3ACANYJ8A97i0h8RwYJK4Zkd0FI6k/PVpiMOkG7EBNePZjK9ttkKFzSbMJOOOJOOzqhEPlC16/K3bezzB5rBUavJi5m5nEXTUEeWeodMC/zQfMQGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Dec 2024 23:27:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28226 invoked by uid 111); 4 Dec 2024 23:27:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Dec 2024 18:27:51 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Dec 2024 18:27:50 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, benno.martin.evers@gmail.com,
	benno@bmevers.de, ravi@prevas.dk, jpoimboe@kernel.org,
	masahiroy@kernel.org
Subject: Re: [PATCH] fixup! describe: stop traversing when we run out of names
Message-ID: <20241204232750.GA1460551@coredump.intra.peff.net>
References: <20241106211717.GD956383@coredump.intra.peff.net>
 <00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>

On Wed, Dec 04, 2024 at 03:15:42PM -0800, Josh Steadmon wrote:

> diff --git a/builtin/describe.c b/builtin/describe.c
> index 8ec3be87df..065c1bde6e 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -336,7 +336,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
>  		return;
>  	}
>  
> -	if (!max_candidates)
> +	if (!max_candidates && !always)
>  		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
>  	if (debug)
>  		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));

Yep, this is the same spot I found. I think it's the right place to make
the fix.

> Subject: Re: [PATCH] fixup! describe: stop traversing when we run out of names

This commit is already in 'next', so it's too late to squash in a change
(though I'd have done this separately anyway, as it's already an issue
for a manual --candidates=0 setting, as unlikely as that is).

Can you re-send with a full commit message?

> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 5633b11d01..9aebf09d3d 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -715,4 +715,18 @@ test_expect_success 'describe --broken --dirty with a file with changed stat' '
>  	)
>  '
>  
> +test_expect_success '--always with no refs falls back to commit hash' '
> +	git init always-no-refs &&
> +	(
> +		cd always-no-refs &&
> +		test_commit --no-tag A &&
> +		test_commit --no-tag B &&
> +		test_commit --no-tag C &&
> +		git describe --abbrev=12 --always HEAD^ >actual &&
> +		echo 13 >expected_size &&
> +		test_file_size actual >actual_size &&
> +		test_cmp expected_size actual_size
> +	)
> +'

I'm not sure if I'm missing anything subtle, but this seems more
complicated than necessary to show the bug. I think just the exit code
of:

  git describe --match=does-not-exist --always HEAD

is sufficient, even in a repo with tags. If you really want to check
stdout, then probably comparing against:

  git rev-list -1 --abbrev-commit --abbrev=13 HEAD >expect &&
  test_cmp expect actual

is a little more obvious than the size check.

-Peff
