Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEAAC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9FD613AA
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhEDRZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:25:25 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:37366 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhEDRZX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:25:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id A129C40F51;
        Tue,  4 May 2021 19:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1620149066; x=1621963467; bh=IUuebSuV40ib48xQ3G7
        osqPKcmYseGmCeo5D+7Vqx1Q=; b=LZ5lokFxruVQsftcFvBRxD9aKinIB9D7JOk
        IT9pj1Q13HMGWzYQqStAOfSYGuBclwGXSEZ3tarXjyNVQrqz4tljC8mfh1Nmdh0/
        eGzqAIf3dvz4DW5XKtkHTdL++qlKKc+Bxv1vRfOPLd+l77BMdIifz/w7LubwHQjd
        gurbgRDUv43VoteZ+PgUhRklZyZlO7RlNg65iKwpMe8Imeb5WKiZo1LjVosiSrOB
        DZvCc2io9wf1sd6eXMHhvze9d0INg/7OZ7vYlamTtr8iGGrC4G8K8AGte0icxSsG
        ZSZSFaf5vzFzjnenzfsfk9aml/zaB19ToEP9AfkRZ7nfpz8VTrwLgs1Ciz4mL7Ah
        C1GDXaFdGCa34cJaVgQm7tyRa8iE+Fp/neRVQEVtasN/kwzOxkustWzlI2pwJwOz
        X3Llnxn6nDQxt0lZ5TG4+CZH0SS+giQybEHLMQK2nY1O4euNcGnrjY3s46mvd/9W
        3YlXaIadGhwGbK52/C2/P4dWoG+ZByGE/Hk8kqSMuSsfm2NILt7sj8QQCahbWukP
        O97q0lo1hoRBirP5Bp6L+HufkiK3HsvI466/hJfZ8oxgAlwC/20UnG6X5BlClPfk
        N9b3+YUTncUaSvB9Qcz4OhKyBYCTIzFx7v8TJJuIvG3Yhn9sGVE08aATNpXy43dj
        MKPutGEI=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6nY-2BOFgv3X; Tue,  4 May 2021 19:24:26 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id C166540BE3;
        Tue,  4 May 2021 19:24:26 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id EFCC4394;
        Tue,  4 May 2021 19:24:21 +0200 (CEST)
Subject: Re: [PATCH v7 23/28] Reftable support for git-core
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
 <2fd7cb8c0983501e2af2f195aec81d7c17fb80e1.1618832277.git.gitgitgadget@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <f5711aa9-e70f-8bb1-09d9-4f283b010d46@ahunt.org>
