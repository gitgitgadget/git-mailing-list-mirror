Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF1F1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 05:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeKDOml (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 09:42:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37534 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKDOml (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 09:42:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id p17so3890523lfh.4
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 22:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vC3j+TJWM6KhiwztVJuSQ5DBh//en9pG/VVnfjRJpD0=;
        b=cNomzyeXMvtXmmfZX8ZHoJ8tW/T0Q5LAEwaMqwTIDPuIBEzSEmaOXNdnykzDWmVN+X
         G1AOkvrzA4hppRFLy6/AXPuxGlci/YDN5o8ShP95rsVT+mr2x2Va0JY/3SALHAWHpm8a
         NscaYNi3ipY1ORjpUnbIUbLzYvEV21EA6FSu87PpvtRTjPalglXFsSdxCDAQfYdspkyP
         0A0ZJhY39yvsRB8DLvP/tD7+x9Fpadx8JDObTPfW9iObG/y2eiIe447pWj9VCb06rXW+
         /CiFJGWGuPR9QH7xFF4qTufL7sul4pKWwfc3ePid+AcjlHt8imBRHh6q5EHgtrFbgk3s
         P+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vC3j+TJWM6KhiwztVJuSQ5DBh//en9pG/VVnfjRJpD0=;
        b=QFQi7BoqlBbCRD+1+kpoBM3pRiJS+1VcRaxvfZU5FjQdQQ5+doh41uD6GBlzuzjSsQ
         JDQPYTHV1EGEVql7HUs4l3enmWO4VEH0wKstMeb6ibh042cc8ZWfCPMGTKW9Siu9ykxl
         DAUAFbkx3ypUPOY79n/D7l85Tb6aXRs0tn9E3PUrfIqRoQUG9ttbiLrUomQRcZpoCyFK
         U5z8gM51ssWDpvZUt+u7yjHwFrRWpltOVMeVnGGf59SDwG1jmzbltVlIEi/UFohU5AEN
         MjRiM4VUM3qek1LoqCda93t1sinEainKx4m9p5pG5q0pvAZ4j/j01WKjujNbFy8FFmoO
         +C4w==
X-Gm-Message-State: AGRZ1gKHj0RsqjTlwmrYAQGPl9TazbkDVNj9Fq/1Sne5mUj8Mt3yVQjR
        T1VsdbPyXAjl18FOGKrVNzNteXvj
X-Google-Smtp-Source: AJdET5faUFTp7P9/WDD+ZP7MMZpZiRLC8juJpGEBz+3NWbkFt8fDKTd2O1D6jnaWaop5H/0F7nvhGA==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr9585109lfb.121.1541309337464;
        Sat, 03 Nov 2018 22:28:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u26-v6sm434332lji.22.2018.11.03.22.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 22:28:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     christophe.bliard@trux.info, git@vger.kernel.org,
        rafa.almas@gmail.com, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] tree-walk.c: fix overoptimistic inclusion in :(exclude) matching
Date:   Sun,  4 Nov 2018 06:28:51 +0100
Message-Id: <20181104052851.12584-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103153049.22850-1-pclouds@gmail.com>
References: <20181103153049.22850-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tree_entry_interesting() is used for matching pathspec on a tree. The
interesting thing about this function is that, because the tree
entries are known to be sorted, this function can return more than
just "yes, matched" and "no, not matched". It can also say "yes, this
entry is matched and so is the remaining entries in the tree".

This is where I made a mistake when matching exclude pathspec. For
exclude pathspec, we do matching twice, one with positive patterns and
one with negative ones, then a rule table is applied to determine the
final "include or exclude" result. Note that "matched" does not
necessarily mean include. For negative patterns, "matched" means
exclude.

This particular rule is too eager to include everything. Rule 8 says
that "if all entries are positively matched" and the current entry is
not negatively matched (i.e. not excluded), then all entries are
positively matched and therefore included. But this is not true. If
the _current_ entry is not negatively matched, it does not mean the
next one will not be and we cannot conclude right away that all
remaining entries are positively matched and can be included.

Rules 8 and 18 are now updated to be less eager. We conclude that the
current entry is positively matched and included. But we say nothing
about remaining entries. tree_entry_interesting() will be called again
for those entries where we will determine entries individually.

Reported-by: Christophe Bliard <christophe.bliard@trux.info>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 fixes the too broad "git add ." in the test

 t/t6132-pathspec-exclude.sh | 17 +++++++++++++++++
 tree-walk.c                 | 11 ++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index eb829fce97..2462b19ddd 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -194,4 +194,21 @@ test_expect_success 'multiple exclusions' '
 	test_cmp expect actual
 '
 
+test_expect_success 't_e_i() exclude case #8' '
+	git init case8 &&
+	(
+		cd case8 &&
+		echo file >file1 &&
+		echo file >file2 &&
+		git add file1 file2 &&
+		git commit -m twofiles &&
+		git grep -l file HEAD :^file2 >actual &&
+		echo HEAD:file1 >expected &&
+		test_cmp expected actual &&
+		git grep -l file HEAD :^file1 >actual &&
+		echo HEAD:file2 >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index 77b37f36fa..79bafbd1a2 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1107,7 +1107,7 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 	 *   5  |  file |    1     |    1     |   0
 	 *   6  |  file |    1     |    2     |   0
 	 *   7  |  file |    2     |   -1     |   2
-	 *   8  |  file |    2     |    0     |   2
+	 *   8  |  file |    2     |    0     |   1
 	 *   9  |  file |    2     |    1     |   0
 	 *  10  |  file |    2     |    2     |  -1
 	 * -----+-------+----------+----------+-------
@@ -1118,7 +1118,7 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 	 *  15  |  dir  |    1     |    1     |   1 (*)
 	 *  16  |  dir  |    1     |    2     |   0
 	 *  17  |  dir  |    2     |   -1     |   2
-	 *  18  |  dir  |    2     |    0     |   2
+	 *  18  |  dir  |    2     |    0     |   1
 	 *  19  |  dir  |    2     |    1     |   1 (*)
 	 *  20  |  dir  |    2     |    2     |  -1
 	 *
@@ -1134,7 +1134,12 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 
 	negative = do_match(entry, base, base_offset, ps, 1);
 
-	/* #3, #4, #7, #8, #13, #14, #17, #18 */
+	/* #8, #18 */
+	if (positive == all_entries_interesting &&
+	    negative == entry_not_interesting)
+		return entry_interesting;
+
+	/* #3, #4, #7, #13, #14, #17 */
 	if (negative <= entry_not_interesting)
 		return positive;
 
-- 
2.19.1.1005.gac84295441

