Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A0C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiI1IkF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiI1Ijl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15155DEF4
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v28so5791039wrd.3
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RlX0H786FaxlIK6maRBBhzBbhW1qYgDoGdHhOgPIj8I=;
        b=T7QjBZVsKiV78PwLnutRobVMxZUxnsUFWVRzMU6NXozGEtaCLPf/Pi/qq6sMsW+SNK
         aEMble5YXJqYAdiDKDfgun2oOTJoseqP1PPAvlEjE5CKGy136ZXBL14FSL/CfV/I5LvQ
         OKYuL0aLxpeF9/+segwmcGQCSe8/5/uf3EliVUyT9QETMvuoRY0hJZ1j9annf04psJgX
         nnZrRYTthFp5f+uIrhUYyZTgProfEGyKn2n09jzpC9rPudran06UQOVCwzZh0XXuS5MX
         jxNYN8pt/UaFu7MOdb6PFt2BHa+4OTTTC4W9Nx7yKeAaEoSZoFWyq3kDzo5s/LrmrK7c
         vDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RlX0H786FaxlIK6maRBBhzBbhW1qYgDoGdHhOgPIj8I=;
        b=jFeSwWctf7DvJQC88Fd7CqgNWER19b5+UpbhlqJm5Rxf9QjcoBYBz0mA53MtKqz3zl
         JFnAhg6Z6MRZtnUeKOLxTPzZBOOCQiCPjy8OGSPnCGAngikWPasPtk0PwoCtI4gWV0Jm
         OoSOctV/WJyVZ9Gv86tM5BLJt7EjpqRls8FqH3KIZh5oNe6DwbMgl9t4Tbk9EPdB7TNh
         o4H2TLtY3/wIPPHZYEXR4SknqUOJCzI/LHsglYIRKz7ijgBu8TB0ybIJpRc8VdJjowVe
         /YWDBLIoAOxhdJeaT3jmIf7imPt5TElAJj1/EgrM2Z2kJienfrSAR+/iVE7L0I8xZ4uB
         Mjdw==
X-Gm-Message-State: ACrzQf0CEC1HZ6c0XlrE1f+Adttw7q6qJrze/Ogb36AmY3q+pfYIfRtf
        Om72hwoiW+6jo0PBYC6ZaClxIUxzRnnWIQ==
X-Google-Smtp-Source: AMsMyM6hXybJOnRn9gky8GdEpahA46lfDdiQ8giRWvB4Udd4vuyQ/ZyDeVACqNFYKZkKockJ8MMKBA==
X-Received: by 2002:adf:e186:0:b0:22a:3329:540f with SMTP id az6-20020adfe186000000b0022a3329540fmr19594901wrb.278.1664354375740;
        Wed, 28 Sep 2022 01:39:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/35] doc/UX: make txt & -h output more consistent
Date:   Wed, 28 Sep 2022 10:38:55 +0200
Message-Id: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
https://lore.kernel.org/git/cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com/

Changes since v1:

 * Clarified the CodingGuidelines update with Junio's suggested
   wording/changes.

 * Fixed a mention to a "preceding" commit noted by Victoria.

 * Made one minor bit of "sed" syntax in 34/35 consistent with the
   rest.

 * Added an assertion that "-h" output only has SP whitespace, not
   TABs.

 * 20/35 shows a bug in v1 of this. I compared the -h and *.txt
   output, but because I normalized (stripped away) the whitespace I
   didn't notice that "git tag" was left unindented.

   There's now a new test in 35/35 to test for that.

Victoria: I decided not to go for your suggestion of trimming this
series down in [1]. Reasons:

 * It would take me time I don't have to spend on this, as some of it
   isn't easy to cleanly re-arrange. E.g. the later "make consistent"
   commits rely on earlier whitespace/basic syntax fixes.

 * A major advantage of reviewing this in one go is that the 34-35/35
   tests at the end are asserting everything that came before
   it.

   That's what I meant re the "mostly trust" comment you replied to in
   [1]. I.e. I aimed to make it easy for reviewers to trust that the
   "doc txt & -h consistency" patches were only altering one side of
   either -h or *.txt, with the other side being in-tree already.

 * I originally hacked this up with 34/35 coming first, but then to
   make the commits atomic I needed to update the test with each
   change to alter the list of built-ins expected to pass.

   I think that original approach is arguably better, as you can
   assert each commit in isolation, and it would certainly make it
   easier to split this up. But to re-do it again at this point would
   be more work & churn than I think this is worth.

