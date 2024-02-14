Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E713DBBE
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952659; cv=none; b=qB6Qh8yE/cQ1l3SH2zH5NPPX9Q0OjpTq9cyHYsQTeqFfjn8M6w2BZXO6+tjdrT2Mj34Gc2vMMT+s9LGUwYnEjCQMGaAPtmMGiWFAyETGkSB8bBW8WsKucs1PS23f62s7rN/nFgBygJUrf5h93ZLLrgvNNTdSRbwgp64vLFdkFjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952659; c=relaxed/simple;
	bh=Y+K/0HPz949V4g7zmjOEZwrDLViKFqW4U70dIf2A0QU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PMx8L0AQvP2vxnaCU0AjMUPgk9OooUbEDfbSN8HEi+MFKOlnd3w5egZciDvU/mVOclhtvaAbGxgIXtCke48e4F2c5rK6KO1QtSCXOf3qv3fWSda9ffinXMrNsO+X6Tn7kIo77A7CYtrQ45FP82ZWf7+DHWILIq3+eFOBNQQFeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tu5X0Ot/; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tu5X0Ot/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C696216DE;
	Wed, 14 Feb 2024 18:17:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Y+K/0HPz949V4g7zmjOEZwrDLViKFqW4U70dIf
	2A0QU=; b=tu5X0Ot//1ASl0swcnvxhl6f3wE2ezaVijEVT9/u2LvCJQ1UT6tFeM
	uPP8Lke4VkB8VKPpcD5X//KxMNI2MKXtEdX1GWYIHI27qBaOBx5St28SXpiDf32Y
	rohQysgf1r8KpvF1YxcP4VEH8B25ueNRtKQT55QblDpSX+S5gtpWw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 34FC1216DD;
	Wed, 14 Feb 2024 18:17:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D9BFF216DC;
	Wed, 14 Feb 2024 18:17:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] t1405: remove unneeded cleanup step
In-Reply-To: <25cf00c36f715edc6b4e86001a36a093f4c4b2e0.1707463221.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 9 Feb 2024 08:23:26 +0100")
References: <cover.1707463221.git.ps@pks.im>
	<25cf00c36f715edc6b4e86001a36a093f4c4b2e0.1707463221.git.ps@pks.im>
Date: Wed, 14 Feb 2024 15:17:32 -0800
Message-ID: <xmqq4jeatz3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3BCC5F84-CB8F-11EE-8130-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In 5e00514745 (t1405: explictly delete reflogs for reftable, 2022-01-31)
> we have added a test that explicitly deletes the reflog when not using
> the "files" backend. This was required because back then, the "reftable"
> backend didn't yet delete reflogs when deleting their corresponding
> branches, and thus subsequent tests would fail because some unexpected
> reflogs still exist.
>
> The "reftable" backend was eventually changed though so that it behaves
> the same as the "files" backend and deletes reflogs when deleting refs.
> This was done to make the "reftable" backend behave like the "files"
> backend as closely as possible so that it can act as a drop-in
> replacement.
>
> The cleanup-style test is thus not required anymore. Remove it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1405-main-ref-store.sh | 6 ------
>  1 file changed, 6 deletions(-)

Again, makes sense.

This is a tangent, but artificial limitations we imposed on reftable
to be more similar to files backend may be something we would want
to reconsider once reftable hits mainline and people actively start
using it.  Not having to lose the reflog only because you removed a
branch by mistake would be a powerful thing, as it would allow you
to resurrect the branch as well as its log.  Being able to have a
branch 'foo', with work related to 'foo' kept inbranches 'foo/arc1'
'foo/arc2', etc., would be a very nice organizational tool.

But it is a good idea to start limited and later making it looser.
These two limitations are something all users are already familiar
with, so it is not as cripplingly bad as it smells anyway.

Thanks.

>
> diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
> index 976bd71efb..1183232a72 100755
> --- a/t/t1405-main-ref-store.sh
> +++ b/t/t1405-main-ref-store.sh
> @@ -33,12 +33,6 @@ test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
>  	test_must_fail git rev-parse refs/tags/new-tag --
>  '
>  
> -# In reftable, we keep the reflogs around for deleted refs.
> -test_expect_success !REFFILES 'delete-reflog(FOO, refs/tags/new-tag)' '
> -	$RUN delete-reflog FOO &&
> -	$RUN delete-reflog refs/tags/new-tag
> -'
> -
>  test_expect_success 'rename_refs(main, new-main)' '
>  	git rev-parse main >expected &&
>  	$RUN rename-ref refs/heads/main refs/heads/new-main &&
