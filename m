Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6EEEE6446
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 08:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjIOIe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjIOIe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 04:34:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E10DF7
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 01:34:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so2198155a12.3
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694766861; x=1695371661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRn0wk4FgwWKg0JadnI4Qf6ALwNLHzV82r//ZK4IJbY=;
        b=YAYCclUmf4E60Gq4VcEN9CnFsGN7vkLQh0hpWmLY7Ux+iirIBBI7yfjktkagfTr1On
         rOFcNcHy8mDzb0ePQYDatwyU6NGZw5GgA3xKkowHDAPGz8bbNcmkQs7mvFAOzA0Z9NlC
         ooAiRSvdP2JhSQZIxU8QNTkEXIkULjTHQNepuh76k6vF6wkaAGhLMI74t3w030Y8Hbi/
         266RJo/z6QSHTto5qQUHe1L6uOEz/dIw1xbjJVFvU/iCkdC5OXcPGRLfloeY6CZzUvLd
         iZfGDuBBcWjxL1ESrXHwokVpAeKe87btAsw+RZ+1K0AhYhwmaVbsFd8LuSHox0SPbD3L
         qZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694766861; x=1695371661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRn0wk4FgwWKg0JadnI4Qf6ALwNLHzV82r//ZK4IJbY=;
        b=n2BmTVJzwVsxeuMbq9+X66J2T7ZQ4BqOSDPd9UpA7Ifp6UoRuBH+zCUeY3a4Glol/W
         tLIe0Zzkrr79wJLBpCDZEzCEDT7K39jL9mkp7T/VhCeenrsN4/UrUgXOYmSnl5nuh7fV
         Yeh5iZCvb6kUcgYPuc5E7orjgQyxew8zDOk+58gUCkVCtPfih9ozrlyv5jHM1k3qTAnB
         OoD9mvf0M1AjBPThwGJsnWP6Qy74DJ2px8cgsbPOWQ/vsbFV0zPmJlzlU2j1OFzN3Emk
         NBtDZGHnUnsWICt0myc3maGLOAegf/vymbGEbToTHYTFIeu8LjzsGLZiGLiY8o62P2/z
         JudA==
X-Gm-Message-State: AOJu0Yw88ikhctGANjgXZ1ET+1IZLmkJ7D33Hr8gMydL9svEAt/g9wZo
        B/HQkQTl1BotSMIC3hFYfmLgocJJKaPF1Q==
X-Google-Smtp-Source: AGHT+IEZgQ6pMGPfX34Q7KWJpyrhPqcyy/nKoNhRP2ekB5ImzwVsCJ1/ATLDWoJ0SlZ8Ypj/Vk+RtA==
X-Received: by 2002:a17:906:5306:b0:9a1:eb67:c0ce with SMTP id h6-20020a170906530600b009a1eb67c0cemr892604ejo.50.1694766860337;
        Fri, 15 Sep 2023 01:34:20 -0700 (PDT)
Received: from worklaptop.fritz.box ([2a02:2454:56d:f00:47bc:9393:72b0:bdf2])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906560a00b0099d0c0bb92bsm2071568ejq.80.2023.09.15.01.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 01:34:19 -0700 (PDT)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To:     karthik.188@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
Subject: [PATCH v3] revision: add `--ignore-missing-links` user option
Date:   Fri, 15 Sep 2023 10:34:15 +0200
Message-ID: <20230915083415.263187-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912155820.136111-1-karthik.188@gmail.com>
References: <20230912155820.136111-1-karthik.188@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

The revision backend is used by multiple porcelain commands such as
git-rev-list(1) and git-log(1). The backend currently supports ignoring
missing links by setting the `ignore_missing_links` bit. This allows the
revision walk to skip any objects links which are missing. Expose this
bit via an `--ignore-missing-links` user option.

A scenario where this option would be used is to find the boundary
objects between different object directories. Consider a repository with
a main object directory (GIT_OBJECT_DIRECTORY) and one or more alternate
object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES). In such a
repository, enabling this option along with the `--boundary` option
while disabling the alternate object directory allows us to find the
boundary objects between the main and alternate object directory.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Changes since v2:
- Refactored the tests thanks to Taylor! 

