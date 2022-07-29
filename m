Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E20CC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiG2Ib1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiG2IbU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:31:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89DD7CB52
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q30so710699wra.11
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZbQrIkEZG9o88Rt+ybtdzT1282jAajqOmt8B9AUkda8=;
        b=RvMuEp6iWwm23jwfp7nrtlTSAYNR+YiIYWgIbSgQOdhA24l31alCloC0oslKZHkKog
         LDMRiDiHE7aWwtesLwfxzv8g4frIm9ezBjLR8vMNzaMiMiyZpUp9Jy1VnuXBUOAFywH6
         NFXuV6x23hXQE/Bd47I/rhE+auUDkFZgv9BD8aWlk5MNnyuB2mmjXHZRWrN2kkAI0eKt
         pN3yT8L9/SQRxqBbw5g9VUpfxc4NVZIalm42DltS0SMSaDm6G9dVBP0PJkkuUWVf0sAK
         qKBnRVoA4F2LSXCQNNBfiGYfWTy+RNT7gpsCtXG4dLNZ1rWXz5mnJxtOqsnEBPBk8BuI
         ClHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZbQrIkEZG9o88Rt+ybtdzT1282jAajqOmt8B9AUkda8=;
        b=th5Nc/wrRPMf8x7VOgBZV939G9gNQAEcxbOuX/5C3GVVf7JTJeveVDurfb2rv8RRmw
         YBAkpTaa3KOCL5tr0zJQXWL/KzwqAA8x/npfj4sK0f5I2v5PcloH3gn5AjmL+DeDFkAF
         JphD3wfnmAu5G2yJiznbGo4wLoPUuwDACoUNDnDP1rRVjT5op02IaFm2AzB7fER2tkEw
         ZeaGqhMY3JJZWDUa83aiqmiSFlVfTqySzcXTA0/AMixkKiKO5Ygs+HRv6utnkTRGZOv8
         ANA0NTLV5pXpveQQWuPCgdeFfi05yaJPbYmuWGYKCVlD5QZqL/6wSNAvNTBD9bH+kOZy
         4JAQ==
X-Gm-Message-State: ACgBeo0yYJpuX2yPCDWId40A8+5zTvCaEjHoegUiFQRl+hcNQkBHsyRV
        lgIZ044xsDv89QaZ0FZ3LfiqQEMkhgoBFw==
X-Google-Smtp-Source: AA6agR71nyzaObUSNqL+aff0c+jPsGlbp+tB1yO75jL4V2+GP+nV1iEDC7NdN/rde6e028GukgKAOQ==
X-Received: by 2002:adf:dfca:0:b0:21f:c93:5c36 with SMTP id q10-20020adfdfca000000b0021f0c935c36mr1591183wrn.41.1659083476666;
        Fri, 29 Jul 2022 01:31:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13-20020adfe90d000000b0021f0c0c62d1sm2325467wrm.13.2022.07.29.01.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:31:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] bisect.c: partially fix bisect_rev_setup() memory leak
Date:   Fri, 29 Jul 2022 10:31:07 +0200
Message-Id: <patch-v2-5.6-2af2bce2d17-20220729T082919Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
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
2.37.1.1196.g8af3636bc64

