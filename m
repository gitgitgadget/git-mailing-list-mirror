Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E953C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A62424656
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 22:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUtBj4TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgANWLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:11:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45468 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgANWLI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 17:11:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id n16so13426354oie.12
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 14:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L5hcs8Eq9cull4vKQ0H/eKV3fCK6V3cYROI0j+lJSwU=;
        b=UUtBj4TPpglIWIZxKtS/M7XKU7G2FmucseofJkFLJ3nSh9A4/0XguWveNodNJU5Dae
         tpxZ2COfO0/gm8j54Xg0HN2KgieM/V72w83uqlz9nU2ZEUEjRzfiM3+/5H5zrssX1UTX
         H32EDJ7luh8cyS6FcdA9tQKg6CuIrFSCnLiU6AHHJ34dXG6vujprDt+Q8EqvxPkUkCy+
         z0csfIk0krj7q1WQEAlLyQ4Byv1QUepZOj5nL/Hwh7fWwSHIRlkcnYTgKU2fl2SeKbFO
         IVPQTLN7/wdXXuOLxyWus/K+kfI8x7iFQRzjtRTvQA4tGgAokjtfuGBmOebDOaMinojp
         +IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L5hcs8Eq9cull4vKQ0H/eKV3fCK6V3cYROI0j+lJSwU=;
        b=Amo35OcyR+xbpdwhzKtcmgz0xZBQ5nqMHUYN+ZhPzcoscdH/l4VyEp41tYCNzwdkM0
         jrj5iHYeFxypNR9Twug4LZAZ1z3ZiARYL2q5rqctEWVJvNL/smMuws3VNifhYBQNpPud
         UGRKPSFP+/8QG4g2hvM/r2a1neB8iSxHKPIcVXwgxQGof5GdStjzmkK4AYUibpQRg/03
         cmcxN0Cn1x6REGqHuh+9CQ7EgavJWYfDlIdZe22EU/4n8RXqdHptuyhtTKKvxzD6Z4Gx
         Y254/RBgFrEpvqgL9f3xHtY+J/L2NHPRMdVhE4Kzp+QVeSaA83J8rnjgYreI+3DGUqH/
         76Bw==
X-Gm-Message-State: APjAAAWVReVxCXYZCaLF+969KB6hlhuHuJMh4d7d77sTMJ6jdsDQXawT
        JcPftkeFfTUOD8MlaWWzOeA=
X-Google-Smtp-Source: APXvYqxFy3WtVdNCyE5/pl4Wxyebjjtzb98F9aLNZKIhFab84/pqfqm8eH0aP0YXPYKdYveSuvYbpA==
X-Received: by 2002:a05:6808:3d0:: with SMTP id o16mr18580634oie.79.1579039867967;
        Tue, 14 Jan 2020 14:11:07 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s24sm5015983oic.31.2020.01.14.14.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 14:11:05 -0800 (PST)
Subject: Re: [PATCH 8/8] sparse-checkout: write escaped patterns in cone mode
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <79b6e9a565fde766954d7cda84a835b9015af6cb.1579029963.git.gitgitgadget@gmail.com>
 <20200114212548.GD3949560@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e325daa4-5a26-3652-5f46-06203403e51d@gmail.com>
Date:   Tue, 14 Jan 2020 17:11:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200114212548.GD3949560@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/14/2020 4:25 PM, Jeff King wrote:
> On Tue, Jan 14, 2020 at 07:26:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> If a user somehow creates a directory with an asterisk (*) or backslash
>> (\), then the "git sparse-checkout set" command will struggle to provide
>> the correct pattern in the sparse-checkout file. When not in cone mode,
>> the provided pattern is written directly into the sparse-checkout file.
>> However, in cone mode we expect a list of paths to directories and then
>> we convert those into patterns.
>>
>> Even more specifically, the goal is to always allow the following from
>> the root of a repo:
>>
>>   git ls-tree --name-only -d HEAD | git sparse-checkout set --stdin
>>
>> The ls-tree command provides directory names with an unescaped asterisk.
>> It also quotes the directories that contain an escaped backslash. We
>> must remove these quotes, then keep the escaped backslashes.
> 
> Do we need to document these rules somewhere? Naively I'd expect
> "--stdin" to take in literal pathnames. But of course it can't represent
> a path with a newline. So perhaps it makes sense to take quoted names by
> default, and allow literal NUL-separated input with "-z" if anybody
> wants it.

This is worth thinking about the right way to describe the rules:

1. You don't _need_ quotes. They happen to come along for the ride in
  'git ls-tree' so it doesn't mess up shell scripts that iterate on
  those entries. At least, that's why I think they are quoted.

2. If you use quotes, the first layer of quotes will be removed.

How much of this needs to be documented explicitly, or how much should
we say "The input format matches what we would expect from 'git ls-tree
--name-only'"?

Thanks,
-Stolee
