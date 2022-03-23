Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B08C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 03:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbiCWDth (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 23:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCWDtc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 23:49:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067DA2734
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d7so319070wrb.7
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 20:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmXTR5S+QWiXYKYi3nJBK9U1otMI7DMZcFOdjb4xAEc=;
        b=eoqCfTMnAYX6J8OwXBcPs1hmjbVBNrJBpntD61VJ1dAhyp8jcAxI8jdIXWrb0wjRRN
         wfkadfF63vy6uYqIHzOIztmQqnN+jA9c4K9YoBhJC07N8vpxhOvtWKx20zsnw0Nxb89s
         Mde5NPhP646i0ER0orx784N5t86aaArV80kabKITpVCn1/Ar3VGYVuayxzAHKhEE/Lzt
         fUw4oJjnxXDDkLJj99t0mjWOrSQ1FNhD1tggn5qDkITtS1qlBTUZEO69tonkWCR4gUNn
         jJmBIhLtEMuYDr0kpp8lM306neM4/Zc9bxb6oY01PAehtBE2uTPC3gMKM3VQHez5Nybs
         G5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmXTR5S+QWiXYKYi3nJBK9U1otMI7DMZcFOdjb4xAEc=;
        b=pVzgT5lSR2GrRv+FnCKsowr6o7Rcc4LPuBmAJWGz8h1k7vMuBFGfdJn5+XZK/GZ7ps
         5n3T5G7rWpuS1nHG2glOh48mrPEy4qBasDt9FtYwZDYoYUgE2YpyWDnfQuzCeal0klGF
         vC+AmcHAJnvGYH7rTwhCTTdmISWjDYAFbr47B6k+VIqUVc6LrJ0QQ2wp4lm25jzBajs2
         gJFXPYNsbKK95z6rmv+tt8yvvuQ3nFkWK7r6ooPDaepnw80fX/nOPQ1el9yQgMAhLNJ3
         s3FvWCvh3ovDzN7Pk4qszzYFG1vWPmDGr8HU7JeEOMeTE+Glme7UpZHNeGPj6ypIHrUy
         smAA==
X-Gm-Message-State: AOAM533h+47MqUiRBcWe3KGhCYgOHUUHsMOjxHPmA0xYtFJXB7ejC4Tg
        r12FPwL7EPPwyGNLDB6qDyGGYTYDR52PoA==
X-Google-Smtp-Source: ABdhPJxDyj2m8qJuOrVtgwUWXFYLPEbGV++bNVmojcUrlQcmuNgPxRWzkfpTosVVSPSyEOIMKFG9Gw==
X-Received: by 2002:a5d:64ed:0:b0:203:7b40:de5b with SMTP id g13-20020a5d64ed000000b002037b40de5bmr25552074wri.253.1648007280217;
        Tue, 22 Mar 2022 20:48:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038c6d836935sm3028830wms.16.2022.03.22.20.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 20:47:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/7] write-or-die.c: remove unused fsync_component() function
Date:   Wed, 23 Mar 2022 04:47:30 +0100
Message-Id: <RFC-patch-1.7-e03c119c784-20220323T033928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com> <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function added in 020406eaa52 (core.fsync: introduce granular
fsync control infrastructure, 2022-03-10) hasn't been used, and
appears not to be used by the follow-up series either?

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h        | 1 -
 write-or-die.c | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/cache.h b/cache.h
index 84fafe2ed71..5d863f8c5e8 100644
--- a/cache.h
+++ b/cache.h
@@ -1766,7 +1766,6 @@ int copy_file_with_time(const char *dst, const char *src, int mode);
 
 void write_or_die(int fd, const void *buf, size_t count);
 void fsync_or_die(int fd, const char *);
-int fsync_component(enum fsync_component component, int fd);
 void fsync_component_or_die(enum fsync_component component, int fd, const char *msg);
 
 static inline int batch_fsync_enabled(enum fsync_component component)
diff --git a/write-or-die.c b/write-or-die.c
index c4fd91b5b43..103698450c3 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -76,13 +76,6 @@ void fsync_or_die(int fd, const char *msg)
 		die_errno("fsync error on '%s'", msg);
 }
 
-int fsync_component(enum fsync_component component, int fd)
-{
-	if (fsync_components & component)
-		return maybe_fsync(fd);
-	return 0;
-}
-
 void fsync_component_or_die(enum fsync_component component, int fd, const char *msg)
 {
 	if (fsync_components & component)
-- 
2.35.1.1428.g1c1a0152d61

