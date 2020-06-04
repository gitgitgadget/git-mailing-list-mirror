Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68453C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 16:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380E22072E
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 16:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVf+Azw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgFDQng (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbgFDQnf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 12:43:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E86C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 09:43:35 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id y1so5761255qtv.12
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M6snPRh9i4WFWx9xYIUw6HZPUrRdAhsulEZPk/EyqZ0=;
        b=NVf+Azw5CztfhlatXkUa8I1N0qZabnYWq96Hg6T3bDkn5z/bLlha0BN9g80Ck4aEV8
         Yb87s1ljovMYnJC+JpfGmaQyBzsltIzSBfDOMi3sALcFV6AYioS7FhzV7waY2NpPttnC
         cRxsZCBHpDF4ay0IzxCtZ1pf3zWYN8d739n0V8PviaSYwlCKNGCgdyo71Muing3dWpP/
         JyMvWRxrKtYEn91z8UlKcCASUxQEC7msPh5Q0XnZwXZ0C75s03I667wXLQ8m4Zj1mN1z
         sYnKKphHDTQjFjBuh9Q2OY0oY9OTDZJKv0nx0UR5IQhPGOZmvbCYXPge5iJ8NWj5iHlS
         intw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M6snPRh9i4WFWx9xYIUw6HZPUrRdAhsulEZPk/EyqZ0=;
        b=GJSC2mkZ8p34SGfx16fAE3bZo/l4laE/7cAMFXX0KXcNwpllEAWUR6QifiGE7ObLgv
         d+q5t808MbUHjh+5Z4wBmKEc4id+GCxC1XF9iG7QD/ob6EjcstcbvWdjaLlfT/TOQM9O
         sJB2dpewYoXeenAKNoLEXJh4dvacEvRque46X6cZKTb8QpCMT2TV18EKofh2m8qWfzcH
         p2suLKbqwkAyJRJuMQfVACD2HOgfLgTyGDAnltzztYfkwRFErsjDTIcZZhbhKPb13+lM
         YjSqun0CP1UUoerKYTDe3v16286BI1vZ0x23CmP/odQ04tJqwwQcd0AKvFzu+xoJSuLd
         sChQ==
X-Gm-Message-State: AOAM532x5bwx8wUSIsExrqFQ3KgRAta5clFSQH+50zZoodhq5CxeHKI+
        b7gZK36KxFL0V31t+wnQ1s0=
X-Google-Smtp-Source: ABdhPJyMu8hkfsWecUAwkJSfKcSRzgE7lBYeOhTHQ1fHA47zSFq0S4UeKuvLXuLWooCWsG3fflQyOg==
X-Received: by 2002:aed:2d44:: with SMTP id h62mr5705811qtd.167.1591289014755;
        Thu, 04 Jun 2020 09:43:34 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s52sm5601910qtb.3.2020.06.04.09.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 09:43:34 -0700 (PDT)
Subject: Re: [PATCH 04/34] commit-slab: add a function to deep free entries on
 the slab
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
 <20200529085038.26008-5-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8030939b-44fe-e251-5b76-2b2f260b980f@gmail.com>
Date:   Thu, 4 Jun 2020 12:43:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200529085038.26008-5-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/29/2020 4:50 AM, SZEDER Gábor wrote:
> +void free_depth_in_slab(int **ptr)

This needs to be "static" to compile with DEVELOPER=1.

(I'm working to apply your patches on top of ds/line-log-on-bloom
so we can get the benefit of these universally-good things. I just
want to report the things that I stumble on.)

Thanks,
-Stolee

