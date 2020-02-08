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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5203BC35250
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA76622464
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r80AUdch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBHJIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40722 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbgBHJIf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so5218427wmi.5
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=auj2PpN7jw/nCeMzZ55W8zrFR3AQWT85aqwAv1NJUPg=;
        b=r80AUdchyUZ88QiyJZksk5Ih8AfUuTgDV8Cn+6c2+IDXwDpkCm8a6zASgTs6/Oflya
         wecyrKXpiJ0XyCikUL2cfd1WR7mzBAAGg27OQr9OvExKiTkYd7p68cUWBBoaeeEwcryJ
         VxItkuSZ2X7VdT32voGNVOxeM5f7dOuN45V7zUj5dDUzO7bMs3COZo9P4ga3h74PqeO6
         E65bSt7PacWpNjNTR7G3Cv9vbzP+EtDWP5r0bxFxS4g7jJwDSHqLhSHZ+jDFGwA8QrMm
         QmiYXeyYAOEqgKU/o5/yDZfuAnPL8SNU0XxA+Cvgm5z50zJ1nLbu83q7sahpFcsE0IPB
         b1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=auj2PpN7jw/nCeMzZ55W8zrFR3AQWT85aqwAv1NJUPg=;
        b=ln+nHaK49LULbGEQBfLDqEbmbDfx71VxB81Sn4PGvDdgDV9lObnThaGniQq6r/nbZe
         cUi6DRW713It1tDoWy5GEzEAvo7f6x3l8B/LTSskSZdmUr3ti7GIzNX3W5/XRvqmUwta
         D31cNlfEWMNwYi5SeDjWO5UOEmFLHs5CSle5v+VBjUm6tNys1NAoVYXdv93bToPsI4Cn
         TSUXTRQT26zonaSD7bEQ8OqNtomGde3M+zImnEwHQTOmogk/UZarOFBNDNO8z07zTjR7
         qHE/XwwcAe0GwUld4BPhd3kPKEuDBNyQzve8sgd2MFr1nr0IB1OSYZ11j0VcATeuaj51
         BBrQ==
X-Gm-Message-State: APjAAAWu1B0md6UM6fL9JyK8RAtoW155UpQMmH5CSZXhgsTbxs4uVBM2
        CLz5HTkXOAaLEOfmPMTsront3zsb
X-Google-Smtp-Source: APXvYqwT2/BwTgF3qYrz3c6aTfFBnVDBgWPWDjeUFYON68op1AN+JDuq6JlSb6h81AYcMoIdLg768Q==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr3616265wmb.33.1581152913397;
        Sat, 08 Feb 2020 01:08:33 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:33 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v3 08/13] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and its dependents
Date:   Sat,  8 Feb 2020 10:06:59 +0100
Message-Id: <20200208090704.26506-9-mirucam@gmail.com>
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

Update all callers to handle the error returns.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 17 +++++++++++------
 bisect.h |  5 ++++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/bisect.c b/bisect.c
index e4573c7ba1..85bda3500b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -661,11 +661,11 @@ static void bisect_common(struct rev_info *revs)
 		mark_edges_uninteresting(revs, NULL, 0);
 }
 
-static void exit_if_skipped_commits(struct commit_list *tried,
+static enum bisect_error error_if_skipped_commits(struct commit_list *tried,
 				    const struct object_id *bad)
 {
 	if (!tried)
-		return;
+		return BISECT_OK;
 
 	printf("There are only 'skip'ped commits left to test.\n"
 	       "The first %s commit could be any of:\n", term_bad);
@@ -676,7 +676,8 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
 	printf(_("We cannot bisect more!\n"));
-	exit(2);
+
+	return BISECT_ONLY_SKIPPED_LEFT;
 }
 
 static int is_expected_rev(const struct object_id *oid)
@@ -950,6 +951,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	struct rev_info revs;
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
+	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
 
@@ -972,8 +974,9 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 		 * We should exit here only if the "bad"
 		 * commit is also a "skip" commit.
 		 */
-		exit_if_skipped_commits(tried, NULL);
-
+		res = error_if_skipped_commits(tried, NULL);
+		if (res < 0)
+			exit(-res);
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
@@ -990,7 +993,9 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	bisect_rev = &revs.commits->item->object.oid;
 
 	if (oideq(bisect_rev, current_bad_oid)) {
-		exit_if_skipped_commits(tried, current_bad_oid);
+		res = error_if_skipped_commits(tried, current_bad_oid);
+		if (res)
+			exit(-res);
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 		show_diff_tree(r, prefix, revs.commits->item);
diff --git a/bisect.h b/bisect.h
index c921ead02c..19d90e4870 100644
--- a/bisect.h
+++ b/bisect.h
@@ -37,10 +37,13 @@ struct rev_list_info {
  * commit has been found (and possibly checked out) and it
  * should be tested.
  * BISECT_FAILED error code: default error code.
+ * BISECT_ONLY_SKIPPED_LEFT error code: only skipped
+ * commits left to be tested.
  */
 enum bisect_error {
 	BISECT_OK = 0,
-	BISECT_FAILED = -1
+	BISECT_FAILED = -1,
+	BISECT_ONLY_SKIPPED_LEFT = -2
 };
 
 enum bisect_error bisect_next_all(struct repository *r,
-- 
2.25.0

