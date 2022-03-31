Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B04AC433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352263AbiCaBOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352244AbiCaBOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:14:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831976623D
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso139735wml.5
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRK1hdwCkLV56UWP+U/+ujnXiMtKlfgwHf1iqIM8ckg=;
        b=GJ7EyVlCihk8IShRhEw3DHcaH4hwgtyr93ATWZsulXjXtwOsOqnoKdd+C0IRidW9wo
         V8aqZbcWjSciG4WkKOJILujRwVSsfnXJC1DS3f3B5fHhbswqlL3B0VxUcriy92zxQppw
         6YssEs1lOx7cun4gN69WLD5VPYCpgXUM/8ND4GBc2Q0AfRDvnNVScMIdl7xvPY5ZGc8P
         X97+x4sO2FTFAvZ551DRfp7+Y9t+HuNfIUcR73AsZT1C93iMc/vQcelBW5JWgCy8j1ux
         kdQroM8/RyQvWG74H8mMdeXrIXpeBtu+3+ur9+jvNm/a14OOFmIaHOnDDK+JxIO363IW
         zzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRK1hdwCkLV56UWP+U/+ujnXiMtKlfgwHf1iqIM8ckg=;
        b=MALZV+/zkDu9vSkSebbDok/bcge9/qkqDwHL81nphtHKaBo/FmeCzRLw9CgJdpdPNo
         OrEl9/xHUmGMbIwccAz+ZcKofhTzqN5SA+ksCnJ9Nar2m20New6x+uCUfTXfi/Elmyuj
         d/O3+beKnczhUdFju1ry3oCFETzT35ffJgjRycI9pjK3Q1EQWnpEN8N4ol3Q0OZlKj3o
         M75PBOmYxqtJtQ1CFH4a8smM9MzQ4AwiSW4FDH6vbP2APPyZk7zHl3mM4qOnmejXZ0fw
         t3Lohu+e3Jecq70E2QSM5v4QaO7tBgthd95s/0BXjKVR29hDSy3iIo2E/pMAW52lLKzM
         0oAw==
X-Gm-Message-State: AOAM532U0gJm04pCddAewmtEJFofS48sJ/Abo4QDE9tn8kbhKmcijM11
        KeZtmfg6fEtpBJ7kFMdNV7tMgfO5EHVwHw==
X-Google-Smtp-Source: ABdhPJzSiZouf04b1ZjAAXela7o4tv0amYskJOhZMCt3nha7Z6ZlAkDIjkDmevJRR6A9f/ivaya8sA==
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr2473770wmp.41.1648689137843;
        Wed, 30 Mar 2022 18:12:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c26cb00b0037ff53511f2sm5789218wmv.31.2022.03.30.18.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:12:17 -0700 (PDT)
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
Subject: [PATCH v4 14/27] revisions API users: use release_revisions() with UNLEAK()
Date:   Thu, 31 Mar 2022 03:11:19 +0200
Message-Id: <patch-v4-14.27-1aeb1127f34-20220331T005325Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1557.g4e3e9cdb5e0
In-Reply-To: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com> <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use a release_revisions() with those "struct rev_list" users which
already "UNLEAK" the struct. It may seem odd to simultaneously attempt
to free() memory, but also to explicitly ignore whether we have memory
leaks in the same.

As explained in preceding commits this is being done to use the
built-in commands as a guinea pig for whether the release_revisions()
function works as expected, we'd like to test e.g. whether we segfault
as we change it. In subsequent commits we'll then remove these
UNLEAK() as the function is made to free the memory that caused us to
add them in the first place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/diff-index.c | 4 +++-
 builtin/diff.c       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 5fd23ab5b6c..3a83183c312 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -71,5 +71,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	}
 	result = run_diff_index(&rev, option);
 	UNLEAK(rev);
-	return diff_result_code(&rev.diffopt, result);
+	result = diff_result_code(&rev.diffopt, result);
+	release_revisions(&rev);
+	return result;
 }
diff --git a/builtin/diff.c b/builtin/diff.c
index bb7fafca618..dd48336da56 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -595,6 +595,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
 	UNLEAK(rev);
+	release_revisions(&rev);
 	UNLEAK(ent);
 	UNLEAK(blob);
 	return result;
-- 
2.35.1.1557.g4e3e9cdb5e0

