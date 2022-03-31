Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55445C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352290AbiCaBOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352259AbiCaBOE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F466220
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r64so13309494wmr.4
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ci/TSsGD1P+7zxosk2aa8M0xbOF6Do4roIg3/ungxg=;
        b=eUXNMcKMK1119/iS6x3A4YYNHVjufxx+9n1nZQT5ijv9iOb49+V3FX/7ZlD21yzMMQ
         eOXovtxN2WFknzOGaXQn23Mqw1D6lM/wSnU5k7t9AtGDAJJw8t/CIof6vHur6Nc3vaQA
         gHU4thMQMTU7Tyn15sGSUnDbAImcci7nHlfnEhnL+yer1JoZ2firqft1eQihJZ0t5RFV
         apydZQSHvf7Di+ASDhGU4+6G37o0GIlBzOr19AY5a+j2gZ5qveCGMUR/6pahRZTeBUNc
         aGa/yWncwwNsMtdFMhwjFoVJ77zA76JYv3HSQn840EIXkxxP8yBxG9abcmpWk8dGJ9XZ
         Fw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ci/TSsGD1P+7zxosk2aa8M0xbOF6Do4roIg3/ungxg=;
        b=479f3NLjPpUE4tRc5L7iCap+sT64hR8MVHJsEa2YmuRlgmzR5Lpv25Uid6Z3yVIiKt
         L7ieAQTmeOGNniFWyt2OyWrK2LJdPNXf9Z84JkkDZYxFOgyuQCKC4N8ULs3pMWcWkh5U
         G71152L3LOFsn0ydozRCTKDPkG+7ot3fFZJrnS42oYLUTnyYiCKwj0Aq2fBxtq+QDDYT
         XProqBSOD3LPjzymjTTRXklvEnXxEm8H5amS9e9Ml13DpwYi4Wsb+wLUg9tkndGhSts+
         lFSkJmjKwqSZBHKOiljsBD9th+7G4qjR52tug4vOgPdXfGJiA8eSuV/3rwIiGAtlW4L4
         kaBA==
X-Gm-Message-State: AOAM533KEIetHMoeqM/wCbdHnkKP0SuCwSGCaLgHr07uiVNPdVsyXekj
        rgkb063+cFsPRNgY7hL19b/Lotmk8YgCsw==
X-Google-Smtp-Source: ABdhPJxGcWAauTJoTXAszvtv3i4ke8jVeUmVLJ9I9TYdq4kkc5MmwUtkAu6ZRXng5oqOirr9Bb6Yvg==
X-Received: by 2002:a05:600c:5023:b0:38d:1261:aac6 with SMTP id n35-20020a05600c502300b0038d1261aac6mr2320479wmr.180.1648689136025;
        Wed, 30 Mar 2022 18:12:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:15 -0700 (PDT)
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
Subject: [PATCH v4 12/27] revisions API users: use release_revisions() in http-push.c
Date:   Thu, 31 Mar 2022 03:11:17 +0200
Message-Id: <patch-v4-12.27-6e41d666223-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
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
2.35.1.1557.g4e3e9cdb5e0

