Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEADC1F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbdL1EON (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:13 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:43036 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbdL1EOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:09 -0500
Received: by mail-io0-f174.google.com with SMTP id k202so28892817ioe.10
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xIBbabmqSwe9oI8Vz/j4mEwVOpbeCLaqbVdNfACZFy8=;
        b=U+oaEkCSkhZm4WvVReWLwtpBXwjJllB8k7fFuNb7N8ca5Sww1121xNrf86p2QCSxul
         afJ7LZ7aZUuu2/jMCTerKxVtP2XPc91yZUacJgkGNtnjr4R8Tg7iPkOhma0k7Uxufp3/
         BFRth6LBDNTcOE5SFHq8dpqJhuUUfo0spq5VQeggWC7GbBN1NbF0nqa20TrtbGlNSP8E
         vJ9XDxVuvd+zZDGz/4zu8L0KOwHPj6J094KQAX4jhMXnzy9szivXYaLZVxcOxFnIGdhF
         UBqwTo+UoBGu/vI06i7alwCfqr3+HUmbGDQA/TF+J/Zxzs1m35nI3aIkdoHq8d95A4Mn
         I8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xIBbabmqSwe9oI8Vz/j4mEwVOpbeCLaqbVdNfACZFy8=;
        b=IvYelBZmOXfDALvT3XJ+sLnZnYqe/5Eq90m8D3ukhk7OqnVH00f0Re1KBO4lG0Pg44
         lJUGMs423zg5NJmgyLPA7xa+goWMBJ9Cb+Ny+46b8Sd/alOVgYYWB8EGVrxqHxvH8DxC
         WeFLp/l5ecq37+zgog+7/PriSQfWvGA+NhmXktT4sZA4XUrf15q/OlergCHiAczE8xQ7
         8QvWbp4qF695OuqRg02o0q6p0sDoKmyPCRyG+raDE9mzatSss1EBvZdmmwcedwShREVc
         0PGnEc1Gj2F4fhqK4l0dM2LQf4o0HRH8iG4/AQ0tbsBf2GkqDiiWPfpbtM2ymq18b9xF
         LnYQ==
X-Gm-Message-State: AKGB3mKjrub77basgwWlBgkgOr6lk5puCS772xKysD1C6tlKPY/1kJGR
        VX4fI1tQf5eEbwyKxLNlN6hWqg==
X-Google-Smtp-Source: ACJfBotLJSI1sfi+Yo18XywUcQhjFFdp8jfaTPasjoksS1xVyHyzfg1fUhLq5LBF/nLQvSeMxLIB1A==
X-Received: by 10.107.174.147 with SMTP id n19mr40293628ioo.131.1514434448417;
        Wed, 27 Dec 2017 20:14:08 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:07 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 08/34] directory rename detection: files/directories in the way of some renames
Date:   Wed, 27 Dec 2017 20:13:26 -0800
Message-Id: <20171228041352.27880-9-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 320 ++++++++++++++++++++++++++++++++++++
 1 file changed, 320 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 28b2d2a2b..468d6d537 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -818,4 +818,324 @@ test_expect_success '4a-check: Directory split, with original directory still pr
 #   detection.)  But, sadly, see testcase 8b.
 ###########################################################################
 
