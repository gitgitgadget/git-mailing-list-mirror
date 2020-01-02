Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F499C2D0DC
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 16:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E80520692
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 16:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELb8mb0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgABQUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:20:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33738 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgABQUo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 11:20:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id d71so23881890qkc.0
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KilvoztEBoI3Z3xHH7lYSrL8Pg52Aun3FMvAk3bNMJQ=;
        b=ELb8mb0gZu77SDeKprfg733GtTs8Fy8SHmfpSOZwCRn+ckt/rZdMTctOuQ+3XaXQgN
         VwFjzK9RKXKh5UTsT87BuOy9QRKMaQr1BoOkbI8R5DcHN5l3QZL9VuhNMhRU5nAMT6N3
         OA87s2cXPbwwLVlMD6l7Lv2hNXUFBvOwSc0P8PhtfqTg9OwzFHM9bmAbSEl/FS8M9iOQ
         pffJOOzNSQPH5BTLys3tGptBTJFky9yZmfRAyCf/y11AmcAxmvI5E57U0yzaxI045uAN
         /Xl0TlNniYoNVbtlX82stzmgdHI/VZ1vd10ExgKI2Ni7Xs70Cgq+9TkNfSig14WIA7/t
         XnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KilvoztEBoI3Z3xHH7lYSrL8Pg52Aun3FMvAk3bNMJQ=;
        b=M1BqU3hxkI2DoE4HrooOjlSelURxhhZJNdqhEBLCboaVhwd+iYjWCqAp1kOFd+/daA
         DGtlHLamNQvMxjcPQnm4yRZmfeIAMu/8i69shvDedlwfSyBECR69+3nqgqOhBf0N75xh
         CaV5J8/rRNrv7WGCsZRHIUCxvXJMXIpHMnr0U37uNiLPK1h6VqCumr86k/Bq1vQKooFB
         BiQgRV/CyeMcFaTSWD8fh2JgdhEfPz5a621k1OAMBBbNWTlNZHmr+S/viNXNEerDhfXd
         dTv5ZVFqZ0bs+K0V+QQeEpnGxch+HZn4rRXSOhaBS3aQEF2VpjjO4z3FHvrgw22HfHGX
         1zaA==
X-Gm-Message-State: APjAAAVsGz1MiPVt6qjmZvuFRqZ+Bz1A9aaEB7N+QgT2np8UPVFn7zFf
        8J2buJrS3PQKZf7IoKRH5dE=
X-Google-Smtp-Source: APXvYqzsXAf/uQjuG9An42F9QXfECoMKznUZIFvD2yU3T1Qeh2QBbxvPwA4XGB6Kwpw7nhYLybBiEg==
X-Received: by 2002:ae9:f506:: with SMTP id o6mr66599609qkg.41.1577982043155;
        Thu, 02 Jan 2020 08:20:43 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:7502:35eb:2949:f0f6? ([2001:4898:a800:1012:2636:35eb:2949:f0f6])
        by smtp.gmail.com with ESMTPSA id v5sm17090246qth.70.2020.01.02.08.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 08:20:42 -0800 (PST)
Subject: Re: [PATCH 1/1] fetch: set size_multiple in split_commit_graph_opts
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.509.git.1577981654.gitgitgadget@gmail.com>
 <91d89356a20625d04af74d458c28b32445e760c1.1577981654.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a6dfda23-541c-14ea-fd72-b71fa782d3c7@gmail.com>
Date:   Thu, 2 Jan 2020 11:20:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <91d89356a20625d04af74d458c28b32445e760c1.1577981654.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I was writing this commit message, I changed the plan for how
to fix this. Originally, I was going to set size_multiple = 2 in
builtin/fetch.c, which is how the subject line was created. I forgot
to change that to something more like:

	"commit-graph: prefer default size_mult when given zero"

On 1/2/2020 11:14 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> In 50f26bd ("fetch: add fetch.writeCommitGraph config setting",
> 2019-09-02), the fetch builtin added the capability to write a
> commit-graph using the "--split" feature. This feature creates
> multiple commit-graph files, and those can merge based on a set
> of "split options" including a size multiple. The default size
> multiple is 2, which intends to provide a log_2 N depth of the
> commit-graph chain where N is the number of commits.
> 
> However, I noticed during dogfooding that my commit-graph chains
> were becoming quite large when left only to builds by 'git fetch'.
> It turns out that in split_graph_merge_strategy(), we default the
> size_mult variable to 2 except we override it with the context's
> split_opts if they exist. In builtin/fetch.c, we create such a
> split_opts, but do not populate it with values.
> 
> This problem is due to two failures:
> 
>  1. It is unclear that we can add the flag COMMIT_GRAPH_WRITE_SPLIT
>     with a NULL split_opts.
>  2. If we have a non-NULL split_opts, then we override the default
>     values even if a zero value is given.
> 
> Correct both of these issues. First, do not override size_mult when
> the options provide a zero value. Second, stop creating a split_opts
> in the fetch builtin.

This is a correct description of the actual patch.

Thanks,
-Stolee


