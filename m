Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8337CC433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 05:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6199120719
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 05:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFLa9zFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgHaFIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgHaFIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 01:08:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD22EC061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 22:08:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c19so3630021wmd.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 22:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=V59ri4/f9SZYbjrlAvz9vNUZq74rlZleXxzz2OBqMLM=;
        b=XFLa9zFfJ6gpFEQFWCxKYJ9hhEN5C/i6gpd9Jx1mf2WraI1BDFJF3i7+oYN/JzqoU1
         EzVs/IlF+u/xaCDCjUGxO5VvSsk8jpWh1MbO7eqgF8gT9iUxh/Am++ofONzjigNKlBl3
         248EF38lhYG77oiX38gfA+epMOZ+EJWrDDVLqIHQjeaLzXewE2KSileaSId/2M+sY7e4
         teVk48LijEISgt+pA1WqvIVoEiEZY2qqNvOEALl6kjav+kxznNxay9BmjvwvpkYJGpye
         9wujE47Cex4ur/5UpGqSNA0OG2ptAZAcZ20OYWT5EGYdilYi9O3nSP0+wnnD01zRk97d
         fTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=V59ri4/f9SZYbjrlAvz9vNUZq74rlZleXxzz2OBqMLM=;
        b=CyNVYnj6bE9jldHbz/4ZFVWXEzTAmzc+8KgukECTLCH9hz2jgHsUaaR2dLwCTATlQK
         CbBL/oYRbDGQpdgy8CXsd7hw2b4oosYkd8AtU91GchkJ+qYzM3FMOxquDoHQZshDLxRz
         H5LL44/KyZFFU1erFuQhEmtQB0gGxxRotwXcIKbnZQv+Ax9kvvw4tjFVs6IMzwGfGv4Y
         a1Fl5mEaGgqvmWtYquG3AQkF8jCnd8iOoDoWDBWXxpINTOQW7pPyb340LiWREW2Wv2Ne
         uPHfULufwy36d2H2t4EeNy3Q+2uPTlpGp/oTjBZ4u/kvYotShlD/nyVU3rZjLtv/EhKW
         bnSA==
X-Gm-Message-State: AOAM533GQurPd42GWDMiYjyu8AcODjsELh82zy8YwygfxksEo4RS9NTq
        H+6WN3kNoPRTrwmoWLJdgPKH82bGDpY=
X-Google-Smtp-Source: ABdhPJwlOujAxj0N4x0lrt7E6IvQBlG9b/Ja3yO9j804SJ9duUMGBPy7w1HkcI+Jgf81+J3BXPl4dA==
X-Received: by 2002:a1c:a911:: with SMTP id s17mr8361809wme.77.1598850494380;
        Sun, 30 Aug 2020 22:08:14 -0700 (PDT)
Received: from debian1 (88-144-199-94.host.pobb.as13285.net. [88.144.199.94])
        by smtp.gmail.com with ESMTPSA id u66sm5686061wmg.44.2020.08.30.22.08.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 22:08:13 -0700 (PDT)
Message-ID: <14a46bcf8da119af8b8882fe77a0d96ff3984b1a.camel@gmail.com>
Subject: [gitk] searching misses relevant commits
From:   Lyndon Brown <jnqnfe@gmail.com>
To:     git@vger.kernel.org
Date:   Mon, 31 Aug 2020 06:08:12 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When searching commits (by which I mean the "find" feature), sometimes
relevant entries are missed which should have been selected. I reported
this to Debian as bug #969197 ([1]).

I gave an example in the Debian bug report of searching the VLC
codebase for commits adding/removing "set_capability" (exact; all
fields). While 888451fe5146a49de8d49e830dbe57dd478e358f was one of
those found, the adjacent
commit 46650ad3f7f92d2757c43b42aa170965dc1df25c was skipped, despite it
being entirely relevant.

Changing to IgnCase makes no difference.

I'm a Debian Linux user, running version 1:2.28.0-1.

[1]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=969197

