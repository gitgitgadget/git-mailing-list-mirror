Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B69C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhK2WWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhK2WUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:20:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFB7C08EACA
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so13215915wmc.2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sUJSAiJhcC5JnTwrCFHARM30Q7J6r/neb9l/9Tappbo=;
        b=OpSPQHpjp0YgThXQybDUSxO8bXqM7SfSDqBdEF4gVLQGuhvaI6yvUpVK+fPzW10DiH
         XKCEcANDJ5cXLhNGXvJdHmdNNpXBSynwHUxwQUDO5MbBgqTb4Utzzir0coXCScGZf/5H
         /yZvSinHthiuc8Ytd8EON6jQAZBexmc5EGAGk6BzU+x+a26SGfBohPQW5N1wSVvcxmlp
         RcuH9TjUIN0tMB9Q7Hs0Xv1vYGpJNb4oQBi8l41BMMAZsDVDq4iQOzXFVxMvfEe7n40F
         F3X4yQslWpInZL48hRpHveFw4Wam3XgQ7SAuFd67jEQaMOS/uznhzoAM2Yw+g74CB7X3
         FYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sUJSAiJhcC5JnTwrCFHARM30Q7J6r/neb9l/9Tappbo=;
        b=vzHRxi6IFUDKlx93pkeZlWFmIHtIFdhfHfGpWrYGciL6WKa19CdV3C2JtERHd5SAJj
         MdpkJh3FRQ4vAtJVmMXOSRUg+9jVrJuZo4ZrERw9PQeTvHxgRKT6j+ni9PcLuwz761HH
         0Rz/T9HNZfdG11yB84nQmzO6z4gutLP31c5wkHRrl/++BkUY3CUgxWUntwfhGbF2JsF+
         ROVr0Fk3z/u6YrnjSH2y87hAMc6dQ9l4MFPJ6ouySBm9P3aEMm3Nc4CW2EoImZjvNfaB
         uAt4z+hi0d4Je+6b4lWO8iAgnMhWDvYUTBFopxZYcT3ah6gL4cKtFIFydP3AkA8ja6WQ
         lr8w==
X-Gm-Message-State: AOAM530F67yX25MJeV1WD0t1qujZaTymJ59Gu3Bi7mApEsvAERMAzhfE
        D9fpJupNp+IXyFTQEimIbBLI4i4DP8tT5w==
X-Google-Smtp-Source: ABdhPJwMYjHFXWIBZxvelOY6uCyINF0SZIq+lAt/JH9WALaQlPaTE5jTVER8XTrX9YdTMPSfzd5lWQ==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr169146wmb.90.1638215954209;
        Mon, 29 Nov 2021 11:59:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/10] cat-file: better usage UX & error messages
Date:   Mon, 29 Nov 2021 20:57:40 +0100
Message-Id: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches to cat-file significantly improves the UX of
the -h output, see 08/10. For the v2 see[1].

This is mainly a re-submission for a series that got lost in the
shuffle around the last release, but in going through it again I made
some minor updates, see the below range-diff.

John Cai (CC'd) expressed interest in reviewing this & perhaps running
with the WIP patch I noted in [2] for extending "cat-file --batch" to
accept named commands. This series should help that along, i.e. it
eliminates the confusion about what does and doesn't combine with the
batch mode.

1. https://lore.kernel.org/git/cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com/
2. https://lore.kernel.org/git/211106.86k0hmgc8q.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (10):
  cat-file tests: test bad usage
  cat-file tests: test messaging on bad objects/paths
  parse-options API: add a usage_msg_optf()
  cat-file docs: fix SYNOPSIS and "-h" output
  cat-file: move "usage" variable to cmd_cat_file()
  cat-file: make --batch-all-objects a CMDMODE
  cat-file: fix remaining usage bugs
  cat-file: correct and improve usage information
  object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
  cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)

 Documentation/git-cat-file.txt |  10 +-
 builtin/cat-file.c             | 181 ++++++++++++++++++++-------------
 builtin/stash.c                |   4 +-
 cache.h                        |   1 +
 object-name.c                  |  11 +-
 parse-options.c                |  13 +++
 parse-options.h                |  10 ++
 t/t1006-cat-file.sh            |  92 +++++++++++++++++
 t/t8007-cat-file-textconv.sh   |  42 ++++++++
 9 files changed, 283 insertions(+), 81 deletions(-)

