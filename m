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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D892C33CB8
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F0A217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scExUJ3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgATOip (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55914 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgATOio (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:44 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so14716365wmj.5
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+qoZnKDmxBY28zZvEzOZGWsh750eTqr5jD+v4kUyMo=;
        b=scExUJ3NBpjFhX5aU/wB/uh2TYr34r/38j8OZ9SAiRfdXvnZ+NC5QP5XkOJest2JTB
         fk2A0E8D2L+8/jvna3CzFnla8an+PHaLmM3A1QUnXahbFmTmPpNDx/9q0MjtOtn+YZiu
         4JckQ55rTB1c/bc2TC1ISw0oE4pHXwDAq27dkA3pyi/RxpkOLyd+zjU0GmMo539GwCUZ
         BMNCm6oEeoZR3Wj0Tfz0AYYgjKRzMshK3gjS7CV+bNAYmYUsqPUm9VzCLbCqUTjhJ0mo
         gOkyOFblKr+AU+BkvQxIBkf07Ncjm69w3Oc4h071fd40z+UurAppLXs0U/pXVkYlbkKr
         qrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+qoZnKDmxBY28zZvEzOZGWsh750eTqr5jD+v4kUyMo=;
        b=D565r3l00HY/F78FohowRIoc2VwHcpL1eNgfumd3EwI0s7IFTFJ+AVEZMgLBqIj1sp
         eETZiiohaI5/DZw4z9bI83yOgw0SnLAy9qWmrwdCKpmlrzrrrp1sp3biMg1B7cM0uyh5
         tuTKWVgKOVVJNcZ/X0QaYCOniCR6NKFuaM74NImkMERl9G1G+pMuu48e92pT+j7zuyU7
         6Ly5EaesyKqZVBNQQ1CXAxF28DU4qBangsT0+ihytfFkK/3BjurEjr2EaW6lA06z5xZN
         4rAebST64m4Uz6+YVTof5tOpJmfDiZlifhf99fOGUqDjvYcmW/8IOkYVbqkz5IWCyX/u
         bW+g==
X-Gm-Message-State: APjAAAUpVWuh0SfIIadmJ431qLAVRHrJcmo8IathlsorZ/pM0ahtPezR
        VEufW2dmjXKyCFW5Qw/ktl51UI4iEoI=
X-Google-Smtp-Source: APXvYqwO+T+DGB8GyW53tXTfUXy3k8iC/uj0RONE2SLZp22xUoCEf1pc/waEnWEGKNUExIcZ9gpXUw==
X-Received: by 2002:a05:600c:108a:: with SMTP id e10mr18727402wmd.38.1579531121725;
        Mon, 20 Jan 2020 06:38:41 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:41 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 11/29] bisect: libify `bisect_next_all`
Date:   Mon, 20 Jan 2020 15:37:42 +0100
Message-Id: <20200120143800.900-12-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
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

Turn `exit()` to `return` calls in `bisect_next_all()`.

All the functions calling `bisect_next_all()` are already able to
handle return values from it.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/bisect.c b/bisect.c
index acb5a13911..33f2829c19 100644
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
 		if (res)
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
-- 
2.21.1 (Apple Git-122.3)

