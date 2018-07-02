Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95E861F516
	for <e@80x24.org>; Mon,  2 Jul 2018 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeGBNbQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 09:31:16 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43851 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbeGBNbM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 09:31:12 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so2186535oib.10
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JWrVNOMxUgWkn7vVsmNteHvFqPGQOPrSF4H3GMrkAv4=;
        b=C9BkYQD8PvBT/Makp52skRulgsiOFyY2g+GBbV6bmAiEp9guy/WVLzdQvgX9E3O8jN
         TxqKNkDqidwwF4Hqbw2q20Niod1Tqw2KtlVry5aTWZjh4NXHvGm0gPL27QCITktXIinX
         ed3riTDFsiT6SacgsBkHvYdt/rdhodc0dl5BBTerakp0zoVmz0Xc/7enqDqNGdT9dGGz
         J4bpDEh05s6O7OM0jYxYj/9l+rp87nJkVIqWpIbrDblwTObVumOTEc48qeBsSbd9RpZB
         sEVhpsdcBfRiOoWWMqs18ommlTBYEty0wZZuwsFItVJRgaK6KY+41x3EN4n0KAkDny8A
         IKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JWrVNOMxUgWkn7vVsmNteHvFqPGQOPrSF4H3GMrkAv4=;
        b=S5hg0Xc6VfkQyDKlPYAQLsc/8DCwOelh/lcefs//Kmr+q3rfYBxS8+2svOU+gVWifI
         YVtPY/9biaIeY6YWHuJYMU0jOJAhGSo9DDCLD+Z4x8aZzN6wd3UhL6CfdBFlKtpzk0hS
         8wehc7B2alcKCYHjZZDrq64Wi2npdq/654yRIbLoEi8QzWSsar9k/c++XqJDMWngKLnN
         HRJcXrsp8hZ3vpMsRJWyynE4ylcKe8LP9HvPqoLFOTe8nr7BgmQW/rM2rO5kbb6i9vhI
         PhB8K03SC3v20vDsz1VwQDyJYx0GGiykdy+QDkUCg/v9K7/lSpzjSnOHDDMf8PS+1+9k
         TO8A==
X-Gm-Message-State: APt69E3ETuEIjiRnRZRM6G75b8Vqpa38p3kEc4AHRnp4RBrKCW4x6cFV
        27kPhmOh9ma93L7dIlGub338Sw==
X-Google-Smtp-Source: AAOMgpfNdDNAiKVSsT7cWMWnm05JtLuHtKLkrnXK12n050ge6F10uw7lxTXc+DoWjz4tu7W/tiXxvA==
X-Received: by 2002:aca:acb:: with SMTP id k72-v6mr16690750oiy.78.1530538271097;
        Mon, 02 Jul 2018 06:31:11 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id r16-v6sm12232366otd.43.2018.07.02.06.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 06:31:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/3] t6042: add testcase covering long chains of rename conflicts
Date:   Mon,  2 Jul 2018 06:30:54 -0700
Message-Id: <20180702133054.18638-4-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.130.gd703bbb5d
In-Reply-To: <20180702133054.18638-1-newren@gmail.com>
References: <20180702133054.18638-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Each rename is a lego: the source side could be connected to a delete or
another rename, and the destination side could be connected to a rename or a
conflicting add.  Previous tests combined these to get e.g.
rename/rename(1to2)/add/add, rename/rename(2to1)/delete/delete, and
rename/add/delete.  But we can also build bigger chains of conflicts.  Add a
testcase demonstrating this.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6042-merge-rename-corner-cases.sh | 111 +++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 46e1aa7df..d9c4068e9 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -827,4 +827,115 @@ test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 	)
 '
 
+# Testcase mod6, chains of rename/rename(1to2) and rename/rename(2to1)
+#   Commit O: one,      three,       five
+#   Commit A: one->two, three->four, five->six
+#   Commit B: one->six, three->two,  five->four
+#   Expected: six CONFLICT(rename/rename) messages, each path in two of the
+#             multi-way merged contents found in two, four, six
+
+test_expect_success 'mod6-setup: chains of rename/rename(1to2) and rename/rename(2to1)' '
+	test_create_repo mod6 &&
+	(
+		cd mod6 &&
+		test_seq 11 19 >one &&
+		test_seq 31 39 >three &&
+		test_seq 51 59 >five &&
+		git add . &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_seq 10 19 >one &&
+		echo 40        >>three &&
+		git add one three &&
+		git mv  one   two  &&
+		git mv  three four &&
+		git mv  five  six  &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo 20    >>one       &&
+		echo forty >>three     &&
+		echo 60    >>five      &&
+		git add one three five &&
+		git mv  one   six  &&
+		git mv  three two  &&
+		git mv  five  four &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure 'mod6-check: chains of rename/rename(1to2) and rename/rename(2to1)' '
+	(
+		cd mod6 &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out 2>err &&
+
+		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_must_be_empty err &&
+
+		git ls-files -s >file_count &&
+		test_line_count = 6 file_count &&
+		git ls-files -u >file_count &&
+		test_line_count = 6 file_count &&
+		git ls-files -o >file_count &&
+		test_line_count = 3 file_count &&
+
+		test_seq 10 20 >merged-one &&
+		test_seq 51 60 >merged-five &&
+		# Determine what the merge of three would give us.
+		test_seq 30 40 >three-side-A &&
+		test_seq 31 39 >three-side-B &&
+		echo forty >three-side-B &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			three-side-A empty three-side-B &&
+		sed -e "s/^\([<=>]\)/\1\1\1/" three-side-A >merged-three &&
+
+		# Verify the index is as expected
+		git rev-parse >actual         \
+			:2:two       :3:two   \
+			:2:four      :3:four  \
+			:2:six       :3:six   &&
+		git hash-object >expect           \
+			merged-one   merged-three \
+			merged-three merged-five  \
+			merged-five  merged-one   &&
+		test_cmp expect actual &&
+
+		git cat-file -p :2:two >expect &&
+		git cat-file -p :3:two >other &&
+		test_must_fail git merge-file    \
+			-L "HEAD"  -L ""  -L "B^0" \
+			expect     empty  other &&
+		test_cmp expect two &&
+
+		git cat-file -p :2:four >expect &&
+		git cat-file -p :3:four >other &&
+		test_must_fail git merge-file    \
+			-L "HEAD"  -L ""  -L "B^0" \
+			expect     empty  other &&
+		test_cmp expect four &&
+
+		git cat-file -p :2:six >expect &&
+		git cat-file -p :3:six >other &&
+		test_must_fail git merge-file    \
+			-L "HEAD"  -L ""  -L "B^0" \
+			expect     empty  other &&
+		test_cmp expect six
+	)
+'
+
 test_done
-- 
2.18.0.130.gd703bbb5d

