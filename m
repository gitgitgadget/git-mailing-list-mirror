Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE9145A1F
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732284; cv=none; b=J2CgXtE/71da103Hb7cythmJDRkcFcggup59d74xdPV0F2mRuFmEO/9sBw3attkvR5S66hQyVPO/oLXVZo0aDcL4YatDpvirH8TGIB9tdSbo/Ez4E6b2MKkBoYJGiXrTs19tf6tAKHrWcfUO9znZn9DQAUBuJ9rlFfFJBSpuUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732284; c=relaxed/simple;
	bh=Aj8uPbu/HS+ChYlkgV8tU2aPylef3CeNZVzHPw3XZpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OJuIrv3Ai3WBatCBRoCUZNhoTchwvLaCD1Z7ciumE2PVmxNOsJYmrGmXCTCi8kdTxfznnJ4LBJGaE/jGHDxKuTMDbFaibz80qSDKf2j+dqde3UPqw/k2puqYaeJ/m/N0DYH88TfhgJaV/Evq4loqt2gZKWBK8bjwJkSuiL842GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ob/dbQ9S; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ob/dbQ9S"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2F1A2B6E5;
	Tue, 18 Jun 2024 13:38:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Aj8uPbu/HS+ChYlkgV8tU2aPylef3CeNZVzHPw
	3XZpY=; b=ob/dbQ9Si7ytIcIoU7lWO/f0qfcjw/TOZ9qAx15PhDQ02dEqum+k02
	+tNdxSrroZ44Rq6wnhw11ycZYITsO1mtx7DedcZYtZQpmNjG6dMh5skKQZC5XNLU
	gtlrIb69DhMeTZDXenV0JJAFF1vW80PByfXbYmedyZIAuSTkMBvsk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B6A902B6E4;
	Tue, 18 Jun 2024 13:38:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECC522B6E3;
	Tue, 18 Jun 2024 13:37:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  blanet <bupt_xingxin@163.com>,  Xing Xin
 <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v7 1/3] bundle-uri: verify oid before writing refs
In-Reply-To: <fc9f44fda0032ab1e5ee0c9bcc2886ddb8e17722.1718632536.git.gitgitgadget@gmail.com>
	(Xing Xin via GitGitGadget's message of "Mon, 17 Jun 2024 13:55:33
	+0000")
References: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
	<pull.1730.v7.git.1718632535.gitgitgadget@gmail.com>
	<fc9f44fda0032ab1e5ee0c9bcc2886ddb8e17722.1718632536.git.gitgitgadget@gmail.com>
Date: Tue, 18 Jun 2024 10:37:58 -0700
Message-ID: <xmqqr0cuyww9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 81A197CE-2D99-11EF-81B5-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Xing Xin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -33,6 +46,16 @@ test_expect_success 'clone with path bundle' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'clone with bundle that has bad header' '
> +	# Write bundle ref fails, but clone can still proceed.
> +	git clone --bundle-uri="clone-from/bad-header.bundle" \
> +		clone-from clone-bad-header 2>err &&
> +	commit_b=$(git -C clone-from rev-parse B) &&
> +	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
> +	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
> +	! grep "refs/bundles/" refs

Why not "test_grep !" here?  There are other uses of bare grep in
the newly added lines, but I won't repeat them here; the same
comment applies to them.

> +	test_write_lines refs/bundles/topic >expect &&
> +	test_cmp expect actual &&
> +	# Ensure that refs/bundles/topic are sent as "have".
> +	test_grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
> +'

Can this rev-parse fail (the failure would be hidden from the test)?
If so,

	...
	test_cmp expect actual &&
	# Ensure that refs/bundles/topic is sent as "have"
	tip=$(git -C clone-from rev-parse A) &&
	test_grep "clone> have $tip" trace-packet.txt

would catch such a failure.  You are doing so in the previous test
in the hunk starting at 33/46 above with commit_b variable already.

There are other uses of git command in $(command substitution) whose
exit status are ignored in the newly added lines, but I won't
repeat them here; the same comment applies to them.

Thanks.
