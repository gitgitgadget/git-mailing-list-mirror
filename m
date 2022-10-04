Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9CAC43217
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJDNX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJDNX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:23:57 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C641A50714
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:23:53 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w18so12576631wro.7
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksbuHuNfZnRCO8cGW8tXd+tUTcnSOdCVKGpXZhKMRrs=;
        b=JCGu/H/uI1P8xWvtSUTD4p8NFWZyIH/mrW0tTW54TT0ZRkuDhBrSBiIW3DceElsEhV
         uzbGBFIHvmEGysJdbu6s5Nn/UoDZeQRB3ftDOcoQ+4gbBqURef48kRx5ulAUac3SqTH6
         64MkZGSFBW1aTCf5QUAkoK43L/w4qGrEDFv/XvegkE4Ba84j3H8AaXkFQYJUjackVm8q
         ttncfOc/UkfA15BMRnw9ydiapAdRn57TB31DPhMdkyHsdgMDgzzkp7qrk09h8YatJ4GQ
         uFr9ZUhibeTBhArXxrpvHNpvRIxc/U9JwO4naQapJzCAE3xskKjdteeC6hZYWiMyeEib
         Hm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksbuHuNfZnRCO8cGW8tXd+tUTcnSOdCVKGpXZhKMRrs=;
        b=6gmO2u4+i2FdPDaWLNwgqO/o5dKreIxuEF196hSiTIKUICfbQtPJJtcsEVdrx3NVb8
         pZCy2nQGj2atmBnlkjJFFuK6yVosKHLXOhylNwK4yqy10uroiuXmYHyv9LJk30i5CPyH
         m3mNTryvhZQqhxdfiUrB2Tmwze7bHEAVXflyTGIpuM4zw2NbZEeyOqo7raThDO80IqWU
         hRKw813UJQpKyEa5v59TvXt0umxERd3M8Hmkj9cXGfmjB80ZBNp7LBk2MqfVW7s0fOFu
         4o53xcoGInkvbnR/24Hv6Ly0Yy4naCDakBCP9QBDIX54Oyvtfe1mFvaAucuR+W2GEaQA
         tweA==
X-Gm-Message-State: ACrzQf1Wv0Auln5JUHZW55b76FjenjC28GRE33Dk00unoQ5HevdEJA6R
        XIM8SD59jMjLHUX1Ze5o7jxgVpqBbxrf6w==
X-Google-Smtp-Source: AMsMyM5GgmQ3c0A8BcG3HhTq+eCY0rCnD9VFgb0SXKGRtpIXDi9WDyR8ycTzdSDkdQX32NYFNdb7+A==
X-Received: by 2002:a05:6000:1541:b0:22a:3b77:6ef4 with SMTP id 1-20020a056000154100b0022a3b776ef4mr16147359wry.303.1664889831283;
        Tue, 04 Oct 2022 06:23:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:23:50 -0700 (PDT)
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
Subject: [PATCH v4 00/34] doc/UX: make txt & -h output more consistent
Date:   Tue,  4 Oct 2022 15:23:14 +0200
Message-Id: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I sent the first 3 patches & CL of this v4 as a "v3" in
https://lore.kernel.org/git/cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com/;
sorry. Here's the whole series, correctly labeled as v4]

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
https://lore.kernel.org/git/cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com/ [1];
For v3 see:
http://lore.kernel.org/git/cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com

Changes since v3:

 * Added a commit to put a small portion of the the new tests first,
   we then add a bit to it as we go along.

 * Squashed some changes as requested, now some of the "doc txt & -h
   consistency" commits have changes that were previously split up,
   but that's noted in the commit message.

 * Ejected the "blame" usage_msg_optf() change, instead the relevant
   later commit just supports both usage() and usage_with_options().

 * Consistently use [<options>], not "[<options...]"

 * Various squshes/fix-ups suggested by Eric & Junio, thanks both!

 * The new test now runs much faster, since we cache the "sed"
   commands that extract the "-h" and "*.txt" output

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
 Documentation/git-clean.txt                   |   8 +-
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
 82 files changed, 593 insertions(+), 198 deletions(-)
 create mode 100755 t/t0450-txt-doc-vs-help.sh
 create mode 100644 t/t0450/txt-help-mismatches

Range-diff against v3:
 -:  ----------- >  1:  f76804fe9ae tests: assert *.txt SYNOPSIS and -h output
 1:  1611913e321 =  2:  c95d3b9ad42 CodingGuidelines: update and clarify command-line conventions
 2:  b2d76494a34 =  3:  b7c98a40393 builtin/bundle.c: indent with tabs
 3:  953a72abee1 =  4:  522d7fbb0a3 bundle: define subcommand -h in terms of command -h
 4:  a8312c50f01 <  -:  ----------- blame: use a more detailed usage_msg_optf() error on bad -L
 5:  ec977f7c8fe =  5:  ac437d4eee5 doc SYNOPSIS: don't use ' for subcommands
 6:  b0ae035500c =  6:  f20cbb661c6 doc SYNOPSIS: consistently use ' for commands
 8:  e9924890620 =  7:  ecdc14f6dfe built-ins: consistently add "\n" between "usage" and options
