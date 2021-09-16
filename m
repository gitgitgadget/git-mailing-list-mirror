Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0941C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADE56124B
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 19:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhIPToM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhIPToL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:44:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56357C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:42:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w29so11266236wra.8
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ENxojK9cTSWUZtQWEbG4jPSYPOV1kA/U7MgTrYBdGdk=;
        b=B1+uOVKiSZ5I67MDy7X73bvI9pfWTbgPjScPykZWTCug1WynR7dRrCSEzRDEn8D2rR
         a7yO5+riMdCQM9aLbIeL60q2pHr29EI/xqbtRvnQ4RtH2NzHeDLbxwjDv7mXl7sO7EWH
         kZS/+cGmbuKZPPn8xQMEXnpgm/bgMit0kienx3a0EILmtDJm9HB46fYwBLxq4TKexAHa
         Sd5RPrFFv9USlbOum4mH2/0YOf7YlF73Ftybennre+uS7/qv9fO+C6UqyjAFkcHF/1zB
         qfyDpizhy/lGMCaYPw+h6YYCTF2VTIttSm/DscjtwcWLrWhiRnPmtvOZHrBn5QBoC5qH
         1t+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ENxojK9cTSWUZtQWEbG4jPSYPOV1kA/U7MgTrYBdGdk=;
        b=E9kVj1v6vekjd0sWCOZMUqQTTl1EYjaYAAHNjnGJJH6sw1pXTlSS9EPiW+K3O36NYE
         40o3He+D+TfITYpi0YIgTWFwctw/sDduadjEUnVcK7sMSbrveDMf5cj3umF8wHYzaR8J
         2/e7R2iz2s/VfXjWp36XBMa4I+IsqL2IsYyI/G0s8wtLDoN14CqfQtc87vq+iBBSWaH2
         e1850H0ei5jtnk8GBOWh/zvcKGXRWCRs4VAqlaeX7brNEGNJgP+lRN/K0PXwTfPD1d4T
         ckBgmfY9hCCDsf1ntbQk8UQNJ3Ou810G96zi9U/sADF0qX65KuUk429capT4Agrjrh8+
         cNCg==
X-Gm-Message-State: AOAM531wuMVSo3Ts1K5/0djQwI63hVMfVf5v4yA3wQ99ETR+MaWhAYT3
        cFxYjK6S0qRx2grSq0Oy+P2i+50RgMk=
X-Google-Smtp-Source: ABdhPJyVLKGRzEu1/A9jPxPRbUqev3ybriUDXu8zr6na7N2sOwkOdlDyCGJoFswadT1nFxw16drYjQ==
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr8029454wru.285.1631821368968;
        Thu, 16 Sep 2021 12:42:48 -0700 (PDT)
Received: from szeder.dev (94-21-37-152.pool.digikabel.hu. [94.21.37.152])
        by smtp.gmail.com with ESMTPSA id g9sm9056377wmg.21.2021.09.16.12.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:42:48 -0700 (PDT)
Date:   Thu, 16 Sep 2021 21:42:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 13/25] progress.[ch]: move the "struct progress" to the
 header
Message-ID: <20210916194243.GA2118053@szeder.dev>
References: <YNKWsTsQgB2Ijxu7@nand.local>
 <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
 <patch-13.25-f2e84e3a3f2-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-13.25-f2e84e3a3f2-20210623T155626Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 07:48:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Move the definition of the "struct progress" to the progress.h
> header. Even though its contents are meant to be "private" this
> pattern has resulted in forward declarations of it in various places,
> as other functions have a need to pass it around.
> 
> Let's just define it in the header instead. 

This is not a good excuse to move the definition of 'struct progress'
to the header file.  Defining a struct in a C source file and
declaring it in header files is C's well-established way to create
an opaque data type and to hide implementation details, so there is
nothing wrong with those forward declarations, and keeping 'struct
progress' private to 'progress.c' is a good thing.

Having said that, we can simply remove all those forward declarations
without moving the definition of 'struct progress' to 'progress.h',
and still successfully build git.  The reason is that in 'cache.h':

  struct index_state {
    [...]
    struct progress *progress;
    [...]
  };

does count as a forward declaration of 'struct progress', and
'cache.h' is the first header included in just about all our C source
files, rendering the other forward declaration unnecessary.


