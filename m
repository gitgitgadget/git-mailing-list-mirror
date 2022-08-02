Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B87FC19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiHBPdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHBPd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:33:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47545CE35
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:33:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v3so17442522wrp.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=d7kjvel9rdFx/1jcdb5+1teFxvhWl6d2tKQUdZlKlUI=;
        b=THj90YJBSpuGCfHk4S2d1mSjWzl7DZPuhDKkwrYGHmoTLHQygZ0z3A6jONt0ncUbKn
         u1ZSp+MG5AThYjUWlTne7z08Z3cGNAGLxxURGO7pdNLhaVpPTUWIsXhWUck1z/ckcFrJ
         ziIA2oOwAL+LxfEiUqAVPQ9gr1oM40HJlYQqqFFAeGWIfq3jxXt03wlZg92m6EXXaYtJ
         oamYmnZzHDch99ieQw/QkHSifGRgQWFwyBaFZvLEjvvmRBLJ4HUd0FIqvhhkqHEvqeQm
         X6YxugmaTMylXbvW4odcSYF4QJNQ/Tmvmpquj/J/LUwwVMsZzQVyN+KAYUkT2jgZiefq
         pDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=d7kjvel9rdFx/1jcdb5+1teFxvhWl6d2tKQUdZlKlUI=;
        b=sGvaqgOdEiN7K9ITtX+HDkEDjiPM8wFigIpO8NxezWiHiZUiPoMANU5PcYDc+18hTy
         WQB1CfgDh9CQXAdWMBa01fPSXxag0l5FgQ9/4pxn23v/Wu/QWX39XNqxpuzkhugj1oJn
         qs0QTuvoy/m/LNK2r5hU087du5U40+wQLZFpFg0GDBGwQM9PQaVUBWwNlh8nP4oJireM
         mHZ7vsPoi14WGBbMfX7zqIIiNSOKbqVBajizY9Y6cbvGTmlG0jm1Vf5FitRYSFfvK8h1
         vQhDgaqr4rcfTVUDuYBOYZyTfWq4Sy7OdG8JliGDVNDu7amoN26vZimUJJB9mhQs7GAn
         Xrlg==
X-Gm-Message-State: ACgBeo3be233Q53Fg+l8EMyczKkOu5Jw1RvU08V9LtWYqyP4u66moEIj
        X88SoV+sxvSV+jmNhpbjJ0jumJ50QFxfuQ==
X-Google-Smtp-Source: AA6agR626TABTVblex/3wCYSWnj+mi9Mz0F7HPdtOmxJpUlqFCISuE5II4UN4wVTgumzT55wXTAo8Q==
X-Received: by 2002:adf:f386:0:b0:220:44e9:ea5 with SMTP id m6-20020adff386000000b0022044e90ea5mr9669639wro.555.1659454407501;
        Tue, 02 Aug 2022 08:33:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y7-20020adffa47000000b0021e9396b135sm15332531wrr.37.2022.08.02.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:33:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/6] bisect.c: partially fix bisect_rev_setup() memory leak
Date:   Tue,  2 Aug 2022 17:33:15 +0200
Message-Id: <patch-v3-5.6-dae5872e722-20220802T152925Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Partially fix the memory leak noted in in 8a534b61241 (bisect: use
argv_array API, 2011-09-13), which added the "XXX" comment seen in the
context. We can partially fix it by having the bisect_rev_setup()
function take a "struct strvec", rather than constructing it.

As the comment notes we need to keep the construct "rev_argv" around
while the "struct rev_info" is around, which as seen in the newly
added "strvec_clear()" calls here we do after "release_revisions()".

This "partially" fixes the memory leak because we're leaking the "--"
added to the "rev_argv" here still, which will be addressed in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/bisect.c b/bisect.c
index 421470bfa59..6afb98be7a1 100644
--- a/bisect.c
+++ b/bisect.c
@@ -648,11 +648,11 @@ static struct commit_list *managed_skipped(struct commit_list *list,
 }
 
 static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
+			     struct strvec *rev_argv,
 			     const char *prefix,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
 {
-	struct strvec rev_argv = STRVEC_INIT;
 	int i;
 
 	repo_init_revisions(r, revs, prefix);
@@ -660,16 +660,16 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
 
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
-	strvec_push(&rev_argv, "bisect_rev_setup");
-	strvec_pushf(&rev_argv, bad_format, oid_to_hex(current_bad_oid));
+	strvec_push(rev_argv, "bisect_rev_setup");
+	strvec_pushf(rev_argv, bad_format, oid_to_hex(current_bad_oid));
 	for (i = 0; i < good_revs.nr; i++)
-		strvec_pushf(&rev_argv, good_format,
+		strvec_pushf(rev_argv, good_format,
 			     oid_to_hex(good_revs.oid + i));
-	strvec_push(&rev_argv, "--");
+	strvec_push(rev_argv, "--");
 	if (read_paths)
-		read_bisect_paths(&rev_argv);
+		read_bisect_paths(rev_argv);
 
-	setup_revisions(rev_argv.nr, rev_argv.v, revs, NULL);
+	setup_revisions(rev_argv->nr, rev_argv->v, revs, NULL);
 	/* XXX leak rev_argv, as "revs" may still be pointing to it */
 }
 
@@ -873,10 +873,11 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 static int check_ancestors(struct repository *r, int rev_nr,
 			   struct commit **rev, const char *prefix)
 {
+	struct strvec rev_argv = STRVEC_INIT;
 	struct rev_info revs;
 	int res;
 
-	bisect_rev_setup(r, &revs, prefix, "^%s", "%s", 0);
+	bisect_rev_setup(r, &revs, &rev_argv, prefix, "^%s", "%s", 0);
 
 	bisect_common(&revs);
 	res = (revs.commits != NULL);
@@ -885,6 +886,7 @@ static int check_ancestors(struct repository *r, int rev_nr,
 	clear_commit_marks_many(rev_nr, rev, ALL_REV_FLAGS);
 
 	release_revisions(&revs);
+	strvec_clear(&rev_argv);
 	return res;
 }
 
@@ -1010,6 +1012,7 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
  */
 enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
+	struct strvec rev_argv = STRVEC_INIT;
 	struct rev_info revs = REV_INFO_INIT;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
@@ -1037,7 +1040,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	if (res)
 		goto cleanup;
 
-	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
+	bisect_rev_setup(r, &revs, &rev_argv, prefix, "%s", "^%s", 1);
 
 	revs.first_parent_only = !!(bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY);
 	revs.limited = 1;
@@ -1112,6 +1115,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	res = bisect_checkout(bisect_rev, no_checkout);
 cleanup:
 	release_revisions(&revs);
+	strvec_clear(&rev_argv);
 	return res;
 }
 
-- 
2.37.1.1233.ge8b09efaedc

