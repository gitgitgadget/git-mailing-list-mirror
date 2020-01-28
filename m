Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3DCC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F56020716
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9EAmbY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgA1Old (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40010 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbgA1OlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id j104so392914wrj.7
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQ3QmPOBX0CDWXYNnM/Q85Pl1DpTyyBNCoiFovU3mwc=;
        b=c9EAmbY8F1gpfiZI1VWxNJmqtX5SHU8GTOkoypek5frByIMiWwka5W4Aqw/M2IcWBM
         8XtsNrCfvqmCiKRATE1B3ZmvbpurP2gdNxKO35eVZP/sgHSj5prU07LiOP1JLH4NtJkt
         EsjmjBnNsF7g0zIT6BkzocTvX8tWZZE+mR1AjDufl4GjJ4lRa8DPmkCVsN8UvDVl2z+Z
         NctXFHCneGMyzHPfx5qxulUPDMZA/SXBvDDt14UPOVBTetDGB/0kRjvV5gPHj4ft7XsW
         xe31qG8fKj59HYXbc8Wrd+WFRxupYITlPt+osjIwN4BO6jwRLCJji+kAMIJGxCqUDD5e
         eOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQ3QmPOBX0CDWXYNnM/Q85Pl1DpTyyBNCoiFovU3mwc=;
        b=GMb/KpwNwu7BD0GKzp2vvXIRCV7SRNniGOKTamrU9J4HJdWYoPdqFpWOLjlE+/3Kum
         BEBC9XaCS64K8vch03niCLjBJahhJUON/4XQcNRD1LONyoen4AGI44HOvix2LeI84QsD
         Jmb0Q34C4ZsAz11AGxlz/uytwT9OyPrlVRvSwkpI5mSdmXocyxfjoR0/gdi0ThMn8qeh
         svbZI4j6WtjgSdIAJAsy8U6UNxvCZJkxFh3iwMmkZQtBl0FlkF278BgBgODFpSi7cnRQ
         lU1KWZF0jrbSGDGy9ytcrmkLLuQw28u/aClggjEXjdLN7nVHfoVWPNNllORuac2MxIhj
         Bx0Q==
X-Gm-Message-State: APjAAAUUfhnNG8+RjiBvfQ1lP1Ae3Hdadqgh8V0jhxgeB8Fg7aIy8Df5
        +FaDSVyBFdF60otFzbtpi+TKKNnt
X-Google-Smtp-Source: APXvYqx+bVS3dbgq6VGg2GakRXEs/E9ILQHITZhlzELqrjzELWafjQauVd0yM5dTRIYJ5lx7cpHZXw==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr3005493wro.162.1580222483805;
        Tue, 28 Jan 2020 06:41:23 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:23 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 09/11] bisect: libify `check_good_are_ancestors_of_bad` and its dependents
Date:   Tue, 28 Jan 2020 15:40:24 +0100
Message-Id: <20200128144026.53128-10-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
References: <20200128144026.53128-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negative-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Code that turns -11(early success code) to 0 from
`check_good_are_ancestors_of_bad()` has been moved to
`cmd_bisect__helper()`.

Handle the return value in dependent function `bisect_next_all()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c                 | 40 ++++++++++++++++++++++++++--------------
 builtin/bisect--helper.c | 12 ++++++++++--
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2a6566d066..d519e10827 100644
--- a/bisect.c
+++ b/bisect.c
@@ -865,19 +865,27 @@ static int check_ancestors(struct repository *r, int rev_nr,
  *
  * If that's not the case, we need to check the merge bases.
  * If a merge base must be tested by the user, its source code will be
- * checked out to be tested by the user and we will exit.
+ * checked out to be tested by the user and we will return.
  */
-static void check_good_are_ancestors_of_bad(struct repository *r,
+
+static int check_good_are_ancestors_of_bad(struct repository *r,
 					    const char *prefix,
 					    int no_checkout)
 {
-	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
+	char *filename;
 	struct stat st;
 	int fd, rev_nr, res = 0;
 	struct commit **rev;
 
+	/*
+	 * We don't want to clean the bisection state
+	 * as we need to get back to where we started
+	 * by using `git bisect reset`.
+	 */
 	if (!current_bad_oid)
-		die(_("a %s revision is needed"), term_bad);
+		return error(_("a %s revision is needed"), term_bad);
+
+	filename = git_pathdup("BISECT_ANCESTORS_OK");
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -893,18 +901,20 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 	if (check_ancestors(r, rev_nr, rev, prefix))
 		res = check_merge_bases(rev_nr, rev, no_checkout);
 	free(rev);
-	if (res)
-		exit(res == -11 ? 0 : -res);
 
-	/* Create file BISECT_ANCESTORS_OK. */
-	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-	if (fd < 0)
-		warning_errno(_("could not create file '%s'"),
-			      filename);
-	else
-		close(fd);
+	if (!res)
+	{
+		/* Create file BISECT_ANCESTORS_OK. */
+		fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		if (fd < 0)
+			warning_errno(_("could not create file '%s'"),
+				      filename);
+		else
+			close(fd);
+	}
  done:
 	free(filename);
+	return res;
 }
 
 /*
@@ -975,7 +985,9 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
 
-	check_good_are_ancestors_of_bad(r, prefix, no_checkout);
+	res = check_good_are_ancestors_of_bad(r, prefix, no_checkout);
+	if (res)
+		return res;
 
 	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 826fcba2ed..3442bfe2cb 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -666,7 +666,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 
 	switch (cmdmode) {
 	case NEXT_ALL:
-		return bisect_next_all(the_repository, prefix, no_checkout);
+		res = bisect_next_all(the_repository, prefix, no_checkout);
+		break;
 	case WRITE_TERMS:
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
@@ -713,5 +714,12 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
 	free_terms(&terms);
-	return !!res;
+	/*
+	 * Handle early success
+	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
+	 */
+	if (res == -11)
+		res = 0;
+
+	return res < 0 ? -res : res;
 }
-- 
2.21.1 (Apple Git-122.3)