Range-diff against v2:
 1:  3a0d2923cfa !  1:  d77771e3ea0 cat-file tests: test bad usage
    @@ t/t1006-cat-file.sh: test_description='git cat-file'
     +}
     +
     +for switches in \
    -+    '-e -p' \
    -+    '-p -t' \
    -+    '-t -s' \
    -+    '-s --textconv' \
    -+    '--textconv --filters'
    ++	'-e -p' \
    ++	'-p -t' \
    ++	'-t -s' \
    ++	'-s --textconv' \
    ++	'--textconv --filters'
     +do
     +	test_expect_success "usage: cmdmode $switches" '
     +		test_cmdmode_usage git cat-file $switches
 2:  fc8d5e60682 !  2:  ab21a69864f cat-file tests: test messaging on bad objects/paths
    @@ t/t8007-cat-file-textconv.sh: test_expect_success 'setup ' '
      	GIT_AUTHOR_NAME=Number2 git commit -a -m Second --date="2010-01-01 20:00:00"
      '
      
    -+test_expect_success 'usage' '
    ++test_expect_success 'usage: <bad rev>' '
     +	cat >expect <<-\EOF &&
     +	fatal: Not a valid object name HEAD2
     +	EOF
     +	test_must_fail git cat-file --textconv HEAD2 2>actual &&
    -+	test_cmp expect actual &&
    ++	test_cmp expect actual
    ++'
     +
    ++test_expect_success 'usage: <bad rev>:<bad path>' '
     +	cat >expect <<-\EOF &&
     +	fatal: Not a valid object name HEAD2:two.bin
     +	EOF
     +	test_must_fail git cat-file --textconv HEAD2:two.bin 2>actual &&
    -+	test_cmp expect actual &&
    ++	test_cmp expect actual
    ++'
     +
    ++test_expect_success 'usage: <rev>:<bad path>' '
    ++	cat >expect <<-\EOF &&
    ++	fatal: Not a valid object name HEAD:two.bin
    ++	EOF
    ++	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++
    ++test_expect_success 'usage: <rev> with no <path>' '
     +	cat >expect <<-\EOF &&
     +	fatal: git cat-file --textconv HEAD: <object> must be <sha1:path>
     +	EOF
     +	test_must_fail git cat-file --textconv HEAD 2>actual &&
    -+	test_cmp expect actual &&
    ++	test_cmp expect actual
    ++'
    ++
     +
    ++test_expect_success 'usage: <bad rev>:<good (in HEAD) path>' '
     +	cat >expect <<-\EOF &&
    -+	fatal: Not a valid object name HEAD:two.bin
    ++	fatal: Not a valid object name HEAD2:one.bin
     +	EOF
    -+	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
    ++	test_must_fail git cat-file --textconv HEAD2:one.bin 2>actual &&
     +	test_cmp expect actual
     +'
     +
 3:  0e2e5ab9d2d =  3:  69ef1ae48c3 parse-options API: add a usage_msg_optf()
 4:  b9c935b95b7 =  4:  597bb97b90a cat-file docs: fix SYNOPSIS and "-h" output
 5:  664c5db634e =  5:  a9ea4c52222 cat-file: move "usage" variable to cmd_cat_file()
 6:  d945fc94774 !  6:  fcb8331f091 cat-file: make --batch-all-objects a CMDMODE
    @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
     
      ## t/t1006-cat-file.sh ##
     @@ t/t1006-cat-file.sh: for switches in \
    -     '-p -t' \
    -     '-t -s' \
    -     '-s --textconv' \
    --    '--textconv --filters'
    -+    '--textconv --filters' \
    -+    '--batch-all-objects -e'
    + 	'-p -t' \
    + 	'-t -s' \
    + 	'-s --textconv' \
    +-	'--textconv --filters'
    ++	'--textconv --filters' \
    ++	'--batch-all-objects -e'
      do
      	test_expect_success "usage: cmdmode $switches" '
      		test_cmdmode_usage git cat-file $switches
 7:  22f55e1fb6b =  7:  ad79e2afc89 cat-file: fix remaining usage bugs
 8:  0842df64695 =  8:  a378dd30dd0 cat-file: correct and improve usage information
 9:  6642b57c6fe =  9:  145c00db08c object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