I'm attaching a "Documentation/doc-diff @{u} HEAD" below the range
diff, to make it easy to see what the end result of the *.txt changes
here is.

1. https://lore.kernel.org/git/af319ab4-2351-2d74-e0c7-6153f229d88c@github.com/

Ævar Arnfjörð Bjarmason (35):
  CodingGuidelines: update and clarify command-line conventions
  builtin/bundle.c: use \t, not fix indentation 2-SP indentation
  bundle: define subcommand -h in terms of command -h
  blame: use a more detailed usage_msg_optf() error on bad -L
  doc SYNOPSIS: don't use ' for subcommands
  doc SYNOPSIS: consistently use ' for commands
  doc SYNOPSIS & -h: fix incorrect alternates syntax
  built-ins: consistently add "\n" between "usage" and options
  doc txt & -h consistency: word-wrap
  doc txt & -h consistency: fix incorrect alternates syntax
  doc txt & -h consistency: add "-z" to cat-file "-h"
  doc txt & -h consistency: add missing "]" to bugreport "-h"
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

 Documentation/CodingGuidelines                |  17 +-
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
 Documentation/git-reflog.txt                  |  17 +-
 Documentation/git-rerere.txt                  |   2 +-
 Documentation/git-send-pack.txt               |   3 +-
 Documentation/git-show-branch.txt             |   4 +-
 Documentation/git-show-ref.txt                |   4 +-
 Documentation/git-sparse-checkout.txt         |   2 +-
 Documentation/git-stash.txt                   |  17 +-
 Documentation/git-status.txt                  |   2 +-
 Documentation/git-tag.txt                     |   2 +-
 Documentation/git-update-server-info.txt      |   8 +-
 Documentation/git-upload-archive.txt          |   4 +-
 Documentation/git-var.txt                     |   2 +-
 Documentation/git-verify-commit.txt           |   2 +-
 Documentation/git-verify-pack.txt             |   2 +-
 Documentation/git-verify-tag.txt              |   2 +-
 Documentation/git-worktree.txt                |   3 +-
 builtin/blame.c                               |  26 ++-
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
 builtin/stash.c                               |  73 ++++---
 builtin/symbolic-ref.c                        |   5 +-
 builtin/tag.c                                 |  10 +-
 builtin/unpack-file.c                         |   2 +-
 builtin/update-server-info.c                  |   2 +-
 builtin/upload-archive.c                      |   2 +-
 builtin/upload-pack.c                         |   3 +-
 builtin/verify-pack.c                         |   2 +-
 builtin/worktree.c                            | 110 +++++++---
 help.c                                        |   2 +-
 t/helper/test-proc-receive.c                  |   2 +-
 t/t0450-txt-doc-vs-help.sh                    | 199 ++++++++++++++++++
 78 files changed, 550 insertions(+), 185 deletions(-)
 create mode 100755 t/t0450-txt-doc-vs-help.sh

