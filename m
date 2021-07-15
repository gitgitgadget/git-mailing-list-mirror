Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F867C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA60613C0
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhGOOp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhGOOpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 10:45:55 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D01C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:43:02 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y6so5182969ilj.13
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S1KmGxInEERKrBJmdWW4iUMYg4dgX/KLV0+VtjTDA6U=;
        b=J8J9hNCEwg9k9NTkpkE+den3in50tvSMAUdWI8ClQ1/lASktYWcmwLgydZwccNERcN
         /qOfvGyeneGlwQolbQJeL291+mPetGhxq3QjLTvCCkrpnEDYzguw0dtcGht0ZT1OT8gg
         bPvQwK6fWbJSEu51GolciWHdyoJZwgJeLLkdq23HfvQS/hMX5q9BRrmoVRYpkwfNo++H
         X0OORpuJzXvFk9vj9h0L3RmjzWW5Wc7455Vk1isyFYTsIAubq483pBuBamBj2kVmPWiX
         AbRP1dA8rpkoTk6DNdZVXA5HZ7Q2h2HjcxNO8ndZq+GC2d+hAKMQdK04tWD4oBZ+mQER
         LTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S1KmGxInEERKrBJmdWW4iUMYg4dgX/KLV0+VtjTDA6U=;
        b=hLx4n3d9y51sUkK3cMngB7dBdPDRu1UVpccBM735qQKBoIpXXEqj55ZKi+1+b5exf+
         sUFdXpkjIU7mHl95rLfFvVsVdivrA6Ei5Zdw0zmPDwfMZm0nigEAn0tKtvboMmD/1J+V
         StG1zM34rZsyMNsY7+bzR0oy8JoAgunOq96N5tbTtDYkGh0XLYyeOcMpNm0abamSxHRV
         uI0t6CsN++n5Y75vElNwbZNl+6JpKyNmXSSisezk1v2aXbsJMypZYb4fMHFOjNMqoIqI
         ClCaEbkXJwwrITSUu6DnulakTqUHxFUFnGbIeIFYope1ayZAtKf3KaIUwZImRZGB7Lh5
         WKWQ==
X-Gm-Message-State: AOAM530s6Sg1SZoQcwx0BZVubJtrvQvg+Orx2c9OUZTEHnyZAKwKrNyg
        XgZXQPeW05lqKYw2s1h8688=
X-Google-Smtp-Source: ABdhPJy3bRGOZYiY18Oh6i/ySxjMy6x6uDmNsWmmpd25gpa3ArRSpzeX83j9MjhJzgQb0mawAeW9wA==
X-Received: by 2002:a05:6e02:1d9b:: with SMTP id h27mr2903471ila.23.1626360182007;
        Thu, 15 Jul 2021 07:43:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2? ([2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2])
        by smtp.gmail.com with ESMTPSA id e14sm3049337ilq.32.2021.07.15.07.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 07:43:01 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] merge-ort: defer recursing into directories when
 merge base is matched
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <pull.988.v2.git.1626204784.gitgitgadget@gmail.com>
 <317553eadb68ce162b5ebea24045a9ca75342e91.1626204784.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <24a7bea5-6325-289d-8d49-619b5e7ec65b@gmail.com>
Date:   Thu, 15 Jul 2021 10:43:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <317553eadb68ce162b5ebea24045a9ca75342e91.1626204784.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/13/2021 3:33 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
...
> +		/*
> +		 * Check for whether we can avoid recursing due to one side
> +		 * matching the merge base.  The side that does NOT match is
> +		 * the one that might have a rename destination we need.
> +		 */
> +		assert(!side1_matches_mbase || !side2_matches_mbase);
> +		side = side1_matches_mbase ? MERGE_SIDE2 :
> +			side2_matches_mbase ? MERGE_SIDE1 : MERGE_BASE;
> +		if (filemask == 0 && (dirmask == 2 || dirmask == 4)) {
> +			/*
> +			 * Also defer recursing into new directories; set up a
> +			 * few variables to let us do so.
> +			 */
> +			ci->match_mask = (7 - dirmask);
> +			side = dirmask / 2;

Clever.

> +		}
> +		if (renames->dir_rename_mask != 0x07 &&
> +		    (side != MERGE_BASE) &&

nit: these parens are not necessary?

> +		    renames->trivial_merges_okay[side] &&
> +		    !strset_contains(&renames->target_dirs[side], pi.string)) {

Does this last condition mean "this directory is not already a parent of a
chosen rename target"?

> +			strintmap_set(&renames->possible_trivial_merges[side],
> +				      pi.string, renames->dir_rename_mask);
> +			renames->dir_rename_mask = prev_dir_rename_mask;
> +			return mask;
> +		}
> +
> +		/* We need to recurse */
>  		ci->match_mask &= filemask;
Thanks,
-Stolee
