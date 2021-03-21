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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF9EC433E3
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0DB601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCUACK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCUAB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B18C061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t4so2419447wrn.11
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gVom+Y8fPmmqcyhJkpXP/lu/6g069lTjvPp3uzuLlSY=;
        b=V0fm8sGKUI7IEmqxdBKyCA9ok7LJ6RCl1aSLx1XmwK6PuK5gbc/do7b9ztHPD22+/s
         OX6F1f18eKMRpINCs6ZoxP9W6KQXzRUOb1V+CeFsk/jVh4gxstEvugr1pkusiNa1gsiI
         PFQBlHbvlvz8QrlPhAQeoxDivOTFWhOXYU7AyQ0jd6anZaOL2DXPPHsqF75oxP5o2hmW
         n9rfZzdNww6SFjTyUrCIFLVuLctk3yttwkFcitRmwBmIVkbSDb+ruHSY74nSsAIFj0rt
         V/hTdVygUjU9bHfHGgqOWj+EvtoOw5ezKWK1t6UFvPJmBrQNF0LWTglRNdKKn53e7fp6
         N0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gVom+Y8fPmmqcyhJkpXP/lu/6g069lTjvPp3uzuLlSY=;
        b=r8GZ4W9Mnl8iLwnPm19/897gz7cFea/4NEbqmAJmZiQkSio4b3+qecnHAJcAJgJ1qN
         mOnaA6x2hldui/bxF9LU2wrFLfsbAhqFpW9DCwGmWSgKgJpAo3DZGZCyV5rsV7o+yJs+
         0ZvvcPi8FppW5UEfIgqsNM7ALCEHjdtbXq5Qtv7Ma06UHEB/HHlmYp5vppKGTVraHmql
         6dffnadshwll0UvqHw4SXC6hfOMjqchQ2y/FEdq9MJxfyJCLGgJezPWl5A3ryCTJV/46
         W6QWLglTzL+ejM28pg/esPYxcZsc5IZoysoG7lU3hPjF/KrFNseOmINO4pFBgB2ZZrre
         Ow8A==
X-Gm-Message-State: AOAM532ysPMR6jWT7Elote3pJiI9ktC+1EEHTFKj8MLFbg/Xk+t2Hx32
        8/7BOS+9j/eCPUp5wMM0apIit2sXhufYUA==
X-Google-Smtp-Source: ABdhPJzdw1yGOUpLE/MyObtmiRk4XH5cyx/G9UfyYhj7g3R07huNDao1ILSPtNVGFAGvhbNxe/LngQ==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr11161598wro.350.1616284887904;
        Sat, 20 Mar 2021 17:01:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:27 -0700 (PDT)
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
Subject: [PATCH v4 02/29] cache.h: add a comment to object_type()
Date:   Sun, 21 Mar 2021 01:00:35 +0100
Message-Id: <186f7a7a44b7d296b83421d703c74be5668b5d8a.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a comment to the object_type() function to explain what it
returns, and what the "mode" is in the "else" case.

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
index c2f8a8eadf6..ae0c0bef5c2 100644
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
2.31.0.286.gc175f2cb894

