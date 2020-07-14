Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE475C433E1
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 01:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7340621548
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 01:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK4nI72f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGNB1B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNB1A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 21:27:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F60BC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 18:27:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so19277135wru.6
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yLodpDT6fploG1hUec6r6MFP20OM7HEBclkJ7tUdj+o=;
        b=kK4nI72fx4uNbKFZiK+WRP8aSoiig7izhNGcONp9gN8WUJUQh9lIEE2GPqQgSatjr3
         P410olZ0337DDlLe/ueGQlC+F+8NdTu0ezTWE0W9VeL9bhzpuXT7ZaB6sR4qFZDu14yK
         kEfdS1+5Jhtaw9BZ4o8HDlEhWTpCOqunyg7XmyjpDLtJsHSoNtecg9RCPwgPXPLIB0h0
         aLkvOQpNTA/a8PPYisfkvQmHT+Fo6UrOYy+iYUbEzDw3oLGw/JMjb220jHl8Wz4k4ifp
         q6fuHFyOYWenqbsUz8PvIM5PKXuydf+pO0srW77CpaTHDqOzWRMWavtU9qqo0hWSlX1x
         Bt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yLodpDT6fploG1hUec6r6MFP20OM7HEBclkJ7tUdj+o=;
        b=bfqtmuVveDkQj3RFEP7Yr+ZeCdlVZHD0uxpxU1d6W158zPLlue16NKVQ/E4BOovk3P
         2K8H6h6VxbMxyq7Ph5UKcmyPs1liZyNsd8utaPQors8aWus9As48zPl9pc6odoXj658s
         YLDn2VV/j/9ntByTS++8n61gltFCUnEXzO06jOTKaEwUhGzH4Pu3cGoXl5JkqNY/nmii
         MW3BjzDmiD1+8WDVa9rwIv0WImh6S18WwJ/IoUqVnyZqIeN6m4IjO+y9OPUioIUJquZU
         8ukyTzYRizD51scdPfAVCSeh4IERDb051yiqwKio9Ld5nXSyGXpnOxkoQykeTzT3xRop
         dj/A==
X-Gm-Message-State: AOAM532menenysv26mlWPQ+b1UMA0Of3pKDd+bi9dOU6wpfiXAzxBITa
        5dHEvGlLt/MA3WTL0NZ8sCfMU4dx
X-Google-Smtp-Source: ABdhPJwqUJHTHzD3Cax45NFwvITuDa36MHaDDhPOcIqhQK6EgOSjGc7i3HHepKVfrqpG9wE0/lpVAw==
X-Received: by 2002:adf:ea84:: with SMTP id s4mr2190709wrm.222.1594690018713;
        Mon, 13 Jul 2020 18:26:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm27163322wrj.8.2020.07.13.18.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 18:26:58 -0700 (PDT)
Message-Id: <pull.674.v2.git.1594690017.gitgitgadget@gmail.com>
In-Reply-To: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
References: <pull.674.git.1594668051847.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jul 2020 01:26:55 +0000
Subject: [PATCH v2 0/2] setup: warn if extensions exist on old format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, delphij@google.com, peff@peff.net,
        johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on xl/upgrade-repo-format.

Thanks, Taylor and Junio for jumping in with helpful review.

Updates in v2:

 1. My initial patch is essentially dropped in its entirety, with Junio's
    patch here instead. I added an extra test and kept some of my commit
    message.
    
    
 2. A second patch has joined the fray, hopefully answering the concerned
    raise by Johannes [1].
    
    

[1] 
https://lore.kernel.org/git/pull.675.git.1594677321039.gitgitgadget@gmail.com/

Thanks, -Stolee

Derrick Stolee (2):
  setup: tweak upgrade policy to grandfather worktreeconfig
  config: provide extra detail about worktree config

 builtin/config.c                   |  5 +++--
 cache.h                            |  2 +-
 setup.c                            | 12 ++++++++----
 t/t1091-sparse-checkout-builtin.sh | 12 ++++++++++++
 t/t2404-worktree-config.sh         | 12 ++++++++++++
 5 files changed, 36 insertions(+), 7 deletions(-)


base-commit: 14c7fa269e42df4133edd9ae7763b678ed6594cd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-674%2Fderrickstolee%2Fsparse-checkout-warning-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-674/derrickstolee/sparse-checkout-warning-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/674

