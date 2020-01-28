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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EABC33CB2
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65037207FD
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMjMkifc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgA1Ola (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:30 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39890 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgA1Ol3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:29 -0500
Received: by mail-wr1-f41.google.com with SMTP id y11so16282784wrt.6
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mN0SToNuKd1IqKAn3n7YucOPBr7uWDuDfQ3rXgbv+2U=;
        b=gMjMkifcl8bGYzM1GA3zMjPWzTnw7PzJUznhv6RzmUnBOQ7WqSASnrwV00+Xhydb/p
         cpQhwsBtIJnyLq6jJryomyMjqICr8M2roob82dsPgw1sNsc3AVo0vyW+EaDFRkClourC
         GJD2ttczJim24B9GlksjaU0fm800gCRpomUz2Bu5Lj0ABStSzxI8pHVvDtqj0vyCOYhP
         ZWZxelYKjJb1HvORHuAmEyMD4cgLE1gHSv3pn+cRPgZTQTa9rEf+NR2WTIiak7mk5a32
         C3HMt0ktQQvopobmtlDJHMy2I9LPSE6tk9d/JyCugQ3pEj4QPLBj8WPdTh+wNU14pyv4
         gkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mN0SToNuKd1IqKAn3n7YucOPBr7uWDuDfQ3rXgbv+2U=;
        b=jWo9yg1Y90dOucWfC0rxDvxU6UaLDD4wO66RTPNCjuQ3cZhdGBEJ768zf/G0IBzgy0
         SWw8H9Xtp8/s9RpA93qlj39YmkAqYyQEPfxW1KfLICwQw+gb7G7EBzeSrDRI4gs5VU/p
         2pKOl13GIxPJmnOtopn+jbIsYkbB415bGQpubltcQZoaW1f1CbiaXbNycCrfSqb0jdpG
         d2BMYn1LPIWZRFqfThnBBRa8XU0KLqpv/hSdZerlrf4TcK0smDyMK7HC7Z74Dr+DLZum
         E+eBNt6O5D3IHVvMo9E4qlfu/NayNdAR2EOlcQjVdwxHLaRFoNCF1/0r4yeTUCI8xubu
         xjoQ==
X-Gm-Message-State: APjAAAVGvfvpf+yjAw2rY5D+lYjeTlYAYNQL6op8Lx+tEzWoheSOKDV8
        pQUwvsjqBW+R6BmN3PbunEHbWMlKD5Y=
X-Google-Smtp-Source: APXvYqxeZqCfkK/c9bRk41iEKDbB/Bhwyv+eT7aE9D9ENEBBIfcRA/T2Dx4kxkYlmIA7xmVDLR5qMQ==
X-Received: by 2002:adf:d183:: with SMTP id v3mr30385595wrc.180.1580222486560;
        Tue, 28 Jan 2020 06:41:26 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:26 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 11/11] bisect: libify `bisect_next_all`
Date:   Tue, 28 Jan 2020 15:40:26 +0100
Message-Id: <20200128144026.53128-12-mirucam@gmail.com>
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

All the functions calling `bisect_next_all()` are already able to
handle return values from it.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 40 +++++++++++++++++++++++++++++-----------
 bisect.h | 23 +++++++++++++++++++++++
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/bisect.c b/bisect.c
index 43baa3df28..d4b883f67d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -967,10 +967,10 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 }
 
 /*
- * We use the convention that exiting with an exit code 10 means that
- * the bisection process finished successfully.
- * In this case the calling shell script should exit 0.
- *
+ * We use the convention that return -10 means the bisection process
+ * finished successfully.
+ * In this case the calling function or command should not turn a -10
+ * return code into an error or a non zero exit code.
  * If no_checkout is non-zero, the bisection process does not
  * checkout the trial commit but instead simply updates BISECT_HEAD.
  */
@@ -1000,23 +1000,35 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 
 	if (!revs.commits) {
 		/*
-		 * We should exit here only if the "bad"
+		 * We should return error here only if the "bad"
 		 * commit is also a "skip" commit.
 		 */
 		res = error_if_skipped_commits(tried, NULL);
 		if (res < 0)
-			exit(-res);
+			return res;
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
 		       term_bad);
-		exit(1);
+
+		/*
+		 * We don't want to clean the bisection state
+		 * as we need to get back to where we started
+		 * by using `git bisect reset`.
+		 */
+		return -1;
 	}
 
 	if (!all) {
 		fprintf(stderr, _("No testable commit found.\n"
 			"Maybe you started with bad path parameters?\n"));
-		exit(4);
+
+		/*
+		 * We don't want to clean the bisection state
+		 * as we need to get back to where we started
+		 * by using `git bisect reset`.
+		 */
+		return -4;
 	}
 
 	bisect_rev = &revs.commits->item->object.oid;
@@ -1024,12 +1036,18 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 	if (oideq(bisect_rev, current_bad_oid)) {
 		res = error_if_skipped_commits(tried, current_bad_oid);
 		if (res)
-			exit(-res);
+			return res;
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
+
 		show_diff_tree(r, prefix, revs.commits->item);
-		/* This means the bisection process succeeded. */
-		exit(10);
+		/*
+		 * This means the bisection process succeeded.
+		 * Using -10 so that the call chain can simply check
+		 * for negative return values for early returns up
+		 * until the cmd_bisect__helper() caller.
+		 */
+		return -10;
 	}
 
 	nr = all - reaches - 1;
diff --git a/bisect.h b/bisect.h
index 4e69a11ea8..f640c4f963 100644
--- a/bisect.h
+++ b/bisect.h
@@ -31,6 +31,29 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
+/*
+ * bisect_next_all() could return the following codes:
+ * 0 success code (from bisect_checkout()): a new commit to test
+ * has been found (and possibly checked out too).
+ * -1 error code (from bisect_next_all()): default error code.
+ * -2 error code (from error_if_skipped_commits()): only skipped
+ * commits left to be tested.
+ * -3 error code (from handle_bad_merge_base() through
+ * check_merge_bases() and check_good_are_ancestors_of_bad()): merge
+ * base check failed.
+ * -4 error code (from bisect_next_all()): no testable commit found.
+ * -10 early success code (from bisect_next_all()): first term_bad
+ * commit found.
+ * This value is checked in builtin/bisect_helper::bisect_next().
+ * -11 early success code (from check_merge_bases() through
+ * check_good_are_ancestors_of_bad()): successfully tested
+ * merge base.
+ * Early success codes -10 and -11 should be only internal codes and
+ * converted to a 0 status code when the bisecting command exits.
+ * Different error codes might enable a bisecting script calling the
+ * bisect command that uses this function to do different things
+ * depending on the exit status of the bisect command.
+ */
 int bisect_next_all(struct repository *r,
 		    const char *prefix,
 		    int no_checkout);
-- 
2.21.1 (Apple Git-122.3)

