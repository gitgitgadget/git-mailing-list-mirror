Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907C170A18
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569810; cv=none; b=lzt4kjan8/apm3/BY7WRWlXeEc4IbpA/UsDroEt2iu3RERtgtkOsqtr9JIasWN1TfBKfsArPGu7d6zrn03kFxtvROxxi3BAej+vHsjyruycrKI5Eg5uxfodxpYQQA4/8wpC2dD6IlgSX+1SoWTpO/+OrOuQJdmTPegOx9tQnqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569810; c=relaxed/simple;
	bh=yZ9NWJzzrO/tVkSRDTqKcTbTt7v9VGy69xnxQo6+gc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VwtyZrQ71vef5KdI3o1V/rqUmsiBKzTrEFZQFFOIiht245lfLhA7ELI7mAnXFGXODsSkJxmBRzhHP4UhQCmUGZPd6yMgTzy/S8IiKnXhe0kXuKLlLj+mclMcMnRyzDwn2wIi8h9vK9Knaj3JMbq7naCX3N8XKVh6gR/McYdHKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HxZNKUmZ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HxZNKUmZ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2830736135;
	Tue, 13 Aug 2024 13:23:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yZ9NWJzzrO/tVkSRDTqKcTbTt7v9VGy69xnxQo
	6+gc0=; b=HxZNKUmZqfxw/LftCFHktUXFdW2c3nVuABvxFgDsME7rhBl6fraLV7
	mYUv4H7gtXss4TS0NWxs2CbzFDi4WVHfNbKZO5BJyDsXorplI+aNuDkS+vHtuSLa
	8wGm8eHy+AtAPhrOwaEN1bPHA37wVDz6iOY0fRtB7cnLxzk9cwEa0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 20AB236134;
	Tue, 13 Aug 2024 13:23:28 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6529936133;
	Tue, 13 Aug 2024 13:23:24 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] tests: drop use of 'tee' that hides exit status
In-Reply-To: <f5d0510c-d455-5e80-08b7-e08c81df4adb@gmx.de> (Johannes
	Schindelin's message of "Tue, 13 Aug 2024 14:22:11 +0200 (CEST)")
References: <xmqq4j7uhfvm.fsf@gitster.g>
	<f5d0510c-d455-5e80-08b7-e08c81df4adb@gmx.de>
Date: Tue, 13 Aug 2024 10:23:22 -0700
Message-ID: <xmqqcymc5oc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BEE42DB0-5998-11EF-A3A3-BF444491E1BC-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 8 Aug 2024, Junio C Hamano wrote:
>
>> diff --git c/t/t1001-read-tree-m-2way.sh w/t/t1001-read-tree-m-2way.sh
>> index 88c524f655..48a1550371 100755
>> --- c/t/t1001-read-tree-m-2way.sh
>> +++ w/t/t1001-read-tree-m-2way.sh
>> @@ -397,7 +397,7 @@ test_expect_success 'a/b vs a, plus c/d case setup.' '
>>
>>  test_expect_success 'a/b vs a, plus c/d case test.' '
>>  	read_tree_u_must_succeed -u -m "$treeH" "$treeM" &&
>> -	git ls-files --stage | tee >treeMcheck.out &&
>> +	git ls-files --stage >treeMcheck.out &&
>
> While this obviously fixes the bug where the test case was incorrectly
> allowed to continue after a failing `git ls-files --stage` call, I will
> note that I interpret the intention of the `| tee` as showing the output
> in the logs in addition to redirecting it to a file for the benefit of
> additional checks in the same test case.

If we really want to do that, we'd do

    git ls-files --stage >treeMcheck.out &&
    cat treeMcheck.out &&

instead.  You wouldn't lose the exit status, and the output would
show the contents just like "tee" would.

We however tend to also remove a leftover debugging "cat", so the
"cat" is likely to be removed during such a clean-up.

> So, what to do here? I don't really know. The easiest option that most
> other people would likely be happy with would be to go with the `| tee`
> dropping.

As long as we treat the CI as a "batch" environment, the postmortem
tarball of the trash directory is probably the best we can do I can
think of.
