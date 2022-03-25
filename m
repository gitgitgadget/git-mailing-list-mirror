Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A15DC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbiCYRe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiCYRe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:34:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1691207F1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:32:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso4812782wmr.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLgLvZ8qi6bBLJAakiJURVxLYnGiO4Y2ldzxBdQZqEM=;
        b=mUVvTMi0PWnriYNI/j1cFb4psiGBuR7KtMx9fwmlw5XWNa0w7ZbE6H7GUeMHfy2z8+
         Nj3fsmoZJepvBB1yZMm7ye5DnKTOIH6nxirQrqi+gDJ//xoWUaR4dy6bGecZFB5Byhs8
         evyiZzN6cbd/WsQdzmCLSqB4veeFZowVQNnm/tlX6hOTrvJNASNqyY4kDhI9+dcE7kvO
         E7x9vhpOgyu7elY0UYRfhLjcTGij31/9FiBKG1U4hGHVlKeqZUdPBsP0DoYXbdl3YFgc
         zF5wwpFI19qaYJLDAE3rudF6Xma/zzzHx5li9zjIXv1P6a8TvP5TQXstUOq8Am1z83bU
         YEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLgLvZ8qi6bBLJAakiJURVxLYnGiO4Y2ldzxBdQZqEM=;
        b=Xu+wO2VlbY1hA5MG/ppnlj+4+g+Qn9EOCy0cY9ZkjWKGlO62z1thr8gJO7TGDtNhBF
         hgU8QDOD+u79q8hK0ckLRALVGgEuK/fWbHEfShELnypq5CMWqKGegG6sr2ppetDov4Gt
         LVdXf4Xjse0u3dwJB+R6fEw8Ov8O4ORGj0AUUmMhm80N7tp+kTn00sGJ8JjxT+vOKUnk
         BIXRiUnC7WgpD9Cb4yNZ+VPzizcNQ0PeEOc4x0A+FbesqUIP0tYJOc3Om05m3c9jrJMC
         DZW3OoRt/YbageqeRe8Huds3ngnU3mQJvfsAmWEOET3+MVdzxjsOkCedT4rHdNApns1Q
         /G7Q==
X-Gm-Message-State: AOAM530llrbeIFG8IgJlGeB3TvB0qfDacc5XSxzJNlkPmYwIJ2TIfhTL
        syTorUiaMsEFzut8yTDTYF19dvRFibw7Yg==
X-Google-Smtp-Source: ABdhPJwEzbucYySEFvd8JSvsdwjZGRasYBfV74qUKasvrxNtA3ivG4eXYQolN7fqrZ7j6B+XY1yPyw==
X-Received: by 2002:a7b:c30d:0:b0:381:4bb9:eede with SMTP id k13-20020a7bc30d000000b003814bb9eedemr20237355wmj.74.1648228783148;
        Fri, 25 Mar 2022 10:19:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/27] revisions API users: use release_revisions() in http-push.c
Date:   Fri, 25 Mar 2022 18:18:36 +0100
Message-Id: <patch-v3-12.27-b6acc61fb61-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of cmd_main() in http-push.c we need to move the
deceleration of the "struct rev-list" into the loop over the
"remote_refs" when adding a release_revisions().

We'd previously set up the "revs" for each remote, but would
potentially leak memory on each one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index f0c044dcf76..01e7c2ac5c8 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1689,7 +1689,6 @@ int cmd_main(int argc, const char **argv)
 	struct refspec rs = REFSPEC_INIT_PUSH;
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
-	struct rev_info revs;
 	int delete_branch = 0;
 	int force_delete = 0;
 	int objects_to_send;
@@ -1825,6 +1824,7 @@ int cmd_main(int argc, const char **argv)
 
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
+		struct rev_info revs;
 		struct strvec commit_argv = STRVEC_INIT;
 
 		if (!ref->peer_ref)
@@ -1941,6 +1941,7 @@ int cmd_main(int argc, const char **argv)
 		unlock_remote(ref_lock);
 		check_locks();
 		strvec_clear(&commit_argv);
+		release_revisions(&revs);
 	}
 
 	/* Update remote server info if appropriate */
-- 
2.35.1.1509.ge4eeb5bd39e

