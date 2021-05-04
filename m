Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3FBC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C0961176
	for <git@archiver.kernel.org>; Tue,  4 May 2021 17:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhEDRY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 13:24:27 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:37338 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhEDRY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 13:24:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 6277740B67;
        Tue,  4 May 2021 19:23:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1620149008; x=1621963409; bh=305w3txX2wiWXxWcTP5
        +k3Gy+F8sgDZYYmjuMm342+I=; b=WDfbspz2mm1MS5zWuXqM//FBHND6aXRW//Z
        deRg9qxTK1Ge0CWTC6YQ/bPigoR7At/VrvhLnPTCdpjjAvxrabXtmtm8wmujF353
        a4e2uTgJsbPu1+sc30mhk9t6f+fVsXMqciKVlQza+WL8farN4G1M7oPs/O5431pd
        PkHdfGYdQMpcdTgJwN5Ykilk5Onwi4xeZ5l45YQljBPoV7ADfQCuY2QkcozTNAnv
        emSUmSvIJU+zwOEuQ2csL8BQqFOxkFYI02jEe31p/PQZ0/UqgV4tRYyuxYKJIN5o
        EBOUGycWc/UyRiPm7XebCAsnO2AkQo1hOz9cdVL5zW1WwdfGjTunQ/pqgyeHRww9
        yvkBmyBqNGpFHM5QIvcaD768T5TMdiV0b11+1uNch80xzbuKlPBts584sVE0yzlH
        BENoYmNiKxbKG5yzFWunIRwwueP/bGmQlrvB1mn7OQTIHJLTHoP0seujS38nKxr9
        2utIReki9sCjbpmB/Hs3lLmKV9tt9K3kUF06iiF+TFyJf64W465UvbgOXxOVv8N7
        NUfPGt8oV1zXae868ZYRoANBQh9BudLdXlL+6Q7mgCAw1MXCzSWRbp1SUk+syhHL
        Lh+0NF+HrceN6nUBZdlDrvPyEMTRAY5cDGMwGK72M2jU8/3RrW2Tq2a8j70Ju08U
        V6Qtj6WU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QvxDEv5NfMgd; Tue,  4 May 2021 19:23:28 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 8A9EA40A74;
        Tue,  4 May 2021 19:23:28 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 3CA404853;
        Tue,  4 May 2021 19:23:23 +0200 (CEST)
Subject: Re: [PATCH v7 10/28] reftable: (de)serialization for the polymorphic
 record type.
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
 <028dd13e701bf82523cc6da1e68a9dab480c1b27.1618832277.git.gitgitgadget@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <ef664c5c-d959-e265-d678-6fc54d23f031@ahunt.org>
Date:   Tue, 4 May 2021 19:23:22 +0200
MIME-Version: 1.0
In-Reply-To: <028dd13e701bf82523cc6da1e68a9dab480c1b27.1618832277.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/04/2021 13:37, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
[...snip...]
> diff --git a/reftable/record.c b/reftable/record.c
> new file mode 100644
> index 000000000000..b111852b667e
> --- /dev/null
> +++ b/reftable/record.c[...snip...> +static void reftable_obj_record_copy_from(void *rec, const 
void *src_rec,
> +					  int hash_size)
> +{
> +	struct reftable_obj_record *obj = rec;
> +	const struct reftable_obj_record *src =
> +		(const struct reftable_obj_record *)src_rec;
> +	int olen;
> +
> +	reftable_obj_record_release(obj);
> +	*obj = *src;
> +	obj->hash_prefix = reftable_malloc(obj->hash_prefix_len);
> +	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
> +
> +	olen = obj->offset_len * sizeof(uint64_t);
> +	obj->offsets = reftable_malloc(olen);
> +	memcpy(obj->offsets, src->offsets, olen);
> +}

If src->offset_len is 0 then offsets will be NULL - and passing NULL 
into memcpy() results in undefined behaviour. I think we should either 
add an "if (src->offset_len)" check around the memcpy, or perhaps switch 
to COPY_ARRAY() which performs that check for us. (We can probably also 
skip the malloc and hence also olen calculation in this scenario though, 
because obj->offsets should already be NULL if src->offsets was NULL?)

Specifically, if I run t0032 as such:

   make CC=clang-11 UBSAN_OPTIONS=print_stacktrace=1 SANITIZE=undefined 
COPTS="-Og -g" GIT_TEST_OPTS=-v T=t0032-reftable-unittest.sh test

UBSAN reports the following error:

reftable/record.c:475:23: runtime error: null pointer passed as argument 
2, which is declared to never be null
/usr/include/string.h:43:28: note: nonnull attribute specified here
     #0 0x698e52 in reftable_obj_record_copy_from record.c:475:2
     #1 0x6ac806 in test_copy record_test.c:21:2
     #2 0x6abb73 in test_reftable_obj_record_roundtrip record_test.c:334:3
     #3 0x6abb73 in record_test_main record_test.c:403:2
     #4 0x437f08 in cmd__reftable test-reftable.c:10:2
     #5 0x427e74 in cmd_main test-tool.c:126:11
     #6 0x428043 in main common-main.c:52:11
     #7 0x7f3cd1044349 in __libc_start_main (/lib64/libc.so.6+0x24349)
     #8 0x407209 in _start start.S:120

SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior 
reftable/record.c:475:23 in

[...snip...]
> +static int reftable_obj_record_decode(void *rec, struct strbuf key,
> +				      uint8_t val_type, struct string_view in,
> +				      int hash_size)
> +{
> +	struct string_view start = in;
> +	struct reftable_obj_record *r = rec;
> +	uint64_t count = val_type;
> +	int n = 0;
> +	uint64_t last;
> +	int j;
> +	r->hash_prefix = reftable_malloc(key.len);
> +	memcpy(r->hash_prefix, key.buf, key.len);
> +	r->hash_prefix_len = key.len;
> +
> +	if (val_type == 0) {
> +		n = get_var_int(&count, &in);
> +		if (n < 0) {
> +			return n;
> +		}
> +
> +		string_view_consume(&in, n);
> +	}
> +
> +	r->offsets = NULL;
> +	r->offset_len = 0;
> +	if (count == 0)
> +		return start.len - in.len;

And it looks like creating a reftable_obj_record with offsets = NULL and 
offset_len = 0 is considered valid based on the code above.

[... snipped the rest ...]
