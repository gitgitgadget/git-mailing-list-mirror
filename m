Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5C0C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A201C60F46
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhINN2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhINN2i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 09:28:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74BBC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:27:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g128so4831160wma.5
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5mKpTW6YJIi0DiEQISjAY1Qf9o4irTRrXgltgb9ZnOU=;
        b=at+8VYc2oZzsJz2oAnHqvfG3BcxJopSLmdqJQd2LPEjLsNA+PTQPKE0Syd1Lp5pNDF
         Uzawri60Nly/1K8CAymlRgKkMfCLIqGnmg2GPjW6UKroSidfJnTBwIGwZoleXLCaj6Sq
         psixY6xB2N/eGX4shchiRRr43Lm2XGbxgrsw2cdTIWV2MNJRPCSBMI1gIEV5xg5vPbaH
         XdJm+yZyfCq3b7GgyqVU1/zgMrZbkqS6NuSlXqfYKqOiQZPFuLj/muA8SVh5J+v30N2I
         pFYLbRxLcxrYdG5A2bA4k+DBe1epbQGGL8p7CaHbATOWmlD4Jq24MLEgp8AmdnU0CsMP
         Aocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=5mKpTW6YJIi0DiEQISjAY1Qf9o4irTRrXgltgb9ZnOU=;
        b=4bWwPrC/ufXTv8DeX9GvRpOJVUbsHYAIFawVhjbFsiNGBvCTWz2zZW1egdUIcMa+bl
         UqIg8+HiTYPM1tNKC2w+P2AJNhUCdVmlgZnwHLPe1aavNsb2zlLFqT0Moz+urMygT5W2
         t2qtgXc7JXFp2cZwb1L8232gUJNAN0DAnBFoXrSQTVht6UBFGvIDQG3Fqfi/VMCobshX
         gt8MD32opOlRxMZwlwKkiEVJwXBoCmQjP/apdCBvnGzI7p4zP9mT9m95M0xVC+6wqUin
         /mhgN+wknLQ0rpxuvIFzQu90m8BIb0VtF5LbKCJrtsbCDtCoU0g0RNNSbgxe9Vrh/2f2
         6Gew==
X-Gm-Message-State: AOAM532PSWZ2h/bp8oGo5BoBX3HHA4vQdfk+vbLorQOWNdzu37AMupYP
        UyobXx/Rw687bTQNkIVgDxNUXt8bvD0=
X-Google-Smtp-Source: ABdhPJxXt4MWRkSGEDKDDFsnFStK6jX8Lum5ObGt2S1k8gJO4JaD5B3RQoWxiOQ8jWoQ6PH58F5mBA==
X-Received: by 2002:a1c:9a85:: with SMTP id c127mr2213606wme.111.1631626039515;
        Tue, 14 Sep 2021 06:27:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18sm9989502wrp.97.2021.09.14.06.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 06:27:19 -0700 (PDT)
Message-Id: <pull.1038.v2.git.1631626038.gitgitgadget@gmail.com>
In-Reply-To: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
From:   "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 14 Sep 2021 13:27:16 +0000
Subject: [PATCH v2 0/2] documentation: handle non-existing html pages and document 'git version'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches are grouped as one patch series, because they arose from
the same Git for Windows issue [1], but they can be reviewed or applied
independent from one another.

One interesting oddity I found while preparing V2: git --version --help gets
converted to git version --help which then calls git help version, but git
--help --version gets converted to git help --version and git help doesn't
know what to do with --version.

[1] https://github.com/git-for-windows/git/issues/3308

Changes since V1:

 * fixed various typos in the log message of patch 1
 * changed patch 1 to just check the requested page instead of both the
   requested page and git.html
 * moved the test up before the "generate builtin list" test
 * reworked the test slightly
 * added a second test
 * removed the redundant description of --build-options from the DESCRIPTION
   section
 * added a small paragraph to Documentation/git.txt that links to the new
   git version page (like we already do for git help)

Matthias Aßhauer (2):
  help: make sure local html page exists before calling external
    processes
  documentation: add documentation for 'git version'

 Documentation/git-version.txt | 28 ++++++++++++++++++++++++++++
 Documentation/git.txt         |  4 ++++
 builtin/help.c                |  9 ++++++---
 t/t0012-help.sh               | 16 ++++++++++++++++
 4 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/git-version.txt


base-commit: 8463beaeb69fe0b7f651065813def4aa6827cd5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1038%2Frimrul%2Fdoc-version-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1038/rimrul/doc-version-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1038

