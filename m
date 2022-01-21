Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BEDC433F5
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 12:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380397AbiAUMkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiAUMkK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 07:40:10 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1CBC061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:40:10 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z22so42367399edd.12
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8VNlRkGsa8CCydqeRqAFptDoDv7TqpvZweUzC/xAicQ=;
        b=pnjTUXtTtcoN9/J6tjJvUPO2Wqz24o8BfNm4PnxSW3DoQS4RigWzocPomVZAd+oqkd
         ZWQEt/9augBvTF/U9XmGOaQyKc7z2/WSt30KW5tTu80E6HLyURFvrzaWH83GH4rr1NHb
         d5YpZWHywpMidumF8RgQrskQeM/pPOyv2SwuDQ/rB+citjJzRBcRh0kVbBq2N/cPzjrM
         YrYeaJ0E30AYGCAbaCycGstzjllaeVCh8E+nK3O9cs1xyhBxZ5kvF2AEpdD0Quk58zTR
         WPQR14PLRIY6p2FyjQzU4eBilg/JgGlfgwmXsiIpq4z3povjqhwVbu/iS6ictvq7xNpo
         nQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8VNlRkGsa8CCydqeRqAFptDoDv7TqpvZweUzC/xAicQ=;
        b=OoibGHOqjMpZd9SHtN3u1T4IlH7mQvNQNOESg6GoRBkwVrLjzJRZwZAJqshFvwvCyC
         K9G97mrz4ViBvxEI9LFGSumxW8mWYVHfmZ63wcW+dXp0KhckppRyQnrIAwJQZ3V+S0mF
         GEHO26dH+UKQJCTYlaaBnDb9VRKEjopEzbHMWJ7FJYZWF17N83YSwDtsA+02LYxKer4A
         66g22SNw17NEzqg98qygJW1qaKFLnQeCR0+57TW5K0y1MRaQTc+lNU1fYrQKVu6tZnc2
         9dsrL5NY9HiV+E/+JcjZSuU8G+wF3A6PAjjtWaVztwplJP/BcVs7tOV88tnrY42cseRb
         IRaQ==
X-Gm-Message-State: AOAM532mCl/M23Zal5ca98Sw+yiSHwItO74gXAgBz3N4ZXZwgvlKB01E
        i37wfnPPhiQMPVuo69nTDtm3mWT6TmHYcw==
X-Google-Smtp-Source: ABdhPJxV/3Jywuex43jcMoIwYnfm/sa3IaonAAiLhor8lPbwuvAPDWz1PNntDpfSWCkOQBOqXfb/rw==
X-Received: by 2002:a17:906:4786:: with SMTP id cw6mr3144955ejc.600.1642768808435;
        Fri, 21 Jan 2022 04:40:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s19sm438491edr.23.2022.01.21.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 04:40:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAtD5-0028sC-C3;
        Fri, 21 Jan 2022 13:40:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 15/15] reftable: add print functions to the record types
