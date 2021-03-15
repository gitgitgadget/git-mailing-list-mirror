Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1736EC43333
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B755A64F2A
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhCON5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbhCON5O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 09:57:14 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926A3C06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:57:13 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id n79so31682012qke.3
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/H1d/ElgBasviBSzYElrHMvd2gGz++gpQx9/pIoqlq4=;
        b=OHSyMONEY9dCcA9vFxuThgHgT9E9CBGgTcmeofevUtRzm5tmMYdqmhOY6Z73WPga1r
         iKWDdRfUm88BIWtFhfq5x+BHaNBC+pUgYtnr0NRGMAeug00r13IT1VOByZMSbrUuCFrZ
         UBTGQMsO71hffJ5JLJmNxtSNtKNK3xd56N6b4wHlZedVN+Tr8cr4+5TqWNFrrPCi9cLx
         BYx2GNGmUM3dbJIDsypXPevyubme1xp5leSlvkOr+CfgDT+XcGH6twj8lO97wsdwNdBZ
         /Oun+FNhPS5lPfm3z/T/5mo5iNtssQVz3oq/EZx44HwPreUcndo9nXlyY8mi1h1KwW7H
         MPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/H1d/ElgBasviBSzYElrHMvd2gGz++gpQx9/pIoqlq4=;
        b=pIzGW4CxaI8f4n5W+Uec7j8lLq0RlUS2Ncg2bZ7iT+toe56rn7ucNOOLBSkYaV2r1j
         fxABv6IIdFrQaPDT1kI70gpgTk499UAeBRn8zni/qUZt5WAkIgbWA4MfzsmUv1Sgj/jR
         28kIOwRWQQzUNgfeFbPUscAOKTtlbetrCd2uz1WiuLaqLIVq/VKvpI31rdURnBW1QZSg
         EQExvzi7v0/fRA4CsHJNJovu9wPRs83dZeCqqOmw34/5ekTu1jk17qn2UP7FA60DnFs6
         W3veRhCfkv/lIsS5vaIFR7BCvLBl/neflt6NvqzT36y6KndIqKHdcsuZfZ6Bezx7jWI2
         PLUw==
X-Gm-Message-State: AOAM533fvrAFdY2zH4YCAiR/7wDcu8TGYTNc/0KJDOE+wJ8YxDF7kO+a
        D1dozXLjz6m6cCT1fR2KM6w=
X-Google-Smtp-Source: ABdhPJyC+TNV9gXwiVTUxLRqL0uq8SEr35Zb3zrDqrcmDhjoAdcovz9eBT1zADYJesaoVdOL5j0w/g==
X-Received: by 2002:a37:89c7:: with SMTP id l190mr19207914qkd.361.1615816632803;
        Mon, 15 Mar 2021 06:57:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:44e0:e2f9:fa7e:56fa? ([2600:1700:e72:80a0:44e0:e2f9:fa7e:56fa])
        by smtp.gmail.com with ESMTPSA id t2sm10899799qtd.13.2021.03.15.06.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 06:57:12 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] Optimization batch 9: avoid detecting irrelevant
 renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.845.v2.git.1615248599.gitgitgadget@gmail.com>
 <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4aed9cc6-b133-b398-353c-9618439c7b8b@gmail.com>
Date:   Mon, 15 Mar 2021 09:57:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <pull.845.v3.git.1615423111.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/10/2021 7:38 PM, Elijah Newren via GitGitGadget wrote:
> This series determines paths which meet special cases where detection of
> renames is irrelevant, where the irrelevance is due to the fact that the
> merge machinery will arrive at the same result regardless of whether a
> rename is detected for any of those paths.
> 
> Changes since v2:
> 
>  * Added an extended comment about filtering order to the first patch, to
>    address Stolee's question
>  * Added a new testcase that will fail if the critical "if (content_relevant
>    || location_relevant)" check only checks for one of those two or the
>    intersection of those two, as suggested by Stolee
>  * Fixed the other minor problems Stolee pointed out in his review (stray
>    newline, wording of comment)

Thanks for these updates. This version works for me.

-Stolee
