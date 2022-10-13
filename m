Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84FAC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJMPjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJMPjl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E198C58B1
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:35 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so3466965wrr.3
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGzn+Xdtg++XHOYU/5c7xauynG3SHzS1630PFxp1q8Y=;
        b=mX6xpLDymEglCEbjYqctgFW3yunoEjxhwg883BfBlK841XLOhKgiSy4nK51TJNRhHc
         6pYufzPwPcMW2nv/wC2PGcHRXYZz9pZf8Crky9Q336tLd1hMq8MCjkeNRT6KezNeM5t4
         MuYFK2pxv447zuVLiAoZ2VITZJxwPUdxB1PhnFX+LwEZESgM3d8JnS3o8mgxmYTdKKIY
         RpWaul+W5JUjJkiuZniWypI6Q7qJDdYakuO9OCElpQ0++JP6df30i4ep36UgM6I3PUIu
         LEgW6ovm2Gnr7bTbHfdmcJNN4hTphFxazV9NtkuvjjfBgn0AUjB0WMVowJ3na0FFO9ki
         3ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGzn+Xdtg++XHOYU/5c7xauynG3SHzS1630PFxp1q8Y=;
        b=aCd1KRcpTCQsC8pGyADXptR15gtr2IA3vgchlbToX78aKh5wbvZ1LoqAaFEIRmKwzS
         oIo/KQOZ2DoCGwRutxWc5EHxWOj9USJPusEJsL4RPzbwMZcSHuG28ncD/VLnaSueMmi7
         rFrQi1UqOJu1AxNIuzmnyyXEl9m7adZuqki5YBpNZzjaQEte9EozWvX91w42+7AgYYeI
         e3/vCobrr980sr1FNeF7Wh0t9hYdEx6DwvSlMpHL2H5n6wnGhxzjgcXsmW40CncSgH1D
         ULMFeP7ZAEbfESyJLv31Mpj7kKt+jtMnqN1AalGlOv/fo+k4PFrfdjI8iExME81jmown
         gLGA==
X-Gm-Message-State: ACrzQf1LEdURlz0/bGV0czWwVB/N/8LH3SAAvckR1Ww43TiuyNhBOs4D
        JdHrqvHtOBKTmv+f+PUMcDgZFPhVxJQQbA==
X-Google-Smtp-Source: AMsMyM7G3WjGAcbXTgRzWuD6vCVYZmqYJl+ljRIuoRvcu4pr+GHxB4W6w1UVIsHDTldzoAblxtlCMA==
X-Received: by 2002:a5d:5691:0:b0:22c:db35:7939 with SMTP id f17-20020a5d5691000000b0022cdb357939mr409743wrv.102.1665675573365;
        Thu, 13 Oct 2022 08:39:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/34] doc/UX: make txt & -h output more consistent
Date:   Thu, 13 Oct 2022 17:38:54 +0200
Message-Id: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are currently wildly inconsistent in whether the SYNOPSIS in the
manual page matches the first line of the -h output, and as we add new
options we routinely forget to add them to one or the other (or both).

Without a more complex approach it's hard to do something about the
"or both" case. But we can rather easily test whether the -h output
matches the *.txt version, and report differences.

As this series shows that allows us to fix a lot of issues we've
effectively already "fixed", we just fixed them in one version, but
not the other.

For the rest of the general overview (the first paragraphs are
copy/pasted) see the v1 at:
https://lore.kernel.org/git/cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com
For v3 see:
https://lore.kernel.org/git/cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com/

Junio: A trivial v5 re your
https://lore.kernel.org/git/xmqqlepvsgeo.fsf@gitster.g/; FWIW I saw
that existing prose, but figured we could continue to use "any paths",
but it's rephrased to incorporate "<pathspec>" here, no other changes.

I'm aware of the minor merge conflict with the builtin/symbolic-ref.c
topic of yours, but I see you've resolved it on your side, so this is
still based on "master".

