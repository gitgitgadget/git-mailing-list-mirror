Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B751C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3A421D7D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 20:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA0dc8cc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAWUCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:02:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:47097 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgAWUCr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 15:02:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so3455657qtr.13
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 12:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5OdzYLKeJ0Bib/+pbcWlImk8M1OXK8AFZzlndGcui64=;
        b=LA0dc8cc2e8N4QhiCPg61R/Kz5jJ3CmjZfQPMdawkLrXVvjIQdlsG91CaXNGmhkgE/
         5IWE2XcgkERYv/Kkdsu2BtLqgWpFNn+ZMXBSl7757Bf69Ol3zGqBWEvu8rlyHSN9rQkq
         Ufj/qc908UcHnrz7OWk+X+F2MP0muNeum9MmJxZZ3BTJwIf3Du/38/pZTHbQ4mY+ZPor
         EL4O+CYEIobeSsbrILAWBkf7zuyis39mu9uMKmCP18fpdY3vv8gn7ijLxcx5L5AQqqig
         8ro3TloHwtxoPpdBP3nATI8cpE+/6pB8Dt2xU4sH4NOy/UrpcrDp9+uz33M8qvdSp51Y
         ASQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5OdzYLKeJ0Bib/+pbcWlImk8M1OXK8AFZzlndGcui64=;
        b=f+2fYgW0xSwZzol+bcaCpYiSKY6hAhb5Ad30pabbdNZFpKE37KpVvu5JazkEf/hLXN
         hjWB0v0kXLSmf3QJIdF8LlzY+c/XSi9Qe/LxzKlPBqZEb9ZpuULI+AGj/LpDwTRfkIel
         wVp+aZhCJu8uXZvH3JQKh3Ji5nqs9MaxPFavMvAfxOdZGc+LrmMV7wqvU+doYrHhfJR+
         +tMBgqcRfqWb9hAjmEDPJtT8Awir8ez9VTgqR+m6Sqo6hY2apFfcaRf1uHQk+6dtV3Ul
         vsG4yyJywQn/fWiOcQ9uPPFDFDDC7yfi+OEjukMuImS+GhZ5qfZ6rqmUgymGTVGS4zov
         qq4w==
X-Gm-Message-State: APjAAAVw1ibqgcxTEZYErsAC0Sy/HSUSGxHCYCwAsrw7JKa9vefvStgI
        886p+Gt2NQXZgmDhl+yT26c=
X-Google-Smtp-Source: APXvYqzisoFn53Jng3S1Glt822/1pabpPupB3SEriz5o1vmMkdTZZR8Jj4sI50DoTmOtPbw2ba2PXw==
X-Received: by 2002:ac8:5205:: with SMTP id r5mr18159981qtn.230.1579809766515;
        Thu, 23 Jan 2020 12:02:46 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:fdb6:49de:4189:c4f0? ([2001:4898:a800:1012:aeea:49de:4189:c4f0])
        by smtp.gmail.com with ESMTPSA id g52sm1614686qta.58.2020.01.23.12.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 12:02:45 -0800 (PST)
Subject: Re: [PATCH 0/2] sparse-checkout: add completion and --cone to docs
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <cover.1579805218.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9fe5920f-1b5f-977c-cfca-33e52771f521@gmail.com>
Date:   Thu, 23 Jan 2020 15:02:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <cover.1579805218.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2020 2:00 PM, Matheus Tavares wrote:
> This adds completion for the sparse-checkout command and mention the
> init's --cone option in the doc file. I know this command might change
> in the near future, so I'm not sure whether these changes are worth
> right now; but since they were simple to do, I decided to send them and
> ask for your comments.
> 
> travis build: https://travis-ci.org/matheustavares/git/builds/641012914
> 
> Matheus Tavares (2):
>   doc: sparse-checkout: mention --cone option
>   completion: add support for sparse-checkout

Thanks for catching these. They are both good patches.

-Stolee

