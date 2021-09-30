Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC54C433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E0B615E5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348140AbhI3Fmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 01:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348136AbhI3Fmb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 01:42:31 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF2C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:49 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id cv2so2929389qvb.5
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=leQ3GXPs0SFhbHZXj3pG5Rj4rj66XgOMKTyWpmRYFzQ=;
        b=IwC1212uNUQl2mkwxnTcgMU9Or0wqNU98VDA+7De6NNbagBZz9V/zpLkljd3BEIMoF
         rIa9krfwYdHZcgRAXE1v5anaePUq75OyLf1RTp0/WBfgOUjcSjnwiu49SR+vqa+XB/cQ
         U+kRohK+4nK29GBNQoLHCZlNu9G8D7FsWcIoPvfX3tfJwYNSkBh4cPrpRYgO/16hrqFi
         fNZTRqt4cVr0tdbl6zV5IVFPY+j+TR32oISSJjl8CqXhdcOqaqMV+ne7T35ef7vgyMuu
         uDsDMr4pRGytEN3jr4IIRNJBdLet4SJWwVR9JadG/mNomAQnAlZhG1JZdqrJ7uMl954Y
         cR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=leQ3GXPs0SFhbHZXj3pG5Rj4rj66XgOMKTyWpmRYFzQ=;
        b=p4CYK+cD5MPz9cu692PzqbtkbQn1YUzgUe3maMHASvJRIJVDAusg5uIrkXKAl+0Pwm
         MRaglO6L3oF3+MLV8TkuyjeGHkMuwQTeUzspWCgMqmxDPchSAPQZcbmQc8MmG4kqUoQm
         5FpcKVC9+XrTyRYuqZECoziGumkDDQxkSr+2pi/qHi7OF4dAU+D/A+QjWP2FqHWBmc9L
         AqVc0B4tkLy+NGEngpV2OjFwgNquN3Qz7hHBsSrOm01a4U+pzD2Q4Rl6u5IRFpEaUpW+
         D55gCgeU8Lci3bXSuA3ztfqCBNv4gSryH30bIdN96EhqJV3Db4/35R9//ZcPTANtin0Y
         MlIQ==
X-Gm-Message-State: AOAM531f6tRar7XzLGTAX9bE4Hod2Ru6WUIYyhhZECVaS5goUoRhJtsT
        6vywNY5h271PyRqde/Fj1C55Kx/sw6n5eA==
X-Google-Smtp-Source: ABdhPJxkcwEgaXPW+CMGtXMFPKSIXRX6fuxUGLP500vYO/dJVvOZTXfWbvBxRoZN8sebdMadA6vcUg==
X-Received: by 2002:ad4:482f:: with SMTP id h15mr2225871qvy.29.1632980448024;
        Wed, 29 Sep 2021 22:40:48 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a2sm1006826qkk.53.2021.09.29.22.40.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Sep 2021 22:40:47 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, avarab@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/4] config.mak.uname: last release and snapshots of Minix still use zlib 1.2.3
Date:   Wed, 29 Sep 2021 22:40:31 -0700
Message-Id: <20210930054032.16867-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210930054032.16867-1-carenas@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
 <20210930054032.16867-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minix 3 uses a BSD userspace from NetBSD, but might had synced last before
8.x got branched.

While Minix itself doesn't have much activity, this is still affecting the
last release (and subsequent snapshots).

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 4acc3e3609..9399247cbb 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -517,6 +517,7 @@ ifeq ($(uname_S),Interix)
 	endif
 endif
 ifeq ($(uname_S),Minix)
+	NO_UNCOMPRESS2 = YesPlease
 	NO_IPV6 = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
-- 
2.33.0.955.gee03ddbf0e

