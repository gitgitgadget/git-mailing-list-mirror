Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30E1C34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DA520659
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 12:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwGC/6aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRMzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:55:25 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35191 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgBRMzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 07:55:25 -0500
Received: by mail-qk1-f193.google.com with SMTP id v2so19366279qkj.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 04:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C6v859bFrrIc/0ansisyd3RnNZVsRN09YoRowz+ffvE=;
        b=gwGC/6awTfhL+u7LPI/KPgcXOX9w5r1Ik0MQIPnHBNdHiqhuZA/evr57saaM8wvxJA
         17VCJGrkqcR+Ba+jja9MosIQgnzwu+Xv3O22wf1LMsizYDwxE8rriMsI3MvQghLfm0EB
         NSilwso9lezFu/7zM+KhzV3k4sZtrYdS75xQRTM2mSeRDPshAwQTvliJcsHEWOT6kbyS
         vY0gmZ/b8eCfnEJPBwURr/rMCnh/JHpflD5ZEEgxhbIXyxQMx1UOpW4sSFjY6zn2X64u
         Shn25fHInnLQ6+Trwh5LtlOmKcySc8nw3ZYSZkOMvuwQFLlaGc1UMqahITT48gvJkIvy
         36tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C6v859bFrrIc/0ansisyd3RnNZVsRN09YoRowz+ffvE=;
        b=kpP9Bydosl0SXQVmjYKsMSOzZACJVnP/XyJGtwc6OYliSZYcooONHalnkZHfhiIoT4
         F4BmwRfyYXKyCvm4yqefxz3+mCDRsAOy1cYy42KByBMNHG+9Crx+Du7wtf6EWUQX3zb5
         trusjqrveUUsLyFmkXc+krXgZBjC8LbH6FjJ1lLyC7k2d2SkQ0n/rnFr06jzTXcqw2c+
         a7cW2O5opzK/jtNvGy1pd4CE4FTk2FfHwgSYw1RfQN/klpJa7Zs84hfLrG9kY+7JloKd
         FtjJwy3xCSERWyC2qgu0sGhryUK7XF11s0ljxHeozu8mDDiASBpF7d0PrIojJPYVI1Fn
         YCYA==
X-Gm-Message-State: APjAAAWGvk/OKGmsLENqc8XsHafkfRvBhaCTTxMoGM4+6mpKRG3dCFl/
        WCjTHGOw3hM6q+Nt2+gox6g=
X-Google-Smtp-Source: APXvYqzs5vbmmE0GrMlu3q0v1IX4xJMfEXM92k6doLU2KlYwRdSC1BZpsRF+hMkgq/pNZAg36ZPqvA==
X-Received: by 2002:a05:620a:9d9:: with SMTP id y25mr1124730qky.499.1582030524256;
        Tue, 18 Feb 2020 04:55:24 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:1879:5acd:5f30:6da2? ([2001:4898:a800:1010:c9ae:5acd:5f30:6da2])
        by smtp.gmail.com with ESMTPSA id n7sm1799034qkk.41.2020.02.18.04.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 04:55:23 -0800 (PST)
Subject: Re: Git Test Coverage Report (Feb. 18, 2020)
From:   Derrick Stolee <stolee@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <2c97befe-9be8-9946-b643-91656fa3dcd8@gmail.com>
Cc:     Garima Singh <garimasigit@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <d3635fdf-1948-5d58-a1bf-abd5f56b18d1@gmail.com>
Date:   Tue, 18 Feb 2020 07:55:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <2c97befe-9be8-9946-b643-91656fa3dcd8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some notes that apply to the changed-path Bloom filter series [1].

[1] https://lore.kernel.org/git/pull.497.v2.git.1580943390.gitgitgadget@gmail.com/

On 2/18/2020 7:46 AM, Derrick Stolee wrote:
> Derrick Stolee	92667ee9 commit-graph: examine commits by generation number
> commit-graph.c
> 92667ee9 89) else if (a->date > b->date)
> 92667ee9 90) return 1;
> 92667ee9 91) return 0;
> 92667ee9 1296) QSORT(sorted_by_pos, ctx->commits.nr, commit_pos_cmp);

This QSORT not being covered means we are not testing the --changed-paths
option with an input option that scans pack-files, and instead always using
--reachable.

Garima: could we update Peff's commit that originally introduced this QSORT
to have such a test? Thanks!

> Garima Singh	282c08a9 commit-graph: write Bloom filters to commit graph file
> commit-graph.c
> 282c08a9 328) chunk_repeated = 1;
> 282c08a9 335) chunk_repeated = 1;
> 282c08a9 342) break;
> 282c08a9 371) graph->chunk_bloom_indexes = NULL;
> 282c08a9 372) graph->chunk_bloom_data = NULL;
> 282c08a9 373) graph->bloom_filter_settings = NULL;

I wouldn't worry about testing these error conditions.

> 282c08a9 1087) progress = start_delayed_progress(
> 282c08a9 1089) ctx->commits.nr);
> 282c08a9 1112) progress = start_delayed_progress(
> 282c08a9 1114) ctx->commits.nr);
> 282c08a9 1288) progress = start_delayed_progress(

But, could we have a test that verifies the progress is output for these
steps? Use GIT_PROGRESS_DELAY=0 to guarantee that the strings are output.

> Garima Singh	b6d925e7 bloom: core Bloom filter implementation for changed paths
> bloom.c
> b6d925e7 247) for (i = 0; i < diff_queued_diff.nr; i++)
> b6d925e7 248) diff_free_filepair(diff_queued_diff.queue[i]);
> b6d925e7 249) filter->data = NULL;
> b6d925e7 250) filter->len = 0;

These are a result of the case of a commit having over 512 changes. I think
there is a follow-up item to make this 512 value be configurable, and when
we do that, then we should add a test that covers this case, but with a
smaller configured value.

> t/helper/test-bloom.c
> b6d925e7 20) printf("No filter.\n");
> b6d925e7 21) return;

This could be covered similarly with such a test.
 
> Jeff King	dc9f0216 commit-graph: examine changed-path objects in pack order
> commit-graph.c
> dc9f0216 62) return; /* should never happen, but be lenient */
> dc9f0216 67) static int commit_pos_cmp(const void *va, const void *vb)
> dc9f0216 69) const struct commit *a = *(const struct commit **)va;
> dc9f0216 70) const struct commit *b = *(const struct commit **)vb;
> dc9f0216 71) return commit_pos_at(&commit_pos, a) -
> dc9f0216 72)        commit_pos_at(&commit_pos, b);

As mentioned earlier, we just don't cover --changed-paths along with
scanning pack-files, but we should.

Thanks,
-Stolee

