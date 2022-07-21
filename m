Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A411C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiGUQPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiGUQPB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:15:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021989A81
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:14:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h8so2983203wrw.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=npR/c3rdiWV/mjLaWJbH692POUgxUsIYPCQMysHriXk=;
        b=YB9xEzRqm49TBO0yigWuavnZHJ0HjI9ztjB2pXU5fRHSY73VsfB8WbZO5MHpVn2ABT
         pu8Qc1TbWCKGEma1XL+y73GA0ygygTjEUzDMkZ8+HPhkaIVTAsd0mi7zyZ218u9C4pA8
         jVVXB/l24Jy9y1JvQDFKQI3ma5BKTPCLJhkw4mqGoPj6i6PX4TSPyWusPtMOQSuw4I62
         O4L6mKHdYRqR5UnJIK60NGAyUV91YE5jVTXp+Y1nXhKUTMqZyhtSVTtlya3uftCas1Zt
         /pnNelKgKuXA5UmDbRdkKG/PRmF7J/L56s352Nt5cRAKbHjoqqduXImqyflWYEGanGGi
         9/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=npR/c3rdiWV/mjLaWJbH692POUgxUsIYPCQMysHriXk=;
        b=juonEJg/HRdXyzEQUFhimFDaCcDOilyUJT4nvAlaXmbjEU3jUAFTf5k9ZaQgnafmVQ
         +6jMjCe9aik9MRRV2cD2Z50GZl4nRfyBPapCY8U7OPU0sM0yqxOiZVmZIESa33ds3iIp
         bMULJZdfdIYh71WEc9IHvZyM1MeQ0P6tyd8OsmFrcrjwxok7hlVEhk24C4210w2ixE1K
         XcgYZ8XGIARxsgLsjVWgDH+Ja0SkDcOVahmqMS9YkebAqLB5qT83VCC7Gks27USuVFir
         CmemR9ZmHia2SqZ+Pl/ptAJ/wafYOEErNlTHH1qwiZ7GPJarI2wjLJ+opaW/V2oqNHy/
         mQ5A==
X-Gm-Message-State: AJIora/zNdvxoJSzo2UhZdslydp2cIrhSkpr57T9cTA0z2MzZhKUyUf3
        vKB/a6I0XNbYYe7VZGBK6rIHR5o09nBAUw==
X-Google-Smtp-Source: AGRyM1tMZuoy7vxiTVWZ5vxH1+H6JJVue3d2B9yWekDzE4wkwbfIZr4JfyL+jkGQnrWP3irIUejtcA==
X-Received: by 2002:adf:ef0b:0:b0:21e:489f:a258 with SMTP id e11-20020adfef0b000000b0021e489fa258mr7212886wro.19.1658420053372;
        Thu, 21 Jul 2022 09:14:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003a2f2bb72d5sm8498608wmq.45.2022.07.21.09.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:14:12 -0700 (PDT)
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
Subject: [PATCH v5 0/9] docs: create & use "(user|developer) interfaces" categories
Date:   Thu, 21 Jul 2022 18:13:49 +0200
Message-Id: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See v3[1] for lofty goals. The changes since v4 are mainly to rename
the "user formats" and "developer formats" to "user interfaces" and
"developer interfaces".

Now:

	$ ./git help --user-interfaces
	User-facing repository, command and file interfaces:
	   attributes          Defining attributes per path
	   cli                 Git command-line interface and conventions
	   hooks               Hooks used by Git
	   ignore              Specifies intentionally untracked files to ignore
	   mailmap             Map author/committer names and/or E-Mail addresses
	   modules             Defining submodule properties
	   repository-layout   Git Repository Layout
	   revisions           Specifying revisions and ranges for Git

The addition of "gitcli" and "gitrevisions" is new. I.e. per git-help(1):

	In-repository file interfaces such as `.git/info/exclude` are
	documented here (see linkgit:gitrepository-layout[5]), as well as
	in-tree configuration such as `.mailmap` (see linkgit:gitmailmap[5]).

	This section of the documentation also covers general or widespread
	user-interface conventions (e.g. linkgit:gitcli[7]), and
	pseudo-configuration such as the file-based `.git/hooks/*` interface
	described in linkgit:githooks[5].

And for "--developer-interfaces" (I wondered about calling this --apis):

	$ ./git help --developer-interfaces
	File formats, protocols and other developer interfaces:
	   format-bundle             The bundle file format
	   format-chunk              Chunk-based file formats
	   format-commit-graph       Git commit graph format
	   format-index              Git index format
	   format-multi-pack-index   The multi-pack-index file format
	   format-pack               Git pack format
	   format-pack-cruft         The cruft pack file format
	   format-signature          Git cryptographic signature formats
	   protocol-capabilities     Protocol v0 and v1 capabilities
	   protocol-common           Things common to various protocols
	   protocol-http             Git HTTP-based protocols
	   protocol-pack             How packs are transferred over-the-wire
	   protocol-v2               Git Wire Protocol, Version 2

I.e.:

 * The name of the new "user" category refers generally to "user
   interfaces", and as the description notes we'll cover user-editable
   files, UX conventions etc. there.

 * Not all the "--developer-interfaces" start with "gitformat"
   anymore, now it's "gitformat" for e.g. the bundle format, but
   "gitprotocol" for things that have to do with the protocol.

   This also solves an ugly wart: Before we had
   "gitformat-pack-protocol" (protocol) and "gitformat-pack" (*.pack
   files).

Other changes:

 * Changed the "<guide> or <doc>" to just say "<doc>, and it's now a
   split-off 2/9.

 * Fixed some links to the new docs, and added missing ones.

 * There was no "--developer-interfaces" section in the git-help(1)
   docs (or "--git-formats") before).

1. https://lore.kernel.org/git/cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  help.c: BUG() out if "help --guides" can't remove "git" prefixes
  git help doc: use "<doc>" instead of "<guide>"
  git docs: add a category for user-facing file, repo and command UX
  git docs: add a category for file formats, protocols and interfaces
  docs: move commit-graph format docs to man section 5
  docs: move protocol-related docs to man section 5
  docs: move pack format docs to man section 5
  docs: move http-protocol docs to man section 5
  docs: move multi-pack-index docs to man section 5

 Documentation/Makefile                        | 26 +++++-----
 Documentation/config/lsrefs.txt               |  2 +-
 Documentation/config/pack.txt                 |  2 +-
 Documentation/config/protocol.txt             |  2 +-
 Documentation/git-bundle.txt                  | 13 +++--
 Documentation/git-commit-graph.txt            |  5 ++
 Documentation/git-help.txt                    | 27 ++++++++--
 Documentation/git-multi-pack-index.txt        |  6 +--
 Documentation/git-upload-pack.txt             |  7 ++-
 Documentation/git.txt                         | 17 +++++++
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++---
 .../chunk-format.txt => gitformat-chunk.txt}  | 29 ++++++++---
 ...-format.txt => gitformat-commit-graph.txt} | 49 +++++++++++++------
 .../index-format.txt => gitformat-index.txt}  | 22 ++++++++-
 ...dex.txt => gitformat-multi-pack-index.txt} | 20 +++++++-
 ...uft-packs.txt => gitformat-pack-cruft.txt} | 22 ++++++++-
 .../pack-format.txt => gitformat-pack.txt}    | 39 +++++++++++++--
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++--
 ...ities.txt => gitprotocol-capabilities.txt} | 28 ++++++++---
 ...ocol-common.txt => gitprotocol-common.txt} | 23 ++++++++-
 ...http-protocol.txt => gitprotocol-http.txt} | 35 ++++++++++---
 ...pack-protocol.txt => gitprotocol-pack.txt} | 28 ++++++++---
 .../protocol-v2.txt => gitprotocol-v2.txt}    | 27 +++++++---
 .../howto/recover-corrupted-object-harder.txt |  2 +-
 Documentation/lint-man-section-order.perl     |  3 ++
 Documentation/technical/api-simple-ipc.txt    |  2 +-
 .../technical/hash-function-transition.txt    |  2 +-
 .../long-running-process-protocol.txt         |  2 +-
 Documentation/technical/packfile-uri.txt      |  2 +-
 Documentation/technical/partial-clone.txt     |  2 +-
 Documentation/user-manual.txt                 |  2 +-
 Makefile                                      |  1 +
 builtin/help.c                                | 20 +++++++-
 cache.h                                       |  3 +-
 command-list.txt                              | 38 +++++++++++---
 help.c                                        | 34 ++++++++++++-
 help.h                                        |  2 +
 pack-revindex.h                               |  2 +-
 refspec.h                                     |  2 +-
 t/t0012-help.sh                               | 14 +++++-
 t/t5551-http-fetch-smart.sh                   |  4 +-
 41 files changed, 508 insertions(+), 123 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (79%)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (89%)
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (87%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/multi-pack-index.txt => gitformat-multi-pack-index.txt} (94%)
 rename Documentation/{technical/cruft-packs.txt => gitformat-pack-cruft.txt} (96%)
 rename Documentation/{technical/pack-format.txt => gitformat-pack.txt} (95%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)
 rename Documentation/{technical/protocol-capabilities.txt => gitprotocol-capabilities.txt} (96%)
 rename Documentation/{technical/protocol-common.txt => gitprotocol-common.txt} (89%)
 rename Documentation/{technical/http-protocol.txt => gitprotocol-http.txt} (97%)
 rename Documentation/{technical/pack-protocol.txt => gitprotocol-pack.txt} (98%)
 rename Documentation/{technical/protocol-v2.txt => gitprotocol-v2.txt} (97%)