Range-diff against v1:
 1:  b8cbd443987 !  1:  aecd3ff41f2 CodingGuidelines: update and clarify command-line conventions
    @@ Documentation/CodingGuidelines: Writing Documentation:
         [-q | --quiet]
         [--utf8 | --no-utf8]
      
    -+ Use spacing around "|" token(s), but not on the inside of "[]()"
    -+ tokens:
    ++ Use spacing around "|" token(s), but not immediately after opening or
    ++ before closing a [] or () pair:
     +   Do: [-q | --quiet]
     +   Don't: [-q|--quiet]
     +
 2:  66286fa3af7 =  2:  63145b58504 builtin/bundle.c: use \t, not fix indentation 2-SP indentation
 3:  b49268615c3 =  3:  6bcfab04cbe bundle: define subcommand -h in terms of command -h
 4:  22c3d1a73dc =  4:  707cf48a900 blame: use a more detailed usage_msg_optf() error on bad -L
 5:  dc66db38a62 =  5:  ad0216f798e doc SYNOPSIS: don't use ' for subcommands
 6:  0b946d60fcc =  6:  adc18d392b5 doc SYNOPSIS: consistently use ' for commands
 7:  a070c97f29b !  7:  3531d531a3f doc SYNOPSIS & -h: fix incorrect alternates syntax
    @@ Commit message
         "[(-o | --option) <argument>]", we were previously claiming that only
         the long option accepted the "<argument>", which isn't what we meant.
     
    -    Unlike a preceding commit where this was fixed for commands which had
    -    inconsistent "-h" and *.txt, for "stash" it's been with us in both the
    -    "-h" and *.txt since bd514cada4b (stash: introduce 'git stash store',
    -    2013-06-15).
    +    This issue has been with us in both the "-h" and *.txt versions since
    +    bd514cada4b (stash: introduce 'git stash store', 2013-06-15).
    +
    +    There are also issues with the alternates syntax for "bugreport" and
    +    "diagnose", but in those cases only for one of *.c or *.txt, not
    +    both. Those issues will be fixed in a subsequent "consistency" commit.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 8:  75c39a2ff83 =  8:  4c68003904f built-ins: consistently add "\n" between "usage" and options
 9:  f79a6ead8b0 =  9:  a7d57827067 doc txt & -h consistency: word-wrap
10:  965f6b3b3cb = 10:  93e63821bc6 doc txt & -h consistency: fix incorrect alternates syntax
11:  698d8d3d53a = 11:  aaa36012fa2 doc txt & -h consistency: add "-z" to cat-file "-h"
12:  55ce0f8632f = 12:  6501b9d1ecc doc txt & -h consistency: add missing "]" to bugreport "-h"
13:  d88690fa849 = 13:  5f421314536 doc txt & -h consistency: correct padding around "[]()"
14:  12ec2627504 = 14:  6354bfea1b2 stash doc SYNOPSIS & -h: correct padding around "[]()"
15:  33d47a8a827 = 15:  28e1edaf68e doc txt & -h consistency: use "<options>", not "<options>..."
16:  1adbe9b7d12 = 16:  8cc40e09124 t/helper/test-proc-receive.c: use "<options>", not "<options>..."
17:  517f9f9a53f = 17:  97873747a1e doc txt & -h consistency: fix mismatching labels
18:  df312ad3ceb = 18:  301280c9c3a doc txt & -h consistency: add or fix optional "--" syntax
19:  77cf58aa9c7 = 19:  1b51906fa07 doc txt & -h consistency: make output order consistent
20:  f6ecf6a38af ! 20:  1c2bc223c5d doc txt & -h consistency: add missing options and labels
    @@ builtin/tag.c
     -	   "        [--format=<format>] [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
     +	N_("git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]\n"
     +	   "        [--points-at <object>] [--column[=<options>] | --no-column]\n"
    -+	   "[--create-reflog] [--sort=<key>] [--format=<format>]\n"
    -+	   "[--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
    ++	   "        [--create-reflog] [--sort=<key>] [--format=<format>]\n"
    ++	   "        [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
      	N_("git tag -v [--format=<format>] <tagname>..."),
      	NULL
      };
