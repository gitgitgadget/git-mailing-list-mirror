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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC45C33CAA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C228F22314
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRyMrN82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgATOim (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46471 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgATOil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so29771909wrl.13
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0XwTj8wOlFkbFN5Ngh75qyxq8FkCrsUb3XwmE9iUZk=;
        b=uRyMrN82iNP1KfCouH8Iq0Xh6sBfhk3caxEV9Jl+tpLDXc6GsqziKPy9NLYE9WSqIW
         PLFqDNN+v+xKF8TLXsYSkZ0vCSGHCW6FPutV8Ijqk9aXen2T/1JJRfsz1dU1OSlQBc9w
         6PAOFuQ1mTKJ7q9X+Vccue0UVBotiSiCCA94TLQe8n74m7/baqoYsXd6yTvyt/xf+/X3
         F8lxOusz6QQFvFwrWCXaEoLDTesN2qPm1KXzJRbVZsCpmCbHm+5kpgsekKV7VzhE25/C
         3xnJIjYRq0oI8Z+Lc+zZerR5p9UOx+zG/icMtY2ctiGssfe6kBvfDqnURH8jqt9uYP1a
         NCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0XwTj8wOlFkbFN5Ngh75qyxq8FkCrsUb3XwmE9iUZk=;
        b=R9qBJxSt09QCKXqTr4RYu57ISumdRDpY8wzOs90fh46MY4hpCM+El3MoA8G+A0Tf92
         7L8a2Zaant7/KMty2araU2n2Z3/G7Lk600RFn7hDR+RQZzcy3RGNttQfhWB42vCuuPM/
         UG17TaMrwzIk6vH1A9oibpp+ALOs8nAwzmBIP1qPFlhL2MNNIJo69AVdbNHEHHyaoxmT
         t5hW+4n7QGC9XDXTZZxyxJvfMek4EHk9PJ8TTbZz/tv1tx0pqgHkutiDkpNaV2z2oo5V
         DsunylDotwx7bAZirknC/evrIzmxL7+GZvi0VeU07bWNoX8XEO5FTAr2oGX1mj2KDnel
         jKsA==
X-Gm-Message-State: APjAAAWvJ/kjLS4uREu80ITRbkM6n9sptMxEJlcl8kRmGWrSfFYlZUQG
        6qwcER99PeiiTGg4A6JyHNgq0MdG64s=
X-Google-Smtp-Source: APXvYqzjevKsv7ZWv4eWPuVqBsHnskndK2HsvPiBwW8VyqmCB0XMxP0yXU/wI5Ery190SV5wuf8mlQ==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr18363598wrq.72.1579531119079;
        Mon, 20 Jan 2020 06:38:39 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:38 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 09/29] bisect: libify `check_good_are_ancestors_of_bad` and its dependents
Date:   Mon, 20 Jan 2020 15:37:40 +0100
Message-Id: <20200120143800.900-10-mirucam@gmail.com>
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

Turn `exit()` to `return` calls in `check_good_are_ancestors_of_bad()`.

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
 bisect.c                 | 42 ++++++++++++++++++++++++++--------------
 builtin/bisect--helper.c | 12 ++++++++++--
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/bisect.c b/bisect.c
index 367258b0dd..2b80597a1d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -865,9 +865,10 @@ static int check_ancestors(struct repository *r, int rev_nr,
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
@@ -876,8 +877,15 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 	int fd, rev_nr, res = 0;
 	struct commit **rev;
 
-	if (!current_bad_oid)
-		die(_("a %s revision is needed"), term_bad);
+	/*
+	 * We don't want to clean the bisection state
+	 * as we need to get back to where we started
+	 * by using `git bisect reset`.
+	 */
+	if (!current_bad_oid) {
+		res = error(_("a %s revision is needed"), term_bad);
+		goto done;
+	}
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -893,18 +901,20 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 	if (check_ancestors(r, rev_nr, rev, prefix))
 		res = check_merge_bases(rev_nr, rev, no_checkout);
 	free(rev);
-	if(res)
-		exit(res == -11 ? 0 : -res);
-
-	/* Create file BISECT_ANCESTORS_OK. */
-	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-	if (fd < 0)
-		warning_errno(_("could not create file '%s'"),
-			      filename);
-	else
-		close(fd);
+	
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
index 826fcba2ed..5e0f759d50 100644
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

