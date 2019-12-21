Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC07C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F74D206C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="MzMKPuTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLUTOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:14:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45771 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLUTOl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 14:14:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so7047794pfg.12
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=B4qbr0PbHAP7hshWLePg0q0AK0RN5wLGg6Xx3ZM0VD0=;
        b=MzMKPuTiCmalKW8H1pTRzqKudbuL31eHHPPznZlZ61JNBoIqzdPGVE9fQE6skz8jtf
         QAeKn0K2KRWOkuzdR7C+dxVpC5J13UvYK+cKUIDmtTWhhdZ5hLlr2pnlJ5548vtRHIr4
         BEpTDb63Sw1aO0+3LD0XXX/LdoH2tr9sV2iCcuSChyMcCmc7Bk4Pr97u/7LwwkDEFHTS
         WjTSGC61KhZMO6oNFbkPxrrqZUid+oNnDubhtynthLqZYrV2m50HF4bs4jg4mbPYOsWE
         bSEJzPca6V99RiISvpgmvBbja3XBgyIKmAVFSm/0DF0/6254FmIXPyaW69JnX2IXGGlQ
         UC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=B4qbr0PbHAP7hshWLePg0q0AK0RN5wLGg6Xx3ZM0VD0=;
        b=e4yfTGmhQnJ9gBoDyiTQOqcOdWaLJDby2/D8RrDEdSk+GkHTmdQUFis2XayXGoUWh9
         oCUI4wiA1KrjxeU9BDu5VnOkymcqjUR5hWTTk+UtBMWjDJCtKcyLn7q4RG4ZOsY2DUp1
         Z4NKtSkCn9pEOjgEwfggH0MujCTMwKuA7DfN4IYWLNoHOaSa7RFsVAZRqPpFuQrd5HKA
         RcwDxDdXS6t/Q/fCFrRkMpX7o08NQB9hcCL3o5p24hXhbNKC3TS8pfJ6ksHPnptZCzRs
         eDym2hog7VODS3zt4Js3zdKurBIqMgjPLrlkH1UZY0QEuAiC4dyenBCqgs8MtU2dDO6G
         uJQQ==
X-Gm-Message-State: APjAAAX4BSYXF51sdhwovIja8jHkg6eVC81ON+v9fGWYLtZHrsbNDC1W
        U4UGiChNWS7k5pb4icvWYpPN5w==
X-Google-Smtp-Source: APXvYqwPlWYNpkzNn8Q7QnN63mmPFVziy3BtMbvhswWAPeS26WH6CcH3VLruy2dtRNZu0GkH4y+Lcg==
X-Received: by 2002:a63:7045:: with SMTP id a5mr22900380pgn.49.1576955680418;
        Sat, 21 Dec 2019 11:14:40 -0800 (PST)
Received: from localhost ([203.144.81.74])
        by smtp.gmail.com with ESMTPSA id j9sm6478836pff.6.2019.12.21.11.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 11:14:39 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gpg-interface: add minTrustLevel as a configuration option
In-Reply-To: <20191220225746.GF8609@szeder.dev>
References: <20191216153204.8906-1-hji@dyntopia.com> <20191216153204.8906-2-hji@dyntopia.com> <20191220225746.GF8609@szeder.dev>
Date:   Sat, 21 Dec 2019 18:59:08 +0000
Message-ID: <87y2v54i9v.hji@dyntopia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20 2019, SZEDER Gábor wrote:
> On Mon, Dec 16, 2019 at 03:32:04PM +0000, Hans Jerry Illikainen wrote:
>> This patch introduces a new configuration option: gpg.minTrustLevel.  It
>> consolidates trust-level verification to gpg-interface.c and adds a new
>> `trust_level` member to the signature_check structure.
>
> This patch causes several test failures:
>
>   https://travis-ci.org/git/git/jobs/627909430#L2259
>
> I see you've already posted an updated version, so I tried it locally,
> and the same test scripts fail with the updated version as well.

Sorry for that!  I'm preparing a v2 (tested with both gpg1 and gpg2).

> I noticed that only Linux CI jobs failed, while the OSX jobs
> succeeded.  Our Linux CI jobs (and my box) are based on Ubuntu 16.04,
> and thus use GnuPG v1.4, while the OSX jobs use v2.something.  Not
> sure that the version difference is connected to the test failures,
> but I figured it's worth pointing out.

Your observation about the different GPG versions was spot on; thanks!
That explains why all tests pass on my machine as well as on a personal
CI setup for my git contributions (both using gpg2).

The issue was that the search for the end of a trust level to parse
relied on the TRUST_ line being space-separated.  But that is not always
the case for gpg1 (only the lowest-two trust levels contain a space
followed by additional information in gpg1).

-- 
hji