Range-diff against v4:
 1:  4428f0a6fb1 !  1:  b0bb29bb131 help.c: BUG() out if "help --guides" can't remove "git" prefixes
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## help.c ##
    -@@ help.c: static const char *drop_prefix(const char *name, uint32_t category)
    +@@ help.c: static struct category_description main_categories[] = {
    + static const char *drop_prefix(const char *name, uint32_t category)
    + {
    + 	const char *new_name;
    ++	const char *prefix;
      
      	if (skip_prefix(name, "git-", &new_name))
      		return new_name;
     -	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
    -+	switch (category)
    -+	{
    ++	switch (category) {
     +	case CAT_guide:
    -+		if (!skip_prefix(name, "git", &new_name))
    -+			BUG("category #%d but no 'git' prefix?", category);
    ++		prefix = "git";
    ++		if (!skip_prefix(name, prefix, &new_name))
    ++			BUG("'%s' in category #%d should have '%s' prefix",
    ++			    name, category, prefix);
      		return new_name;
     +	}
      	return name;
 -:  ----------- >  2:  2ec00f81552 git help doc: use "<doc>" instead of "<guide>"
 2:  883c483d4e7 !  3:  31be7d01c50 git docs: split "User-facing file formats" off from "Guides"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git docs: split "User-facing file formats" off from "Guides"
    +    git docs: add a category for user-facing file, repo and command UX
     
    -    Create a new "User-facing file formats" section in the main "git help
    -    git" manual page. The "Guides" section was added to the manual page in
    -    f442f28a81b (git.txt: add list of guides, 2020-08-05), it makes sense
    -    to list all that documentation.
    +    Create a new "Repository, command and file interfaces" section in the
    +    main "git help git" manual page. Move things that belong under this
    +    new criteria from the generic "Guides" section.
    +
    +    The "Guides" section was added in f442f28a81b (git.txt: add list of
    +    guides, 2020-08-05). It makes sense to have e.g. "giteveryday(7)" and
    +    "gitfaq(7)" listed under "Guides".
     
         But placing e.g. "gitignore(5)" in it is stretching the meaning of
         what a "guide" is, ideally that section should list things similar to
         "giteveryday(7)" and "gitcore-tutorial(7)".
     
    -    We take a wide view of what's considered a "user format", it's not
    -    just a file format, but e.g. githooks(5) also belongs, since the
    -    layout of the ".git/hooks/" and the placement of hooks in it is
    -    something the user might be expected to interact with.
    +    An alternate name that was considered for this new section was "User
    +    formats", for consistency with the nomenclature used for man section 5
    +    in general. My man(1) lists it as "File formats and conventions,
    +    e.g. /etc/passwd".
    +
    +    So calling this "git help --formats" or "git help --user-formats"
    +    would make sense for e.g. gitignore(5), but would be stretching it
    +    somewhat for githooks(5), and would seem really suspect for the likes
    +    of gitcli(7).
    +
    +    Let's instead pick a name that's closer to the generic term "User
    +    interface", which is really what this documentation discusses: General
    +    user-interface documentation that doesn't obviously belong elsewhere.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ Documentation/Makefile: cmds_txt = cmds-ancillaryinterrogators.txt \
      	cmds-synchingrepositories.txt \
      	cmds-synchelpers.txt \
      	cmds-guide.txt \
    -+	cmds-userformats.txt \
    ++	cmds-userinterfaces.txt \
      	cmds-purehelpers.txt \
      	cmds-foreignscminterface.txt
      
     
      ## Documentation/git-help.txt ##
     @@ Documentation/git-help.txt: SYNOPSIS
    - --------
    - [verse]
    - 'git help' [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]
    --'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
    -+'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>|<doc>]
    + 'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]
      'git help' [-g|--guides]
      'git help' [-c|--config]
    -+'git help' [--user-formats]
    ++'git help' [--user-interfaces]
      
      DESCRIPTION
      -----------
    - 
    --With no options and no '<command>' or '<guide>' given, the synopsis of the 'git'
    -+With no options and no '<command>', '<guide>' or '<doc>' given, the synopsis of the 'git'
    - command and a list of the most commonly used Git commands are printed
    - on the standard output.
    - 
    -@@ Documentation/git-help.txt: printed on the standard output.
    - If the option `--guides` or `-g` is given, a list of the
    - Git concept guides is also printed on the standard output.
    - 
    --If a command, or a guide, is given, a manual page for that command or
    --guide is brought up. The 'man' program is used by default for this
    -+If a command or other documentation is given, the relevant manual page
    -+will be brought up. The 'man' program is used by default for this
    - purpose, but this can be overridden by other options or configuration
    - variables.
    - 
     @@ Documentation/git-help.txt: OPTIONS
      --guides::
      	Prints a list of the Git concept guides on the standard output.
      
    -+--user-formats::
    -+	Prints a list of the Git user-facing format documentation on
    -+	the standard output.
    ++--user-interfaces::
    ++	Prints a list of the repository, command and file interfaces
    ++	documentation on the standard output.
    +++
    ++In-repository file interfaces such as `.git/info/exclude` are
    ++documented here (see linkgit:gitrepository-layout[5]), as well as
    ++in-tree configuration such as `.mailmap` (see linkgit:gitmailmap[5]).
    +++
    ++This section of the documentation also covers general or widespread
    ++user-interface conventions (e.g. linkgit:gitcli[7]), and
    ++pseudo-configuration such as the file-based `.git/hooks/*` interface
    ++described in linkgit:githooks[5].
     +
      -i::
      --info::
    @@ Documentation/git.txt: The following documentation pages are guides about Git co
      
      include::cmds-guide.txt[]
      
    -+User-facing file formats
    -+------------------------
    ++Repository, command and file interfaces
    ++---------------------------------------
     +
    -+This documentation discusses file formats that users are expected to
    -+edit. These can also be listed with 'git help --user-formats'.
    ++This documentation discusses repository and command interfaces which
    ++users are expected to interact with directly. See `--user-formats` in
    ++linkgit:git-help[1] for more details on the critera.
     +
    -+include::cmds-userformats.txt[]
    ++include::cmds-userinterfaces.txt[]
      
      Configuration Mechanism
      -----------------------
    @@ Makefile: check-docs::
      		sed -e '1,/^### command list/d' \
      		    -e '/^#/d' \
      		    -e '/guide$$/d' \
    -+		    -e '/formats$$/d' \
    ++		    -e '/interfaces$$/d' \
      		    -e 's/[ 	].*//' \
      		    -e 's/^/listed /' command-list.txt; \
      		$(MAKE) -C Documentation print-man1 | \
    @@ builtin/help.c: static enum help_action {
      	HELP_ACTION_ALL = 1,
      	HELP_ACTION_GUIDES,
      	HELP_ACTION_CONFIG,
    -+	HELP_ACTION_USER_FORMATS,
    ++	HELP_ACTION_USER_INTERFACES,
      	HELP_ACTION_CONFIG_FOR_COMPLETION,
      	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
      } cmd_mode;
    @@ builtin/help.c: static struct option builtin_help_options[] = {
      
      	OPT_CMDMODE('g', "guides", &cmd_mode, N_("print list of useful guides"),
      		    HELP_ACTION_GUIDES),
    -+	OPT_CMDMODE(0, "user-formats", &cmd_mode, N_("print list of user-facing file formats"),
    -+		    HELP_ACTION_USER_FORMATS),
    ++	OPT_CMDMODE(0, "user-interfaces", &cmd_mode,
    ++		    N_("print list of user-facing repository, command and file interfaces"),
    ++		    HELP_ACTION_USER_INTERFACES),
      	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
      		    HELP_ACTION_CONFIG),
      	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
    -@@ builtin/help.c: static struct option builtin_help_options[] = {
    - 
    - static const char * const builtin_help_usage[] = {
    - 	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
    --	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
    -+	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
    +@@ builtin/help.c: static const char * const builtin_help_usage[] = {
    + 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
      	"git help [-g|--guides]",
      	"git help [-c|--config]",
    -+	"git help [--user-formats]",
    ++	"git help [--user-interfaces]",
      	NULL
      };
      
    @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
      		opt_mode_usage(argc, "--config-for-completion", help_format);
      		list_config_help(SHOW_CONFIG_VARS);
      		return 0;
    -+	case HELP_ACTION_USER_FORMATS:
    -+		opt_mode_usage(argc, "--user-formats", help_format);
    -+		list_user_formats_help();
    ++	case HELP_ACTION_USER_INTERFACES:
    ++		opt_mode_usage(argc, "--user-interfaces", help_format);
    ++		list_user_interfaces_help();
     +		return 0;
      	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
      		opt_mode_usage(argc, "--config-sections-for-completion",
    @@ command-list.txt
      # specified here, which can only have "guide" attribute and nothing
      # else.
      #
    -+# User-facing file formats such as documentation for the .gitmodules,
    -+# .mailmap etc. files lives in man section 5. These entries can only
    -+# have the "userformats" attribute and nothing else.
    ++# User-facing repository, command and file interfaces such as
    ++# documentation for the .gitmodules, .mailmap etc. files lives in man
    ++# sections 5 and 7. These entries can only have the "userinterfaces"
    ++# attribute and nothing else.
     +#
      ### command list (do not change this line)
      # command name                          category [category] [category]
    @@ command-list.txt: git-verify-tag                          ancillaryinterrogators
      git-worktree                            mainporcelain
      git-write-tree                          plumbingmanipulators
     -gitattributes                           guide
    -+gitattributes                           userformats
    - gitcli                                  guide
    +-gitcli                                  guide
    ++gitattributes                           userinterfaces
    ++gitcli                                  userinterfaces
      gitcore-tutorial                        guide
      gitcredentials                          guide
    + gitcvs-migration                        guide
     @@ command-list.txt: gitdiffcore                             guide
      giteveryday                             guide
      gitfaq                                  guide
      gitglossary                             guide
     -githooks                                guide
     -gitignore                               guide
    -+githooks                                userformats
    -+gitignore                               userformats
    ++githooks                                userinterfaces
    ++gitignore                               userinterfaces
      gitk                                    mainporcelain
     -gitmailmap                              guide
     -gitmodules                              guide
    -+gitmailmap                              userformats
    -+gitmodules                              userformats
    ++gitmailmap                              userinterfaces
    ++gitmodules                              userinterfaces
      gitnamespaces                           guide
      gitremote-helpers                       guide
     -gitrepository-layout                    guide
    -+gitrepository-layout                    userformats
    - gitrevisions                            guide
    +-gitrevisions                            guide
    ++gitrepository-layout                    userinterfaces
    ++gitrevisions                            userinterfaces
      gitsubmodules                           guide
      gittutorial                             guide
    + gittutorial-2                           guide
     
      ## help.c ##
     @@ help.c: static struct category_description main_categories[] = {
      	{ CAT_plumbinginterrogators, N_("Low-level Commands / Interrogators") },
      	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
      	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
    -+	{ CAT_userformats, N_("Git user-facing file formats") },
    ++	{ CAT_userinterfaces, N_("User-facing repository, command and file interfaces") },
      	{ 0, NULL }
      };
      
     @@ help.c: static const char *drop_prefix(const char *name, uint32_t category)
    - 	switch (category)
    - 	{
    - 	case CAT_guide:
    -+	case CAT_userformats:
    - 		if (!skip_prefix(name, "git", &new_name))
    - 			BUG("category #%d but no 'git' prefix?", category);
      		return new_name;
    + 	switch (category) {
    + 	case CAT_guide:
    ++	case CAT_userinterfaces:
    + 		prefix = "git";
    + 		if (!skip_prefix(name, prefix, &new_name))
    + 			BUG("'%s' in category #%d should have '%s' prefix",
     @@ help.c: void list_guides_help(void)
      	putchar('\n');
      }
      
    -+void list_user_formats_help(void)
    ++void list_user_interfaces_help(void)
     +{
     +	struct category_description catdesc[] = {
    -+		{ CAT_userformats, N_("Git user-facing file formats:") },
    ++		{ CAT_userinterfaces, N_("User-facing repository, command and file interfaces:") },
     +		{ 0, NULL }
     +	};
     +	print_cmd_by_category(catdesc, NULL);
    @@ help.h: static inline void mput_char(char c, unsigned int num)
      void list_common_cmds_help(void);
      void list_all_cmds_help(int show_external_commands, int show_aliases);
      void list_guides_help(void);
    -+void list_user_formats_help(void);
    ++void list_user_interfaces_help(void);
      
      void list_all_main_cmds(struct string_list *list);
      void list_all_other_cmds(struct string_list *list);
    @@ t/t0012-help.sh: test_expect_success 'invalid usage' '
      	test_expect_code 129 git help -g add &&
      	test_expect_code 129 git help -a -g &&
      
    -+	test_expect_code 129 git help --user-formats add &&
    ++	test_expect_code 129 git help --user-interfaces add &&
     +
      	test_expect_code 129 git help -g -c &&
      	test_expect_code 129 git help --config-for-completion add &&
    @@ t/t0012-help.sh: test_expect_success 'git help succeeds without git.html' '
      	test_cmp expect test-browser.log
      '
      
    -+test_expect_success 'git help --user-formats' '
    -+	git help --user-formats >help.output &&
    ++test_expect_success 'git help --user-interfaces' '
    ++	git help --user-interfaces >help.output &&
     +	grep "^   attributes   " help.output &&
     +	grep "^   mailmap   " help.output
     +'
    @@ t/t0012-help.sh: test_expect_success "'git help -a' section spacing" '
      
      	Low-level Commands / Internal Helpers
     +
    -+	Git user-facing file formats
    ++	User-facing repository, command and file interfaces
      	EOF
      	test_cmp expect actual
      '
 3:  d196bcd1db0 !  4:  a7310898866 git docs: create a "Git file formats and protocols" section
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    git docs: create a "Git file formats and protocols" section
    +    git docs: add a category for file formats, protocols and interfaces
     
    -    Create a new "Git file formats and protocols" section in the main "git help
    -    git" manual page and start moving the documentation that now lives in
    -    "Documentation/technical/*.git" over to it. This compliments the newly
    -    added and adjacent "User-facing file formats" section.
    +    Create a new "File formats, protocols and other developer interfaces"
    +    section in the main "git help git" manual page and start moving the
    +    documentation that now lives in "Documentation/technical/*.git" over
    +    to it. This compliments the newly added and adjacent "Repository,
    +    command and file interfaces" section.
     
         This makes the technical documentation more accessible and
         discoverable. Before this we wouldn't install it by default, and had
    @@ Documentation/Makefile: TECH_DOCS += MyFirstObjectWalk
      TECH_DOCS += technical/hash-function-transition
      TECH_DOCS += technical/http-protocol
     @@ Documentation/Makefile: cmds_txt = cmds-ancillaryinterrogators.txt \
    + 	cmds-synchingrepositories.txt \
      	cmds-synchelpers.txt \
      	cmds-guide.txt \
    - 	cmds-userformats.txt \
    -+	cmds-gitformats.txt \
    ++	cmds-developerinterfaces.txt \
    + 	cmds-userinterfaces.txt \
      	cmds-purehelpers.txt \
      	cmds-foreignscminterface.txt
    - 
     
      ## Documentation/git-bundle.txt ##
     @@ Documentation/git-bundle.txt: using "thin packs", bundles created using exclusions are smaller in
    @@ Documentation/git-bundle.txt: using "thin packs", bundles created using exclusio
      
      OPTIONS
      -------
    +@@ Documentation/git-bundle.txt: verify <file>::
    + 	commits exist and are fully linked in the current repository.
    + 	Then, 'git bundle' prints a list of missing commits, if any.
    + 	Finally, information about additional capabilities, such as "object
    +-	filter", is printed. See "Capabilities" in link:technical/bundle-format.html
    ++	filter", is printed. See "Capabilities" in linkgit:gitformat-bundle[5]
    + 	for more information. The exit code is zero for success, but will
    + 	be nonzero if the bundle file is invalid.
    + 
     @@ Documentation/git-bundle.txt: You can also see what references it offers:
      $ git ls-remote mybundle
      ----------------
    @@ Documentation/git-help.txt
     @@ Documentation/git-help.txt: SYNOPSIS
      'git help' [-g|--guides]
      'git help' [-c|--config]
    - 'git help' [--user-formats]
    -+'git help' [--git-formats]
    + 'git help' [--user-interfaces]
    ++'git help' [--developer-interfaces]
      
      DESCRIPTION
      -----------
    +@@ Documentation/git-help.txt: user-interface conventions (e.g. linkgit:gitcli[7]), and
    + pseudo-configuration such as the file-based `.git/hooks/*` interface
    + described in linkgit:githooks[5].
    + 
    ++--developer-interfaces::
    ++	Print list of file formats, protocols and other developer
    ++	interfaces documentation on the standard output.
    ++
    + -i::
    + --info::
    + 	Display manual page for the command in the 'info' format. The
     
      ## Documentation/git.txt ##
    -@@ Documentation/git.txt: edit. These can also be listed with 'git help --user-formats'.
    +@@ Documentation/git.txt: linkgit:git-help[1] for more details on the critera.
      
    - include::cmds-userformats.txt[]
    + include::cmds-userinterfaces.txt[]
      
    -+Git file formats and protocols
    -+------------------------------
    ++File formats, protocols and other developer interfaces
    ++------------------------------------------------------
     +
    -+This documentation discusses the file formats and protocols that git
    -+itself uses. These can also be listed with 'git help --git-formats'.
    ++This documentation discusses file formats, over-the-wire protocols and
    ++other git developer interfaces. See `--developer-interfaces` in
    ++linkgit:git-help[1].
     +
    -+include::cmds-gitformats.txt[]
    ++include::cmds-developerinterfaces.txt[]
     +
      Configuration Mechanism
      -----------------------
    @@ builtin/help.c
     @@ builtin/help.c: static enum help_action {
      	HELP_ACTION_GUIDES,
      	HELP_ACTION_CONFIG,
    - 	HELP_ACTION_USER_FORMATS,
    -+	HELP_ACTION_GIT_FORMATS,
    + 	HELP_ACTION_USER_INTERFACES,
    ++	HELP_ACTION_DEVELOPER_INTERFACES,
      	HELP_ACTION_CONFIG_FOR_COMPLETION,
      	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
      } cmd_mode;
     @@ builtin/help.c: static struct option builtin_help_options[] = {
    - 		    HELP_ACTION_GUIDES),
    - 	OPT_CMDMODE(0, "user-formats", &cmd_mode, N_("print list of user-facing file formats"),
    - 		    HELP_ACTION_USER_FORMATS),
    -+	OPT_CMDMODE(0, "git-formats", &cmd_mode, N_("print list of internal file formats and network protocols"),
    -+		    HELP_ACTION_GIT_FORMATS),
    + 	OPT_CMDMODE(0, "user-interfaces", &cmd_mode,
    + 		    N_("print list of user-facing repository, command and file interfaces"),
    + 		    HELP_ACTION_USER_INTERFACES),
    ++	OPT_CMDMODE(0, "developer-interfaces", &cmd_mode,
    ++		    N_("print list of file formats, protocols and other developer interfaces"),
    ++		    HELP_ACTION_DEVELOPER_INTERFACES),
      	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
      		    HELP_ACTION_CONFIG),
      	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
     @@ builtin/help.c: static const char * const builtin_help_usage[] = {
      	"git help [-g|--guides]",
      	"git help [-c|--config]",
    - 	"git help [--user-formats]",
    -+	"git help [--git-formats]",
    + 	"git help [--user-interfaces]",
    ++	"git help [--developer-interfaces]",
      	NULL
      };
      
     @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
    - 		opt_mode_usage(argc, "--user-formats", help_format);
    - 		list_user_formats_help();
    + 		opt_mode_usage(argc, "--user-interfaces", help_format);
    + 		list_user_interfaces_help();
      		return 0;
    -+	case HELP_ACTION_GIT_FORMATS:
    -+		opt_mode_usage(argc, "--git-formats", help_format);
    -+		list_git_formats_help();
    ++	case HELP_ACTION_DEVELOPER_INTERFACES:
    ++		opt_mode_usage(argc, "--developer-interfaces", help_format);
    ++		list_developer_interfaces_help();
     +		return 0;
      	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
      		opt_mode_usage(argc, "--config-sections-for-completion",
    @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
     
      ## command-list.txt ##
     @@
    - # .mailmap etc. files lives in man section 5. These entries can only
    - # have the "userformats" attribute and nothing else.
    + # sections 5 and 7. These entries can only have the "userinterfaces"
    + # attribute and nothing else.
      #
    -+# Git internal file formats and protocols, such as documentation for the
    ++# Git's file formats and protocols, such as documentation for the
     +# *.bundle format lives in man section 5. These entries can only have
    -+# the "gitformats" attribute and nothing else.
    ++# the "developerinterfaces" attribute and nothing else.
     +#
      ### command list (do not change this line)
      # command name                          category [category] [category]
    @@ command-list.txt: gitcvs-migration                        guide
      gitdiffcore                             guide
      giteveryday                             guide
      gitfaq                                  guide
    -+gitformat-bundle                        gitformats
    ++gitformat-bundle                        developerinterfaces
      gitglossary                             guide
    - githooks                                userformats
    - gitignore                               userformats
    + githooks                                userinterfaces
    + gitignore                               userinterfaces
     
      ## help.c ##
     @@ help.c: static struct category_description main_categories[] = {
      	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
      	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
    - 	{ CAT_userformats, N_("Git user-facing file formats") },
    -+	{ CAT_gitformats, N_("Git internal file formats and protocols") },
    + 	{ CAT_userinterfaces, N_("User-facing repository, command and file interfaces") },
    ++	{ CAT_developerinterfaces, N_("Developer-facing file file formats, protocols and interfaces") },
      	{ 0, NULL }
      };
      
     @@ help.c: static const char *drop_prefix(const char *name, uint32_t category)
    - 	{
    + 	switch (category) {
      	case CAT_guide:
    - 	case CAT_userformats:
    -+	case CAT_gitformats:
    - 		if (!skip_prefix(name, "git", &new_name))
    - 			BUG("category #%d but no 'git' prefix?", category);
    - 		return new_name;
    -@@ help.c: void list_user_formats_help(void)
    + 	case CAT_userinterfaces:
    ++	case CAT_developerinterfaces:
    + 		prefix = "git";
    + 		if (!skip_prefix(name, prefix, &new_name))
    + 			BUG("'%s' in category #%d should have '%s' prefix",
    +@@ help.c: void list_user_interfaces_help(void)
      	putchar('\n');
      }
      
    -+void list_git_formats_help(void)
    ++void list_developer_interfaces_help(void)
     +{
     +	struct category_description catdesc[] = {
    -+		{ CAT_gitformats, N_("Internal file formats and protocols:") },
    ++		{ CAT_developerinterfaces, N_("File formats, protocols and other developer interfaces:") },
     +		{ 0, NULL }
     +	};
     +	print_cmd_by_category(catdesc, NULL);
    @@ help.h
     @@ help.h: void list_common_cmds_help(void);
      void list_all_cmds_help(int show_external_commands, int show_aliases);
      void list_guides_help(void);
    - void list_user_formats_help(void);
    -+void list_git_formats_help(void);
    + void list_user_interfaces_help(void);
    ++void list_developer_interfaces_help(void);
      
      void list_all_main_cmds(struct string_list *list);
      void list_all_other_cmds(struct string_list *list);
    @@ t/t0012-help.sh
     @@ t/t0012-help.sh: test_expect_success "'git help -a' section spacing" '
      	Low-level Commands / Internal Helpers
      
    - 	Git user-facing file formats
    + 	User-facing repository, command and file interfaces
     +
    -+	Git internal file formats and protocols
    ++	Developer-facing file file formats, protocols and interfaces
      	EOF
      	test_cmp expect actual
      '
 4:  b59e001a4ca !  5:  62f9020a72d docs: move commit-graph format docs to man section 5
    @@ Commit message
         file-format documentation into our main documentation space.
     
         By moving the documentation for the commit-graph format into man
    -    section 5 and the new "gitformats" category. This change is split from
    -    subsequent commits due to the relatively large amount of ASCIIDOC
    -    formatting changes that are required.
    +    section 5 and the new "developerinterfaces" category. This change is
    +    split from subsequent commits due to the relatively large amount of
    +    ASCIIDOC formatting changes that are required.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ command-list.txt
     @@ command-list.txt: gitdiffcore                             guide
      giteveryday                             guide
      gitfaq                                  guide
    - gitformat-bundle                        gitformats
    -+gitformat-commit-graph                  gitformats
    + gitformat-bundle                        developerinterfaces
    ++gitformat-bundle                        developerinterfaces
    ++gitformat-commit-graph                  developerinterfaces
      gitglossary                             guide
    - githooks                                userformats
    - gitignore                               userformats
    + githooks                                userinterfaces
    + gitignore                               userinterfaces
 5:  968aa977b67 !  6:  019ec8cf73c docs: move protocol-related docs to man section 5
    @@ Commit message
         e.g. lsrefs.unborn and protocol.version documentation to a manpage we
         build by default.
     
    +    So far we have been using the "gitformat-" prefix for the
    +    documentation we've been moving over from Documentation/technical/*,
    +    but for protocol documentation let's use "gitprotocol-*".
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/Makefile ##
    -@@ Documentation/Makefile: MAN1_TXT += gitweb.txt
    - MAN5_TXT += gitattributes.txt
    - MAN5_TXT += gitformat-bundle.txt
    - MAN5_TXT += gitformat-commit-graph.txt
    -+MAN5_TXT += gitformat-pack-protocol.txt
    -+MAN5_TXT += gitformat-protocol-capabilities.txt
    -+MAN5_TXT += gitformat-protocol-common.txt
    -+MAN5_TXT += gitformat-protocol-v2.txt
    - MAN5_TXT += githooks.txt
    +@@ Documentation/Makefile: MAN5_TXT += githooks.txt
      MAN5_TXT += gitignore.txt
      MAN5_TXT += gitmailmap.txt
    + MAN5_TXT += gitmodules.txt
    ++MAN5_TXT += gitprotocol-capabilities.txt
    ++MAN5_TXT += gitprotocol-common.txt
    ++MAN5_TXT += gitprotocol-pack.txt
    ++MAN5_TXT += gitprotocol-v2.txt
    + MAN5_TXT += gitrepository-layout.txt
    + MAN5_TXT += gitweb.conf.txt
    + 
     @@ Documentation/Makefile: TECH_DOCS += technical/long-running-process-protocol
      TECH_DOCS += technical/multi-pack-index
      TECH_DOCS += technical/pack-format
    @@ Documentation/config/lsrefs.txt
      	May be "advertise" (the default), "allow", or "ignore". If "advertise",
      	the server will respond to the client sending "unborn" (as described in
     -	protocol-v2.txt) and will advertise support for this feature during the
    -+	linkgit:gitformat-protocol-v2[5]) and will advertise support for this feature during the
    ++	linkgit:gitprotocol-v2[5]) and will advertise support for this feature during the
      	protocol v2 capability advertisement. "allow" is the same as
      	"advertise" except that the server will not advertise support for this
      	feature; this is useful for load-balanced servers that cannot be
    @@ Documentation/config/protocol.txt: protocol.version::
        in the initial response from the server.
      
     -* `2` - link:technical/protocol-v2.html[wire protocol version 2].
    -+* `2` - Wire protocol version 2, see linkgit:gitformat-protocol-v2[5].
    ++* `2` - Wire protocol version 2, see linkgit:gitprotocol-v2[5].
      
      --
     
    @@ Documentation/git-upload-pack.txt: OPTIONS
     -	link:technical/protocol-v2.html[the Git Wire Protocol, Version
     -	2] documentation. Also understood by
     +	transfer protocols] documentation and "HTTP Transport" in the
    -+	linkgit:gitformat-protocol-v2[5] documentation. Also understood by
    ++	linkgit:gitprotocol-v2[5] documentation. Also understood by
      	linkgit:git-receive-pack[1].
      
      <directory>::
    @@ Documentation/gitformat-bundle.txt: FORMAT
      
      We will use ABNF notation to define the Git bundle format. See
     -link:technical/protocol-common.html for the details.
    -+linkgit:gitformat-protocol-common[5] for the details.
    ++linkgit:gitprotocol-common[5] for the details.
      
      A v2 bundle looks like this:
      
     
    - ## Documentation/technical/pack-protocol.txt => Documentation/gitformat-pack-protocol.txt ##
    -@@
    --Packfile transfer protocols
    --===========================
    -+gitformat-pack-protocol(5)
    -+==========================
    -+
    -+NAME
    -+----
    -+gitformat-pack-protocol - How packs are transferred over-the-wire
    -+
    -+SYNOPSIS
    -+--------
    -+[verse]
    -+<over-the-wire-protocol>
    -+
    -+DESCRIPTION
    -+-----------
    - 
    - Git supports transferring data in packfiles over the ssh://, git://, http:// and
    - file:// transports.  There exist two sets of protocols, one for pushing
    -@@ Documentation/gitformat-pack-protocol.txt: pkt-line Format
    - ---------------
    - 
    - The descriptions below build on the pkt-line format described in
    --protocol-common.txt. When the grammar indicate `PKT-LINE(...)`, unless
    -+linkgit:gitformat-protocol-common[5]. When the grammar indicate `PKT-LINE(...)`, unless
    - otherwise noted the usual pkt-line LF rules apply: the sender SHOULD
    - include a LF, but the receiver MUST NOT complain if it is not present.
    - 
    -@@ Documentation/gitformat-pack-protocol.txt: An example client/server communication might look like this:
    -    S: 0018ok refs/heads/debug\n
    -    S: 002ang refs/heads/master non-fast-forward\n
    - ----
    -+
    -+GIT
    -+---
    -+Part of the linkgit:git[1] suite
    -
    - ## Documentation/technical/protocol-capabilities.txt => Documentation/gitformat-protocol-capabilities.txt ##
    + ## Documentation/technical/protocol-capabilities.txt => Documentation/gitprotocol-capabilities.txt ##
     @@
     -Git Protocol Capabilities
     -=========================
    -+gitformat-protocol-capabilities(5)
    -+==================================
    ++gitprotocol-capabilities(5)
    ++===========================
     +
     +NAME
     +----
    -+gitformat-protocol-capabilities - Protocol v0 and v1 capabilities
    ++gitprotocol-capabilities - Protocol v0 and v1 capabilities
     +
     +SYNOPSIS
     +--------
    @@ Documentation/technical/protocol-capabilities.txt => Documentation/gitformat-pro
      
      NOTE: this document describes capabilities for versions 0 and 1 of the pack
     -protocol. For version 2, please refer to the link:protocol-v2.html[protocol-v2]
    -+protocol. For version 2, please refer to the linkgit:gitformat-protocol-v2[5]
    ++protocol. For version 2, please refer to the linkgit:gitprotocol-v2[5]
      doc.
      
      Servers SHOULD support all capabilities defined in this document.
    -@@ Documentation/gitformat-protocol-capabilities.txt: interleaved with S-R-Q.
    +@@ Documentation/gitprotocol-capabilities.txt: interleaved with S-R-Q.
      multi_ack_detailed
      ------------------
      This is an extension of multi_ack that permits client to better
     -understand the server's in-memory state. See pack-protocol.txt,
    -+understand the server's in-memory state. See linkgit:gitformat-pack-protocol[5],
    ++understand the server's in-memory state. See linkgit:gitprotocol-pack[5],
      section "Packfile Negotiation" for more information.
      
      no-done
    -@@ Documentation/gitformat-protocol-capabilities.txt: a packfile upload and reference update.  If the pushing client requests
    +@@ Documentation/gitprotocol-capabilities.txt: a packfile upload and reference update.  If the pushing client requests
      this capability, after unpacking and updating references the server
      will respond with whether the packfile unpacked successfully and if
      each reference was updated successfully.  If any of those were not
     -successful, it will send back an error message.  See pack-protocol.txt
    -+successful, it will send back an error message.  See linkgit:gitformat-pack-protocol[5]
    ++successful, it will send back an error message.  See linkgit:gitprotocol-pack[5]
      for example messages.
      
      report-status-v2
    -@@ Documentation/gitformat-protocol-capabilities.txt: adding new "option" directives in order to support reference rewritten by
    +@@ Documentation/gitprotocol-capabilities.txt: adding new "option" directives in order to support reference rewritten by
      the "proc-receive" hook.  The "proc-receive" hook may handle a command
      for a pseudo-reference which may create or update a reference with
      different name, new-oid, and old-oid.  While the capability
     -'report-status' cannot report for such case.  See pack-protocol.txt
    -+'report-status' cannot report for such case.  See linkgit:gitformat-pack-protocol[5]
    ++'report-status' cannot report for such case.  See linkgit:gitprotocol-pack[5]
      for details.
      
      delete-refs
    -@@ Documentation/gitformat-protocol-capabilities.txt: packet-line, and must not contain non-printable or whitespace characters. The
    +@@ Documentation/gitprotocol-capabilities.txt: packet-line, and must not contain non-printable or whitespace characters. The
      current implementation uses trace2 session IDs (see
      link:api-trace2.html[api-trace2] for details), but this may change and users of
      the session ID should not rely on this fact.
    @@ Documentation/gitformat-protocol-capabilities.txt: packet-line, and must not con
     +---
     +Part of the linkgit:git[1] suite
     
    - ## Documentation/technical/protocol-common.txt => Documentation/gitformat-protocol-common.txt ##
    + ## Documentation/technical/protocol-common.txt => Documentation/gitprotocol-common.txt ##
     @@
     -Documentation Common to Pack and Http Protocols
     -===============================================
    -+gitformat-protocol-common(5)
    -+============================
    ++gitprotocol-common(5)
    ++=====================
     +
     +NAME
     +----
    -+gitformat-protocol-common - Things common to various protocols
    ++gitprotocol-common - Things common to various protocols
     +
     +SYNOPSIS
     +--------
    @@ Documentation/technical/protocol-common.txt => Documentation/gitformat-protocol-
      
      ABNF Notation
      -------------
    -@@ Documentation/gitformat-protocol-common.txt: Examples (as C-style strings):
    +@@ Documentation/gitprotocol-common.txt: Examples (as C-style strings):
        "000bfoobar\n"    "foobar\n"
        "0004"            ""
      ----
    @@ Documentation/gitformat-protocol-common.txt: Examples (as C-style strings):
     +---
     +Part of the linkgit:git[1] suite
     
    - ## Documentation/technical/protocol-v2.txt => Documentation/gitformat-protocol-v2.txt ##
    + ## Documentation/technical/pack-protocol.txt => Documentation/gitprotocol-pack.txt ##
    +@@
    +-Packfile transfer protocols
    +-===========================
    ++gitprotocol-pack(5)
    ++===================
    ++
    ++NAME
    ++----
    ++gitprotocol-pack - How packs are transferred over-the-wire
    ++
    ++SYNOPSIS
    ++--------
    ++[verse]
    ++<over-the-wire-protocol>
    ++
    ++DESCRIPTION
    ++-----------
    + 
    + Git supports transferring data in packfiles over the ssh://, git://, http:// and
    + file:// transports.  There exist two sets of protocols, one for pushing
    +@@ Documentation/gitprotocol-pack.txt: pkt-line Format
    + ---------------
    + 
    + The descriptions below build on the pkt-line format described in
    +-protocol-common.txt. When the grammar indicate `PKT-LINE(...)`, unless
    ++linkgit:gitprotocol-common[5]. When the grammar indicate `PKT-LINE(...)`, unless
    + otherwise noted the usual pkt-line LF rules apply: the sender SHOULD
    + include a LF, but the receiver MUST NOT complain if it is not present.
    + 
    +@@ Documentation/gitprotocol-pack.txt: Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
    + 
    + Servers that receive any such Extra Parameters MUST ignore all
    + unrecognized keys. Currently, the only Extra Parameter recognized is
    +-"version" with a value of '1' or '2'.  See protocol-v2.txt for more
    ++"version" with a value of '1' or '2'.  See linkgit:gitprotocol-v2[5] for more
    + information on protocol version 2.
    + 
    + Git Transport
    +@@ Documentation/gitprotocol-pack.txt: An example client/server communication might look like this:
    +    S: 0018ok refs/heads/debug\n
    +    S: 002ang refs/heads/master non-fast-forward\n
    + ----
    ++
    ++GIT
    ++---
    ++Part of the linkgit:git[1] suite
    +
    + ## Documentation/technical/protocol-v2.txt => Documentation/gitprotocol-v2.txt ##
     @@
     -Git Wire Protocol, Version 2
     -============================
    -+gitformat-protocol-v2(5)
    -+========================
    ++gitprotocol-v2(5)
    ++=================
     +
     +NAME
     +----
    -+gitformat-protocol-v2 - Git Wire Protocol, Version 2
    ++gitprotocol-v2 - Git Wire Protocol, Version 2
     +
     +SYNOPSIS
     +--------
    @@ Documentation/technical/protocol-v2.txt => Documentation/gitformat-protocol-v2.t
      
      This document presents a specification for a version 2 of Git's wire
      protocol.  Protocol v2 will improve upon v1 in the following ways:
    -@@ Documentation/gitformat-protocol-v2.txt: Packet-Line Framing
    +@@ Documentation/gitprotocol-v2.txt: Packet-Line Framing
      -------------------
      
      All communication is done using packet-line framing, just as in v1.  See
     -`Documentation/technical/pack-protocol.txt` and
    -+linkgit:gitformat-pack-protocol[5] and
    - `Documentation/technical/protocol-common.txt` for more information.
    +-`Documentation/technical/protocol-common.txt` for more information.
    ++linkgit:gitprotocol-pack[5] and linkgit:gitprotocol-common[5] for more information.
      
      In protocol v2 these special packets will have the following semantics:
    -@@ Documentation/gitformat-protocol-v2.txt: Initial Client Request
    + 
    +@@ Documentation/gitprotocol-v2.txt: Initial Client Request
      In general a client can request to speak protocol v2 by sending
      `version=2` through the respective side-channel for the transport being
      used which inevitably sets `GIT_PROTOCOL`.  More information can be
     -found in `pack-protocol.txt` and `http-protocol.txt`, as well as the
    -+found in linkgit:gitformat-pack-protocol[5] and `http-protocol.txt`, as well as the
    ++found in linkgit:gitprotocol-pack[5] and `http-protocol.txt`, as well as the
      `GIT_PROTOCOL` definition in `git.txt`. In all cases the
      response from the server is the capability advertisement.
      
    -@@ Documentation/gitformat-protocol-v2.txt: and associated requested information, each separated by a single space.
    +@@ Documentation/gitprotocol-v2.txt: and associated requested information, each separated by a single space.
      	attr = "size"
      
      	obj-info = obj-id SP obj-size
    @@ Documentation/technical/api-simple-ipc.txt: client and an optional response mess
      with a flush packet.
      
     -The pkt-line routines (Documentation/technical/protocol-common.txt)
    -+The pkt-line routines (linkgit:gitformat-protocol-common[5])
    ++The pkt-line routines (linkgit:gitprotocol-common[5])
      are used to simplify buffer management during message generation,
      transmission, and reception.  A flush packet is used to mark the end
      of the message.  This allows the sender to incrementally generate and
    @@ Documentation/technical/http-protocol.txt: smart server reply:
      
      The client may send Extra Parameters (see
     -Documentation/technical/pack-protocol.txt) as a colon-separated string
    -+linkgit:gitformat-pack-protocol[5]) as a colon-separated string
    ++linkgit:gitprotocol-pack[5]) as a colon-separated string
      in the Git-Protocol HTTP header.
      
      Uses the `--http-backend-info-refs` option to
    @@ Documentation/technical/http-protocol.txt: References
      http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
     -link:technical/pack-protocol.html
     -link:technical/protocol-capabilities.html
    -+linkgit:gitformat-pack-protocol[5]
    -+linkgit:gitformat-protocol-capabilities[5]
    ++linkgit:gitprotocol-pack[5]
    ++linkgit:gitprotocol-capabilities[5]
     
      ## Documentation/technical/long-running-process-protocol.txt ##
     @@ Documentation/technical/long-running-process-protocol.txt: Long-running process protocol
    @@ Documentation/technical/long-running-process-protocol.txt: Long-running process
      This protocol is used when Git needs to communicate with an external
      process throughout the entire life of a single Git command. All
     -communication is in pkt-line format (see technical/protocol-common.txt)
    -+communication is in pkt-line format (see linkgit:gitformat-protocol-common[5])
    ++communication is in pkt-line format (see linkgit:gitprotocol-common[5])
      over standard input and standard output.
      
      Handshake
     
    + ## Documentation/technical/packfile-uri.txt ##
    +@@ Documentation/technical/packfile-uri.txt: a `packfile-uris` argument, the server MAY send a `packfile-uris` section
    + directly before the `packfile` section (right after `wanted-refs` if it is
    + sent) containing URIs of any of the given protocols. The URIs point to
    + packfiles that use only features that the client has declared that it supports
    +-(e.g. ofs-delta and thin-pack). See protocol-v2.txt for the documentation of
    ++(e.g. ofs-delta and thin-pack). See linkgit:gitprotocol-v2[5] for the documentation of
    + this section.
    + 
    + Clients should then download and index all the given URIs (in addition to
    +
      ## Documentation/technical/partial-clone.txt ##
     @@ Documentation/technical/partial-clone.txt: Design Details
        upload-pack negotiation.
      +
      This uses the existing capability discovery mechanism.
     -See "filter" in Documentation/technical/pack-protocol.txt.
    -+See "filter" in linkgit:gitformat-pack-protocol[5].
    ++See "filter" in linkgit:gitprotocol-pack[5].
      
      - Clients pass a "filter-spec" to clone and fetch which is passed to the
        server to request filtering during packfile construction.
     
      ## command-list.txt ##
    -@@ command-list.txt: giteveryday                             guide
    +@@ command-list.txt: gitdiffcore                             guide
    + giteveryday                             guide
      gitfaq                                  guide
    - gitformat-bundle                        gitformats
    - gitformat-commit-graph                  gitformats
    -+gitformat-pack-protocol                 gitformats
    -+gitformat-protocol-capabilities         gitformats
    -+gitformat-protocol-common               gitformats
    -+gitformat-protocol-v2                   gitformats
    + gitformat-bundle                        developerinterfaces
    +-gitformat-bundle                        developerinterfaces
    + gitformat-commit-graph                  developerinterfaces
      gitglossary                             guide
    - githooks                                userformats
    - gitignore                               userformats
    + githooks                                userinterfaces
    +@@ command-list.txt: gitk                                    mainporcelain
    + gitmailmap                              userinterfaces
    + gitmodules                              userinterfaces
    + gitnamespaces                           guide
    ++gitprotocol-capabilities                developerinterfaces
    ++gitprotocol-common                      developerinterfaces
    ++gitprotocol-pack                        developerinterfaces
    ++gitprotocol-v2                          developerinterfaces
    + gitremote-helpers                       guide
    + gitrepository-layout                    userinterfaces
    + gitrevisions                            userinterfaces
    +
    + ## refspec.h ##
    +@@ refspec.h: int valid_remote_name(const char *name);
    + struct strvec;
    + /*
    +  * Determine what <prefix> values to pass to the peer in ref-prefix lines
    +- * (see Documentation/technical/protocol-v2.txt).
    ++ * (see linkgit:gitprotocol-v2[5]).
    +  */
    + void refspec_ref_prefixes(const struct refspec *rs,
    + 			  struct strvec *ref_prefixes);
     
      ## t/t5551-http-fetch-smart.sh ##
     @@ t/t5551-http-fetch-smart.sh: test_expect_success 'no-op half-auth fetch does not require a password' '
 6:  858ce9c6999 !  7:  5b081e6637a docs: move pack format docs to man section 5
    @@ Documentation/Makefile: MAN1_TXT += gitweb.txt
      MAN5_TXT += gitformat-commit-graph.txt
     +MAN5_TXT += gitformat-index.txt
     +MAN5_TXT += gitformat-pack-cruft.txt
    - MAN5_TXT += gitformat-pack-protocol.txt
     +MAN5_TXT += gitformat-pack.txt
    - MAN5_TXT += gitformat-protocol-capabilities.txt
    - MAN5_TXT += gitformat-protocol-common.txt
    - MAN5_TXT += gitformat-protocol-v2.txt
     +MAN5_TXT += gitformat-signature.txt
      MAN5_TXT += githooks.txt
      MAN5_TXT += gitignore.txt
    @@ Documentation/technical/chunk-format.txt => Documentation/gitformat-chunk.txt
      scanning a small "table of contents" for the remaining data. This common
      format is used by the `commit-graph` and `multi-pack-index` files. See
     -link:technical/pack-format.html[the `multi-pack-index` format] and
    --the `commit-graph` format in linkgit:gitformat-commit-graph[5] for
     +the `multi-pack-index` format in linkgit:gitformat-pack[5] and
    -+link:technical/commit-graph-format.html[the `commit-graph` format] for
    + the `commit-graph` format in linkgit:gitformat-commit-graph[5] for
      how they use the chunks to describe structured data.
      
    - A chunk-based file format begins with some header information custom to
     @@ Documentation/gitformat-chunk.txt: for future formats:
      * *multi-pack-index:* see `write_midx_internal()` and `load_multi_pack_index()`
        in `midx.c` for how the chunk-format API is used to write and
    @@ Documentation/gitformat-pack-cruft.txt: which aren't already stored in an earlie
     +---
     +Part of the linkgit:git[1] suite
     
    - ## Documentation/gitformat-pack-protocol.txt ##
    -@@ Documentation/gitformat-pack-protocol.txt: Now that the client and server have finished negotiation about what
    - the minimal amount of data that needs to be sent to the client is, the server
    - will construct and send the required data in packfile format.
    - 
    --See pack-format.txt for what the packfile itself actually looks like.
    -+See linkgit:gitformat-pack[5] for what the packfile itself actually looks like.
    - 
    - If 'side-band' or 'side-band-64k' capabilities have been specified by
    - the client, the server will send the packfile data multiplexed.
    -
      ## Documentation/technical/pack-format.txt => Documentation/gitformat-pack.txt ##
     @@
     -Git pack format
    @@ Documentation/technical/pack-format.txt => Documentation/gitformat-pack.txt
     +linkgit:git-gc[1] and linkgit:git-pack-objects[1].
     +
     +The pack format is also used over-the-wire, see
    -+e.g. linkgit:gitformat-protocol-v2[5], as well as being a part of
    ++e.g. linkgit:gitprotocol-v2[5], as well as being a part of
     +other container formats in the case of linkgit:gitformat-bundle[5].
      
      == Checksums and object IDs
    @@ Documentation/gitformat-signature.txt: Date:   Wed Jun 15 09:13:29 2016 +0000
     +---
     +Part of the linkgit:git[1] suite
     
    + ## Documentation/gitprotocol-pack.txt ##
    +@@ Documentation/gitprotocol-pack.txt: Now that the client and server have finished negotiation about what
    + the minimal amount of data that needs to be sent to the client is, the server
    + will construct and send the required data in packfile format.
    + 
    +-See pack-format.txt for what the packfile itself actually looks like.
    ++See linkgit:gitformat-pack[5] for what the packfile itself actually looks like.
    + 
    + If 'side-band' or 'side-band-64k' capabilities have been specified by
    + the client, the server will send the packfile data multiplexed.
    +
      ## Documentation/howto/recover-corrupted-object-harder.txt ##
     @@ Documentation/howto/recover-corrupted-object-harder.txt: Note that the "object" file isn't fit for feeding straight to zlib; it
      has the git packed object header, which is variable-length. We want to
    @@ command-list.txt
     @@ command-list.txt: gitdiffcore                             guide
      giteveryday                             guide
      gitfaq                                  guide
    - gitformat-bundle                        gitformats
    -+gitformat-chunk                         gitformats
    - gitformat-commit-graph                  gitformats
    -+gitformat-index                         gitformats
    -+gitformat-pack                          gitformats
    -+gitformat-pack-cruft                    gitformats
    - gitformat-pack-protocol                 gitformats
    - gitformat-protocol-capabilities         gitformats
    - gitformat-protocol-common               gitformats
    - gitformat-protocol-v2                   gitformats
    -+gitformat-signature                     gitformats
    + gitformat-bundle                        developerinterfaces
    ++gitformat-chunk                         developerinterfaces
    + gitformat-commit-graph                  developerinterfaces
    ++gitformat-index                         developerinterfaces
    ++gitformat-pack                          developerinterfaces
    ++gitformat-pack-cruft                    developerinterfaces
    ++gitformat-signature                     developerinterfaces
      gitglossary                             guide
    - githooks                                userformats
    - gitignore                               userformats
    + githooks                                userinterfaces
    + gitignore                               userinterfaces
     
      ## pack-revindex.h ##
     @@
 7:  499ee582644 !  8:  8f8214addfd docs: move http-protocol docs to man section 5
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/Makefile ##
    -@@ Documentation/Makefile: MAN5_TXT += gitformat-pack-protocol.txt
    - MAN5_TXT += gitformat-pack.txt
    - MAN5_TXT += gitformat-protocol-capabilities.txt
    - MAN5_TXT += gitformat-protocol-common.txt
    -+MAN5_TXT += gitformat-protocol-http.txt
    - MAN5_TXT += gitformat-protocol-v2.txt
    - MAN5_TXT += gitformat-signature.txt
    - MAN5_TXT += githooks.txt
    +@@ Documentation/Makefile: MAN5_TXT += gitmailmap.txt
    + MAN5_TXT += gitmodules.txt
    + MAN5_TXT += gitprotocol-capabilities.txt
    + MAN5_TXT += gitprotocol-common.txt
    ++MAN5_TXT += gitprotocol-http.txt
    + MAN5_TXT += gitprotocol-pack.txt
    + MAN5_TXT += gitprotocol-v2.txt
    + MAN5_TXT += gitrepository-layout.txt
     @@ Documentation/Makefile: TECH_DOCS += SubmittingPatches
      TECH_DOCS += ToolsForGit
      TECH_DOCS += technical/bitmap-format
    @@ Documentation/git-upload-pack.txt: OPTIONS
      	`$GIT_URL/info/refs?service=git-upload-pack` requests. See
     -	"Smart Clients" in link:technical/http-protocol.html[the HTTP
     -	transfer protocols] documentation and "HTTP Transport" in the
    --	linkgit:gitformat-protocol-v2[5] documentation. Also understood by
    -+	"Smart Clients" in linkgit:gitformat-protocol-http[5] and
    -+	"HTTP Transport" in link:technical/protocol-v2.html[the Git
    -+	Wire Protocol, Version 2] documentation. Also understood by
    +-	linkgit:gitprotocol-v2[5] documentation. Also understood by
    ++	"Smart Clients" in linkgit:gitprotocol-http[5] and "HTTP
    ++	Transport" in in the linkgit:gitprotocol-v2[5]
    ++	documentation. Also understood by
      	linkgit:git-receive-pack[1].
      
      <directory>::
     
    - ## Documentation/gitformat-pack-protocol.txt ##
    -@@ Documentation/gitformat-pack-protocol.txt: Git supports transferring data in packfiles over the ssh://, git://, http:// and
    - file:// transports.  There exist two sets of protocols, one for pushing
    - data from a client to a server and another for fetching data from a
    - server to a client.  The three transports (ssh, git, file) use the same
    --protocol to transfer data. http is documented in http-protocol.txt.
    -+protocol to transfer data. http is documented in linkgit:gitformat-protocol-http[5].
    - 
    - The processes invoked in the canonical Git implementation are 'upload-pack'
    - on the server side and 'fetch-pack' on the client side for fetching data;
    -
    - ## Documentation/technical/http-protocol.txt => Documentation/gitformat-protocol-http.txt ##
    + ## Documentation/technical/http-protocol.txt => Documentation/gitprotocol-http.txt ##
     @@
     -HTTP transfer protocols
     -=======================
    -+gitformat-protocol-http(5)
    -+==========================
    ++gitprotocol-http(5)
    ++===================
     +
     +NAME
     +----
    -+gitformat-protocol-http - Git HTTP-based protocols
    ++gitprotocol-http - Git HTTP-based protocols
     +
     +
     +SYNOPSIS
    @@ Documentation/technical/http-protocol.txt => Documentation/gitformat-protocol-ht
      
      Git supports two HTTP based transfer protocols.  A "dumb" protocol
      which requires only a standard HTTP server on the server end of the
    -@@ Documentation/gitformat-protocol-http.txt: the id obtained through ref discovery as old_id.
    +@@ Documentation/gitprotocol-http.txt: the id obtained through ref discovery as old_id.
      
      TODO: Document this further.
      
    @@ Documentation/gitformat-protocol-http.txt: the id obtained through ref discovery
     +SEE ALSO
     +--------
     +
    - linkgit:gitformat-pack-protocol[5]
    - linkgit:gitformat-protocol-capabilities[5]
    + linkgit:gitprotocol-pack[5]
    + linkgit:gitprotocol-capabilities[5]
     +
     +GIT
     +---
     +Part of the linkgit:git[1] suite
     
    - ## Documentation/gitformat-protocol-v2.txt ##
    -@@ Documentation/gitformat-protocol-v2.txt: Initial Client Request
    + ## Documentation/gitprotocol-pack.txt ##
    +@@ Documentation/gitprotocol-pack.txt: Git supports transferring data in packfiles over the ssh://, git://, http:// and
    + file:// transports.  There exist two sets of protocols, one for pushing
    + data from a client to a server and another for fetching data from a
    + server to a client.  The three transports (ssh, git, file) use the same
    +-protocol to transfer data. http is documented in http-protocol.txt.
    ++protocol to transfer data. http is documented in linkgit:gitprotocol-http[5].
    + 
    + The processes invoked in the canonical Git implementation are 'upload-pack'
    + on the server side and 'fetch-pack' on the client side for fetching data;
    +
    + ## Documentation/gitprotocol-v2.txt ##
    +@@ Documentation/gitprotocol-v2.txt: Initial Client Request
      In general a client can request to speak protocol v2 by sending
      `version=2` through the respective side-channel for the transport being
      used which inevitably sets `GIT_PROTOCOL`.  More information can be
    --found in linkgit:gitformat-pack-protocol[5] and `http-protocol.txt`, as well as the
    -+found in linkgit:gitformat-pack-protocol[5] and linkgit:gitformat-protocol-http[5], as well as the
    +-found in linkgit:gitprotocol-pack[5] and `http-protocol.txt`, as well as the
    ++found in linkgit:gitprotocol-pack[5] and linkgit:gitprotocol-http[5], as well as the
      `GIT_PROTOCOL` definition in `git.txt`. In all cases the
      response from the server is the capability advertisement.
      
    -@@ Documentation/gitformat-protocol-v2.txt: HTTP Transport
    +@@ Documentation/gitprotocol-v2.txt: HTTP Transport
      ~~~~~~~~~~~~~~
      
      When using the http:// or https:// transport a client makes a "smart"
     -info/refs request as described in `http-protocol.txt` and requests that
    -+info/refs request as described in linkgit:gitformat-protocol-http[5] and requests that
    ++info/refs request as described in linkgit:gitprotocol-http[5] and requests that
      v2 be used by supplying "version=2" in the `Git-Protocol` header.
      
         C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0
     
      ## command-list.txt ##
    -@@ command-list.txt: gitformat-pack-cruft                    gitformats
    - gitformat-pack-protocol                 gitformats
    - gitformat-protocol-capabilities         gitformats
    - gitformat-protocol-common               gitformats
    -+gitformat-protocol-http                 gitformats
    - gitformat-protocol-v2                   gitformats
    - gitformat-signature                     gitformats
    - gitglossary                             guide
    +@@ command-list.txt: gitmodules                              userinterfaces
    + gitnamespaces                           guide
    + gitprotocol-capabilities                developerinterfaces
    + gitprotocol-common                      developerinterfaces
    ++gitprotocol-http                       developerinterfaces
    + gitprotocol-pack                        developerinterfaces
    + gitprotocol-v2                          developerinterfaces
    + gitremote-helpers                       guide
 8:  f186950e673 !  9:  19601ac36a2 docs: move multi-pack-index docs to man section 5
    @@ Documentation/Makefile: MAN5_TXT += gitformat-bundle.txt
      MAN5_TXT += gitformat-index.txt
     +MAN5_TXT += gitformat-multi-pack-index.txt
      MAN5_TXT += gitformat-pack-cruft.txt
    - MAN5_TXT += gitformat-pack-protocol.txt
      MAN5_TXT += gitformat-pack.txt
    + MAN5_TXT += gitformat-signature.txt
     @@ Documentation/Makefile: TECH_DOCS += ToolsForGit
      TECH_DOCS += technical/bitmap-format
      TECH_DOCS += technical/hash-function-transition
    @@ Documentation/git-multi-pack-index.txt: $ git multi-pack-index verify
      --------
     -See link:technical/multi-pack-index.html[The Multi-Pack-Index Design
     -Document] and linkgit:gitformat-pack[5] for more information on the
    -+
     +See linkgit:git-multi-pack-index[1] and
     +linkgit:gitformat-multi-pack-index[5] for more information on the
      multi-pack-index feature and its file format.
    @@ Documentation/gitformat-pack.txt: packs arranged in MIDX order (with the preferr
      Part of the linkgit:git[1] suite
     
      ## command-list.txt ##
    -@@ command-list.txt: gitformat-bundle                        gitformats
    - gitformat-chunk                         gitformats
    - gitformat-commit-graph                  gitformats
    - gitformat-index                         gitformats
    -+gitformat-multi-pack-index              gitformats
    - gitformat-pack                          gitformats
    - gitformat-pack-cruft                    gitformats
    - gitformat-pack-protocol                 gitformats
    +@@ command-list.txt: gitformat-bundle                        developerinterfaces
    + gitformat-chunk                         developerinterfaces
    + gitformat-commit-graph                  developerinterfaces
    + gitformat-index                         developerinterfaces
    ++gitformat-multi-pack-index              developerinterfaces
    + gitformat-pack                          developerinterfaces
    + gitformat-pack-cruft                    developerinterfaces
    + gitformat-signature                     developerinterfaces
-- 
2.37.1.1095.g64a1e8362fd

