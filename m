Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B07C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8B222CA2
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbhAEQbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbhAEQbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 11:31:39 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11494C061793
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 08:30:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t8so40342pfg.8
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 08:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BW5YW7jWgnpBzfiHeoJ9ugXv46fnhIiFmPBc1rv3fM0=;
        b=OmUQn90n2fm/zqx6MBbcUwcjbOSfmz9kh0UBxHgZqHyYljlbShdCLtC05SwNnUZQNC
         JACnGwmqsxByH9Vmy5375XVg6WSNQ19yuQ1Sf5fe8Pl6D8KJWiXEziTuJWTiDkV0IZj8
         e2xkRvx7XZh3OTROiuwIwerh3i5NqATdyF/bCq8LOw52rdAyx/36gUiimVGqZw4Qr3tF
         AkYU6rEy+0rKQJPm6mUwAa6fsYAEVnBsr27tjeVVfwezqbR8xXuiwLGHZhFYQJlShwdm
         2g/8br1WFudTwu8apE6Kc0sa/rT63Th/DqEb/obBVtcxbYHrehkT9sfCrpODLPkGESv4
         50RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BW5YW7jWgnpBzfiHeoJ9ugXv46fnhIiFmPBc1rv3fM0=;
        b=KVJ0yDr4bZUyKLvIKjaIBf+xVOP1FmY+CD7Ff/vIlav5JiY++S/HxFyHq+A2PxHM8z
         nxxtonwc391g17dOY06hgHcQkj5M8k52CopZAseniIT75648PCaAPPANpCq7bQqpLF6+
         8e/ic2XL1G689wq/z1h+LD1/n3ahpuw9t09X2+LsA+5bqHuEV0mol3G0C6Bsap7nXGmf
         hFmhhIo+WYu8e+KwH4M76c8uj6vZF1S0Me1ZqMLXlkIN41b0JgPsxpjB9pcvJdjbaeoT
         Q1VUH++lQ09ipbYUD+HJ3Y7NnZiWc78xBtmb5+MIrmaL9hyD2xgAjUclvt21lcTFlKEW
         QXAg==
X-Gm-Message-State: AOAM531Bg+eCPFHzyV4VnGzsZSBzcWjt8OoT8s/yvHmEm93g5TSfMR1q
        FFGGGUeKKIiVU5nIavRaLOw=
X-Google-Smtp-Source: ABdhPJxtu0pMFc56nZOF/2boNa68JLSa3QjkuQ1Mr72hfo1VJPahcvJmxN+N15DggHvQUWtcywBE6g==
X-Received: by 2002:a62:fc86:0:b029:19d:9943:c843 with SMTP id e128-20020a62fc860000b029019d9943c843mr266531pfh.71.1609864258528;
        Tue, 05 Jan 2021 08:30:58 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y15sm70303pju.13.2021.01.05.08.30.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 08:30:57 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 1/2] bundle: lost objects when removing duplicate pendings
