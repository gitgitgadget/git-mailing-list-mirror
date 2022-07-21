Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C805EC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiGUMBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiGUMBN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:01:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C21A821
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d16so1915886wrv.10
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZfpUxHJEGA2VH+oD+Q2rifpvJEeOwhigUwvcPg6HOs=;
        b=OkMtBLT0qk5Hz/gz+G0eoVwjIzsArS+OcSLOjnJ5BvSE3258iRIQEFuyVc9d361a+Y
         o3XmsVd3S6S47UaJsZErtSATNwOyqgF2u2a8jMUVpwlywyRfeh6ZEYfAQmWQRwSdb4Qy
         5vQdo27waY+VBiT6GVa5yLpSb7is7JCgvKTg5+al8wplkcdKnYBnMZQXdcfP+pL4JRlv
         WISB7cF5cAmNgh3vf9SNGACnIHdR/PJXBbOgST935TxQ5j5DAWP1wOsbAV3KorUOcTE8
         nqhJOoWL0DcakXye91bFMT2WPYCM/FmxUHWdFEAJV6MGAjdEDMb7naIwqY7uBoB3dNAf
         TSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZfpUxHJEGA2VH+oD+Q2rifpvJEeOwhigUwvcPg6HOs=;
        b=4CtmlcRvBeAaa+rPDuzG0aKGLMzySapLwwaQSzVxndsfiN8ZklqHn13GItmn4nD9pb
         5dJ/+13H1VNt6gOU5wcsZLvHwIFYXqjGjYUYA1JQz3tFlnL/NTmDCWTcNiE6atiVbFUr
         sZiBfKKVu9zQCJj+AOM9sHbMnqmSMNPaivi+3kuVUNCvwWqMNUneHYfPCWJi5g7AqWNP
         npAv0ELo2/sHwgK3jKxH2Up6fYtgCDFWNLtDxrbtKdPDf+hd6GJbAYXyvEwVyBWn9MtT
         Oo/XXcg69xppPKqLvfhouYTGh1czwNqeokwXfgKSakqproiMittLEXnXIYHfI+B1GRcM
         WnVg==
X-Gm-Message-State: AJIora/M4n773FqqL7dx3v5T6w2bu5y2qfiOF4k3hOvFXm1Zw6kMj/CH
        CuwX/SedtqXTKcfjVUrXLC/weUgtwfpPBw==
X-Google-Smtp-Source: AGRyM1tF0hLO1GWe3tZ9CZu/6dApqwRcAEm28b7MDc4ex8ryMiSHLXDGgxJaMW/FjfyGAahzqFUcFg==
X-Received: by 2002:a5d:6908:0:b0:21e:4fe3:cd1f with SMTP id t8-20020a5d6908000000b0021e4fe3cd1fmr4260047wru.476.1658404869888;
        Thu, 21 Jul 2022 05:01:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a3200bc788sm5226069wmh.33.2022.07.21.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 05:01:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] string-list API user: fix API use, some with coccinelle
Date:   Thu, 21 Jul 2022 14:00:47 +0200
Message-Id: <cover-v2-0.6-00000000000-20220721T111808Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A larger v2, this:

 * Renames string_list.cocci to string-list.cocci (to be consistent
   with the string-list.[ch])

 * Answers Elijah's question about why the previous 2/2 left out one
   case, it's due to --disable-worth-trying-opt. That's now split out
   into its own commit.

   FWIW it's the only case with "make coccicheck" that we've "missed",
   including existing rules, but we just got lucky there.

   I have some follow-up patches to fix various such bugs in our
   coccicheck, but let's leave the larger fixes for now.

 * The new 4/6 duplicates Junio's
   https://lore.kernel.org/git/xmqq7d471dns.fsf@gitster.g/, but now
   we've got a coccinelle rule for it and similar inverse cases. It's
   still the only in-tree case, but it's probably good to keep the
   rule around regardless.

   I could also eject that *.C change and say this is based on
   Junio's, or both could make the same change and "merge" will sort
   it out. I do think 4/6 is a bit easier to read with an actual case
   where we change things, but then again there's the added tests...

 * A new 5/6 tweaks some "strdup_strings" dancing to a simpler
   pattern, this is adjusted from my local WIP branch of larger
   string_list API fixes.

 * A new 6/6 fixes a confusing case of dup v.s. nodup to use a more
   obvious callback pattern where we don't flip-flop.

