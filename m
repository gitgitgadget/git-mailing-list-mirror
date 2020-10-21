Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB1C55178
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D70822248
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZftYqqF4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443360AbgJUOPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443357AbgJUOPo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 10:15:44 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA40C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 07:15:44 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h12so2231067qtu.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=893USEFlbdRq5oSDPN9tjOTQWBqu7m9yVJxhx3Y+Ytc=;
        b=ZftYqqF4ZIdWA3m0sUCMbkEmZy+W48cMtwgFknv4i+KUk/au/gdlS8upO5v1qBWuej
         JniX8sR2VwoTLlb5NEI1MD30pm/xEzpU7dDOlcAE5Xovc3q2YqgSJRz/l64wus5q98NY
         /ru3W7rVCLM6UwYn7hh8xNaGQWzuEN6Xp1abQr6e7b2P+ZipbHcGsjouup6mtAj1JzAq
         eox+sEXjn9b+BISfKyWPlpHyh+pnDHNtH5tNNMVdfd8c054ep3QNNhtdfx8aImv1c8mP
         yrV99cWJRGywRbEopHU3mLid2LJ4x89x1jHcWnBDL10Ybf2hwEHy+qHoRtWecumKkplg
         cNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=893USEFlbdRq5oSDPN9tjOTQWBqu7m9yVJxhx3Y+Ytc=;
        b=JqsISqMUCJVuNiNSnnHFEktIInOoKal5VGWCCrnEjw0cdTy1x1j6vvGuKNRenkyZsW
         WrJpVBWxLv/SbT/ZcT6Ej5+3csK9iR2eDlSnYYwHce6JU1BE/L98UjrFrf7YyppFOzS7
         tCd8qBvfU4nPpE1Thkz8yWKSRu/VoM1Zrl++RrVa+wmODNsedsFhTyTWHGr2SqI9ulr8
         HP0CD6n9Vh+J/eJS69H6E51CkpH9sy86NzHpkiGh0fEEmlY89sD43VsIsVE7rIfLQLZ2
         YkV9+3jmO8Yk06YdVUB5dfm5OhS+Ef6F/St2DFOyaz8TxmWWq7Fzkr6hzWRVWiu46hnS
         2/5A==
X-Gm-Message-State: AOAM532k12rUWJpe2lDI6UqetUvsu0BTGY9sX1q/ayVyuIarQHeHYS7d
        PpOpKJhqOgxkyT9XPHc7w1MuvfWwMzA=
X-Google-Smtp-Source: ABdhPJwhBoYh7mGZKkRaZpmxBwU/hZT28RSkmv5COMuyUqyHPWXHmLnzk7L7gzBU4Z4JoCoGcwUSxw==
X-Received: by 2002:ac8:3663:: with SMTP id n32mr3426817qtb.354.1603289742753;
        Wed, 21 Oct 2020 07:15:42 -0700 (PDT)
Received: from JeremiahRosePC ([2601:585:8100:275:99e2:7649:59df:4246])
        by smtp.gmail.com with ESMTPSA id m33sm1274660qtb.65.2020.10.21.07.15.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:15:42 -0700 (PDT)
From:   "Jeremiah Rose" <jrose0323@gmail.com>
To:     <git@vger.kernel.org>
References: <00ef01d6a7b4$87ad1ef0$97075cd0$@gmail.com>
In-Reply-To: <00ef01d6a7b4$87ad1ef0$97075cd0$@gmail.com>
Subject: Launchpad Stable Release Archive not updated
Date:   Wed, 21 Oct 2020 10:15:41 -0400
Message-ID: <00f601d6a7b4$a8c03910$fa40ab30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHUhy53Y2KvljTKInbmK8+dMR7fsKmmWuKQ
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good morning,

Git 2.29 does not seem to be updated on the Launchpad ppa for stable release
for Ubuntu, but still shows under the RC archive. Is this intended?