Date:   Tue,  5 Jan 2021 11:30:53 -0500
Message-Id: <20210105163054.25358-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <xmqqft3g6ziz.fsf@gitster.c.googlers.com>
References: <xmqqft3g6ziz.fsf@gitster.c.googlers.com>
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
 t/t6020-bundle-misc.sh | 413 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 419 insertions(+), 4 deletions(-)
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
index 0000000000..c6613a4162
--- /dev/null
+++ b/t/t6020-bundle-misc.sh
@@ -0,0 +1,413 @@
+test_description='Test git-bundle'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_bundle_object_count () {
+	git verify-pack -v "$1" >verify.out &&
+	count=$(grep "^$OID_REGEX " verify.out | wc -l) &&
+	test $2 = $count && return 0
+	echo object count is $count, not $2
+	return 1
+}
+
+convert_bundle_to_pack () {
+	while read x && test -n "$x"
+	do
+		:;
+	done
+	cat
+}
+
+# Format the output of git commands to make a user-friendly and stable
+# text.  We can easily prepare the expect text without having to worry
+# about future changes of the commit ID and spaces of the output.
+make_user_friendly_and_stable_output () {
+	sed \
+		-e "s/ *\$//" \
+		-e "s/$A/<COMMIT-A>/g" \
+		-e "s/$B/<COMMIT-B>/g" \
+		-e "s/$C/<COMMIT-C>/g" \
+		-e "s/$D/<COMMIT-D>/g" \
+		-e "s/$E/<COMMIT-E>/g" \
+		-e "s/$F/<COMMIT-F>/g" \
+		-e "s/$G/<COMMIT-G>/g" \
+		-e "s/$H/<COMMIT-H>/g" \
+		-e "s/$I/<COMMIT-I>/g" \
+		-e "s/$J/<COMMIT-J>/g" \
+		-e "s/$K/<COMMIT-K>/g" \
+		-e "s/$L/<COMMIT-L>/g" \
+		-e "s/$M/<COMMIT-M>/g" \
+		-e "s/$N/<COMMIT-N>/g" \
+		-e "s/$O/<COMMIT-O>/g" \
+		-e "s/$P/<COMMIT-P>/g" \
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
+		-e "s/$TAG1/<TAG-1>/g" \
+		-e "s/$TAG2/<TAG-2>/g" \
+		-e "s/$TAG3/<TAG-3>/g" \
+		-e "s/$(echo $TAG1 | cut -c1-7)[0-9a-f]*/<OID-TAG-1>/g" \
+		-e "s/$(echo $TAG2 | cut -c1-7)[0-9a-f]*/<OID-TAG-2>/g" \
+		-e "s/$(echo $TAG3 | cut -c1-7)[0-9a-f]*/<OID-TAG-3>/g" \
+		-e "s/$ZERO_OID/<ZERO-OID>/g"
+}
+
+#            (C)   (D, pull/1/head, topic/1)
+#             o --- o
+#            /       \                              (L, tags/v1)
+#           /         \        o (H, topic/2)             (M, tags/v2)
+#          /    (F)    \      /                                 (N, tags/v3)
+#         /      o --------- o (G, pull/2/head)      o --- o --- o (release)
+#        /      /        \    \                      /       \
+#  o --- o --- o -------- o -- o ------------------ o ------- o --- o (main)
+# (A)   (B)   (E)        (I)  (J)                  (K)       (O)   (P)
+#
+test_expect_success 'setup' '
+	# commit A & B
+	cat >main.txt <<-EOF &&
+		Commit A
+		EOF
+	git add main.txt &&
+	test_tick &&
+	git commit -m "Commit A" &&
+
+	cat >main.txt <<-EOF &&
+		Commit B
+		EOF
+	git add main.txt &&
+	test_tick &&
+	git commit -m "Commit B" &&
+	A=$(git rev-parse HEAD~) &&
+	B=$(git rev-parse HEAD) &&
+
+	# branch topic/1
+	git checkout -b topic/1 &&
+	cat >topic-1.txt <<-EOF &&
+		Commit C
+		EOF
+	git add topic-1.txt &&
+	test_tick &&
+	git commit -m "Commit C" &&
+
+	cat >topic-1.txt <<-EOF &&
+		Commit D
+		EOF
+	git add -u &&
+	test_tick &&
+	git commit -m "Commit D" &&
+	git update-ref refs/pull/1/head HEAD &&
+	C=$(git rev-parse topic/1~) &&
+	D=$(git rev-parse topic/1) &&
+
+	# commit E
+	git checkout main &&
+	cat >main.txt <<-EOF &&
+		Commit E
+		EOF
+	git add main.txt &&
+	test_tick &&
+	git commit -m "Commit E" &&
+	E=$(git rev-parse HEAD) &&
+
+	# branch topic/2
+	git checkout -b topic/2 &&
+	cat >topic-2.txt <<-EOF &&
+		Commit F
+		EOF
+	git add topic-2.txt &&
+	test_tick &&
+	git commit -m "Commit F" &&
+
+	cat >topic-2.txt <<-EOF &&
+		Commit G
+		EOF
+	git add -u &&
+	test_tick &&
+	git commit -m "Commit G" &&
+	git update-ref refs/pull/2/head HEAD &&
+
+	cat >topic-2.txt <<-EOF &&
+		Commit H
+		EOF
+	git add -u &&
+	test_tick &&
+	git commit -m "Commit H" &&
+	F=$(git rev-parse topic/2~2) &&
+	G=$(git rev-parse topic/2~) &&
+	H=$(git rev-parse topic/2) &&
+
+	# merge commit I & J
+	git checkout main &&
+	test_tick &&
+	git merge --no-ff --no-edit topic/1 &&
+	test_tick &&
+	git merge --no-ff --no-edit refs/pull/2/head &&
+	I=$(git rev-parse HEAD~) &&
+	J=$(git rev-parse HEAD) &&
+
+	# commit K
+	git checkout main &&
+	cat >main.txt <<-EOF &&
+		Commit K
+		EOF
+	git add main.txt &&
+	test_tick &&
+	git commit -m "Commit K" &&
+	K=$(git rev-parse HEAD) &&
+
+	# branch release
+	git checkout -b release &&
+	cat >release.txt <<-EOF &&
+		Commit L
+		EOF
+	git add release.txt &&
+	test_tick &&
+	git commit -m "Commit L" &&
+	test_tick &&
+	git tag -m "v1" v1 HEAD &&
+
+	cat >release.txt <<-EOF &&
+		Commit M
+		EOF
+	git add -u &&
+	test_tick &&
+	git commit -m "Commit M" &&
+	test_tick &&
+	git tag -m "v2" v2 HEAD &&
+
+	cat >release.txt <<-EOF &&
+		Commit N
+		EOF
+	git add -u &&
+	test_tick &&
+	git commit -m "Commit N" &&
+	test_tick &&
+	git tag -m "v3" v3 HEAD &&
+	L=$(git rev-parse HEAD~2) &&
+	M=$(git rev-parse HEAD~) &&
+	N=$(git rev-parse HEAD) &&
+	TAG1=$(git rev-parse refs/tags/v1) &&
+	TAG2=$(git rev-parse refs/tags/v2) &&
+	TAG3=$(git rev-parse refs/tags/v3) &&
+
+	# merge commit O
+	git checkout main &&
+	test_tick &&
+	git merge --no-ff --no-edit tags/v2 &&
+	O=$(git rev-parse HEAD) &&
+
+	# commit P
+	git checkout main &&
+	cat >main.txt <<-EOF &&
+		Commit P
+		EOF
+	git add main.txt &&
+	test_tick &&
+	git commit -m "Commit P" &&
+	P=$(git rev-parse HEAD)
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
+	convert_bundle_to_pack <special-rev.bdl >special-rev.pack &&
+	git index-pack special-rev.pack &&
+	test_bundle_object_count special-rev.pack 3
+'
+
+test_expect_success 'create bundle 1 - no prerequisites' '
+	# create bundle from args
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
+	convert_bundle_to_pack <1.bdl >1.pack &&
+	git index-pack 1.pack &&
+	test_bundle_object_count 1.pack 24
+'
+
+test_expect_success 'create bundle 2 - has prerequisites' '
+	# create bundle from args
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
+	convert_bundle_to_pack <2.bdl >2.pack &&
+	git index-pack 2.pack &&
+	test_bundle_object_count 2.pack 16
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
+	# create bundle from args
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
+	convert_bundle_to_pack <3.bdl >3.pack &&
+	git index-pack 3.pack &&
+	test_bundle_object_count 3.pack 4
+'
+
+test_expect_success 'create bundle 4 - with tags' '
+	# create bundle from args
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
+	convert_bundle_to_pack <4.bdl >4.pack &&
+	git index-pack 4.pack &&
+	test_bundle_object_count 4.pack 3
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
2.30.0.4.g09ee524cd5

