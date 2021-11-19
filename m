Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BB4C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EBDE613C8
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhKSU3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbhKSU3f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:29:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0506C061748
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:32 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso8435202wmf.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QE6994fTb5NMjei5kwjNFNhLxOamiXDYIwmi5GcfL2c=;
        b=LqYzMTDTpM+qP4GHFbhF8IFrprM/wLoEHHKYmlhDiS5BITap1Q+3LKGF8N1E+VmX7U
         PEttszh2xPgIHkg6CmPDUx64RxBJperF0liEXNgRHPwrIjYSZU5L7vd1/m+RVakqfl2W
         wCGGY5dCEKuu5h0UnF0CsuggI1gLcuEtQqQzm4RqQHk76v0j//8mGKZ6Zumy+jV4kLdD
         7YW6+oK0JXopDV9ehiw3/HGlzbITzf/wpuFHbT/9IC2e6IJh2L052XWRK0nzyCKDubXB
         oXWbXF+v4fEQN98GbQv2R2ACPRED0Va7pW3WI0IlegCdHXuaxGIFN5FhKL0IE7khCtuK
         a6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QE6994fTb5NMjei5kwjNFNhLxOamiXDYIwmi5GcfL2c=;
        b=KorRwRhbQ74go/x+KiFiij+PLoOdm/LNd3YiTlTDWeEXh+GYsFCJLqJNBZ5ycVBRI0
         TauGTA8kfAohB0ns/4B047Kqr12YU7JN05/iKaBlH+dmLK0QTQlejuyES50yf+Pl3a3h
         pZSpiZbvF7p1cmrDWRb/VeByBonXEgNqFAlxpcrdIvYCaje85lPnU5LjdXfoYSFMG4JE
         vlt/rzfROxdaq1SSkIl3mi/kaUEMs6NMHGC8C5DAN4PGhDqK5uJAFfWCIXRAlRnsCw0I
         donD/nO1v8APkXqtcH3/m4JNVV2J4xz59TgSKnAjkh08sAeVUB+Q2Ha1j24kNds6Fyoi
         Xcug==
X-Gm-Message-State: AOAM531ZUbzZMDDOxqfYO7mZcl23IUojAZnXGRoazO+ggeijL1L4U9Tn
        GIY98KbtZEKn+/O6DblsaA85UP0gSWV8oA==
X-Google-Smtp-Source: ABdhPJz+f1oML4f8UJbta0vtH0l88QEsYqVM+6Ye1bhwvGxwrFcSJstIWHNhYzoR5EGe7F+TG9stmg==
X-Received: by 2002:a1c:96:: with SMTP id 144mr3131438wma.126.1637353590958;
        Fri, 19 Nov 2021 12:26:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg14sm856202wmb.5.2021.11.19.12.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:26:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] alloc.[ch]: remove alloc_report() function
Date:   Fri, 19 Nov 2021 21:26:24 +0100
Message-Id: <patch-v2-4.5-672bdffde83-20211119T202455Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The alloc_report() function has been orphaned since its introduction
in 855419f764a (Add specialized object allocator, 2006-06-19), it
appears to have been used for demonstration purposes in that commit
message.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 alloc.c | 19 -------------------
 alloc.h |  1 -
 2 files changed, 20 deletions(-)

diff --git a/alloc.c b/alloc.c
index 957a0af3626..bf7982712f1 100644
--- a/alloc.c
+++ b/alloc.c
@@ -122,22 +122,3 @@ void *alloc_commit_node(struct repository *r)
 	init_commit_node(c);
 	return c;
 }
-
-static void report(const char *name, unsigned int count, size_t size)
-{
-	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
-			name, count, (uintmax_t) size);
-}
-
-#define REPORT(name, type)	\
-    report(#name, r->parsed_objects->name##_state->count, \
-		  r->parsed_objects->name##_state->count * sizeof(type) >> 10)
-
-void alloc_report(struct repository *r)
-{
-	REPORT(blob, struct blob);
-	REPORT(tree, struct tree);
-	REPORT(commit, struct commit);
-	REPORT(tag, struct tag);
-	REPORT(object, union any_object);
-}
diff --git a/alloc.h b/alloc.h
index 371d388b552..3f4a0ad310a 100644
--- a/alloc.h
+++ b/alloc.h
@@ -13,7 +13,6 @@ void init_commit_node(struct commit *c);
 void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
-void alloc_report(struct repository *r);
 
 struct alloc_state *allocate_alloc_state(void);
 void clear_alloc_state(struct alloc_state *s);
-- 
2.34.0.823.gcc3243ae16c

