Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A55C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347043AbiFCSjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347477AbiFCSi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:38:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A784513E9A
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t13so11436938wrg.9
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPpBwzTnfki3Yu19R4uLNMXp4KWuN/tV971U6Qb2csw=;
        b=gowkXgGF3tpmm1M32qCF0AWpKXqwvo+zoQmUy+Z+T7R8JPLHXJm0dNueo7Jg7mB8TQ
         cvPcIRoqx058kJxwEZYzhldBSErlEE1cEa0xQ2gCgJvmsesMnrjwlYeA9bwvFqA7EQA3
         VBtBb+f+npHSDM9AcS2w8IbjE2mALF/z0chYVLzETJf75gQH4vUKbJn4CuZAc7Oby4Fw
         2159g/4JTQ/sOZa2GJLO0/M2ItkOU++n6k24xI2QC4YzYrnh8F5kA2NbFmJNK0fCIW1I
         IOmr6PR4OrFdXz9sNHJUIevFgV/FlDUS6B5Jlu6EpcBBKAeAwOH+WIgaRcPKzz3MFDPK
         aCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPpBwzTnfki3Yu19R4uLNMXp4KWuN/tV971U6Qb2csw=;
        b=XWU7L4uWehmG8QX0FYIyJ7V6j18Soyw3+EAqkrRm5Qmo1iPCHYE63yUnGNs05DoIy+
         nxai5EB4XfPtGnN4D03ZOoFYN5f0s+x6LM3Q8uFMrtYsrgMT+vE16LAADjeJBWk9+hGh
         3cHID3uPXnzK+uSL5iag4Xin8hxOIyrl5lpQA7Tbjr6NMR24LA1rPIUk8RrU+8DqoNVs
         mCpkYJP8WYxNXGm3tFX+xLuXXtg6n6kEhF0XNjuf4wvBga3rSiPjS9XxXusGKMce63kC
         e8HPQ3FuBauVeQs8LoNAwY6FEGWXnWKJ9vPly1gBjrEQTl4o7wNUXIsdAhZP+rPFbHRy
         crlQ==
X-Gm-Message-State: AOAM532pmrcBLP3QRZK28uKUMP01mAWa+KygqKsaKxjQp18ZnNWnSiOk
        T5vWtUZWN7ltRHItI9AfeUgXwIZjBOCWpQ==
X-Google-Smtp-Source: ABdhPJwN2xMSIvwqtVOMHpUIW3SznmHCctmQBUSG6BfjPGB64i1Q+jLtZ0o1Dx3iQKZN2t80rXdYXw==
X-Received: by 2002:adf:ef01:0:b0:20a:8068:ca5e with SMTP id e1-20020adfef01000000b0020a8068ca5emr9221923wro.661.1654281480397;
        Fri, 03 Jun 2022 11:38:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:37:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 00/15] Fix GCC -fanalyzer warnings & add -fanalyzer DEVOPTS mode
Date:   Fri,  3 Jun 2022 20:37:37 +0200
Message-Id: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -fanalyzer mode in GCC v12 is much better about reporting real
issues. This RFC series currently conflicts with "next", but I thought
sending it for comment sooner than later made sense.

With this series applied you can run:

    make DEVOPTS=analyzer

Which will turn all of these into warnings even under -Werror, we can
also:

    make DEVOPTS="analyzer no-suppress-analyzer"

This works on both GCC 12 and GCC 11, but the former will yield better
results. We need to quiet some issues on GCC 11. GCC 10 ships with
"-fanalyzer", but it has so many false positives that we'll $(error)
out if you try to run it with DEVOPTS=fanalyzer.

If you're CC'd on this series you were either involved in some
discussion about -fanalyzer on the ML, or one of the commits mentioned
in this series is yours. Comments on individual sets of patches below:

Ævar Arnfjörð Bjarmason (15):
  remote.c: don't dereference NULL in freeing loop
  pull.c: don't feed NULL to strcmp() on get_rebase_fork_point() path
  reftable: don't memset() a NULL from failed malloc()

These are all real bugs, in rough order of more to less severe.

  diff-lib.c: don't dereference NULL in oneway_diff()
  refs/packed-backend.c: add a BUG() if iter is NULL
  ref-filter.c: BUG() out on show_ref() with NULL refname

