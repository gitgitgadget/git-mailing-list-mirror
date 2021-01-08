Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1356C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3FC235FF
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbhAHOqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbhAHOqB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 09:46:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17FC061381
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 06:45:21 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x12so5750317plr.10
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 06:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1sU6W276rhbNArOKTD2i3KkeRnEtrqPZ0VjNPlLy7cU=;
        b=LnmwgYZNK4sel+MfiLFBfLOdJkpYOkYJuupnpNqlmLSn7MjmKJzBeSj32Cllgp6TIU
         +JvsUNlAZBfUjn5nhUE+/j0V8maSNWgFFhdZSY8Xre3Esdeh4Nnuypn5f6dOBpk6FP/D
         hazmm7ElZPExy8yKBDOMbNkKEL41wLAK22Wtu1CL5sG0u7cP0rzbplDYfAFJRVct5gCL
         /Idb3OUXQzijRoBIrd8tv+DgjePyrR8oki9JxKRfrgRNqIGfR7mnYeReJ01G8PLEGtuk
         +LBfbskg0d2OvPPTLSt3aOJcaADzVuDTAljbVEfqFRD9XE98E3l6Z3EGXsBTD33kbygK
         9pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1sU6W276rhbNArOKTD2i3KkeRnEtrqPZ0VjNPlLy7cU=;
        b=q148A5fBeEG3NHu5HShPMpvkRA0dEN5XtAuw1fmSaxYhXtay7sPumt08mbgzRIl/Wr
         q5YDe9dLRDWFuyR3ApmudBfw/XtudrqebRlTkVkGKSUS3CUokdZrBw/1BIf9NngzNyEA
         yod97UGPtKiMJLyun2K+XKZV1r1eJq5LUrpzga16onXHM+EA3ZdNZBZLI+SNHJ7XlJqB
         OPyz+9elHjDTZgQIFc9KLRDgr7nFhjCkEMA6XQpdz5+qgrtrNH+u49Roj+sxPsWl28t1
         lb/ISc4AyKFaWIM1KzdYKc6vVL9FGXSDfAuVeELPS1fLnKSR7w65QyiGN0Hpe6FaBjMV
         RyBw==
X-Gm-Message-State: AOAM530S3mlBGiPQ3UWm83QZ5FceVk+g5WsvZl6kehF8g8bENyP9v3Cj
        jAFRtNiR7hE97rPYtx9dnGI=
X-Google-Smtp-Source: ABdhPJyEch0DbD+brqVIpeoTvYcjDRS2A1D80DEq/EGf2rivk3HawW//Mu+ykFBDd58HUm/cuEb0ng==
X-Received: by 2002:a17:902:a60c:b029:da:e036:5dbe with SMTP id u12-20020a170902a60cb02900dae0365dbemr4056037plq.43.1610117121143;
        Fri, 08 Jan 2021 06:45:21 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q15sm9471894pgk.11.2021.01.08.06.45.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 06:45:20 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 1/2] bundle: lost objects when removing duplicate pendings
Date:   Fri,  8 Jan 2021 09:45:13 -0500
Message-Id: <20210108144514.24805-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <X/cqrTgilKAW9P9G@danh.dev>
References: <X/cqrTgilKAW9P9G@danh.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

`git rev-list` will list one commit for the following command:

    $ git rev-list 'main^!'
    <tip-commit-of-main-branch>

But providing the same rev-list args to `git bundle`, fail to create
a bundle file.

    $ git bundle create - 'main^!'
    # v2 git bundle
    -<OID> <one-line-message>

    fatal: Refusing to create empty bundle.

This is because when removing duplicate objects in function
`object_array_remove_duplicates()`, one unique pending object which has
the same name is deleted by mistake.  The revision arg 'main^!' in the
above example is parsed by `handle_revision_arg()`, and at lease two
different objects will be appended to `revs.pending`, one points to the
parent commit of the "main" branch, and the other points to the tip
commit of the "main" branch.  These two objects have the same name
"main".  Only one object is left with the name "main" after calling the
function `object_array_remove_duplicates()`.

And what's worse, when adding boundary commits into pending list, we use
one-line commit message as names, and the arbitory names may surprise
git-bundle.

Only comparing objects themselves (".item") is also not good enough,
because user may want to create a bundle with two identical objects but
with different reference names, such as: "HEAD" and "refs/heads/main".