Range-diff vs v1:

 1:  113cb7cda2 ! 1:  1b26d9710a setup: warn if extensions exist on old format
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    setup: warn if extensions exist on old format
     +    setup: tweak upgrade policy to grandfather worktreeconfig
      
          Prior to 14c7fa269e4 (check_repository_format_gently(): refuse extensions
          for old repositories, 2020-06-05), Git was honoring configured
     @@ Commit message
      
          The issue now is that users who relied on that previously bad behavior
          will upgrade to the next version of Git and suddently be in a bad
     -    situation. In particular, users of the 'git sparse-checkout' builting
     +    situation. In particular, users of the 'git sparse-checkout' command
          will rely on the extensions.worktreeConfig for the core.sparseCheckout
          and core.sparseCheckoutCone config options. Without that extension,
          these users will suddenly have repositories stop acting like a sparse
     @@ Commit message
          This is because the logic in 14c7fa269e4 refuses to upgrae repos when
          the version is unset but extensions exist.
      
     -    While it is important to correct this improper behavior, create a
     -    warning so users in this situation can correct themselves without too
     -    much guesswork. By creating a warning in
     -    check_repository_format_gently(), we can alert the user if they have a
     -    ocnfigured extension but not a configured repository version.
     +    One possible way to alert a user of this issue is to warn them when Git
     +    notices an extension exists, but core.repositoryFormatVersion is not a
     +    correct value. However,
      
     +     - it requires the end-user to read, understand and execute the
     +       manual upgrade
     +
     +     - it encourages to follow the same procedure blindly, making the
     +       protection even less useful
     +
     +    Let's instead keep failing hard without teaching how to bypass the
     +    repository protection, but allow upgrading even when only the
     +    worktreeconfig extension exists in an old repository, which is
     +    likely to be set by a broke version of Git that did not update the
     +    repository version when setting the extension.
     +
     +    This change of behavior is made visible by testing how 'git
     +    sparse-checkout init' behaves to upgrade the repository format version
     +    even if the extension.worktreeConfig is already set. This would
     +    previously fail without a clear way forward.
     +
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     + ## cache.h ##
     +@@ cache.h: struct repository_format {
     + 	int worktree_config;
     + 	int is_bare;
     + 	int hash_algo;
     +-	int has_extensions;
     + 	char *work_tree;
     ++	int has_unallowed_extensions;
     + 	struct string_list unknown_extensions;
     + };
     + 
     +
       ## setup.c ##
     -@@ setup.c: static int check_repository_format_gently(const char *gitdir, struct repository_
     - 		}
     +@@ setup.c: static int check_repo_format(const char *var, const char *value, void *vdata)
     + 	if (strcmp(var, "core.repositoryformatversion") == 0)
     + 		data->version = git_config_int(var, value);
     + 	else if (skip_prefix(var, "extensions.", &ext)) {
     +-		data->has_extensions = 1;
     + 		/*
     + 		 * record any known extensions here; otherwise,
     + 		 * we fall through to recording it as unknown, and
     + 		 * check_repository_format will complain
     + 		 */
     ++		int is_unallowed_extension = 1;
     ++
     + 		if (!strcmp(ext, "noop"))
     + 			;
     + 		else if (!strcmp(ext, "preciousobjects"))
     +@@ setup.c: static int check_repo_format(const char *var, const char *value, void *vdata)
     + 			if (!value)
     + 				return config_error_nonbool(var);
     + 			data->partial_clone = xstrdup(value);
     +-		} else if (!strcmp(ext, "worktreeconfig"))
     ++		} else if (!strcmp(ext, "worktreeconfig")) {
     + 			data->worktree_config = git_config_bool(var, value);
     +-		else
     ++			is_unallowed_extension = 0;
     ++		} else
     + 			string_list_append(&data->unknown_extensions, ext);
     ++
     ++		data->has_unallowed_extensions |= is_unallowed_extension;
       	}
       
     -+	if (candidate->version == 0 && candidate->has_extensions) {
     -+		warning(_("some extensions are enabled, but core.repositoryFormatVersion=0"));
     -+		warning(_("if you intended to use extensions, run 'git config core.repositoryFormatVersion 1'"));
     -+	}
     -+
     - 	return 0;
     - }
     + 	return read_worktree_config(var, value, vdata);
     +@@ setup.c: int upgrade_repository_format(int target_version)
     + 		return 0;
       
     + 	if (verify_repository_format(&repo_fmt, &err) < 0 ||
     +-	    (!repo_fmt.version && repo_fmt.has_extensions)) {
     ++	    (!repo_fmt.version && repo_fmt.has_unallowed_extensions)) {
     + 		warning("unable to upgrade repository format from %d to %d: %s",
     + 			repo_fmt.version, target_version, err.buf);
     + 		strbuf_release(&err);
      
       ## t/t1091-sparse-checkout-builtin.sh ##
      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'git sparse-checkout init' '
       	check_files repo a
       '
       
     -+test_expect_success 'warning about core.repositoryFormatVersion' '
     ++test_expect_success 'git sparse-checkout works if repository format is wrong' '
      +	test_when_finished git -C repo config core.repositoryFormatVersion 1 &&
     -+	git -C repo status 2>err &&
     -+	test_must_be_empty err &&
     -+	git -C repo config --local core.repositoryFormatVersion 0 &&
     -+	git -C repo status 2>err &&
     -+	test_i18ngrep "some extensions are enabled, but core.repositoryFormatVersion=0" err
     ++	git -C repo config --unset core.repositoryFormatVersion &&
     ++	git -C repo sparse-checkout init &&
     ++	git -C repo config core.repositoryFormatVersion >actual &&
     ++	echo 1 >expect &&
     ++	git -C repo config core.repositoryFormatVersion 0 &&
     ++	git -C repo sparse-checkout init &&
     ++	git -C repo config core.repositoryFormatVersion >actual &&
     ++	test_cmp expect actual
      +'
      +
       test_expect_success 'git sparse-checkout list after init' '
 -:  ---------- > 2:  e11e973c6f config: provide extra detail about worktree config

-- 
gitgitgadget
