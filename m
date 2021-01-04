Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE20C433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 01:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F802080D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 01:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbhADB12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 20:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADB11 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 20:27:27 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476ADC061574
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 17:26:47 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id y14so5931187oom.10
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 17:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mRjccrlJnDenomKu1gExfcvms/GL2r8UGTGQSpM8ZYk=;
        b=LplbeG9GmV+BBHufNvVv2jkStfycPISICyiuieJxe2eEio7UzvOItFmjlP0AclK4HW
         Nscet7bnw6USqpxXPF2EsENJiOhVpnG1IXhyRBv0ke+FzgavloEbQAldJvQNj+s/fO0U
         BoWrKdbUtwmwXg0KAooilYFkGUvkMKRbQfukyNskGSl5Mvr7KfGE6EzmsA4n50bg2Lt3
         PuFxKGhTWHxDqYurOZp60OMoyOrKehpyjX9pIxYTUm51svVWgnYiGeRUkCveKBNbRA7I
         6bmy23CqcP1JKL4w4LKATL/7QNZMCwx4KEV9Vx8lsmVE206bWwCA6HGCSH0YwPwX3rAV
         EsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mRjccrlJnDenomKu1gExfcvms/GL2r8UGTGQSpM8ZYk=;
        b=TROs1a5bBQ4x0Fdtd5wgPyLwguKohTyfhgawQO3yLMItoV18FUNbv5ihd6Wt7KJYwc
         xsN938vCMzR6D1UefDj0ufR3SKPM9DrK9v+dOsnxb0TNL9iArAXWhwxx5eCESOn3+BcH
         5GNbdG1IDSPuI8CJNK0RvSFo7m1FouQcIxIxwfMTE6A4JGho1xc0cDnMTculmiELUbx1
         tzdRzIRkyYmy6MVOhqNIOIR+PFbM92B9imwT1DJiYKW7x/odLKfwgkwojiGDZVI9ou6Z
         L970pYbVXsg9mALQkxRW+woH0VSkaW6/iMbPin2tal5XNrf9p+aaASrexr7PE+vQvN4C
         wzug==
X-Gm-Message-State: AOAM533HAB8nY8ANKGieO5wF20aQ/V/P+vkyu9v5O2aC83QlB+GrjJdt
        +hZp0JQUIobY7+2RFktb0bY=
X-Google-Smtp-Source: ABdhPJzDi81mHXPfN0U8HdjHSEOtAIvyuCdrGcQWzpQ9HvkmCgScQqPBk4NgZ0IiGASgYe9Depwhpw==
X-Received: by 2002:a4a:c191:: with SMTP id w17mr48368252oop.1.1609723606666;
        Sun, 03 Jan 2021 17:26:46 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id t26sm13233954otm.17.2021.01.03.17.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 17:26:46 -0800 (PST)
Subject: Re: [PATCH] cache-tree: use ce_namelen() instead of strlen()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
 <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
 <daeb59ee-861d-9c8d-3601-6aef1ac3fc94@web.de>
 <3ed37ae6-1f09-bd6b-c9d9-c8089da1af92@gmail.com>
 <a8b5bb13-5c88-d744-b47e-7204e12ad05d@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <247e3c34-6190-c9e4-2a82-0f4b71249bdb@gmail.com>
Date:   Sun, 3 Jan 2021 20:26:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <a8b5bb13-5c88-d744-b47e-7204e12ad05d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/2/2021 10:19 AM, René Scharfe wrote:
> Use the name length field of cache entries instead of calculating its
> value anew.

Thanks! I didn't know about this macro.

-Stolee

> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Not sure why it took me so long to spot this.. o_O
> 
>  cache-tree.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/cache-tree.c b/cache-tree.c
> index a537a806c1..57cacab195 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -185,10 +185,12 @@ static int verify_cache(struct cache_entry **cache,
>  		 * the cache is sorted.  Also path can appear only once,
>  		 * which means conflicting one would immediately follow.
>  		 */
> -		const char *this_name = cache[i]->name;
> -		const char *next_name = cache[i+1]->name;
> -		int this_len = strlen(this_name);
> -		if (this_len < strlen(next_name) &&
> +		const struct cache_entry *this_ce = cache[i];
> +		const struct cache_entry *next_ce = cache[i + 1];
> +		const char *this_name = this_ce->name;
> +		const char *next_name = next_ce->name;
> +		int this_len = ce_namelen(this_ce);
> +		if (this_len < ce_namelen(next_ce) &&
>  		    strncmp(this_name, next_name, this_len) == 0 &&
>  		    next_name[this_len] == '/') {
>  			if (10 < ++funny) {

For what it's worth, this caching of the lengths lowers my test
time from 854ms to 833ms. It goes down again to 816ms with the
swapped conditional, so I'll include that patch here:

-- >8 --

From 8f303000030bd8f9db3466c90eb0d9fea11a7c3b Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Sun, 3 Jan 2021 20:20:05 -0500
Subject: [PATCH] cache-tree: speed up consecutive path comparisons
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The previous change reduced time spent in strlen() while comparing
consecutive paths in verify_cache(), but we can do better. The
conditional checks the existence of a directory separator at the correct
location, but only after doing a string comparison. Swap the order to be
logically equivalent but perform fewer string comparisons.

To test the effect on performance, I used a repository with over three
million paths in the index. I then ran the following command on repeat:

  git -c index.threads=1 commit --amend --allow-empty --no-edit

Here are the measurements over 10 runs after a 5-run warmup:

  Benchmark #1: v2.30.0
    Time (mean ± σ):     854.5 ms ±  18.2 ms
    Range (min … max):   825.0 ms … 892.8 ms

  Benchmark #2: Previous change
    Time (mean ± σ):     833.2 ms ±  10.3 ms
    Range (min … max):   815.8 ms … 849.7 ms

  Benchmark #3: This change
    Time (mean ± σ):     815.5 ms ±  18.1 ms
    Range (min … max):   795.4 ms … 849.5 ms

This change is 2% faster than the previous change and 5% faster than
v2.30.0.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 57cacab195..6eaef21145 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -191,8 +191,8 @@ static int verify_cache(struct cache_entry **cache,
 		const char *next_name = next_ce->name;
 		int this_len = ce_namelen(this_ce);
 		if (this_len < ce_namelen(next_ce) &&
-		    strncmp(this_name, next_name, this_len) == 0 &&
-		    next_name[this_len] == '/') {
+		    next_name[this_len] == '/' &&
+		    strncmp(this_name, next_name, this_len) == 0) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
-- 
v2.30.0


