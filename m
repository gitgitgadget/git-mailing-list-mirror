Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081ABC433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354490AbiDBKwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354512AbiDBKv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69826140767
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:50:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i27so3560392ejd.9
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5L0FrsIduO7fVZcb92ii8iUNtKfOS+FYzvv3S9IkP8=;
        b=CT8OzeMUACTqlMbJinNEPOTLmEucW1JXNL4P6yBDYiDuDFwywfieiTAGCn1xN6Wuh9
         zUEh7naSkNgVVqAEv5ldAhryly9zOwEblcFdFPc3apyrdNrJXdzjCi7BtzlmU4TQRO2m
         b8ig0H4SMyvifkRctPZl9ua6B2C5fQ+EOTCxKYiqVzMBytUU8t7SpkfoXJqXm6ap3+rU
         N/nz+OzHfILpQDWa4g/PybMyrzGu8g+gkgXkah68e6Wt2Z8ljOosNBMUtD9tGPlmCvm/
         JjpJWrKDNwgJpKdgxvs/K5Ft+ED5ThF+OvcVjkf2KWx+wOXgQqpxN8Z0HrJwTXUz3qLF
         iR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5L0FrsIduO7fVZcb92ii8iUNtKfOS+FYzvv3S9IkP8=;
        b=3PHNaHWCceyK4eSMyX97MEIi0IaqeKAHLNfy8BcieeB5ODTbzXX6SIT8SrAN+qn/P1
         +4fm2uETttWQvn3mYPZ7G35595ZwjRc56jTCgD6NoVTBdyUerxuR87Sx3rE0xd6Ds+yG
         7TJ6FbsDplfm8U55LDrTgxpjtzuYW+/efukUlVzkj/zPrHmw/gmkcawpBduiUWFFARKg
         h33dRKUiUJFmFmLVEzrUxvCvIBAxbxnxCFCFXHqUBUq2e9IbOJgxKzCG/dShZauHoaqf
         9BeqqzXBvNG+yx9wnAzBUBjZCWQiF0M/gbuSMDJcvR/Cy+ZqVlCCbiaDy2TLC7A4NMO4
         pqUQ==
X-Gm-Message-State: AOAM533NMQWoT6eZ+rV+jmIVopqi/XV6seeL9zStKiWgF5HMlI0B9rWW
        W6hGOAJ6wJU1Ojle4bDnOgDBdB02bXicFg==
X-Google-Smtp-Source: ABdhPJwC+Eo0T/MIRSd0UM5oLz+gkjKsMDQM7jZIihH13wWrWuRuK7WvUQlnG6lgVqDuN4vDj1u4Mw==
X-Received: by 2002:a17:906:58d2:b0:6da:b635:fbf3 with SMTP id e18-20020a17090658d200b006dab635fbf3mr3334338ejs.40.1648896598726;
        Sat, 02 Apr 2022 03:49:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 14/27] revisions API users: use release_revisions() with UNLEAK()
Date:   Sat,  2 Apr 2022 12:49:28 +0200
Message-Id: <patch-v5-14.27-ddc7402b054-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
2.35.1.1585.gd85f8dcb745