10:  177f16ba856 ! 10:  45a24f97c88 cat-file: improve --(textconv|filters) disambiguation
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    cat-file: improve --(textconv|filters) disambiguation
    +    cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
     
    -    Improve the errors emitted when an invalid <object> and/or <path> is
    -    provided with either the --path option, or as an argument. We now use
    -    the same logic in get_oid_with_context_1() that "git show" et al use.
    +    Change the cat_one_file() logic that calls get_oid_with_context()
    +    under --textconv and --filters to use the GET_OID_ONLY_TO_DIE flag,
    +    thus improving the error messaging emitted when e.g. <path> is missing
    +    but <rev> is not.
     
    -    To replace the "cat-file" use-case we need to introduce a new
    +    To service the "cat-file" use-case we need to introduce a new
         "GET_OID_REQUIRE_PATH" flag, otherwise it would exit early as soon as
         a valid "HEAD" was resolved, but in the "cat-file" case being changed
         we always need a valid revision and path.
     
    +    This arguably makes the "<bad rev>:<bad path>" and "<bad
    +    rev>:<good (in HEAD) path>" use cases worse, as we won't quote the
    +    <path> component at the user anymore, but let's just use the existing
    +    logic "git log" et al use for now. We can improve the messaging for
    +    those cases as a follow-up for all callers.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/cat-file.c ##
    @@ object-name.c: static enum get_oid_result get_oid_with_context_1(struct reposito
      	 * :path -> object name of absolute path in index
     
      ## t/t8007-cat-file-textconv.sh ##
    -@@ t/t8007-cat-file-textconv.sh: test_expect_success 'usage' '
    - 	test_cmp expect actual &&
    +@@ t/t8007-cat-file-textconv.sh: test_expect_success 'usage: <bad rev>' '
      
    + test_expect_success 'usage: <bad rev>:<bad path>' '
      	cat >expect <<-\EOF &&
     -	fatal: Not a valid object name HEAD2:two.bin
     +	fatal: invalid object name '\''HEAD2'\''.
      	EOF
      	test_must_fail git cat-file --textconv HEAD2:two.bin 2>actual &&
    - 	test_cmp expect actual &&
    + 	test_cmp expect actual
    +@@ t/t8007-cat-file-textconv.sh: test_expect_success 'usage: <bad rev>:<bad path>' '
    + 
    + test_expect_success 'usage: <rev>:<bad path>' '
    + 	cat >expect <<-\EOF &&
    +-	fatal: Not a valid object name HEAD:two.bin
    ++	fatal: path '\''two.bin'\'' does not exist in '\''HEAD'\''
    + 	EOF
    + 	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
    + 	test_cmp expect actual
    +@@ t/t8007-cat-file-textconv.sh: test_expect_success 'usage: <rev>:<bad path>' '
      
    + test_expect_success 'usage: <rev> with no <path>' '
      	cat >expect <<-\EOF &&
     -	fatal: git cat-file --textconv HEAD: <object> must be <sha1:path>
     +	fatal: <object>:<path> required, only <object> '\''HEAD'\'' given
      	EOF
      	test_must_fail git cat-file --textconv HEAD 2>actual &&
    - 	test_cmp expect actual &&
    + 	test_cmp expect actual
    +@@ t/t8007-cat-file-textconv.sh: test_expect_success 'usage: <rev> with no <path>' '
      
    + test_expect_success 'usage: <bad rev>:<good (in HEAD) path>' '
      	cat >expect <<-\EOF &&
    --	fatal: Not a valid object name HEAD:two.bin
    -+	fatal: path '\''two.bin'\'' does not exist in '\''HEAD'\''
    +-	fatal: Not a valid object name HEAD2:one.bin
    ++	fatal: invalid object name '\''HEAD2'\''.
      	EOF
    - 	test_must_fail git cat-file --textconv HEAD:two.bin 2>actual &&
    + 	test_must_fail git cat-file --textconv HEAD2:one.bin 2>actual &&
      	test_cmp expect actual
-- 
2.34.1.841.gf15fb7e6f34