> It's part of our own
> internal code, so we're not at much risk of someone tweaking the
> internal fields manually. While doing that rename the "TP_IDX_MAX"
> macro to the more clearly namespaced "PROGRESS_THROUGHPUT_IDX_MAX".
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  cache.h             |  1 -
>  csum-file.h         |  2 --
>  pack.h              |  1 -
>  parallel-checkout.h |  1 -
>  progress.c          | 29 +----------------------------
>  progress.h          | 28 +++++++++++++++++++++++++++-
>  reachable.h         |  1 -
>  7 files changed, 28 insertions(+), 35 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index ba04ff8bd36..7e03a181f68 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -308,7 +308,6 @@ static inline unsigned int canon_mode(unsigned int mode)
>  
>  struct split_index;
>  struct untracked_cache;
> -struct progress;
>  struct pattern_list;
>  
>  struct index_state {
> diff --git a/csum-file.h b/csum-file.h
> index 3044bd19ab6..3de0de653e8 100644
> --- a/csum-file.h
> +++ b/csum-file.h
> @@ -3,8 +3,6 @@
>  
>  #include "hash.h"
>  
> -struct progress;
> -
>  /* A SHA1-protected file */
>  struct hashfile {
>  	int fd;
> diff --git a/pack.h b/pack.h
> index fa139545262..8df04f4937a 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -77,7 +77,6 @@ struct pack_idx_entry {
>  };
>  
>  
> -struct progress;
>  /* Note, the data argument could be NULL if object type is blob */
>  typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
>  
> diff --git a/parallel-checkout.h b/parallel-checkout.h
> index 80f539bcb77..193f76398d6 100644
> --- a/parallel-checkout.h
> +++ b/parallel-checkout.h
> @@ -5,7 +5,6 @@
>  
>  struct cache_entry;
>  struct checkout;
> -struct progress;
>  
>  /****************************************************************
>   * Users of parallel checkout
> diff --git a/progress.c b/progress.c
> index e1b50ef7882..aff9af9ee8b 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -17,33 +17,6 @@
>  #include "utf8.h"
>  #include "config.h"
>  
> -#define TP_IDX_MAX      8
> -
> -struct throughput {
> -	off_t curr_total;
> -	off_t prev_total;
> -	uint64_t prev_ns;
> -	unsigned int avg_bytes;
> -	unsigned int avg_misecs;
> -	unsigned int last_bytes[TP_IDX_MAX];
> -	unsigned int last_misecs[TP_IDX_MAX];
> -	unsigned int idx;
> -	struct strbuf display;
> -};
> -
> -struct progress {
> -	const char *title;
> -	uint64_t last_value;
> -	uint64_t total;
> -	unsigned last_percent;
> -	unsigned delay;
> -	struct throughput *throughput;
> -	uint64_t start_ns;
> -	struct strbuf counters_sb;
> -	int title_len;
> -	int split;
> -};
> -
>  static volatile sig_atomic_t progress_update;
>  static struct progress *global_progress;
>  
> @@ -194,7 +167,7 @@ void display_throughput(struct progress *progress, uint64_t total)
>  	tp->avg_misecs -= tp->last_misecs[tp->idx];
>  	tp->last_bytes[tp->idx] = count;
>  	tp->last_misecs[tp->idx] = misecs;
> -	tp->idx = (tp->idx + 1) % TP_IDX_MAX;
> +	tp->idx = (tp->idx + 1) % PROGRESS_THROUGHPUT_IDX_MAX;
>  
>  	throughput_string(&tp->display, total, rate);
>  	if (progress->last_value != -1 && progress_update)
> diff --git a/progress.h b/progress.h
> index f1913acf73f..4fb2b483d36 100644
> --- a/progress.h
> +++ b/progress.h
> @@ -1,7 +1,33 @@
>  #ifndef PROGRESS_H
>  #define PROGRESS_H
> +#include "strbuf.h"
>  
> -struct progress;
> +#define PROGRESS_THROUGHPUT_IDX_MAX      8
> +
> +struct throughput {
> +	off_t curr_total;
> +	off_t prev_total;
> +	uint64_t prev_ns;
> +	unsigned int avg_bytes;
> +	unsigned int avg_misecs;
> +	unsigned int last_bytes[PROGRESS_THROUGHPUT_IDX_MAX];
> +	unsigned int last_misecs[PROGRESS_THROUGHPUT_IDX_MAX];
> +	unsigned int idx;
> +	struct strbuf display;
> +};
> +
> +struct progress {
> +	const char *title;
> +	uint64_t last_value;
> +	uint64_t total;
> +	unsigned last_percent;
> +	unsigned delay;
> +	struct throughput *throughput;
> +	uint64_t start_ns;
> +	struct strbuf counters_sb;
> +	int title_len;
> +	int split;
> +};
>  
>  #ifdef GIT_TEST_PROGRESS_ONLY
>  
> diff --git a/reachable.h b/reachable.h
> index 5df932ad8f5..7e1ddddbc63 100644
> --- a/reachable.h
> +++ b/reachable.h
> @@ -1,7 +1,6 @@
>  #ifndef REACHEABLE_H
>  #define REACHEABLE_H
>  
> -struct progress;
>  struct rev_info;
>  
>  int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
> -- 
> 2.32.0.599.g3967b4fa4ac
> 
