Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFED4666C
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LKbpy/LX"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E2106
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 16:59:33 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9882E1C32AF;
	Wed, 18 Oct 2023 19:59:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=54c873wzcjRGMXpeVnOzy/3PMdEU+IIoIL+aW5
	kIkkY=; b=LKbpy/LXl8J+tetrf79aMSAtLEVCBndibyBBTrcFEy/nSrfhcUkxNe
	vk4oicrJ3pdC6w60ct2A9E/0mxcVMNuEwgArBUmD/YJl9tSYHrEHLK9bWPaMSKoZ
	MdSvdzbs345jDlBWlPRoaf2AFC7pzAXr0yOuYbpGkxhUNPc2Le7Ck=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 916421C32AE;
	Wed, 18 Oct 2023 19:59:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C65ED1C32AD;
	Wed, 18 Oct 2023 19:59:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH v2] t/t7601: use "test_path_is_file"etc.
 instead of "test -f"
In-Reply-To: <20231018124538.68549-2-anonolitunya@gmail.com> (Dorcas
	AnonoLitunya's message of "Wed, 18 Oct 2023 15:45:12 +0300")
References: <20231018124538.68549-2-anonolitunya@gmail.com>
Date: Wed, 18 Oct 2023 16:59:30 -0700
Message-ID: <xmqqa5sfzdlp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 61705CFC-6E12-11EE-B31D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dorcas AnonoLitunya <anonolitunya@gmail.com> writes:

> Some tests in t7601 use "test -f" and "test ! -f" to see if a path
> exists or is missing.
>
> Use test_path_is_file and test_path_is_missing helper functions to
> clarify these tests a bit better. This especially matters for the
> "missing" case because "test ! -f F" will be happy if "F" exists as a
> directory, but the intent of the test is that "F" should not exist, even
> as a directory. The updated code expresses this better.
>
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
>  t/t7601-merge-pull-config.sh | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Nicely done; it seems that the title line got garbled whitespace for
some reason but I'll fix them up while queuing.

Thanks.  Will queue.


> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index bd238d89b0..e08767df66 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -349,13 +349,13 @@ test_expect_success 'Cannot rebase with multiple heads' '
>  
>  test_expect_success 'merge c1 with c2' '
>  	git reset --hard c1 &&
> -	test -f c0.c &&
> -	test -f c1.c &&
> -	test ! -f c2.c &&
> -	test ! -f c3.c &&
> +	test_path_is_file c0.c &&
> +	test_path_is_file c1.c &&
> +	test_path_is_missing c2.c &&
> +	test_path_is_missing c3.c &&
>  	git merge c2 &&
> -	test -f c1.c &&
> -	test -f c2.c
> +	test_path_is_file c1.c &&
> +	test_path_is_file c2.c
>  '
>  
>  test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
> @@ -411,8 +411,8 @@ test_expect_success 'merge c1 with c2 (ours in pull.twohead)' '
>  	git reset --hard c1 &&
>  	git config pull.twohead ours &&
>  	git merge c2 &&
> -	test -f c1.c &&
> -	! test -f c2.c
> +	test_path_is_file c1.c &&
> +	test_path_is_missing c2.c
>  '
>  
>  test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
> @@ -431,10 +431,10 @@ test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octo
>  	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
>  	test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
>  	git diff --exit-code &&
> -	test -f c0.c &&
> -	test -f c1.c &&
> -	test -f c2.c &&
> -	test -f c3.c
> +	test_path_is_file c0.c &&
> +	test_path_is_file c1.c &&
> +	test_path_is_file c2.c &&
> +	test_path_is_file c3.c
>  '
>  
>  conflict_count()