Range diff against version 2:

 1:  e3f4d85732 ! 1:  a08f3637a0 revision: add `--ignore-missing-links` user option
    @@ Commit message
         while disabling the alternate object directory allows us to find the
         boundary objects between the main and alternate object directory.
     
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/rev-list-options.txt ##
    @@ t/t6022-rev-list-alternates.sh (new)
     +# We create 5 commits and move them to the alt directory and
     +# create 5 more commits which will stay in the main odb.
     +test_expect_success 'create repository and alternate directory' '
    -+	git init main &&
    -+	test_commit_bulk -C main 5 &&
    -+	BOUNDARY_COMMIT=$(git -C main rev-parse HEAD) &&
    -+	mkdir alt &&
    -+	mv main/.git/objects/* alt &&
    -+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt test_commit_bulk --start=6 -C main 5
    ++	test_commit_bulk 5 &&
    ++	git clone --reference=. --shared . alt &&
    ++	test_commit_bulk --start=6 -C alt 5
     +'
     +
     +# when the alternate odb is provided, all commits are listed along with the boundary
     +# commit.
     +test_expect_success 'rev-list passes with alternate object directory' '
    -+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main rev-list HEAD >actual &&
    -+	test_stdout_line_count = 10 cat actual &&
    -+	grep $BOUNDARY_COMMIT actual
    ++	git -C alt rev-list --all --objects --no-object-names >actual.raw &&
    ++	{
    ++		git rev-list --all --objects --no-object-names &&
    ++		git -C alt rev-list --all --objects --no-object-names --not \
    ++			--alternate-refs
    ++	} >expect.raw &&
    ++	sort actual.raw >actual &&
    ++	sort expect.raw >expect &&
    ++	test_cmp expect actual
     +'
     +
    ++alt=alt/.git/objects/info/alternates
    ++
    ++hide_alternates () {
    ++	test -f "$alt.bak" || mv "$alt" "$alt.bak"
    ++}
    ++
    ++show_alternates () {
    ++	test -f "$alt" || mv "$alt.bak" "$alt"
    ++}
    ++
     +# When the alternate odb is not provided, rev-list fails since the 5th commit's
     +# parent is not present in the main odb.
     +test_expect_success 'rev-list fails without alternate object directory' '
    -+	test_must_fail git -C main rev-list HEAD
    ++	hide_alternates &&
    ++	test_must_fail git -C alt rev-list HEAD
     +'
     +
     +# With `--ignore-missing-links`, we stop the traversal when we encounter a
     +# missing link. The boundary commit is not listed as we haven't used the
     +# `--boundary` options.
     +test_expect_success 'rev-list only prints main odb commits with --ignore-missing-links' '
    -+	git -C main rev-list --ignore-missing-links HEAD >actual &&
    -+	test_stdout_line_count = 5 cat actual &&
    -+	! grep -$BOUNDARY_COMMIT actual
    ++	hide_alternates &&
    ++
    ++	git -C alt rev-list --objects --no-object-names \
    ++		--ignore-missing-links HEAD >actual.raw &&
    ++	git -C alt cat-file  --batch-check="%(objectname)" \
    ++		--batch-all-objects >expect.raw &&
    ++
    ++	sort actual.raw >actual &&
    ++	sort expect.raw >expect &&
    ++	test_must_fail git -C alt rev-list HEAD
     +'
     +
     +# With `--ignore-missing-links` and `--boundary`, we can even print those boundary
     +# commits.
     +test_expect_success 'rev-list prints boundary commit with --ignore-missing-links' '
    -+	git -C main rev-list --ignore-missing-links --boundary HEAD >actual &&
    -+	test_stdout_line_count = 6 cat actual &&
    -+	grep -$BOUNDARY_COMMIT actual
    ++	git -C alt rev-list --ignore-missing-links --boundary HEAD >got &&
    ++	grep "^-$(git rev-parse HEAD)" got
     +'
     +
    -+# The `--ignore-missing-links` option should ensure that git-rev-list(1) doesn't
    -+# fail when used alongside `--objects` when a tree is missing.
    -+test_expect_success 'rev-list --ignore-missing-links works with missing tree' '
    -+	echo "foo" >main/file &&
    -+	git -C main add file &&
    -+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 11" &&
    -+	TREE_OID=$(git -C main rev-parse HEAD^{tree}) &&
    -+	mkdir alt/${TREE_OID:0:2} &&
    -+	mv main/.git/objects/${TREE_OID:0:2}/${TREE_OID:2} alt/${TREE_OID:0:2}/ &&
    -+	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
    -+	! grep $TREE_OID actual
    ++test_expect_success "setup for rev-list --ignore-missing-links with missing objects" '
    ++	show_alternates &&
    ++	test_commit -C alt 11
     +'
     +
    -+# Similar to above, it should also work when a blob is missing.
    -+test_expect_success 'rev-list --ignore-missing-links works with missing blob' '
    -+	echo "bar" >main/file &&
    -+	git -C main add file &&
    -+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$PWD/alt git -C main commit -m"commit 12" &&
    -+	BLOB_OID=$(git -C main rev-parse HEAD:file) &&
    -+	mkdir alt/${BLOB_OID:0:2} &&
    -+	mv main/.git/objects/${BLOB_OID:0:2}/${BLOB_OID:2} alt/${BLOB_OID:0:2}/ &&
    -+	git -C main rev-list --ignore-missing-links --objects HEAD >actual &&
    -+	! grep $BLOB_OID actual
    -+'
    ++for obj in "HEAD^{tree}" "HEAD:11.t"
    ++do
    ++	# The `--ignore-missing-links` option should ensure that git-rev-list(1)
    ++	# doesn't fail when used alongside `--objects` when a tree/blob is
    ++	# missing.
    ++	test_expect_success "rev-list --ignore-missing-links with missing $type" '
    ++		oid="$(git -C alt rev-parse $obj)" &&
    ++		path="alt/.git/objects/$(test_oid_to_path $oid)" &&
    ++
    ++		mv "$path" "$path.hidden" &&
    ++		test_when_finished "mv $path.hidden $path" &&
    ++
    ++		git -C alt rev-list --ignore-missing-links --objects HEAD \
    ++			>actual &&
    ++		! grep $oid actual
    ++       '
    ++done
     +
     +test_done


 Documentation/rev-list-options.txt |  9 +++
 builtin/rev-list.c                 |  3 +-
 revision.c                         |  2 +
 t/t6022-rev-list-alternates.sh     | 93 ++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)
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
index 0000000000..567dd21876
--- /dev/null
+++ b/t/t6022-rev-list-alternates.sh
@@ -0,0 +1,93 @@
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
+	test_commit_bulk 5 &&
+	git clone --reference=. --shared . alt &&
+	test_commit_bulk --start=6 -C alt 5
+'
+
+# when the alternate odb is provided, all commits are listed along with the boundary
+# commit.
+test_expect_success 'rev-list passes with alternate object directory' '
+	git -C alt rev-list --all --objects --no-object-names >actual.raw &&
+	{
+		git rev-list --all --objects --no-object-names &&
+		git -C alt rev-list --all --objects --no-object-names --not \
+			--alternate-refs
+	} >expect.raw &&
+	sort actual.raw >actual &&
+	sort expect.raw >expect &&
+	test_cmp expect actual
+'
+
+alt=alt/.git/objects/info/alternates
+
+hide_alternates () {
+	test -f "$alt.bak" || mv "$alt" "$alt.bak"
+}
+
+show_alternates () {
+	test -f "$alt" || mv "$alt.bak" "$alt"
+}
+
+# When the alternate odb is not provided, rev-list fails since the 5th commit's
+# parent is not present in the main odb.
+test_expect_success 'rev-list fails without alternate object directory' '
+	hide_alternates &&
+	test_must_fail git -C alt rev-list HEAD
+'
+
+# With `--ignore-missing-links`, we stop the traversal when we encounter a
+# missing link. The boundary commit is not listed as we haven't used the
+# `--boundary` options.
+test_expect_success 'rev-list only prints main odb commits with --ignore-missing-links' '
+	hide_alternates &&
+
+	git -C alt rev-list --objects --no-object-names \
+		--ignore-missing-links HEAD >actual.raw &&
+	git -C alt cat-file  --batch-check="%(objectname)" \
+		--batch-all-objects >expect.raw &&
+
+	sort actual.raw >actual &&
+	sort expect.raw >expect &&
+	test_must_fail git -C alt rev-list HEAD
+'
+
+# With `--ignore-missing-links` and `--boundary`, we can even print those boundary
+# commits.
+test_expect_success 'rev-list prints boundary commit with --ignore-missing-links' '
+	git -C alt rev-list --ignore-missing-links --boundary HEAD >got &&
+	grep "^-$(git rev-parse HEAD)" got
+'
+
+test_expect_success "setup for rev-list --ignore-missing-links with missing objects" '
+	show_alternates &&
+	test_commit -C alt 11
+'
+
+for obj in "HEAD^{tree}" "HEAD:11.t"
+do
+	# The `--ignore-missing-links` option should ensure that git-rev-list(1)
+	# doesn't fail when used alongside `--objects` when a tree/blob is
+	# missing.
+	test_expect_success "rev-list --ignore-missing-links with missing $type" '
+		oid="$(git -C alt rev-parse $obj)" &&
+		path="alt/.git/objects/$(test_oid_to_path $oid)" &&
+
+		mv "$path" "$path.hidden" &&
+		test_when_finished "mv $path.hidden $path" &&
+
+		git -C alt rev-list --ignore-missing-links --objects HEAD \
+			>actual &&
+		! grep $oid actual
+       '
+done
+
+test_done
-- 
2.41.0