+
+###########################################################################
+# SECTION 5: Files/directories in the way of subset of to-be-renamed paths
+#
+# Implicitly renaming files due to a detected directory rename could run
+# into problems if there are files or directories in the way of the paths
+# we want to rename.  Explore such cases in this section.
+###########################################################################
+
+# Testcase 5a, Merge directories, other side adds files to original and target
+#   Commit O: z/{b,c},       y/d
+#   Commit A: z/{b,c,e_1,f}, y/{d,e_2}
+#   Commit B: y/{b,c,d}
+#   Expected: z/e_1, y/{b,c,d,e_2,f} + CONFLICT warning
+#   NOTE: While directory rename detection is active here causing z/f to
+#         become y/f, we did not apply this for z/e_1 because that would
+#         give us an add/add conflict for y/e_1 vs y/e_2.  This problem with
+#         this add/add, is that both versions of y/e are from the same side
+#         of history, giving us no way to represent this conflict in the
+#         index.
+
+test_expect_success '5a-setup: Merge directories, other side adds files to original and target' '
+	test_create_repo 5a &&
+	(
+		cd 5a &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir y &&
+		echo d >y/d &&
+		git add z y &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		echo e1 >z/e &&
+		echo f >z/f &&
+		echo e2 >y/e &&
+		git add z/e z/f y/e &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '5a-check: Merge directories, other side adds files to original and target' '
+	(
+		cd 5a &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+		test 0 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :0:y/d :0:y/e :0:z/e &&
+		git rev-parse >expect \
+			O:z/b O:z/c O:y/d A:y/e A:z/e &&
+		test_cmp expect actual &&
+
+		test $(git rev-parse :0:y/f) = $(git rev-parse A:z/f) &&
+
+		test_i18ngrep "CONFLICT.*implicit dir rename" out
+	)
+'
+
+# Testcase 5b, Rename/delete in order to get add/add/add conflict
+#   (Related to testcase 8d; these may appear slightly inconsistent to users;
+#    Also related to testcases 7d and 7e)
+#   Commit O: z/{b,c,d_1}
+#   Commit A: y/{b,c,d_2}
+#   Commit B: z/{b,c,d_1,e}, y/d_3
+#   Expected: y/{b,c,e}, CONFLICT(add/add: y/d_2 vs. y/d_3)
+#   NOTE: If z/d_1 in commit B were to be involved in dir rename detection, as
+#         we normaly would since z/ is being renamed to y/, then this would be
+#         a rename/delete (z/d_1 -> y/d_1 vs. deleted) AND an add/add/add
+#         conflict of y/d_1 vs. y/d_2 vs. y/d_3.  Add/add/add is not
+#         representable in the index, so the existence of y/d_3 needs to
+#         cause us to bail on directory rename detection for that path, falling
+#         back to git behavior without the directory rename detection.
+
+test_expect_success '5b-setup: Rename/delete in order to get add/add/add conflict' '
+	test_create_repo 5b &&
+	(
+		cd 5b &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		echo d1 >z/d &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm z/d &&
+		git mv z y &&
+		echo d2 >y/d &&
+		git add y/d &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		echo d3 >y/d &&
+		echo e >z/e &&
+		git add y/d z/e &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '5b-check: Rename/delete in order to get add/add/add conflict' '
+	(
+		cd 5b &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
+
+		test 5 -eq $(git ls-files -s | wc -l) &&
+		test 2 -eq $(git ls-files -u | wc -l) &&
+		test 1 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :0:y/e :2:y/d :3:y/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/e A:y/d B:y/d &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse :1:y/d &&
+		test -f y/d
+	)
+'
+
+# Testcase 5c, Transitive rename would cause rename/rename/rename/add/add/add
+#   (Directory rename detection would result in transitive rename vs.
+#    rename/rename(1to2) and turn it into a rename/rename(1to3).  Further,
+#    rename paths conflict with separate adds on the other side)
+#   (Related to testcases 3b and 7c)
+#   Commit O: z/{b,c}, x/d_1
+#   Commit A: y/{b,c,d_2}, w/d_1
+#   Commit B: z/{b,c,d_1,e}, w/d_3, y/d_4
+#   Expected: A mess, but only a rename/rename(1to2)/add/add mess.  Use the
+#             presence of y/d_4 in B to avoid doing transitive rename of
+#             x/d_1 -> z/d_1 -> y/d_1, so that the only paths we have at
+#             y/d are y/d_2 and y/d_4.  We still do the move from z/e to y/e,
+#             though, because it doesn't have anything in the way.
+
+test_expect_success '5c-setup: Transitive rename would cause rename/rename/rename/add/add/add' '
+	test_create_repo 5c &&
+	(
+		cd 5c &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		mkdir x &&
+		echo d1 >x/d &&
+		git add z x &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		echo d2 >y/d &&
+		git add y/d &&
+		git mv x w &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv x/d z/ &&
+		mkdir w &&
+		mkdir y &&
+		echo d3 >w/d &&
+		echo d4 >y/d &&
+		echo e >z/e &&
+		git add w/ y/ z/e &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '5c-check: Transitive rename would cause rename/rename/rename/add/add/add' '
+	(
+		cd 5c &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*z/d" out &&
+		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
+
+		test 9 -eq $(git ls-files -s | wc -l) &&
+		test 6 -eq $(git ls-files -u | wc -l) &&
+		test 3 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :0:y/e &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/e &&
+		test_cmp expect actual &&
+
+		test_must_fail git rev-parse :1:y/d &&
+		git rev-parse >actual \
+			:2:w/d :3:w/d :1:x/d :2:y/d :3:y/d :3:z/d &&
+		git rev-parse >expect \
+			O:x/d B:w/d O:x/d A:y/d B:y/d O:x/d &&
+		test_cmp expect actual &&
+
+		git hash-object >actual \
+			w/d~HEAD w/d~B^0 &&
+		git rev-parse >expect \
+			O:x/d B:w/d &&
+		test_cmp expect actual &&
+		test ! -f x/d &&
+		test -f y/d &&
+		grep -q "<<<<" y/d &&  # conflict markers should be present
+		test $(git hash-object z/d) = $(git rev-parse O:x/d)
+	)
+'
+
+# Testcase 5d, Directory/file/file conflict due to directory rename
+#   Commit O: z/{b,c}
+#   Commit A: y/{b,c,d_1}
+#   Commit B: z/{b,c,d_2,f}, y/d/e
+#   Expected: y/{b,c,d/e,f}, z/d_2, CONFLICT(file/directory), y/d_1~HEAD
+#   Note: The fact that y/d/ exists in B makes us bail on directory rename
+#         detection for z/d_2, but that doesn't prevent us from applying the
+#         directory rename detection for z/f -> y/f.
+
+test_expect_success '5d-setup: Directory/file/file conflict due to directory rename' '
+	test_create_repo 5d &&
+	(
+		cd 5d &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv z y &&
+		echo d1 >y/d &&
+		git add y/d &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir -p y/d &&
+		echo e >y/d/e &&
+		echo d2 >z/d &&
+		echo f >z/f &&
+		git add y/d/e z/d z/f &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '5d-check: Directory/file/file conflict due to directory rename' '
+	(
+		cd 5d &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 >out &&
+		test_i18ngrep "CONFLICT (file/directory).*y/d" out &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+		test 1 -eq $(git ls-files -u | wc -l) &&
+		test 2 -eq $(git ls-files -o | wc -l) &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :0:z/d :0:y/f :2:y/d :0:y/d/e &&
+		git rev-parse >expect \
+			O:z/b O:z/c B:z/d B:z/f A:y/d B:y/d/e &&
+		test_cmp expect actual &&
+
+		test $(git hash-object y/d~HEAD) = $(git rev-parse A:y/d)
+	)
+'
+
+###########################################################################
+# Rules suggested by section 5:
+#
+#   If a subset of to-be-renamed files have a file or directory in the way,
+#   "turn off" the directory rename for those specific sub-paths, falling
+#   back to old handling.  But, sadly, see testcases 8a and 8b.
+###########################################################################
+
 test_done
-- 
2.15.0.408.g8e199d483