21:  50e1a8c2b1e = 21:  5785ed1d667 doc txt & -h consistency: make "rerere" consistent
22:  92c178d5303 = 22:  fde75be474a doc txt & -h consistency: make "read-tree" consistent
23:  dee17f861b2 = 23:  a6a43d0b3fd doc txt & -h consistency: make "bundle" consistent
24:  8cc52c68b67 = 24:  a4feebc5434 doc txt & -h consistency: use "git foo" form, not "git-foo"
25:  3b0295e3467 = 25:  a4d75ea691c doc txt & -h consistency: add missing options
26:  3907f349948 = 26:  ac62cda1ab2 doc txt & -h consistency: make "stash" consistent
27:  f6c9fb63a08 = 27:  42415194e3f doc txt & -h consistency: make "annotate" consistent
28:  6607ed3e343 = 28:  42076626a08 doc txt & -h consistency: use "[<label>...]" for "zero or more"
29:  dc32043b203 = 29:  a57b00648dc doc txt & -h consistency: make "diff-tree" consistent
30:  0aea4ee2e03 = 30:  7289ab9e09b doc txt & -h consistency: make "commit" consistent
31:  5da768a04bc = 31:  61a3c002690 reflog doc: list real subcommands up-front
32:  5fa403db45a = 32:  a59f78d80c8 worktree: define subcommand -h in terms of command -h
33:  280c3b56d97 = 33:  a63d8017381 doc txt & -h consistency: make "worktree" consistent
34:  c15c1422055 ! 34:  aef2b7356dc tests: start asserting that *.txt SYNOPSIS matches -h output
    @@ t/t0450-txt-doc-vs-help.sh (new)
     +			/^$/d;
     +			s/^usage: //;
     +			s/^ *or: //;
    -+			p
    ++			p;
     +		}' <out
     +}
     +
    @@ t/t0450-txt-doc-vs-help.sh (new)
     +test_debug '>failing'
     +while read builtin
     +do
    ++	test_expect_success "$builtin -h output has no \t" '
    ++		builtin_to_synopsis "$builtin" >help.raw &&
    ++		! grep "$HT" help.raw
    ++	'
    ++
     +	txt="$(builtin_to_txt "$builtin")" &&
     +	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
     +
 -:  ----------- > 35:  c92a4f52a8c tests: assert consistent whitespace in -h output

