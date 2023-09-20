Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DA1CE79C2
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 10:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjITKqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjITKpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 06:45:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BBD12E
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 03:45:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-530c9980556so5165655a12.2
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 03:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695206739; x=1695811539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI/fb/IBGPFl7APseC8grqIFZ73e9cRB+c0BuAAc0QU=;
        b=jKWHdUb5Vm+jK9kHJNnCA+oynNERhA6sB0vpNJMdvtPWK8GIm8esKBFYyeVqUChNef
         8JG4xSuxZAS5KCJLDNyyGDqwvCyEotnwzetwIfiTujvXhDfaQQED4U9LQ/Zy5wcAM1TG
         m4TrH4kiG8ANmglPzHaRTM0L1nf2/9Xo3tOvmy9VDcWoA+uOTxHPc//e/j77JAJ1N4SP
         ngZfr9S7zICk1YGNPMgpovujhFzRSkuYFIHt5veRO5JOsjWutJQZLGL/+OcFIX1j4yya
         t+VIqQqH1U7CgzJz5OYRBeFMYXsguWv2xFAvJC4y9KrWIrZSkLWYC6+GtUKw14k/36x4
         dTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695206739; x=1695811539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI/fb/IBGPFl7APseC8grqIFZ73e9cRB+c0BuAAc0QU=;
        b=JStvrRDDUftSS6NHanidQE9HJrIQ1XQQ2hhLn0tM6f21u6P6hZVINaN2d0RX9i5hRn
         Htbzp2/HwpohyJ+ItCTiY136eOs3nxcIz06ey+HdUiCbWXWcPPf6pbZnYrLe//VT5HtD
         KZp5SrD7l4ynSmPRU1zOmVTI2LSRLsNggIqONEmDy+Qn6P0bcF3J7gEVVRM7X4NzFrgr
         9kgRTuZCQFR2cHxp19QqkBUaVg2OJzzpj1+K1h2RRYSruc6Egw5x+X15cgSoj+0dJe7d
         gFz6n8fgJPxyxc3vwmemKB1QDm/A/dVOrAJpP2giPTFsSYiVQwB3v7wyWtMje3Og4cjJ
         SgNg==
X-Gm-Message-State: AOJu0Yw6NYrbIw8U0DnBie0UJ4WFk8fnivbIpBrPc9oc0cb8LkII/lq1
        znIkUBO24woiDSB9WC207AMPSzebMXpqtw==
X-Google-Smtp-Source: AGHT+IHu/UbVufVGeSc6nVKafye1e+y2o8NKilXETV2xYMGss2HLXdobOesYjmAst3vZtcE/xsEE5Q==
X-Received: by 2002:a19:4f06:0:b0:503:34b4:8149 with SMTP id d6-20020a194f06000000b0050334b48149mr2200571lfb.38.1695206717331;
        Wed, 20 Sep 2023 03:45:17 -0700 (PDT)
Received: from worklaptop.wework.com ([213.61.95.74])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906595500b00992f2befcbcsm9071905ejr.180.2023.09.20.03.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 03:45:16 -0700 (PDT)
From:   Karthik Nayak <karthik.188@gmail.com>
To:     karthik.188@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
Subject: [PATCH v4] revision: add `--ignore-missing-links` user option
Date:   Wed, 20 Sep 2023 12:45:07 +0200
Message-ID: <20230920104507.21664-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915083415.263187-1-knayak@gitlab.com>
References: <20230915083415.263187-1-knayak@gitlab.com>
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

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Changes from v3:
1. Remove hard-coded skipping of finish_object__ma(...). This means that
`--ignore-missing-links` needs to be used with `--missing=...` for missing
non-commit objects, but also now provides the flexibility to the user instead.
Fixes to the tests around this.
2. Fix an incorrect test.
3. Capitalize first character in test's comment.

Range diff from v4

1:  a08f3637a0 ! 1:  639a8cc385 revision: add `--ignore-missing-links` user option
    @@ Documentation/rev-list-options.txt: explicitly.
      --bisect::
      	Pretend as if the bad bisection ref `refs/bisect/bad`
     
    - ## builtin/rev-list.c ##
    -@@ builtin/rev-list.c: static int finish_object(struct object *obj, const char *name UNUSED,
    - {
    - 	struct rev_list_info *info = cb_data;
    - 	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
    --		finish_object__ma(obj);
    -+		if (!info->revs->ignore_missing_links)
    -+			finish_object__ma(obj);
    - 		return 1;
    - 	}
    - 	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
    -
      ## revision.c ##
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
      		revs->limited = 1;
    @@ t/t6022-rev-list-alternates.sh (new)
     +	test_commit_bulk --start=6 -C alt 5
     +'
     +
    -+# when the alternate odb is provided, all commits are listed along with the boundary
    ++# When the alternate odb is provided, all commits are listed along with the boundary
     +# commit.
     +test_expect_success 'rev-list passes with alternate object directory' '
     +	git -C alt rev-list --all --objects --no-object-names >actual.raw &&
    @@ t/t6022-rev-list-alternates.sh (new)
     +	hide_alternates &&
     +
     +	git -C alt rev-list --objects --no-object-names \
    -+		--ignore-missing-links HEAD >actual.raw &&
    ++		--ignore-missing-links --missing=allow-any HEAD >actual.raw &&
     +	git -C alt cat-file  --batch-check="%(objectname)" \
     +		--batch-all-objects >expect.raw &&
     +
     +	sort actual.raw >actual &&
     +	sort expect.raw >expect &&
    -+	test_must_fail git -C alt rev-list HEAD
    ++	test_cmp expect actual
     +'
     +
     +# With `--ignore-missing-links` and `--boundary`, we can even print those boundary
    @@ t/t6022-rev-list-alternates.sh (new)
     +		mv "$path" "$path.hidden" &&
     +		test_when_finished "mv $path.hidden $path" &&
     +
    -+		git -C alt rev-list --ignore-missing-links --objects HEAD \
    ++		git -C alt rev-list --ignore-missing-links --missing=allow-any --objects HEAD \
     +			>actual &&
     +		! grep $oid actual
     +       '

 Documentation/rev-list-options.txt |  9 +++
 revision.c                         |  2 +
 t/t6022-rev-list-alternates.sh     | 93 ++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
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
index 0000000000..9ba739c830
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
+# When the alternate odb is provided, all commits are listed along with the boundary
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
+		--ignore-missing-links --missing=allow-any HEAD >actual.raw &&
+	git -C alt cat-file  --batch-check="%(objectname)" \
+		--batch-all-objects >expect.raw &&
+
+	sort actual.raw >actual &&
+	sort expect.raw >expect &&
+	test_cmp expect actual
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
+		git -C alt rev-list --ignore-missing-links --missing=allow-any --objects HEAD \
+			>actual &&
+		! grep $oid actual
+       '
+done
+
+test_done
-- 
2.41.0

