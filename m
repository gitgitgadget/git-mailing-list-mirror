Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C66C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04116104F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhHEPHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbhHEPHf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D0AC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k38-20020a05600c1ca6b029025af5e0f38bso6572652wms.5
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HLCNKgHHYCFas7daLYl9ysBEHz463DBUy4UY8L4Gfoo=;
        b=HPsAQeklPbl/Xw8SFz5+mVPWlj7R8KvdqFlHrueogLdjNSvZYDV+/iJGMVO5iKRghb
         /yjOWSZFzgQASkYESLPmnFXiW+NCQ6RVBLWpfeHjqJTwHBxqMspHe+LyFu4ESq42VkHC
         Om+iekca+vysN7x2YnHq3CsoMJbghAHwT90uWzqKoOXGoIWOqA0QpWMJ4oz5e/jGUj9v
         2G4znSWmBTa9cIlfajZ8gR6Ifc2TVa/epYGkivoySBvsyXPa/uVoObtAImhWTnQ54ViS
         UPby96z6tnayfaxCFK/o16/GYAVCkr6E1NxeExH0NTtfTum9h4v+rxfKhvbviZIAjxxM
         oFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HLCNKgHHYCFas7daLYl9ysBEHz463DBUy4UY8L4Gfoo=;
        b=bXC0fSc/8cizWAxvaOGxP34955ni7XhL9kUFci9bgvpHaHTiZTAphBn8SbvZ24HWL1
         jYDoHGXUNNhQoEjuykVQzbx14x2UURsR1yrvX7XYgfr/aCVJFJ8QmWvxct4fZNvoeq4h
         EMjDxH/w0BPT0+oceLjZXHtGwFt1HuDCMRFCfqBicZ+NJuqqCkViW2JOPsKKdFMECOs8
         YXL0Kj6usndn7JdlyHylVGijrdf0vBU8T7tahg2rfY+bU5C/I6fJrCti2j/OlsFVl8VH
         YdIfKu10Anh8qfjJ9b+Fq2Def4vVjnj7pHbGAOBWgawbDcq63GuDxEdKPkbF0TOH0jbS
         mQEQ==
X-Gm-Message-State: AOAM533fh9S8picaKGs9jF4xBon2uhfa3nJMGZHslAdZ4tJlhxaveFtv
        7Vrv0CYvN8vmn4T06t55opdqRjHjbQw=
X-Google-Smtp-Source: ABdhPJwL86nq8J6Qjx5tmSdFJx7qTLpwz1+YF9sqqsyNaaGfXe5tNZ5ZYLzThwvb7RnBA+u4qWUeeA==
X-Received: by 2002:a05:600c:4a12:: with SMTP id c18mr15590254wmp.3.1628176039039;
        Thu, 05 Aug 2021 08:07:19 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.232])
        by smtp.gmail.com with ESMTPSA id t15sm6165540wrw.48.2021.08.05.08.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 08:07:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] midx: don't provide a total for QSORT() progress
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
 <patch-2.3-3411fe0515-20210722T121801Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5cf55741-d06a-f8f3-5027-02c5e1dfa672@gmail.com>
Date:   Thu, 5 Aug 2021 16:07:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <patch-2.3-3411fe0515-20210722T121801Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/2021 13:20, Ævar Arnfjörð Bjarmason wrote:
> The quicksort algorithm can be anywhere between O(n) and O(n^2), so
> providing a "num objects" as a total means that in some cases we're
> going to go past 100%.

Being pedantic QSORT() is not necessarily a quicksort, for example 
compact/qsort_s.c implements a merge sort.

I'm confused as to how we go past 100% when we only call 
display_progress(progress, 0) and then stop_progress(). If my reading of 
progress.c is correct then this change means we'll stop displaying a 
percentage as progress->total will be zero in

static void display(struct progress *progress, uint64_t n, const char *done)
{
	/* ... */
	if (progress->total) {
		unsigned percent = n * 100 / progress->total;
		if (percent != progress->last_percent || progress_update) {
			progress->last_percent = percent;

			strbuf_reset(counters_sb);
			strbuf_addf(counters_sb,
				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
				    (uintmax_t)n, (uintmax_t)progress->total,
				    tp);
			show_update = 1;
		}
	} else if (progress_update) {
		strbuf_reset(counters_sb);
		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
		show_update = 1;
	}
	/* ... */
}

Best Wishes

Phillip

> This fixes a logic error in 5ae18df9d8e (midx: during verify group
> objects by packfile to speed verification, 2019-03-21), which in turn
> seems to have been diligently copied from my own logic error in the
> commit-graph.c code, see 890226ccb57 (commit-graph write: add
> itermediate progress, 2019-01-19).
> 
> That commit-graph code of mine was removed in
> 1cbdbf3bef7 (commit-graph: drop count_distinct_commits() function,
> 2020-12-07), so we don't need to fix that too.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   midx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/midx.c b/midx.c
> index 9a35b0255d..eaae75ab19 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1291,7 +1291,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
>   
>   	if (flags & MIDX_PROGRESS)
>   		progress = start_sparse_progress(_("Sorting objects by packfile"),
> -						 m->num_objects);
> +						 0);
>   	display_progress(progress, 0); /* TODO: Measure QSORT() progress */
>   	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
>   	stop_progress(&progress);
> 