Ævar Arnfjörð Bjarmason (34):
  tests: assert *.txt SYNOPSIS and -h output
  CodingGuidelines: update and clarify command-line conventions
  builtin/bundle.c: indent with tabs
  bundle: define subcommand -h in terms of command -h
  doc SYNOPSIS: don't use ' for subcommands
  doc SYNOPSIS: consistently use ' for commands
  built-ins: consistently add "\n" between "usage" and options
  doc txt & -h consistency: word-wrap
  doc txt & -h consistency: fix incorrect alternates syntax
  doc txt & -h consistency: add "-z" to cat-file "-h"
  doc txt & -h consistency: balance unbalanced "[" and "]"
  doc txt & -h consistency: correct padding around "[]()"
  stash doc SYNOPSIS & -h: correct padding around "[]()"
  doc txt & -h consistency: use "<options>", not "<options>..."
  doc SYNOPSIS & -h: use "-" to separate words in labels, not "_"
  doc txt & -h consistency: fix mismatching labels
  doc txt & -h consistency: add or fix optional "--" syntax
  doc txt & -h consistency: make output order consistent
  doc txt & -h consistency: add missing options and labels
  doc txt & -h consistency: make "rerere" consistent
  doc txt & -h consistency: make "read-tree" consistent
  doc txt & -h consistency: make "bundle" consistent
  doc txt & -h consistency: use "git foo" form, not "git-foo"
  doc txt & -h consistency: add missing options
  doc txt & -h consistency: make "stash" consistent
  doc txt & -h consistency: make "annotate" consistent
  doc txt & -h consistency: use "[<label>...]" for "zero or more"
  doc txt & -h consistency: make "diff-tree" consistent
  doc txt & -h consistency: make "commit" consistent
  reflog doc: list real subcommands up-front
  worktree: define subcommand -h in terms of command -h
  doc txt & -h consistency: make "worktree" consistent
  tests: start asserting that *.txt SYNOPSIS matches -h output
  tests: assert consistent whitespace in -h output

 Documentation/CodingGuidelines                |  14 +-
 Documentation/git-annotate.txt                |   2 +-
 Documentation/git-clean.txt                   |  10 +-
 Documentation/git-commit-graph.txt            |   5 +-
 .../git-credential-cache--daemon.txt          |   4 +-
 Documentation/git-diff-files.txt              |   2 +-
 Documentation/git-fast-export.txt             |   2 +-
 Documentation/git-hash-object.txt             |   3 +-
 Documentation/git-interpret-trailers.txt      |   5 +-
 Documentation/git-merge-base.txt              |   4 +-
 Documentation/git-mv.txt                      |   4 +-
 Documentation/git-pack-redundant.txt          |   2 +-
 Documentation/git-prune-packed.txt            |   2 +-
 Documentation/git-read-tree.txt               |   2 +-
 Documentation/git-receive-pack.txt            |   4 +-
 Documentation/git-reflog.txt                  |  17 +-
 Documentation/git-rerere.txt                  |   2 +-
 Documentation/git-rev-list.txt                |   2 +-
 Documentation/git-send-pack.txt               |   5 +-
 Documentation/git-show-branch.txt             |   4 +-
 Documentation/git-show-ref.txt                |   4 +-
 Documentation/git-sparse-checkout.txt         |   2 +-
 Documentation/git-stash.txt                   |  17 +-
 Documentation/git-status.txt                  |   2 +-
 Documentation/git-tag.txt                     |  18 +-
 Documentation/git-update-server-info.txt      |   8 +-
 Documentation/git-upload-archive.txt          |   4 +-
 Documentation/git-var.txt                     |   2 +-
 Documentation/git-verify-commit.txt           |   2 +-
 Documentation/git-verify-pack.txt             |   2 +-
 Documentation/git-verify-tag.txt              |   2 +-
 Documentation/git-worktree.txt                |   3 +-
 builtin/blame.c                               |  22 ++-
 builtin/bugreport.c                           |   3 +-
 builtin/bundle.c                              |  38 ++--
 builtin/cat-file.c                            |   2 +-
 builtin/clean.c                               |   2 +-
 builtin/commit-graph.c                        |  10 +-
 builtin/commit-tree.c                         |   5 +-
 builtin/commit.c                              |  11 +-
 builtin/credential-cache--daemon.c            |   4 +-
 builtin/describe.c                            |   5 +-
 builtin/diagnose.c                            |   3 +-
 builtin/diff-files.c                          |   1 +
 builtin/diff-index.c                          |   3 +-
 builtin/diff-tree.c                           |   6 +-
 builtin/diff.c                                |   3 +-
 builtin/for-each-repo.c                       |   2 +-
 builtin/fsck.c                                |   5 +-
 builtin/hash-object.c                         |   5 +-
 builtin/help.c                                |   2 +-
 builtin/init-db.c                             |   5 +-
 builtin/interpret-trailers.c                  |   4 +-
 builtin/ls-remote.c                           |   2 +-
 builtin/merge-base.c                          |   2 +-
 builtin/pack-objects.c                        |   4 +-
 builtin/pack-redundant.c                      |   2 +-
 builtin/pack-refs.c                           |   2 +-
 builtin/read-tree.c                           |   4 +-
 builtin/rerere.c                              |   2 +-
 builtin/rev-list.c                            |   3 +-
 builtin/revert.c                              |   9 +-
 builtin/rm.c                                  |   4 +-
 builtin/send-pack.c                           |   1 +
 builtin/show-branch.c                         |   3 +-
 builtin/show-ref.c                            |   4 +-
 builtin/sparse-checkout.c                     |   2 +-
 builtin/stash.c                               |  73 +++++---
 builtin/symbolic-ref.c                        |   5 +-
 builtin/tag.c                                 |  10 +-
 builtin/unpack-file.c                         |   2 +-
 builtin/update-server-info.c                  |   2 +-
 builtin/upload-archive.c                      |   2 +-
 builtin/upload-pack.c                         |   3 +-
 builtin/verify-commit.c                       |   2 +-
 builtin/verify-pack.c                         |   2 +-
 builtin/verify-tag.c                          |   2 +-
 builtin/worktree.c                            | 110 ++++++++---
 help.c                                        |   2 +-
 t/helper/test-proc-receive.c                  |   2 +-
 t/t0450-txt-doc-vs-help.sh                    | 172 ++++++++++++++++++
 t/t0450/txt-help-mismatches                   |  58 ++++++
 82 files changed, 594 insertions(+), 199 deletions(-)
 create mode 100755 t/t0450-txt-doc-vs-help.sh
 create mode 100644 t/t0450/txt-help-mismatches