Date:   Fri, 21 Jan 2022 13:33:05 +0100
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <82f140cab5c30b59de534d773a5d00343e0868f9.1642691534.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <82f140cab5c30b59de534d773a5d00343e0868f9.1642691534.git.gitgitgadget@gmail.com>
Message-ID: <220121.86bl05jm8o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
> [...]
> +void reftable_ref_record_print(const struct reftable_ref_record *ref,
> +			       uint32_t hash_id) {

...here...

> +	reftable_ref_record_print_sz(ref, hash_size(hash_id));
> +}
> +
>  static void reftable_ref_record_release_void(void *rec)
>  {
>  	reftable_ref_record_release(rec);
> @@ -443,6 +448,12 @@ static int reftable_ref_record_equal_void(const void *a,
>  	return reftable_ref_record_equal(ra, rb, hash_size);
>  }
>  
> +static void reftable_ref_record_print_void(const void *rec,
> +					   int hash_size)

...and here you avoid a line longer than 79 characters....

> +{
> +	reftable_ref_record_print_sz((struct reftable_ref_record *) rec, hash_size);

...but not here...

> +		strbuf_addf(&offset_str, "%" PRIu64 " ", obj->offsets[i]);

"%"PRIu64 not "%" PRIu64, per the usual coding style....

> -		printf("log{%s(%" PRIu64 ") delete", log->refname,
> +		printf("log{%s(%" PRIu64 ") delete\n", log->refname,

...although I see we have some existing code here in reftable/ using the other style..

> +static void reftable_index_record_print(const void *rec, int hash_size)
> +{
> +	const struct reftable_index_record *idx = rec;
> +	/* TODO: escape null chars? */

That's quite scary as a TODO comment, can we think about whether we're
doing the wrong thing here? I.e. the printf() will stop on a \0, or
maybe I'm misunderstanding this...

>  	/* Are two records equal? This assumes they have the same type. Returns 0 for non-equal. */
>  	int (*equal)(const void *a, const void *b, int hash_size);
> +
> +	/* Print on stdout, for debugging. */

Inaccurate comment, this isn't for ad-hoc debugging, we're using this in
the reftable tests....

> +	void (*print)(const void *rec, int hash_size);
>  };
>  
>  /* returns true for recognized block types. Block start with the block type. */
> @@ -112,6 +115,7 @@ struct reftable_record {
>  
>  /* see struct record_vtable */
>  int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
> +void reftable_record_print(struct reftable_record *rec, int hash_size);
>  void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
>  uint8_t reftable_record_type(struct reftable_record *rec);
>  void reftable_record_copy_from(struct reftable_record *rec,
> diff --git a/reftable/record_test.c b/reftable/record_test.c
> index c6fdd1925a9..f91ea5e8830 100644
> --- a/reftable/record_test.c
> +++ b/reftable/record_test.c
> @@ -25,6 +25,10 @@ static void test_copy(struct reftable_record *rec)
>  	/* do it twice to catch memory leaks */
>  	reftable_record_copy_from(&copy, rec, GIT_SHA1_RAWSZ);
>  	EXPECT(reftable_record_equal(rec, &copy, GIT_SHA1_RAWSZ));
> +
> +	puts("testing print coverage:\n");
> +	reftable_record_print(&copy, GIT_SHA1_RAWSZ);

...i.e. here.

> +
>  	reftable_record_release(&copy);
>  }
>  
> @@ -176,7 +180,8 @@ static void test_reftable_log_record_equal(void)
>  static void test_reftable_log_record_roundtrip(void)
>  {
>  	int i;
> -	struct reftable_log_record in[2] = {
> +

...more stray whitespace...

> +	struct reftable_log_record in[] = {
>  		{
>  			.refname = xstrdup("refs/heads/master"),
>  			.update_index = 42,
> @@ -197,10 +202,24 @@ static void test_reftable_log_record_roundtrip(void)
>  			.refname = xstrdup("refs/heads/master"),
>  			.update_index = 22,
>  			.value_type = REFTABLE_LOG_DELETION,
> +		},
> +		{
> +			.refname = xstrdup("branch"),
> +			.update_index = 33,
> +			.value_type = REFTABLE_LOG_UPDATE,
> +			.value = {
> +				.update = {
> +					.old_hash = reftable_malloc(GIT_SHA1_RAWSZ),
> +					.new_hash = reftable_malloc(GIT_SHA1_RAWSZ),
> +					/* rest of fields left empty. */

But in test_reftable_log_record_roundtrip() we have another existing
user who leaves out fields, but doesn't have such a comment.

I think it's better to just leave it out here, clearly it's intentional,
but if it's going to be added to anything surely the other user defining
5/7 fields is better than this user of 2/7 fields (i.e. the 5/7 is more
likely to be an unintentional omission), this one is clearly
intentional.