Range-diff vs v1:

 1:  8674d67a439 ! 1:  c55360272d5 help: make sure local html page exists before calling external processes
     @@ Metadata
       ## Commit message ##
          help: make sure local html page exists before calling external processes
      
     -    We already check that git.html exists, regardless of the page the user wants
     -    to open. Additionally checking wether the requested page exists gives us a
     -    smoother user experience when it doesn't.
     +    We check that git.html exists, regardless of the page the user wants to open.
     +    Checking whether the requested page exists instead gives us a smoother user
     +    experience in two use cases:
     +
     +    1) The requested page doesn't exist
      
          When calling a git command and there is an error, most users reasonably expect
          git to produce an error message on the standard error stream, but in this case
     -    we pass the filepath to git web--browse wich passes it on to a browser (or a
     -    helper programm like xdg-open or start that should in turn open a browser)
     +    we pass the filepath to git web--browse which passes it on to a browser (or a
     +    helper program like xdg-open or start that should in turn open a browser)
          without any error and many GUI based browsers or helpers won't output such a
          message onto the standard error stream.
      
     -    Especialy the helper programs tend to show the corresponding error message in
     +    Especially the helper programs tend to show the corresponding error message in
          a message box and wait for user input before exiting. This leaves users in
          interactive console sessions without an error message in their console,
          without a console prompt and without the help page they expected.
      
     -    The performance cost of the additional stat should be negliggible compared to
     -    the two or more pocesses that we spawn after the checks.
     +    2) git.html is missing for some reason, but the user asked for some other page
     +
     +    We currently refuse to show any local html help page when we can't find
     +    git.html. Even if the requested help page exists. If we check for the requested
     +    page instead, we can show the user all available pages and only error out on
     +    those that don't exist.
      
          Signed-off-by: Matthias Aßhauer <mha1993@live.de>
      
     @@ builtin/help.c: static void get_html_page_path(struct strbuf *page_path, const c
       
      -	/* Check that we have a git documentation directory. */
      +	/*
     -+	 * Check that we have a git documentation directory and the page we're
     -+	 * looking for exists.
     ++	 * Check that the page we're looking for exists.
      +	 */
       	if (!strstr(html_path, "://")) {
     - 		if (stat(mkpath("%s/git.html", html_path), &st)
     - 		    || !S_ISREG(st.st_mode))
     - 			die("'%s': not a documentation directory.", html_path);
     +-		if (stat(mkpath("%s/git.html", html_path), &st)
      +		if (stat(mkpath("%s/%s.html", html_path, page), &st)
     -+		    || !S_ISREG(st.st_mode))
     + 		    || !S_ISREG(st.st_mode))
     +-			die("'%s': not a documentation directory.", html_path);
      +			die("'%s/%s.html': documentation file not found.",
      +				html_path, page);
       	}
     @@ builtin/help.c: static void get_html_page_path(struct strbuf *page_path, const c
       	strbuf_init(page_path, 0);
      
       ## t/t0012-help.sh ##
     -@@ t/t0012-help.sh: test_expect_success 'generate builtin list' '
     - 	git --list-cmds=builtins >builtins
     +@@ t/t0012-help.sh: test_expect_success 'git help -g' '
     + 	test_i18ngrep "^   tutorial   " help.output
       '
       
      +test_expect_success 'git help fails for non-existing html pages' '
      +	configure_help &&
     -+	mkdir html-doc &&
     -+	touch html-doc/git.html &&
     -+	test_must_fail git -c help.htmlpath=html-doc help status
     ++	mkdir html-empty &&
     ++	test_must_fail git -c help.htmlpath=html-empty help status &&
     ++	test_must_be_empty test-browser.log
      +'
      +
     - while read builtin
     - do
     - 	test_expect_success "$builtin can handle -h" '
     ++test_expect_success 'git help succeeds without git.html' '
     ++	configure_help &&
     ++	mkdir html-with-docs &&
     ++	touch html-with-docs/git-status.html &&
     ++	git -c help.htmlpath=html-with-docs help status &&
     ++	echo "html-with-docs/git-status.html" >expect &&
     ++	test_cmp expect test-browser.log
     ++'
     ++
     + test_expect_success 'generate builtin list' '
     + 	git --list-cmds=builtins >builtins
     + '
 2:  d3635cbfd6e ! 2:  bc9a4534f5b documentation: add documentation for 'git version'
     @@ Commit message
          it is a non-experimental user-facing builtin command. As such
          it should have a help page.
      
     +    Both `git help` and `git version` can be called as options
     +    (`--help`/`--version`) that internally get converted to the
     +    corresponding command. Add a small paragraph to
     +    Documentation/git.txt describing how these two options
     +    interact with each other and link to this help page for the
     +    sub-options that `--version` can take. Well, currently there
     +    is only one sub-option, but that could potentially increase
     +    in future versions of Git.
     +
          Signed-off-by: Matthias Aßhauer <mha1993@live.de>
      
       ## Documentation/git-version.txt (new) ##
     @@ Documentation/git-version.txt (new)
      +----
      +git-version - Display version information about Git
      +
     -+
      +SYNOPSIS
      +--------
      +[verse]
      +'git version' [--build-options]
      +
     -+
      +DESCRIPTION
      +-----------
     -+
     -+With no options given, the version of 'git' is printed
     -+on the standard output.
     -+
     -+If the option `--build-options` is given, information about how git was built is
     -+printed on the standard output in addition to the version number.
     ++With no options given, the version of 'git' is printed on the standard output.
      +
      +Note that `git --version` is identical to `git version` because the
      +former is internally converted into the latter.
     @@ Documentation/git-version.txt (new)
      +OPTIONS
      +-------
      +--build-options::
     -+	Prints out additional information about how git was built for diagnostic
     ++	Include additional information about how git was built for diagnostic
      +	purposes.
      +
      +GIT
      +---
      +Part of the linkgit:git[1] suite
     +
     + ## Documentation/git.txt ##
     +@@ Documentation/git.txt: OPTIONS
     + -------
     + --version::
     + 	Prints the Git suite version that the 'git' program came from.
     +++
     ++This option is internaly converted to `git version ...` and accepts
     ++the same options as the linkgit:git-version[1] command. If `--help` is
     ++also given, it takes precedence over `--version`.
     + 
     + --help::
     + 	Prints the synopsis and a list of the most commonly used

-- 
gitgitgadget