A manually produced doc-diff, as noted above:
	
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-annotate.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-annotate.1
	index e1098d7841e..e696e5a03c7 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-annotate.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-annotate.1
	@@ -4,7 +4,7 @@ NAME
	        git-annotate - Annotate file lines with commit information
	 
	 SYNOPSIS
	-       git annotate [<options>] <file> [<revision>]
	+       git annotate [<options>] [<rev-opts>] [<rev>] [--] <file>
	 
	 DESCRIPTION
	        Annotates each line in the given file with information from the commit
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-clean.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-clean.1
	index cd823d5c176..13e20af3996 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-clean.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-clean.1
	@@ -4,7 +4,7 @@ NAME
	        git-clean - Remove untracked files from the working tree
	 
	 SYNOPSIS
	-       git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
	+       git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] [<pathspec>...]
	 
	 DESCRIPTION
	        Cleans the working tree by recursively removing files that are not
	@@ -14,16 +14,16 @@ DESCRIPTION
	        is specified, ignored files are also removed. This can, for example, be
	        useful to remove all build products.
	 
	-       If any optional <path>... arguments are given, only those paths are
	+       If any optional <pathspec>... arguments are given, only those paths are
	        affected.
	 
	 OPTIONS
	        -d
	-           Normally, when no <path> is specified, git clean will not recurse
	-           into untracked directories to avoid removing too much. Specify -d
	-           to have it recurse into such directories as well. If any paths are
	-           specified, -d is irrelevant; all untracked files matching the
	-           specified paths (with exceptions for nested git directories
	+           Normally, when no <pathspec> is specified, git clean will not
	+           recurse into untracked directories to avoid removing too much.
	+           Specify -d to have it recurse into such directories as well. If any
	+           paths are specified, -d is irrelevant; all untracked files matching
	+           the specified paths (with exceptions for nested git directories
	            mentioned under --force) will be removed.
	 
	        -f, --force
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-commit-graph.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-commit-graph.1
	index 919c4015a5b..10e5b7f1fb9 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-commit-graph.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-commit-graph.1
	@@ -5,7 +5,10 @@ NAME
	 
	 SYNOPSIS
	        git commit-graph verify [--object-dir <dir>] [--shallow] [--[no-]progress]
	-       git commit-graph write <options> [--object-dir <dir>] [--[no-]progress]
	+       git commit-graph write [--object-dir <dir>] [--append]
	+                               [--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]
	+                               [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]
	+                               <split options>
	 
	 DESCRIPTION
	        Manage the serialized commit-graph file.
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-credential-cache--daemon.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-credential-cache--daemon.1
	index 6199b539d04..e81cabc3e9a 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-credential-cache--daemon.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-credential-cache--daemon.1
	@@ -5,7 +5,7 @@ NAME
	        memory
	 
	 SYNOPSIS
	-       git credential-cache--daemon [--debug] <socket>
	+       git credential-cache--daemon [--debug] <socket-path>
	 
	 DESCRIPTION
	            Note
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-diff-files.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-diff-files.1
	index b0f4ed10de0..91c261e610d 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-diff-files.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-diff-files.1
	@@ -4,7 +4,7 @@ NAME
	        git-diff-files - Compares files in the working tree and the index
	 
	 SYNOPSIS
	-       git diff-files [-q] [-0|-1|-2|-3|-c|--cc] [<common-diff-options>] [<path>...]
	+       git diff-files [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]
	 
	 DESCRIPTION
	        Compares the files in the working tree and the index. When paths are
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-hash-object.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-hash-object.1
	index c7627bbf999..674c62143c8 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-hash-object.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-hash-object.1
	@@ -5,7 +5,8 @@ NAME
	        a file
	 
	 SYNOPSIS
	-       git hash-object [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
	+       git hash-object [-t <type>] [-w] [--path=<file>|--no-filters]
	+                       [--stdin [--literally]] [--] <file>...
	        git hash-object [-t <type>] [-w] --stdin-paths [--no-filters]
	 
	 DESCRIPTION
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-interpret-trailers.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-interpret-trailers.1
	index 1eaf26fec4c..ac4dfeaa0cf 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-interpret-trailers.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-interpret-trailers.1
	@@ -5,8 +5,9 @@ NAME
	        messages
	 
	 SYNOPSIS
	-       git interpret-trailers [<options>] [(--trailer <token>[(=|:)<value>])...] [<file>...]
	-       git interpret-trailers [<options>] [--parse] [<file>...]
	+       git interpret-trailers [--in-place] [--trim-empty]
	+                               [(--trailer <token>[(=|:)<value>])...]
	+                               [--parse] [<file>...]
	 
	 DESCRIPTION
	        Help parsing or adding trailers lines, that look similar to RFC 822
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-merge-base.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-merge-base.1
	index bb77c49baed..700d00f5e86 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-merge-base.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-merge-base.1
	@@ -4,8 +4,8 @@ NAME
	        git-merge-base - Find as good common ancestors as possible for a merge
	 
	 SYNOPSIS
	-       git merge-base [-a|--all] <commit> <commit>...
	-       git merge-base [-a|--all] --octopus <commit>...
	+       git merge-base [-a | --all] <commit> <commit>...
	+       git merge-base [-a | --all] --octopus <commit>...
	        git merge-base --is-ancestor <commit> <commit>
	        git merge-base --independent <commit>...
	        git merge-base --fork-point <ref> [<commit>]
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-mv.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-mv.1
	index 68bd3298b6d..c608c146efc 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-mv.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-mv.1
	@@ -4,7 +4,7 @@ NAME
	        git-mv - Move or rename a file, a directory, or a symlink
	 
	 SYNOPSIS
	-       git mv <options>... <args>...
	+       git mv [<options>] <source>... <destination>
	 
	 DESCRIPTION
	        Move or rename a file, directory or symlink.
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-pack-redundant.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-pack-redundant.1
	index 6336769ea00..36e19089eda 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-pack-redundant.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-pack-redundant.1
	@@ -4,7 +4,7 @@ NAME
	        git-pack-redundant - Find redundant pack files
	 
	 SYNOPSIS
	-       git pack-redundant [ --verbose ] [ --alt-odb ] ( --all | <pack-filename>... )
	+       git pack-redundant [--verbose] [--alt-odb] (--all | <pack-filename>...)
	 
	 DESCRIPTION
	        This program computes which packs in your repository are redundant. The
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-prune-packed.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-prune-packed.1
	index 2de5e6f2ddf..542cbe2780c 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-prune-packed.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-prune-packed.1
	@@ -4,7 +4,7 @@ NAME
	        git-prune-packed - Remove extra objects that are already in pack files
	 
	 SYNOPSIS
	-       git prune-packed [-n|--dry-run] [-q|--quiet]
	+       git prune-packed [-n | --dry-run] [-q | --quiet]
	 
	 DESCRIPTION
	        This program searches the $GIT_OBJECT_DIRECTORY for all objects that
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-read-tree.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-read-tree.1
	index 2d7366df2dc..0d08a46f13b 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-read-tree.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-read-tree.1
	@@ -4,7 +4,7 @@ NAME
	        git-read-tree - Reads tree information into the index
	 
	 SYNOPSIS
	-       git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
	+       git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)
	                        [-u | -i]] [--index-output=<file>] [--no-sparse-checkout]
	                        (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
	 
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-receive-pack.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-receive-pack.1
	index 557b090b02e..bcd953a65f7 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-receive-pack.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-receive-pack.1
	@@ -4,7 +4,7 @@ NAME
	        git-receive-pack - Receive what is pushed into the repository
	 
	 SYNOPSIS
	-       git-receive-pack <directory>
	+       git receive-pack <git-dir>
	 
	 DESCRIPTION
	        Invoked by git send-pack and updates the repository with the
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-reflog.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-reflog.1
	index 78f0c8969d6..97101386014 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-reflog.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-reflog.1
	@@ -4,19 +4,16 @@ NAME
	        git-reflog - Manage reflog information
	 
	 SYNOPSIS
	-       git reflog <subcommand> <options>
	+       git reflog [show] [<log-options>] [<ref>]
	+       git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
	+               [--rewrite] [--updateref] [--stale-fix]
	+               [--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
	+       git reflog delete [--rewrite] [--updateref]
	+               [--dry-run | -n] [--verbose] <ref>@{<specifier>}...
	+       git reflog exists <ref>
	 
	 DESCRIPTION
	-       The command takes various subcommands, and different options depending
	-       on the subcommand:
	-
	-           git reflog [show] [<log-options>] [<ref>]
	-           git reflog expire [--expire=<time>] [--expire-unreachable=<time>]
	-                   [--rewrite] [--updateref] [--stale-fix]
	-                   [--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
	-           git reflog delete [--rewrite] [--updateref]
	-                   [--dry-run | -n] [--verbose] <ref>@{<specifier>}...
	-           git reflog exists <ref>
	+       This command manages the information recorded in the reflogs.
	 
	        Reference logs, or "reflogs", record when the tips of branches and
	        other references were updated in the local repository. Reflogs are
	@@ -26,7 +23,8 @@ DESCRIPTION
	        week ago in this local repository", and so on. See gitrevisions(7) for
	        more details.
	 
	-       This command manages the information recorded in the reflogs.
	+       The command takes various subcommands, and different options depending
	+       on the subcommand:
	 
	        The "show" subcommand (which is also the default, in the absence of any
	        subcommands) shows the log of the reference provided in the
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-rerere.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-rerere.1
	index 92b7d74d266..7fe89de8d53 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-rerere.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-rerere.1
	@@ -4,7 +4,7 @@ NAME
	        git-rerere - Reuse recorded resolution of conflicted merges
	 
	 SYNOPSIS
	-       git rerere [clear|forget <pathspec>|diff|remaining|status|gc]
	+       git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]
	 
	 DESCRIPTION
	        In a workflow employing relatively long lived topic branches, the
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-send-pack.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-send-pack.1
	index 56700af6311..f727babc314 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-send-pack.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-send-pack.1
	@@ -4,7 +4,8 @@ NAME
	        git-send-pack - Push objects over Git protocol to another repository
	 
	 SYNOPSIS
	-       git send-pack [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
	+       git send-pack [--mirror] [--dry-run] [--force]
	+                       [--receive-pack=<git-receive-pack>]
	                        [--verbose] [--thin] [--atomic]
	                        [--[no-]signed|--signed=(true|false|if-asked)]
	                        [<host>:]<directory> (--all | <ref>...)
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-show-branch.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-show-branch.1
	index b81c4999fa8..29480d4f8d7 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-show-branch.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-show-branch.1
	@@ -4,12 +4,12 @@ NAME
	        git-show-branch - Show branches and their commits
	 
	 SYNOPSIS
	-       git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order]
	+       git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]
	                        [--current] [--color[=<when>] | --no-color] [--sparse]
	                        [--more=<n> | --list | --independent | --merge-base]
	                        [--no-name | --sha1-name] [--topics]
	                        [(<rev> | <glob>)...]
	-       git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
	+       git show-branch (-g | --reflog)[=<n>[,<base>]] [--list] [<ref>]
	 
	 DESCRIPTION
	        Shows the commit ancestry graph starting from the commits named with
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-show-ref.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-show-ref.1
	index 05008ff520e..c9cb2839742 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-show-ref.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-show-ref.1
	@@ -4,8 +4,8 @@ NAME
	        git-show-ref - List references in a local repository
	 
	 SYNOPSIS
	-       git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference]
	-                    [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
	+       git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference]
	+                    [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags]
	                     [--heads] [--] [<pattern>...]
	        git show-ref --exclude-existing[=<pattern>]
	 
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-sparse-checkout.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-sparse-checkout.1
	index 93c601af41d..42f20178480 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-sparse-checkout.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-sparse-checkout.1
	@@ -5,7 +5,7 @@ NAME
	        files
	 
	 SYNOPSIS
	-       git sparse-checkout <subcommand> [<options>]
	+       git sparse-checkout (init | list | set | add | reapply | disable) [<options>]
	 
	 DESCRIPTION
	        This command is used to create sparse checkouts, which change the
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-stash.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-stash.1
	index 27123a702e3..e56c0d42f00 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-stash.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-stash.1
	@@ -5,17 +5,20 @@ NAME
	 
	 SYNOPSIS
	        git stash list [<log-options>]
	-       git stash show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
	-       git stash drop [-q|--quiet] [<stash>]
	-       git stash ( pop | apply ) [--index] [-q|--quiet] [<stash>]
	+       git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
	+       git stash drop [-q | --quiet] [<stash>]
	+       git stash pop [--index] [-q | --quiet] [<stash>]
	+       git stash apply [--index] [-q | --quiet] [<stash>]
	        git stash branch <branchname> [<stash>]
	-       git stash [push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]
	-                    [-u|--include-untracked] [-a|--all] [-m|--message <message>]
	+       git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
	+                    [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
	                     [--pathspec-from-file=<file> [--pathspec-file-nul]]
	                     [--] [<pathspec>...]]
	+       git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
	+                    [-u | --include-untracked] [-a | --all] [<message>]
	        git stash clear
	        git stash create [<message>]
	-       git stash store [-m|--message <message>] [-q|--quiet] <commit>
	+       git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
	 
	 DESCRIPTION
	        Use git stash when you want to record the current state of the working
	@@ -39,7 +42,7 @@ DESCRIPTION
	 
	 COMMANDS
	        push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index]
	-       [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message
	+       [-u|--include-untracked] [-a|--all] [-q|--quiet] [(-m|--message)
	        <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--]
	        [<pathspec>...]
	            Save your local modifications to a new stash entry and roll them
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-status.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-status.1
	index 40481e33502..def2218250f 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-status.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-status.1
	@@ -4,7 +4,7 @@ NAME
	        git-status - Show the working tree status
	 
	 SYNOPSIS
	-       git status [<options>...] [--] [<pathspec>...]
	+       git status [<options>] [--] [<pathspec>...]
	 
	 DESCRIPTION
	        Displays paths that have differences between the index file and the
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-tag.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-tag.1
	index 7b8a1f7121c..72082aade13 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-tag.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-tag.1
	@@ -4,7 +4,7 @@ NAME
	        git-tag - Create, list, delete or verify a tag object signed with GPG
	 
	 SYNOPSIS
	-       git tag [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
	+       git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]
	                <tagname> [<commit> | <object>]
	        git tag -d <tagname>...
	        git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-update-server-info.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-update-server-info.1
	index 8453bc47398..5495562a6d7 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-update-server-info.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-update-server-info.1
	@@ -5,7 +5,7 @@ NAME
	        servers
	 
	 SYNOPSIS
	-       git update-server-info
	+       git update-server-info [-f | --force]
	 
	 DESCRIPTION
	        A dumb server that does not do on-the-fly pack generations must have
	@@ -14,6 +14,10 @@ DESCRIPTION
	        references and packs the server has. This command generates such
	        auxiliary files.
	 
	+OPTIONS
	+       -f, --force
	+           Allow adding otherwise ignored files.
	+
	 OUTPUT
	        Currently the command updates the following files. Please see
	        gitrepository-layout(5) for description of what they are for:
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-upload-archive.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-upload-archive.1
	index 95e69407775..4f81618976a 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-upload-archive.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-upload-archive.1
	@@ -4,7 +4,7 @@ NAME
	        git-upload-archive - Send archive back to git-archive
	 
	 SYNOPSIS
	-       git upload-archive <directory>
	+       git upload-archive <repository>
	 
	 DESCRIPTION
	        Invoked by git archive --remote and sends a generated archive to the
	@@ -46,7 +46,7 @@ SECURITY
	        non-smart-http.
	 
	 OPTIONS
	-       <directory>
	+       <repository>
	            The repository to get a tar archive from.
	 
	 GIT
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-var.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-var.1
	index e8981b47f97..dc25589cc08 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-var.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-var.1
	@@ -4,7 +4,7 @@ NAME
	        git-var - Show a Git logical variable
	 
	 SYNOPSIS
	-       git var ( -l | <variable> )
	+       git var (-l | <variable>)
	 
	 DESCRIPTION
	        Prints a Git logical variable.
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-verify-commit.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-verify-commit.1
	index 0d7dd5135b6..e7884d403a4 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-verify-commit.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-verify-commit.1
	@@ -4,7 +4,7 @@ NAME
	        git-verify-commit - Check the GPG signature of commits
	 
	 SYNOPSIS
	-       git verify-commit <commit>...
	+       git verify-commit [-v | --verbose] <commit>...
	 
	 DESCRIPTION
	        Validates the GPG signature created by git commit -S.
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-verify-pack.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-verify-pack.1
	index 7dc7eac065c..4c8cc24ab06 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-verify-pack.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-verify-pack.1
	@@ -4,7 +4,7 @@ NAME
	        git-verify-pack - Validate packed Git archive files
	 
	 SYNOPSIS
	-       git verify-pack [-v|--verbose] [-s|--stat-only] [--] <pack>.idx ...
	+       git verify-pack [-v | --verbose] [-s | --stat-only] [--] <pack>.idx...
	 
	 DESCRIPTION
	        Reads given idx file for packed Git archive created with the git
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-verify-tag.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-verify-tag.1
	index 58d3d9ad5dd..02b8f38db8d 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-verify-tag.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-verify-tag.1
	@@ -4,7 +4,7 @@ NAME
	        git-verify-tag - Check the GPG signature of tags
	 
	 SYNOPSIS
	-       git verify-tag [--format=<format>] <tag>...
	+       git verify-tag [-v | --verbose] [--format=<format>] <tag>...
	 
	 DESCRIPTION
	        Validates the gpg signature created by git tag.
	diff --git a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-worktree.1 b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-worktree.1
	index 40ba511d7a8..cb5aebfca95 100644
	--- a/2a7d63a2453e2c30353342a2c9385fa22a846987/home/avar/share/man/man1/git-worktree.1
	+++ b/c92a4f52a8c961b9153647d88c22941cba93b087/home/avar/share/man/man1/git-worktree.1
	@@ -4,7 +4,8 @@ NAME
	        git-worktree - Manage multiple working trees
	 
	 SYNOPSIS
	-       git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]] [-b <new-branch>] <path> [<commit-ish>]
	+       git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
	+                          [-b <new-branch>] <path> [<commit-ish>]
	        git worktree list [-v | --porcelain [-z]]
	        git worktree lock [--reason <string>] <worktree>
	        git worktree move <worktree> <new-path>
-- 
2.38.0.rc1.925.gb61c5ccd7da

