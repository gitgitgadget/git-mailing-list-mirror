Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88458C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 07:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3820964ECF
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 07:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhBXHVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:21:21 -0500
Received: from [93.83.142.38] ([93.83.142.38]:42264 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232329AbhBXHVU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 02:21:20 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 2131729CD6;
        Wed, 24 Feb 2021 08:20:57 +0100 (CET)
Subject: Re: [PATCH] wrapper: add workaround for open() returning EINTR
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Aleksey Kliger <alklig@microsoft.com>
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <acb282ee-fc55-bbe0-8272-087bde180ea2@kdbg.org>
Date:   Wed, 24 Feb 2021 08:20:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.21 um 05:43 schrieb Jeff King:
> The workaround here is enabled all the time, without a Makefile knob,
> since it's a complete noop if open() never returns EINTR. I did push it
> into its own compat/ source file, though, since it has to #undef our
> macro redirection. Putting it in a file with other code risks confusion
> if more code is added after that #undef.

I'm not so much opposed to "enable it all the time" in general, but when
we already have an override of open(), like for the Windows case in
compat/mingw.h, I find it a bit rough to put another wrapper around it,
even more so since we won't have the EINTR problem on Windows due to the
absence of signals.

-- Hannes