These may or may not be real bugs, I'm pretty sure they are...

  strbuf.c: placate -fanalyzer in strbuf_grow()

The first of cases where -fanalyzer isn't "wrong", but it is in the
sense that the error it points out is a hard constraint that we
(hopefully) ensure elsewhere in various APIs.

  strbuf.c: use st_add3(), not unsigned_add_overflows()

A while-we're-at-it for code spotted in the last commit.

  add-patch: assert parse_diff() expectations with BUG()
  reftable: don't have reader_get_block() confuse -fanalyzer
  blame.c: clarify the state of "final_commit" for -fanalyzer
  pack.h: wrap write_*file*() functions
  pack-write API: pass down "verify" not arbitrary flags

These are all cases where -fanalyzer flags "genuine" issues, but on
closer inspection it's because we're passing the equivalent of two
variables we know go hand-in-hand, but probably no compiler can be
smart enough to spot that.

E.g. the first one here is a case where "git add -p" would segfault if
fed diffs that aren't in the format "git diff" would emit, but since
we control both sides it doesn't happen in practice.

Regardless, sprinkling assertions and BUG() guards in that code seems
prudent.

  config.mak.dev: add a DEVOPTS=analyzer mode to use GCC's -fanalyzer

Add the new DEVOPTS mode and quiet some issues that need -Wno-error=*.

  config.mak.dev: add and use ASSERT_FOR_FANALYZER() macro

Quiet some outstanding issues, the main reason these aren't in commits
like the above is because I didn't get to them yet, and may not any
time soon. They may be genuine bugs, false alarms etc.

Even if we don't get to these I think having a CI mode with -fanalyzer
and a whitelist of current issues would be an improment, since we'd
error on *new* isssues.

This series doesn't add such a CI mode yet, due to conflicts with CI
work in "next"..

Ævar Arnfjörð Bjarmason (15):
  remote.c: don't dereference NULL in freeing loop
  pull.c: don't feed NULL to strcmp() on get_rebase_fork_point() path
  reftable: don't memset() a NULL from failed malloc()
  diff-lib.c: don't dereference NULL in oneway_diff()
  refs/packed-backend.c: add a BUG() if iter is NULL
  ref-filter.c: BUG() out on show_ref() with NULL refname
  strbuf.c: placate -fanalyzer in strbuf_grow()
  strbuf.c: use st_add3(), not unsigned_add_overflows()
  add-patch: assert parse_diff() expectations with BUG()
  reftable: don't have reader_get_block() confuse -fanalyzer
  blame.c: clarify the state of "final_commit" for -fanalyzer
  pack.h: wrap write_*file*() functions
  pack-write API: pass down "verify" not arbitrary flags
  config.mak.dev: add a DEVOPTS=analyzer mode to use GCC's -fanalyzer
  config.mak.dev: add and use ASSERT_FOR_FANALYZER() macro

 Makefile                | 14 +++++++++
 add-patch.c             |  7 ++++-
 blame.c                 |  2 +-
 builtin/fast-import.c   |  2 +-
 builtin/index-pack.c    | 35 +++++++++-------------
 builtin/name-rev.c      |  1 +
 builtin/pack-objects.c  |  9 ++----
 builtin/pull.c          | 14 +++++----
 config.mak.dev          | 65 +++++++++++++++++++++++++++++++++++++++++
 diff-lib.c              |  3 ++
 dir.c                   |  1 +
 git-compat-util.h       | 16 ++++++++++
 gpg-interface.c         |  2 ++
 graph.c                 |  2 ++
 line-log.c              |  2 ++
 midx.c                  |  2 +-
 pack-write.c            | 38 +++++++++++-------------
 pack.h                  | 24 +++++++++------
 ref-filter.c            |  4 ++-
 refs/packed-backend.c   |  2 ++
 reftable/publicbasics.c |  2 ++
 reftable/reader.c       | 11 +++----
 remote.c                |  8 ++---
 strbuf.c                | 10 ++++---
 unpack-trees.c          |  1 +
 utf8.c                  |  1 +
 26 files changed, 195 insertions(+), 83 deletions(-)

-- 
2.36.1.1124.g577fa9c2ebd

