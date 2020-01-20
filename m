Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7347C33CBA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6DA217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPWzixn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgATOij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40685 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgATOig (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so14926305wmi.5
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+0sLYrP58eeovRExl7dsWUvPzeYQuBQyVbe8IQ/XvY=;
        b=VPWzixn2jURgQl1d033nvbMfYp+SyrefILWBcdY5SBEN9pCJAotA0HTKQPiXCeYlnE
         USA2l3jfnS8rZ6saKYNUhqCgjgnHIyECwfYZx5gGeNwWsj1YaQaKjE0d2gHbz6XZqcFC
         EON+NZSsySzyBlb2NIf1/4NbulhsLs4kjSSTm8GvRJ2//yUckh4SESR+QnbMG+/Y7j03
         MRA+hEG+B80koVqFopjP6Dt2mbfw8YWHH5vd/pTk2w8OENzB9yoh3kg9WeDvQfaEOqiL
         zjHd46xVAW27HWmHBWcG7MGzFVzmUPj3FdZ68HQMyzxCvewtft8GgIGRKUO7CT62ECug
         ypgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+0sLYrP58eeovRExl7dsWUvPzeYQuBQyVbe8IQ/XvY=;
        b=q74BBFbgmywMp8Ci3xv+5CDC58qOrxwT2YDhfUzIWIehFOCARSCHwQTVPLXgFtl7m/
         VAFQ68FaAMpC8NVt/TuUaQaufciKftymLvdvpK9DY72jsyk2r99uqKgWTopf2NHjx+oB
         isPmaPzlxP/LtVx77s6JWzjzt3Uv4qiBE7eqsl2TdLm2B+v7fwhVIPCHZxscerH9zFcq
         AgoxWsI7v9X778UYQsFSr1AR+OS8fUisE50x0TXxZbWZ+bU1FGkXLXh1SUThbWjEywQW
         juWIDqeh38PFNdizENCi8iyfwtbaS6vrBlKs5+GmPDLQFY8Yx0EJ+eholFShozHy0bvj
         UC+g==
X-Gm-Message-State: APjAAAXXtlTRKbvB16XuJLwS68TqDnQA50iUPrfTnR0VMtoEjNIJHaza
        wmuCIRrdChkDFVhjcWGyR7gYiwXv+UM=
X-Google-Smtp-Source: APXvYqxUrTAb88ANWpHqWkHXp0SDAWSCznMb32r5NjX5E+4jLqz4CX7xFlGPKxvcPdB8ZqCmmii11Q==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr19583521wmb.150.1579531114335;
        Mon, 20 Jan 2020 06:38:34 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:33 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 05/29] bisect--helper: introduce new `decide_next()` function
Date:   Mon, 20 Jan 2020 15:37:36 +0100
Message-Id: <20200120143800.900-6-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
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

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 62 +++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 21de5c096c..826fcba2ed 100644
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
+	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
+	const char *good_glob = xstrfmt("%s-*", terms->term_good);
+
+	if (ref_exists(bad_ref))
+		missing_bad = 0;
+
+	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
+			     (void *) &missing_good);
+
 	free((void *) good_glob);
 	free((void *) bad_ref);
-	return res;
+
+	return decide_next(terms, current_term, missing_good, missing_bad);
 }
 
 static int get_terms(struct bisect_terms *terms)
-- 
2.21.1 (Apple Git-122.3)

