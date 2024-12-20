Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB66D1A3BD7
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734729733; cv=none; b=A+IoaPvJWysNm9d+Nyl1GKlfX2A3b+Vvwc3Z67g8j+TFqWZltoaBww2JBe7qwlnjXBLqpbwTAGgQdjq21aQDFLCm0DpR8f0YKzcWiRSAsHXtJdwKaNjX8Eu4T5V9vs8GWN/Krhj0oEBXCTtQatSLmne3XcYeCI2TuUCNcpNFK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734729733; c=relaxed/simple;
	bh=XZ+9O87Gr6p4BivBiZa9GKPOCPBQ+KZ/FvgwjZ2U3mY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3kFlndvH5fNOk7nBd6jk/141gQZDXgztq7dgM4C7t1qUNK7BJQEZ7mrM7garvWcjTTHRIXac0QTx2mZadtuXvkbTtZDLIMpPNZ4zdWS10grS2sbMJtcc5aDk5UX9iMV2xT0QbAvWG9ErO4JYIGzYPNnv7k9kQQ1Mj4pZAKmOqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BKLLwen2530830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 21:21:59 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqfrmn4hr9.fsf@gitster.g> <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com> <Z2EC9rq3F0rTljff@pks.im> <010a01db508a$4544d750$cfce85f0$@nexbridge.com> <015901db50b5$e3a7f6e0$aaf7e4a0$@nexbridge.com> <Z2JyFB3CddYM_LP4@pks.im> <00ca01db5257$12708d00$3751a700$@nexbridge.com> <Z2UX2v8sc-DELaVm@pks.im> <015501db5314$b61ac2a0$225047e0$@nexbridge.com> <Z2XHfzLEBUfqygBq@pks.im>
In-Reply-To: <Z2XHfzLEBUfqygBq@pks.im>
Subject: RE: [ANNOUNCE] Git v2.48.0-rc0
Date: Fri, 20 Dec 2024 16:21:53 -0500
Organization: Nexbridge Inc.
Message-ID: <016b01db5325$34c0fd80$9e42f880$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFEfEaRNrZ6uu0wI6oVXmgPkoCy2gI/zh74AaCMqnQBl78GqAGqkn5VArNI4yoCossCbgJ/RS7RAc1uYKMCYDUlXLOEH57w
Content-Language: en-ca

