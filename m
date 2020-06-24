Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB2C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 23:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC77C2078D
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 23:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYbDP8lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbgFXXdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbgFXXdA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 19:33:00 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DB2C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 16:32:58 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g7so1919722qvx.11
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 16:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N5niTNvILZIe3247dXEHKWfE+0gRo9BckREUqYeb2F4=;
        b=GYbDP8lDlT6lTJCiutn3dx87W8YeT0/iqTOR0XW73u/K7ZibiO5UpR2ROXJjTTEeLQ
         0kmrMuk27GPnPpnmICMhJ7un/oawhuPbj5YnN8rBjpXjd8BOOCN/LYS6GQXcM6/YBUc6
         xWTvrAxgQY3oxGr+2g2BMDypE8I7IQ5DW6m/b7t0XnQWREp8/vSreFGzlq5ChEdAzUFE
         UXrCy1m+fGuDtjGzDj5zbYq8yG+ZsEfAR6l0lzOx/32/iBaEWd4jjVnZBMiPhaaoF45i
         5HrPCkXyGWbeWmO7fgVji4TnaguKwn07tIqIgsfV2FvfFXKLT6vniMS5arRNVNBWncX5
         Xm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N5niTNvILZIe3247dXEHKWfE+0gRo9BckREUqYeb2F4=;
        b=qUeVkiiteWIt33dTDqfpuLTRqoqDxktwGfZNZZjumUlgDT5yy0GUqx89MlR/pAtOB2
         fGHErW2IqRA0cITZf+ih4KNgKEmkxf6dQMv8QxxYjYepbseoLZLxZHwboMiBGaOahaJ6
         ELG7lRavPn924R+/0omtcLtKdc3pEL8UDr50U6jFIq2tZWzqq8WV/+WLqwniuU7MX6el
         /k9E0lDvJ9T51sk47/W2TITUjR+TUzsiiWtuxlSyiHL9pa3HMvF7lNwDZTwBciwb85ub
         dhX5S4vnRpKO+CXLETmNMieSyghEZuV9gTB9k+0Wojym1bMbgHhcUtPMjjOe87LP6izx
         jaPg==
X-Gm-Message-State: AOAM53012ZCWUJsJqAYzICPsqF4Egt84WN7ccsJRlCeO8ISZe+CQniIw
        J2IJwEANoalBA0bjXEF/fCE=
X-Google-Smtp-Source: ABdhPJyxCj52ctXx7DaABu8rfVE9tkYCRqtGzzcLuEaynAQ7YMBy3riaxvazF/bJVxW4FmAP1Eun2A==
X-Received: by 2002:ad4:580e:: with SMTP id dd14mr17107105qvb.96.1593041577685;
        Wed, 24 Jun 2020 16:32:57 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 195sm4613494qkl.37.2020.06.24.16.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 16:32:57 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] More commit-graph/Bloom filter improvements
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, szeder.dev@gmail.com,
        l.s.r@web.de, Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
 <xmqqftak5aa0.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <429f38a2-9346-f6f7-bd69-2fd63828ae7c@gmail.com>
Date:   Wed, 24 Jun 2020 19:32:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqftak5aa0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2020 7:11 PM, Junio C Hamano wrote:
> This does not seem to play well with what is in flight.  Tests seem
> to pass with topics up to es/config-hooks merged but not with this
> topic merged on top.
> 
>     1b5d3d8260 Merge branch 'ds/commit-graph-bloom-updates' into seen
>     32169c595c Merge branch 'es/config-hooks' into seen
>     ...
> 
> $ sh t4216-log-bloom.sh -i -v
> 
> ends like so:
> 
> ok 133 - Use Bloom filters if they exist in the latest but not all commit graphs in the chain.
> 
> expecting success of 4216.134 'persist filter settings':
>         test_when_finished rm -rf .git/objects/info/commit-graph* &&
>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
>         grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10}" trace2.txt &&
>         cp .git/objects/info/commit-graph commit-graph-before &&
>         corrupt_graph $BASE_K_BYTE_OFFSET "\09" &&
>         corrupt_graph $BASE_LEN_BYTE_OFFSET "\0F" &&
>         cp .git/objects/info/commit-graph commit-graph-after &&
>         test_commit c18 A/corrupt &&
>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
>         grep "{\"hash_version\":1,\"num_hashes\":57,\"bits_per_entry\":70}" trace2.txt
> 
> not ok 134 - persist filter settings
> # ...
> 
> Thanks.

Thanks for letting me know. I'll investigate carefully with the
rest of the 'seen' branch. This test is a bit fragile due to
computed values for which bytes to replace, so anything that
could have changed the length or order of chunks would lead to
a failure here.

Sorry for the disruption.

-Stolee

