Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ED9C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 14:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiGEOCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiGEOBt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 10:01:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22D21802
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 06:47:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o4so17662224wrh.3
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p2ryWnMdzUe+Bv/drddU3wGOo0/cVK/Ocbr0NEuq19M=;
        b=R81BGwHhioPhZ1s/WulUyrsDXTEPr/D0dePL64NnW8qEMBrbH62FFMmgOgMGhlx1Ua
         g7twLqeBh+C+MYl4w7sFlfcqUdQ8HX1+5PAaKIWviyzhWDLIIunsCdaWgBn1B/iHn4lU
         VUJFhWYg/cN6+z9PjM6ZZ+lCOq0+ajF6o+7AY/yOvfCP2lU0TkK+q4mNOtFKJaz6GZSu
         UoYhzV3Y/F3dv31j2Vbtv7QinjFYSfdSye141DYynsiBROxusxTmmoQh6Rzl8ANyd7A2
         ka1N+U7zdvF78ikSTewJgFQI48qTAlXmQajc+8IHwNq0hJVhgVGrflPMUNvZt2OWB+7Y
         Z4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2ryWnMdzUe+Bv/drddU3wGOo0/cVK/Ocbr0NEuq19M=;
        b=VRqcwLpDIccvtkJrVy1ABkILrQ2JMOKOk0S/bK54JqYbvlDj90nzBzOQgg4d70C7Tx
         koYgO6/4tzw+Rhaq9/jLBju3JR2wb/VBuncOem6KdEnCDQP2g9vp4wwm6EfnY7O63chS
         4jEgr0xk+Xudea+cVcWYsinvol4j/vbl/TSdtZylqye1w9lMj64+QgRlE5tykwylSQlW
         vJnCWqc5f0eGem1PL6foczaGRSE+QGVvyBXMlL1//flSyu7ERQy/dTTcxP4WCUbv3Zuo
         XyfBXJyO8z+lq1CA8dVqnZAaCPZRpDEtmaosxavwAIkh0FNPgcn37gpurxhRzd24Ggkv
         dRLQ==
X-Gm-Message-State: AJIora9Uk1GKXpmoM0PaqXI/n4qzM5zq9r5iSimNALYbbt2vjKeqJ6nu
        cTUuqv2/pX0OpTRzYXO0t3/sy0n7F3Q=
X-Google-Smtp-Source: AGRyM1tL04277QXnyAEaLoI9YUZr1VkZoZsdNrktlCQfy2QJSDRuIzbP70v5tHOOScSHtjI//hWzTA==
X-Received: by 2002:a05:6000:1d86:b0:21d:6433:1455 with SMTP id bk6-20020a0560001d8600b0021d64331455mr14477161wrb.514.1657028827662;
        Tue, 05 Jul 2022 06:47:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b0021b92171d28sm40786942wro.54.2022.07.05.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:47:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/6] add and apply a rule to find "unused" init+free
Date:   Tue,  5 Jul 2022 15:46:54 +0200
Message-Id: <cover-v4-0.6-00000000000-20220705T134033Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g50625c3f077
In-Reply-To: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
References: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a coccinelle rule to find and remove code where the
only reference to a variable in a given function is to malloc() &
free() it, where "malloc" and "free" also match
"strbuf_init/strbuf_release", and then later in the series anything
that looks like a init/free pattern.

Changes since v3[1]

 * Add a "coccicheck-test" target in an early and new patch, the
   structure mirrors that of coccinelle.git's own tests. As the
   diffstat shows we have a *.c and *.res file which is C code
   before/after a *.cocci rule is applied.
 * The extensive commentary in the proposed rule is gone in favor of
   self-explanatory test cases
 * We now catch init/reset patterns as well as init/release fully
   (i.e. for the "struct strbuf" early on)
 * Squashed the "when strict" change in, and there's now a test-case
   for it.
 * 1-2/6 are new minor cleanup patches for what follows.

