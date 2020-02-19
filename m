Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C59C34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 08:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A61222D9
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 08:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSINz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:13:55 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:56963 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgBSINz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 03:13:55 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 48Mr8b4yrDz5tl9;
        Wed, 19 Feb 2020 09:13:51 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 84D011CA0;
        Wed, 19 Feb 2020 09:13:50 +0100 (CET)
Subject: Re: [GSoC][RFC][PATCH 1/2] STRBUF_INIT_CONST: a new way to initialize
 strbuf
To:     Robear Selwans <rwagih.rw@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20200218041805.10939-1-robear.selwans@outlook.com>
 <20200218041805.10939-2-robear.selwans@outlook.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <467c035f-c7cd-01e1-e64c-2c915610de01@kdbg.org>
Date:   Wed, 19 Feb 2020 09:13:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218041805.10939-2-robear.selwans@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.02.20 um 05:18 schrieb Robear Selwans:
> A new function `STRBUF_INIT_CONST(const_str)` was added to allow for a
> quick initialization of strbuf.
> 
> Details:
> Using `STRBUF_INIT_CONST(str)` creates a new struct of type `strbuf` and
> initializes its `buf`, `len` and `alloc` as `str`, `strlen(str)` and
> `0`, respectively.
> 
> Use Case:
> This is meant to be used to initialize strbufs with constant values and
> thus, only allocating memory when needed.
> 
> Usage Example:
> ```
> strbuf env_var = STRBUF_INIT_CONST("dev");
> ```
> 
> This was added according to the issue opened at [https://github.com/gitgitgadget/git/issues/398]

I am not a friend of this change at all. Why do so many functions and
strbuf instances have to pay a price (check for immutable string) for a
feature that they are not using?

As the macro is just intended for convenience, I suggest to implement it
using strbuf_addstr() under the hood. That is much less code churn, and
the price is paid only by the strbufs that actually use the feature.

-- Hannes
