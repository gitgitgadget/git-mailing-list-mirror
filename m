Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890FEC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 20:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552D62173E
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 20:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+BCc6sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfLLU7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:59:37 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36873 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfLLU7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 15:59:37 -0500
Received: by mail-qv1-f67.google.com with SMTP id t7so1541490qve.4
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 12:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8IKcDO5O/yPRMZidFgDFLYcax88bWmLDx453ZH3xQoY=;
        b=H+BCc6sYyh94jeM02LBtvGg+uG05xmkXLCas9/+neMfKzy3dNvddr3ialqEtUgS6XH
         o92G57qsGvhh0jZ8bS2+zjqNzWXr5ZBbfyHGTghyYyFhhJ/lUWbMQ7bekKNJ+A3mc4QV
         EG3q9fKakCQPuUL2OKkktE0lqfTd4cuOqnXO8ogn1gWSEzVVxEF4jG0bZv9xDLA1NNK7
         Tx983pzXbh1/UeB0VI7/hKrf6gnSa8pN1FFa3/bmYZltQAjr9ZGR5ABAtezDc4QftIW2
         JgsacY8bJADtdJ5Q5TcnszWtNShdnOw5KIrxUaFZSfNaaV+JrebcEYImEjrQPiOSMPgx
         cPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8IKcDO5O/yPRMZidFgDFLYcax88bWmLDx453ZH3xQoY=;
        b=AQ1R1QcZ0ytSbxXK5DToB3EJP8DaJR/CBHCdxlPDXIk7WAwTz1zWU92r23OcITZCoz
         0XNOCnewT5zkiys8UH3PP80Eb5ayBhDfqlPuSXCXLlQ9guQDYAnbarvQL7mv0YdtHA/O
         w3W7tR20yGaOEwegBW35pLcjjrPbq/2i1AdNqg8/zofHndXcAIFqh1NfbWpj98NgWI3e
         WWjGbxN83R7JlWzLvmu4L04apMlef/Joa4HBQRWs4/6oLUYsJn7iohhVZn5nEcS+aIcP
         6O33UWoUa1sSjYKerSSrTnOZfylb/z3o4s3tEkrWQk2EecgTZP9R5QaEPAX942TLJKWu
         xC+g==
X-Gm-Message-State: APjAAAUXMJ20jyorsy6hy1iUS+LGjtb25PgK+NSG8zHPReQ7J8O3cJdY
        jNAB0L0gdDzWoOKxQUa1sVc=
X-Google-Smtp-Source: APXvYqxQiPq8JUUcy5I+shxanIzPxUeeoKw6Ttu0Rtmgyg0YT9u1XJNZv91SmhzB/kIhl1h0F+2mXg==
X-Received: by 2002:a0c:d0f1:: with SMTP id b46mr10147564qvh.188.1576184375849;
        Thu, 12 Dec 2019 12:59:35 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:8c1c:80ae:ee57:99af? ([2001:4898:a800:1010:3d52:80ae:ee57:99af])
        by smtp.gmail.com with ESMTPSA id k73sm2128031qke.36.2019.12.12.12.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 12:59:35 -0800 (PST)
Subject: Re: [PATCH 1/1] sparse-checkout: respect core.ignoreCase in cone mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.488.git.1575920580.gitgitgadget@gmail.com>
 <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7aeb1589-cc08-654f-1bc0-d48fec1c0729@gmail.com>
Date:   Thu, 12 Dec 2019 15:59:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <23705845ce73992bf7ab645d28febebe0a698d49.1575920580.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2019 2:43 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When a user uses the sparse-checkout feature in cone mode, they
> add patterns using "git sparse-checkout set <dir1> <dir2> ..."
> or by using "--stdin" to provide the directories line-by-line over
> stdin. This behaviour naturally looks a lot like the way a user
> would type "git add <dir1> <dir2> ..."

Junio:

While I was updating my GGG PR [1] with new logic, I see that you
added this commit to ds/sparse-cone. I didn't intend to these
to be in the same topic, and I was hoping this discussion doesn't
delay the other commits in ds/sparse-cone from merging.

If you have a plan for that branch and the merge status of those
commits, then I'm happy to re-target my PR against 'next' or
an equivalent branch.

Thanks,
-Stolee

[1] https://github.com/gitgitgadget/git/pull/488

