Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC95C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiI3SIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiI3SIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:08:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B1C1E2FF2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h7so7976617wru.10
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DuMOpHooTuYNQ5Cz0ZA9yyN1+mhYkif/IXAazSinc/g=;
        b=kKCLXfqHVSAdI/3Wbs3eUTLOsc+aTvCgFazWNWAz3fE48Heybkx/zT2bqEdOqdjSyL
         uBjnR/FK+24WwxcEA6/JzbWhV98jjllolMLQY28VJXq8Atco8qsRNBl5cxao7aCwlOn/
         EXTXeKkhXjPK9QHPHENqeKU3v3Ehm01xZtoTtCWVjgihj33JB8my1To2v7BTGSaHTCb4
         zW4g4FEBDBC2EW4vJ3bvKU++Nmr4vpoPs2sMc/q6BRNKsHudc25wlMo3pyz8SIjVblOz
         hkaOgV2FtrYfELp4m/mhFCZ9iEG+NpZlTqaWCstrn0kdkyIfR33H6dgVoZNQ7HnsYR8M
         us2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DuMOpHooTuYNQ5Cz0ZA9yyN1+mhYkif/IXAazSinc/g=;
        b=WgYBcDD8jVYV0TQ4dsgaYeUUBdfTXZ19CDMSr71NqOdOJ2QAhgYMG4yEc6GYiUTXLL
         hi08PwCpuTGN3VZEjGovPIkVME4aWlgdXk3aGhKPD45rY5OrCoJklKnxe13h3yjfY/b4
         8bLNnvramCAoHhhRsjYfEYlEdTmszGpjnRyzFjRzaOLT8ckK/YLrfku5J9e3zc0N05Sb
         5/UOhFU7PL7Zv6xJWUoZ/bpXZdcgzVyYYWOzFvwSB66qkzP9wSyYwI5itv5EDO9qSN5f
         dzOWVAo7L9e4T84rtl7TRgQofqksjB5C8SHwGGlChw4r7nPtV34SVraPfP8Rg98btEf9
         2nQw==
X-Gm-Message-State: ACrzQf3VCahrTD46ra23s8U75T9UzoySm577jK4Ut7e7vQH7UcJ7FRi1
        dx7DOaoRPDKxSyUhb62PUyhWq0P9nnzYpw==
X-Google-Smtp-Source: AMsMyM7a7MiiiGNAROcMGHKFm418R9vvvN0EOw+bXR/Lph5cmoDor46jCEaM80sCEK5gEvXTqdd17g==
X-Received: by 2002:a5d:4a01:0:b0:21d:8ce1:8b6d with SMTP id m1-20020a5d4a01000000b0021d8ce18b6dmr6595054wrq.718.1664561286921;
        Fri, 30 Sep 2022 11:08:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:02 -0700 (PDT)
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
Subject: [PATCH v3 00/36] doc/UX: make txt & -h output more consistent
Date:   Fri, 30 Sep 2022 20:07:23 +0200
Message-Id: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
https://lore.kernel.org/git/cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com/;
For v2 see:
https://lore.kernel.org/git/cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com/