Ævar Arnfjörð Bjarmason (6):
  string_list API users + cocci: use string_list_init_dup()
  cocci: apply string_list.cocci with --disable-worth-trying-opt
  reflog-walk.c: use string_list_init_dup()
  cocci: add "string_list" rule to swap "DUP" <-> "NODUP"
  string-list API users: don't tweak "strdup_strings" to free dupes
  notes.c: make "struct string_list display_notes_refs" non-static

 bisect.c                                 |  7 +++---
 builtin/remote.c                         |  3 +--
 contrib/coccinelle/string-list.cocci     | 26 ++++++++++++++++++++++
 contrib/coccinelle/tests/string-list.c   | 20 +++++++++++++++++
 contrib/coccinelle/tests/string-list.res | 18 +++++++++++++++
 notes-utils.c                            |  4 ++--
 notes.c                                  | 28 ++++++++++++++----------
 reflog-walk.c                            |  2 +-
 refs.c                                   |  4 ++--
 resolve-undo.c                           |  8 +++----
 revision.c                               |  4 ++--
 11 files changed, 95 insertions(+), 29 deletions(-)
 create mode 100644 contrib/coccinelle/string-list.cocci
 create mode 100644 contrib/coccinelle/tests/string-list.c
 create mode 100644 contrib/coccinelle/tests/string-list.res

Range-diff against v1:
1:  c89758491e7 ! 1:  61a62bdf8e9 string_list API users + cocci: use string_list_init_dup()
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## contrib/coccinelle/string_list.cocci (new) ##
    + ## contrib/coccinelle/string-list.cocci (new) ##
     @@
     +@@
     +struct string_list *P;
    @@ contrib/coccinelle/string_list.cocci (new)
     +- (P)->strdup_strings = 1;
     ++ string_list_init_dup(P);
     
    - ## contrib/coccinelle/tests/string_list.c (new) ##
    + ## contrib/coccinelle/tests/string-list.c (new) ##
     @@
     +int init(void)
     +{
    @@ contrib/coccinelle/tests/string_list.c (new)
     +	list->strdup_strings = 1;
     +}
     
    - ## contrib/coccinelle/tests/string_list.res (new) ##
    + ## contrib/coccinelle/tests/string-list.res (new) ##
     @@
     +int init(void)
     +{
2:  5d8baa9cbc4 ! 2:  33e551a2f4c string-list API users: manually use string_list_init_*()
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    string-list API users: manually use string_list_init_*()
    +    cocci: apply string_list.cocci with --disable-worth-trying-opt
     
    -    Convert various code that didn't use string_list_init_*() to do so, in
    -    cases where the only thing being allocated was the string list we can
    -    change from CALLOC_ARRAY() to ALLOC_ARRAY(), the string_list_init_*()
    -    function will zero out the memory.
    +    Apply the new string-list.cocci added in the preceding commit with
    +    --disable-worth-trying-opt. For optimization purposes we run spatch in
    +    a mode where even though we run it with --all-includes we'll miss some
    +    changes because we don't use --disable-worth-trying-opt.
     
    -    This covers cases that weren't matched by tho coccinelle rule in the
    -    preceding commit, which is conservative enough to care about the type
    -    of what we're modifying.
    +    This is because without that option it'll take a look at
    +    notes-utils.c, and conclude that it doesn't need to process
    +    it (irrelevant output excluded with "[...]"):
    +
    +            $ spatch --sp-file contrib/coccinelle/string-list.cocci --patch . notes-utils.c
    +            [...]
    +            (ONCE) Expected tokens string_list strdup_strings CALLOC_ARRAY
    +            Skipping: notes-utils.c
    +
    +    This is just one of the known (and probably some unknown) issues where
    +    our "make coccicheck" fails to include changes for whatever
    +    reason. That should be fixed more generally, but let's just fix this
    +    manually for now.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ notes-utils.c: struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char
      	c->refs_from_env = 0;
      	c->mode_from_env = 0;
      	if (rewrite_mode_env) {
    -
    - ## reflog-walk.c ##
    -@@ reflog-walk.c: struct reflog_walk_info {
    - void init_reflog_walk(struct reflog_walk_info **info)
    - {
    - 	CALLOC_ARRAY(*info, 1);
    --	(*info)->complete_reflogs.strdup_strings = 1;
    -+	string_list_init_dup(&((*info)->complete_reflogs));
    - }
    - 
    - void reflog_walk_info_release(struct reflog_walk_info *info)
-:  ----------- > 3:  62aab32ae77 reflog-walk.c: use string_list_init_dup()
-:  ----------- > 4:  2d858c49243 cocci: add "string_list" rule to swap "DUP" <-> "NODUP"
-:  ----------- > 5:  8c0ac6cbd96 string-list API users: don't tweak "strdup_strings" to free dupes
-:  ----------- > 6:  b0de7a63d1c notes.c: make "struct string_list display_notes_refs" non-static
-- 
2.37.1.1095.g64a1e8362fd

