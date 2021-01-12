Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD0DC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DC223123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438007AbhALVhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436845AbhALUS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:18:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366C2C061795
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y23so3320334wmi.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRwCSbQS1GwtBpIY9PjgMEn7KWOqBkT+C2ETYJdC3so=;
        b=M1keJgmiXYnnNYY/EeiMF3GSBb0trBrxMbrW2T9PIk3IFzTVE3NXK8CTNYbZP2nJos
         rqIR2m0sr8oLeH4DJ01++UQ9rI/4lZ7xJg0KJryfK5YZcb8C06oTqbWL0KyjeT//lk5f
         T9SFNGHLXtI1yCBuLdupG6QE3Qg78YdZBWY6mHBlWqkM2pWTvi42eTFETKg/nK1MNf3G
         r1olVtMMImAcVUN9oREgxichrwrInU0gnRcd0rADc4MoDAGF4YZYddQcZOMBck3Q7wxI
         G6FyfHI5SlGkRGoQJ8k3v31aWxGmxAZJmpz10VJ0o8gRBdWx8XK1me9cENLHD59AXQll
         JUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRwCSbQS1GwtBpIY9PjgMEn7KWOqBkT+C2ETYJdC3so=;
        b=t0U18xb1ZPorFgvQPjxK1BjzzdkLgwt6umGLgR44kqWkMFuw1NR/p3AWoT1YEW6Unp
         MrFU4bIAlc0nUzEYzcTnV+4Si9zixxaL4TOa3yRdOKeOuNiZkB7FOthcoVJhEHYW1u65
         pvSe0IVjMgYJaldF1J03051y7vxnqCkkTLZ7o+pl/A+DjMD/V4Vk/2by1rzogBE2ZfmJ
         xeCs07bLpJSNu/FIK4wJ6+mDKfwRbe3VUMqu7f6jKSOqL0NC2hw4Pc3F6FoT1JwtLK9e
         ywS3AheEXKEdOi4Sl2o/L+Ru8mdWptGYqmAMrJZZFVw/VTTCeM42oTBVl3sBiJg0sUs0
         Nmtw==
X-Gm-Message-State: AOAM53346r2XdfRFdhAxy/6L7fMYBH/eqEJcdUa7ZNyQxhvoOUulwJ5i
        L7JHAZUEWhZza8dWQAq7sMOsLH+U0pVoBw==
X-Google-Smtp-Source: ABdhPJwv00RJmnYflbn+LzdKckhX/SGdyziXVtzQJ+edps4wmSvD8KNg37KbPaG2moMgLK63YgH7iw==
X-Received: by 2002:a1c:a957:: with SMTP id s84mr869450wme.166.1610482696733;
        Tue, 12 Jan 2021 12:18:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/22] mailmap doc: quote config variables `like.this`
Date:   Tue, 12 Jan 2021 21:17:46 +0100
Message-Id: <20210112201806.13284-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quote the mailmap.file and mailmap.blob configuration variables as
`mailmap.file` and `mailmap.blob`, and link to git-config(1). This is
in line with the preferred way of doing this in the rest of our
documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitmailmap.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitmailmap.txt b/Documentation/gitmailmap.txt
index 8b07f9c5d7..e75eadde63 100644
--- a/Documentation/gitmailmap.txt
+++ b/Documentation/gitmailmap.txt
@@ -14,8 +14,8 @@ DESCRIPTION
 -----------
 
 If the file `.mailmap` exists at the toplevel of the repository, or at
-the location pointed to by the mailmap.file or mailmap.blob
-configuration options, it
+the location pointed to by the `mailmap.file` or `mailmap.blob`
+configuration options (see linkgit:git-config[1]), it
 is used to map author and committer names and email addresses to
 canonical real names and email addresses.
 
-- 
2.29.2.222.g5d2a92d10f8