Changes since v2:

 * Numerous issues raised by Eric Sunshine, thanks a lot! I believe
   this re-roll addresses all of them.

 * The 1/36 commit message attempts to explain the --foo=(x|y)
   v.s. (--foo | --bar) whitespace inconsistency.

 * The list of command mismatches is now a file at
   t/t0450/txt-help-mismatches, instead of being embedded in the test
   (per Junio's request).

Ævar Arnfjörð Bjarmason (36):
  CodingGuidelines: update and clarify command-line conventions
  builtin/bundle.c: indent with tabs
  bundle: define subcommand -h in terms of command -h
  blame: use a more detailed usage_msg_optf() error on bad -L
  doc SYNOPSIS: don't use ' for subcommands
  doc SYNOPSIS: consistently use ' for commands
  doc SYNOPSIS & -h: fix incorrect alternates syntax
  built-ins: consistently add "\n" between "usage" and options
  doc SYNOPSIS & -h: word-wrap
  doc txt & -h consistency: word-wrap
  doc txt & -h consistency: fix incorrect alternates syntax
  doc txt & -h consistency: add "-z" to cat-file "-h"
  doc txt & -h consistency: balance unbalanced "[" and "]"
  doc txt & -h consistency: correct padding around "[]()"
  stash doc SYNOPSIS & -h: correct padding around "[]()"
  doc txt & -h consistency: use "<options>", not "<options>..."
  t/helper/test-proc-receive.c: use "<options>", not "<options>..."
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
 Documentation/git-clean.txt                   |   6 +-
 Documentation/git-commit-graph.txt            |   5 +-
 .../git-credential-cache--daemon.txt          |   2 +-
 Documentation/git-diff-files.txt              |   2 +-
 Documentation/git-fast-export.txt             |   2 +-
 Documentation/git-hash-object.txt             |   3 +-
 Documentation/git-interpret-trailers.txt      |   5 +-
 Documentation/git-merge-base.txt              |   4 +-
 Documentation/git-mv.txt                      |   2 +-
 Documentation/git-pack-redundant.txt          |   2 +-
 Documentation/git-prune-packed.txt            |   2 +-
 Documentation/git-read-tree.txt               |   2 +-
 Documentation/git-receive-pack.txt            |   2 +-
 Documentation/git-reflog.txt                  |  17 +--
 Documentation/git-rerere.txt                  |   2 +-
 Documentation/git-send-pack.txt               |   5 +-
 Documentation/git-show-branch.txt             |   4 +-
 Documentation/git-show-ref.txt                |   4 +-
 Documentation/git-sparse-checkout.txt         |   2 +-
 Documentation/git-stash.txt                   |  17 ++-
 Documentation/git-status.txt                  |   2 +-
 Documentation/git-tag.txt                     |   2 +-
 Documentation/git-update-server-info.txt      |   8 +-
 Documentation/git-upload-archive.txt          |   4 +-
 Documentation/git-var.txt                     |   2 +-
 Documentation/git-verify-commit.txt           |   2 +-
 Documentation/git-verify-pack.txt             |   2 +-
 Documentation/git-verify-tag.txt              |   2 +-
 Documentation/git-worktree.txt                |   3 +-
 builtin/blame.c                               |  26 ++--
 builtin/bugreport.c                           |   3 +-
 builtin/bundle.c                              |  38 +++--
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
 builtin/stash.c                               |  73 ++++++----
 builtin/symbolic-ref.c                        |   5 +-
 builtin/tag.c                                 |  10 +-
 builtin/unpack-file.c                         |   2 +-
 builtin/update-server-info.c                  |   2 +-
 builtin/upload-archive.c                      |   2 +-
 builtin/upload-pack.c                         |   3 +-
 builtin/verify-pack.c                         |   2 +-
 builtin/worktree.c                            | 110 ++++++++++----
 help.c                                        |   2 +-
 t/helper/test-proc-receive.c                  |   2 +-
 t/t0450-txt-doc-vs-help.sh                    | 136 ++++++++++++++++++
 t/t0450/txt-help-mismatches                   |  58 ++++++++
 79 files changed, 544 insertions(+), 185 deletions(-)
 create mode 100755 t/t0450-txt-doc-vs-help.sh
 create mode 100644 t/t0450/txt-help-mismatches

Range-diff against v2:
 1:  aecd3ff41f2 !  1:  1611913e321 CodingGuidelines: update and clarify command-line conventions
    @@ Commit message
            alternatives, this is not a new policy, but just codifies what's
            already the pattern in the most wide use in the documentation.
     
    +    Having a space around " | " for flags, but not for flag values is
    +    inconsistent, but this style guide codifies existing
    +    patterns. Grepping shows that we don't have any instance matching the
    +    second "Don't" example:
    +
    +            git grep -E -h -o '=\([^)]+\)' -- builtin Documentation/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/CodingGuidelines ##
 2:  63145b58504 !  2:  b2d76494a34 builtin/bundle.c: use \t, not fix indentation 2-SP indentation
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    builtin/bundle.c: use \t, not fix indentation 2-SP indentation
    +    builtin/bundle.c: indent with tabs
     
         Fix indentation issues introduced with 73c3253d75e (bundle: framework
         for options before bundle file, 2019-11-10), and carried forward in
 3:  6bcfab04cbe =  3:  953a72abee1 bundle: define subcommand -h in terms of command -h
 4:  707cf48a900 =  4:  a8312c50f01 blame: use a more detailed usage_msg_optf() error on bad -L
 5:  ad0216f798e =  5:  ec977f7c8fe doc SYNOPSIS: don't use ' for subcommands
 6:  adc18d392b5 =  6:  b0ae035500c doc SYNOPSIS: consistently use ' for commands
 7:  3531d531a3f =  7:  829bdf58499 doc SYNOPSIS & -h: fix incorrect alternates syntax
 8:  4c68003904f !  8:  e9924890620 built-ins: consistently add "\n" between "usage" and options
    @@ Commit message
     
         As we'll see in a subsequent commit this also helps to make the "git
         <cmd> -h" output more easily machine-readable, as we can assume that
    -    the usage usage information is separated from the options by an empty
    -    line.
    +    the usage information is separated from the options by an empty line.
    +
    +    Note that "COMMON_DIFF_OPTIONS_HELP" starts with a "\n", so the
    +    seeming omission of a "\n" here is correct, the second one is provided
    +    by the macro.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 -:  ----------- >  9:  516af07e8a8 doc SYNOPSIS & -h: word-wrap
 9:  a7d57827067 ! 10:  1a02f7c76cd doc txt & -h consistency: word-wrap
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## Documentation/git-hash-object.txt ##
    -@@ Documentation/git-hash-object.txt: git-hash-object - Compute object ID and optionally creates a blob from a file
    - SYNOPSIS
    - --------
    - [verse]
    --'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
    -+'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters]
    -+		[--stdin [--literally]] [--] <file>...
    - 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]
    - 
    - DESCRIPTION
    -
      ## Documentation/git-worktree.txt ##
     @@ Documentation/git-worktree.txt: git-worktree - Manage multiple working trees
      SYNOPSIS