On December 20, 2024 2:38 PM, Patrick Steinhardt wrote:
>On Fri, Dec 20, 2024 at 02:23:49PM -0500, rsbecker@nexbridge.com wrote:
>> On December 20, 2024 2:08 AM, Patrick Steinhardt wrote:
>> >On Thu, Dec 19, 2024 at 03:46:20PM -0500, rsbecker@nexbridge.com wrote:
>> >> On December 18, 2024 11:07 AM, I wrote:
>> >> >All tests, actually.
>> >> >
>> >> >$ GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true sh
>> >> >t0000- basic.sh --verbose -i -x
>> >> >error: reftable: transaction prepare: out of memory
>> >> >error: cannot run git init
>> >>
>> >> Any updates or hypothesis on this? Our test system has loads of
>> >> memory
>> >> - I cannot figure out where the allocation failure takes place.
>> >> There is a limit to how much memory can be allocated, but it is
>> >> very high and our virtual memory is extensive, but this is a 32-bit
build.
>> >
>> >My hypothesis is that this is caused by ps/reftable-alloc-failures,
>> >but I
>> am unable to
>> >tell where exactly the error comes from. So I'm dependent on your input.
>> >
>> >Could you please bisect the error? Finding out where the error is
>> >raised
>> would also
>> >be quite helpful. It has to be one of the reftable functions that
>> >returns REFTABLE_OUT_OF_MEMORY_ERROR, but other than that I do not
>> >have any more gut feeling right now.
>>
>> This is what bisect shows:
>>
>> git bisect start
>> # status: waiting for both good and bad commits # good:
>> [777489f9e09c8d0dd6b12f9d90de6376330577a2] Git 2.47 git bisect good
>> 777489f9e09c8d0dd6b12f9d90de6376330577a2
>> # status: waiting for bad commit, 1 good commit known # bad:
>> [063bcebf0c917140ca0e705cbe0fdea127e90086] Git 2.48-rc0
>>
>> git bisect bad 063bcebf0c917140ca0e705cbe0fdea127e90086
>> # bad: [2037ca85ad93ec905b46543df6df4080f6ca258b] worktree: refactor
>> `repair_worktree_after_gitdir_move()`
>> git bisect bad 2037ca85ad93ec905b46543df6df4080f6ca258b
>> # bad: [6a11438f43469f3815f2f0fc997bd45792ff04c0] The fifth batch git
>> bisect bad 6a11438f43469f3815f2f0fc997bd45792ff04c0
>> # bad: [f004467b042d735a2fe8bd5706b053b04b1aec65] Merge branch
>> 'jh/config-unset-doc-fix'
>> git bisect bad f004467b042d735a2fe8bd5706b053b04b1aec65
>> # bad: [e29296745dc92fb03f8f60111b458adc69ff84c5] Merge branch
>> 'sk/doc-maintenance-schedule'
>> git bisect bad e29296745dc92fb03f8f60111b458adc69ff84c5
>> # bad: [5b67cc6477ce88c499caab5ebcebd492ec78932d] reftable/stack:
>> handle allocation failures in auto compaction git bisect bad
>> 5b67cc6477ce88c499caab5ebcebd492ec78932d
>> # good: [31f5b972e0231d4211987775dd58e67815734989] reftable/record:
>> handle allocation failures when decoding records git bisect good
>> 31f5b972e0231d4211987775dd58e67815734989
>> # bad: [18da60029319733e2d931f2758a8e47b8b25b117] reftable/reader:
>> handle allocation failures for unindexed reader git bisect bad
>> 18da60029319733e2d931f2758a8e47b8b25b117
>> # good: [74d1c18757d1a45b95e46836adf478193a34c42c] reftable/writer:
>> handle allocation failures in `reftable_new_writer()` git bisect good
>> 74d1c18757d1a45b95e46836adf478193a34c42c
>
>This is missing the last step for git-bisect(1). Right now it could be
caused by one of
>these commits:
>
>    18da600293 (reftable/reader: handle allocation failures for unindexed
reader,
>2024-10-02)
>    802c0646ac (reftable/merged: handle allocation failures in
>`merged_table_init_iter()`, 2024-10-02)

They are there, it is just that Outlook wrapped the lines on me.  The
802c064 is not in my repo - I bisected from 2.47.0 to 2.48.0-rc0, so may
have skipped a more recent commit than rc0 has.

>The first commit seems quite unlikely to be the root cause. The second
commit is
>rather interesting though. I wonder whether NonStop's malloc returns a NULL
>pointer when given a size of 0?
>
>A quick stab into the dark, but does below patch on top of `master` make
things
>work for you?
>
>Patrick
>
>-- >8 --
>
>diff --git a/reftable/merged.c b/reftable/merged.c index
bb0836e344..7ae6f78d45
>100644
>--- a/reftable/merged.c
>+++ b/reftable/merged.c
>@@ -244,7 +244,7 @@ int merged_table_init_iter(struct reftable_merged_table
>*mt,
> 	struct merged_iter *mi = NULL;
> 	int ret;
>
>-	REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len);
>+	REFTABLE_CALLOC_ARRAY(subiters, mt->readers_len + 1);
> 	if (!subiters) {
> 		ret = REFTABLE_OUT_OF_MEMORY_ERROR;
> 		goto out;
>diff --git a/reftable/stack.c b/reftable/stack.c index
59fd695a12..1b6b8cc9ea
>100644
>--- a/reftable/stack.c
>+++ b/reftable/stack.c
>@@ -1612,7 +1612,7 @@ static uint64_t
>*stack_table_sizes_for_compaction(struct reftable_stack *st)
> 	int overhead = header_size(version) - 1;
> 	uint64_t *sizes;
>
>-	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len);
>+	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len + 1);
> 	if (!sizes)
> 		return NULL;
>

The fix above does not appear to make any difference.

