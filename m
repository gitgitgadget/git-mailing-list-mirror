Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2605F1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 22:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfHEWd6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 18:33:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43002 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfHEWd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 18:33:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so37050118plb.9
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ua64w6xE4k/oj4Q1Mv7zIC8ID7pNjBp5gh0Jswau+dk=;
        b=DuKdafoAeuqEHcsUdWoZC61sjZt6/TUJqxmPDe3g8qYvD4nQK/wunA8xgOQk89PN6A
         xbY3JJDS4VkmnXJu3W6rV+NLUL7ogwF7vDBbTt3oQuvG6XVOUhrEBmuN2q+UUqWPEz21
         41IylyGPcOCBZ9GuiWxbRfzmpVAIWUS70AyERDU0TsLxiBqWDXiqKeBffIrkZnF71A/X
         UqbvJ8pKw0DeTml2J07WwBnr45/xfMrnt1EJMG7J0oWuWZ693MjI9vsHAfl16l9duMTD
         uRHQ4ekc+sDg1ACoQcmMuDuckAHGD2V7wRtz3aai7SW9OeJi4HNCV6l3+3zp6MAFYvcv
         1VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ua64w6xE4k/oj4Q1Mv7zIC8ID7pNjBp5gh0Jswau+dk=;
        b=h3LC9Iu65n7K0eKDRwH62Znh4aKM3VAjtPBjZMId2nePixxSXxAEv552LHh6+M4o3R
         PJ+h84buZ2cpc1GgnReDxSCM6m65V0AwIZkDhkVNmU2OiV9NVsSQnhoezbVAvxd0KoyQ
         /YPjHc8e1cBbiBzzpR1gdDOkc9zl+cVtjOgsWDt3MAnQwpDzA4MwR9sSUzuUch9PGd/G
         QdHFQ+UPrVkHBICJeKeeYv2vTGStm7yZpO+6OOR0D7fw2hbxu132p47L01AShbC79LEo
         EYVmqbVhLwUCn8fL/hz/CMIKWoGNQtW41wDUh+nHXvY//S26mU8HlJTa1Qikq8Gnp42m
         cBtg==
X-Gm-Message-State: APjAAAVGDVxdC+aqOCigyMdAce4OfDNsu03aowsVgLKy6c5hakoUaG6e
        6lYrOR8d2A9wAPpKDht20zs=
X-Google-Smtp-Source: APXvYqyDDQ6wE5M4gj2TUf64NUgYPrxEeeONcrLybYdvv1HOuMe53xfZI4sTPG5MIXIME+9u3ZRqTg==
X-Received: by 2002:a17:902:e011:: with SMTP id ca17mr80670plb.328.1565044437034;
        Mon, 05 Aug 2019 15:33:57 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id k22sm92080686pfk.157.2019.08.05.15.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 15:33:55 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/1] merge-recursive: avoid directory rename detection in recursive case
