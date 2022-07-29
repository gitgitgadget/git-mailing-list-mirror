Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5541CC19F2B
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiG2I0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiG2I0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:26:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1778827FEA
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z17so384618wrq.4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=j8164VF0z4XXmHNreGfqUBZ2GvggTlC4fEkFtLJeGAM=;
        b=j/IZ7+4FgekmDnSQ0AZnEvoYgmWlOjOk3Ezk4Cw55DWVU3Xp3QJLzwxhgUQCmTpofA
         RbFUt4eAU7tq/gOjYoYm+NK5X9AyCEdoqkF/RbBzyqZT0eADrGiLgTVYCHqjjlxB0QjO
         noAsket2/KGhKfOyYnr6EZaFZ+r0lE6MHuGkBO4Yx1IvnlwwDjrta9lfIGfC1bEJOS6m
         9zBeK8KSVymleh6LVqb+6AFpv2nTZiERo+mDvQ0EZYAKdVmA4QmFPFN6UVz13fQLbnpW
         ZizG5K+CsPTP7oGZM3VP9Qy1o7mOhvqYaSolGTnVQJ2mGz2pe5dxC8kldZvbe17gVS4Z
         Wrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=j8164VF0z4XXmHNreGfqUBZ2GvggTlC4fEkFtLJeGAM=;
        b=4gv5fPYZKLSN2kZ9q5wq5vT3wnRZaW14ufTsNyqknFDjFRVClthqwODSgKJDKF5PKi
         rvjTfL+QXHRVXpO4iZeElhdbRDLo4L38oXBnraSsCBXJpJ6cCcH6f6lyvhKXPa48puqi
         d9TLkgZNocyJl5WeakIMI4x2dWhhL1UCOH3KlldcBdUgwRLztTIn2j0JQRerQgHdgOmc
         o4HQ25eYGUObUdCX7nut5Ol7MrsUzqOc6DBeDdpz69MytfwMOvDPSpQw0iXQej40XOHB
         uCBPdC4bLim1zfdWWqLGouWSOmDMsvNStbgNfVgMEYllidJ/KSMggGhE+84bnZqK9mSf
         P5og==
X-Gm-Message-State: ACgBeo3Lcpyyb4lTnIng8LFPHzfxj+A7tYPqb6T1AFE++E4JLOfBteY8
        4o7q/f5M7RSnrJ+ZSbfNpFRnLkddgWOkFQ==
X-Google-Smtp-Source: AA6agR597gAKptNW/vNJh1gg7SQ1F4FP63qGwg/YW9xKLWgpmPw3CzRj7efENM1PnBcfOnj1Y/FJ8Q==
X-Received: by 2002:a5d:4811:0:b0:21e:3d86:a2df with SMTP id l17-20020a5d4811000000b0021e3d86a2dfmr1698380wrq.633.1659083157913;
        Fri, 29 Jul 2022 01:25:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2994802wrh.17.2022.07.29.01.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:25:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] docs: de-duplicate sections, add more CONFIGURATION sections
Date:   Fri, 29 Jul 2022 10:25:46 +0200
Message-Id: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover.1657819649.git.matheus.bernardino@usp.br>
References: <cover.1657819649.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a follow-up to Matheus Tavares's v1[1] patches to
de-duplicate some of our configuration documentation, per [2] I'm
submitting this as a replacement series.

I've had this laying around for a while (around 1 1/2 yrs). Per the
diffstat we add a CONFIGURATION section to various built-ins, with the
configuration that's relevant to them.

Doing that isn't new, e.g. we do so for git-gc(1) and a few others
(see 1/9) and https://git-scm.com/docs/git-gc#_configuration; but
this takes the concept much further.

