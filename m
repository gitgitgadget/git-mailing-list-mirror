Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04EACA0EEB
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 15:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjILP6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILP6o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 11:58:44 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEE110DE
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 08:58:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so93884881fa.3
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694534318; x=1695139118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG7nEDPWZzYkV2l0bCZbsqtJyeGUxf3Eh28hXcDUc3k=;
        b=WkvNXXliitY3Lm/cyYFwduuX9HoxTre2Lt7J0Cg9frp9zvQCYULvxlgyHkcxLb/JD6
         uQNa69aykZfPxt5Tp4IeE/8dOPbgV+dWozEAaWOs1z0Zz/D8ZfOinCuEtT0FFO6eXNFC
         ls2bMAZS/JhURGfS7OtAccmoOxdkWgoxSJ7h250oOrZtHluPfcAY3timVAW39iiQEmLZ
         i8eTwKico0GK6VWwumJY6JOe7wwwezBG2frshEywjplpn3ZjCOwLX3z+UlnNkeufI3Z9
         KBdaQYfKDRIjb8uTr9+AeGbS5kVRkqn694vHjrgFU4T7NhAQqlZ7ZfMFvwUNAj/r6uN6
         reZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534318; x=1695139118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wG7nEDPWZzYkV2l0bCZbsqtJyeGUxf3Eh28hXcDUc3k=;
        b=JsrHBCBMYQ4fwxZ97aoRTMQYaH47WH3Tj3j5wb5HXRHk+rdEuzd5z+gOMOWVm/W7Fm
         XSq4jidJ3p69ZwfgIrmKCOEAbmybxBnxlqMXVXWB7dCJlt/MZbQNZv1uq2RL1u6NoDpg
         SyLFFIw1wodFQNWgLkRbUMdyac0FVVv1Z2iCsXYZBgVjlJgeZ2n6GM07ccbvs5N3QipK
         zAagxmmYGLL/RuN7/W1x0DCoxtXkYr/bDw33Oqn25DJ09dO16joWP7DqSzSw2oEjNats
         kmhdpl00G9B9FFHsDWXXKko0Q9Bpaa9ZoYt1R8M2bbXQvPFV/TEYVzqvOqwKCNK2cuAB
         gE0A==
X-Gm-Message-State: AOJu0YzjLX4VIWXiCuinekMC7nr36A0Yahjv8F997d0qxrJyVK3R6WNK
        D4Tnl4IJN/XBDgI4DkUq4mB7kZ3Pa54=
X-Google-Smtp-Source: AGHT+IHYtag55tw26CXSaKoU0ExfO4UiCCE4C3GKOnT7kRLUeOcAy0rAvmK28GID48QozO/OAb4m6A==
X-Received: by 2002:a2e:9692:0:b0:2b7:11f8:27d with SMTP id q18-20020a2e9692000000b002b711f8027dmr188417lji.7.1694534317673;
        Tue, 12 Sep 2023 08:58:37 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:b15b:356c:2a07:7b52])
        by smtp.gmail.com with ESMTPSA id gs9-20020a170906f18900b0099bd5d28dc4sm7104063ejb.195.2023.09.12.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 08:58:37 -0700 (PDT)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2] revision: add `--ignore-missing-links` user option
Date:   Tue, 12 Sep 2023 17:58:20 +0200
Message-ID: <20230912155820.136111-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908174208.249184-1-karthik.188@gmail.com>
References: <20230908174208.249184-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The revision backend is used by multiple porcelain commands such as
git-rev-list(1) and git-log(1). The backend currently supports ignoring
missing links by setting the `ignore_missing_links` bit. This allows the
revision walk to skip any objects links which are missing. Expose this
bit via an `--ignore-missing-links` user option.

