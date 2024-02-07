Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83A15442F
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341094; cv=none; b=NdH1F1l0vtziXwtIkxuCQ15oeVa632NX2pB3RhtRYkThw/WoA1sY0YJJN+OBXe0FcWxCz955lQuhyflm2QH9QjeCUbq65yNfgh7NbTlpkakIsF2bagksV+2Eu2EWWzg2R0sKn9hjiZjS0kAgc/8nF8CAsiT3X460Xj3qCjv8L64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341094; c=relaxed/simple;
	bh=9ZmKkp79agdP89MB5YY/UsJsBNij1oahEJAPLZRhk78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPsOW91ohJxEIrf4MgEiIefSJN6MHOulLNv8zDOimhosqMm5Q4++hP9/vkUNoHzj3H9PGC5dApi/Mo0yfGLv6wf6SdRasINGOVomhWEJqQ9IRUbnT13jeWT+4Nu37CJoDrDq5ftdjgalCF0/WyVpf4ZcrDClgxXkhpIYAeINBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x45g6Mqi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x45g6Mqi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFF141DFEEE;
	Wed,  7 Feb 2024 16:24:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9ZmKkp79agdP89MB5YY/UsJsBNij1oahEJAPLZ
	Rhk78=; b=x45g6MqilucT4zY6ey40CInUiQtqYo45PbIE3xZSshlzBWhjuAlraH
	8RtUSoYj/72mjKeJjZnfPlKdyY7qkf/G1sPDrxmAnqBQCWtiCsG9z/JkdXZ6j2UM
	yRvIP4fJIzfdO7Lg2zTklEj3mzj09l/XcMxUYkAi/86o8XpVvJZa4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C774F1DFEED;
	Wed,  7 Feb 2024 16:24:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A0871DFEEC;
	Wed,  7 Feb 2024 16:24:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/5] t4301: verify that merge-tree fails on missing
 blob objects
In-Reply-To: <CAPig+cSJz3U+vT==NhX5hcrTjsCggnAzhzQOvZcSXbcEGuYaKQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 7 Feb 2024 12:24:59 -0500")
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
	<pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<be1dadf28502fe3e9662fa61523e8c57ce3352f1.1707324462.git.gitgitgadget@gmail.com>
	<CAPig+cSJz3U+vT==NhX5hcrTjsCggnAzhzQOvZcSXbcEGuYaKQ@mail.gmail.com>
Date: Wed, 07 Feb 2024 13:24:49 -0800
Message-ID: <xmqqr0ho55ni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5374B4BE-C5FF-11EE-B0F6-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
>> @@ -961,4 +961,18 @@ test_expect_success 'error out on missing tree objects' '
>> +test_expect_success 'error out on missing blob objects' '
>> +       seq1=$(test_seq 1 10 | git hash-object -w --stdin) &&
>> +       seq2=$(test_seq 1 11 | git hash-object -w --stdin) &&
>> +       seq3=$(test_seq 0 10 | git hash-object -w --stdin) &&
>
> Is there significance to the ranges passed to test_seq()? Or, can the
> same be achieved by using arbitrary content for each blob?
>
>     blob1=$(echo "one" | git hash-object -w --stdin) &&
>     blob2=$(echo "two" | git hash-object -w --stdin) &&
>     blob3=$(echo "three" | git hash-object -w --stdin) &&
>
>> +       tree1=$(printf "100644 blob %s\tsequence" $seq1 | git mktree) &&
>> +       tree2=$(printf "100644 blob %s\tsequence" $seq2 | git mktree) &&
>> +       tree3=$(printf "100644 blob %s\tsequence" $seq3 | git mktree) &&
>
> I found the lack of terminating "\n" in the `printf` confusing,
> especially since the variable names (seq1, seq2, etc.) and the use of
> `printf` seem to imply, at first glance, that each git-mktree
> invocation is receiving multiple lines as input which, it turns out,
> is not the case. Adding the missing "\n" would help:
>
>    tree1=$(printf "100644 blob %s\tsequence\n" $seq1 | git mktree) &&
>    tree2=$(printf "100644 blob %s\tsequence\n" $seq2 | git mktree) &&
>    tree3=$(printf "100644 blob %s\tsequence\n" $seq3 | git mktree) &&
>
> Interpolating the $seqN variable directly into the string rather than
> using %s would make it even clearer that only a single line is being
> generated as input to git-mktree:
>
>    tree1=$(printf "100644 blob $seq1\tsequence\n" | git mktree) &&
>    tree2=$(printf "100644 blob $seq2\tsequence\n" | git mktree) &&
>    tree3=$(printf "100644 blob $seq3\tsequence\n" | git mktree) &&

All good points.  Thanks for excellent reviews (not just this one
but another one in the series).
