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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F410C433E9
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2871365229
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhCHPHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhCHPHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2FC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l22so6260872wme.1
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fp5bPLAzp8al4K7NhdNtDrIXlPwcTYIwQbVmRRryFuU=;
        b=TcMWRIIm0qVwhFItEUi4J8CzL2YK/DONVONo8guOKgur7czwFh3scP5OoI/unlHr+g
         4zY7xWjIPkoRxNU4KWXhycqobOe6mebSq10qqzj6a87/JOBwffEpqc9fikLL3adXBfpt
         elOsogvpcjElwcmFzHCKTh8Fm+06BTXqwcxZcWO9w0j4ZsmR5qFluKQ/388pYN60BZ9d
         AbZXNeS51Mw9eH+UXntVPhsX8sEvonk7JiAAL6pVpTfGzTnR6SujgFsr8DBNsJuSQWcV
         vfGlm4LckeQRtxxSL0Afg/b0lRhKoWVKLQ/A9UrclUTdtNkD94EfcJ/ysFmZFzxXaYxA
         G4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fp5bPLAzp8al4K7NhdNtDrIXlPwcTYIwQbVmRRryFuU=;
        b=uSCuTWxhQcL0p0pPl9jsuaEihSF0DaUPri3nHtBHm1aF9/1WwkXmJMYx5ZnmSHfuWz
         9jd0Di5bEuCrKsbGxq6S4GM8k6veBfqbU97YoX+ubdxy/QkelT+lOsS48EOnXYxKKmBz
         VeTUAdQ50cEFroIDExH1QMu+tqsgZ/1bEoQ7PtYk8MclpYKJwrR/G1UvDNUzL7xUVClx
         NyGaLQgIbKQkM9W/pNy4VEWX/+fHy/RErMkYMBondkijpXEj0lxSNIcQckzDZ3MMX54Y
         MZc2IgG1BvH2XYR4SfVCah1GbIEYa3+0E22oDeFAy+CYO8qNPCa2uPh2SlRro4Z5/5WL
         +htA==
X-Gm-Message-State: AOAM531/QHPcsLHad77y+1ZIPCxiSTvYJ/Y2gxaVCLDP8bq/hYCW1bun
        thq1p62dkbH67yNSjmKaXpIH1eXquWUDPA==
X-Google-Smtp-Source: ABdhPJz1InqGlkddGuzTSZ7xZRFc624Iz8ZI3njwACUu3AfevCHHYLvL+7DuQ/qfbcoSP8mNsZZjEQ==
X-Received: by 2002:a7b:c3c1:: with SMTP id t1mr22389295wmj.47.1615216031527;
        Mon, 08 Mar 2021 07:07:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/30] cache.h: add a comment to object_type()
Date:   Mon,  8 Mar 2021 16:06:23 +0100
Message-Id: <20210308150650.18626-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment to the object_type() function to explain what it
returns, and whet the "mode" is in the "else" case.

The object_type() function dates back to 4d1012c3709 (Fix rev-list
when showing objects involving submodules, 2007-11-11). It's not
immediately obvious to someone looking at its history and how it's
come to be used.

Despite what Linus noted in 4d1012c3709 (Fix rev-list when showing
objects involving submodules, 2007-11-11) about wanting to move away
from users of object_type() relying on S_ISLNK(mode) being true here
we do currently rely on that. If this is changed to a condition to
only return OBJ_BLOB on S_ISREG(mode) then t4008, t4023 and t7415 will
have failing tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index d9281496140..e513f0ee5b4 100644
--- a/cache.h
+++ b/cache.h
@@ -451,11 +451,16 @@ enum object_type {
 	OBJ_MAX
 };
 
+/*
+ * object_type() returns an object of a type that'll appear in a tree,
+ * so no OBJ_TAG is possible. This is mostly (and dates back to)
+ * consumers of the tree-walk.h API's "mode" field.
+ */
 static inline enum object_type object_type(unsigned int mode)
 {
 	return S_ISDIR(mode) ? OBJ_TREE :
 		S_ISGITLINK(mode) ? OBJ_COMMIT :
-		OBJ_BLOB;
+		OBJ_BLOB; /* S_ISREG(mode) || S_ISLNK(mode) */
 }
 
 /* Double-check local_repo_env below if you add to this list. */
-- 
2.31.0.rc0.126.g04f22c5b82