1. https://lore.kernel.org/git/cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (6):
  Makefile: remove mandatory "spatch" arguments from SPATCH_FLAGS
  Makefile & .gitignore: ignore & clean "git.res", not "*.res"
  cocci: add a "coccicheck-test" target and test *.cocci rules
  cocci: have "coccicheck{,-pending}" depend on "coccicheck-test"
  cocci: add and apply a rule to find "unused" strbufs
  cocci: generalize "unused" rule to cover more than "strbuf"

 .gitignore                          |  2 +-
 Makefile                            | 28 ++++++++--
 builtin/fetch.c                     |  3 +-
 builtin/merge.c                     |  4 --
 builtin/repack.c                    |  2 -
 contrib/coccinelle/tests/free.c     | 11 ++++
 contrib/coccinelle/tests/free.res   |  9 ++++
 contrib/coccinelle/tests/unused.c   | 82 +++++++++++++++++++++++++++++
 contrib/coccinelle/tests/unused.res | 45 ++++++++++++++++
 contrib/coccinelle/unused.cocci     | 43 +++++++++++++++
 contrib/scalar/scalar.c             |  3 +-
 diff.c                              |  2 -
 shared.mak                          |  1 +
 13 files changed, 219 insertions(+), 16 deletions(-)
 create mode 100644 contrib/coccinelle/tests/free.c
 create mode 100644 contrib/coccinelle/tests/free.res
 create mode 100644 contrib/coccinelle/tests/unused.c
 create mode 100644 contrib/coccinelle/tests/unused.res
 create mode 100644 contrib/coccinelle/unused.cocci

