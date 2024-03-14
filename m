Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432628F6C
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710382743; cv=none; b=s0rISHCpkAl1Pqp/Tx1ml0pURg/uZvLvaYIi+1TCBpI5VtjfQcuMaYIYngOp5FRk206MgkXaNwNr9e0rG+wVrbgJOgfvkmB7hDiInFRyckryJhipKDIALy45Ijsm2QVA8TwgbVV2Q0CNKNXGxyMFI/2xnGd6v/+gJZWLglNWuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710382743; c=relaxed/simple;
	bh=g+y45QfYGnujFppiD5rq3tqt3QAXEW9a4ZPTuM/TxNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SidVk2T0mDvUoCsI5zwK6XGOfG2HF8srbcGz9cFLo/3N0PoK1KYYqE0TXy0mK7hAOgkvdYD4UWFjU3Az/Km7FpvinCOUzUQV/1YSQj776Q6oy32RC2gwTAAx1PWFFNwPlm6tahUj33aBPGqoujpBSXHqn7R8ciK2dO3se71+e0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t6tf+w0i; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t6tf+w0i"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18EB61E178A;
	Wed, 13 Mar 2024 22:19:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g+y45QfYGnujFppiD5rq3tqt3QAXEW9a4ZPTuM
	/TxNk=; b=t6tf+w0i1GL5OkFXZRiIS1tvOrjqcnPVF5jXVV5rrG0+ZfiTIv4/Nr
	f8vjvFF5+tcP9846RtNRDRHfbYOo6ycf2DHSTjndfSf81qhYi94RIcMG3NELnaTk
	Syov0adpyTjU/NqVuR79OaBcu8GQQ9WjR55iNUuMH4GqIVezP5N5E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1077D1E1788;
	Wed, 13 Mar 2024 22:19:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44AB51E1786;
	Wed, 13 Mar 2024 22:18:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH 3/3] t1300: add tests for internal whitespace and inline
 comments
In-Reply-To: <292ab942c38de44476c6c5bf045c375bf4f6a70d.1710258538.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Tue, 12 Mar 2024 16:55:46 +0100")
References: <cover.1710258538.git.dsimic@manjaro.org>
	<292ab942c38de44476c6c5bf045c375bf4f6a70d.1710258538.git.dsimic@manjaro.org>
Date: Wed, 13 Mar 2024 19:18:58 -0700
Message-ID: <xmqq8r2l1rot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 379077D6-E1A9-11EE-8A15-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Add a couple of additional automated tests, to improve the coverage of
> configuration file entries whose values contain internal whitespace, or have
> an additional inline comment.

While this may document the current behaviour, I am not sure of the
value of carving the current behaviour in stone, especially after
checking if the current behaviour is a bug.

> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  t/t1300-config.sh | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 31c387868708..589af5e81d61 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -11,6 +11,26 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  TEST_PASSES_SANITIZE_LEAK=true
>  . ./test-lib.sh
>  
> +cat > .git/config << EOF
> +[section]
> +	sparse = big 		 blue
> +	annotated = big blue	# to be discarded
> +EOF
> +
> +echo 'big    blue' > expect
> +
> +test_expect_success 'internal whitespace' '
> +	git config --get section.sparse > output &&
> +	test_cmp expect output
> +'
> +
> +echo 'big blue' > expect
> +
> +test_expect_success 'inline comment' '
> +	git config --get section.annotated > output &&
> +	test_cmp expect output
> +'
> +
>  test_expect_success 'clear default config' '
>  	rm -f .git/config
>  '
