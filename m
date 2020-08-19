Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB098C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB016207FF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTpu6OtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHSPPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHSPPY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:15:24 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28909C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:23 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id s15so11414313qvv.7
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oh3YVAmKYPgbyDR62uPAA1POXRxX0qb3gymexmLmBIs=;
        b=aTpu6OtN4ZGA0LX6IL4MlV2uIpKDm08siKRDmurc9K4DiLppIU5iY4lsHwoRfvZL1A
         OzsLPr6WEgEH1VJa4IVs9leCYGFNCPGhwKhul1SdzMUHL+p4bGFsNmHMBO2lV/T6R+2/
         N6TLQub8zTWW3htift7mwbn8o+2/GOzFvNsCPksr6O59DuEa3DXaU0GVwuYWPszCW4Jm
         ffEYO/kVwxHjcAY71B0ahXuRqDBBBN1vFcZQSuwHRMr77Cd/E/h3ttmAFglpOBAe9DCJ
         EQnUXsDzFT3x807TbRvD7I70K/3/Vk7Blz1JLq6u6/4if/DRfJZHRZaLQeA9dqGZoxaP
         hSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oh3YVAmKYPgbyDR62uPAA1POXRxX0qb3gymexmLmBIs=;
        b=CRjk5apHj90zDfPpMOd6iU7H4VP1Ry5EtkLYjQJmb+TpuYYyW9FCNLKkE/KUzQGS71
         Qm/wR2ed3O8FBI+iOtvvNIxO7sntk4jGsan1+jfuhkgmLoFIkvuHlNX9X/gufPqbwRJi
         wsaK6d9u9L3cvfcWGNlImubSNYzLv/ZMh7nAkG+dKiA+cv6SG0LHOzXDAeccWM3gY4kL
         WBYOcvcQMM/HUn3AcH2MnYgCkanmkq9lBRjBah//txyUJPJrY618mwP9qSQ6m4jKPvGY
         IVxhRNgW9h1Wma+OLaDj2SqRvhaQFrSG6T+jsbpM3eQU4SoD2DtzYeIYFFHSmmLtnj14
         xS/w==
X-Gm-Message-State: AOAM533AVUCd07c4zBFWPSXZsc5XBjxIUPwUzKjqtmZj060V/7Ip5rH2
        RKqTzk+SPkxQwYT6Iknc0O8=
X-Google-Smtp-Source: ABdhPJwK4wpr2UJq1y4Kh21QWK9hvr1tJEYLV0/7upezATT7ChMvISgORRd1IW8wBZB27x5emtA4Zw==
X-Received: by 2002:a05:6214:542:: with SMTP id ci2mr22979667qvb.7.1597850122198;
        Wed, 19 Aug 2020 08:15:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:641b:4ef3:c176:5ed3? ([2600:1700:e72:80a0:641b:4ef3:c176:5ed3])
        by smtp.gmail.com with ESMTPSA id q126sm23578414qke.34.2020.08.19.08.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 08:15:21 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] maintenance: add auto condition for commit-graph
 task
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com
References: <fc097c389a963065fc0bb5991bdebdca8824b121.1597760589.git.gitgitgadget@gmail.com>
 <20200819000947.2844392-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a9f5ca0-73b2-b9f8-b342-a8fff8c938be@gmail.com>
Date:   Wed, 19 Aug 2020 11:15:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200819000947.2844392-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2020 8:09 PM, Jonathan Tan wrote:
>> Instead of writing a new commit-graph in every 'git maintenance run
>> --auto' process (when maintenance.commit-graph.enalbed is configured to
> 
> s/enalbed/enabled/
> 
>> +/* Remember to update object flag allocation in object.h */
>> +#define PARENT1		(1u<<16)
> 
> Why this name? "SEEN" seems perfectly fine.

For some reason I thought that there might be issues using
SEEN (1u<<0) but trying it locally does not seem to be a
problem. I think I've just been bit by how revision.c uses
it a bit too often. The use here is independent enough to
not cause problems.

>> +static int num_commits_not_in_graph = 0;
>> +static int limit_commits_not_in_graph = 100;
>> +
>> +static int dfs_on_ref(const char *refname,
>> +		      const struct object_id *oid, int flags,
>> +		      void *cb_data)
>> +{
> 
> [snip]
> 
>> +static int should_write_commit_graph(void)
>> +{
>> +	int result;
>> +
>> +	git_config_get_int("maintenance.commit-graph.auto",
>> +			   &limit_commits_not_in_graph);
>> +
>> +	if (!limit_commits_not_in_graph)
>> +		return 0;
>> +	if (limit_commits_not_in_graph < 0)
>> +		return 1;
>> +
>> +	result = for_each_ref(dfs_on_ref, NULL);
> 
> I don't like introducing the mutable global num_commits_not_in_graph
> especially when there seems to be at least one easy alternative (e.g.
> putting it in cb_data) but I know that this is a pattern than existing
> code.

I should have done this right in the first place. Thanks for
catching it.

-Stolee