Range-diff against v3:
-:  ----------- > 1:  fbdc2c3d66b Makefile: remove mandatory "spatch" arguments from SPATCH_FLAGS
-:  ----------- > 2:  d7e85d4c4a6 Makefile & .gitignore: ignore & clean "git.res", not "*.res"
-:  ----------- > 3:  540186e69dc cocci: add a "coccicheck-test" target and test *.cocci rules
-:  ----------- > 4:  48810f7390c cocci: have "coccicheck{,-pending}" depend on "coccicheck-test"
1:  49e9ccb5819 ! 5:  d1c6833c8d5 cocci: add and apply a rule to find "unused" strbufs
    @@ Commit message
         cocci: add and apply a rule to find "unused" strbufs
     
         Add a coccinelle rule to remove "struct strbuf" initialization
    -    followed by calling "strbuf_release()" function.
    +    followed by calling "strbuf_release()" function, without any uses of
    +    the strbuf in the same function.
     
    -    See extensive commentary in the new "unused.cocci" for how it works,
    -    and what it's intended to find and replace.
    +    See the tests in contrib/coccinelle/tests/unused.{c,res} for what it's
    +    intended to find and replace.
     
         The inclusion of "contrib/scalar/scalar.c" is because "spatch" was
         manually run on it (we don't usually run spatch on contrib).
     
    -    The use of "with strict" here will be explained and amended in the
    -    following commit.
    +    Per the "buggy code" comment we also match a strbuf_init() before the
    +    xmalloc(), but we're not seeking to be so strict as to make checks
    +    that the compiler will catch for us redundant. Saying we'll match
    +    either "init" or "xmalloc" lines makes the rule simpler.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/fetch.c: static int store_updated_refs(const char *raw_url, const char *
      }
     
      ## builtin/merge.c ##
    +@@ builtin/merge.c: static void reset_hard(const struct object_id *oid, int verbose)
    + static void restore_state(const struct object_id *head,
    + 			  const struct object_id *stash)
    + {
    +-	struct strbuf sb = STRBUF_INIT;
    + 	const char *args[] = { "stash", "apply", NULL, NULL };
    + 
    + 	if (is_null_oid(stash))
    +@@ builtin/merge.c: static void restore_state(const struct object_id *head,
    + 	 */
    + 	run_command_v_opt(args, RUN_GIT_CMD);
    + 
    +-	strbuf_release(&sb);
    + 	refresh_cache(REFRESH_QUIET);
    + }
    + 
     @@ builtin/merge.c: static void merge_name(const char *remote, struct strbuf *msg)
      {
      	struct commit *remote_head;
    @@ builtin/merge.c: static void merge_name(const char *remote, struct strbuf *msg)
      }
      
     
    + ## contrib/coccinelle/tests/unused.c (new) ##
    +@@
    ++void test_strbuf(void)
    ++{
    ++	struct strbuf sb1 = STRBUF_INIT;
    ++	struct strbuf sb2 = STRBUF_INIT;
    ++	struct strbuf sb3 = STRBUF_INIT;
    ++	struct strbuf sb4 = STRBUF_INIT;
    ++	struct strbuf sb5;
    ++	struct strbuf sb6 = { 0 };
    ++	struct strbuf sb7 = STRBUF_INIT;
    ++	struct strbuf sb8 = STRBUF_INIT;
    ++	struct strbuf *sp1;
    ++	struct strbuf *sp2;
    ++	struct strbuf *sp3;
    ++	struct strbuf *sp4 = xmalloc(sizeof(struct strbuf));
    ++	struct strbuf *sp5 = xmalloc(sizeof(struct strbuf));
    ++	struct strbuf *sp6 = xmalloc(sizeof(struct strbuf));
    ++	struct strbuf *sp7;
    ++
    ++	strbuf_init(&sb5, 0);
    ++	strbuf_init(sp1, 0);
    ++	strbuf_init(sp2, 0);
    ++	strbuf_init(sp3, 0);
    ++	strbuf_init(sp4, 0);
    ++	strbuf_init(sp5, 0);
    ++	strbuf_init(sp6, 0);
    ++	strbuf_init(sp7, 0);
    ++	sp7 = xmalloc(sizeof(struct strbuf));
    ++
    ++	use_before(&sb3);
    ++	use_as_str("%s", sb7.buf);
    ++	use_as_str("%s", sp1->buf);
    ++	use_as_str("%s", sp6->buf);
    ++	pass_pp(&sp3);
    ++
    ++	strbuf_release(&sb1);
    ++	strbuf_reset(&sb2);
    ++	strbuf_release(&sb3);
    ++	strbuf_release(&sb4);
    ++	strbuf_release(&sb5);
    ++	strbuf_release(&sb6);
    ++	strbuf_release(&sb7);
    ++	strbuf_release(sp1);
    ++	strbuf_release(sp2);
    ++	strbuf_release(sp3);
    ++	strbuf_release(sp4);
    ++	strbuf_release(sp5);
    ++	strbuf_release(sp6);
    ++	strbuf_release(sp7);
    ++
    ++	use_after(&sb4);
    ++
    ++	if (when_strict())
    ++		return;
    ++	strbuf_release(&sb8);
    ++}
    +
    + ## contrib/coccinelle/tests/unused.res (new) ##
    +@@
    ++void test_strbuf(void)
    ++{
    ++	struct strbuf sb3 = STRBUF_INIT;
    ++	struct strbuf sb4 = STRBUF_INIT;
    ++	struct strbuf sb7 = STRBUF_INIT;
    ++	struct strbuf *sp1;
    ++	struct strbuf *sp3;
    ++	struct strbuf *sp6 = xmalloc(sizeof(struct strbuf));
    ++	strbuf_init(sp1, 0);
    ++	strbuf_init(sp3, 0);
    ++	strbuf_init(sp6, 0);
    ++
    ++	use_before(&sb3);
    ++	use_as_str("%s", sb7.buf);
    ++	use_as_str("%s", sp1->buf);
    ++	use_as_str("%s", sp6->buf);
    ++	pass_pp(&sp3);
    ++
    ++	strbuf_release(&sb3);
    ++	strbuf_release(&sb4);
    ++	strbuf_release(&sb7);
    ++	strbuf_release(sp1);
    ++	strbuf_release(sp3);
    ++	strbuf_release(sp6);
    ++
    ++	use_after(&sb4);
    ++
    ++	if (when_strict())
    ++		return;
    ++}
    +
      ## contrib/coccinelle/unused.cocci (new) ##
     @@
    -+// This rule finds sequences of "unused" declerations and uses of
    -+// "struct strbuf".
    -+//
    -+// I.e. this finds cases where we only declare the variable, and then
    -+// release it, e.g.:
    -+//
    -+//	struct strbuf buf = STRBUF_INIT;
    -+//      [.. no other use of "buf" in the function ..]
    -+//	strbuf_release(&buf)
    -+//
    -+// Or:
    -+//
    -+//	struct strbuf buf;
    -+//	[.. no other use of "buf" in the function ..]
    -+//	strbuf_init(&buf, 0);
    -+//	[.. no other use of "buf" in the function ..]
    -+//	strbuf_release(&buf)
    -+//
    -+// To do do this we find (continued below)...
    ++// This rule finds sequences of "unused" declerations and uses of a
    ++// variable, where "unused" is defined to include only calling the
    ++// equivalent of alloc, init & free functions on the variable.
     +@@
     +type T;
     +identifier I;
    -+// STRBUF_INIT
     +constant INIT_MACRO =~ "^STRBUF_INIT$";
    -+// strbuf_init(&I, ...) etc.
    ++identifier MALLOC1 =~ "^x?[mc]alloc$";
     +identifier INIT_CALL1 =~ "^strbuf_init$";
    -+// strbuf_release()
    -+identifier REL1 =~ "^strbuf_release$";
    ++identifier REL1 =~ "^strbuf_(release|reset)$";
     +@@
     +
    -+// .. A declaration like "struct strbuf buf;"...
     +(
     +- T I;
    -+// ... or "struct strbuf buf = { 0 };" ...
     +|
     +- T I = { 0 };
    -+// ... or "struct STRBUF buf = STRBUF_INIT;" ...
     +|
     +- T I = INIT_MACRO;
    ++|
    ++- T I = MALLOC1(...);
     +)
     +
    -+// ... Optionally followed by lines that make no use of "buf", "&buf"
    -+// etc., but which ...
     +<... when != \( I \| &I \)
    -+     when strict
    -+// .. (only) make use of "buf" or "&buf" to call something like
    -+// "strbuf_init(&buf, ...)" ...
    ++(
     +- \( INIT_CALL1 \)( \( I \| &I \), ...);
    ++|
    ++- I = MALLOC1(...);
    ++)
     +...>
     +
    -+// ... and then no mention of "buf" or "&buf" until we get to a
    -+// strbuf_release(&buf) at the end ...
     +- \( REL1 \)( \( &I \| I \) );
    -+// ... and no use *after* either, e.g. we don't want to delete
    -+// init/strbuf_release() patterns, where "&buf" could be used
    -+// afterwards.
     +  ... when != \( I \| &I \)
    -+      when strict
    -+// This rule also isn't capable of finding cases where &buf is used,
    -+// but only to e.g. pass that variable to a static function which
    -+// doesn't use it. The analysis is only function-local.
     
      ## contrib/scalar/scalar.c ##
     @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
2:  6324d3956ed < -:  ----------- cocci: catch unused "strbuf" using an xmalloc() pattern
3:  9a5e7208dec < -:  ----------- cocci: remove "when strict" from unused.cocci
4:  45a429b9cc9 ! 6:  dafd59d5ded cocci: generalize "unused" rule to cover more than "strbuf"
    @@ Commit message
         similar-looking *_{release,clear,free}() and {release,clear,free}_*()
         functions.
     
    +    We're intentionally loose in accepting e.g. a "strbuf_init(&sb)"
    +    followed by a "string_list_clear(&sb, 0)".  It's assumed that the
    +    compiler will catch any such invalid code, i.e. that our
    +    constructors/destructors don't take a "void *".
    +
         See [1] for example of code that would be covered by the
         "get_worktrees()" part of this rule. We'd still need work that the
         series is based on (we were passing "worktrees" to a function), but
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      	string_list_clear(&existing_kept_packs, 0);
      	clear_pack_geometry(geometry);
     
    + ## contrib/coccinelle/tests/unused.c ##
    +@@ contrib/coccinelle/tests/unused.c: void test_strbuf(void)
    + 		return;
    + 	strbuf_release(&sb8);
    + }
    ++
    ++void test_other(void)
    ++{
    ++	struct string_list l = STRING_LIST_INIT_DUP;
    ++	struct strbuf sb = STRBUF_INIT;
    ++
    ++	string_list_clear(&l, 0);
    ++	string_list_clear(&sb, 0);
    ++}
    ++
    ++void test_worktrees(void)
    ++{
    ++	struct worktree **w1 = get_worktrees();
    ++	struct worktree **w2 = get_worktrees();
    ++	struct worktree **w3;
    ++	struct worktree **w4;
    ++
    ++	w3 = get_worktrees();
    ++	w4 = get_worktrees();
    ++
    ++	use_it(w4);
    ++
    ++	free_worktrees(w1);
    ++	free_worktrees(w2);
    ++	free_worktrees(w3);
    ++	free_worktrees(w4);
    ++}
    +
    + ## contrib/coccinelle/tests/unused.res ##
    +@@ contrib/coccinelle/tests/unused.res: void test_strbuf(void)
    + 	if (when_strict())
    + 		return;
    + }
    ++
    ++void test_other(void)
    ++{
    ++}
    ++
    ++void test_worktrees(void)
    ++{
    ++	struct worktree **w4;
    ++
    ++	w4 = get_worktrees();
    ++
    ++	use_it(w4);
    ++
    ++	free_worktrees(w4);
    ++}
    +
      ## contrib/coccinelle/unused.cocci ##
    -@@
    - // This rule finds sequences of "unused" declerations and uses of
    --// "struct strbuf".
    -+// "struct strbuf" and other common types.
    - //
    - // I.e. this finds cases where we only declare the variable, and then
    - // release it, e.g.:
     @@
      @@
      type T;
      identifier I;
    --// STRBUF_INIT
     -constant INIT_MACRO =~ "^STRBUF_INIT$";
     +// STRBUF_INIT, but also e.g. STRING_LIST_INIT_DUP (so no anchoring)
     +constant INIT_MACRO =~ "_INIT";
    - // x[mc]alloc() etc.
      identifier MALLOC1 =~ "^x?[mc]alloc$";
    -+// I = get_worktrees() etc.
    -+identifier INIT_ASSIGN1 =~ "^get_worktrees$";
    - // strbuf_init(&I, ...) etc.
     -identifier INIT_CALL1 =~ "^strbuf_init$";
    --// strbuf_release()
    --identifier REL1 =~ "^strbuf_release$";
    +-identifier REL1 =~ "^strbuf_(release|reset)$";
    ++identifier INIT_ASSIGN1 =~ "^get_worktrees$";
     +identifier INIT_CALL1 =~ "^[a-z_]*_init$";
    -+// stbuf_release(), string_list_clear() etc.
    -+identifier REL1 =~ "^[a-z_]*_(release|clear|free)$";
    -+// release_patch(), clear_pathspec() etc.
    ++identifier REL1 =~ "^[a-z_]*_(release|reset|clear|free)$";
     +identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
      @@
      
    - // .. A declaration like "struct strbuf buf;"...
    -@@ contrib/coccinelle/unused.cocci: identifier REL1 =~ "^strbuf_release$";
    - // "strbuf_init(&buf, ...)" ...
    + (
    +@@ contrib/coccinelle/unused.cocci: identifier REL1 =~ "^strbuf_(release|reset)$";
    + - T I = INIT_MACRO;
    + |
    + - T I = MALLOC1(...);
    ++|
    ++- T I = INIT_ASSIGN1(...);
    + )
    + 
    + <... when != \( I \| &I \)
    + (
      - \( INIT_CALL1 \)( \( I \| &I \), ...);
      |
    -+// .. or e.g. "worktrees = get_worktrees();", i.e. a known "assignment
    -+// init" ...
     +- I = \( INIT_ASSIGN1 \)(...);
     +|
    - // .. or to follow-up a "struct strbuf *buf" with e.g. "buf =
    - // xmalloc(...)" (which may in turn be followed-up by a
    - // "strbuf_init()", which we'll match with INIT_CALL1) ...
    -@@ contrib/coccinelle/unused.cocci: identifier REL1 =~ "^strbuf_release$";
    + - I = MALLOC1(...);
    + )
    + ...>
      
    - // ... and then no mention of "buf" or "&buf" until we get to a
    - // strbuf_release(&buf) at the end ...
     -- \( REL1 \)( \( &I \| I \) );
     +(
     +- \( REL1 \| REL2 \)( \( I \| &I \), ...);
     +|
     +- \( REL1 \| REL2 \)( \( &I \| I \) );
     +)
    - // ... and no use *after* either, e.g. we don't want to delete
    - // init/strbuf_release() patterns, where "&buf" could be used
    - // afterwards.
        ... when != \( I \| &I \)
    -+// Note that we're intentionally loose in accepting e.g. a
    -+// "strbuf_init(&buf)" followed by a "string_list_clear(&buf,
    -+// 0)". It's assumed that the compiler will catch any such invalid
    -+// code, i.e. that our constructors/destructors don't take a "void *".
    -+//
    - // This rule also isn't capable of finding cases where &buf is used,
    - // but only to e.g. pass that variable to a static function which
    - // doesn't use it. The analysis is only function-local.
-- 
2.37.0.913.g50625c3f077

