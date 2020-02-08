Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DAEC35250
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B7D22522
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7i8U+1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBHJIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54768 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgBHJIc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id g1so4824845wmh.4
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cidQ2/1P7oKcKMitQp8G7KJy2dGBePySTf6krnU+sU=;
        b=Y7i8U+1tj2OMRWDUAg2sL+IapXnnuj3kXd3BVkM/gDmFXG4zISVXPUG45tNTwu3pcW
         FlU0kHg7XbSjn3HAUzXdr8VQtjmSR4Rq+v+0U0EYcOuDqND20se8K5EzFZyi9vgyHnYz
         k8fyYSgGU1N9j0mK2HeT9A8gXrSkUIfUgs3LjZAwXjhksHop/1Ww3DZiAJeChPh9zlTq
         lADFmMZiSmc58cRG5kF8cAhfCmABBNrx3fiDQF3nvis+tZPTfN7Z96TJOu0OrVvbWTpC
         nFy0Qtt7b3P77BNRK/2+h4qPDackshOwjTOfwIOuFlcex9ncQMJ0b7McUGdB0bmPSXP+
         d0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cidQ2/1P7oKcKMitQp8G7KJy2dGBePySTf6krnU+sU=;
        b=CJ3Z0r5xhsCjaZZJ3ltsONkzbWqQjGIonhNfX54ai9SwVoYtCDEM5uFPg/kYSwNFGF
         mJsFIjOOfZHzttYqAFGhkjoSGMl8ukjeB+KEUpMnO9zsK2iLusm5KcDm67m8hAvWHYVQ
         M52xmBMzVYIR14rtW8//+KgSSrxH50GWBuujOg78IaG0i73xxRMxzvZQgLOkegjWvxHH
         CEIi0wslVRPXtOR/ANhlniOygMNqGyVO2m2uQmhoLugqxVVv7z1l2EqktHOEpCuX4lFi
         T7Jb3+cSLGm+9WfPeh/xjhSvYurRsNy4vxVoBMaF71wZ1rrqlWGXSBYdCkJfzzG0lNjj
         f63A==
X-Gm-Message-State: APjAAAUTWeqDojQQiJIi5LVsV2HGisO3um8toi/LmML4UloCCMEn58zu
        Xx+pwYRsF8vKFPc1BVEMGsAdwscF
X-Google-Smtp-Source: APXvYqxplu5gOsMPSwQf4ogr68ka7FSJ72zVA/nsaWv5AN9tZ+ydHA+fwwcUZsjy5yuPv/E0lsbcuQ==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr3608395wmj.100.1581152909620;
        Sat, 08 Feb 2020 01:08:29 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:29 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 05/13] bisect--helper: introduce new `decide_next()` function
Date:   Sat,  8 Feb 2020 10:06:56 +0100
Message-Id: <20200208090704.26506-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

Let's refactor code from bisect_next_check() into a new
decide_next() helper function.

This removes some goto statements and makes the code simpler,
clearer and easier to understand.

While at it `bad_ref` and `good_glob` are not const any more
to void casting them inside `free()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 66 +++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 21de5c096c..e21d3d1a4c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -291,26 +291,14 @@ static const char need_bisect_start_warning[] =
 	   "You then need to give me at least one %s and %s revision.\n"
 	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
 
-static int bisect_next_check(const struct bisect_terms *terms,
-			     const char *current_term)
+static int decide_next(const struct bisect_terms *terms,
+		       const char *current_term, int missing_good,
+		       int missing_bad)
 {
-	int missing_good = 1, missing_bad = 1, res = 0;
-	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
-	const char *good_glob = xstrfmt("%s-*", terms->term_good);
-
-	if (ref_exists(bad_ref))
-		missing_bad = 0;
-
-	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
-			     (void *) &missing_good);
-
 	if (!missing_good && !missing_bad)
-		goto finish;
-
-	if (!current_term) {
-		res = -1;
-		goto finish;
-	}
+		return 0;
+	if (!current_term)
+		return -1;
 
 	if (missing_good && !missing_bad &&
 	    !strcmp(current_term, terms->term_good)) {
@@ -321,7 +309,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		 */
 		warning(_("bisecting only with a %s commit"), terms->term_bad);
 		if (!isatty(0))
-			goto finish;
+			return 0;
 		/*
 		 * TRANSLATORS: Make sure to include [Y] and [n] in your
 		 * translation. The program will only accept English input
@@ -329,21 +317,35 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		 */
 		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
 		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
-			res = -1;
-		goto finish;
-	}
-	if (!is_empty_or_missing_file(git_path_bisect_start())) {
-		res = error(_(need_bad_and_good_revision_warning),
-			       vocab_bad, vocab_good, vocab_bad, vocab_good);
-	} else {
-		res = error(_(need_bisect_start_warning),
-			       vocab_good, vocab_bad, vocab_good, vocab_bad);
+			return -1;
+		return 0;
 	}
 
-finish:
-	free((void *) good_glob);
-	free((void *) bad_ref);
-	return res;
+	if (!is_empty_or_missing_file(git_path_bisect_start()))
+		return error(_(need_bad_and_good_revision_warning),
+			     vocab_bad, vocab_good, vocab_bad, vocab_good);
+	else
+		return error(_(need_bisect_start_warning),
+			     vocab_good, vocab_bad, vocab_good, vocab_bad);
+}
+
+static int bisect_next_check(const struct bisect_terms *terms,
+			     const char *current_term)
+{
+	int missing_good = 1, missing_bad = 1;
+	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
+	char *good_glob = xstrfmt("%s-*", terms->term_good);
+
+	if (ref_exists(bad_ref))
+		missing_bad = 0;
+
+	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
+			     (void *) &missing_good);
+
+	free(good_glob);
+	free(bad_ref);
+
+	return decide_next(terms, current_term, missing_good, missing_bad);
 }
 
 static int get_terms(struct bisect_terms *terms)
-- 
2.25.0