I have follow-up patches that come after this, which involve adding
even more exhaustive configuration to these sections, e.g. each
command getting its own color.* configuration when appropriate. Doing
that requires splitting up the Documentation/config/*.txt files into
sub-includes.

This series stops just short of that.

1. https://lore.kernel.org/git/cover.1657819649.git.matheus.bernardino@usp.br/
2. https://lore.kernel.org/git/CAHd-oW6ompHPJ_8X6XqwBJs8mda52a=NJge7=AwVwuEg-9VHZw@mail.gmail.com/

Ævar Arnfjörð Bjarmason (9):
  docs: add and use include template for config/* includes
  grep docs: de-duplicate configuration sections
  send-email docs: de-duplicate configuration sections
  apply docs: de-duplicate configuration sections
  notes docs: de-duplicate configuration sections
  difftool docs: de-duplicate configuration sections
  log docs: de-duplicate configuration sections
  docs: add CONFIGURATION sections that map to a built-in
  docs: add CONFIGURATION sections that fuzzy map to built-ins

 Documentation/Makefile                        |  1 +
 Documentation/config/diff.txt                 | 15 ------
 Documentation/config/difftool.txt             | 28 ++++++++--
 Documentation/config/grep.txt                 |  7 ++-
 Documentation/config/log.txt                  | 18 +++++--
 Documentation/config/notes.txt                | 43 +++++++++------
 Documentation/config/sendemail.txt            | 40 ++++++++++++--
 Documentation/git-add.txt                     |  7 +++
 Documentation/git-am.txt                      |  7 +++
 Documentation/git-apply.txt                   | 10 ++--
 Documentation/git-blame.txt                   |  6 +++
 Documentation/git-branch.txt                  |  4 ++
 Documentation/git-checkout.txt                |  7 +++
 Documentation/git-clean.txt                   |  7 +++
 Documentation/git-clone.txt                   |  9 ++++
 Documentation/git-column.txt                  |  7 +++
 Documentation/git-commit-graph.txt            |  7 +++
 Documentation/git-commit.txt                  |  4 ++
 Documentation/git-diff.txt                    |  7 +++
 Documentation/git-difftool.txt                | 27 ++--------
 Documentation/git-fast-import.txt             |  7 +++
 Documentation/git-fetch.txt                   |  7 +++
 Documentation/git-fsck.txt                    |  2 +
 Documentation/git-gc.txt                      |  3 +-
 Documentation/git-grep.txt                    | 29 +---------
 Documentation/git-imap-send.txt               |  2 +
 Documentation/git-log.txt                     | 49 +++--------------
 Documentation/git-mailinfo.txt                |  7 +++
 Documentation/git-maintenance.txt             |  7 +++
 Documentation/git-merge.txt                   |  5 +-
 Documentation/git-mergetool.txt               |  3 ++
 Documentation/git-notes.txt                   | 54 ++-----------------
 Documentation/git-push.txt                    |  7 +++
 Documentation/git-rebase.txt                  |  2 +
 Documentation/git-revert.txt                  |  7 +++
 Documentation/git-send-email.txt              | 36 +------------
 Documentation/git-show-branch.txt             |  7 +++
 Documentation/git-stash.txt                   |  7 +++
 Documentation/git-switch.txt                  |  7 +++
 .../includes/cmd-config-section-all.txt       |  3 ++
 .../includes/cmd-config-section-rest.txt      |  3 ++
 41 files changed, 284 insertions(+), 231 deletions(-)
 create mode 100644 Documentation/includes/cmd-config-section-all.txt
 create mode 100644 Documentation/includes/cmd-config-section-rest.txt

Range-diff against v1:
 -:  ----------- >  1:  ef6fa5450e7 docs: add and use include template for config/* includes
 1:  f3b275fd5b5 !  2:  5f07f87710c doc: grep: unify configuration variables definitions
    @@
      ## Metadata ##
    -Author: Matheus Tavares <matheus.bernardino@usp.br>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    doc: grep: unify configuration variables definitions
    +    grep docs: de-duplicate configuration sections
     
    -    The configuration variables for git-grep are duplicated in
    -    "Documentation/git-grep.txt" and "Documentation/config/grep.txt", which
    -    gqcan make maintenance difficult. The first also contains a definition
    -    that is not present in the latter (grep.fullName), and the latter
    -    received a wording improvement that was not replicated in the former:
    -    see 91028f765 ("grep: clarify what `grep.patternType=default` means",
    -    2021-12-05).
    +    Include the "config/grep.txt" file in "git-grep.txt", instead of
    +    repeating an almost identical description of the "grep" configuration
    +    variables in two places.
     
    -    To avoid such problems, unify the information in one file and include it
    -    in the other.
    +    There is no loss of information here that isn't shown in the addition
    +    to "grep.txt". This change was made by copying the contents of
    +    "git-grep.txt"'s version over the "grep.txt" version. Aside from the
    +    change "grep.txt" being made here the two were identical.
     
    -    Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
    +    This documentation started being copy/pasted around in
    +    b22520a37c8 (grep: allow -E and -n to be turned on by default via
    +    configuration, 2011-03-30). After that in e.g. 6453f7b3486 (grep: add
    +    grep.fullName config variable, 2014-03-17) they started drifting
    +    apart, with only grep.fullName being described in the command
    +    documentation.
    +
    +    In 434e6e753fe (config.txt: move grep.* to a separate file,
    +    2018-10-27) we gained the include, but didn't do this next step, let's
    +    do it now.
    +
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/config/grep.txt ##
     @@ Documentation/config/grep.txt: grep.extendedRegexp::
    @@ Documentation/config/grep.txt: grep.extendedRegexp::
      grep.threads::
     -	Number of grep worker threads to use.
     -	See `grep.threads` in linkgit:git-grep[1] for more information.
    -+	Number of grep worker threads to use. See `--threads`
    -+ifndef::git-grep[]
    -+	in linkgit:git-grep[1]
    -+endif::git-grep[]
    -+	for more information.
    ++	Number of grep worker threads to use. If unset (or set to 0), Git will
    ++	use as many threads as the number of logical cores available.
     +
     +grep.fullName::
     +	If set to true, enable `--full-name` option by default.
    @@ Documentation/config/grep.txt: grep.extendedRegexp::
      	If set to true, fall back to git grep --no-index if git grep
     
      ## Documentation/git-grep.txt ##
    -@@ Documentation/git-grep.txt: registered in the index file, or blobs in given tree objects.  Patterns
    - are lists of one or more search expressions separated by newline
    - characters.  An empty string as search expression matches all lines.
    - 
    --
    - OPTIONS
    - -------
    - --cached::
    -@@ Documentation/git-grep.txt: providing this option will cause it to die.
    - 	a non-zero status.
    - 
    - --threads <num>::
    --	Number of grep worker threads to use.
    --	See `grep.threads` in 'CONFIGURATION' for more information.
    -+	Number of grep worker threads to use. If not provided (or set to
    -+	0), Git will use as many worker threads as the number of logical
    -+	cores available. The default value can also be set with the
    -+	`grep.threads` configuration.
    - 
    - -f <file>::
    - 	Read patterns from <file>, one per line.
     @@ Documentation/git-grep.txt: performance in this case, it might be desirable to use `--threads=1`.
      CONFIGURATION
      -------------
    @@ Documentation/git-grep.txt: performance in this case, it might be desirable to u
     -grep.fallbackToNoIndex::
     -	If set to true, fall back to git grep --no-index if git grep
     -	is executed outside of a git repository.  Defaults to false.
    --
    -+:git-grep: 1
    ++include::includes/cmd-config-section-all.txt[]
    + 
     +include::config/grep.txt[]
      
      GIT
 -:  ----------- >  3:  8138dc54e3e send-email docs: de-duplicate configuration sections
 2:  d40ed2c351f !  4:  b9750ae43e1 doc: apply: unify configuration variables definitions
    @@
      ## Metadata ##
    -Author: Matheus Tavares <matheus.bernardino@usp.br>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    doc: apply: unify configuration variables definitions
    +    apply docs: de-duplicate configuration sections
     
    -    Note that apply.ignoreWhitespace and apply.whitespace are defined with
    -    slightly different wordings at git-apply.txt and config/apply.txt.
    -    Nevertheless, there is no loss of information from using one or the
    -    other, so I kept the latter for the single unified definition.
    +    The wording is not identical to Documentation/config/apply.txt, but
    +    that version is better.
     
    -    Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
    -
    - ## Documentation/config/apply.txt ##
    -@@ Documentation/config/apply.txt: apply.ignoreWhitespace::
    - 	option.
    - 	When set to one of: no, none, never, false tells 'git apply' to
    - 	respect all whitespace differences.
    -+ifndef::git-apply[]
    - 	See linkgit:git-apply[1].
    -+endif::git-apply[]
    - 
    - apply.whitespace::
    - 	Tells 'git apply' how to handle whitespaces, in the same way
    --	as the `--whitespace` option. See linkgit:git-apply[1].
    -+	as the `--whitespace` option.
    -+ifndef::git-apply[]
    -+	See linkgit:git-apply[1].
    -+endif::git-apply[]
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-apply.txt ##
     @@ Documentation/git-apply.txt: has no effect when `--index` or `--cached` is in use.
    @@ Documentation/git-apply.txt: has no effect when `--index` or `--cached` is in us
     -apply.whitespace::
     -	When no `--whitespace` flag is given from the command
     -	line, this configuration item is used as the default.
    -+:git-apply: 1
    ++include::includes/cmd-config-section-all.txt[]
    ++
     +include::config/apply.txt[]
      
      SUBMODULES
 3:  5338d50c99c !  5:  1b6c8c75df7 doc: notes: unify configuration variables definitions
    @@
      ## Metadata ##
    -Author: Matheus Tavares <matheus.bernardino@usp.br>
    +Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    doc: notes: unify configuration variables definitions
    +    notes docs: de-duplicate configuration sections
     
    -    Unify duplicated configuration descriptions from git-notes.txt and
    -    config.txt in order to facilitate maintenance and update. There are some
    -    discrepancies between these two files: git-notes.txt received two
    -    updates that were not made in config.txt: see 66c4c32
    -    ("Documentation/notes: simplify treatment of default display refs",
    -    2010-05-08) and c5ce183 ("Documentation/notes: clean up description of
    -    rewriting configuration", 2010-05-08 ). And there was also an update to
    -    config.txt not propagated to git-notes.txt: see 2b4aa89 ("Documentation:
    -    basic configuration of notes.rewriteRef", 2011-09-13). Let's make sure
    -    to include all these three updates in the unified version.
    +    Let's also fix the "git-notes(1)" docs so that we link to
    +    "git-config(1)", not "git-log(1)" as a reference for the "notes" docs.
     
    -    Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/config/notes.txt ##
     @@ Documentation/config/notes.txt: notes.mergeStrategy::
    - 	Which merge strategy to choose by default when resolving notes
      	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
      	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
    --	section of linkgit:git-notes[1] for more information on each strategy.
    -+	section
    -+ifdef::git-notes[above]
    -+ifndef::git-notes[of linkgit:git-notes[1]]
    -+	for more information on each strategy.
    + 	section of linkgit:git-notes[1] for more information on each strategy.
    +++
    ++This setting can be overridden by passing the `--strategy` option to
    ++linkgit:git-notes[1].
      
      notes.<name>.mergeStrategy::
      	Which merge strategy to choose when doing a notes merge into
    - 	refs/notes/<name>.  This overrides the more general
    --	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section in
    --	linkgit:git-notes[1] for more information on the available strategies.
    -+	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section
    -+ifdef::git-notes[above]
    -+ifndef::git-notes[in linkgit:git-notes[1]]
    -+	for more information on the available strategies.
    +@@ Documentation/config/notes.txt: notes.<name>.mergeStrategy::
    + 	linkgit:git-notes[1] for more information on the available strategies.
      
      notes.displayRef::
     -	The (fully qualified) refname from which to show notes when
    @@ Documentation/config/notes.txt: notes.mergeStrategy::
     -	several times.  A warning will be issued for refs that do not
     -	exist, but a glob that does not match any refs is silently
     -	ignored.
    --+
    --This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
    --environment variable, which must be a colon separated list of refs or
    --globs.
    --+
    --The effective value of "core.notesRef" (possibly overridden by
    --GIT_NOTES_REF) is also implicitly added to the list of refs to be
    --displayed.
     +	Which ref (or refs, if a glob or specified more than once), in
     +	addition to the default set by `core.notesRef` or
     +	`GIT_NOTES_REF`, to read notes from when showing commit
     +	messages with the 'git log' family of commands.
    -+	This setting can be overridden on the command line or by the
    -+	`GIT_NOTES_DISPLAY_REF` environment variable.
    -+	See linkgit:git-log[1].
    + +
    + This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
    + environment variable, which must be a colon separated list of refs or
    + globs.
    + +
    ++A warning will be issued for refs that do not exist,
    ++but a glob that does not match any refs is silently ignored.
    +++
    ++This setting can be disabled by the `--no-notes` option to the 'git
    ++log' family of commands, or by the `--notes=<ref>` option accepted by
    ++those commands.
    +++
    + The effective value of "core.notesRef" (possibly overridden by
    + GIT_NOTES_REF) is also implicitly added to the list of refs to be
    + displayed.
      
      notes.rewrite.<command>::
      	When rewriting commits with <command> (currently `amend` or
    @@ Documentation/config/notes.txt: notes.mergeStrategy::
     +	notes from the original to the rewritten commit.  Defaults to
     +	`true`.  See also "`notes.rewriteRef`" below.
     ++
    -+This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
    -+environment variable.
    ++This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
    ++environment variable, which must be a colon separated list of refs or
    ++globs.
      
      notes.rewriteMode::
    --	When copying notes during a rewrite (see the
    --	"notes.rewrite.<command>" option), determines what to do if
    --	the target commit already has a note.  Must be one of
    --	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
    --	Defaults to `concatenate`.
    -+	When copying notes during a rewrite, what to do if the target
    -+	commit already has a note.  Must be one of `overwrite`,
    -+	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
    -+	`concatenate`.
    - +
    - This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
    - environment variable.
    + 	When copying notes during a rewrite (see the
    +@@ Documentation/config/notes.txt: environment variable.
      
      notes.rewriteRef::
      	When copying notes during a rewrite, specifies the (fully
    @@ Documentation/config/notes.txt: notes.mergeStrategy::
     -environment variable, which must be a colon separated list of refs or
     -globs.
     +Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.
    ++See `notes.rewrite.<command>` above for a further description of its format.
    +
    + ## Documentation/git-log.txt ##
    +@@ Documentation/git-log.txt: log.showSignature::
    + mailmap.*::
    + 	See linkgit:git-shortlog[1].
    + 
    +-notes.displayRef::
    +-	Which refs, in addition to the default set by `core.notesRef`
    +-	or `GIT_NOTES_REF`, to read notes from when showing commit
    +-	messages with the `log` family of commands.  See
    +-	linkgit:git-notes[1].
    +-+
    +-May be an unabbreviated ref name or a glob and may be specified
    +-multiple times.  A warning will be issued for refs that do not exist,
    +-but a glob that does not match any refs is silently ignored.
    +-+
    +-This setting can be disabled by the `--no-notes` option,
    +-overridden by the `GIT_NOTES_DISPLAY_REF` environment variable,
    +-and overridden by the `--notes=<ref>` option.
    ++include::includes/cmd-config-section-rest.txt[]
    ++
    ++include::config/notes.txt[]
    + 
    + GIT
    + ---
     
      ## Documentation/git-notes.txt ##
    +@@ Documentation/git-notes.txt: using the `--notes` option. Such notes are added as a patch commentary
    + after a three dash separator line.
    + 
    + To change which notes are shown by 'git log', see the
    +-"notes.displayRef" configuration in linkgit:git-log[1].
    ++"notes.displayRef" configuration in linkgit:git-config[1].
    + 
    + See the "notes.rewrite.<command>" configuration for a way to carry
    + notes across commands that rewrite commits.
     @@ Documentation/git-notes.txt: core.notesRef::
      	This setting can be overridden through the environment and
      	command line.
    @@ Documentation/git-notes.txt: core.notesRef::
     -+
     -This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
     -environment variable.
    --
    ++include::includes/cmd-config-section-rest.txt[]
    + 
     -notes.rewriteMode::
     -	When copying notes during a rewrite, what to do if the target
     -	commit already has a note.  Must be one of `overwrite`,
    @@ Documentation/git-notes.txt: core.notesRef::
     -enable note rewriting.
     -+
     -Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.
    --
    -+:git-notes: 1
     +include::config/notes.txt[]
      
    + 
      ENVIRONMENT
    - -----------
 -:  ----------- >  6:  b3a5ea46bb5 difftool docs: de-duplicate configuration sections
 -:  ----------- >  7:  08d98767384 log docs: de-duplicate configuration sections
 -:  ----------- >  8:  5c379ab1476 docs: add CONFIGURATION sections that map to a built-in
 -:  ----------- >  9:  91689154926 docs: add CONFIGURATION sections that fuzzy map to built-ins
-- 
2.37.1.1196.g8af3636bc64