Range-diff against v4:
 1:  f76804fe9ae =  1:  cb0e2ffcd2c tests: assert *.txt SYNOPSIS and -h output
 2:  c95d3b9ad42 =  2:  998cd47045b CodingGuidelines: update and clarify command-line conventions
 3:  b7c98a40393 =  3:  dadae0d364f builtin/bundle.c: indent with tabs
 4:  522d7fbb0a3 =  4:  7c9b42d8a9b bundle: define subcommand -h in terms of command -h
 5:  ac437d4eee5 =  5:  88fdaff4f28 doc SYNOPSIS: don't use ' for subcommands
 6:  f20cbb661c6 =  6:  7a4e244b261 doc SYNOPSIS: consistently use ' for commands
 7:  ecdc14f6dfe =  7:  c31e6eba62d built-ins: consistently add "\n" between "usage" and options
 8:  1b9b6a91916 =  8:  e029f1303af doc txt & -h consistency: word-wrap
 9:  f4598ca1899 =  9:  d878b1fd91d doc txt & -h consistency: fix incorrect alternates syntax
10:  0e955f294cd = 10:  323afb78f75 doc txt & -h consistency: add "-z" to cat-file "-h"
11:  aa2f9325839 = 11:  84a81046a95 doc txt & -h consistency: balance unbalanced "[" and "]"
12:  009a0e586e9 = 12:  f5bd52cb103 doc txt & -h consistency: correct padding around "[]()"
13:  b568189532f = 13:  83d53381165 stash doc SYNOPSIS & -h: correct padding around "[]()"
14:  e5cb5c91b82 = 14:  760bc0a6727 doc txt & -h consistency: use "<options>", not "<options>..."
15:  403e7ceb449 = 15:  00b4cc7dfcc doc SYNOPSIS & -h: use "-" to separate words in labels, not "_"
16:  563ccaab6a9 ! 16:  503bd076a6b doc txt & -h consistency: fix mismatching labels
    @@ Documentation/git-clean.txt: Normally, only files unknown to Git are removed, bu
     +	Normally, when no <pathspec> is specified, git clean will not
      	recurse into untracked directories to avoid removing too much.
      	Specify -d to have it recurse into such directories as well.
    - 	If any paths are specified, -d is irrelevant; all untracked
    +-	If any paths are specified, -d is irrelevant; all untracked
    ++	If a <pathspec> is specified, -d is irrelevant; all untracked
    + 	files matching the specified paths (with exceptions for nested
    + 	git directories mentioned under `--force`) will be removed.
    + 
     
      ## Documentation/git-credential-cache--daemon.txt ##
     @@ Documentation/git-credential-cache--daemon.txt: git-credential-cache--daemon - Temporarily store user credentials in memory
17:  e6ef67f1c4f = 17:  a27ce91d9b3 doc txt & -h consistency: add or fix optional "--" syntax
18:  766bafcde05 = 18:  517ff5a4565 doc txt & -h consistency: make output order consistent
19:  fb95d7a9f86 = 19:  f5ad5f0a87f doc txt & -h consistency: add missing options and labels
20:  729029f49c3 = 20:  058b22e22f7 doc txt & -h consistency: make "rerere" consistent
21:  2d4fdbd1aa1 = 21:  2c4c48792b3 doc txt & -h consistency: make "read-tree" consistent
22:  c3d227c17c6 = 22:  c616f2e9129 doc txt & -h consistency: make "bundle" consistent
23:  02e450ea39b = 23:  1a49bbd1f6a doc txt & -h consistency: use "git foo" form, not "git-foo"
24:  430d40d3083 = 24:  bacce14d438 doc txt & -h consistency: add missing options
25:  acd6e1f2632 = 25:  89ad801409d doc txt & -h consistency: make "stash" consistent
26:  c02fc626542 = 26:  a7762e82f71 doc txt & -h consistency: make "annotate" consistent
27:  d991b9ef611 = 27:  6c68125f191 doc txt & -h consistency: use "[<label>...]" for "zero or more"
28:  dd7d2f0b167 = 28:  abaffb0b0df doc txt & -h consistency: make "diff-tree" consistent
29:  3c8154151f3 = 29:  65cd6340726 doc txt & -h consistency: make "commit" consistent
30:  2452157548b = 30:  f8f716e6ff5 reflog doc: list real subcommands up-front
31:  dbcabff3421 = 31:  fd2d358fc05 worktree: define subcommand -h in terms of command -h
32:  ea82721b057 = 32:  48c1bb97a91 doc txt & -h consistency: make "worktree" consistent
33:  a2abf7a1161 = 33:  099998e8cba tests: start asserting that *.txt SYNOPSIS matches -h output
34:  3443ae7ee6b = 34:  4de83d3d89a tests: assert consistent whitespace in -h output
-- 
2.38.0.1085.gb7e61c3016c