10:  1a02f7c76cd !  8:  1b9b6a91916 doc txt & -h consistency: word-wrap
    @@ Commit message
         doc txt & -h consistency: word-wrap
     
         Change the documentation and -h output for those built-in commands
    -    where the *.txt and -h output didn't match as far as word-wrapping was
    -    concerned.
    +    where both the -h output and *.txt were lacking in word-wrapping.
    +
    +    There are many more built-ins that could use this treatment, this
    +    change is narrowed to those where this whitespace change is needed to
    +    make the -h and *.txt consistent in the end.
    +
    +    In the case of "Documentation/git-hash-object.txt" and
    +    "builtin/hash-object.c" this is not a "doc txt & -h consistency"
    +    change, as we're changing both versions, doing so here makes a
    +    subsequent change smaller.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## Documentation/git-hash-object.txt ##
    +@@ Documentation/git-hash-object.txt: git-hash-object - Compute object ID and optionally creates a blob from a file
    + SYNOPSIS
    + --------
    + [verse]
    +-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
    ++'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters]
    ++		[--stdin [--literally]] [--] <file>...
    + 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]
    + 
    + DESCRIPTION
    +
      ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: git-worktree - Manage multiple working trees
      SYNOPSIS
    @@ builtin/diagnose.c
      };
      
     
    + ## builtin/hash-object.c ##
    +@@ builtin/hash-object.c: static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
    + int cmd_hash_object(int argc, const char **argv, const char *prefix)
    + {
    + 	static const char * const hash_object_usage[] = {
    +-		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
    ++		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters]\n"
    ++		   "                [--stdin] [--] <file>..."),
    + 		"git hash-object  --stdin-paths",
    + 		NULL
    + 	};
    +
      ## builtin/init-db.c ##
     @@ builtin/init-db.c: static int shared_callback(const struct option *opt, const char *arg, int unset)
      }
 7:  829bdf58499 !  9:  f4598ca1899 doc SYNOPSIS & -h: fix incorrect alternates syntax
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    doc SYNOPSIS & -h: fix incorrect alternates syntax
    +    doc txt & -h consistency: fix incorrect alternates syntax
     
         Fix the incorrect "[-o | --option <argument>]" syntax, which should be
         "[(-o | --option) <argument>]", we were previously claiming that only
         the long option accepted the "<argument>", which isn't what we meant.
     
    -    This issue has been with us in both the "-h" and *.txt versions since
    -    bd514cada4b (stash: introduce 'git stash store', 2013-06-15).
    +    This syntax issue for "bugreport" originated in
    +    238b439d698 (bugreport: add tool to generate debugging info,
    +    2020-04-16), and for "diagnose" in 6783fd3cef0 (builtin/diagnose.c:
    +    create 'git diagnose' builtin, 2022-08-12), which copied and adjusted
    +    "bugreport" documentation and code.
     
    -    There are also issues with the alternates syntax for "bugreport" and
    -    "diagnose", but in those cases only for one of *.c or *.txt, not
    -    both. Those issues will be fixed in a subsequent "consistency" commit.
    +    In the case of "Documentation/git-stash.txt" and "builtin/stash.c"
    +    this is not a "doc txt & -h consistency" change, as we're changing
    +    both versions, doing so here makes a subsequent change smaller.
    +
    +    In that case fix the incorrect "[-o | --option <argument>]" syntax,
    +    which should be "[(-o | --option) <argument>]", we were previously
    +    claiming that only the long option accepted the "<argument>", which
    +    isn't what we meant.
    +
    +    The "stash" issue has been with us in both the "-h" and *.txt versions
    +    since bd514cada4b (stash: introduce 'git stash store', 2013-06-15).
    +
    +    We could claim that this isn't a syntax issue if a "vertical bar binds
    +    tighter than option and its argument", but such a rule would change
    +    e.g. this "cat-file" SYNOPSIS example to mean something we don't:
    +
    +            ... [<rev>:<path|tree-ish> | --path=<path|tree-ish> <rev>]
    +
    +    We have various other examples where the post-image here is already
    +    used, e.g. for "format-patch" ("-o"), "grep" ("-m"),
    +    "submodule" ("set-branch -b") etc.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/git-stash.txt: stash index (e.g. the integer `n` is equivalent to
      	Save your local modifications to a new 'stash entry' and roll them
      	back to HEAD (in the working tree and in the index).
     
    + ## builtin/bugreport.c ##
    +@@ builtin/bugreport.c: static void get_populated_hooks(struct strbuf *hook_info, int nongit)
    + }
    + 
    + static const char * const bugreport_usage[] = {
    +-	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]\n"
    ++	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
    + 	   "              [--diagnose[=<mode>]"),
    + 	NULL
    + };
    +
    + ## builtin/diagnose.c ##
    +@@
    + #include "diagnose.h"
    + 
    + static const char * const diagnose_usage[] = {
    +-	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format>]\n"
    ++	N_("git diagnose [(-o|--output-directory) <path>] [(-s|--suffix) <format>]\n"
    + 	   "             [--mode=<mode>]"),
    + 	NULL
    + };
    +
      ## builtin/stash.c ##
     @@ builtin/stash.c: static const char * const git_stash_usage[] = {
      	N_("git stash branch <branchname> [<stash>]"),
 9:  516af07e8a8 <  -:  ----------- doc SYNOPSIS & -h: word-wrap
11:  7794c3d6ef5 <  -:  ----------- doc txt & -h consistency: fix incorrect alternates syntax
12:  357a228000c = 10:  0e955f294cd doc txt & -h consistency: add "-z" to cat-file "-h"
13:  57cbaee9826 = 11:  aa2f9325839 doc txt & -h consistency: balance unbalanced "[" and "]"
14:  a29af2dcc4f = 12:  009a0e586e9 doc txt & -h consistency: correct padding around "[]()"
15:  589705cf6fa = 13:  b568189532f stash doc SYNOPSIS & -h: correct padding around "[]()"
16:  db850539d2a ! 14:  e5cb5c91b82 doc txt & -h consistency: use "<options>", not "<options>..."
    @@ Commit message
         In the case of "mv" and "sparse-checkout" let's add the missing "[]"
         to indicate that these are optional.
     
    +    In the case of "t/helper/test-proc-receive.c" there is no *.txt
    +    version, making it the only hunk in this commit that's not a "doc txt
    +    & -h consistency" change.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-mv.txt ##
    @@ builtin/sparse-checkout.c
      	NULL
      };
      
    +
    + ## t/helper/test-proc-receive.c ##
    +@@
    + #include "test-tool.h"
    + 
    + static const char *proc_receive_usage[] = {
    +-	"test-tool proc-receive [<options>...]",
    ++	"test-tool proc-receive [<options>]",
    + 	NULL
    + };
    + 