10:  93e63821bc6 = 11:  7794c3d6ef5 doc txt & -h consistency: fix incorrect alternates syntax
11:  aaa36012fa2 = 12:  357a228000c doc txt & -h consistency: add "-z" to cat-file "-h"
12:  6501b9d1ecc ! 13:  57cbaee9826 doc txt & -h consistency: add missing "]" to bugreport "-h"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    doc txt & -h consistency: add missing "]" to bugreport "-h"
    +    doc txt & -h consistency: balance unbalanced "[" and "]"
     
         Fix a "-h" output syntax issue introduced when "--diagnose" was added
         in aac0e8ffeee (builtin/bugreport.c: create '--diagnose' option,
         2022-08-12): We need to close the "[" we opened. The
         corresponding *.txt change did not have the same issue.
     
    +    The "help -h" output then had one "]" too many, which is an issue
    +    introduced in b40845293b5 (help: correct the usage string in -h and
    +    documentation, 2021-09-10).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/bugreport.c ##
    @@ builtin/bugreport.c: static void get_populated_hooks(struct strbuf *hook_info, i
      	NULL
      };
      
    +
    + ## builtin/help.c ##
    +@@ builtin/help.c: static struct option builtin_help_options[] = {
    + };
    + 
    + static const char * const builtin_help_usage[] = {
    +-	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
    ++	"git help [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]",
    + 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
    + 	"git help [-g|--guides]",
    + 	"git help [-c|--config]",
13:  5f421314536 ! 14:  a29af2dcc4f doc txt & -h consistency: correct padding around "[]()"
    @@ Documentation/git-diff-files.txt: git-diff-files - Compares files in the working
      DESCRIPTION
      -----------
     
    + ## Documentation/git-hash-object.txt ##
    +@@ Documentation/git-hash-object.txt: git-hash-object - Compute object ID and optionally creates a blob from a file
    + SYNOPSIS
    + --------
    + [verse]
    +-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters]
    ++'git hash-object' [-t <type>] [-w] [--path=<file> | --no-filters]
    + 		[--stdin [--literally]] [--] <file>...
    + 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]
    + 
    +
      ## Documentation/git-merge-base.txt ##
     @@ Documentation/git-merge-base.txt: git-merge-base - Find as good common ancestors as possible for a merge
      SYNOPSIS
    @@ Documentation/git-rerere.txt: git-rerere - Reuse recorded resolution of conflict
      DESCRIPTION
      -----------
     
    + ## Documentation/git-send-pack.txt ##
    +@@ Documentation/git-send-pack.txt: SYNOPSIS
    + [verse]
    + 'git send-pack' [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
    + 		[--verbose] [--thin] [--atomic]
    +-		[--[no-]signed|--signed=(true|false|if-asked)]
    ++		[--[no-]signed | --signed=(true|false|if-asked)]
    + 		[<host>:]<directory> (--all | <ref>...)
    + 
    + DESCRIPTION
    +
      ## Documentation/git-show-branch.txt ##
     @@ Documentation/git-show-branch.txt: git-show-branch - Show branches and their commits
      SYNOPSIS
    @@ builtin/bugreport.c: static void get_populated_hooks(struct strbuf *hook_info, i
      	NULL
      };
     
    + ## builtin/commit-graph.c ##
    +@@
    + 
    + #define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
    + 	N_("git commit-graph write [--object-dir <objdir>] [--append]\n" \
    +-	   "                       [--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]\n" \
    ++	   "                       [--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]\n" \
    + 	   "                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]\n" \
    + 	   "                       <split options>")
    + 
    +
      ## builtin/diagnose.c ##
     @@
      #include "diagnose.h"
14:  6354bfea1b2 = 15:  589705cf6fa stash doc SYNOPSIS & -h: correct padding around "[]()"
15:  28e1edaf68e ! 16:  db850539d2a doc txt & -h consistency: use "<options>", not "<options>..."
    @@ Commit message
         "[<options>]" form to indicate an arbitrary number of options, let's
         do the same in these cases, which were the odd ones out.
     
    -    In the case of "mv" let's add the missing "[]" to indicate that these
    -    are optional.
    +    In the case of "mv" and "sparse-checkout" let's add the missing "[]"
    +    to indicate that these are optional.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/pack-objects.c: static inline void oe_set_delta_size(struct packing_data
      	NULL
      };
      
    +
    + ## builtin/sparse-checkout.c ##
    +@@
    + static const char *empty_base = "";
    + 
    + static char const * const builtin_sparse_checkout_usage[] = {
    +-	N_("git sparse-checkout (init | list | set | add | reapply | disable) <options>"),
    ++	N_("git sparse-checkout (init | list | set | add | reapply | disable) [<options>]"),
    + 	NULL
    + };
    + 
16:  8cc40e09124 = 17:  041aa64f3c7 t/helper/test-proc-receive.c: use "<options>", not "<options>..."
17:  97873747a1e ! 18:  3a439c4401d doc txt & -h consistency: fix mismatching labels
    @@ builtin/commit-graph.c
      #define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
     -	N_("git commit-graph write [--object-dir <objdir>] [--append]\n" \
     +	N_("git commit-graph write [--object-dir <dir>] [--append]\n" \
    - 	   "                       [--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]\n" \
    + 	   "                       [--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]\n" \
      	   "                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]\n" \
      	   "                       <split options>")
     
    @@ builtin/upload-archive.c
      static const char deadchild[] =
      "git upload-archive: archiver died with error";
     
    + ## builtin/verify-pack.c ##
    +@@ builtin/verify-pack.c: static int verify_one_pack(const char *path, unsigned int flags, const char *has
    + }
    + 
    + static const char * const verify_pack_usage[] = {
    +-	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>..."),
    ++	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>.idx..."),
    + 	NULL
    + };
    + 
    +
      ## builtin/worktree.c ##
     @@ builtin/worktree.c: static const char * const worktree_usage[] = {
      	N_("git worktree prune [<options>]"),
18:  301280c9c3a ! 19:  3bfdd3fb79e doc txt & -h consistency: add or fix optional "--" syntax
    @@ builtin/rev-list.c
      "\n"
      "  limiting output:\n"
      "    --max-count=<n>\n"
    +
    + ## builtin/verify-pack.c ##
    +@@ builtin/verify-pack.c: static int verify_one_pack(const char *path, unsigned int flags, const char *has
    + }
    + 
    + static const char * const verify_pack_usage[] = {
    +-	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>.idx..."),
    ++	N_("git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx..."),
    + 	NULL
    + };
    + 
19:  1b51906fa07 = 20:  98bdd0353cf doc txt & -h consistency: make output order consistent
20:  1c2bc223c5d ! 21:  1713227d497 doc txt & -h consistency: add missing options and labels
    @@ Documentation/git-send-pack.txt: git-send-pack - Push objects over Git protocol
     +'git send-pack' [--mirror] [--dry-run] [--force]
     +		[--receive-pack=<git-receive-pack>]
      		[--verbose] [--thin] [--atomic]
    - 		[--[no-]signed|--signed=(true|false|if-asked)]
    + 		[--[no-]signed | --signed=(true|false|if-asked)]
      		[<host>:]<directory> (--all | <ref>...)
     
      ## Documentation/git-sparse-checkout.txt ##
    @@ builtin/diff-index.c
      "\n"
      COMMON_DIFF_OPTIONS_HELP;
     
    - ## builtin/help.c ##
    -@@ builtin/help.c: static struct option builtin_help_options[] = {
    - };
    - 
    - static const char * const builtin_help_usage[] = {
    --	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
    -+	"git help [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]",
    - 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
    - 	"git help [-g|--guides]",
    - 	"git help [-c|--config]",
    -
      ## builtin/ls-remote.c ##
     @@
      
    @@ builtin/send-pack.c: static const char * const send_pack_usage[] = {
      	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
      	   "              [--receive-pack=<git-receive-pack>]\n"
      	   "              [--verbose] [--thin] [--atomic]\n"
    -+	   "              [--[no-]signed|--signed=(true|false|if-asked)]\n"
    ++	   "              [--[no-]signed | --signed=(true|false|if-asked)]\n"
      	   "              [<host>:]<directory> (--all | <ref>...)"),
      	NULL,
      };
     
    - ## builtin/sparse-checkout.c ##
    -@@
    - static const char *empty_base = "";
    - 
    - static char const * const builtin_sparse_checkout_usage[] = {
    --	N_("git sparse-checkout (init | list | set | add | reapply | disable) <options>"),
    -+	N_("git sparse-checkout (init | list | set | add | reapply | disable) [<options>]"),
    - 	NULL
    - };
    - 
    -
      ## builtin/symbolic-ref.c ##
     @@
      #include "parse-options.h"
    @@ builtin/upload-pack.c
      };
      
     
    - ## builtin/verify-pack.c ##
    -@@ builtin/verify-pack.c: static int verify_one_pack(const char *path, unsigned int flags, const char *has
    - }
    - 
    - static const char * const verify_pack_usage[] = {
    --	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>..."),
    -+	N_("git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx..."),
    - 	NULL
    - };
    - 
    -
      ## help.c ##
     @@ help.c: int cmd_version(int argc, const char **argv, const char *prefix)
      	struct strbuf buf = STRBUF_INIT;
21:  5785ed1d667 = 22:  702eb747c0f doc txt & -h consistency: make "rerere" consistent
22:  fde75be474a = 23:  01e20b8e452 doc txt & -h consistency: make "read-tree" consistent
23:  a6a43d0b3fd = 24:  7f93da79fee doc txt & -h consistency: make "bundle" consistent
24:  a4feebc5434 = 25:  ab109f73264 doc txt & -h consistency: use "git foo" form, not "git-foo"
25:  a4d75ea691c ! 26:  d57635b2707 doc txt & -h consistency: add missing options
    @@ Commit message
         doc txt & -h consistency: add missing options
     
         Change those built-in commands that were attempting to exhaustively
    -    the options in the "-h" output to actually do so, and always
    +    list the options in the "-h" output to actually do so, and always
         have *.txt documentation know about the exhaustive list of options.
     
         Let's also fix the documentation and -h output for those built-in
         commands where the *.txt and -h output was a mismatch of missing
         options on both sides.
     
    +    In the case of "interpret-trailers" fixing the missing options reveals
    +    that the *.txt version was implicitly claiming that the command had
    +    two operating modes, which a look at the -h version (and studying the
    +    documentation) will show is not the case.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-commit-graph.txt ##
    @@ Documentation/git-commit-graph.txt: SYNOPSIS
      'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
     -'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]
     +'git commit-graph write' [--object-dir <dir>] [--append]
    -+			[--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]
    ++			[--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]
     +			[--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]
     +			<split options>
      
    @@ builtin/fsck.c: static int mark_packed_for_connectivity(const struct object_id *
      
     
      ## builtin/hash-object.c ##
    -@@ builtin/hash-object.c: static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
    - int cmd_hash_object(int argc, const char **argv, const char *prefix)
    +@@ builtin/hash-object.c: int cmd_hash_object(int argc, const char **argv, const char *prefix)
      {
      	static const char * const hash_object_usage[] = {
    --		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
    + 		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters]\n"
    +-		   "                [--stdin] [--] <file>..."),
     -		"git hash-object  --stdin-paths",
    -+		N_("git hash-object [-t <type>] [-w] [--path=<file>|--no-filters]\n"
     +		   "                [--stdin [--literally]] [--] <file>..."),
     +		N_("git hash-object [-t <type>] [-w] --stdin-paths [--no-filters]"),
      		NULL
26:  ac62cda1ab2 ! 27:  ac959d0cfc1 doc txt & -h consistency: make "stash" consistent
    @@ Metadata
      ## Commit message ##
         doc txt & -h consistency: make "stash" consistent
     
    -    Amend both the the -h output and *.txt to match one another. In this
    -    case the *.txt didn't list the "save" subcommand, and the "-h" was
    +    Amend both the -h output and *.txt to match one another. In this case
    +    the *.txt didn't list the "save" subcommand, and the "-h" was
         similarly missing some commands.
     
         Let's also convert the *.c code to use a macro definition, similar to
    @@ builtin/stash.c
      
      static const char * const git_stash_clear_usage[] = {
     -	"git stash clear",
    -+	BUILTIN_STASH_BRANCH_USAGE,
    ++	BUILTIN_STASH_CLEAR_USAGE,
      	NULL
      };
      
27:  42415194e3f = 28:  f617375ea9e doc txt & -h consistency: make "annotate" consistent
28:  42076626a08 = 29:  c96c3fc6d8d doc txt & -h consistency: use "[<label>...]" for "zero or more"
29:  a57b00648dc = 30:  34b778dd176 doc txt & -h consistency: make "diff-tree" consistent
30:  7289ab9e09b = 31:  336fc749f1c doc txt & -h consistency: make "commit" consistent
31:  61a3c002690 = 32:  81024d1c3cd reflog doc: list real subcommands up-front
32:  a59f78d80c8 = 33:  76e6b7d296a worktree: define subcommand -h in terms of command -h
33:  a63d8017381 = 34:  efd0c2c634d doc txt & -h consistency: make "worktree" consistent
34:  aef2b7356dc ! 35:  22da68abce3 tests: start asserting that *.txt SYNOPSIS matches -h output
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## Documentation/CodingGuidelines ##
    -@@ Documentation/CodingGuidelines: Writing Documentation:
    - 
    -  A few commented examples follow to provide reference when writing or
    -  modifying command usage strings and synopsis sections in the manual
    -- pages:
    -+ pages. The two should match, see t/t0450-txt-doc-vs-help.sh for
    -+ (partial) regression testing.
    - 
    -  Placeholders are spelled in lowercase and enclosed in angle brackets:
    -    <file>
    -
      ## t/t0450-txt-doc-vs-help.sh (new) ##
     @@
     +#!/bin/sh
    @@ t/t0450-txt-doc-vs-help.sh (new)
     +	git --list-cmds=builtins >builtins
     +'
     +
    -+test_expect_success 'setup: list of txt v.s. help' '
    -+	cat >list <<-\EOF
    -+	add
    -+	am
    -+	apply
    -+	archive
    -+	bisect
    -+	blame
    -+	branch
    -+	check-ref-format
    -+	checkout
    -+	checkout-index
    -+	clone
    -+	column
    -+	config
    -+	credential
    -+	credential-cache
    -+	credential-store
    -+	fast-export
    -+	fast-import
    -+	fetch-pack
    -+	fmt-merge-msg
    -+	for-each-ref
    -+	format-patch
    -+	fsck-objects
    -+	fsmonitor--daemon
    -+	gc
    -+	grep
    -+	index-pack
    -+	init-db
    -+	log
    -+	ls-files
    -+	ls-tree
    -+	mailinfo
    -+	mailsplit
    -+	maintenance
    -+	merge
    -+	merge-file
    -+	merge-index
    -+	merge-one-file
    -+	multi-pack-index
    -+	name-rev
    -+	notes
    -+	pack-objects
    -+	push
    -+	range-diff
    -+	rebase
    -+	remote
    -+	remote-ext
    -+	remote-fd
    -+	repack
    -+	reset
    -+	restore
    -+	rev-parse
    -+	show
    -+	stage
    -+	switch
    -+	update-index
    -+	update-ref
    -+	whatchanged
    -+	EOF
    -+'
    -+
    -+test_expect_success 'setup: list of txt v.s. help is sorted' '
    -+	sort -u list >list.sorted &&
    -+	if ! test_cmp list list.sorted
    ++test_expect_success 'list of txt and help mismatches is sorted' '
    ++	sort -u "$TEST_DIRECTORY"/t0450/txt-help-mismatches >expect &&
    ++	if ! test_cmp expect "$TEST_DIRECTORY"/t0450/txt-help-mismatches
     +	then
    -+		BUG "please keep the command list sorted"
    ++		BUG "please keep the list of txt and help mismatches sorted"
     +	fi
     +'
     +
    @@ t/t0450-txt-doc-vs-help.sh (new)
     +	fi &&
     +
     +	result=
    -+	if grep -q "^$builtin$" list
    ++	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/txt-help-mismatches
     +	then
     +		result=failure
     +	else
    @@ t/t0450-txt-doc-vs-help.sh (new)
     +test_debug 'say "$(cat failing)"'
     +
     +test_done
    +
    + ## t/t0450/txt-help-mismatches (new) ##
    +@@
    ++add
    ++am
    ++apply
    ++archive
    ++bisect
    ++blame
    ++branch
    ++check-ref-format
    ++checkout
    ++checkout-index
    ++clone
    ++column
    ++config
    ++credential
    ++credential-cache
    ++credential-store
    ++fast-export
    ++fast-import
    ++fetch-pack
    ++fmt-merge-msg
    ++for-each-ref
    ++format-patch
    ++fsck-objects
    ++fsmonitor--daemon
    ++gc
    ++grep
    ++index-pack
    ++init-db
    ++log
    ++ls-files
    ++ls-tree
    ++mailinfo
    ++mailsplit
    ++maintenance
    ++merge
    ++merge-file
    ++merge-index
    ++merge-one-file
    ++multi-pack-index
    ++name-rev
    ++notes
    ++pack-objects
    ++push
    ++range-diff
    ++rebase
    ++remote
    ++remote-ext
    ++remote-fd
    ++repack
    ++reset
    ++restore
    ++rev-parse
    ++show
    ++stage
    ++switch
    ++update-index
    ++update-ref
    ++whatchanged
35:  c92a4f52a8c = 36:  b56113dd620 tests: assert consistent whitespace in -h output
-- 
2.38.0.rc2.935.g6b421ae1592

