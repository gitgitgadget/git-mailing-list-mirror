Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5ACC2D0C6
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 14:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623BC20740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 14:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7uMLOhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfL0OFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 09:05:11 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46637 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0OFL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 09:05:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id g1so17718469qtr.13
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 06:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZfpOigyU5pqaHk20offcY1fWJupz19wiMxtCyPK4OWk=;
        b=K7uMLOhTsc+dwmk33amzh87AYywyhKLMI/9gigzgACLp+oyZi3VB7juWqyOJ7bmFKt
         k4BKjcYYJ9nzWU1C1e+9c7X5Ty6eFqr+co0a+zHx9qAZc4+3Og47IbPa6+6W4GWdPvy6
         TMOMmF15T0jgs4DMI/QOLq/oQuubYYO+n5vZ6Lj+QHJkCL6rm5QX5zdLjNv8k/DYD77y
         W3rvPjo4QQYZQmcktRBaBGNJ6H01z2FZ0qOe5swgrlD6KPTUzJ/t/uxwV6ELfcyHE27N
         qE0ynAohdUs1HgUPZypWQRyc5f3oqx0AAuYB7W1Gc0XjPI/O6iEvIPwuzC+u5qtkfd3W
         1KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZfpOigyU5pqaHk20offcY1fWJupz19wiMxtCyPK4OWk=;
        b=dDAwNFkSGNh+3hpoehEPRVXYbUa3YV6W1U8gq++95ZaEqtLR8HlQGy6xR1RkRXUmfO
         VArUl7NsszSeQdYctikrMy3sA+cB2S0qrZZuXGeNpLco219Rci29z4jku6wr2dXcb6IP
         wqfzZtzBlqxu6aEPqJ5rfufoHvHAD9Xzlt58MjfTXE5jHdAO25UHrYR8zxTVZJl+rcin
         xpGA3AqP4gJFwVl9bYWdB8tXgg30NE9GCivMLeAfT/Tu/IKCiwZwDfEhHUE958/2G6EZ
         9Ub9Egdd+dAUrg1XxzqwitcPPiPXD1NdLykTB1918tiieAQeBolHmjBi1u8E85E+Y0Ql
         ZXtw==
X-Gm-Message-State: APjAAAUvbPubB/pU88coybbP0oFj/W9LnL4uBjB4dhv4IpYSfMqkQ3W2
        Nwoq0hN6QloHj+V6EYbTR9I=
X-Google-Smtp-Source: APXvYqx3ghqPiYp7eXpc54BrAsqFHnDe1Zk+k+YO11DkoJFsNC3yWmwr/e4iLdluIigUosfqnjwd8Q==
X-Received: by 2002:ac8:2b26:: with SMTP id 35mr38082427qtu.341.1577455509978;
        Fri, 27 Dec 2019 06:05:09 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9d29:38a1:5885:e8b3? ([2001:4898:a800:1010:4e5f:38a1:5885:e8b3])
        by smtp.gmail.com with ESMTPSA id p19sm10812287qte.81.2019.12.27.06.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 06:05:09 -0800 (PST)
Subject: Re: [PATCH 1/1] sparse-checkout: list folders in cone mode
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, newren@gmail.com,
        jon@jonsimons.org, Derrick Stolee <dstolee@microsoft.com>
References: <pull.500.git.1577393347.gitgitgadget@gmail.com>
 <07be7b8dda679d79ac9b218b2a9b08e47d7762fd.1577393347.git.gitgitgadget@gmail.com>
 <xmqqo8vukcqv.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4ecc2696-421a-9b1b-7b2c-335091aa7b08@gmail.com>
Date:   Fri, 27 Dec 2019 09:05:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8vukcqv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/26/2019 4:17 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
> 
>> Subject: Re: [PATCH 1/1] sparse-checkout: list folders in cone mode
> s/folder/directory/ everywhere as the rest of Git.
> 
>> When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
>> command taks a list of folders as input, then creates an ordered
> 
> "takes"

Good catch.

>> list of sparse-checkout patterns such that those folders are
>> recursively included and all sibling blobs along the parent folders
> 
> In this sentence, what does a "blob" really mean?  Do you mean a
> filesystem entity, that is not a folder, that is immediately
> contained in the "parent folder" (in other words, regular files
> and symbolic links)?

You're right, I'm using strange wording here. How about "sibling
entries"?

> How would this interact with a submodule by the way?

I just checked with the Git repo by running:

	git submodule init
	git submodule update
	git sparse-checkout init --cone

The working directory then contains all blobs at root AND the
sha1collisiondetection submodule. Interesting that the sparse-
checkout feature ignores submodules. That seems like the best
approach since the user can already enlist in a subset of the
submodules.

>> are also included. Listing the patterns is less user-friendly than the
>> folders themselves.
>>
>> In cone mode, and as long as the patterns match the expected cone-mode
>> pattern types, change the output of 'git sparse-checkout list' to only
>> show the folders that created the patterns.
>> ...
>> +In the cone mode case, the `git sparse-checkout list` subcommand will list the
>> +folders that define the recursive patterns. For the example sparse-checkout file
>> +above, the output is as follows:
>> +
>> +--------------------------
>> +$ git sparse-checkout list
>> +A/B/C
>> +--------------------------
>> +
> 
> Sounds like a worthwhile usability improvement.
 
Thanks,
-Stolee
