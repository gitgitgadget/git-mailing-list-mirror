Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F2DC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1712253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvTnK2on"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLMWxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:53:44 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39308 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMWxo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 17:53:44 -0500
Received: by mail-pj1-f68.google.com with SMTP id v93so338963pjb.6
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 14:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1nNWLvRudj2R8fxeqfLpCEh/jTTAUq6rfF55f68OlN0=;
        b=YvTnK2on8JwY4U8Y9cROKvKtMdtpIUYMedl7hJZHHapsc0JwZXJPf2QA5EQIGsZEKo
         qfZ57MuPIz8uWs5yNp6/TyOWGG5CFeQGimUK/ZGNiBxPDwBEiR+KLKHp0GqPERMRcDVa
         q2x+4d5gV4mdjLBKuS2g94iFa7UNta3am3896yHUFcZqDnMRRKoz1Y1Id1YsB6UQOzjh
         M7TshanZqEaVfXONhnX7ZLlcm23fFJjGwv2ZqBngmkFPsYmXS2WCzblFWfba0Eacohkx
         HJFYkuXpnFHqchTgeyZL1Gv+xrTY+10tZc6Wbg0eq+NjIbjRwkjJGEDE9vcHLz0PKmYG
         G+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1nNWLvRudj2R8fxeqfLpCEh/jTTAUq6rfF55f68OlN0=;
        b=pbm5Tjt9CDkGseID//ssDMues13zPqC6XTTF79OKwKhPCs6wHGbPmy75ar1JiJLlRD
         ypnzGs3btOb/+RQRtN8oN6tJmvWyySvV47cvyuWMJQntREaJp3tpiilcGaSxXhdWQaVD
         5xpvN0UK6uGXs+WNDSchLgl5RpMuatnFABtO6o5QeeAjePmEQVmXTYCUbRTrr7P9kRZx
         W8WOaJSs4O9vS53yVCsC6IFRF3EjUlfaxUfW6AIapuN5DHKd4N6vnGxmIRsZ0k63GD49
         qgGPojgicmagRnH6/rcItGvbgs60JZgSZXjO0gy1thh7XX2Hrjzexb25Tn70k+IBsbfC
         /qbA==
X-Gm-Message-State: APjAAAW9gEBeD/YeQTeRtDNkdtJMXpd1n402l88tZ4BVQgr+KtU2up3l
        TuOGIWAQeIKbGNytwzpGN8g=
X-Google-Smtp-Source: APXvYqxsxKk1ymzj6VoKO3aVzCZzLwa5VyTfCd2WQZoQGu5FReVVFgF5QbLtMKdbAE7Zgi/JECOK5g==
X-Received: by 2002:a17:902:968f:: with SMTP id n15mr2060392plp.12.1576277623523;
        Fri, 13 Dec 2019 14:53:43 -0800 (PST)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id 11sm11341691pfj.130.2019.12.13.14.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:53:42 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:54:44 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/4] git-p4: yes/no prompts should sanitize user text
Message-ID: <20191213225444.GA31452@generichostname>
References: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
 <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
 <6c23cd56842e76e5c11f32ba59fd7729769ab4b7.1576245481.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c23cd56842e76e5c11f32ba59fd7729769ab4b7.1576245481.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Fri, Dec 13, 2019 at 01:57:58PM +0000, Ben Keene via GitGitGadget wrote:
> From: Ben Keene <seraphire@gmail.com>
> 
> When prompting the user interactively for direction, the tests are
> not forgiving of user input format.
> 
> For example, the first query asks for a yes/no response. If the user
> enters the full word "yes" or "no" or enters a capital "Y" the test
> will fail.
> 
> Create a new function, prompt(prompt_text) where
>   * prompt_text is the text prompt for the user
>   * returns a single character where valid return values are
>       found by inspecting prompt_text for single characters
>       surrounded by square brackets
> 
> This new function must  prompt the user for input and sanitize it by
> converting the response to a lower case string, trimming leading and
> trailing spaces, and checking if the first character is in the list
> of choices. If it is, return the first letter.
> 
> Change the current references to raw_input() to use this new function.
> 
> Since the method requires the returned text to be one of the available
> choices, remove the loop from the calling code that handles response
> verification.
> 
> Thanks-to: Denton Liu <Denton Liu>

Thanks-to: Denton Liu <liu.denton@gmail.com>?

Anyway, it's probably not worth a reroll. Aside from that, all the
patches look good to me from a Python perspective.

> Signed-off-by: Ben Keene <seraphire@gmail.com>
