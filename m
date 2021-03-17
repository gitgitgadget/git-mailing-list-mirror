Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E5C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4810264F0F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhCQUWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhCQUVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:21:35 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E72C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:21:35 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t83so239412oih.12
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fZGJfViZnRInBhqT6LBoG8jLK+xoj4vOJBNRrFOm2Qg=;
        b=UgPYl5rvuVJjO40KncFUYVic0pSzb9UA8fTjIzk3P5PYIPWlPLW1NL4/njGq7/xlVg
         QFglPSTBKwYNQVig+0TCkbp4NojFN0CLuFCiwODaJdjy/kXIU06sP5FJwTitkUWcYGq0
         n9EIX+d8xfiVSzLYuKS/TvZFlYu1b5sdy08CW/m53DvFUoXDisWRyAsy31LBF1uRkKfp
         Ze2ehuj1TqgmOX1ox0rmdWFC6NRMVGaaMgfmO3qg+9KQAr5kSdbtxXjgyb6mXHO47v6q
         jnkYxrAE6eH7Zbl2b9nbMHr+zG0eUTCnVzeGXQQqxvLuwOdTcjs7vDUpS5E43pyYC3Bb
         MWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fZGJfViZnRInBhqT6LBoG8jLK+xoj4vOJBNRrFOm2Qg=;
        b=p0LtFyd8KdklygcteyvZoiYAYRMLPWnz1ShYpdrgMVcNOiqisNzxIJ5WspM+qA8juf
         lUeOeHLwTKVWhehPSfhdgTJyGCXU+qm3pdIjeT+Wywhqypmv60njpGLVD56w6l9jTyxH
         0GZGM0ct3n8Qem9GutXVQMlYYZ6hNEmylfQoXCN4Xrqk0UpYLF0AjKY9UAzzMwSdCX6e
         MnU90YTnYtvvkY22lbRAPE5s2rK1NEr4UYZxHxecqZ0Dw4cx2ALqYLOwNk0J2+whjLTb
         PWJWkt0f5Tko5ODdqovoNB2bU/vb/hLcUG/Da4lxyQEiLcUImAxjaYp8bgDV+0BOoS+J
         rvow==
X-Gm-Message-State: AOAM532LvG+fPDGoz9wGsferOqgOeSLgjUL5Sihz7nnFoMKks+gHwN+H
        aXzBxXyI+xwZ9VUZNq0zu0Y=
X-Google-Smtp-Source: ABdhPJwXyC6zkoLTE6XdH3YvF0RQyUTQaPVFp8xR/DBklkaa36VWnMT9VCS9rUg/kLiOjyl8OnZcIw==
X-Received: by 2002:a05:6808:b21:: with SMTP id t1mr449321oij.35.1616012494458;
        Wed, 17 Mar 2021 13:21:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id n83sm11755oif.18.2021.03.17.13.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 13:21:34 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix memory corruption with FSMonitor-enabled
 unpack_trees()
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.891.git.1615995049.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07a368ee-6b45-a401-32c3-c052370150f5@gmail.com>
Date:   Wed, 17 Mar 2021 16:21:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.891.git.1615995049.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 11:30 AM, Johannes Schindelin via GitGitGadget wrote:
> While dog-fooding Jeff Hostetler's FSMonitor patches, I ran into a really
> obscure segmentation fault during one of my epic Git for Windows rebases.

Thanks for dogfooding!

> Turns out that this bug is quite old.

A little over a year, yes, since the v2 hook was committed. It's old
enough that these could be applied to 'maint'.
 
> Johannes Schindelin (2):
>   fsmonitor: fix memory corruption in some corner cases
>   fsmonitor: do not forget to release the token in `discard_index()`

The patches themselves are correct and describe the problem well.
They only show up during non-trivial uses of FS Monitor and index
updates, so I understand your hesitance to write tests that trigger
these problems.

Thanks,
-Stolee
