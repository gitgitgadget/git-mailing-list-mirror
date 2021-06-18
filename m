Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD60AC48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 05:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C82360E0B
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 05:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhFRF6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 01:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhFRF6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 01:58:45 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7CC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 22:56:35 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e20so6937408pgg.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 22:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qlGp3QiKw5STek11YU2PKf5CsvLoW1rzm41FpjYRfoE=;
        b=FYJaZmgiPS+7hA5SFIZ0wtp2LZ0VVoyqfWlB/mbVqq1ZAFiH6YSV6Tm43qr4oimfw2
         oYYkOy4UYowzOdhl8KzsABByMHzuyOSha5R7ZGfuZiA3HeaQKz++qI0srxocpM01e7Ou
         fVkexvFPgsJv2EPx7msvQDFYjnty9iFopRdh1hQdvjksfT74dDMmeO93lghkpSCrsQ0h
         B7+RBtvtxc1T+E1gZrPpJnNLtNcEo7am1aMO1YdSKrxLCkcBt9zU0WiP40Yt6sV6FtTs
         Di289Vb1BMbJgv2gbtxUlaJkIC00mo+/noZ3yscOSUq1y2ffOY3QecKpA0ulZ6FBTxE9
         Cs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlGp3QiKw5STek11YU2PKf5CsvLoW1rzm41FpjYRfoE=;
        b=STiQohOvvxszzUY6rhBYjj2JrP+d4e1nZYreU9ciKisCjSQEPqDgRd8W9knXf03lWt
         llrP5MhD+hGVKcpNlNOCWQT+JEfCQ0YsJBiVujFWDl81zXvqkuefN/YqaUGjPF3CTaXC
         VuU+96+KFOZKUDHsTwqtoG6H79b2C/JbOwPJHUsPnhfSwZ2QHKgPG3uVsNFZLPsnG0T1
         /9jB1bL/Vq7JtYXydjb62++9xQX8klYLbQDH/q5qldnzCZOpqZE1meETFwR7tIWXSKnF
         ClJpouvpXs5toZAZadWc6V9GWOnNmhP9GF0B+IWIZ0uzY5ZN3oWMiGuBerS56xhvPEY3
         78Tg==
X-Gm-Message-State: AOAM530nUJ6SLK13KjMZnK1BUlH2OdZI6YFAHAmdgHTgz/O5mYhhRVoV
        78OxB6zJDXJpC4R6wazgUZo=
X-Google-Smtp-Source: ABdhPJxSljNH6bgnCFwC9hZT3YKrNb1hJHkK+vmDwumw6Q8Loh6p670J4101OY0KsVlwLLHzm1LXOg==
X-Received: by 2002:a63:e64a:: with SMTP id p10mr8409531pgj.424.1623995795261;
        Thu, 17 Jun 2021 22:56:35 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-89.three.co.id. [180.214.233.89])
        by smtp.gmail.com with ESMTPSA id 189sm6502847pfu.84.2021.06.17.22.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 22:56:34 -0700 (PDT)
Subject: Re: Only 27% of reviewed-by tags are explicit, and much more
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
References: <60cc1749b1c4d_5d12520825@natae.notmuch>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <35417819-3b25-e346-436a-a2090a8f8c43@gmail.com>
Date:   Fri, 18 Jun 2021 12:56:03 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60cc1749b1c4d_5d12520825@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/06/21 10.47, Felipe Contreras wrote:
> I think it's fair to say our Documentation/SubmittingPatches needs to be
> updated.
> 

With what new procedure? After any reviews?

-- 
An old man doll... just what I always wanted! - Clara
