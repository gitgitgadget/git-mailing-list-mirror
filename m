Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C9C4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5C8610F9
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 10:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhH3KsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 06:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbhH3KsR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 06:48:17 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297AEC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 03:47:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v10so21777228wrd.4
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ee6C527tRpJVQ+uEy84krbvGXn5SUsspleN+3gUQp20=;
        b=M11rK+UgEjJab5re8cYicz0SqKfKekM1DWHIhsDsHQwBHKF+GMN0MS+0jJv07kpHMB
         RzIc1ve2v8uHFb7kJ0XFHefC7wQmd1Q0YSsFP1pJg5PH96k0slwqxPNakHi6Xjry5E1E
         Hw+ImpjzekSl9LZkz8Tq5lzyEhnyKjzBQGXWFxUwmW4ff2qCfhy86C6+U2HlrZesxmZS
         PuqiX89IiXYTagzUI/KqbEC1eE4Dlu9C3q23GJD9VFTslap7F2Dd/RStVWoQQZgcn24B
         n1JC18E3RhI1t5KwUoDNk1/Gz3qssZpuT3lLVMcftd2+krB+XnzaY6kyi/T6+naoEQa8
         Nd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ee6C527tRpJVQ+uEy84krbvGXn5SUsspleN+3gUQp20=;
        b=IVgvlbX3ipMHxyleVQ3lY/gsfqpVg085il4cQLWn1aMvODfw/Hn7Nh3bDj3P5tDZGY
         wHIQYAOjZoiCwDmwUnD1hdgUH/jjhCLEWNrpDKSPjqna4k5TcOmrtK+vCkWKGSh4AtJL
         BtFyq5xzXy9nHKFDqJnkQ4mPWhsIdAG8cFOXSfgusQM4j4wgB0bjoTKgUhHzqHTdUm5k
         ElkVy9eygokdr45qnr9wsl0+aE+GpCjZ8abfACWKtNfuVZtuOrqCeaGtezLAwchJifVx
         3eUKOeRyPsvwtcYycp3JEGbOCOVzLDZ64tzpsAs1ILDbTFc2oyH5qA5X9s19CCPAzj4P
         5RDg==
X-Gm-Message-State: AOAM5319JG5+JxsJNYr1aCMoVibbhH1oeLUjPqDnI204+qf3Uoq28ihG
        a76m4syZkikWh3Of4/d910IX2ZDJbtMFJL0A
X-Google-Smtp-Source: ABdhPJyM+iFvV0cpN6e8XLDbuGS+W0mV7UyK3KhkCCll8TKrKOPQcVqaVjJnBFTC3GI2BHaHvusEoQ==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr25145222wrp.351.1630320442483;
        Mon, 30 Aug 2021 03:47:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13sm15509057wrf.55.2021.08.30.03.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 03:47:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 1/2] t3303/t9301: make `notes` tests less brittle
Date:   Mon, 30 Aug 2021 12:47:13 +0200
Message-Id: <RFC-patch-v2-1.2-5a1ddd30859-20210830T103913Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.737.g0eefde7d76
In-Reply-To: <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com>
References: <20210830072118.91921-1-sunshine@sunshineco.com> <RFC-cover-v2-0.2-00000000000-20210830T103913Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

These tests care about whether intended notes-related functionality
occurred, but they check for the expected result in a brittle way by
consulting the default output of `git log` which is intended for human,
not machine, consumption. Make the tests more robust by requesting the
desired information in a stable machine-consumable format.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3303-notes-subtrees.sh    | 13 ++++++++-----
 t/t9301-fast-import-notes.sh | 36 +++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index d47ce00f694..abffa105645 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -171,13 +171,16 @@ INPUT_END
 }
 
 verify_concatenated_notes () {
-	git log | grep "^    " > output &&
+	git log --format="tformat:%B%N" >output &&
 	i=$number_of_commits &&
 	while [ $i -gt 0 ]; do
-		echo "    commit #$i" &&
-		echo "    first note for commit #$i" &&
-		echo "    " &&
-		echo "    second note for commit #$i" &&
+		cat <<-EOF &&
+		commit #$i
+		first note for commit #$i
+
+		second note for commit #$i
+
+		EOF
 		i=$(($i-1));
 	done > expect &&
 	test_cmp expect output
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 1ae4d7c0d37..123323b2bbb 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -259,29 +259,31 @@ EOF
 
 INPUT_END
 
-whitespace="    "
-
 cat >expect <<EXPECT_END
-    fourth commit
-    pre-prefix of note for fourth commit
-$whitespace
-    prefix of note for fourth commit
-$whitespace
-    third note for fourth commit
-    third commit
-    prefix of note for third commit
-$whitespace
-    third note for third commit
-    second commit
-    third note for second commit
-    first commit
-    third note for first commit
+fourth commit
+pre-prefix of note for fourth commit
+
+prefix of note for fourth commit
+
+third note for fourth commit
+
+third commit
+prefix of note for third commit
+
+third note for third commit
+
+second commit
+third note for second commit
+
+first commit
+third note for first commit
+
 EXPECT_END
 
 test_expect_success 'add concatenation notes with M command' '
 
 	git fast-import <input &&
-	GIT_NOTES_REF=refs/notes/test git log | grep "^    " > actual &&
+	GIT_NOTES_REF=refs/notes/test git log --format="tformat:%B%N" >actual &&
 	test_cmp expect actual
 
 '
-- 
2.33.0.737.g0eefde7d76

