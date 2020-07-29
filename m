Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52E1C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 03:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1C6206D7
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 03:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldP+9BRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgG2Ddc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgG2Ddb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 23:33:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BB8C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 20:33:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g8so1382799wmk.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 20:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OdZ5o6AoUkfwWdWe9slUvzb8nB28KqR3HTpcYkpb4Nk=;
        b=ldP+9BRDPyqtBOHI6NB90Csb19876WhutnCgA5tqoTwpDjC1Zj31eYbxk7Sd/yd/aa
         rrzenQI7/69//43xUtB9mXojWVQTsT+RJ5qe1RKH+7LNvQ6IWDAk24GXKOV4uCLzDB+V
         vhy/m0Q25A6D44vYY/qfJNJo1D2dqWHqKGhQla+AY5qDmRcx7b8jb7jRj1uWCMuGiBcr
         HAzU5u9/SrY2rC/BaRC1R3MzEuZcBdSafAns4tjBkdoUeqfafFplHizojltZGWnEn5jp
         WKLYG+P3fUaucRL4K0H/gWJO7jTqN04dI6CewxIm/og0sDp2EC//iAcAmFO2gA7FJ4+W
         QXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OdZ5o6AoUkfwWdWe9slUvzb8nB28KqR3HTpcYkpb4Nk=;
        b=HrTaurxUfugrRuv1j/8Lv/RMdkDMyXl9c+qdazYmldwB6t7fNl/Ux94JOJtx3BHMMG
         vJh06Oe2cAimOksxGJisdpJeL/yyAffUxX/PUxCD1Zk69sZD3YoY6Fw4FdAGty6d3U7V
         aw8EnounY34Xqe1UI7TzFhLIp8nYLpxBAYrHAMgD4mtPY0kpIiC5J+6P/FoKO1YQFZFN
         iR2P9QKoXBBTTQNWmQsS1rV18/ROc4IuWCUbRdlivA1e9xwBjNh22N8MLSknEhjHb0If
         QzAAa3GnMlpE8ORKxy1YRh9PMGoy637D3PUnhNoeOTy40U8C8RdDc9j34ejVQNX2BOMK
         d9pg==
X-Gm-Message-State: AOAM533RsMp7iDZKpGjkUbq7GLJ0WAZWRRB2zY8N3xLVzqPgxfGaxH6c
        p4NfS5Umk4O7g0DRnHMOfgTnUurO
X-Google-Smtp-Source: ABdhPJz3FggzULGeLxOX307aGgrFHY2XD2QUw3Esk9DH1ArcnNSPLnL6ikr/3yelPLGOXe4MUw+pxQ==
X-Received: by 2002:a1c:4e18:: with SMTP id g24mr7079464wmh.133.1595993609676;
        Tue, 28 Jul 2020 20:33:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm2501146wru.3.2020.07.28.20.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 20:33:29 -0700 (PDT)
Message-Id: <pull.685.git.1595993608886.gitgitgadget@gmail.com>
From:   "Steve Kemp via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Jul 2020 03:33:28 +0000
Subject: [PATCH] comment: fix spelling mistakes inside comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Steve Kemp <steve@steve.org.uk>, Steve Kemp <steve@steve.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Steve Kemp <steve@steve.org.uk>

This commit fixes a couple of minor spelling mistakes inside
comments.

Signed-off-by: Steve Kemp <steve@steve.fi>
Signed-off-by: Steve Kemp <steve@steve.org.uk>
---
    comment: Fix spelling mistakes inside comments
    
    This commit fixes a couple of minor spelling mistakes inside comments.
    
    Signed-off-by: Steve Kemp steve@steve.fi [steve@steve.fi]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-685%2Fskx%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-685/skx/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/685

 add-patch.c  | 2 +-
 column.c     | 2 +-
 grep.c       | 2 +-
 ref-filter.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index f899389e2c..a1d66c1b75 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1203,7 +1203,7 @@ static int edit_hunk_loop(struct add_p_state *s,
 	for (;;) {
 		int res = edit_hunk_manually(s, hunk);
 		if (res == 0) {
-			/* abandonded */
+			/* abandoned */
 			*hunk = backup;
 			return -1;
 		}
diff --git a/column.c b/column.c
index 4a38eed322..a58969baba 100644
--- a/column.c
+++ b/column.c
@@ -107,7 +107,7 @@ static void display_plain(const struct string_list *list,
 		printf("%s%s%s", indent, list->items[i].string, nl);
 }
 
-/* Print a cell to stdout with all necessary leading/traling space */
+/* Print a cell to stdout with all necessary leading/trailing space */
 static int display_cell(struct column_data *data, int initial_width,
 			const char *empty_cell, int x, int y)
 {
diff --git a/grep.c b/grep.c
index 13232a904a..54af9f813e 100644
--- a/grep.c
+++ b/grep.c
@@ -1817,7 +1817,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		 * We might set up the shared textconv cache data here, which
 		 * is not thread-safe. Also, get_oid_with_context() and
 		 * parse_object() might be internally called. As they are not
-		 * currenty thread-safe and might be racy with object reading,
+		 * currently thread-safe and might be racy with object reading,
 		 * obj_read_lock() must be called.
 		 */
 		grep_attr_lock();
diff --git a/ref-filter.c b/ref-filter.c
index 8447cb09be..f836f3830c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1980,7 +1980,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
  * of oids. If the given ref is a tag, check if the given tag points
  * at one of the oids in the given oid array.
  * NEEDSWORK:
- * 1. Only a single level of inderection is obtained, we might want to
+ * 1. Only a single level of indirection is obtained, we might want to
  * change this to account for multiple levels (e.g. annotated tags
  * pointing to annotated tags pointing to a commit.)
  * 2. As the refs are cached we might know what refname peels to without

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
