Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D261F516
	for <e@80x24.org>; Mon,  2 Jul 2018 13:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeGBNbl (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 09:31:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46010 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbeGBNbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 09:31:09 -0400
Received: by mail-oi0-f66.google.com with SMTP id m2-v6so8423626oim.12
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tqNaGkTdAYp9u5+6I/EyUHwR6ocfufSrb4yjs7Encq0=;
        b=QXTlml/dziDrLjEq83Xg479hdtbfc5BeXWr1ynkWLz5xE1A+iLvxOWSDB//CeOoEFY
         yREK8z657Bv9nismIS9ng7cl61Up2xadkDlNoZpOm45mlQ3IZYNXeQrjPnRRUFlPhX3y
         ULYxzGo63iml+8RJx1aGuY2aElymHf8Fg1ZZmcgsn7Hxx8ZrX4vjbOLuavqEptHb0Zws
         s3TJXuGrKVTXkPcRayz2NtB0c++xX+J2e3ISM9ojmVE5iNqsNKjeDqoWfIMPQcxip685
         rF5Ote3kk+4kgrVybny1IzvQ4jDm7sY+QegG7kqB0IsUSLgT115Txnl2vwF88PqvyP5y
         1SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tqNaGkTdAYp9u5+6I/EyUHwR6ocfufSrb4yjs7Encq0=;
        b=kQwsvhghf5VpXlrmQCEO2R6jpMZYMLbAYxQ43mpEVn+4rn3S27zelitbn4F3lO6g0X
         bgXXKGlyNx6WKj82hmrbZJLiMZWh4R1mKd2898JTa04585rlMFcUyc8KV1eldnzL3XUG
         happ97o2QkGNBZ/nM3R3UVPnrZP93oEXHcufa7MQ9tmb2mY8q6MYSWJyNMSegH7QTw+U
         eETWRovDqT3vuMLNRMCBkGuNa/jxFcvf3cQBU6vyJ2+GreWrbD3gD4nWgA61/HKjieEC
         mfUgzFLU79IV/sdKR8qfTLlNPG95Tr6xXZZtry24dIxAJln78AeWNxlkaMy1UiPJ0Elg
         Mwhw==
X-Gm-Message-State: APt69E1hNavdOFNMmn99lL9tpHnDBaFs47vmrMjPMWWarv9qyMDV1kdy
        rarEmGMOlyHWGIIr2LLW4cW29w==
X-Google-Smtp-Source: AAOMgpcw8EC3HGV7tNeYln1cdo4gC94mKyUDBQtoIkN1ROp4ujF2V4ziuoOcWajy+Y8Z7WXUgC25bQ==
X-Received: by 2002:aca:b285:: with SMTP id b127-v6mr16249273oif.130.1530538268740;
        Mon, 02 Jul 2018 06:31:08 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id r16-v6sm12232366otd.43.2018.07.02.06.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 06:31:08 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/3] t6042: add testcase covering rename/add/delete conflict type
Date:   Mon,  2 Jul 2018 06:30:52 -0700
Message-Id: <20180702133054.18638-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
In-Reply-To: <20180702133054.18638-1-newren@gmail.com>
References: <20180702133054.18638-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a file is renamed on one side of history, and the other side of history
both deletes the original file and adds a new unrelated file in the way of
the rename, then we have what I call a rename/add/delete conflict.  Add a
testcase covering this scenario.

Reported-by: Robert Dailey <rcdailey.lists@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6042-merge-rename-corner-cases.sh | 66 ++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 1cbd946fc..788a31451 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -693,4 +693,70 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 	)
 '
 
+# Testcase rad, rename/add/delete
+#   Commit O: foo
+#   Commit A: rm foo, add different bar
+#   Commit B: rename foo->bar
+#   Expected: CONFLICT (rename/add/delete), two-way merged bar
+
+test_expect_success 'rad-setup: rename/add/delete conflict' '
+	test_create_repo rad &&
+	(
+		cd rad &&
+		echo "original file" >foo &&
+		git add foo &&
+		git commit -m "original" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm foo &&
+		echo "different file" >bar &&
+		git add bar &&
+		git commit -m "Remove foo, add bar" &&
+
+		git checkout B &&
+		git mv foo bar &&
+		git commit -m "rename foo to bar"
+	)
+'
+
+test_expect_failure 'rad-check: rename/add/delete conflict' '
+	(
+		cd rad &&
+
+		git checkout B^0 &&
+		test_must_fail git merge -s recursive A^0 >out 2>err &&
+
+		# Not sure whether the output should contain just one
+		# "CONFLICT (rename/add/delete)" line, or if it should break
+		# it into a pair of "CONFLICT (rename/delete)" and
+		# "CONFLICT (rename/add)"; allow for either.
+		test_i18ngrep "CONFLICT (rename.*add)" out &&
+		test_i18ngrep "CONFLICT (rename.*delete)" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >file_count &&
+		test_line_count = 2 file_count &&
+		git ls-files -u >file_count &&
+		test_line_count = 2 file_count &&
+		git ls-files -o >file_count &&
+		test_line_count = 2 file_count &&
+
+		git rev-parse >actual \
+			:2:bar :3:bar &&
+		git rev-parse >expect \
+			B:bar  A:bar  &&
+
+		test_cmp file_is_missing foo &&
+		# bar should have two-way merged contents of the different
+		# versions of bar; check that content from both sides is
+		# present.
+		grep original bar &&
+		grep different bar
+	)
+'
+
 test_done
-- 
2.18.0.130.gd703bbb5d

