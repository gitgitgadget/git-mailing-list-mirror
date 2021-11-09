Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEAAC433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B6561105
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 19:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbhKIT36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 14:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243202AbhKIT35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 14:29:57 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93941C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 11:27:11 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l8so1791493qtk.6
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8QSyqiQCzg5qzOQunTvTa/sdJu9nj9P+Mzw3oMRX22A=;
        b=bBLpbyLOvkIsH8wSAXaA0FDmga2DkNrmGJP1tMeiDQwVwcSTxuxOSjxdu7tp1RddVA
         Fh2C3J2dvWAamcSLF50vSk6lBAmXN3eVg0IcZEQmA++rAsXCpvm5PFtx7j32ZaZ2d35/
         0Tfp9pBePS2JbeKxN851hu4mQkCh/yf5OMl3NvUIHs8g5wasr8aeHP1qtSdIm3nFAeYQ
         HCOmtO72+7FAaOrchgDb3v3XvMc+6DuMzUYu96M6JhwTwlFsBfCQMxVZgw5rS+5fYAQw
         7HC2NYbQSv4AIKYOFz0CKeYyoQBZHhf3WqM3blxmZPrD1IqMj5b38TCkI7Yki/Ry6w9H
         9n+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8QSyqiQCzg5qzOQunTvTa/sdJu9nj9P+Mzw3oMRX22A=;
        b=zr8YZFuu26Nwm2NscOtWzrYbhkgpZLiRJSLQxTjVYDcJk3l0jjSEU7pLLrc9Oze5m/
         TLT2roz+oIav1lnFKdbJcIr4DLhWX+qpHZt2MyH2fFFq+mc/GD42JniIzpjTZWB52/Lm
         EHrbrklfJP4kjukSEo5KDkis7hXNWKFFxZVRiWbix2AV32V0xZybrKcAgHj1D6zRkQ8b
         YX0mb9pnoyBcyOflN26seN5jHXnWOCjGkfHS/7QdRyYf0PDVlq4XR2fd3pgBVGTVKDUq
         MkKtUIyh7WPhh+B0g5rygOSWp7U6ub2UMWjaArp+gOCjmu5nRCXWomle82d76jxy2lRn
         4ZUg==
X-Gm-Message-State: AOAM530kAT1JGuMfRnRpeMteC6A0NhccR/+Q7rC5cQ0XVlU+g4pt2Oo+
        YzWydc+HMPFI0c02Y7HTKioeYJGVWel+Gr6w
X-Google-Smtp-Source: ABdhPJzn9yMN3uUi5VckN2WE6drJjTL4Kw36bF8v46Eg8E8E7I/k6TCQ2ivG2TxVED69xacMan/j5A==
X-Received: by 2002:ac8:5f8d:: with SMTP id j13mr11399448qta.108.1636486030722;
        Tue, 09 Nov 2021 11:27:10 -0800 (PST)
Received: from samxps.umontreal.ca (x-132-204-243-123.xtpr.umontreal.ca. [132.204.243.123])
        by smtp.gmail.com with ESMTPSA id e10sm12729945qtx.66.2021.11.09.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 11:27:10 -0800 (PST)
From:   Samuel Yvon <samuelyvon9@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        Samuel Yvon <samuelyvon9@gmail.com>
Subject: Re: Description of github.com/git/git, was Re: [PATCH] builtin-commit: re-read file index before launching editor
Date:   Tue,  9 Nov 2021 14:27:07 -0500
Message-Id: <20211109192707.19916-1-samuelyvon9@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <xmqq5yt12lta.fsf@gitster.g>
References: <xmqq5yt12lta.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I didn't double-check but I presume SubmittingPatches these days
> talk about GGG?

It does not, but it links to Documentation/MyFirstContribution,
which does. 

Junio C Hamano <gitster@pobox.com> writes:

>     Git Source Code Mirror - This is a publish-only repository but
>     pull requests can be turned into patches to the mailing list via
>     GitGitGadget. Please follow Documentation/SubmittingPatches
>     procedure for any of your improvements.

I think this is descriptive enough so that newcomers can find their way.