Date:   Mon,  5 Aug 2019 15:33:50 -0700
Message-Id: <20190805223350.27504-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.246.g5ddf3d502a
In-Reply-To: <20190726220928.GG113966@google.com>
References: <20190726220928.GG113966@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since commit 8c8e5bd6eb33 ("merge-recursive: switch directory
rename detection default", 2019-04-05), the default handling with
directory rename detection was to report a conflict and leave unstaged
entries in the index.  However, when creating a virtual merge base in
the recursive case, we absolutely need a tree, and the only way a tree
can be written is if we have no unstaged entries -- otherwise we hit a
BUG().

There are a few fixes possible here which at least fix the BUG(), but
none of them seem optimal for other reasons; see the comments with the
new testcase 13e in t6043 for details (which testcase triggered a BUG()
prior to this patch).  As such, just opt for a very conservative and
simple choice that is still relatively reasonable: have the recursive
case treat 'conflict' as 'false' for opt->detect_directory_renames.

Reported-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---

I really should introduce constants like
  DETECT_DIRECTORY_RENAMES_NEVER    = 0
  DETECT_DIRECTORY_RENAMES_CONFLICT = 1
  DETECT_DIRECTORY_RENAMES_YES      = 2
and then use them in the code to make it clearer, but I wanted to make
the code change as simple and contained as possible given that this is
built on maint, fixes a BUG() and we're already in -rc1.

I know this bug doesn't satisfy the normal criteria for making it into
2.23 (it's a bug that was present in 2.22 rather than a regression in
2.23), but given that it's a BUG() condition, I was hoping it is
important and safe enough to include anyway.

(This fix does merge down cleanly to master, next, and pu.)

 merge-recursive.c                   |   3 +-
 t/t6043-merge-rename-directories.sh | 111 ++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index d2e380b7ed..c7691d9b54 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2856,7 +2856,8 @@ static int detect_and_process_renames(struct merge_options *opt,
 	head_pairs = get_diffpairs(opt, common, head);
 	merge_pairs = get_diffpairs(opt, common, merge);
 
-	if (opt->detect_directory_renames) {
+	if ((opt->detect_directory_renames == 2) ||
+	    (opt->detect_directory_renames == 1 && !opt->call_depth)) {
 		dir_re_head = get_directory_renames(head_pairs);
 		dir_re_merge = get_directory_renames(merge_pairs);
 
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 50b7543483..c966147d5d 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -4403,4 +4403,115 @@ test_expect_success '13d-check(info): messages for rename/rename(1to1) via dual
 	)
 '
 
+# Testcase 13e, directory rename in virtual merge base
+#
+# This testcase has a slightly different setup than all the above cases, in
+# order to include a recursive case:
+#
+#      A   C
+#      o - o
+#     / \ / \
+#  O o   X   ?
+#     \ / \ /
+#      o   o
+#      B   D
+#
+#   Commit O: a/{z,y}
+#   Commit A: b/{z,y}
+#   Commit B: a/{z,y,x}
+#   Commit C: b/{z,y,x}
+#   Commit D: b/{z,y}, a/x
+#   Expected: b/{z,y,x}  (sort of; see below for why this might not be expected)
+#
+#   NOTES: 'X' represents a virtual merge base.  With the default of
+#          directory rename detection yielding conflicts, merging A and B
+#          results in a conflict complaining about whether 'x' should be
+#          under 'a/' or 'b/'.  However, when creating the virtual merge
+#          base 'X', since virtual merge bases need to be written out as a
+#          tree, we cannot have a conflict, so some resolution has to be
+#          picked.
+#
+#          In choosing the right resolution, it's worth noting here that
+#          commits C & D are merges of A & B that choose different
+#          locations for 'x' (i.e. they resolve the conflict differently),
+#          and so it would be nice when merging C & D if git could detect
+#          this difference of opinion and report a conflict.  But the only
+#          way to do so that I can think of would be to have the virtual
+#          merge base place 'x' in some directory other than either 'a/' or
+#          'b/', which seems a little weird -- especially since it'd result
+#          in a rename/rename(1to2) conflict with a source path that never
+#          existed in any version.
+#
+#          So, for now, when directory rename detection is set to
+#          'conflict' just avoid doing directory rename detection at all in
+#          the recursive case.  This will not allow us to detect a conflict
+#          in the outer merge for this special kind of setup, but it at
+#          least avoids hitting a BUG().
+#
+test_expect_success '13e-setup: directory rename detection in recursive case' '
+	test_create_repo 13e &&
+	(
+		cd 13e &&
+
+		mkdir a &&
+		echo z >a/z &&
+		echo y >a/y &&
+		git add a &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv a/ b/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo x >a/x &&
+		git add a &&
+		test_tick &&
+		git commit -m "B" &&
+
+		git branch C A &&
+		git branch D B &&
+
+		git checkout C &&
+		test_must_fail git -c merge.directoryRenames=conflict merge B &&
+		git add b/x &&
+		test_tick &&
+		git commit -m "C" &&
+
+
+		git checkout D &&
+		test_must_fail git -c merge.directoryRenames=conflict merge A &&
+		git add b/x &&
+		mkdir a &&
+		git mv b/x a/x &&
+		test_tick &&
+		git commit -m "D"
+	)
+'
+
+test_expect_success '13e-check: directory rename detection in recursive case' '
+	(
+		cd 13e &&
+
+		git checkout --quiet D^0 &&
+
+		git -c merge.directoryRenames=conflict merge -s recursive C^0 >out 2>err &&
+
+		test_i18ngrep ! CONFLICT out &&
+		test_i18ngrep ! BUG: err &&
+		test_i18ngrep ! core.dumped err &&
+		test_must_be_empty err &&
+
+		git ls-files >paths &&
+		! grep a/x paths &&
+		grep b/x paths
+	)
+'
+
 test_done
-- 
2.22.0.246.g5ddf3d502a

