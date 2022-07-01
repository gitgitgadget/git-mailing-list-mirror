Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC0CCA480
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiGAKb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiGAKb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:31:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E3676942
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:31:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k22so2563118wrd.6
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VFLSiO/6KET+SGlh7ge6Au3MtKLtuBXO/JcZUNxAHQ=;
        b=X61bVeqSnUFxI8ESlmdOJxq5PbICgpQvbv+LeBwBHGBw6onV9jbFDUiepwpd0QF17p
         naZsd1MgslTE70MAUW1MzM2GVXNG0gQj/l0lUml5wiEn4jAUWJ9zDacMMh1NH5D5n1hc
         fukrbNeeAfY+ySCO54UVd9JtKYmf0w3DjmeeCOKd4dlq4xQUsLvo1a/DmxX15jWzCHas
         0ZcryGWAE/PgsprG30Z0fJwLaLNiIga9LNIa34Misoe0w3TiXiEVo+dz3oZD7oR90ttd
         3Zt4mcVnR+YM3xbeG7V3zMHQKdWho+5XRRvqODpnSp+lKezAtce2naJURUlidiFWTFKU
         7ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VFLSiO/6KET+SGlh7ge6Au3MtKLtuBXO/JcZUNxAHQ=;
        b=GXxMzi18+uA1+Lreg2Qc7NkgYf7W7PqGHvvR3+NL6qVJ6ibeZ1xN0uBVn8B3AHUcuT
         E1i+xqS1xYHVt23RdeifzeSs1+jc9KiyuSHCJg31CnNO/FYaVo7ew6Py/rrZuAnYzGW3
         MWPHHpytAKELaaLHsveoO2cts/2mJhlTrziVeKzEPIqDAghRBKEoK9hF3SXzdq7taJlS
         SIdaJgl0vlnQB08hrNNMrEW+2Un9Eo2EtVJ+TU14cWvB0mp/mWddTeHXdQhOHV3frQ72
         qDzGHGAOKXXJSY1JZhRUJ2CwABHcGpndIDtJ6OVZr1iMEhMQp3AhZrxL09puPs+BdEPy
         L9vA==
X-Gm-Message-State: AJIora/qMwJnutUNfTxNme1bGr4Wn4TpZ76hKFD+ctV7aaTgQgW1bQ4w
        eQf1YuFpy7fp36mfkpjcSHu+mEMFOms0jg==
X-Google-Smtp-Source: AGRyM1v4JleLbjFSeVEveGy6Q9INkaeWoOKmWXBDa0rsnEB+UBdAnGoBgIut4rAH+HOlRv/DQ2n0NQ==
X-Received: by 2002:adf:fd92:0:b0:21a:3d15:91f9 with SMTP id d18-20020adffd92000000b0021a3d1591f9mr12613227wrr.262.1656671483731;
        Fri, 01 Jul 2022 03:31:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c12c600b0039c811077d3sm9712790wmd.22.2022.07.01.03.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:31:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/4] add and apply a rule to find "unused" init+free
Date:   Fri,  1 Jul 2022 12:30:55 +0200
Message-Id: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com>
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

Changes since v2:

 * Make the wider rule revert-able, as requested by Junio in
   https://lore.kernel.org/git/xmqqsfnw65zu.fsf@gitster.g/

 * We now find and remove "malloc" followed by an optional "init" and
   "release".

 * We now match { 0 } initializers, in addition to things that look
   like "INIT" macros.

Ævar Arnfjörð Bjarmason (4):
  cocci: add and apply a rule to find "unused" strbufs
  cocci: catch unused "strbuf" using an xmalloc() pattern
  cocci: remove "when strict" from unused.cocci
  cocci: generalize "unused" rule to cover more than "strbuf"

 builtin/fetch.c                 |  3 +-
 builtin/merge.c                 |  4 --
 builtin/repack.c                |  2 -
 contrib/coccinelle/unused.cocci | 88 +++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.c         |  3 +-
 diff.c                          |  2 -
 6 files changed, 90 insertions(+), 12 deletions(-)
 create mode 100644 contrib/coccinelle/unused.cocci

