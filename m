Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38907C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC7064DA1
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBSMzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 07:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSMzI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 07:55:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E48CC06121F
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:53:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t15so8260551wrx.13
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Abq5RV8Veb6+M3aXs66sYdqL9Hu8aO1oErSGk41zO+w=;
        b=V4wjKUfQi78V3q9D/33vVve+qUi2bp3cvUBQeS4h5RJ55rUKJuptnqHbZ1YVtFDEqz
         i66TvZJT7B2CzjVvraGzJcvx3a59Zj9V1Bhj4UgizuuEUnTh0phM4HL75Z8ToatZQq9X
         sr0YXpmcBW+t6HLGO0JrBQPFUOvW2Neg1YcgH77Nc6ZJJ9cKBuyRw/U5UXwZEpN+ZqB8
         t1capRWE56WBiv+9GePUbwCcQOHeP5zCXyinbLgpzRxOnKoXqZgvf77wBcUWeYxiplMS
         514Y+YEXtiueiH5nv2Zxg+4OAOO7XxUAsRoDqxnF/zYkfEMj8Wvdhy4R6tk9Ld9nXFIZ
         lHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Abq5RV8Veb6+M3aXs66sYdqL9Hu8aO1oErSGk41zO+w=;
        b=PeMawUdDmT0bUYVG4G7lrageabxmiohgWsMNNjwCFH1IgNmilGEVZYvyjY1G46+jnp
         nFDPZEjDuMJhpRjHpHk7eSp6Ywcv7FCkoW5WKCK6z3AeOKFr69LpfWhq9GKXi/51txTI
         AFG7cW+pD8sPOiyEKXkZSBpUe/fdFpFlKC9KJ3Vs3dmwQPhiWWxN6NvMnnJX4wD0Fi5O
         XiFklkHMvJptuv71oa1tVxJ5lI/vnbMPsQDvtiiIJZpEkPxoCC0K1xsIzrjEesk1Ped2
         t01yvwsExXq2+mzBOqIsBePmSmDqibRVQJlEtJJ7TUS0ZBIcODAiMRS8I1TtiUE/w0G6
         UYXw==
X-Gm-Message-State: AOAM533mcZAVtR7tz+yPQAgVlO2dbWC9E7r1YLb9hV4cM/F29wUyZ3if
        QB1xQKAMn+kJK1iT8hRAoxy13mnEtI4=
X-Google-Smtp-Source: ABdhPJzwoJjvrXt7UGyujvRTNMa1gLxh8ce5f9QYtDziTIzj0vW1bYCefvxTBvkngFA7AJumWylVyg==
X-Received: by 2002:adf:fb03:: with SMTP id c3mr9064826wrr.395.1613739236375;
        Fri, 19 Feb 2021 04:53:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm1072190wmg.2.2021.02.19.04.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 04:53:55 -0800 (PST)
Message-Id: <pull.870.v6.git.1613739235241.gitgitgadget@gmail.com>
In-Reply-To: <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
References: <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 12:53:54 +0000
Subject: [PATCH v6] difftool.c: learn a new way start at specified file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

`git difftool` only allow us to select file to view in turn.
If there is a commit with many files and we exit in the middle,
we will have to traverse list again to get the file diff which
we want to see. Therefore,teach the command an option
`--skip-to=<path>` to allow the user to say that diffs for earlier
paths are not interesting (because they were already seen in an
earlier session) and start this session with the named path.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    difftool.c: learn a new way start at specified file
    
     * The patch of the previous version implemented the jump through
       environment variables. The current version is based on the "diff
       --skip-to=" feature implemented by gitster, which implements a
       possible solution for the jump of difftool.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-870%2Fadlternative%2Fdifftool_save_point-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-870/adlternative/difftool_save_point-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/870

