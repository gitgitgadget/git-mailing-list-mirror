Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8E1F602
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063504; cv=none; b=kcMfu1p3MKoePeI9npsgQ7hiNu1QiRARb4V+Dh9JAVMQ7lJbXfJsQaZiSDJtqTnWUAXNc53l3kuTGZkxo0L3xEParuxX9TfWIgyij7uwYFYuDsmusFjRP5t4CkwDIMzDGFh3XJjD5r1N/A0THGyBdCpJwQZLtoASqo16LnWRGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063504; c=relaxed/simple;
	bh=0TXmpcB4oEJH+urVhhlvIgxhXQzF4GM+lijwol2DUUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rk/s4mB0hVn1vK7H/joxmQBaeyrLXwiDGkV3GFj/aMFzsjt3LwZTV8rOhFF5gqT0CRAh3l0QjAmq8AiYCbufNNyyaSOIlmcJW5kIu6wVRQIUOCgYdi5cSXus/xOILlQUm/cije79jS3EOE5pXSOq824etaSQxHmn4sT4S1xApVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TOreHQ2d; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TOreHQ2d"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ED3AD31F50;
	Tue,  7 May 2024 02:31:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0TXmpcB4oEJH+urVhhlvIgxhXQzF4GM+lijwol
	2DUUE=; b=TOreHQ2dSthJKUsqdLh077+//HBezZuYxlenekOpNWESnmJ7DgP3ad
	VUNOqSEUNIkonA6l8Rb5DeVqtsva0eAOAZegmKggmCFotlBhIcO2yyGLMAvCW21f
	Gx+IHHLoqIIxOcmTAVL/UBLlDzq/iaLV0Q+gM1Sn3+Ep6sA280r7A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E5A4931F4F;
	Tue,  7 May 2024 02:31:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72AA531F4E;
	Tue,  7 May 2024 02:31:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v7 0/8] refs: add support for transactional symref updates
In-Reply-To: <xmqq5xvqt9ym.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 May 2024 23:25:21 -0700")
References: <20240503124115.252413-1-knayak@gitlab.com>
	<20240507060035.28602-1-knayak@gitlab.com>
	<xmqq5xvqt9ym.fsf@gitster.g>
Date: Mon, 06 May 2024 23:31:37 -0700
Message-ID: <xmqq1q6et9o6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 760BAA32-0C3B-11EF-9523-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio, I've rebased my patches on top of, not sure if there is something else I
>> missed here:
>> - ps/ci-python-2-deprecation (2a686e00d2)
>> - ps/reftable-write-options (f5545b173b)
>> - ps/pseudo-ref-terminology (ad302a68fd)
>
> This is a somewhat puzzling set of topics.  You are not touching
> ci/lib.sh at all so I do not see the point of including the
> ci-python one, for example.

Oh, it is even worse.  2a686e00d2 is not the ci-python thing at all.
It is a random point between 'master' and 'seen' that happens to be
a merge of that topic, so you basically based your series on top of
random collection of many topics that are not even in 'next'.  More
than 30 of them.

2a686e00d2 Merge branch 'ps/ci-python-2-deprecation' into seen
cfae85760b Merge branch 'ow/refspec-glossary-update' into seen
0ac6476973 Merge branch 'ps/ci-enable-minimal-fuzzers-at-gitlab' into seen
2e6fe8d39b Merge branch 'jp/tag-trailer' into seen
2954339080 Merge branch 'rs/external-diff-with-exit-code' into seen
b16fe0b6f5 Merge branch 'it/refs-name-conflict' into seen
bdec3a9a17 Merge branch 'ps/refs-without-the-repository' into seen
b30d6b985f Merge branch 'kn/ref-transaction-symref' into seen
33c1562652 Merge branch 'ds/doc-config-reflow' into seen
053736edd8 Merge branch 'ie/config-includeif-hostname' into seen
db453e610c Merge branch 'cw/git-std-lib' into seen
6858402556 Merge branch 'bk/complete-dirname-for-am-and-format-patch' into seen
2ec214595a Merge branch 'bk/complete-send-email' into seen
0810be3417 Merge branch 'jc/rerere-cleanup' into seen
a3d2847041 Merge branch 'ds/send-email-per-message-block' into seen
919b280123 Merge branch 'tb/attr-limits' into jch
27f675fb6d Merge branch 'ps/config-subcommands' into jch
f5545b173b Merge branch 'ps/reftable-write-options' into jch
c86de5db47 Merge branch 'ew/khash-to-khashl' into jch
ef2bdd9348 Merge branch 'jc/test-workaround-broken-mv' into jch
fb794ba19c Merge branch 'jc/rev-parse-fatal-doc' into jch
96aa517d85 Merge branch 'jt/port-ci-whitespace-check-to-gitlab' into jch
941a03e7c9 Merge branch 'jl/git-no-advice' into jch
56c4ee21a1 Merge branch 'ma/win32-unix-domain-socket' into jch
9d2ea80011 Merge branch 'tb/pseudo-merge-reachability-bitmap' into jch
ad302a68fd Merge branch 'ps/pseudo-ref-terminology' into jch
2754234e89 Merge branch 'ds/scalar-reconfigure-all-fix' into jch
c0340717db Merge branch 'pw/rebase-i-error-message' into jch
89b67e5799 Merge branch 'tb/path-filter-fix' into jch
f40942e3c0 Merge branch 'la/hide-trailer-info' into jch
7b725fb75c Merge branch 'js/cmake-with-test-tool' into jch
1ddb41fd10 Merge branch 'js/unit-test-suite-runner' into jch
e95b4f5420 Merge branch 'jc/no-default-attr-tree-in-bare' into jch
ed26589653 ### match next

I'll not look at this round, as I know you know better than building
a series deliberately on top of these random topics and this was an
accidental mistake you'd rather want to correct before asking folks
to take a look at the resulting series.

Thanks.
