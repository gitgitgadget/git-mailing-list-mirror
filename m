Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99BD1F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 05:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeGKFVK (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 01:21:10 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34898 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeGKFVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 01:21:09 -0400
Received: by mail-yw0-f193.google.com with SMTP id t18-v6so8714810ywg.2
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 22:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ExOKUgRlL94v4sX6/wr+YZcKoR6R2ub79/qFqeoaZ48=;
        b=vH8BhZQi6Bia378BwNntW2OENCLvEoZDmWYCxGeFXOvxPSXOsIFJMjwtKfzaqUFJxf
         e/kaMQaVfLFNMumcGZD3Ax0tcCVVsFYlgEpeS+H2MjgJSzhknf9bQXvNn5Wfzm0cfPyi
         UHFpAG1JUUYuqOdFqMmC7J7QTV9gl4SchuCrfcBXUErcFLUxeqZ28VOT6EUqeKSffiDZ
         o/nhKz5d7i6v+tg6a/d4nG84OU4GgkzJon1nl7lBdESWkBCBqyNwaX6MqfUFoqnOox9X
         +pWerAPWfNhLClQSFOQBFsBACSlgCZI+uo5AD0qLZ8RWR0gGF5Gq1mPURXTm9qwkI0ek
         xFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ExOKUgRlL94v4sX6/wr+YZcKoR6R2ub79/qFqeoaZ48=;
        b=t1ISQGSkEqz8AteYqy2HXNp2UhB8T7oBsGueoR2UofqOMwMnfWSLhXwZiBkKBNzegk
         0RaTx2jbFR366I1xKR/jFqxG+OQhS6LY8OcTqFIVPhuQmwiW24eCGe5qTRKLoOGG4zjE
         IWwT/fCAa2aK4dMrHolX80rHXneNHvlLEDBi1wwV6cX0hydnxrwWnP5pm5Yc8csmV1w/
         BGZfccuJAlE9yDI0Dvm1IHO8LW3VkXk7yKp45HTayprmv65D7u0a8XCaDOpPw/JWVu01
         aXr8+4cEHu9Qlvb+Nx4fXsaQrvGZ7Q/3Cip83g2M0avrA5Qev9xInWiKZHtpfi+o67UN
         SFkw==
X-Gm-Message-State: AOUpUlFmGrNThPqVXIeO6ni5/7PjpNJcZu62AegXx2FhIAmNZpRzya/l
        AzyYldjXanQQBIwQK6TVN9fB+A==
X-Google-Smtp-Source: AAOMgpe6ihQ1nLS86EuKLdR6bL8u0azz8HnJvdnsvEXMpDQQLnysVntBoUmkrfZhuxFBKlRlzPkuBg==
X-Received: by 2002:a0d:fc41:: with SMTP id m62-v6mr7015830ywf.210.1531286320805;
        Tue, 10 Jul 2018 22:18:40 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x185-v6sm7561851ywb.69.2018.07.10.22.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 22:18:40 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] t1015: demonstrate directory/file conflict recovery failures
Date:   Tue, 10 Jul 2018 22:18:33 -0700
Message-Id: <20180711051834.28181-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.132.g6e63b23f4
In-Reply-To: <20180711051834.28181-1-newren@gmail.com>
References: <20180711051834.28181-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several "recovery" commands outright fail or do not fully recover
when directory-file conflicts are present.  This includes:
  * git read-tree --reset HEAD
  * git am --skip
  * git am --abort
  * git merge --abort
  * git reset --hard

Add testcases documenting these shortcomings.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1015-read-index-unmerged.sh | 123 +++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100755 t/t1015-read-index-unmerged.sh

diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
new file mode 100755
index 000000000..bbd64587c
--- /dev/null
+++ b/t/t1015-read-index-unmerged.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+
+test_description='Test various callers of read_index_unmerged'
+. ./test-lib.sh
+
+test_expect_success 'setup modify/delete + directory/file conflict' '
+	test_create_repo df_plus_modify_delete &&
+	(
+		cd df_plus_modify_delete &&
+
+		printf "a\nb\nc\nd\ne\nf\ng\nh\n" >letters &&
+		git add letters &&
+		git commit -m initial &&
+
+		git checkout -b modify &&
+		# Throw in letters.txt for sorting order fun
+		# ("letters.txt" sorts between "letters" and "letters/file")
+		echo i >>letters &&
+		echo "version 2" >letters.txt &&
+		git add letters letters.txt &&
+		git commit -m modified &&
+
+		git checkout -b delete HEAD^ &&
+		git rm letters &&
+		mkdir letters &&
+		>letters/file &&
+		echo "version 1" >letters.txt &&
+		git add letters letters.txt &&
+		git commit -m deleted
+	)
+'
+
+test_expect_failure 'read-tree --reset cleans unmerged entries' '
+	test_when_finished "git -C df_plus_modify_delete clean -f" &&
+	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
+	(
+		cd df_plus_modify_delete &&
+
+		git checkout delete^0 &&
+		test_must_fail git merge modify &&
+
+		git read-tree --reset HEAD &&
+		git ls-files -u >conflicts &&
+		test_must_be_empty conflicts
+	)
+'
+
+test_expect_failure 'One reset --hard cleans unmerged entries' '
+	test_when_finished "git -C df_plus_modify_delete clean -f" &&
+	test_when_finished "git -C df_plus_modify_delete reset --hard" &&
+	(
+		cd df_plus_modify_delete &&
+
+		git checkout delete^0 &&
+		test_must_fail git merge modify &&
+
+		git reset --hard &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		git ls-files -u >conflicts &&
+		test_must_be_empty conflicts
+	)
+'
+
+test_expect_success 'setup directory/file conflict + simple edit/edit' '
+	test_create_repo df_plus_edit_edit &&
+	(
+		cd df_plus_edit_edit &&
+
+		test_seq 1 10 >numbers &&
+		git add numbers &&
+		git commit -m initial &&
+
+		git checkout -b d-edit &&
+		mkdir foo &&
+		echo content >foo/bar &&
+		git add foo &&
+		echo 11 >>numbers &&
+		git add numbers &&
+		git commit -m "directory and edit" &&
+
+		git checkout -b f-edit d-edit^1 &&
+		echo content >foo &&
+		git add foo &&
+		echo eleven >>numbers &&
+		git add numbers &&
+		git commit -m "file and edit"
+	)
+'
+
+test_expect_failure 'git merge --abort succeeds despite D/F conflict' '
+	test_when_finished "git -C df_plus_edit_edit clean -f" &&
+	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
+	(
+		cd df_plus_edit_edit &&
+
+		git checkout f-edit^0 &&
+		test_must_fail git merge d-edit^0 &&
+
+		git merge --abort &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		git ls-files -u >conflicts &&
+		test_must_be_empty conflicts
+	)
+'
+
+test_expect_failure 'git am --skip succeeds despite D/F conflict' '
+	test_when_finished "git -C df_plus_edit_edit clean -f" &&
+	test_when_finished "git -C df_plus_edit_edit reset --hard" &&
+	(
+		cd df_plus_edit_edit &&
+
+		git checkout f-edit^0 &&
+		git format-patch -1 d-edit &&
+		test_must_fail git am -3 0001*.patch &&
+
+		git am --skip &&
+		test_path_is_missing .git/rebase-apply &&
+		git ls-files -u >conflicts &&
+		test_must_be_empty conflicts
+	)
+'
+
+test_done
-- 
2.18.0.138.g557c5d94c.dirty

