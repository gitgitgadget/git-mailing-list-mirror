Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66416C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 20:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiGLUHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiGLUHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 16:07:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3913CB31E0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:07:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v16so12648720wrd.13
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujjRGSFgVPsa9nSIA1nuTtHphmSJDmrEh8x/aYu1e8w=;
        b=VKSMi5deU4bkavmgRKtDtNdOUnwPWwoUqL6g63Qbh4cABpH2FZciqQLPo2aZ2ldKQ/
         YOah49kyPbWie0IvAOcRj9NGtjl3MLDtS0zUFIsOPGx6vC8i+kq+j0zT7sXpwx6FlFhn
         L0WTQt8Ob/m5UFH8G1l7/O6Wt5OHlrAzWRas+G6ItQ9HxhPMSiXCpCGEzQMfVDXmf1hf
         B+wKgzDi1tl95wvDaGaoftHDP4yszJ1iZD+Z3FnFQ+FY6JmgWYDIfltKcXge4M+QLj14
         1dym9YztfD6v+gYQJ/irTsX+MKWq5P9hDEroa7KKTOtQ+O9HF2S/VHSfaOrMaUmkkV2m
         049w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujjRGSFgVPsa9nSIA1nuTtHphmSJDmrEh8x/aYu1e8w=;
        b=l+akpGflDSsnmWAb5UxSEK1WiiNa/FES/d+2SdxUmAFaE7a5sRR3ZHqOMgDU2Nv+J3
         Zswj5kXXFlcO4q5kbU3Mij/GK9IorBCPIfLG1Cq5cjbk8jcH//EJyC/7gdIdkLfRm91r
         09pRNFii6Hqk23eHzLa5BOQdAqraj29aJTbWtatIRpCSUKLlKEbZ3y93PVcGlSMTePNT
         ETvCRyivPmfN05c1eaXNOM1+LBdNvQGy2wN5+zLSlMKyWQDDCEbiJHILzLxrU2T3Kjfl
         Moi07lG5oWDxsN3DseC6wOyJZzowFWMjcaBRTVBfm7bxjemh1V6p0w6QN94TA9kcF/ny
         CUXA==
X-Gm-Message-State: AJIora/Xsv3yBOYC7BLlWaoLRlvuSLhnh6Qy98KAPNLKZBeSf+EdXL2L
        eNndpH5IrLsqZqxaCPJ3nXlB0c2T+vo=