A scenario where this option would be used is to find the boundary
objects between different object directories. Consider a repository with
a main object directory (GIT_OBJECT_DIRECTORY) and one or more alternate
object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES). In such a
repository, enabling this option along with the `--boundary` option for
while disabling the alternate object directory allows us to find the
boundary objects between the main and alternate object directory.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Changes from v1:
1. Changes in the commit message and option description to be more specific
and list why and what the changes are.
2. Ensure the new option also works with the existing `--objects` options.
3. More specific testing for boundary commit.

Range diff against v1:

1:  c0a4dca9b0 ! 1:  e3f4d85732 revision: add `--ignore-missing-links` user option
    @@ Commit message
         The revision backend is used by multiple porcelain commands such as
         git-rev-list(1) and git-log(1). The backend currently supports ignoring
         missing links by setting the `ignore_missing_links` bit. This allows the
    -    revision walk to skip any objects links which are missing.
    +    revision walk to skip any objects links which are missing. Expose this
    +    bit via an `--ignore-missing-links` user option.
     
    -    Currently there is no way to use git-rev-list(1) to traverse the objects
    -    of the main object directory (GIT_OBJECT_DIRECTORY) and print the
    -    boundary objects when moving from the main object directory to the
    -    alternate object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES).
    -
    -    By exposing this new flag `--ignore-missing-links`, users can set the
    -    required env variables (GIT_OBJECT_DIRECTORY and
    -    GIT_ALTERNATE_OBJECT_DIRECTORIES) along with the `--boundary` flag to
    -    find the boundary objects between object directories.
    +    A scenario where this option would be used is to find the boundary
    +    objects between different object directories. Consider a repository with
    +    a main object directory (GIT_OBJECT_DIRECTORY) and one or more alternate
    +    object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES). In such a
    +    repository, enabling this option along with the `--boundary` option for
    +    while disabling the alternate object directory allows us to find the
    +    boundary objects between the main and alternate object directory.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Documentation/rev-list-options.txt: explicitly.
      	the bad input was not given.
      
     +--ignore-missing-links::
    -+	When an object points to another object that is missing, pretend as if the
    -+	link did not exist. These missing links are not written to stdout unless
    -+	the --boundary flag is passed.
    ++	During traversal, if an object that is referenced does not
    ++	exist, instead of dying of a repository corruption, pretend as
    ++	if the reference itself does not exist. Running the command
    ++	with the `--boundary` option makes these missing commits,
    ++	together with the commits on the edge of revision ranges
    ++	(i.e. true boundary objects), appear on the output, prefixed
    ++	with '-'.
     +
      ifndef::git-rev-list[]
      --bisect::
      	Pretend as if the bad bisection ref `refs/bisect/bad`
     
    + ## builtin/rev-list.c ##
    +@@ builtin/rev-list.c: static int finish_object(struct object *obj, const char *name UNUSED,
    + {
    + 	struct rev_list_info *info = cb_data;
    + 	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
    +-		finish_object__ma(obj);
    ++		if (!info->revs->ignore_missing_links)
    ++			finish_object__ma(obj);
    + 		return 1;
    + 	}
    + 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
    +
      ## revision.c ##
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
      		revs->limited = 1;
    @@ t/t6022-rev-list-alternates.sh (new)
     +test_expect_success 'create repository and alternate directory' '
     +	git init main &&
     +	test_commit_bulk -C main 5 &&
    ++	BOUNDARY_COMMIT=$(git -C main rev-parse HEAD) &&
     +	mkdir alt &&
     +	mv main/.git/objects/* alt &&
     +	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt test_commit_bulk --start=6 -C main 5
     +'
     +
    -+# When the alternate odb is provided, all commits are listed.
    ++# when the alternate odb is provided, all commits are listed along with the boundary
    ++# commit.
     +test_expect_success 'rev-list passes with alternate object directory' '
    -+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt test_stdout_line_count = 10 git -C main rev-list HEAD
    ++	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main rev-list HEAD >actual &&
    ++	test_stdout_line_count = 10 cat actual &&
    ++	grep $BOUNDARY_COMMIT actual
     +'
     +
     +# When the alternate odb is not provided, rev-list fails since the 5th commit's
    @@ t/t6022-rev-list-alternates.sh (new)
     +'
     +
     +# With `--ignore-missing-links`, we stop the traversal when we encounter a
    -+# missing link.
    ++# missing link. The boundary commit is not listed as we haven't used the
    ++# `--boundary` options.
     +test_expect_success 'rev-list only prints main odb commits with --ignore-missing-links' '
    -+	test_stdout_line_count = 5 git -C main rev-list --ignore-missing-links HEAD
    ++	git -C main rev-list --ignore-missing-links HEAD >actual &&
    ++	test_stdout_line_count = 5 cat actual &&
    ++	! grep -$BOUNDARY_COMMIT actual
     +'
     +
     +# With `--ignore-missing-links` and `--boundary`, we can even print those boundary
     +# commits.
     +test_expect_success 'rev-list prints boundary commit with --ignore-missing-links' '
    -+	git -C main rev-list --ignore-missing-links --boundary HEAD >list-output &&
    -+	test_stdout_line_count = 6 cat list-output &&
    -+	test_stdout_line_count = 1 cat list-output | grep "^-"
    ++	git -C main rev-list --ignore-missing-links --boundary HEAD >actual &&
    ++	test_stdout_line_count = 6 cat actual &&
    ++	grep -$BOUNDARY_COMMIT actual
    ++'
    ++
    ++# The `--ignore-missing-links` option should ensure that git-rev-list(1) doesn't
    ++# fail when used alongside `--objects` when a tree is missing.
    ++test_expect_success 'rev-list --ignore-missing-links works with missing tree' '
    ++	echo "foo" >main/file &&
    ++	git -C main add file &&
    ++	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 11" &&
    ++	TREE_OID=$(git -C main rev-parse HEAD^{tree}) &&
    ++	mkdir alt/${TREE_OID:0:2} &&
    ++	mv main/.git/objects/${TREE_OID:0:2}/${TREE_OID:2} alt/${TREE_OID:0:2}/ &&
    ++	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
    ++	! grep $TREE_OID actual
    ++'
    ++
    ++# Similar to above, it should also work when a blob is missing.
    ++test_expect_success 'rev-list --ignore-missing-links works with missing blob' '
    ++	echo "bar" >main/file &&
    ++	git -C main add file &&
    ++	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 12" &&
    ++	BLOB_OID=$(git -C main rev-parse HEAD:file) &&
    ++	mkdir alt/${BLOB_OID:0:2} &&
    ++	mv main/.git/objects/${BLOB_OID:0:2}/${BLOB_OID:2} alt/${BLOB_OID:0:2}/ &&
    ++	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
    ++	! grep $BLOB_OID actual
     +'
     +
     +test_done


 Documentation/rev-list-options.txt |  9 ++++
 builtin/rev-list.c                 |  3 +-
 revision.c                         |  2 +
 t/t6022-rev-list-alternates.sh     | 75 ++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100755 t/t6022-rev-list-alternates.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a4a0cb93b2..8ee713db3d 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -227,6 +227,15 @@ explicitly.
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
 
+--ignore-missing-links::
+	During traversal, if an object that is referenced does not
+	exist, instead of dying of a repository corruption, pretend as
+	if the reference itself does not exist. Running the command
+	with the `--boundary` option makes these missing commits,
+	together with the commits on the edge of revision ranges
+	(i.e. true boundary objects), appear on the output, prefixed
+	with '-'.
+
 ifndef::git-rev-list[]
 --bisect::
 	Pretend as if the bad bisection ref `refs/bisect/bad`
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff715d6918..5239d83c76 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -266,7 +266,8 @@ static int finish_object(struct object *obj, const char *name UNUSED,
 {
 	struct rev_list_info *info = cb_data;
 	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
-		finish_object__ma(obj);
+		if (!info->revs->ignore_missing_links)
+			finish_object__ma(obj);
 		return 1;
 	}
 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
diff --git a/revision.c b/revision.c
index 2f4c53ea20..cbfcbf6e28 100644
--- a/revision.c
+++ b/revision.c
@@ -2595,6 +2595,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
+	} else if (!strcmp(arg, "--ignore-missing-links")) {
+		revs->ignore_missing_links = 1;
 	} else if (opt && opt->allow_exclude_promisor_objects &&
 		   !strcmp(arg, "--exclude-promisor-objects")) {
 		if (fetch_if_missing)
diff --git a/t/t6022-rev-list-alternates.sh b/t/t6022-rev-list-alternates.sh
new file mode 100755
index 0000000000..08d9ffde5f
--- /dev/null
+++ b/t/t6022-rev-list-alternates.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description='handling of alternates in rev-list'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+# We create 5 commits and move them to the alt directory and
+# create 5 more commits which will stay in the main odb.
+test_expect_success 'create repository and alternate directory' '
+	git init main &&
+	test_commit_bulk -C main 5 &&
+	BOUNDARY_COMMIT=$(git -C main rev-parse HEAD) &&
+	mkdir alt &&
+	mv main/.git/objects/* alt &&
+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt test_commit_bulk --start=6 -C main 5
+'
+
+# when the alternate odb is provided, all commits are listed along with the boundary
+# commit.
+test_expect_success 'rev-list passes with alternate object directory' '
+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main rev-list HEAD >actual &&
+	test_stdout_line_count = 10 cat actual &&
+	grep $BOUNDARY_COMMIT actual
+'
+
+# When the alternate odb is not provided, rev-list fails since the 5th commit's
+# parent is not present in the main odb.
+test_expect_success 'rev-list fails without alternate object directory' '
+	test_must_fail git -C main rev-list HEAD
+'
+
+# With `--ignore-missing-links`, we stop the traversal when we encounter a
+# missing link. The boundary commit is not listed as we haven't used the
+# `--boundary` options.
+test_expect_success 'rev-list only prints main odb commits with --ignore-missing-links' '
+	git -C main rev-list --ignore-missing-links HEAD >actual &&
+	test_stdout_line_count = 5 cat actual &&
+	! grep -$BOUNDARY_COMMIT actual
+'
+
+# With `--ignore-missing-links` and `--boundary`, we can even print those boundary
+# commits.
+test_expect_success 'rev-list prints boundary commit with --ignore-missing-links' '
+	git -C main rev-list --ignore-missing-links --boundary HEAD >actual &&
+	test_stdout_line_count = 6 cat actual &&
+	grep -$BOUNDARY_COMMIT actual
+'
+
+# The `--ignore-missing-links` option should ensure that git-rev-list(1) doesn't
+# fail when used alongside `--objects` when a tree is missing.
+test_expect_success 'rev-list --ignore-missing-links works with missing tree' '
+	echo "foo" >main/file &&
+	git -C main add file &&
+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 11" &&
+	TREE_OID=$(git -C main rev-parse HEAD^{tree}) &&
+	mkdir alt/${TREE_OID:0:2} &&
+	mv main/.git/objects/${TREE_OID:0:2}/${TREE_OID:2} alt/${TREE_OID:0:2}/ &&
+	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
+	! grep $TREE_OID actual
+'
+
+# Similar to above, it should also work when a blob is missing.
+test_expect_success 'rev-list --ignore-missing-links works with missing blob' '
+	echo "bar" >main/file &&
+	git -C main add file &&
+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 12" &&
+	BLOB_OID=$(git -C main rev-parse HEAD:file) &&
+	mkdir alt/${BLOB_OID:0:2} &&
+	mv main/.git/objects/${BLOB_OID:0:2}/${BLOB_OID:2} alt/${BLOB_OID:0:2}/ &&
+	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
+	! grep $BLOB_OID actual
+'
+
+test_done
-- 
2.41.0

