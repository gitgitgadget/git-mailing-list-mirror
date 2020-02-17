Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E9C7619B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E631320725
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxEHHbfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgBQIl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41868 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgBQIl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so18570964wrw.8
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7cidQ2/1P7oKcKMitQp8G7KJy2dGBePySTf6krnU+sU=;
        b=BxEHHbfZZk4yWpcQ2Ra70Xz+xu8XYA/UAQaKTbEaBgu7yowxMEUcknmDgs+YyAhwJk
         ouJ2UHYCvwxOj+KkZc9ye1B2+GSnpARigFJPNrsvcZTDQYektex4qUzuCQk1UMLiQBL9
         41PZ/TGpIp+Pv+mdDDe5zG9AWrHVrVZBubsY9FUEO9IgRLHGnku7Gb54dedQ67d5HNSp
         svyyCuk6YUlSOYLKFU6CTcpOEvdq9FZl9LJypIX7jOpMhq0aK3hp/N9yu/1fRTAvfTGV
         vcmElldiVfH8qDm5qM0BDyCnIQQv/zqXaIvMUbtSyggTiA8x8ZNsHz8TQ/QHegKs1BNr
         Q7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cidQ2/1P7oKcKMitQp8G7KJy2dGBePySTf6krnU+sU=;
        b=g9DOY7edzGoWiJPGKzCOQiOwPVfZl9PJhhbJ0dilZlEIniUjXpIXYwu9xtnzrwnhoX
         dxLP8/TWaD52moZn8rxyGxPtVifsnQoAi2dBSW3p++W4v7K1XQ9foKuXVpWAAatWx5NG
         c7d18ydLuVqsOM3fGvhbC/H3Ob0HkWx7AAhGAZuTUuYWF+mhqfc18CDl3bNxkj3yyukW
         rln+HkG/1oBNqoHBCyWL6UPpvlunIQm3zG8qkR/5RwAnmIHBSC2M+tQf0oibZExLUxMx
         ZHkxC2I9D3GopqHBDVlZvXlqIGLqQ4YqQdtriNi4IldceHfDReRdXNHdPGBV6uL3UetN
         SAFA==
X-Gm-Message-State: APjAAAVIZmKz80wtVH39Znzbt1CtR/3r6TCmKWPHsMQ6KAp+oOfdovTx
        BHEhEcTu05AWLnuFvKQ+pW4tDhOr
X-Google-Smtp-Source: APXvYqzy127J3FkDeoBndopOMEm5l7zeMswMAm9aTOHUz0oRc0IAZIf20Dgm5PM7xuHMvP0xiXoiig==
X-Received: by 2002:adf:df03:: with SMTP id y3mr20905535wrl.260.1581928883139;
        Mon, 17 Feb 2020 00:41:23 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:22 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 04/12] bisect--helper: introduce new `decide_next()` function
Date:   Mon, 17 Feb 2020 09:40:31 +0100
Message-Id: <20200217084039.78215-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
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