Add new function `contains_object()` which compare both the address and
the name of the object.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 object.c               |  10 +-
 t/t6020-bundle-misc.sh | 477 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 483 insertions(+), 4 deletions(-)
 create mode 100755 t/t6020-bundle-misc.sh

diff --git a/object.c b/object.c
index 68f80b0b3d..98017bed8e 100644
--- a/object.c
+++ b/object.c
@@ -412,15 +412,16 @@ void object_array_clear(struct object_array *array)
 }
 
 /*
- * Return true iff array already contains an entry with name.
+ * Return true if array already contains an entry.
  */
-static int contains_name(struct object_array *array, const char *name)
+static int contains_object(struct object_array *array,
+			   const struct object *item, const char *name)
 {
 	unsigned nr = array->nr, i;
 	struct object_array_entry *object = array->objects;
 
 	for (i = 0; i < nr; i++, object++)
-		if (!strcmp(object->name, name))
+		if (item == object->item && !strcmp(object->name, name))
 			return 1;
 	return 0;
 }
@@ -432,7 +433,8 @@ void object_array_remove_duplicates(struct object_array *array)
 
 	array->nr = 0;
 	for (src = 0; src < nr; src++) {
-		if (!contains_name(array, objects[src].name)) {
+		if (!contains_object(array, objects[src].item,
+				     objects[src].name)) {
 			if (src != array->nr)
 				objects[array->nr] = objects[src];
 			array->nr++;
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
new file mode 100755
index 0000000000..c4447ca88f
--- /dev/null
+++ b/t/t6020-bundle-misc.sh
@@ -0,0 +1,477 @@
+#!/bin/sh
+#
+# Copyright (c) 2021 Jiang Xin
+#
+
+test_description='Test git-bundle'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Check count of objects in a bundle file.
+# We can use "--thin" opiton to check thin pack, which must be fixed by
+# command `git-index-pack --fix-thin --stdin`.
+test_bundle_object_count () {
+	thin= &&
+	if test "$1" = "--thin"
+	then
+		thin=yes
+		shift
+	fi &&
+	if test $# -ne 2
+	then
+		echo >&2 "args should be: <bundle> <count>"
+		return 1
+	fi
+	bundle=$1 &&
+	pack=${bundle%.bdl}.pack &&
+	convert_bundle_to_pack <"$bundle" >"$pack" &&
+	if test -n "$thin"
+	then
+		test_must_fail git index-pack "$pack" &&
+		mv "$pack" "$pack"-thin &&
+		cat "$pack"-thin |
+			git index-pack --stdin --fix-thin "$pack"
+	else
+		git index-pack "$pack"
+	fi &&
+	git verify-pack -v "$pack" >verify.out
+	if test $? -ne 0
+	then
+		echo >&2 "error: fail to convert $bundle to $pack"
+		return 1
+	fi
+	count=$(grep -c "^$OID_REGEX " verify.out) &&
+	test $2 = $count && return 0
+	echo >&2 "error: object count for $bundle is $count, not $2"
+	return 1
+}
+
+# Display the pack data contained in the bundle file, bypassing the
+# header that contains the signature, prerequisites and references.
+convert_bundle_to_pack () {
+	while read x && test -n "$x"
+	do
+		:;
+	done
+	cat
+}
+
+# Create a commit or tag and set the variable with the object ID.
+test_commit_setvar () {
+	notick= &&
+	signoff= &&
+	indir= &&
+	merge= &&
+	tag= &&
+	var= &&
+	while test $# != 0
+	do
+		case "$1" in
+		--merge)
+			merge=yes
+			;;
+		--tag)
+			tag=yes
+			;;
+		--notick)
+			notick=yes
+			;;
+		--signoff)
+			signoff="$1"
+			;;
+		-C)
+			indir="$2"
+			shift
+			;;
+		-*)
+			echo >&2 "error: unknown option $1"
+			return 1
+			;;
+		*)
+			test -n "$var" && break
+			var=$1
+			;;
+		esac
+		shift
+	done &&
+	indir=${indir:+"$indir"/} &&
+	if test $# -eq 0
+	then
+		echo >&2 "no args provided"
+		return 1
+	fi &&
+	if test -z "$notick"
+	then
+		test_tick
+	fi &&
+	if test -n "$merge"
+	then
+		git ${indir:+ -C "$indir"} merge --no-edit --no-ff \
+			${2:+-m "$2"} "$1" &&
+		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
+	elif test -n "$tag"
+	then
+		git ${indir:+ -C "$indir"} tag -m "$1" "$1" &&
+		oid=$(git ${indir:+ -C "$indir"} rev-parse "$1")
+	else
+		file=${2:-"$1.t"} &&
+		echo "${3-$1}" > "$indir$file" &&
+		git ${indir:+ -C "$indir"} add "$file" &&
+		git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
+		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
+	fi &&
+	eval $var=$oid
+}
+
+
+# Format the output of git commands to make a user-friendly and stable
+# text.  We can easily prepare the expect text without having to worry
+# about future changes of the commit ID and spaces of the output.
+make_user_friendly_and_stable_output () {
+	sed \
+		-e "s/$A/<COMMIT-A>/" \
+		-e "s/$B/<COMMIT-B>/" \
+		-e "s/$C/<COMMIT-C>/" \
+		-e "s/$D/<COMMIT-D>/" \
+		-e "s/$E/<COMMIT-E>/" \
+		-e "s/$F/<COMMIT-F>/" \
+		-e "s/$G/<COMMIT-G>/" \
+		-e "s/$H/<COMMIT-H>/" \
+		-e "s/$I/<COMMIT-I>/" \
+		-e "s/$J/<COMMIT-J>/" \
+		-e "s/$K/<COMMIT-K>/" \
+		-e "s/$L/<COMMIT-L>/" \
+		-e "s/$M/<COMMIT-M>/" \
+		-e "s/$N/<COMMIT-N>/" \
+		-e "s/$O/<COMMIT-O>/" \
+		-e "s/$P/<COMMIT-P>/" \
+		-e "s/$TAG1/<TAG-1>/" \
+		-e "s/$TAG2/<TAG-2>/" \
+		-e "s/$TAG3/<TAG-3>/" \
+		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
+		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
+		-e "s/$(echo $C | cut -c1-7)[0-9a-f]*/<OID-C>/g" \
+		-e "s/$(echo $D | cut -c1-7)[0-9a-f]*/<OID-D>/g" \
+		-e "s/$(echo $E | cut -c1-7)[0-9a-f]*/<OID-E>/g" \
+		-e "s/$(echo $F | cut -c1-7)[0-9a-f]*/<OID-F>/g" \
+		-e "s/$(echo $G | cut -c1-7)[0-9a-f]*/<OID-G>/g" \
+		-e "s/$(echo $H | cut -c1-7)[0-9a-f]*/<OID-H>/g" \
+		-e "s/$(echo $I | cut -c1-7)[0-9a-f]*/<OID-I>/g" \
+		-e "s/$(echo $J | cut -c1-7)[0-9a-f]*/<OID-J>/g" \
+		-e "s/$(echo $K | cut -c1-7)[0-9a-f]*/<OID-K>/g" \
+		-e "s/$(echo $L | cut -c1-7)[0-9a-f]*/<OID-L>/g" \
+		-e "s/$(echo $M | cut -c1-7)[0-9a-f]*/<OID-M>/g" \
+		-e "s/$(echo $N | cut -c1-7)[0-9a-f]*/<OID-N>/g" \
+		-e "s/$(echo $O | cut -c1-7)[0-9a-f]*/<OID-O>/g" \
+		-e "s/$(echo $P | cut -c1-7)[0-9a-f]*/<OID-P>/g" \
+		-e "s/$(echo $TAG1 | cut -c1-7)[0-9a-f]*/<OID-TAG-1>/g" \
+		-e "s/$(echo $TAG2 | cut -c1-7)[0-9a-f]*/<OID-TAG-2>/g" \
+		-e "s/$(echo $TAG3 | cut -c1-7)[0-9a-f]*/<OID-TAG-3>/g" \
+		-e "s/ *\$//"
+}
+
+#            (C)   (D, pull/1/head, topic/1)
+#             o --- o
+#            /       \                              (L)
+#           /         \        o (H, topic/2)             (M, tag:v2)
+#          /    (F)    \      /                                 (N, tag:v3)
+#         /      o --------- o (G, pull/2/head)      o --- o --- o (release)
+#        /      /        \    \                      /       \
+#  o --- o --- o -------- o -- o ------------------ o ------- o --- o (main)
+# (A)   (B)  (E, tag:v1) (I)  (J)                  (K)       (O)   (P)
+#
+test_expect_success 'setup' '
+	# Try to make a stable fixed width for abbreviated commit ID,
+	# this fixed-width oid will be replaced with "<OID>".
+	git config core.abbrev 7 &&
+
+	# branch main: commit A & B
+	test_commit_setvar A "Commit A" main.txt &&
+	test_commit_setvar B "Commit B" main.txt &&
+
+	# branch topic/1: commit C & D, refs/pull/1/head
+	git checkout -b topic/1 &&
+	test_commit_setvar C "Commit C" topic-1.txt &&
+	test_commit_setvar D "Commit D" topic-1.txt &&
+	git update-ref refs/pull/1/head HEAD &&
+
+	# branch topic/1: commit E, tag v1
+	git checkout main &&
+	test_commit_setvar E "Commit E" main.txt &&
+	test_commit_setvar TAG1 --tag v1 &&
+
+	# branch topic/2: commit F & G, refs/pull/2/head
+	git checkout -b topic/2 &&
+	test_commit_setvar F "Commit F" topic-2.txt &&
+	test_commit_setvar G "Commit G" topic-2.txt &&
+	git update-ref refs/pull/2/head HEAD &&
+	test_commit_setvar H "Commit H" topic-2.txt &&
+
+	# branch main: merge commit I & J
+	git checkout main &&
+	test_commit_setvar I --merge topic/1 "Merge commit I" &&
+	test_commit_setvar J --merge refs/pull/2/head "Merge commit J" &&
+
+	# branch main: commit K
+	git checkout main &&
+	test_commit_setvar K "Commit K" main.txt &&
+
+	# branch release:
+	git checkout -b release &&
+	test_commit_setvar L "Commit L" release.txt &&
+	test_commit_setvar M "Commit M" release.txt &&
+	test_commit_setvar TAG2 --tag v2 &&
+	test_commit_setvar N "Commit N" release.txt &&
+	test_commit_setvar TAG3 --tag v3 &&
+
+	# branch main: merge commit O, commit P
+	git checkout main &&
+	test_commit_setvar O --merge tags/v2 "Merge commit O" &&
+	test_commit_setvar P "Commit P" main.txt
+'
+
+test_expect_success 'create bundle from special rev: main^!' '
+	git bundle create special-rev.bdl "main^!" &&
+
+	git bundle list-heads special-rev.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		<COMMIT-P> refs/heads/main
+		EOF
+	test_i18ncmp expect actual &&
+
+	git bundle verify special-rev.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		The bundle contains this ref:
+		<COMMIT-P> refs/heads/main
+		The bundle requires this ref:
+		<COMMIT-O>
+		EOF
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count special-rev.bdl 3
+'
+
+test_expect_success 'create bundle with --max-count option' '
+	git bundle create max-count.bdl --max-count 1 \
+		main \
+		"^release" \
+		refs/tags/v1 \
+		refs/pull/1/head \
+		refs/pull/2/head &&
+
+	git bundle list-heads max-count.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		<COMMIT-P> refs/heads/main
+		<TAG-1> refs/tags/v1
+		EOF
+	test_i18ncmp expect actual &&
+
+	git bundle verify max-count.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		The bundle contains these 2 refs:
+		<COMMIT-P> refs/heads/main
+		<TAG-1> refs/tags/v1
+		The bundle requires this ref:
+		<COMMIT-O>
+		EOF
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count max-count.bdl 4
+'
+
+test_expect_success 'create bundle with --since option' '
+	since="Thu Apr 7 15:26:13 2005 -0700" &&
+	git log -1 --pretty="%ad" $M >actual &&
+	echo "$since" >expect &&
+	test_cmp expect actual &&
+
+	git bundle create since.bdl \
+		--since "$since" --all &&
+
+	git bundle list-heads since.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		<COMMIT-P> refs/heads/main
+		<COMMIT-N> refs/heads/release
+		<TAG-2> refs/tags/v2
+		<TAG-3> refs/tags/v3
+		<COMMIT-P> HEAD
+		EOF
+	test_i18ncmp expect actual &&
+
+	git bundle verify since.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		The bundle contains these 5 refs:
+		<COMMIT-P> refs/heads/main
+		<COMMIT-N> refs/heads/release
+		<TAG-2> refs/tags/v2
+		<TAG-3> refs/tags/v3
+		<COMMIT-P> HEAD
+		The bundle requires these 2 refs:
+		<COMMIT-L>
+		<COMMIT-K>
+		EOF
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count --thin since.bdl 16
+'
+
+test_expect_success 'create bundle 1 - no prerequisites' '
+	git bundle create 1.bdl topic/1 topic/2 &&
+
+	cat >expect <<-EOF &&
+		The bundle contains these 2 refs:
+		<COMMIT-D> refs/heads/topic/1
+		<COMMIT-H> refs/heads/topic/2
+		The bundle records a complete history.
+		EOF
+
+	# verify bundle, which has no prerequisites
+	git bundle verify 1.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count 1.bdl 24
+'
+
+test_expect_success 'create bundle 2 - has prerequisites' '
+	git bundle create 2.bdl \
+		--ignore-missing \
+		^topic/deleted \
+		^$D \
+		^topic/2 \
+		release &&
+
+	cat >expect <<-EOF &&
+		The bundle contains this ref:
+		<COMMIT-N> refs/heads/release
+		The bundle requires these 3 refs:
+		<COMMIT-D>
+		<COMMIT-E>
+		<COMMIT-G>
+		EOF
+
+	git bundle verify 2.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count 2.bdl 16
+'
+
+test_expect_success 'fail to verify bundle without prerequisites' '
+	git init --bare test1.git &&
+
+	cat >expect <<-EOF &&
+		error: Repository lacks these prerequisite commits:
+		error: <COMMIT-D>
+		error: <COMMIT-E>
+		error: <COMMIT-G>
+		EOF
+
+	test_must_fail git -C test1.git bundle verify ../2.bdl 2>&1 |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'create bundle 3 - two refs, same object' '
+	git bundle create --version=3 3.bdl \
+		^release \
+		^topic/1 \
+		^topic/2 \
+		main \
+		HEAD &&
+
+	cat >expect <<-EOF &&
+		The bundle contains these 2 refs:
+		<COMMIT-P> refs/heads/main
+		<COMMIT-P> HEAD
+		The bundle requires these 2 refs:
+		<COMMIT-M>
+		<COMMIT-K>
+		EOF
+
+	git bundle verify 3.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count 3.bdl 4
+'
+
+test_expect_success 'create bundle 4 - with tags' '
+	git bundle create 4.bdl \
+		^main \
+		^release \
+		^topic/1 \
+		^topic/2 \
+		--all &&
+
+	cat >expect <<-EOF &&
+		The bundle contains these 3 refs:
+		<TAG-1> refs/tags/v1
+		<TAG-2> refs/tags/v2
+		<TAG-3> refs/tags/v3
+		The bundle records a complete history.
+		EOF
+
+	git bundle verify 4.bdl |
+		make_user_friendly_and_stable_output >actual &&
+	test_i18ncmp expect actual &&
+
+	test_bundle_object_count 4.bdl 3
+'
+
+test_expect_success 'clone from bundle' '
+	git clone --mirror 1.bdl mirror.git &&
+	git -C mirror.git show-ref |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		<COMMIT-D> refs/heads/topic/1
+		<COMMIT-H> refs/heads/topic/2
+		EOF
+	test_cmp expect actual &&
+
+	git -C mirror.git fetch ../2.bdl "+refs/*:refs/*" &&
+	git -C mirror.git show-ref |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		<COMMIT-N> refs/heads/release
+		<COMMIT-D> refs/heads/topic/1
+		<COMMIT-H> refs/heads/topic/2
+		EOF
+	test_cmp expect actual &&
+
+	git -C mirror.git fetch ../3.bdl "+refs/*:refs/*" &&
+	git -C mirror.git show-ref |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		<COMMIT-P> refs/heads/main
+		<COMMIT-N> refs/heads/release
+		<COMMIT-D> refs/heads/topic/1
+		<COMMIT-H> refs/heads/topic/2
+		EOF
+	test_cmp expect actual &&
+
+	git -C mirror.git fetch ../4.bdl "+refs/*:refs/*" &&
+	git -C mirror.git show-ref |
+		make_user_friendly_and_stable_output >actual &&
+	cat >expect <<-EOF &&
+		<COMMIT-P> refs/heads/main
+		<COMMIT-N> refs/heads/release
+		<COMMIT-D> refs/heads/topic/1
+		<COMMIT-H> refs/heads/topic/2
+		<TAG-1> refs/tags/v1
+		<TAG-2> refs/tags/v2
+		<TAG-3> refs/tags/v3
+		EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
2.30.0.2.g06d2f50715

