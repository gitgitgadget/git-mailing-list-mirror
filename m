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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8189C352A1
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B56217BA
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpRyJVQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBHJIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50416 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbgBHJIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so4868856wmb.0
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XhzMsY+lJloLSl4b1Z/o0VZTFTA4XJ4siYO0bhm1Oc=;
        b=jpRyJVQTEQBBJdVklZavtE5Gj5NMnAedujtPITMSahb90DvbYMHsDrBzSOiSVuY7QE
         FoILbsl+DAU6ix0UMb3K/d8wQAccG+BPuj4+foOYeb7tRqh90nmIR/4HL1PemPMZXkqM
         vEoA8DDkEC/QPhp6RaBSlf9NdRaq16FvC/KOhWQgdlGNjg8nBoNcYHqf8svrTkhPzur8
         rJw//oSAsN0RbWIYdew2GHtvAr1m2FKAsTwrKEOv4Sm3BiuPGF2zf9DSnXBrweYKWsyb
         kn7A4psjYOBoEllf1ok0NxXbAyuM7TJ2G4VisVcvakMyZwpOdzw+WHS/nfNciwNWVTH7
         KTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XhzMsY+lJloLSl4b1Z/o0VZTFTA4XJ4siYO0bhm1Oc=;
        b=gZXqoGGDmJzpLPT9NsfuFbhGj2EetLCf03AE0C1Un02tUAczFIvIeAz0gdhFU0NoAf
         5125M/Bfncoc8ZonRdkTOghwduEtQm+gzoJGHrH11xSwniY6BybXi80hxT7NYX4ZA0EE
         qdqp4XOlMg8FqISiMf6D7HBUL8N9dwCCQccg/37AmFqfdyKG2QSUZ4Uu+zsic7CgYE9L
         eTnSB5wmHPuf2euuUQNK+k3uys/dbSmm8qgPi4yK5CGelAbNQ1fDNe06Sfpty8IgqUmX
         Ug623Z8h0fd3RuC9w7SDaQje837zLtiAQER0eBR7150RjYge5RurDkF1yIQgDdaiTL9e
         gSgg==
X-Gm-Message-State: APjAAAVn5auozscpL9/K6Dwoqa/gzB62S8Q5QxwkZe3l5oI42LGRwEDs
        hc1lubbsyhth05i+ewO2i0UJwNgO
X-Google-Smtp-Source: APXvYqxoEkSGimW8qFjZHSa2FaCxS6qTnmDOFZvQTuzKeteYjeX6xlucI9l2yr+ebAurDC6fh+txkA==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr3408344wma.159.1581152917161;
        Sat, 08 Feb 2020 01:08:37 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:36 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 11/13] bisect: libify `check_good_are_ancestors_of_bad` and its dependents
Date:   Sat,  8 Feb 2020 10:07:02 +0100
Message-Id: <20200208090704.26506-12-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh, it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negative-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Code that turns BISECT_INTERNAL_SUCCESS_MERGE_BASE (-11)
 to BISECT_OK (0) from `check_good_are_ancestors_of_bad()` has been moved to
`cmd_bisect__helper()`.

Update all callers to handle the error returns.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c                 | 41 ++++++++++++++++++++++++++--------------
 builtin/bisect--helper.c | 11 ++++++++++-
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/bisect.c b/bisect.c
index 382e0b471f..f5ce3a4b70 100644
--- a/bisect.c
+++ b/bisect.c
@@ -872,20 +872,23 @@ static int check_ancestors(struct repository *r, int rev_nr,
  *
  * If that's not the case, we need to check the merge bases.
  * If a merge base must be tested by the user, its source code will be
- * checked out to be tested by the user and we will exit.
+ * checked out to be tested by the user and we will return.
  */
-static void check_good_are_ancestors_of_bad(struct repository *r,
+
+static enum bisect_error check_good_are_ancestors_of_bad(struct repository *r,
 					    const char *prefix,
 					    int no_checkout)
 {
-	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
+	char *filename;
 	struct stat st;
 	int fd, rev_nr;
 	enum bisect_error res = BISECT_OK;
 	struct commit **rev;
 
 	if (!current_bad_oid)
-		die(_("a %s revision is needed"), term_bad);
+		return error(_("a %s revision is needed"), term_bad);
+
+	filename = git_pathdup("BISECT_ANCESTORS_OK");
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -901,18 +904,26 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 	if (check_ancestors(r, rev_nr, rev, prefix))
 		res = check_merge_bases(rev_nr, rev, no_checkout);
 	free(rev);
-	if (res)
-		exit(res == BISECT_INTERNAL_SUCCESS_MERGE_BASE ? BISECT_OK : -res);
 
-	/* Create file BISECT_ANCESTORS_OK. */
-	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-	if (fd < 0)
-		warning_errno(_("could not create file '%s'"),
-			      filename);
-	else
-		close(fd);
+	if (!res) {
+		/* Create file BISECT_ANCESTORS_OK. */
+		fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		if (fd < 0)
+			/*
+			 * BISECT_ANCESTORS_OK file is not absolutely necessary,
+			 * the bisection process will continue at the next
+			 * bisection step.
+			 * So, just signal with a warning that something
+			 * might be wrong.
+			 */
+			warning_errno(_("could not create file '%s'"),
+				filename);
+		else
+			close(fd);
+	}
  done:
 	free(filename);
+	return res;
 }
 
 /*
@@ -984,7 +995,9 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	if (read_bisect_refs())
 		die(_("reading bisect refs failed"));
 
-	check_good_are_ancestors_of_bad(r, prefix, no_checkout);
+	res = check_good_are_ancestors_of_bad(r, prefix, no_checkout);
+	if (res)
+		return res;
 
 	bisect_rev_setup(r, &revs, prefix, "%s", "^%s", 1);
 	revs.limited = 1;
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e6bd4d6645..c1c40b516d 100644
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
@@ -713,5 +714,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
 	free_terms(&terms);
+
+	/*
+	 * Handle early success
+	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
+	 */
+	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
+		res = BISECT_OK;
+
 	return abs(res);
 }
-- 
2.25.0

