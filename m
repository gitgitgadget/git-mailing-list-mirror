Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FDBC4320A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1811610F7
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhHMQdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237860AbhHMQds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:33:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E14C0617AF
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:33:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w200-20020a25c7d10000b02905585436b530so9676762ybe.21
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9AtELwqgpyAIzQTIM6IQQKggxEAo7aGAMaPmBCy9ZoQ=;
        b=O8h4l7XNRy2zgwVNObPDcUHt+bHLjQ/ZkMCD6UVn6WXd9syUdhrWcHiefIhchBKog5
         YBntr2h4TxDG4bcsgqWETFjwM6hyJelr9IH3KiNMXhlf23GXLSU8fdX9Mr9Us79t33z2
         3i3fF0nCLDj4D5K776sSPTcNmtfoNtSFtYwqrhRGhOiN19HUA9OhEiCLyIf+0bKgf2vM
         dewVCX/S5twsjMLMQDeO0EeMkAXQ+bGG/jGNzDWGI/u7EK9Seq8P28DIk7+IPmEOVvZ7
         e+uvoqoaJ/+AyVsRTuFPLpEA37WEWoRTSMwjkxc7hm6/LpAjhmgVP+vxKOVL77D65jFW
         u8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9AtELwqgpyAIzQTIM6IQQKggxEAo7aGAMaPmBCy9ZoQ=;
        b=G71vp10KDV6ZFmd3pCz4Hu2B/L+EZkybgQQXfyrtAmgajaJCIx07vxD9x/i9WXar9W
         PNg1Lj3rxeJhV4BGLsvgP/WGNo1/j9BvVG4WZNmcs8xp+mY/4ItDSUxRTfJXcuUXxn+z
         Xpeg1Jl4lNeI02d0bk3VenkZ3hCIBAXJuDMjc8TT9+DwagKotU0r3tinS5YLTL//dmii
         9TjfpZHm06hgPXBMXj+Mi1/CasIpLUSHH+evBAjkv9Ts1JHdU7Ox+tGbufhazZsora59
         T+iHb8f+uHoE44HZsTdYyaEZru/e9z72ZI31aoy2NnbnQlZbTNzCDoSK+njaWhmbv9P8
         RmhA==
X-Gm-Message-State: AOAM532Z7XFQDlnYUM6z8L6DMd31HEzCdBF0L4AUPNQHVMCZDLWBLVQJ
        0H5k/Og+EbJBGsfW/CyIITuSvvkk9+F0cjCLv68W
X-Google-Smtp-Source: ABdhPJySABoeNPxlkCkxS2OIBtM7f+A5+fwL3UVJyX5TkgfvYqUsbv0t39iptAlzBGpvD3BvkI4HNg6oF58gfYkacj2b
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:28b:: with SMTP id
 x11mr3909213ybl.9.1628872399918; Fri, 13 Aug 2021 09:33:19 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:33:18 -0700
In-Reply-To: <xmqqwnoq6217.fsf@gitster.g>
Message-Id: <20210813163318.3213751-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqwnoq6217.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 3/7] grep: typesafe versions of grep_source_init
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     matheus.bernardino@usp.br, jonathantanmy@google.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Small nit: perhaps `grep_source_init_buf()` could take `buf` and
> > `size` too, so that all the fields get initialized by the same
> > function.
> 
> Sounds sensible.  Thanks.

Makes sense - I'll do this.
