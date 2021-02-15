Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CCBC433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D4E64DEC
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBOVCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhBOVCR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:02:17 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68142C061756
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:37 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p12so3756473qvv.5
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CFS8ZAwCkck62u5YGZ1R1ZwS/6GyuYHcrZz8RMkbT8M=;
        b=0X+uFSXUFKDxLx1yIxyVgOahw4u7ZhEaH663vTZwm2JU/1W6lu9a2CcAQldw/Jg5BJ
         eaGpr0F3FpUjwGX5CNQl3RRXfx7o2hbP1RB6+QVU7rX288BzfomY3sl6Q1K7OjQ7pz2Z
         2j1onxfYNPXrPySjQHuY+TKloxtJzDKrY1G545/yuNfvpIUeaclkz2ixLuGpRshJb3IV
         KRG86oOyajc/3ytMrYQpISiEusEdI0UcxrPXGyyC0w0phZStVGP+GnHVFxt5s9tHwPPc
         wQwwqLhC+hFjKoscEUTZuWAaIOAKxmGua/rAmHVLU+qbgNqdsa4WyoitdRFohsPjo/8z
         uLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CFS8ZAwCkck62u5YGZ1R1ZwS/6GyuYHcrZz8RMkbT8M=;
        b=Yn39E51BXqBcNHidOglmN6j2YpABBNQyBmzK8VgRXjPvVSX3PCvwTnynXEp8/qu2Au
         Tn6ql41/TzSXaglDyIjFTfhCU0BCBRUA3NQeeTrY/c8fBfrnN5fdRppTw1vELuv913Vu
         +s1vA2f1Pl9BZZoFivH7s5DOFCLDn/gnEyS4KGNolVzFXt5jEA2TwYjJZEZeErKXsDlI
         MxDz1Dls681W1NTdeyTy0RGflJLcTmCmXVaZTvPe55gtATmK89i2zB289mTzTrg33Qdy
         EJBmt5hZAcmrZoG5WP/U2q6HYPjQWoH9gSlnKdT4SAlaCII3b8K/A7UUcyIlOe8HQz88
         JVHw==
X-Gm-Message-State: AOAM533FolgvnbXrskuoFfpdUfjIVMjM0pgp6Ld66KK8SJJ9ufI2TJv4
        cIEnMX10DVWKsZ5XUvfymz1MdsC9MDdmJZfM
X-Google-Smtp-Source: ABdhPJy8dIyRUA/8+S94d4WiFVcozKowfx1X4P6dO/THC+7672BEosBKTfOhSUxJ7qDghhSXp0xB6w==
X-Received: by 2002:a0c:fd47:: with SMTP id j7mr16159294qvs.22.1613422896412;
        Mon, 15 Feb 2021 13:01:36 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:808e:e46a:5ad1:bdf0])
        by smtp.gmail.com with ESMTPSA id x9sm11653858qtr.74.2021.02.15.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 13:01:36 -0800 (PST)
Date:   Mon, 15 Feb 2021 16:01:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: [PATCH v2 0/4] midx: split out sub-commands
Message-ID: <cover.1613422804.git.me@ttaylorr.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1lhb6z7.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a few patches that we could add to the beginning of this series,
or queue up separately.

I think that these are all fairly straightforward, but it would be good
to have Ævar take a look and make sure I'm not doing anything wrong
here.

I'll plan to send a v2 of the reverse index series in a few days with
these four new patches at the beginning.

Taylor Blau (4):
  builtin/multi-pack-index.c: inline 'flags' with options
  builtin/multi-pack-index.c: don't handle 'progress' separately
  builtin/multi-pack-index.c: define common usage with a macro
  builtin/multi-pack-index.c: split sub-commands

 builtin/multi-pack-index.c | 155 +++++++++++++++++++++++++++++--------
 1 file changed, 124 insertions(+), 31 deletions(-)

--
2.30.0.667.g81c0cbc6fd
