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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936E1C33CAA
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE0B217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZng50aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgATOij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33207 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATOih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so29871750wrq.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o5O2mOhEEB/3yyhH7Yak7Hvy8bfFkBykevEU+u0WAWY=;
        b=RZng50awghOV3zrOD3BFp7TD8fq+UqJEM3idUnI3j0l2hRGIXY9UNbCqO1tcp+Ivx/
         n2Xu5Q032FetRGa0nuQF7KnIw5UhkWgdfEGl5pkJFHT/391rooXBkWdIC2J2JbBGCbz3
         R3wKfbBpxu2eczEJfbr0ijaTEvhpMXRo4p7zrGi3MB+hTEkYpRSLLiF1CI2WPKuQ8LW0
         CYKBWnRKV4HXTKmQLra1rd6YqkzJUnvWnkWWZGycqHhdgc9TMZTK7vtjQk9nYXm9Lzuv
         E26uM6djLiUD3rMNxdt6/mo9jtInCkK2hIOoIH4dN9giH4RzScs/gs7XG+rbX/lgJF19
         7/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o5O2mOhEEB/3yyhH7Yak7Hvy8bfFkBykevEU+u0WAWY=;
        b=mgTW6OdnRYgesmJwAfcjyhA2zMz4BO5w0hGwX/0Clka/dKYFk/QI4Gyfk6LHrt6ZkA
         9l7HlfmPyfzNI4pk2xThj4MfO/O750mLKk6EnL6y1eJt9CytTAvMBkmqyhDhJvmklBXW
         c9+9X+K+0WYACHFL5pi0DrUZTZ3kWRLy4L0sMK944bqoEa3XkUT45PTKTjisVC1RAHek
         7J9R79U6BrEslBwgg12EvOARyQ0zwaHDruylvBvazMBim6UmOEFn/Q/CNCwTlMa+Z+/f
         wwH7p5ZtY7y1a0111US8+NoP0Ff03G3hvwWN0FPTLrBQmjCwut0qXdZlCBOhPMcK6Oy4
         KjWg==
X-Gm-Message-State: APjAAAWZf2/Z/c+Q5ph88LBxe1VcSNmZcxd3WxaYgbVbKr3u4ipEVKB2
        OMd1BTOm3kuqI+N2PqUS2dYwsxO1RUU=
X-Google-Smtp-Source: APXvYqwuW3yRpu7ItTH5dKB1Hw+o9ScsHgzeY1EDwYdlZ7ZkGKOd9ZzUmYuA95GBdKqJkPa+S22OJQ==
X-Received: by 2002:adf:c54e:: with SMTP id s14mr17840781wrf.385.1579531115518;
        Mon, 20 Jan 2020 06:38:35 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:35 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 06/29] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and its dependents
Date:   Mon, 20 Jan 2020 15:37:37 +0100
Message-Id: <20200120143800.900-7-mirucam@gmail.com>
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
Modify `cmd_bisect_helper()` to handle these negative returns.

Turn `exit()` to `return` calls in `exit_if_skipped_commits()` and rename
the method to `error_if_skipped_commits()`.

Handle this return in dependant function `bisect_next_all()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index 83cb5b3a98..2ac0463327 100644
--- a/bisect.c
+++ b/bisect.c
@@ -661,11 +661,11 @@ static void bisect_common(struct rev_info *revs)
 		mark_edges_uninteresting(revs, NULL, 0);
 }
 
-static void exit_if_skipped_commits(struct commit_list *tried,
+static int error_if_skipped_commits(struct commit_list *tried,
 				    const struct object_id *bad)
 {
 	if (!tried)
-		return;
+		return 0;
 
 	printf("There are only 'skip'ped commits left to test.\n"
 	       "The first %s commit could be any of:\n", term_bad);
@@ -676,7 +676,13 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
 	printf(_("We cannot bisect more!\n"));
-	exit(2);
+
+	/*
+	 * We don't want to clean the bisection state
+	 * as we need to get back to where we started
+	 * by using `git bisect reset`.
+	 */
+	return -2;
 }
 
 static int is_expected_rev(const struct object_id *oid)
@@ -949,7 +955,7 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 {
 	struct rev_info revs;
 	struct commit_list *tried;
-	int reaches = 0, all = 0, nr, steps;
+	int reaches = 0, all = 0, nr, steps, res;
 	struct object_id *bisect_rev;
 	char *steps_msg;
 
@@ -972,8 +978,9 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 		 * We should exit here only if the "bad"
 		 * commit is also a "skip" commit.
 		 */
-		exit_if_skipped_commits(tried, NULL);
-
+		res = error_if_skipped_commits(tried, NULL);
+		if (res)
+			exit(-res);
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
@@ -990,7 +997,9 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
 	bisect_rev = &revs.commits->item->object.oid;
 
 	if (oideq(bisect_rev, current_bad_oid)) {
-		exit_if_skipped_commits(tried, current_bad_oid);
+		res = error_if_skipped_commits(tried, current_bad_oid);
+		if (res)
+			exit(-res);
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(r, prefix, revs.commits->item);
-- 
2.21.1 (Apple Git-122.3)