17:  041aa64f3c7 ! 15:  403e7ceb449 t/helper/test-proc-receive.c: use "<options>", not "<options>..."
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    t/helper/test-proc-receive.c: use "<options>", not "<options>..."
    +    doc SYNOPSIS & -h: use "-" to separate words in labels, not "_"
     
    -    As in a preceding commit use "<options>", not "<options>...", in this
    -    case there is no *.txt version, but let's fix this one too while we're
    -    at it.
    +    Change "builtin/credential-cache--daemon.c" to use "<socket-path>" not
    +    "<socket_path>" in a placeholder label, almost all of our
    +    documentation uses this form.
    +
    +    This is now consistent with the "If a placeholder has multiple words,
    +    they are separated by dashes" guideline added in
    +    9c9b4f2f8b7 (standardize usage info string format, 2015-01-13), let's
    +    add a now-passing test to assert that that's the case.
    +
    +    To do this we need to introduce a very sed-powered parser to extract
    +    the SYNOPSIS from the *.txt, and handle not all commands with "-h"
    +    having a corresponding *.txt (e.g. "bisect--helper"). We'll still want
    +    to handle syntax edge cases in the *.txt in subsequent commits for
    +    other checks, but let's do that then.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/helper/test-proc-receive.c ##
    -@@
    - #include "test-tool.h"
    + ## builtin/credential-cache--daemon.c ##
    +@@ builtin/credential-cache--daemon.c: int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
    + 	const char *socket_path;
    + 	int ignore_sighup = 0;
    + 	static const char *usage[] = {
    +-		"git-credential-cache--daemon [opts] <socket_path>",
    ++		"git-credential-cache--daemon [opts] <socket-path>",
    + 		NULL
    + 	};
    + 	int debug = 0;
    +
    + ## t/t0450-txt-doc-vs-help.sh ##
    +@@ t/t0450-txt-doc-vs-help.sh: help_to_synopsis () {
    + 	echo "$out"
    + }
    + 
    ++builtin_to_txt () {
    ++       echo "$GIT_BUILD_DIR/Documentation/git-$1.txt"
    ++}
    ++
    ++txt_to_synopsis () {
    ++	builtin="$1" &&
    ++	out_dir="out/$builtin" &&
    ++	out="$out_dir/txt.synopsis" &&
    ++	if test -f "$out"
    ++	then
    ++		echo "$out" &&
    ++		return 0
    ++	fi &&
    ++	b2t="$(builtin_to_txt "$builtin")" &&
    ++	sed -n \
    ++		-e '/^\[verse\]$/,/^$/ {
    ++			/^$/d;
    ++			/^\[verse\]$/d;
    ++
    ++			p;
    ++		}' \
    ++		<"$b2t" >"$out" &&
    ++	echo "$out"
    ++}
    ++
    ++check_dashed_labels () {
    ++	! grep -E "<[^>_-]+_" "$1"
    ++}
    ++
    + HT="	"
      
    - static const char *proc_receive_usage[] = {
    --	"test-tool proc-receive [<options>...]",
    -+	"test-tool proc-receive [<options>]",
    - 	NULL
    - };
    + while read builtin
    +@@ t/t0450-txt-doc-vs-help.sh: do
    + 		h2s="$(help_to_synopsis "$builtin")" &&
    + 		! grep "$HT" "$h2s"
    + 	'
    ++
    ++	test_expect_success "$builtin -h output has dashed labels" '
    ++		check_dashed_labels "$(help_to_synopsis "$builtin")"
    ++	'
    ++
    ++	txt="$(builtin_to_txt "$builtin")" &&
    ++	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
    ++
    ++	if test -f "$txt"
    ++	then
    ++		test_set_prereq "$preq"
    ++	fi &&
    ++
    ++	# *.txt output assertions
    ++	test_expect_success "$preq" "$builtin *.txt SYNOPSIS has dashed labels" '
    ++		check_dashed_labels "$(txt_to_synopsis "$builtin")"
    ++	'
    + done <builtins
      
    + test_done
