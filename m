Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942DEC433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D21464F4E
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 15:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCJPJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 10:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhCJPJB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 10:09:01 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F62C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 07:09:01 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id w6so13209885qti.6
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 07:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zlG9MtQb9xEfKTjuof32ul7X5X3R1+wVpoBXUVkoHhk=;
        b=Fl9XCTU06hJ6rjYhtyynS/2ebRm87iVyMQXd7E39mwm1ZkllWfW/ylJbU3VjKDbGIj
         wsxOQcPeac+a4Mzc4AGa4XoGmfDUMyLCYBm1SQKXq1f9dVELWM2Ff9Z5G0r2/02vXe1b
         yh3BpNFST0MWD2Kr38NFZ1o7jrNDT69QYo6+isiI79mhCYESLtrHu3Ua/3TYy4JeidWS
         FNweryVpZHzr/68AoKKuUYHFJ0DiDpwDBIE/tc0/YHwnmuJsD6S8k4LIPF7SOIjMScFG
         FtwYz6JBMR3HEpKZEnhq8VBiIxPs8Kd8//waWd5JUdhAB1BSYArMWHnlLrlmlQOrMdf+
         J6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zlG9MtQb9xEfKTjuof32ul7X5X3R1+wVpoBXUVkoHhk=;
        b=jvSOd+iXSCAfAJQ5Cq6juzvhPJ0aOSLGKRm1lUQIYWq8f6qt2qxUlxEK4undlM9AX4
         4iqhmeSwihaxiLKXSOdt6OyQbTXg1JQnxb478luFfyL2+cFoDMy4TGf3iHbJNeCGQcUe
         tJRiTYNn2sN8U2pwWc3ctl5KGR0M6Q55Y6m4zOp631VLjpnqQioKkUq6pPEh36yjrz0L
         JL7K2+R3GGtinTsCzaBMnPijnPkHqEFmEN4gRPsXp7Aiera9VqtdpqRHPc1kJ2eqTY2F
         BdbN4+OPPOkljMRAwpXuNOuHxwaPFjWQXSgyVzaqqf/9ZDv/dSpTFbtGIpmcHwMi/4AD
         3PDg==
X-Gm-Message-State: AOAM532mIgUwPu+719MlVgDjPehNrHgOhDxzg021QGI+bq0A1XQTeloR
        BjQscXGiqQPOic3/txGjaEI=
X-Google-Smtp-Source: ABdhPJyDMct4ZyK1pI8gAg0fDlsk/VwBvrieYdPhq4ZmWTKqu9+3XDy0Pb7HH85S75aRToeAqp0ODA==
X-Received: by 2002:ac8:7516:: with SMTP id u22mr2948963qtq.113.1615388940531;
        Wed, 10 Mar 2021 07:09:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:cc70:a06f:72ba:12a7? ([2600:1700:e72:80a0:cc70:a06f:72ba:12a7])
        by smtp.gmail.com with ESMTPSA id s13sm896959qkg.17.2021.03.10.07.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 07:09:00 -0800 (PST)
Subject: Re: [PATCH v2 0/8] Optimization batch 9: avoid detecting irrelevant
 renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
 <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c4ce57f2-fc02-a70c-5ecb-0911a551192c@gmail.com>
Date:   Wed, 10 Mar 2021 10:08:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/2021 7:09 PM, Elijah Newren via GitGitGadget wrote:
> This series depends textually on ort-perf-batch-8, but semantically it's
> almost completely unrelated and can be reviewed without any familiarity with
> any of the previous patch series.
> 
> There are no changes since v1; it's just a resend just over a week later to
> bump it so it isn't lost.
> 
> === Basic Optimization idea ===
> 
> This series determines paths which meet special cases where detection of
> renames is irrelevant, where the irrelevance is due to the fact that the
> merge machinery will arrive at the same result regardless of whether a
> rename is detected for any of those paths. This series represents
> "Optimization #2" from my Git Merge 2020 talk[1], though this series has
> some improvements on the optimization relative to what I had at that time.
> 
> The basic idea here is:
> 
> We only need expensive rename detection on the subset of files changed on
> both sides of history (for the most part).

I've taken time this morning to re-read some of the patches. I have a
grasp on the idea of the optimization and the code looks well presented
and correct.

The only issue I have is that there are no additional tests to ensure that
these scenarios are being tested and are checked to return the correct
results. Naturally, it seems we are not testing the ORT strategy by default,
and if I do enable it, that causes test failures still.

I wonder how much we should be merging these optimizations before the full
test suite can pass with ORT as the default. Then, we can check to see if
small mutations can be caught by the test suite. In particular, everything
in this optimization seems to revolve around this condition in add_pair():

		if (content_relevant || location_relevant)
			strset_add(&renames->relevant_sources[side], pathname);

I'd prefer to have test cases that cover all four options for the two boolean
values on this operator. Mostly, I'd like to know that if I delete either side
of the || operator (or change it to &&) then we would have a test failure.

Thanks,
-Stolee