Range-diff vs v5:

 1:  fb4bfd0f8b16 < -:  ------------ diff: --{rotate,skip}-to=<path>
 2:  98e2707ee2fa ! 1:  4377a917ca9e difftool.c: learn a new way start at specified file
     @@ Commit message
          difftool.c: learn a new way start at specified file
      
          `git difftool` only allow us to select file to view in turn.
     -    If there is a commit with many files and we exit in the search,
     -    We will have to traverse list again to get the file diff which
     -    we want to see. Therefore, here is a new method: user can use
     -    `git difftool --rotate-to=<filename>` or `git difftool --skip-to=<filename>`
     -    to start viewing from the specified file, This will improve the
     -    user experience.
     -
     -    `git difftool --rotate-to=<file>` or `git difftool --skip-to=<filename>`
     -    will pass the path to `diffcore-rotate`, and diff-core will
     -    adjust the order of files, make the specified file sorted to
     -    the first.`git difftool --rotate-to=<file>` will move files before
     -    the  specified path to the last output, and
     -    `git difftool --skip-to=<filename>`  will ignore these files output.
     -    It is an error when there is no patch for specified file is shown.
     +    If there is a commit with many files and we exit in the middle,
     +    we will have to traverse list again to get the file diff which
     +    we want to see. Therefore,teach the command an option
     +    `--skip-to=<path>` to allow the user to say that diffs for earlier
     +    paths are not interesting (because they were already seen in an
     +    earlier session) and start this session with the named path.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     - ## Documentation/diff-options.txt ##
     -@@ Documentation/diff-options.txt: components matches the pattern.  For example, the pattern "`foo*bar`"
     - matches "`fooasdfbar`" and "`foo/bar/baz/asdf`" but not "`foobarx`".
     - 
     - --skip-to=<file>::
     ----rotate-to=<file::
     -+--rotate-to=<file>::
     - 	Discard the files before the named <file> from the output
     - 	(i.e. 'skip to'), or move them to the end of the output
     - 	(i.e. 'rotate to').  These were invented primarily for use
     -
       ## Documentation/git-difftool.txt ##
      @@ Documentation/git-difftool.txt: OPTIONS
       	This is the default behaviour; the option is provided to
       	override any configuration settings.
       
      +--rotate-to=<file>::
     -+	Internally call `git diff --rotate-to=<file>`,
     -+	show the change in the specified path first.
     -+	Files before the specified path will be moved to the last output.
     ++	Start showing the diff for the given path,
     ++	the paths before it will move to end and output.
      +
      +--skip-to=<file>::
     -+	Internally call `git diff --skip-to=<file>`,
     -+	skip the output to the specified path.
     -+	Files before the specified path will not output.
     ++	Start showing the diff for the given path, skipping all
     ++	the paths before it.
      +
       -t <tool>::
       --tool=<tool>::
     @@ t/t7800-difftool.sh: test_expect_success 'difftool --gui, --tool and --extcmd ar
      +	4
      +	1
      +	EOF
     -+	test_cmp output expect &&
     -+	test_must_fail git difftool --no-prompt --extcmd=cat --rotate-to="3" HEAD^
     ++	test_cmp output expect
      +'
      +
      +test_expect_success 'difftool --skip-to' '
     @@ t/t7800-difftool.sh: test_expect_success 'difftool --gui, --tool and --extcmd ar
      +	2
      +	4
      +	EOF
     -+	test_cmp output expect &&
     -+	test_must_fail git difftool --no-prompt --extcmd=cat --skip-to="3" HEAD^
     ++	test_cmp output expect
      +'
      +
     ++test_expect_success 'difftool --rotate/skip-to error condition' '
     ++	test_must_fail git difftool --no-prompt --extcmd=cat --rotate-to="3" HEAD^ &&
     ++	test_must_fail git difftool --no-prompt --extcmd=cat --skip-to="3" HEAD^
     ++'
       test_done


 Documentation/git-difftool.txt |  8 ++++++++
 t/t7800-difftool.sh            | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 484c485fd06c..143b0c49d739 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -34,6 +34,14 @@ OPTIONS
 	This is the default behaviour; the option is provided to
 	override any configuration settings.
 
+--rotate-to=<file>::
+	Start showing the diff for the given path,
+	the paths before it will move to end and output.
+
+--skip-to=<file>::
+	Start showing the diff for the given path, skipping all
+	the paths before it.
+
 -t <tool>::
 --tool=<tool>::
 	Use the diff tool specified by <tool>.  Valid values include
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9192c141ffc6..3e041e83aede 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -762,4 +762,36 @@ test_expect_success 'difftool --gui, --tool and --extcmd are mutually exclusive'
 	test_must_fail git difftool --gui --tool=test-tool --extcmd=cat
 '
 
+test_expect_success 'difftool --rotate-to' '
+	difftool_test_setup &&
+	test_when_finished git reset --hard &&
+	echo 1 >1 &&
+	echo 2 >2 &&
+	echo 4 >4 &&
+	git add 1 2 4 &&
+	git commit -a -m "124" &&
+	git difftool --no-prompt --extcmd=cat --rotate-to="2" HEAD^ >output&&
+	cat >expect <<-\EOF &&
+	2
+	4
+	1
+	EOF
+	test_cmp output expect
+'
+
+test_expect_success 'difftool --skip-to' '
+	difftool_test_setup &&
+	test_when_finished git reset --hard &&
+	git difftool --no-prompt --extcmd=cat --skip-to="2" HEAD^ >output &&
+	cat >expect <<-\EOF &&
+	2
+	4
+	EOF
+	test_cmp output expect
+'
+
+test_expect_success 'difftool --rotate/skip-to error condition' '
+	test_must_fail git difftool --no-prompt --extcmd=cat --rotate-to="3" HEAD^ &&
+	test_must_fail git difftool --no-prompt --extcmd=cat --skip-to="3" HEAD^
+'
 test_done

base-commit: 1eb4136ac2a24764257567b930535fcece01719f
-- 
gitgitgadget
