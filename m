Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8CF1F803
	for <e@80x24.org>; Thu, 10 Jan 2019 18:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfAJSaE (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 13:30:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34341 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfAJSaE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 13:30:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so294959wmd.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 10:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J/p77LTVE5+c5U+tMbZpWWB1/yreGdABtiteu5WwLgQ=;
        b=DjPBHLYpN/f+pI1ms/9ViCw4VeZH56HPk8wEdNoOHIgvsgXeHwDNaHr4Bjb0eWTXsx
         qkYtwaAHaBNvcJsSzIxdRH/OQmYm8HxMyuNGu6GERuseJa+nvYNDrHG1QgxZGkFBbvI8
         F/kikJzjabicOkGdR4nuzKJYfSavdhGakHslMPolVKjDV9sF11C5eN5TB/H3+K2BAFMw
         QfnQeFsfOaWLPZWIrTWP1Q4F1rHE2DhGCLtL+oapc0fCBezVTp9FG2ZZ/8ONFpowR51d
         F8HBVZzC/MNQY49TYTq3L/0B5jN9KqdeqbhpgbfIvJmO8yDJK5yu8ElC/6ZP/f14paB0
         BV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J/p77LTVE5+c5U+tMbZpWWB1/yreGdABtiteu5WwLgQ=;
        b=Jgyz3ot48pW+u1bjqyZVKEDPo1WIiHpj7P/OEE3fdDUoUPS6WNTr5mVzoYVdilEsSt
         2PkY7CSElTRlTPivo+MGFkDonsquppBdUaWxNZjF8lmJSTeI2eL7vUlwbglN8k80YOgS
         GTLHqfrFGi3wNvVIqXh2StdpJPTuXla5H8iPgSgCgP7Qss3n4B0zEdaIOFJwhrp3QjMG
         saenCbW5lJ7nBH25s7o25EWqbIEFmMcLmTQKHvDoMPzv3M3uY+yftLlGNtVN/h4hvtyx
         Yey0uOn6IZKFu+KnqJ5wCnUjIC7svYGTCSjqxguI07CF8P1OkhC0n0q5lQDYVNkavEBN
         7LzQ==
X-Gm-Message-State: AJcUukeyOHUBCsq3ejehi6jF2/f8ZpLLHNoeLyCeTsnyggrD2sKZ6zmv
        H+NW0Ivibh7XgQODbTCsK2etsr5M
X-Google-Smtp-Source: ALg8bN4pkbOpxSJL0abApYBRHqxtSmdR/WvcMax9Al3g5S0Xq7cpryfQ0qp/OMDazSVojU2Gog23gw==
X-Received: by 2002:a1c:8c13:: with SMTP id o19mr31307wmd.56.1547145001540;
        Thu, 10 Jan 2019 10:30:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h16sm135845143wrb.62.2019.01.10.10.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:30:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH] upload-pack: teach deepen-relative in protocol v2
References: <20181218212435.201641-1-jonathantanmy@google.com>
        <20190109193510.GE54613@google.com>
Date:   Thu, 10 Jan 2019 10:30:00 -0800
In-Reply-To: <20190109193510.GE54613@google.com> (Josh Steadmon's message of
        "Wed, 9 Jan 2019 11:35:10 -0800")
Message-ID: <xmqqa7k82wnr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Looks good to me.
> Reviewed-by: Josh Steadmon <steadmon@google.com>

Thanks, both.
