Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BF548E1
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708626191; cv=none; b=YX/9TAkUYgAHWp2adVgX98BL3iYHfMj9BTNIQXwnA8LjhV0xfJZNh/lBS6E9cgSsld9T4yDDy2qCMbJbGbogEnt3AvKW+9VblnxTmUkbZeIDHcvrkVmEG9dMvFsvLQlmDllKDncuKu2mMDErzZFkYJnFq7x1z8/BL+gWf2RBVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708626191; c=relaxed/simple;
	bh=FhChwMoDSguVUpTEWk7hJVaZa9XQ9wIa+xcD7WhvHrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P68joPagcqcPCPRJMT5C6RTv0fvOG3sNELqZnnSwuJh6LXX5Vb5NSoMb23wPCnVSKFt3cb8kp/T9twS6scE82UURonRGtxHWM7NFw/0qvFgi4ru0aR7ZbZuwwW3Y8wcJ925xmlJ31bwNOC2XMr0KtMAnnFilaljAkna2bs44oYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uZmtgcsB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uZmtgcsB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 146051D680E;
	Thu, 22 Feb 2024 13:23:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FhChwMoDSguVUpTEWk7hJVaZa9XQ9wIa+xcD7W
	hvHrI=; b=uZmtgcsByvJQZjAwmA5Fy4VZW2SOmSnQeG5FGPfdGfXo+AmhgFA7/U
	UEY3vt7aGDLgp6UbIVwM0ddm8i0dkwdy25HcGdrbbJn4EJkU6Ty00QaXKczzTwQI
	zqjhn5h6/1tsNlMMu8HmkrV8rZHngRG2P2nB6CKPcELciqHRJQa4g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3B971D680D;
	Thu, 22 Feb 2024 13:23:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD7911D680A;
	Thu, 22 Feb 2024 13:23:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/5] t4301: verify that merge-tree fails on missing
 blob objects
In-Reply-To: <xmqqttm0fly9.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	22 Feb 2024 09:27:58 -0800")
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<e82fdf7fbcbf12fffdf4a720927c2f4f006068f8.1708612605.git.gitgitgadget@gmail.com>
	<xmqqttm0fly9.fsf@gitster.g>
Date: Thu, 22 Feb 2024 10:23:05 -0800
Message-ID: <xmqqcysoe4ty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6CC2BA7C-D1AF-11EE-AD5D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'error out on missing blob objects' '
>> +	echo 1 | git hash-object -w --stdin >blob1 &&
>> +	echo 2 | git hash-object -w --stdin >blob2 &&
>> +	echo 3 | git hash-object -w --stdin >blob3 &&
>> +	printf "100644 blob $(cat blob1)\tblob\n" | git mktree >tree1 &&
>> +	printf "100644 blob $(cat blob2)\tblob\n" | git mktree >tree2 &&
>> +	printf "100644 blob $(cat blob3)\tblob\n" | git mktree >tree3 &&
>> +	git init --bare missing-blob.git &&
>> +	cat blob1 blob3 tree1 tree2 tree3 |
>> +	git pack-objects missing-blob.git/objects/pack/side1-whatever-is-missing &&
>> +	test_must_fail git --git-dir=missing-blob.git >actual 2>err \
>> +		merge-tree --merge-base=$(cat tree1) $(cat tree2) $(cat tree3) &&
>> +	test_grep "unable to read blob object $(cat blob2)" err &&
>> +	test_must_be_empty actual
>> +'
>
> It would have been even easier to see that blob2 is what we expect
> to be complained about, if you listed all objects and filtered blob2
> out, but the number of objects involved here is so small, a "cat" of
> all objects we want to keep is OK here.

Just FYI for anybody reading from the sideline.

	git cat-file --unordered \
		--batch-check="%(objectname)" --batch-all-objects |
	grep -v $(cat blob2) |
	git pack-objects ...

would be a compact way to say "Give me a pack that lets me easily
simulate what happens in a repository identical to the current one,
if it lacked object "blob2", without having to enumerate what object
we want to include in the test repository.

Again, I think in this particular case, it is easy enough to see in
the "blob1 blob3 tree1 tree2 tree3" enumeration what is missing, so
the way the patch is written is fine.

Thanks.
