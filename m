Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA42BC433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiCYRak (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbiCYR2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:28:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904BCFE424
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so4817019wme.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AblYUYmyG6Os5E02ikHkP4bYaFKzxy1QO/EzepoRnm4=;
        b=nYZv/9eHiB5/RTnR/g2m9eBSKWzDMYI35WLQ1rk8yjzFqJwGq8H0EBqWU605QugoyU
         h61eHUFYkf+vgVThBuP3Ck2U25UD4u1g7fZ39aPUgTLf4mJLbRNjrb6vlizshhSAP88M
         SnkUtHZiEKh2N6z9tcd42IHCahuE2Kjgb6HW4arCBHxRsmc4CIn6WT/dDdqEYVtxu0r2
         dKmrw78RfWe080UMjsLW3xbQ0NxiWalaYAGkbrqH8KMnvPVMC4B6UH8tnfI0cnCrCeMs
         QWPeEUaYnLn7sjmIY4QHZXIL6zc32BDufEJyICBCrWEDcAOd90YRpXnggwhP9saZ/qF/
         7dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AblYUYmyG6Os5E02ikHkP4bYaFKzxy1QO/EzepoRnm4=;
        b=1+34GH7NBCqD3jfqc7oPyUOHEmEKVH4nOi+a69k9XhsaH3jLK3VatSe+6Kw5XO+uSB
         cSmJhCRNflRDT/gi47EKGN3w+yxovROXuFOK4D5rR5r4v8VvI4iGZm1OTTm36Jg/3FKY
         VrrYZ642oHHOcDtwByZP9aOZSvfqRI+7eqTPQvN9Io3iS9zkAiMiRdrq89jJoTAmlrFB
         XaOTO2xZlOlnXLZqDF8ZW41C7mVrmD8awrJXxwakuZepJYFz8qkbAPVpWCUSTGLP82zA
         Z9YxuVmP9Knw3DWvEdwSAFp2ANbSyP+71aNfTDwAFbW44eMH/jsaPwRXYPsvJOMp8B4s
         J1Pg==
X-Gm-Message-State: AOAM531iO6SoB4LSw+wfBk2oaqHzhyAlBHlslzXYz5fHV8hKJTYjtE57
        6fAQcLVQSD4QC19f2JGySHel13QNw5i0Ag==
X-Google-Smtp-Source: ABdhPJzBmQMvQZrp2t2gic7mqkuLdhKx12Muj712cLTMMKRyW+rWROE2UEC1xRx3zYBMU2EdpmilWw==
X-Received: by 2002:a1c:f315:0:b0:381:1f6d:6ca6 with SMTP id q21-20020a1cf315000000b003811f6d6ca6mr20813153wmq.25.1648228785041;
        Fri, 25 Mar 2022 10:19:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:44 -0700 (PDT)
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
Subject: [PATCH v3 14/27] revisions API users: use release_revisions() with UNLEAK()
Date:   Fri, 25 Mar 2022 18:18:38 +0100
Message-Id: <patch-v3-14.27-216eb3b41f7-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
2.35.1.1509.ge4eeb5bd39e

