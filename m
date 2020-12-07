Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEDDC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7311B2389A
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgLGSq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgLGSq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:46:27 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47AC061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 10:45:41 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id g19so7018184qvy.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 10:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ui/p6KjBhcQHKxr312vQ+zZOLrVei6ZpTBzXWoQ13p4=;
        b=pWQzSDiX6i3Fuu+twqgsVY2uCtJ8wS4j7Lr0XH5xDpYnRKKMNSjK8Js+aTZXFq4PhO
         3FQBBGLBSNKRq6yW64H91KPpkKJpJBRQokfH/hoz2kipIAHzSi0pzsVGVoukZydqIiVm
         s7JKzpFhov3+Wz5iYKYdm/MtULQ0hmwL9eglWHSNafv3Q/ii9QDFn4zs55GfoFEriLER
         uXOK0Djw8Exw2GjTY978r8enK5OZq/hLlDtXzDK4sm4f1lD+Xbi33xlxkFFhsV2DHFUD
         SHN5vJxFKSb9qc2axiwdCI0F88rbtg2waQq60OVd4wp/6LxgwRKaiZ0C9ErWyrGczIjV
         0edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ui/p6KjBhcQHKxr312vQ+zZOLrVei6ZpTBzXWoQ13p4=;
        b=tMlYKQeW1Is/lLlskaBIGCwuKP34pzBvpV1P19danNlF8fRC22B2bOB8m9COKaGkDO
         7TUoAdrFWHRfwlVE0sr7KCPFOU6JXfjJB/IDe1W1aisH7z0kfgjlLCvgOlBpNztVY1h1
         lvW/xkgcgqmKtjWgB0stoi4JixB2M49jE1IaZZPHrse6HpIZRV0SPlZch1n1tpOklRVZ
         hQo7K8bq2PasNvo/1z1rMMNaTTYL4qSBGKJ2vcfWC9zXWOLWDHLVGQ9esHag79c1Z5ko
         aa0Fr0XZVjfXlsfAemiAPJowyiXNMdNqypiBDe8H4yb+yErV6unMEU3koJNu3Z+4M5fE
         AP5A==
X-Gm-Message-State: AOAM531n92ZnDg+xB+Z+GJI1AczIScOrubB9VtbggHeSHaC32xOyuv8u
        1emDs3OJZIq85vuf5U7HrgU=
X-Google-Smtp-Source: ABdhPJzppnmzg0Rv/1kjmc6EdC5JYQCgMBaN3ZnqDfBu7sS3e64hqIslfrU1c/ALnjRAZZf6fF/9lw==
X-Received: by 2002:ad4:4761:: with SMTP id d1mr9307860qvx.12.1607366740383;
        Mon, 07 Dec 2020 10:45:40 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02? ([2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02])
        by smtp.gmail.com with UTF8SMTPSA id e18sm1493973qtm.4.2020.12.07.10.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:45:39 -0800 (PST)
Subject: Re: [PATCH v2 23/24] pack-bitmap-write: relax unique rewalk condition
From:   Derrick Stolee <stolee@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com
References: <X8fBHz2A82hxUzV8@nand.local>
 <20201207181909.3032039-1-jonathantanmy@google.com>
 <2f0540e6-b4f4-ea9f-bac0-ecf92c7b764d@gmail.com>
Message-ID: <4bcb8636-54f3-e98e-d4f3-c86f15edc0c9@gmail.com>
Date:   Mon, 7 Dec 2020 13:45:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <2f0540e6-b4f4-ea9f-bac0-ecf92c7b764d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2020 1:43 PM, Derrick Stolee wrote:
> The very next patch "pack-bitmap-write: better reuse bitmaps" fixes
> this problem by checking for computed bitmaps during the walk in
> fill_bitmap_commit().

Of course I got confused and instead I meant to refer to the _previous_
patch, "pack-bitmap-write: use existing bitmaps".

-Stolee