Range-diff against v2:
1:  d14036521ab ! 1:  49e9ccb5819 cocci: add and apply a rule to find "unused" variables
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    cocci: add and apply a rule to find "unused" variables
    +    cocci: add and apply a rule to find "unused" strbufs
     
    -    Add a coccinelle rule to remove variable initialization followed by
    -    calling a "release" function. See extensive commentary in the new
    -    "unused.cocci" for how it works, and what it's intended to find and
    -    replace.
    +    Add a coccinelle rule to remove "struct strbuf" initialization
    +    followed by calling "strbuf_release()" function.
    +
    +    See extensive commentary in the new "unused.cocci" for how it works,
    +    and what it's intended to find and replace.
     
         The inclusion of "contrib/scalar/scalar.c" is because "spatch" was
         manually run on it (we don't usually run spatch on contrib).
    @@ Commit message
         The use of "with strict" here will be explained and amended in the
         following commit.
     
    -    1. https://lore.kernel.org/git/042d624b8159364229e95d35e9309f12b67f8173.1652977582.git.gitgitgadget@gmail.com/
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/fetch.c ##
    @@ builtin/merge.c: static void merge_name(const char *remote, struct strbuf *msg)
     
      ## contrib/coccinelle/unused.cocci (new) ##
     @@
    -+// This rule finds sequences of "unused" declerations, init and
    -+// release(). E.g.:
    ++// This rule finds sequences of "unused" declerations and uses of
    ++// "struct strbuf".
    ++//
    ++// I.e. this finds cases where we only declare the variable, and then
    ++// release it, e.g.:
     +//
     +//	struct strbuf buf = STRBUF_INIT;
     +//      [.. no other use of "buf" in the function ..]
     +//	strbuf_release(&buf)
     +//
    ++// Or:
    ++//
    ++//	struct strbuf buf;
    ++//	[.. no other use of "buf" in the function ..]
    ++//	strbuf_init(&buf, 0);
    ++//	[.. no other use of "buf" in the function ..]
    ++//	strbuf_release(&buf)
    ++//
     +// To do do this we find (continued below)...
     +@@
     +type T;
     +identifier I;
    -+// STRBUF_INIT, but also e.g. STRING_LIST_INIT_DUP (so no anchoring)
    -+constant INIT =~ "_INIT";
    -+// I = get_worktrees() etc.
    -+identifier INIT_ASSIGN1 =~ "^get_worktrees$";
    ++// STRBUF_INIT
    ++constant INIT_MACRO =~ "^STRBUF_INIT$";
     +// strbuf_init(&I, ...) etc.
    -+identifier INIT_CALL1 =~ "^[a-z_]*_init$";
    -+// stbuf_release(), string_list_clear() etc.
    -+identifier REL1 =~ "^[a-z_]*_(release|clear|free)$";
    -+// release_patch(), clear_pathspec() etc.
    -+identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
    ++identifier INIT_CALL1 =~ "^strbuf_init$";
    ++// strbuf_release()
    ++identifier REL1 =~ "^strbuf_release$";
     +@@
     +
     +// .. A declaration like "struct strbuf buf;"...
     +(
     +- T I;
    ++// ... or "struct strbuf buf = { 0 };" ...
    ++|
    ++- T I = { 0 };
     +// ... or "struct STRBUF buf = STRBUF_INIT;" ...
     +|
    -+- T I = INIT;
    ++- T I = INIT_MACRO;
     +)
     +
     +// ... Optionally followed by lines that make no use of "buf", "&buf"
    @@ contrib/coccinelle/unused.cocci (new)
     +     when strict
     +// .. (only) make use of "buf" or "&buf" to call something like
     +// "strbuf_init(&buf, ...)" ...
    -+(
     +- \( INIT_CALL1 \)( \( I \| &I \), ...);
    -+|
    -+// .. or e.g. "worktrees = get_worktrees();", i.e. a known "assignment
    -+// init" ...
    -+- I = \( INIT_ASSIGN1 \)(...);
    -+)
     +...>
     +
     +// ... and then no mention of "buf" or "&buf" until we get to a
     +// strbuf_release(&buf) at the end ...
    -+(
    -+- \( REL1 \| REL2 \)( \( I \| &I \), ...);
    -+|
    -+- \( REL1 \| REL2 \)( \( &I \| I \) );
    -+)
    ++- \( REL1 \)( \( &I \| I \) );
     +// ... and no use *after* either, e.g. we don't want to delete
     +// init/strbuf_release() patterns, where "&buf" could be used
     +// afterwards.
     +  ... when != \( I \| &I \)
     +      when strict
    -+// Note that we're intentionally loose in accepting e.g. a
    -+// "strbuf_init(&buf)" followed by a "string_list_clear(&buf,
    -+// 0)". It's assumed that the compiler will catch any such invalid
    -+// code, i.e. that our constructors/destructors don't take a "void *".
    -+//
     +// This rule also isn't capable of finding cases where &buf is used,
     +// but only to e.g. pass that variable to a static function which
     +// doesn't use it. The analysis is only function-local.
-:  ----------- > 2:  6324d3956ed cocci: catch unused "strbuf" using an xmalloc() pattern
2:  4130dc15287 ! 3:  9a5e7208dec cocci: remove "when strict" from unused.cocci
    @@ builtin/merge.c: static void restore_state(const struct object_id *head,
      }
      
     
    - ## builtin/repack.c ##
    -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    - 	struct child_process cmd = CHILD_PROCESS_INIT;
    - 	struct string_list_item *item;
    - 	struct string_list names = STRING_LIST_INIT_DUP;
    --	struct string_list rollback = STRING_LIST_INIT_NODUP;
    - 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
    - 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
    - 	struct pack_geometry *geometry = NULL;
    -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    - 	}
    - 
    - 	string_list_clear(&names, 0);
    --	string_list_clear(&rollback, 0);
    - 	string_list_clear(&existing_nonkept_packs, 0);
    - 	string_list_clear(&existing_kept_packs, 0);
    - 	clear_pack_geometry(geometry);
    -
      ## contrib/coccinelle/unused.cocci ##
    -@@ contrib/coccinelle/unused.cocci: identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
    +@@ contrib/coccinelle/unused.cocci: identifier REL1 =~ "^strbuf_release$";
      // ... Optionally followed by lines that make no use of "buf", "&buf"
      // etc., but which ...
      <... when != \( I \| &I \)
     -     when strict
    + (
      // .. (only) make use of "buf" or "&buf" to call something like
      // "strbuf_init(&buf, ...)" ...
    - (
    -@@ contrib/coccinelle/unused.cocci: identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
    +@@ contrib/coccinelle/unused.cocci: identifier REL1 =~ "^strbuf_release$";
      // init/strbuf_release() patterns, where "&buf" could be used
      // afterwards.
        ... when != \( I \| &I \)
     -      when strict
    - // Note that we're intentionally loose in accepting e.g. a
    - // "strbuf_init(&buf)" followed by a "string_list_clear(&buf,
    - // 0)". It's assumed that the compiler will catch any such invalid
    + // This rule also isn't capable of finding cases where &buf is used,
    + // but only to e.g. pass that variable to a static function which
    + // doesn't use it. The analysis is only function-local.
-:  ----------- > 4:  45a429b9cc9 cocci: generalize "unused" rule to cover more than "strbuf"
-- 
2.37.0.900.g4d0de1cceb2

