Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D15B1E0
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593120; cv=none; b=AG2DaG/1JzMvpL9rfRb5nylTAgtkORGritQOv2XtFTL1996sq9DYF0VOASQvA1HRZrzXurEoA7BR9K9VIT5gj8c3Uh8LddpNrfB1QqaLy2jwl6sb0yc1N2IUzLFEg1kdj0Ub4NY/+vUjKpYuCuF/33bFYrAOT498CGGmNbSq1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593120; c=relaxed/simple;
	bh=4F2g2W7AcBoE1ACXHbsFXfb/qmTvCM/wWToclh1Equk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4DCAsZxjJwkgkawyDTBy+5tklAo8VGnFM01xGcQdIOkpoXal20T2zNDzlHdkmRr9eqNWgYvLrLnS1TpVZee6cAJqgZsR8GEYWfasTbAodKurTxyGq0faX6Mdnw2JkSAnxob7lJWiOei1IVf/NizHJNa/CfL+Agg1kbDy91T9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nkEP6Fqm; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nkEP6Fqm"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 60AEE1DB06;
	Mon,  8 Apr 2024 12:18:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4F2g2W7AcBoE1ACXHbsFXfb/qmTvCM/wWToclh
	1Equk=; b=nkEP6FqmzRVq56t9rK2UQH8QWllqTz3r3zLXZ1xa1zp3tg/oTyq0W6
	B9RxXgj5kO/1GKWAdIhVlkgkqjNgo5L5mSEOblzStRZ+Puf5/Bd+89KODYc2o16J
	+4JBBBqPX1vxkoKIjqIBPtFclkr0/HTWiKCaZRr1aADNq0gTDrxeQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 58BE81DB05;
	Mon,  8 Apr 2024 12:18:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CDD6F1DB04;
	Mon,  8 Apr 2024 12:18:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Han-Wen
 Nienhuys <hanwenn@gmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v5 2/3] reftable/stack: add env to disable autocompaction
In-Reply-To: <ZhOK262a5WCxS9MN@tanuki> (Patrick Steinhardt's message of "Mon,
	8 Apr 2024 08:12:43 +0200")
References: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
	<pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
	<7c4fe0e9ec597203ee37d2c2503be319e87ff5ee.1712255369.git.gitgitgadget@gmail.com>
	<ZhOK262a5WCxS9MN@tanuki>
Date: Mon, 08 Apr 2024 09:18:28 -0700
Message-ID: <xmqqjzl7eskr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A3159BCA-F5C3-11EE-B3DB-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> @@ -248,6 +249,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
>>  	refs->write_options.hash_id = repo->hash_algo->format_id;
>>  	refs->write_options.default_permissions = calc_shared_perm(0666 & ~mask);
>>  
>> +	if (!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
>> +		refs->write_options.disable_auto_compact = 1;
>> +
>
> This could be simplified to:
>
>     ```
>     refs->write_options.disable_auto_compact =
>             !git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
>     ```

I presume that the .disable_auto_compact member is off initially,
given that this is inside reftable_be_init(), but your rewrite makes
it easier on readers, as they do not have to know what value the
member originally has at this point in the flow.  So even though it
replaces two lines of code with another two lines of code, it does
count as a valuable simplification at the conceptual level.

Thanks.

