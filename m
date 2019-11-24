Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8213C432C3
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 08:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9C32075E
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 08:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obeLkj7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfKXIBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 03:01:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40344 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfKXIBR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 03:01:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id y5so12284697wmi.5
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 00:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4EgIZ1IbfAhNQ7UcrXfKKqly4OwurdwfGw/5qLqMA68=;
        b=obeLkj7hKrRCCirm7NrDU9MYb/i7syM+/NQVt3KUnbyCcJCqcZseGW3culmQ93A/gw
         UybAG/oRFnCiiQCd6CifZnuP1RqkM/EWz8P3c9B14GowVMsQlkZL2SRyshWifzUUiYKi
         2ITulS6OwS4FIsVaVOECSd12kw7Ygkt6JYeW4IpKgXm5UDwVD1uIhhyN7Ye+e27y1tfU
         yNpQOSUrk+pTcwyL3To3egvPuktsrG2St3Gn660PyCozVh1bPCxPu8HfgpCXdRmNlx7P
         HaQ0aJY7QP0ZhL4PJ1CNdHr4KvQvg1vcuBYREdLjWTu22/AcOuoAMKqlq8agNZkWXAk7
         y0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4EgIZ1IbfAhNQ7UcrXfKKqly4OwurdwfGw/5qLqMA68=;
        b=Se/4s7aW+ViOfXGxFW2wIxrFlVg1fH5D+/LCsyBRg1ED7BjNAgz3uMxcXznhjQ694c
         OWQMpcAl37fB8LuYiLcjeWriIYSmm7wPwfgz+hJ0c3RP9KFzXs4quRLhSszD4Ub7D1sd
         1pE4j6lfTB+n28ZV2oni/ZqYqmuDO88+XU7SRUPP0L8vdcjP9Eg6ZwC5gfCZNVmiJISq
         H0E047oz59qi52IHijvJVBrg+qaEA2w9P3+e3xDq1NZh3KEUalZV3NMXjk6+ckgGRWVW
         DT8e5hW62cHkIpV9RCAhKvAPZp0xt2n09kjXsnJLBX36p7Svv0oWZJ55RZoJlAR6FbtU
         GH4Q==
X-Gm-Message-State: APjAAAUcH6l1q5Ov5zPmo+RtkXAYweGjCRCf/b4AVUYDmwxuU1pwu2kf
        451DfewYQBW5+QNs+ZllXz/xto7F
X-Google-Smtp-Source: APXvYqyqRhcjMI4ui0nfndbkUusccCgNDSxS0w0h0Y9xn+4ns/DNqgB4CgbTAV0QVazqQbJ0hqXUag==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr23646057wma.120.1574582475149;
        Sun, 24 Nov 2019 00:01:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h124sm4509029wmf.30.2019.11.24.00.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 00:01:14 -0800 (PST)
Message-Id: <pull.472.v2.git.1574582473.gitgitgadget@gmail.com>
In-Reply-To: <pull.472.git.1574490521.gitgitgadget@gmail.com>
References: <pull.472.git.1574490521.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 08:01:12 +0000
Subject: [PATCH v2 0/1] submodule: Fix 'submodule status' when called from a subdirectory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Manish Goregaokar <manishsmail@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated to include a test and a more standard commit message.

Manish Goregaokar (1):
  submodule: fix 'submodule status' when called from a subdirectory

 builtin/submodule--helper.c |  3 ++-
 t/t7400-submodule-basic.sh  | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-472%2FManishearth%2Fsubdir-status-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-472/Manishearth/subdir-status-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/472

Range-diff vs v1:

 1:  2004f4aaa9 ! 1:  e4c932bd09 submodule: Fix 'submodule status' when called from a subdirectory
     @@ -1,18 +1,18 @@
      Author: Manish Goregaokar <manishsmail@gmail.com>
      
     -    submodule: Fix 'submodule status' when called from a subdirectory
     +    submodule: fix 'submodule status' when called from a subdirectory
      
     -    Previously, when calling `git submodule status` while in a
     -    subdirectory, it was incorrectly not detecting modified submodules and
     -    thus reporting that all of the submodules were unchanged.
     +    When calling `git submodule status` while in a subdirectory, we are
     +    incorrectly not detecting modified submodules and
     +    thus reporting that all of the submodules are unchanged.
      
     -    This was because the submodule helper was calling `diff-index` with the
     -    submodule path assuming the path was relative to the current prefix
     +    This is because the submodule helper is calling `diff-index` with the
     +    submodule path assuming the path is relative to the current prefix
          directory, however the submodule path used is actually relative to the root.
      
     -    This fixes the bug by setting the `prefix` to NULL when running
     -    `diff-index` from the helper, so that it correctly interprets the path
     -    as relative to the repository root.
     +    Always pass NULL as the `prefix` when running diff-files on the
     +    submodule, to make sure the submodule's path is interpreted as relative
     +    to the superproject's repository root.
      
          Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
      
     @@ -24,10 +24,38 @@
       
       	git_config(git_diff_basic_config, NULL);
      -	repo_init_revisions(the_repository, &rev, prefix);
     -+	/*
     -+	 * prefix is NULL since path is an absolute path
     -+	 */
     ++
      +	repo_init_revisions(the_repository, &rev, NULL);
       	rev.abbrev = 0;
       	diff_files_args.argc = setup_revisions(diff_files_args.argc,
       					       diff_files_args.argv,
     +
     + diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
     + --- a/t/t7400-submodule-basic.sh
     + +++ b/t/t7400-submodule-basic.sh
     +@@
     + 	test_line_count = 1 lines
     + '
     + 
     ++test_expect_success 'status from subdirectory should have the same SHA1' '
     ++	test_when_finished "rmdir addtest/subdir" &&
     ++	(
     ++		cd addtest &&
     ++		git status > /tmp/foo &&
     ++		git submodule status | awk "{print \$1}" >expected &&
     ++		mkdir subdir &&
     ++		cd subdir &&
     ++		git submodule status | awk "{print \$1}" >../actual &&
     ++		test_cmp ../expected ../actual &&
     ++		git -C ../submod checkout @^ &&
     ++		git submodule status | awk "{print \$1}" >../actual2 &&
     ++		cd .. &&
     ++		git submodule status | awk "{print \$1}" >expected2 &&
     ++		test_cmp actual2 expected2 &&
     ++		test_must_fail test_cmp actual actual2
     ++	)
     ++'
     ++
     + test_expect_success 'setup - fetch commit name from submodule' '
     + 	rev1=$(cd .subrepo && git rev-parse HEAD) &&
     + 	printf "rev1: %s\n" "$rev1" &&

-- 
gitgitgadget