Date:   Tue, 4 May 2021 19:24:20 +0200
MIME-Version: 1.0
In-Reply-To: <2fd7cb8c0983501e2af2f195aec81d7c17fb80e1.1618832277.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/04/2021 13:37, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
[...snip...]> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> new file mode 100644
> index 000000000000..55d053e5ca65
> --- /dev/null
> +++ b/refs/reftable-backend.c
[...snip...]
> +static int write_transaction_table(struct reftable_writer *writer, void *arg)
> +{
> +	struct ref_transaction *transaction = (struct ref_transaction *)arg;
> +	struct git_reftable_ref_store *refs =
> +		(struct git_reftable_ref_store *)transaction->ref_store;
> +	struct reftable_stack *stack =
> +		stack_for(refs, transaction->updates[0]->refname);
> +	uint64_t ts = reftable_stack_next_update_index(stack);
> +	int err = 0;
> +	int i = 0;
> +	struct reftable_log_record *logs =
> +		calloc(transaction->nr, sizeof(*logs));
> +	struct ref_update **sorted =
> +		malloc(transaction->nr * sizeof(struct ref_update *));
> +	struct reftable_merged_table *mt = reftable_stack_merged_table(stack);
> +	struct reftable_table tab = {NULL};
> +	struct reftable_ref_record ref = {NULL};
> +	reftable_table_from_merged_table(&tab, mt);
> +	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
> +	QSORT(sorted, transaction->nr, ref_update_cmp);
> +	reftable_writer_set_limits(writer, ts, ts);
> +
> +	for (i = 0; i < transaction->nr; i++) {
> +		struct ref_update *u = sorted[i];
> +		struct reftable_log_record *log = &logs[i];
> +		struct object_id old_id;
> +		fill_reftable_log_record(log);
> +		log->update_index = ts;
> +		log->value_type = REFTABLE_LOG_UPDATE;
> +		log->refname = (char *)u->refname;
> +		log->update.new_hash = u->new_oid.hash;
> +		log->update.message = u->msg;
> +
> +		err = reftable_table_read_ref(&tab, u->refname, &ref);
> +		if (err < 0)
> +			goto done;
> +		else if (err > 0) {
> +			old_id = null_oid;
> +		} else {
> +			oidread(&old_id, ref.value.val1);
> +		}

This seems to assume that 'ref.value_type == REFTABLE_REF_VAL1' - but do 
we expect to have to handle the other types 
(REFTABLE_REF_VAL2/REFTABLE_REF_SYMREF)? When I run tests in seen 
against ASAN I see the following errors in t0031, which suggests we're 
running this code against REFTABLE_REF_SYMREF too - but I don't know if 
that means that this code should be able to handle the other ref types 
or if there's a bug higher up the stack. (AFAIUI REFTABLE_REF_DELETION 
is already handled because reftable_table_read_ref() already returns 1 
for deletion, but the other cases seem valid?)

ASAN error output:

==25352==ERROR: AddressSanitizer: heap-buffer-overflow on address 
0x603000003353 at pc 0x000000499d17 bp 0x7fff0ea0a210 sp 0x7fff0ea099d8
READ of size 32 at 0x603000003353 thread T0
     #0 0x499d16 in __asan_memcpy 
../projects/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:22:3
     #1 0x97ed0a in oidread hash.h:292:2
     #2 0x97ed0a in write_transaction_table refs/reftable-backend.c:548:4
     #3 0xb5537a in reftable_addition_add reftable/stack.c:650:8
     #4 0x97b024 in git_reftable_transaction_finish 
refs/reftable-backend.c:618:9
     #5 0x95f9bf in ref_transaction_commit refs.c:2218:8
     #6 0x9d3aa6 in update_head_with_reflog sequencer.c:1138:6
     #7 0x52ffbf in cmd_commit builtin/commit.c:1814:6
     #8 0x4ce8fe in run_builtin git.c:461:11
     #9 0x4ccbc8 in handle_builtin git.c:718:3
     #10 0x4cb0cc in run_argv git.c:785:4
     #11 0x4cb0cc in cmd_main git.c:916:19
     #12 0x6beded in main common-main.c:52:11
     #13 0x7f415c762349 in __libc_start_main (/lib64/libc.so.6+0x24349)
     #14 0x420769 in _start ../sysdeps/x86_64/start.S:120

0x603000003353 is located 0 bytes to the right of 19-byte region 
[0x603000003340,0x603000003353)
allocated by thread T0 here:
     #0 0x4868b4 in strdup 
../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
     #1 0xaa08e8 in xstrdup wrapper.c:29:14
     #2 0xb4b280 in reftable_ref_record_copy_from reftable/record.c:229:23
     #3 0xb46754 in merged_iter_next_entry reftable/merged.c:132:2
     #4 0xb46754 in merged_iter_next reftable/merged.c:141:13
     #5 0xb46754 in merged_iter_next_void reftable/merged.c:157:9
     #6 0xb500ae in iterator_next reftable/generic.c:147:9
     #7 0xb500ae in reftable_iterator_next_ref reftable/generic.c:134:9
     #8 0xb500ae in reftable_table_read_ref reftable/generic.c:46:8
     #9 0x97ec67 in write_transaction_table refs/reftable-backend.c:542:9
     #10 0xb5537a in reftable_addition_add reftable/stack.c:650:8
     #11 0x97b024 in git_reftable_transaction_finish 
refs/reftable-backend.c:618:9
     #12 0x95f9bf in ref_transaction_commit refs.c:2218:8
     #13 0x9d3aa6 in update_head_with_reflog sequencer.c:1138:6
     #14 0x52ffbf in cmd_commit builtin/commit.c:1814:6
     #15 0x4ce8fe in run_builtin git.c:461:11
     #16 0x4ccbc8 in handle_builtin git.c:718:3
     #17 0x4cb0cc in run_argv git.c:785:4
     #18 0x4cb0cc in cmd_main git.c:916:19
     #19 0x6beded in main common-main.c:52:11
     #20 0x7f415c762349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: heap-buffer-overflow 
../projects/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:22:3 in 
__asan_memcpy


Produced using:

   make CC=clang-11 SANITIZE=address COPTS="-Og -g" GIT_TEST_OPTS=-v 
T=t0031-reftable.sh test


> +
> +		/* XXX fold together with the old_id check below? */
> +
> +		log->update.old_hash = old_id.hash;
> +		if (u->flags & REF_LOG_ONLY) {
> +			continue;
> +		}
> +
> +		if (u->flags & REF_HAVE_NEW) {
> +			struct reftable_ref_record ref = { NULL };
> +			struct object_id peeled;
> +
> +			int peel_error = peel_object(&u->new_oid, &peeled);
> +			ref.refname = (char *)u->refname;
> +			ref.update_index = ts;
> +
> +			if (!peel_error) {
> +				ref.value_type = REFTABLE_REF_VAL2;
> +				ref.value.val2.target_value = peeled.hash;
> +				ref.value.val2.value = u->new_oid.hash;
> +			} else if (!is_null_oid(&u->new_oid)) {
> +				ref.value_type = REFTABLE_REF_VAL1;
> +				ref.value.val1 = u->new_oid.hash;
> +			}
> +
> +			err = reftable_writer_add_ref(writer, &ref);
> +			if (err < 0) {
> +				goto done;
> +			}
> +		}
> +	}
> +
> +	for (i = 0; i < transaction->nr; i++) {
> +		err = reftable_writer_add_log(writer, &logs[i]);
> +		clear_reftable_log_record(&logs[i]);
> +		if (err < 0) {
> +			goto done;
> +		}
> +	}
> +
> +done:
> +	assert(err != REFTABLE_API_ERROR);
> +	reftable_ref_record_release(&ref);
> +	free(logs);
> +	free(sorted);
> +	return err;
> +}
> +

[...snip...]