X-Google-Smtp-Source: AGRyM1tSSR7lLUL9baY6XBQSXvriG1U88e7rbIZli/XEJvTeeaMu5Fzo74x1+a312euzzQgaIsa3cQ==
X-Received: by 2002:a05:6000:1ac9:b0:21d:a85c:298b with SMTP id i9-20020a0560001ac900b0021da85c298bmr10278032wry.185.1657656430493;
        Tue, 12 Jul 2022 13:07:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b5-20020adfe305000000b0021d8c8c79dbsm8929448wrj.65.2022.07.12.13.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:07:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/7] git doc + "git help": move "format" docs from technical/*
Date:   Tue, 12 Jul 2022 22:06:55 +0200
Message-Id: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series improves the accessability of our documentation by moving
much of the documentation about user and developer-facing "formats" to
our main documentation namespace.

I.e. they'll be installed as part of "make install-doc" etc, most of
our docs avoid referring to these, and when they do they refer to the
html versions. Now the manual pages will be self-contained, without
any need to visit these in a browser.

A "user format" is defined broadly as a file format (or similar) that
a user might need to interact with or edit. This contains some manual
pages that are now in --guides:

	$ git help --user-formats
	Git user-facing file formats:
	   attributes          Defining attributes per path
	   hooks               Hooks used by Git
	   ignore              Specifies intentionally untracked files to ignore
	   mailmap             Map author/committer names and/or E-Mail addresses
	   modules             Defining submodule properties
	   repository-layout   Git Repository Layout

All of that exists already, it's just in its own category now,
i.e. not with the likes of "tutorial" etc.

But this is new, all of these docs were previously languishing in
Documentation/techical/, but are now built as manual pages:

	$ git help --git-formats
	Internal file formats and protocols:
	   format-bundle                  The bundle file format
	   format-chunk                   Chunk-based file formats
	   format-commit-graph            Git commit graph format
	   format-index                   Git index format
	   format-multi-pack-index        The multi-pack-index file format
	   format-pack                    Git pack format
	   format-pack-bitmap             The bitmap file format
	   format-pack-cruft              The cruft pack file format
	   format-pack-protocol           How packs are transferred over-the-wire
	   format-protocol-capabilities   Protocol v0 and v1 capabilities
	   format-protocol-common         Things common to various protocols
	   format-protocol-http           Git HTTP-based protocols
	   format-protocol-v2             Git Wire Protocol, Version 2
	   format-signature               Git cryptographic signature formats

See [1] for the v2. This series took a while to re-roll because there
have been various painful conflicts in-flight work in
Documentation/techical/ in the interim. There's a minor conflict here
with ac/bitmap-lookup-table, see below:

Changes since v2:

 * Fix SYNOPSIS, usage etc.
 * The --user-formats and --git-formats now skip the "git" prefix,
   like --guides did.
 * Updated the help descriptions / title sections (see range-diff)
 * The cruft pack format is now included, as well as this being
   re-rolled for other changes in Documentation/techical/
 * Moved all the pack formats under gitformat-pack-*
 * Fixed some more cross-links to the now-moved
   Documentation/techical/ docs.
 * Move more docs to --git-formats (which previously conflicted)

1. https://lore.kernel.org/git/cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com/

For Junio: There's a conflict here with ac/bitmap-lookup-table in
"seen", which can be solved thusly (remerge-diff output):
	
	diff --git a/Documentation/gitformat-pack-bitmap.txt b/Documentation/gitformat-pack-bitmap.txt
	remerge CONFLICT (content): Merge conflict in Documentation/gitformat-pack-bitmap.txt
	index b01a3a202e8..136fd0c1b71 100644
	--- a/Documentation/gitformat-pack-bitmap.txt
	+++ b/Documentation/gitformat-pack-bitmap.txt
	@@ -248,13 +248,8 @@ If implementations want to choose a different hashing scheme, they are
	 free to do so, but MUST allocate a new header flag (because comparing
	 hashes made under two different schemes would be pointless).
	 
	-<<<<<<< aabdc4a4151 (docs: move multi-pack-index docs to man section 5):Documentation/gitformat-pack-bitmap.txt
	-GIT
	----
	-Part of the linkgit:git[1] suite
	-=======
	 Commit lookup table
	--------------------
	+~~~~~~~~~~~~~~~~~~~
	 
	 If the BITMAP_OPT_LOOKUP_TABLE flag is set, the last `N * (4 + 8 + 4)`
	 bytes (preceding the name-hash cache and trailing hash) of the `.bitmap`
	@@ -280,4 +275,7 @@ triplet is -
	 	xor_row (4 byte integer, network byte order): ::
	 	The position of the triplet whose bitmap is used to compress
	 	this one, or `0xffffffff` if no such bitmap exists.
	->>>>>>> 135e1ec09aa (Merge branch 'sa/cat-file-mailmap' into seen):Documentation/technical/bitmap-format.txt
	+
	+GIT
	+---
	+Part of the linkgit:git[1] suite

I.e. the new "GIT" section needs to come last (as check-docs will
report), but otherwise it's a union of the two, *except* that the
"Commit lookup table" needs to use "~" for the section, not "-".
	

Ævar Arnfjörð Bjarmason (7):
  git docs: split "User-facing file formats" off from "Guides"
  git docs: create a "Git file formats and protocols" section
  docs: move commit-graph format docs to man section 5
  docs: move protocol-related docs to man section 5
  docs: move pack format docs to man section 5
  docs: move http-protocol docs to man section 5
  docs: move multi-pack-index docs to man section 5

 Documentation/Makefile                        | 28 ++++++-----
 Documentation/config/lsrefs.txt               |  2 +-
 Documentation/config/pack.txt                 |  2 +-
 Documentation/config/protocol.txt             |  2 +-
 Documentation/git-bundle.txt                  | 11 +++--
 Documentation/git-commit-graph.txt            |  5 ++
 Documentation/git-help.txt                    | 14 ++++--
 Documentation/git-multi-pack-index.txt        |  7 +--
 Documentation/git-upload-pack.txt             |  7 ++-
 Documentation/git.txt                         | 15 ++++++
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++---
 .../chunk-format.txt => gitformat-chunk.txt}  | 27 ++++++++--
 ...-format.txt => gitformat-commit-graph.txt} | 49 +++++++++++++------
 .../index-format.txt => gitformat-index.txt}  | 22 ++++++++-
 ...dex.txt => gitformat-multi-pack-index.txt} | 20 +++++++-
 ...p-format.txt => gitformat-pack-bitmap.txt} | 38 +++++++++++---
 ...uft-packs.txt => gitformat-pack-cruft.txt} | 22 ++++++++-
 ...otocol.txt => gitformat-pack-protocol.txt} | 26 ++++++++--
 .../pack-format.txt => gitformat-pack.txt}    | 39 +++++++++++++--
 ...xt => gitformat-protocol-capabilities.txt} | 28 ++++++++---
 ...mmon.txt => gitformat-protocol-common.txt} | 23 ++++++++-
 ...otocol.txt => gitformat-protocol-http.txt} | 35 ++++++++++---
 ...tocol-v2.txt => gitformat-protocol-v2.txt} | 26 ++++++++--
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++--
 .../howto/recover-corrupted-object-harder.txt |  2 +-
 Documentation/lint-man-section-order.perl     |  3 ++
 Documentation/technical/api-simple-ipc.txt    |  2 +-
 .../technical/hash-function-transition.txt    |  2 +-
 .../long-running-process-protocol.txt         |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 Documentation/user-manual.txt                 |  2 +-
 Makefile                                      |  1 +
 builtin/help.c                                | 18 ++++++-
 cache.h                                       |  3 +-
 command-list.txt                              | 34 ++++++++++---
 help.c                                        | 29 ++++++++++-
 help.h                                        |  2 +
 pack-revindex.h                               |  2 +-
 t/t0012-help.sh                               | 14 +++++-
 t/t5551-http-fetch-smart.sh                   |  4 +-
 40 files changed, 513 insertions(+), 122 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (79%)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (90%)
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (87%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/multi-pack-index.txt => gitformat-multi-pack-index.txt} (94%)
 rename Documentation/{technical/bitmap-format.txt => gitformat-pack-bitmap.txt} (91%)
 rename Documentation/{technical/cruft-packs.txt => gitformat-pack-cruft.txt} (96%)
 rename Documentation/{technical/pack-protocol.txt => gitformat-pack-protocol.txt} (98%)
 rename Documentation/{technical/pack-format.txt => gitformat-pack.txt} (95%)
 rename Documentation/{technical/protocol-capabilities.txt => gitformat-protocol-capabilities.txt} (96%)
 rename Documentation/{technical/protocol-common.txt => gitformat-protocol-common.txt} (88%)
 rename Documentation/{technical/http-protocol.txt => gitformat-protocol-http.txt} (97%)
 rename Documentation/{technical/protocol-v2.txt => gitformat-protocol-v2.txt} (97%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)

Range-diff against v2:
1:  960574b7f05 ! 1:  929d9192828 git docs: split "User-facing file formats" off from "Guides"
    @@ Documentation/git-help.txt
     @@ Documentation/git-help.txt: SYNOPSIS
      --------
      [verse]
    - 'git help' [-a|--all [--[no-]verbose]]
    --	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
    -+	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>|<doc>]
    + 'git help' [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]
    +-'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
    ++'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>|<doc>]
      'git help' [-g|--guides]
      'git help' [-c|--config]
     +'git help' [--user-formats]
    @@ builtin/help.c: static struct option builtin_help_options[] = {
      	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
      		    HELP_ACTION_CONFIG),
      	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
    -@@ builtin/help.c: static const char * const builtin_help_usage[] = {
    - 	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
    - 	N_("git help [-g|--guides]"),
    - 	N_("git help [-c|--config]"),
    -+	N_("git help [--user-formats]"),
    +@@ builtin/help.c: static struct option builtin_help_options[] = {
    + 
    + static const char * const builtin_help_usage[] = {
    + 	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
    +-	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
    ++	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
    + 	"git help [-g|--guides]",
    + 	"git help [-c|--config]",
    ++	"git help [--user-formats]",
      	NULL
      };
      
     @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
    - 		no_extra_argc(argc);
    + 		opt_mode_usage(argc, "--config-for-completion", help_format);
      		list_config_help(SHOW_CONFIG_VARS);
      		return 0;
     +	case HELP_ACTION_USER_FORMATS:
    -+		no_extra_argc(argc);
    ++		opt_mode_usage(argc, "--user-formats", help_format);
     +		list_user_formats_help();
     +		return 0;
      	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
    - 		no_extra_argc(argc);
    - 		list_config_help(SHOW_CONFIG_SECTIONS);
    + 		opt_mode_usage(argc, "--config-sections-for-completion",
    + 			       help_format);
     
      ## command-list.txt ##
     @@
    @@ help.c: static struct category_description main_categories[] = {
      	{ CAT_plumbinginterrogators, N_("Low-level Commands / Interrogators") },
      	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
      	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
    -+	{ CAT_userformats, N_("User-facing file formats") },
    ++	{ CAT_userformats, N_("Git user-facing file formats") },
      	{ 0, NULL }
      };
      
    +@@ help.c: static const char *drop_prefix(const char *name, uint32_t category)
    + 
    + 	if (skip_prefix(name, "git-", &new_name))
    + 		return new_name;
    +-	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
    ++	switch (category) {
    ++	case CAT_guide:
    ++	case CAT_userformats:
    ++		skip_prefix(name, "git", &new_name);
    + 		return new_name;
    ++	}
    + 	return name;
    + 
    + }
     @@ help.c: void list_guides_help(void)
      	putchar('\n');
      }
    @@ help.c: void list_guides_help(void)
     +void list_user_formats_help(void)
     +{
     +	struct category_description catdesc[] = {
    -+		{ CAT_userformats, N_("The user-facing file formats are:") },
    ++		{ CAT_userformats, N_("Git user-facing file formats:") },
     +		{ 0, NULL }
     +	};
     +	print_cmd_by_category(catdesc, NULL);
    @@ help.c: void list_guides_help(void)
      ## help.h ##
     @@ help.h: static inline void mput_char(char c, unsigned int num)
      void list_common_cmds_help(void);
    - void list_all_cmds_help(void);
    + void list_all_cmds_help(int show_external_commands, int show_aliases);
      void list_guides_help(void);
     +void list_user_formats_help(void);
      
    @@ t/t0012-help.sh: test_expect_success 'git help' '
      	test_i18ngrep "^   commit " help.output &&
      	test_i18ngrep "^   fetch  " help.output
      '
    -+
    -+test_expect_success 'git help -a' '
    -+	git help -a >help.output &&
    -+	grep "^Main Porcelain Commands" help.output &&
    -+	grep "^User-facing file formats" help.output
    -+'
     +
      test_expect_success 'git help -g' '
      	git help -g >help.output &&
    @@ t/t0012-help.sh: test_expect_success 'git help succeeds without git.html' '
      	test_cmp expect test-browser.log
      '
      
    -+test_expect_success 'git help --formats' '
    ++test_expect_success 'git help --user-formats' '
     +	git help --user-formats >help.output &&
    -+	grep "^   gitattributes   " help.output &&
    -+	grep "^   gitmailmap   " help.output
    ++	grep "^   attributes   " help.output &&
    ++	grep "^   mailmap   " help.output
     +'
     +
      test_expect_success 'git help -c' '
      	git help -c >help.output &&
      	cat >expect <<-\EOF &&
    +@@ t/t0012-help.sh: test_expect_success "'git help -a' section spacing" '
    + 	Low-level Commands / Syncing Repositories
    + 
    + 	Low-level Commands / Internal Helpers
    ++
    ++	Git user-facing file formats
    + 	EOF
    + 	test_cmp expect actual
    + '
2:  b2d73f8c9da ! 2:  1fd57d5caf4 git docs: create a "Git file and wire formats" section
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git docs: create a "Git file and wire formats" section
    +    git docs: create a "Git file formats and protocols" section
     
    -    Create a new "Git file and wire formats" section in the main "git help
    +    Create a new "Git file formats and protocols" section in the main "git help
         git" manual page and start moving the documentation that now lives in
         "Documentation/technical/*.git" over to it. This compliments the newly
         added and adjacent "User-facing file formats" section.
    @@ Documentation/Makefile: MAN1_TXT += gitweb.txt
      MAN5_TXT += githooks.txt
      MAN5_TXT += gitignore.txt
      MAN5_TXT += gitmailmap.txt
    -@@ Documentation/Makefile: SP_ARTICLES += $(API_DOCS)
    - TECH_DOCS += MyFirstContribution
    - TECH_DOCS += MyFirstObjectWalk
    +@@ Documentation/Makefile: TECH_DOCS += MyFirstObjectWalk
      TECH_DOCS += SubmittingPatches
    + TECH_DOCS += ToolsForGit
    + TECH_DOCS += technical/bitmap-format
     -TECH_DOCS += technical/bundle-format
    + TECH_DOCS += technical/cruft-packs
      TECH_DOCS += technical/hash-function-transition
      TECH_DOCS += technical/http-protocol
    - TECH_DOCS += technical/index-format
     @@ Documentation/Makefile: cmds_txt = cmds-ancillaryinterrogators.txt \
      	cmds-synchelpers.txt \
      	cmds-guide.txt \
    @@ Documentation/git-bundle.txt: You can also see what references it offers:
      ---
      Part of the linkgit:git[1] suite
     
    + ## Documentation/git-help.txt ##
    +@@ Documentation/git-help.txt: SYNOPSIS
    + 'git help' [-g|--guides]
    + 'git help' [-c|--config]
    + 'git help' [--user-formats]
    ++'git help' [--git-formats]
    + 
    + DESCRIPTION
    + -----------
    +
      ## Documentation/git.txt ##
     @@ Documentation/git.txt: edit. These can also be listed with 'git help --user-formats'.
      
      include::cmds-userformats.txt[]
      
    -+Git file and wire formats
    -+-------------------------
    ++Git file formats and protocols
    ++------------------------------
     +
    -+This documentation discusses the file and wire formats that git itself
    -+uses. These can also be listed with 'git help --git-formats'.
    ++This documentation discusses the file formats and protocols that git
    ++itself uses. These can also be listed with 'git help --git-formats'.
     +
     +include::cmds-gitformats.txt[]
     +
    @@ Documentation/gitformat-bundle.txt: In the bundle format, there can be a comment
     +------------
      
      Because there is no opportunity for negotiation, unknown capabilities cause 'git
    - bundle' to abort.  The only known capability is `object-format`, which specifies
    - the hash algorithm in use, and can take the same values as the
    - `extensions.objectFormat` configuration value.
    + bundle' to abort.
    +@@ Documentation/gitformat-bundle.txt: bundle' to abort.
    + * `filter` specifies an object filter as in the `--filter` option in
    +   linkgit:git-rev-list[1]. The resulting pack-file must be marked as a
    +   `.promisor` pack-file after it is unbundled.
     +
     +GIT
     +---
    @@ builtin/help.c: static struct option builtin_help_options[] = {
      		    HELP_ACTION_GUIDES),
      	OPT_CMDMODE(0, "user-formats", &cmd_mode, N_("print list of user-facing file formats"),
      		    HELP_ACTION_USER_FORMATS),
    -+	OPT_CMDMODE(0, "git-formats", &cmd_mode, N_("print list of Git's own file and network formats"),
    ++	OPT_CMDMODE(0, "git-formats", &cmd_mode, N_("print list of internal file formats and network protocols"),
     +		    HELP_ACTION_GIT_FORMATS),
      	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
      		    HELP_ACTION_CONFIG),
      	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
     @@ builtin/help.c: static const char * const builtin_help_usage[] = {
    - 	N_("git help [-g|--guides]"),
    - 	N_("git help [-c|--config]"),
    - 	N_("git help [--user-formats]"),
    -+	N_("git help [--git-formats]"),
    + 	"git help [-g|--guides]",
    + 	"git help [-c|--config]",
    + 	"git help [--user-formats]",
    ++	"git help [--git-formats]",
      	NULL
      };
      
     @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
    - 		no_extra_argc(argc);
    + 		opt_mode_usage(argc, "--user-formats", help_format);
      		list_user_formats_help();
      		return 0;
     +	case HELP_ACTION_GIT_FORMATS:
    -+		no_extra_argc(argc);
    ++		opt_mode_usage(argc, "--git-formats", help_format);
     +		list_git_formats_help();
     +		return 0;
      	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
    - 		no_extra_argc(argc);
    - 		list_config_help(SHOW_CONFIG_SECTIONS);
    + 		opt_mode_usage(argc, "--config-sections-for-completion",
    + 			       help_format);
     
      ## command-list.txt ##
     @@
      # .mailmap etc. files lives in man section 5. These entries can only
      # have the "userformats" attribute and nothing else.
      #
    -+# Git's own file and network formats such as documentation for the
    -+# *.bundle format lives in mn section 5. These entries can only have
    ++# Git internal file formats and protocols, such as documentation for the
    ++# *.bundle format lives in man section 5. These entries can only have
     +# the "gitformats" attribute and nothing else.
     +#
      ### command list (do not change this line)
    @@ help.c
     @@ help.c: static struct category_description main_categories[] = {
      	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
      	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
    - 	{ CAT_userformats, N_("User-facing file formats") },
    -+	{ CAT_gitformats, N_("Internal file- and wire formats formats") },
    + 	{ CAT_userformats, N_("Git user-facing file formats") },
    ++	{ CAT_gitformats, N_("Git internal file formats and protocols") },
      	{ 0, NULL }
      };
      
    +@@ help.c: static const char *drop_prefix(const char *name, uint32_t category)
    + 	switch (category) {
    + 	case CAT_guide:
    + 	case CAT_userformats:
    ++	case CAT_gitformats:
    + 		skip_prefix(name, "git", &new_name);
    + 		return new_name;
    + 	}
     @@ help.c: void list_user_formats_help(void)
      	putchar('\n');
      }
    @@ help.c: void list_user_formats_help(void)
     +void list_git_formats_help(void)
     +{
     +	struct category_description catdesc[] = {
    -+		{ CAT_gitformats, N_("Git's internal file and network formats are:") },
    ++		{ CAT_gitformats, N_("Internal file formats and protocols:") },
     +		{ 0, NULL }
     +	};
     +	print_cmd_by_category(catdesc, NULL);
    @@ help.c: void list_user_formats_help(void)
     
      ## help.h ##
     @@ help.h: void list_common_cmds_help(void);
    - void list_all_cmds_help(void);
    + void list_all_cmds_help(int show_external_commands, int show_aliases);
      void list_guides_help(void);
      void list_user_formats_help(void);
     +void list_git_formats_help(void);
      
      void list_all_main_cmds(struct string_list *list);
      void list_all_other_cmds(struct string_list *list);
    +
    + ## t/t0012-help.sh ##
    +@@ t/t0012-help.sh: test_expect_success "'git help -a' section spacing" '
    + 	Low-level Commands / Internal Helpers
    + 
    + 	Git user-facing file formats
    ++
    ++	Git internal file formats and protocols
    + 	EOF
    + 	test_cmp expect actual
    + '
3:  5abd59b807f ! 3:  d548c6aaba7 docs: move commit-graph format docs to man section 5
    @@ Documentation/gitformat-commit-graph.txt: CHUNK DATA:
            2 bits of the lowest byte, storing the 33rd and 34th bit of the
            commit time.
      
    --  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
    -+==== Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
    +-  Generation Data (ID: {'G', 'D', 'A', '2' }) (N * 4 bytes) [Optional]
    ++==== Generation Data (ID: {'G', 'D', 'A', '2' }) (N * 4 bytes) [Optional]
          * This list of 4-byte values store corrected commit date offsets for the
            commits, arranged in the same order as commit data chunk.
          * If the corrected commit date offset cannot be stored within 31 bits,
    @@ Documentation/gitformat-commit-graph.txt: CHUNK DATA:
            by compatible versions of Git and in case of split commit-graph chains,
            the topmost layer also has Generation Data chunk.
      
    --  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
    -+==== Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
    +-  Generation Data Overflow (ID: {'G', 'D', 'O', '2' }) [Optional]
    ++==== Generation Data Overflow (ID: {'G', 'D', 'O', '2' }) [Optional]
          * This list of 8-byte values stores the corrected commit date offsets
            for commits with corrected commit date offsets that cannot be
            stored within 31 bits.
    @@ Documentation/gitformat-commit-graph.txt: CHUNK DATA:
     +=== TRAILER:
      
      	H-byte HASH-checksum of all of the above.
    + 
    +@@ Documentation/gitformat-commit-graph.txt: the number '2' in their chunk IDs because a previous version of Git wrote
    + possibly erroneous data in these chunks with the IDs "GDAT" and "GDOV". By
    + changing the IDs, newer versions of Git will silently ignore those older
    + chunks and write the new information without trusting the incorrect data.
     +
     +GIT
     +---
4:  fb91009c18f = 4:  f404987f94d docs: move protocol-related docs to man section 5
5:  5cb41bb0dcb ! 5:  6c46b4dccea docs: move {index,signature,bitmap,chunk}-format docs to man section 5
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    docs: move {index,signature,bitmap,chunk}-format docs to man section 5
    +    docs: move pack format docs to man section 5
     
         Continue the move of existing Documentation/technical/* protocol and
    -    file-format documentation into our main documentation space.
    +    file-format documentation into our main documentation space by moving
    +    the various documentation pertaining to the *.pack format and related
    +    files, and updating things that refer to it to link to the new
    +    location.
     
         By moving these we can properly link from the newly created
         gitformat-commit-graph do to a gitformat-chunk-format manpage we build
    -    by default. Let's also move the rest over for consistency.
    +    by default.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/Makefile ##
     @@ Documentation/Makefile: MAN1_TXT += gitweb.txt
    - 
      # man5 / man7 guides (note: new guides should also be added to command-list.txt)
      MAN5_TXT += gitattributes.txt
    -+MAN5_TXT += gitformat-bitmap.txt
      MAN5_TXT += gitformat-bundle.txt
     +MAN5_TXT += gitformat-chunk.txt
      MAN5_TXT += gitformat-commit-graph.txt
     +MAN5_TXT += gitformat-index.txt
    ++MAN5_TXT += gitformat-pack-bitmap.txt
    ++MAN5_TXT += gitformat-pack-cruft.txt
      MAN5_TXT += gitformat-pack-protocol.txt
    ++MAN5_TXT += gitformat-pack.txt
      MAN5_TXT += gitformat-protocol-capabilities.txt
      MAN5_TXT += gitformat-protocol-common.txt
      MAN5_TXT += gitformat-protocol-v2.txt
    @@ Documentation/Makefile: MAN1_TXT += gitweb.txt
      MAN5_TXT += githooks.txt
      MAN5_TXT += gitignore.txt
      MAN5_TXT += gitmailmap.txt
    -@@ Documentation/Makefile: TECH_DOCS += MyFirstObjectWalk
    +@@ Documentation/Makefile: TECH_DOCS += MyFirstContribution
    + TECH_DOCS += MyFirstObjectWalk
      TECH_DOCS += SubmittingPatches
    + TECH_DOCS += ToolsForGit
    +-TECH_DOCS += technical/bitmap-format
    +-TECH_DOCS += technical/cruft-packs
      TECH_DOCS += technical/hash-function-transition
      TECH_DOCS += technical/http-protocol
     -TECH_DOCS += technical/index-format
      TECH_DOCS += technical/long-running-process-protocol
      TECH_DOCS += technical/multi-pack-index
    - TECH_DOCS += technical/pack-format
    +-TECH_DOCS += technical/pack-format
    + TECH_DOCS += technical/pack-heuristics
    + TECH_DOCS += technical/parallel-checkout
    + TECH_DOCS += technical/partial-clone
     @@ Documentation/Makefile: TECH_DOCS += technical/racy-git
      TECH_DOCS += technical/reftable
      TECH_DOCS += technical/send-pack-pipeline
    @@ Documentation/Makefile: TECH_DOCS += technical/racy-git
      SP_ARTICLES += $(TECH_DOCS)
      SP_ARTICLES += technical/api-index
     
    - ## Documentation/technical/bitmap-format.txt => Documentation/gitformat-bitmap.txt ##
    + ## Documentation/config/pack.txt ##
    +@@ Documentation/config/pack.txt: permuted into their appropriate location when writing a new bitmap.
    + 
    + pack.writeReverseIndex::
    + 	When true, git will write a corresponding .rev file (see:
    +-	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
    ++	linkgit:gitformat-pack[5])
    + 	for each new packfile that it writes in all places except for
    + 	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
    + 	Defaults to false.
    +
    + ## Documentation/git-bundle.txt ##
    +@@ Documentation/git-bundle.txt: size. That they're "thin" under the hood is merely noted here as a
    + curiosity, and as a reference to other documentation.
    + 
    + See linkgit:gitformat-bundle[5] for more details and the discussion of
    +-"thin pack" in link:technical/pack-format.html[the pack format
    +-documentation] for further details.
    ++"thin pack" in linkgit:gitformat-pack[5] for further details.
    + 
    + OPTIONS
    + -------
    +
    + ## Documentation/git-multi-pack-index.txt ##
    +@@ Documentation/git-multi-pack-index.txt: $ git multi-pack-index verify
    + SEE ALSO
    + --------
    + See link:technical/multi-pack-index.html[The Multi-Pack-Index Design
    +-Document] and link:technical/pack-format.html[The Multi-Pack-Index
    +-Format] for more information on the multi-pack-index feature.
    ++Document] and linkgit:gitformat-pack[5] for more information on the
    ++multi-pack-index feature and its file format.
    + 
    + 
    + GIT
    +
    + ## Documentation/technical/chunk-format.txt => Documentation/gitformat-chunk.txt ##
    +@@
    +-Chunk-based file formats
    +-========================
    ++gitformat-chunk(5)
    ++==================
    ++
    ++NAME
    ++----
    ++gitformat-chunk - Chunk-based file formats
    ++
    ++SYNOPSIS
    ++--------
    ++
    ++Used by linkgit:gitformat-commit-graph[5] and the "MIDX" format (see
    ++the pack format documentation in linkgit:gitformat-pack[5]).
    ++
    ++DESCRIPTION
    ++-----------
    + 
    + Some file formats in Git use a common concept of "chunks" to describe
    + sections of the file. This allows structured access to a large file by
    + scanning a small "table of contents" for the remaining data. This common
    + format is used by the `commit-graph` and `multi-pack-index` files. See
    +-link:technical/pack-format.html[the `multi-pack-index` format] and
    +-the `commit-graph` format in linkgit:gitformat-commit-graph[5] for
    ++the `multi-pack-index` format in linkgit:gitformat-pack[5] and
    ++link:technical/commit-graph-format.html[the `commit-graph` format] for
    + how they use the chunks to describe structured data.
    + 
    + A chunk-based file format begins with some header information custom to
    +@@ Documentation/gitformat-chunk.txt: for future formats:
    + * *multi-pack-index:* see `write_midx_internal()` and `load_multi_pack_index()`
    +   in `midx.c` for how the chunk-format API is used to write and
    +   parse the multi-pack-index file format documented in
    +-  link:technical/pack-format.html[the multi-pack-index file format].
    ++  the multi-pack-index file format section of linkgit:gitformat-pack[5].
    ++
    ++GIT
    ++---
    ++Part of the linkgit:git[1] suite
    +
    + ## Documentation/gitformat-commit-graph.txt ##
    +@@ Documentation/gitformat-commit-graph.txt: All multi-byte numbers are in network byte order.
    +       ID appears at most once.
    + 
    +   The CHUNK LOOKUP matches the table of contents from
    +-  link:technical/chunk-format.html[the chunk-based file format].
    ++  the chunk-based file format, see linkgit:gitformat-chunk[5]
    + 
    +   The remaining data in the body is described one chunk at a time, and
    +   these chunks may be given in any order. Chunks are required unless
    +
    + ## Documentation/technical/index-format.txt => Documentation/gitformat-index.txt ##
    +@@
    ++gitformat-index(5)
    ++==================
    ++
    ++NAME
    ++----
    ++gitformat-index - Git index format
    ++
    ++SYNOPSIS
    ++--------
    ++[verse]
    ++$GIT_DIR/index
    ++
    ++DESCRIPTION
    ++-----------
    ++
    + Git index format
    +-================
    + 
    + == The Git index file has the following format
    + 
    +@@ Documentation/gitformat-index.txt: Git index format
    +     entry is encoded as if the path name for the previous entry is an
    +     empty string).  At the beginning of an entry, an integer N in the
    +     variable width encoding (the same encoding as the offset is encoded
    +-    for OFS_DELTA pack entries; see pack-format.txt) is stored, followed
    ++    for OFS_DELTA pack entries; see linkgit:gitformat-pack[5]) is stored, followed
    +     by a NUL-terminated string S.  Removing N bytes from the end of the
    +     path name for the previous entry, and replacing it with the string S
    +     yields the path name for this entry.
    +@@ Documentation/gitformat-index.txt: The remaining data of each directory block is grouped by type:
    +   with signature { 's', 'd', 'i', 'r' }. Like the split-index extension,
    +   tools should avoid interacting with a sparse index unless they understand
    +   this extension.
    ++
    ++GIT
    ++---
    ++Part of the linkgit:git[1] suite
    +
    + ## Documentation/technical/bitmap-format.txt => Documentation/gitformat-pack-bitmap.txt ##
     @@
     -GIT bitmap v1 format
     -====================
    -+gitformat-bitmap(5)
    -+===================
    ++gitformat-pack-bitmap(5)
    ++========================
      
     -== Pack and multi-pack bitmaps
     +NAME
     +----
    -+gitformat-bitmap - The bitmap file format
    ++gitformat-pack-bitmap - The bitmap file format
     +
     +SYNOPSIS
     +--------
     +[verse]
    -+$GIT_DIR/objects/pack/*.bitmap
    ++$GIT_DIR/objects/pack/pack-*.bitmap
     +
     +DESCRIPTION
     +-----------
     +
     +Bitmaps are a file format associated with .pack files. See
    -+link:technical/pack-format.html[the pack format documentation] and
    ++the pack format documentation in linkgit:gitformat-pack[5] and
     +linkgit:git-pack-objects[1].
     +
     +== GIT bitmap v1 format
    @@ Documentation/technical/bitmap-format.txt => Documentation/gitformat-bitmap.txt
      
      Bitmaps store reachability information about the set of objects in a packfile,
      or a multi-pack index (MIDX). The former is defined obviously, and the latter is
    -@@ Documentation/gitformat-bitmap.txt: Certain bitmap extensions are supported (see: Appendix B). No extensions are
    +@@ Documentation/gitformat-pack-bitmap.txt: Certain bitmap extensions are supported (see: Appendix B). No extensions are
      required for bitmaps corresponding to packfiles. For bitmaps that correspond to
      MIDXs, both the bit-cache and rev-cache extensions are required.
      
     -== On-disk format
     +=== On-disk format
      
    - 	- A header appears at the beginning:
    - 
    -@@ Documentation/gitformat-bitmap.txt: MIDXs, both the bit-cache and rev-cache extensions are required.
    +     * A header appears at the beginning:
      
    - 		- The compressed bitmap itself, see Appendix A.
    +@@ Documentation/gitformat-pack-bitmap.txt: in the index.
    + 	TRAILER: ::
    + 		Trailing checksum of the preceding contents.
      
     -== Appendix A: Serialization format for an EWAH bitmap
     +Appendix A - Serialization format for an EWAH bitmap
    @@ Documentation/gitformat-bitmap.txt: MIDXs, both the bit-cache and rev-cache exte
      
      Ewah bitmaps are serialized in the same protocol as the JAVAEWAH
      library, making them backwards compatible with the JGit
    -@@ Documentation/gitformat-bitmap.txt: chunk.  For efficient appending to the bitstream, the EWAH stores a
    +@@ Documentation/gitformat-pack-bitmap.txt: chunk.  For efficient appending to the bitstream, the EWAH stores a
      pointer to the last RLW in the stream.
      
      
    @@ Documentation/gitformat-bitmap.txt: chunk.  For efficient appending to the bitst
      
      If the BITMAP_OPT_HASH_CACHE flag is set, the end of the bitmap contains
      a cache of 32-bit values, one per object in the pack/MIDX. The value at
    -@@ Documentation/gitformat-bitmap.txt: Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
    +@@ Documentation/gitformat-pack-bitmap.txt: Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
      If implementations want to choose a different hashing scheme, they are
      free to do so, but MUST allocate a new header flag (because comparing
      hashes made under two different schemes would be pointless).
    @@ Documentation/gitformat-bitmap.txt: Note that this hashing scheme is tied to the
     +---
     +Part of the linkgit:git[1] suite
     
    - ## Documentation/technical/chunk-format.txt => Documentation/gitformat-chunk.txt ##
    + ## Documentation/technical/cruft-packs.txt => Documentation/gitformat-pack-cruft.txt ##
     @@
    --Chunk-based file formats
    --========================
    -+gitformat-chunk(5)
    -+==================
    +-= Cruft packs
    ++gitformat-pack-cruft(5)
    ++=======================
     +
     +NAME
     +----
    -+gitformat-chunk - Chunk-based file formats
    ++gitformat-pack-cruft - The cruft pack file format
     +
     +SYNOPSIS
     +--------
    -+
    -+Used by linkgit:gitformat-commit-graph[5] and the "MIDX" format (see
    -+link:technical/pack-format.html[the pack format documentation]).
    ++[verse]
    ++$GIT_DIR/objects/pack/pack-*.mtimes
     +
     +DESCRIPTION
     +-----------
      
    - Some file formats in Git use a common concept of "chunks" to describe
    - sections of the file. This allows structured access to a large file by
    -@@ Documentation/gitformat-chunk.txt: for future formats:
    -   in `midx.c` for how the chunk-format API is used to write and
    -   parse the multi-pack-index file format documented in
    -   link:technical/pack-format.html[the multi-pack-index file format].
    + The cruft packs feature offer an alternative to Git's traditional mechanism of
    + removing unreachable objects. This document provides an overview of Git's
    +@@ Documentation/gitformat-pack-cruft.txt: same.
    + To remove unreachable objects from your repository, Git offers `git repack -Ad`
    + (see linkgit:git-repack[1]). Quoting from the documentation:
    + 
    +-[quote]
    ++----
    + [...] unreachable objects in a previous pack become loose, unpacked objects,
    + instead of being left in the old pack. [...] loose unreachable objects will be
    + pruned according to normal expiry rules with the next 'git gc' invocation.
    ++----
    + 
    + Unreachable objects aren't removed immediately, since doing so could race with
    + an incoming push which may reference an object which is about to be deleted.
    +@@ Documentation/gitformat-pack-cruft.txt: which aren't already stored in an earlier cruft pack) is significantly more
    + complicated to construct, and so aren't pursued here. The obvious drawback to
    + the current implementation is that the entire cruft pack must be re-written from
    + scratch.
     +
     +GIT
     +---
     +Part of the linkgit:git[1] suite
     
    - ## Documentation/gitformat-commit-graph.txt ##
    -@@ Documentation/gitformat-commit-graph.txt: All multi-byte numbers are in network byte order.
    -       ID appears at most once.
    + ## Documentation/gitformat-pack-protocol.txt ##
    +@@ Documentation/gitformat-pack-protocol.txt: Now that the client and server have finished negotiation about what
    + the minimal amount of data that needs to be sent to the client is, the server
    + will construct and send the required data in packfile format.
      
    -   The CHUNK LOOKUP matches the table of contents from
    --  link:technical/chunk-format.html[the chunk-based file format].
    -+  the chunk-based file format, see linkgit:gitformat-chunk[5]
    +-See pack-format.txt for what the packfile itself actually looks like.
    ++See linkgit:gitformat-pack[5] for what the packfile itself actually looks like.
      
    -   The remaining data in the body is described one chunk at a time, and
    -   these chunks may be given in any order. Chunks are required unless
    + If 'side-band' or 'side-band-64k' capabilities have been specified by
    + the client, the server will send the packfile data multiplexed.
     
    - ## Documentation/technical/index-format.txt => Documentation/gitformat-index.txt ##
    + ## Documentation/technical/pack-format.txt => Documentation/gitformat-pack.txt ##
     @@
    -+gitformat-index(5)
    -+==================
    +-Git pack format
    +-===============
    ++gitformat-pack(5)
    ++=================
     +
     +NAME
     +----
    -+gitformat-index - Git index format
    ++gitformat-pack - Git pack format
    ++
     +
     +SYNOPSIS
     +--------
     +[verse]
    -+$GIT_DIR/index
    ++$GIT_DIR/objects/pack/pack-*.{pack,idx}
    ++$GIT_DIR/objects/pack/pack-*.rev
    ++$GIT_DIR/objects/pack/multi-pack-index
     +
     +DESCRIPTION
     +-----------
     +
    - Git index format
    --================
    ++The Git pack format is now Git stores most of its primary repository
    ++data. Over the lietime af a repository loose objects (if any) and
    ++smaller packs are consolidated into larger pack(s). See
    ++linkgit:git-gc[1] and linkgit:git-pack-objects[1].
    ++
    ++The pack format is also used over-the-wire, see
    ++e.g. linkgit:gitformat-protocol-v2[5], as well as being a part of
    ++other container formats in the case of linkgit:gitformat-bundle[5].
      
    - == The Git index file has the following format
    + == Checksums and object IDs
      
    -@@ Documentation/gitformat-index.txt: The remaining data of each directory block is grouped by type:
    -   with signature { 's', 'd', 'i', 'r' }. Like the split-index extension,
    -   tools should avoid interacting with a sparse index unless they understand
    -   this extension.
    +@@ Documentation/gitformat-pack.txt: CHUNK LOOKUP:
    + 	    using the next chunk position if necessary.)
    + 
    + 	The CHUNK LOOKUP matches the table of contents from
    +-	link:technical/chunk-format.html[the chunk-based file format].
    ++	the chunk-based file format, see linkgit:gitformat-chunk[5].
    + 
    + 	The remaining data in the body is described one chunk at a time, and
    + 	these chunks may be given in any order. Chunks are required unless
    +@@ Documentation/gitformat-pack.txt: packs arranged in MIDX order (with the preferred pack coming first).
    + 
    + The MIDX's reverse index is stored in the optional 'RIDX' chunk within
    + the MIDX itself.
     +
     +GIT
     +---
    @@ Documentation/gitformat-signature.txt: Date:   Wed Jun 15 09:13:29 2016 +0000
     +---
     +Part of the linkgit:git[1] suite
     
    - ## Documentation/technical/pack-format.txt ##
    -@@ Documentation/technical/pack-format.txt: CHUNK LOOKUP:
    - 	    using the next chunk position if necessary.)
    + ## Documentation/howto/recover-corrupted-object-harder.txt ##
    +@@ Documentation/howto/recover-corrupted-object-harder.txt: Note that the "object" file isn't fit for feeding straight to zlib; it
    + has the git packed object header, which is variable-length. We want to
    + strip that off so we can start playing with the zlib data directly. You
    + can either work your way through it manually (the format is described in
    +-link:../technical/pack-format.html[Documentation/technical/pack-format.txt]),
    ++linkgit:gitformat-pack[5]),
    + or you can walk through it in a debugger. I did the latter, creating a
    + valid pack like:
      
    - 	The CHUNK LOOKUP matches the table of contents from
    --	link:technical/chunk-format.html[the chunk-based file format].
    -+	the chunk-based file format, see linkgit:gitformat-chunk[5].
    +
    + ## Documentation/technical/hash-function-transition.txt ##
    +@@ Documentation/technical/hash-function-transition.txt: SHA-1 content.
    + Object storage
    + ~~~~~~~~~~~~~~
    + Loose objects use zlib compression and packed objects use the packed
    +-format described in Documentation/technical/pack-format.txt, just like
    ++format described in linkgit:gitformat-pack[5], just like
    + today. The content that is compressed and stored uses SHA-256 content
    + instead of SHA-1 content.
    + 
    +
    + ## Documentation/user-manual.txt ##
    +@@ Documentation/user-manual.txt: those "loose" objects.
    + You can save space and make Git faster by moving these loose objects in
    + to a "pack file", which stores a group of objects in an efficient
    + compressed format; the details of how pack files are formatted can be
    +-found in link:technical/pack-format.html[pack format].
    ++found in link:gitformat-pack[5].
    + 
    + To put the loose objects into a pack, just run git repack:
      
    - 	The remaining data in the body is described one chunk at a time, and
    - 	these chunks may be given in any order. Chunks are required unless
    +
    + ## cache.h ##
    +@@ cache.h: extern struct index_state the_index;
    + 
    + /*
    +  * Values in this enum (except those outside the 3 bit range) are part
    +- * of pack file format. See Documentation/technical/pack-format.txt
    +- * for more information.
    ++ * of pack file format. See gitformat-pack(5) for more information.
    +  */
    + enum object_type {
    + 	OBJ_BAD = -1,
     
      ## command-list.txt ##
    -@@ command-list.txt: gitcvs-migration                        guide
    - gitdiffcore                             guide
    +@@ command-list.txt: gitdiffcore                             guide
      giteveryday                             guide
      gitfaq                                  guide
    -+gitformat-bitmap                        gitformats
      gitformat-bundle                        gitformats
     +gitformat-chunk                         gitformats
      gitformat-commit-graph                  gitformats
     +gitformat-index                         gitformats
    ++gitformat-pack                          gitformats
    ++gitformat-pack-bitmap                   gitformats
    ++gitformat-pack-cruft                    gitformats
      gitformat-pack-protocol                 gitformats
      gitformat-protocol-capabilities         gitformats
      gitformat-protocol-common               gitformats
    @@ command-list.txt: gitcvs-migration                        guide
      gitglossary                             guide
      githooks                                userformats
      gitignore                               userformats
    +
    + ## pack-revindex.h ##
    +@@
    +  *
    +  *   - pack position refers to an object's position within a non-existent pack
    +  *     described by the MIDX. The pack structure is described in
    +- *     Documentation/technical/pack-format.txt.
    ++ *     gitformat-pack(5).
    +  *
    +  *     It is effectively a concatanation of all packs in the MIDX (ordered by
    +  *     their numeric ID within the MIDX) in their original order within each
-:  ----------- > 6:  5cf8b526bff docs: move http-protocol docs to man section 5
-:  ----------- > 7:  aabdc4a4151 docs: move multi-pack-index docs to man section 5
-- 
2.37.0.932.g7b7031e73bc