18:  3a439c4401d ! 16:  563ccaab6a9 doc txt & -h consistency: fix mismatching labels
    @@ Commit message
         corresponding -h output where our translatable labels didn't match
         up.
     
    +    In some cases we need to adjust the prose that follows the SYNOPSIS
    +    accordingly, as it refers back to the changed label.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-clean.txt ##
    @@ Documentation/git-clean.txt: Normally, only files unknown to Git are removed, bu
      example, be useful to remove all build products.
      
     -If any optional `<path>...` arguments are given, only those paths
    +-are affected.
     +If any optional `<pathspec>...` arguments are given, only those paths
    - are affected.
    ++that match the pathspec are affected.
      
      OPTIONS
      -------
    @@ Documentation/git-credential-cache--daemon.txt: git-credential-cache--daemon - T
      
      DESCRIPTION
      -----------
    +@@ Documentation/git-credential-cache--daemon.txt: DESCRIPTION
    + NOTE: You probably don't want to invoke this command yourself; it is
    + started automatically when you use linkgit:git-credential-cache[1].
    + 
    +-This command listens on the Unix domain socket specified by `<socket>`
    ++This command listens on the Unix domain socket specified by `<socket-path>`
    + for `git-credential-cache` clients. Clients may store and retrieve
    + credentials. Each credential is held for a timeout specified by the
    + client; once no credentials are held, the daemon exits.
     
      ## Documentation/git-mv.txt ##
     @@ Documentation/git-mv.txt: git-mv - Move or rename a file, a directory, or a symlink
    @@ Documentation/git-mv.txt: git-mv - Move or rename a file, a directory, or a syml
      
      DESCRIPTION
      -----------
    +@@ Documentation/git-mv.txt: OPTIONS
    + -------
    + -f::
    + --force::
    +-	Force renaming or moving of a file even if the target exists
    ++	Force renaming or moving of a file even if the <destination> exists.
    + -k::
    + 	Skip move or rename actions which would lead to an error
    + 	condition. An error happens when a source is neither existing nor
     
      ## Documentation/git-receive-pack.txt ##
     @@ Documentation/git-receive-pack.txt: git-receive-pack - Receive what is pushed into the repository
    @@ Documentation/git-receive-pack.txt: git-receive-pack - Receive what is pushed in
      
      DESCRIPTION
      -----------
    +@@ Documentation/git-receive-pack.txt: its behavior, see linkgit:git-config[1].
    + 
    + OPTIONS
    + -------
    +-<directory>::
    ++<git-dir>::
    + 	The repository to sync into.
    + 
    + --http-backend-info-refs::
     
      ## Documentation/git-tag.txt ##
     @@ Documentation/git-tag.txt: git-tag - Create, list, delete or verify a tag object signed with GPG
    @@ Documentation/git-tag.txt: git-tag - Create, list, delete or verify a tag object
      	<tagname> [<commit> | <object>]
      'git tag' -d <tagname>...
      'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
    +@@ Documentation/git-tag.txt: to delete, list or verify tags.
    + 
    + Unless `-f` is given, the named tag must not yet exist.
    + 
    +-If one of `-a`, `-s`, or `-u <keyid>` is passed, the command
    ++If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
    + creates a 'tag' object, and requires a tag message.  Unless
    + `-m <msg>` or `-F <file>` is given, an editor is started for the user to type
    + in the tag message.
    + 
    +-If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <keyid>`
    ++If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <key-id>`
    + are absent, `-a` is implied.
    + 
    + Otherwise, a tag reference that points directly at the given object
    + (i.e., a lightweight tag) is created.
    + 
    + A GnuPG signed tag object will be created when `-s` or `-u
    +-<keyid>` is used.  When `-u <keyid>` is not used, the
    ++<key-id>` is used.  When `-u <key-id>` is not used, the
    + committer identity for the current user is used to find the
    + GnuPG key for signing. 	The configuration variable `gpg.program`
    + is used to specify custom GnuPG binary.
    +@@ Documentation/git-tag.txt: OPTIONS
    + 	Override `tag.gpgSign` configuration variable that is
    + 	set to force each and every tag to be signed.
    + 
    +--u <keyid>::
    +---local-user=<keyid>::
    ++-u <key-id>::
    ++--local-user=<key-id>::
    + 	Make a GPG-signed tag, using the given key.
    + 
    + -f::
    +@@ Documentation/git-tag.txt: This option is only applicable when listing tags without annotation lines.
    + 	Use the given tag message (instead of prompting).
    + 	If multiple `-m` options are given, their values are
    + 	concatenated as separate paragraphs.
    +-	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
    ++	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
    + 	is given.
    + 
    + -F <file>::
    + --file=<file>::
    + 	Take the tag message from the given file.  Use '-' to
    + 	read the message from the standard input.
    +-	Implies `-a` if none of `-a`, `-s`, or `-u <keyid>`
    ++	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
    + 	is given.
    + 
    + -e::
    +@@ Documentation/git-tag.txt: it in the repository configuration as follows:
    + 
    + -------------------------------------
    + [user]
    +-    signingKey = <gpg-keyid>
    ++    signingKey = <gpg-key_id>
    + -------------------------------------
    + 
    + `pager.tag` is only respected when listing tags, i.e., when `-l` is
     
      ## Documentation/git-upload-archive.txt ##
     @@ Documentation/git-upload-archive.txt: git-upload-archive - Send archive back to git-archive
    @@ builtin/commit-graph.c
      	   "                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]\n" \
      	   "                       <split options>")
     
    - ## builtin/credential-cache--daemon.c ##
    -@@ builtin/credential-cache--daemon.c: int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
    - 	const char *socket_path;
    - 	int ignore_sighup = 0;
    - 	static const char *usage[] = {
    --		"git-credential-cache--daemon [opts] <socket_path>",
    -+		"git-credential-cache--daemon [opts] <socket-path>",
    - 		NULL
    - 	};
    - 	int debug = 0;
    -
      ## builtin/for-each-repo.c ##
     @@
      #include "string-list.h"
19:  3bfdd3fb79e ! 17:  e6ef67f1c4f doc txt & -h consistency: add or fix optional "--" syntax
    @@ Commit message
         inconsistent, or where we incorrectly stated in one but not the other
         that the "--" was mandatory.
     
    +    In the case of "rev-list" both sides were wrong, as we we don't
    +    require one or more paths if "--" is used, e.g. this is OK:
    +
    +            git rev-list HEAD --
    +
    +    That part of this change is not a "doc txt & -h consistency" change,
    +    as we're changing both versions, doing so here makes both sides
    +    consistent.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## Documentation/git-rev-list.txt ##
    +@@ Documentation/git-rev-list.txt: git-rev-list - Lists commit objects in reverse chronological order
    + SYNOPSIS
    + --------
    + [verse]
    +-'git rev-list' [<options>] <commit>... [[--] <path>...]
    ++'git rev-list' [<options>] <commit>... [--] [<path>...]
    + 
    + DESCRIPTION
    + -----------
    +
      ## builtin/for-each-repo.c ##
     @@
      #include "string-list.h"
    @@ builtin/rev-list.c
      
      static const char rev_list_usage[] =
     -"git rev-list [<options>] <commit>... [-- <path>...]\n"
    -+"git rev-list [<options>] <commit>... [[--] <path>...]\n"
    ++"git rev-list [<options>] <commit>... [--] [<path>...]\n"
      "\n"
      "  limiting output:\n"
      "    --max-count=<n>\n"
20:  98bdd0353cf = 18:  766bafcde05 doc txt & -h consistency: make output order consistent
21:  1713227d497 ! 19:  fb95d7a9f86 doc txt & -h consistency: add missing options and labels
    @@ Commit message
          * We said "opts" or "options", but could instead enumerate
            the (small) set of supported options
     
    -     * argument labels were missing entirely (ls-remote)
    +     * Options that were missing entirely (ls-remote's --sort=<key>)
     
    -     * How we referred to an argument was inconsistent between the two,
    -       e.g. <pack> v.s. <pack>.idx.
    +       As we can specify "--sort" multiple times (it's backed by a
    +       string-list" it should really be "[(--sort=<key>)...]", which is
    +       what "git for-each-ref" lists it as, but let's leave that issue for
    +       a subsequent cleanup, and stop at making these consistent. Other
    +       "ref-filter.h" users share the same issue, e.g. "git-branch.txt".
    +
    +     * For "verify-tag" and "verify-commit" we were missing the "--raw"
    +       option.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/git-update-server-info.txt: $GIT_OBJECT_DIRECTORY/info directories
     +-------
     +-f::
     +--force::
    -+	Allow adding otherwise ignored files.
    ++	update the info files from scratch.
     +
      OUTPUT
      ------
    @@ Documentation/git-verify-commit.txt: git-verify-commit - Check the GPG signature
      --------
      [verse]
     -'git verify-commit' <commit>...
    -+'git verify-commit' [-v | --verbose] <commit>...
    ++'git verify-commit' [-v | --verbose] [--raw] <commit>...
      
      DESCRIPTION
      -----------
    @@ Documentation/git-verify-tag.txt: git-verify-tag - Check the GPG signature of ta
      --------
      [verse]
     -'git verify-tag' [--format=<format>] <tag>...
    -+'git verify-tag' [-v | --verbose] [--format=<format>] <tag>...
    ++'git verify-tag' [-v | --verbose] [--format=<format>] [--raw] <tag>...
      
      DESCRIPTION
      -----------
    @@ builtin/upload-pack.c
      };
      
     
    + ## builtin/verify-commit.c ##
    +@@
    + #include "gpg-interface.h"
    + 
    + static const char * const verify_commit_usage[] = {
    +-		N_("git verify-commit [-v | --verbose] <commit>..."),
    ++		N_("git verify-commit [-v | --verbose] [--raw] <commit>..."),
    + 		NULL
    + };
    + 
    +
    + ## builtin/verify-tag.c ##
    +@@
    + #include "ref-filter.h"
    + 
    + static const char * const verify_tag_usage[] = {
    +-		N_("git verify-tag [-v | --verbose] [--format=<format>] <tag>..."),
    ++		N_("git verify-tag [-v | --verbose] [--format=<format>] [--raw] <tag>..."),
    + 		NULL
    + };
    + 
    +
      ## help.c ##
     @@ help.c: int cmd_version(int argc, const char **argv, const char *prefix)
      	struct strbuf buf = STRBUF_INIT;
22:  702eb747c0f = 20:  729029f49c3 doc txt & -h consistency: make "rerere" consistent
23:  01e20b8e452 ! 21:  2d4fdbd1aa1 doc txt & -h consistency: make "read-tree" consistent
    @@ Metadata
      ## Commit message ##
         doc txt & -h consistency: make "read-tree" consistent
     
    -    The C version was right to use "()" in place of "[]", let's update
    -    the *.txt version accordingly, and furthermore list the *.c options in
    -    the same order as the *.txt.
    +    The C version was right to use "()" in place of "[]" around the option
    +    listing, let's update the *.txt version accordingly, and furthermore
    +    list the *.c options in the same order as the *.txt.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
24:  7f93da79fee = 22:  c3d227c17c6 doc txt & -h consistency: make "bundle" consistent
25:  ab109f73264 ! 23:  02e450ea39b doc txt & -h consistency: use "git foo" form, not "git-foo"
    @@ Commit message
         Use the "git cmd" form instead of "git-cmd" for both "git
         receive-pack" and "git credential-cache--daemon".
     
    +    For "git-receive-pack" we do have a binary with that name, even when
    +    installed with SKIP_DASHED_BUILT_INS=YesPlease, but for the purposes
    +    of the SYNOPSIS let's use the "git cmd" form like everywhere else. It
    +    can be invoked like that (and our tests do so), the parts of our
    +    documentation that explain when you need to use the dashed form do so,
    +    and use it.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-receive-pack.txt ##
26:  d57635b2707 = 24:  430d40d3083 doc txt & -h consistency: add missing options
27:  ac959d0cfc1 = 25:  acd6e1f2632 doc txt & -h consistency: make "stash" consistent
28:  f617375ea9e ! 26:  c02fc626542 doc txt & -h consistency: make "annotate" consistent
    @@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
      	long anchor;
      	const int hexsz = the_hash_algo->hexsz;
      	long num_lines = 0;
    -+	const char **usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
    ++	const char *str_usage = cmd_is_annotate ? annotate_usage : blame_usage;
    ++	const char **opt_usage = cmd_is_annotate ? annotate_opt_usage : blame_opt_usage;
      
      	setup_default_color_by_age();
      	git_config(git_blame_config, &output_option);
    @@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
      			    PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
      	for (;;) {
     -		switch (parse_options_step(&ctx, options, blame_opt_usage)) {
    -+		switch (parse_options_step(&ctx, options, usage)) {
    ++		switch (parse_options_step(&ctx, options, opt_usage)) {
      		case PARSE_OPT_NON_OPTION:
      		case PARSE_OPT_UNKNOWN:
      			break;
    @@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
      			reverse = 1;
      		}
     -		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
    -+		parse_revision_opt(&revs, &ctx, options, usage);
    ++		parse_revision_opt(&revs, &ctx, options, opt_usage);
      	}
      parse_done:
      	revision_opts_finish(&revs);
    @@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
      		case 2: /* (1b) */
      			if (argc != 4)
     -				usage_with_options(blame_opt_usage, options);
    -+				usage_with_options(usage, options);
    ++				usage_with_options(opt_usage, options);
      			/* reorder for the new way: <rev> -- <path> */
      			argv[1] = argv[3];
      			argv[3] = argv[2];
    @@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
      			break;
      		default:
     -			usage_with_options(blame_opt_usage, options);
    -+			usage_with_options(usage, options);
    ++			usage_with_options(opt_usage, options);
      		}
      	} else {
      		if (argc < 2)
     -			usage_with_options(blame_opt_usage, options);
    -+			usage_with_options(usage, options);
    ++			usage_with_options(opt_usage, options);
      		if (argc == 3 && is_a_rev(argv[argc - 1])) { /* (2b) */
      			path = add_prefix(prefix, argv[1]);
      			argv[1] = argv[2];
     @@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
    + 				    nth_line_cb, &sb, lno, anchor,
      				    &bottom, &top, sb.path,
      				    the_repository->index))
    - 			usage_msg_optf(_("failed to parse -L argument '%s'"),
    --				       blame_opt_usage, options, arg);
    -+				       usage, options, arg);
    +-			usage(blame_usage);
    ++			usage(str_usage);
      		if ((!lno && (top || bottom)) || lno < bottom)
      			die(Q_("file %s has only %lu line",
      			       "file %s has only %lu lines",
29:  c96c3fc6d8d = 27:  d991b9ef611 doc txt & -h consistency: use "[<label>...]" for "zero or more"
30:  34b778dd176 = 28:  dd7d2f0b167 doc txt & -h consistency: make "diff-tree" consistent
31:  336fc749f1c = 29:  3c8154151f3 doc txt & -h consistency: make "commit" consistent
32:  81024d1c3cd = 30:  2452157548b reflog doc: list real subcommands up-front
33:  76e6b7d296a = 31:  dbcabff3421 worktree: define subcommand -h in terms of command -h
34:  efd0c2c634d = 32:  ea82721b057 doc txt & -h consistency: make "worktree" consistent
35:  22da68abce3 ! 33:  a2abf7a1161 tests: start asserting that *.txt SYNOPSIS matches -h output
    @@ Commit message
         testing.
     
         This adds such regression testing, we can parse out the SYNOPSIS
    -    output with "sed", and is turns out it's relatively easy to normalize
    +    output with "sed", and it turns out it's relatively easy to normalize
         it and the "-h" output to match on another.
     
         We now ensure that we won't have regressions when it comes to the list
    @@ Commit message
            "builtin_log_usage" in builtin/log.c doesn't take into account what
            command we're running.
     
    -     * Likewise "git stage -h" shows "git add" usage, but should be aware
    -       of what command it's running. The same for "annotate" and "blame".
    -
          * Commands which implement subcommands such as like
            "multi-pack-index", "notes", "remote" etc. having their subcommands
            in a very different order in the *.txt and *.c. Fixing it would
    -       require some verbose diffs, so it's been left alone for onw.
    +       require some verbose diffs, so it's been left alone for now.
     
          * Commands such as "format-patch" have a very long argument list in
            the *.txt, but just "[<options>]" in the *.c.
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## t/t0450-txt-doc-vs-help.sh (new) ##
    + ## t/t0450-txt-doc-vs-help.sh ##
     @@
    -+#!/bin/sh
    -+
    -+test_description='compare (unbuilt) Documentation/*.txt to -h output
    + #!/bin/sh
    + 
    +-test_description='assert (unbuilt) Documentation/*.txt and -h output'
    ++test_description='assert (unbuilt) Documentation/*.txt and -h output
     +
     +Run this with --debug to see a summary of where we still fail to make
     +the two versions consistent with one another.'
    -+
    -+. ./test-lib.sh
    -+
    -+test_expect_success 'setup: list of builtins' '
    -+	git --list-cmds=builtins >builtins
    -+'
    -+
    + 
    + TEST_PASSES_SANITIZE_LEAK=true
    + . ./test-lib.sh
    +@@ t/t0450-txt-doc-vs-help.sh: test_expect_success 'setup: list of builtins' '
    + 	git --list-cmds=builtins >builtins
    + '
    + 
     +test_expect_success 'list of txt and help mismatches is sorted' '
     +	sort -u "$TEST_DIRECTORY"/t0450/txt-help-mismatches >expect &&
     +	if ! test_cmp expect "$TEST_DIRECTORY"/t0450/txt-help-mismatches
    @@ t/t0450-txt-doc-vs-help.sh (new)
     +	fi
     +'
     +
    -+builtin_to_synopsis () {
    -+	builtin="$1" &&
    -+	test_when_finished "rm -f out" &&
    -+	test_expect_code 129 git $builtin -h >out 2>&1 &&
    -+	sed -n \
    -+		-e '1,/^$/ {
    -+			/^$/d;
    -+			s/^usage: //;
    -+			s/^ *or: //;
    -+			p;
    -+		}' <out
    -+}
    -+
    -+builtin_to_txt () {
    -+	echo "$GIT_BUILD_DIR/Documentation/git-$1.txt"
    -+}
    -+
    -+txt_synopsis () {
    -+	sed -n \
    -+		-e '/^\[verse\]$/,/^$/ {
    -+			/^$/d;
    -+			/^\[verse\]$/d;
    + help_to_synopsis () {
    + 	builtin="$1" &&
    + 	out_dir="out/$builtin" &&
    +@@ t/t0450-txt-doc-vs-help.sh: txt_to_synopsis () {
    + 			/^$/d;
    + 			/^\[verse\]$/d;
    + 
     +			s/{litdd}/--/g;
    -+
     +			s/'\''\(git[ a-z-]*\)'\''/\1/g;
    -+			p;
    -+		}' \
    -+		<"$1"
    -+}
     +
    -+HT="	"
    + 			p;
    + 		}' \
    + 		<"$b2t" >"$out" &&
    +@@ t/t0450-txt-doc-vs-help.sh: check_dashed_labels () {
    + 
    + HT="	"
    + 
     +align_after_nl () {
     +	builtin="$1" &&
     +	len=$(printf "git %s " "$builtin" | wc -c) &&
    @@ t/t0450-txt-doc-vs-help.sh (new)
     +}
     +
     +test_debug '>failing'
    -+while read builtin
    -+do
    -+	test_expect_success "$builtin -h output has no \t" '
    -+		builtin_to_synopsis "$builtin" >help.raw &&
    -+		! grep "$HT" help.raw
    -+	'
    -+
    -+	txt="$(builtin_to_txt "$builtin")" &&
    -+	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
    -+
    -+	if test -f "$txt"
    -+	then
    -+		test_set_prereq "$preq"
    -+	fi &&
    -+
    + while read builtin
    + do
    + 	# -h output assertions
    +@@ t/t0450-txt-doc-vs-help.sh: do
    + 	test_expect_success "$preq" "$builtin *.txt SYNOPSIS has dashed labels" '
    + 		check_dashed_labels "$(txt_to_synopsis "$builtin")"
    + 	'
    ++
    ++	# *.txt output consistency assertions
     +	result=
     +	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/txt-help-mismatches
     +	then
    @@ t/t0450-txt-doc-vs-help.sh (new)
     +	else
     +		result=success
     +	fi &&
    -+
     +	test_expect_$result "$preq" "$builtin -h output and SYNOPSIS agree" '
    -+		txt_synopsis "$txt" >txt.raw &&
    ++		t2s="$(txt_to_synopsis "$builtin")" &&
     +		if test "$builtin" = "merge-tree"
     +		then
    -+			sed -e '\''s/ (deprecated)$//g'\'' <txt.raw >txt.raw.new &&
    -+			mv txt.raw.new txt.raw
    ++			test_when_finished "rm -f t2s.new" &&
    ++			sed -e '\''s/ (deprecated)$//g'\'' <"$t2s" >t2s.new
    ++			t2s=t2s.new
     +		fi &&
    -+		builtin_to_synopsis "$builtin" >help.raw &&
    ++		h2s="$(help_to_synopsis "$builtin")" &&
     +
     +		# The *.txt and -h use different spacing for the
     +		# alignment of continued usage output, normalize it.
    -+		align_after_nl "$builtin" <txt.raw >txt &&
    -+		align_after_nl "$builtin" <help.raw >help &&
    ++		align_after_nl "$builtin" <"$t2s" >txt &&
    ++		align_after_nl "$builtin" <"$h2s" >help &&
     +		test_cmp txt help
     +	'
     +
    @@ t/t0450-txt-doc-vs-help.sh (new)
     +		# used with --debug
     +		rm -f txt help tmp 2>/dev/null
     +	fi
    -+done <builtins
    -+
    + done <builtins
    + 
     +test_debug 'say "$(cat failing)"'
     +
    -+test_done
    + test_done
     
      ## t/t0450/txt-help-mismatches (new) ##
     @@
36:  b56113dd620 ! 34:  3443ae7ee6b tests: assert consistent whitespace in -h output
    @@ Commit message
                        [...]
                [--create-reflog] [...]
     
    -    Which should instead be like this instead, i.e. the options lines
    -    should be aligned:
    +    Which should instead be like this, i.e. the options lines should be
    +    aligned:
     
            [...]
            or: git tag [-n[<num>]]
    @@ Commit message
     
      ## t/t0450-txt-doc-vs-help.sh ##
     @@ t/t0450-txt-doc-vs-help.sh: do
    - 		! grep "$HT" help.raw
    + 		check_dashed_labels "$(help_to_synopsis "$builtin")"
      	'
      
     +	test_expect_success "$builtin -h output has consistent spacing" '
    -+		builtin_to_synopsis "$builtin" >help.raw &&
    ++		h2s="$(help_to_synopsis "$builtin")" &&
     +		sed -n \
     +			-e "/^ / {
     +				s/[^ ].*//;
     +				p;
     +			}" \
    -+			<help.raw >help &&
    ++			<"$h2s" >help &&
     +		sort -u help >help.ws &&
     +		if test -s help.ws
     +		then
-- 
2.38.0.rc2.935.g6b421ae1592

