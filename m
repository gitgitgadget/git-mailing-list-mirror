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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922E2C7619D
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F4A2064C
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 08:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUXMb4AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgBQIlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:41:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37809 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgBQIld (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 03:41:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id a6so17416016wme.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 00:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLSG+Q77AdLVaFVMIARi/gl7xzQBzBo857i0VLL2p5k=;
        b=FUXMb4ADpRoJf3qFxUGExzOjZPMyzRHuPrDtbFvy6JPfA0aERdT5gTIgikehZqs8BO
         ymubyr3m/jz1DyxiY9Emj/nDFQ0H/8NLCCgJb4rQwB/1rXQqf6QqRkjPR1cFzCa0vg5K
         jEP0u/9ROuSD5nxyneKuHukNp7G+8R8K0iHfvlHZoaRqneZ5gv1pFYLH+3fbjDl8t/PJ
         5V02snKuOacOXYzObvnB9x/PtyuMC7AfB+vIdA3foO/uaehgd78gUpgDp1ZzUhaFT7ZD
         1y52BVwO06v2c99a468unJ+7enVeXPl8lSMcLMVTmDvBeWRORxMXJSe4QUERuCgdrkJw
         EaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLSG+Q77AdLVaFVMIARi/gl7xzQBzBo857i0VLL2p5k=;
        b=DkmvQwiH87ZJr4GUxSR7zAJ8T7F70wVDb/E2HzXC4nR/DzrGr1Nrz/HT3E4aC7nhth
         aMYwZ1Ux9ldHP2IHlsKqUcUe8/NLqDe2wITiDV1dHMTpOFWs3uaDNIX62YMTleiXNARd
         K8f54/wUmL7o7CLafaoVbaKSG2ADv58S+yFkqYmjiDe/1o4g9LHOfAHDl3YUlg5rfEJx
         Qsy0jpzaNXLALG5wQwXIEUsSpt8h/zaDKD7qBDShSM7greWDyjI+cYbQcqdwPlkdfCvm
         8A3H3HyD3c3FN3MPx/fc8k2s3SWJAZlwQHTWIk2ByeWpmki3yRw00f1RkvtIOqAICB3A
         cKuQ==
X-Gm-Message-State: APjAAAUIp5D46qC8inh90SC5dH7BlO/kdh1qAt4LQhhvvTIwn0Lc5KiP
        9wUSOKzTcNG5WBX+1XgnvtOafXk8
X-Google-Smtp-Source: APXvYqxldzjLVWYpF7QClVlrSyN7v5T/itsV5oxSmbhkK2x+D42/1dsbrzDkC6eVU+ZVWad7pRlg5Q==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr20750892wmj.175.1581928889541;
        Mon, 17 Feb 2020 00:41:29 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id s22sm19187149wmh.4.2020.02.17.00.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:41:29 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 09/12] bisect: libify `check_merge_bases` and its dependents
Date:   Mon, 17 Feb 2020 09:40:36 +0100
Message-Id: <20200217084039.78215-10-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217084039.78215-1-mirucam@gmail.com>
References: <20200217084039.78215-1-mirucam@gmail.com>
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

In `check_merge_bases()` there is an early success special case,
so we have introduced special error code
BISECT_INTERNAL_SUCCESS_MERGE_BASE (-11) which indicates early
success. This BISECT_INTERNAL_SUCCESS_MERGE_BASE is converted back
to BISECT_OK (0) in `check_good_are_ancestors_of_bad()`.

Update all callers to handle the error returns.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 22 ++++++++++++++++++----
 bisect.h |  7 ++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index f6582ddfed..382e0b471f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -811,13 +811,18 @@ static void handle_skipped_merge_base(const struct object_id *mb)
  * "check_merge_bases" checks that merge bases are not "bad" (or "new").
  *
  * - If one is "bad" (or "new"), it means the user assumed something wrong
- * and we must exit with a non 0 error code.
+ * and we must return error with a non 0 error code.
  * - If one is "good" (or "old"), that's good, we have nothing to do.
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
+ * - If a merge base must be tested, on success return
+ * BISECT_INTERNAL_SUCCESS_MERGE_BASE (-11) a special condition
+ * for early success, this will be converted back to 0 in
+ * check_good_are_ancestors_of_bad().
  */
-static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
+static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 {
+	enum bisect_error res = BISECT_OK;
 	struct commit_list *result;
 
 	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
@@ -832,11 +837,16 @@ static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			exit(bisect_checkout(mb, no_checkout));
+			res = bisect_checkout(mb, no_checkout);
+			if (!res)
+				/* indicate early success */
+				res = BISECT_INTERNAL_SUCCESS_MERGE_BASE;
+			break;
 		}
 	}
 
 	free_commit_list(result);
+	return res;
 }
 
 static int check_ancestors(struct repository *r, int rev_nr,
@@ -871,6 +881,7 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
 	int fd, rev_nr;
+	enum bisect_error res = BISECT_OK;
 	struct commit **rev;
 
 	if (!current_bad_oid)
@@ -885,10 +896,13 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
+
 	rev = get_bad_and_good_commits(r, &rev_nr);
 	if (check_ancestors(r, rev_nr, rev, prefix))
-		check_merge_bases(rev_nr, rev, no_checkout);
+		res = check_merge_bases(rev_nr, rev, no_checkout);
 	free(rev);
+	if (res)
+		exit(res == BISECT_INTERNAL_SUCCESS_MERGE_BASE ? BISECT_OK : -res);
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
diff --git a/bisect.h b/bisect.h
index 19d90e4870..f68ae85376 100644
--- a/bisect.h
+++ b/bisect.h
@@ -39,11 +39,16 @@ struct rev_list_info {
  * BISECT_FAILED error code: default error code.
  * BISECT_ONLY_SKIPPED_LEFT error code: only skipped
  * commits left to be tested.
+ * BISECT_INTERNAL_SUCCESS_MERGE_BASE early success
+ * code: found merge base that should be tested.
+ * Early success code BISECT_INTERNAL_SUCCESS_MERGE_BASE
+ * should be only an internal code.
  */
 enum bisect_error {
 	BISECT_OK = 0,
 	BISECT_FAILED = -1,
-	BISECT_ONLY_SKIPPED_LEFT = -2
+	BISECT_ONLY_SKIPPED_LEFT = -2,
+	BISECT_INTERNAL_SUCCESS_MERGE_BASE = -11
 };
 
 enum bisect_error bisect_next_all(struct repository *r,
-- 
2.25.0

