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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7B9C4320A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC60361038
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhHLIC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 04:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbhHLIC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 04:02:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46E8C061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:02:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h13so6999509wrp.1
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6u7SFoHXtLd9sU3lW4anVowGh4+lD3jqkL5FntJhF3k=;
        b=W4UdSYsTj1QplAdR6Q2GtGizMF9O8p3QG0Z9EkI7yU83Ax3ThynmN28JefQhf6JHA+
         lKFh0Lu3V0eaxIx1/hLtbSZargTjk6riJIxXLdvEPr55kNM7LVe6R+BS3vz7fSPn7O4n
         dUbudaHaDCteY2hvlajNtzMgqQXFgeKv4a9hbZd0TlgcX67aDPxsr2uwZobBudUA5+nY
         sBel/VWpYEYmPtdSR7Jt1fDJg/6xy+RRDZpSWRJcEQ3w8ATE85SpE0r/SHB13eHnf8bA
         82kJB1J09aikK8Bt8Y+2XIPHRbxzfyG2Pq3ivR/QbSt/2wgNLWZaq9dD/QeBPpl+sR0U
         xfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6u7SFoHXtLd9sU3lW4anVowGh4+lD3jqkL5FntJhF3k=;
        b=RRntEPMNkucgoKqWA++Mzwp5GMimoUOBJGrFssBtZI7NwdpSUFuJDqk4C7D/l4sCG0
         0mSJ36UCFl3oR31qVKBSUAWdX3GUtlkAr4kK1nVD4MFV936M/fes5//Ux/MnXk2LSA8/
         zpsDGN2QoVsrTrMkqUq4qTZ8mVNAFZYz4CLA2Ty/KGQr/XLSDe1fK1YYumK/Kg0RWWHC
         rSx0E63opCjjofa2UeO9HwD78BVEXI1adq9V6frb4YK9+Fdw3MorNa35+HyM7y2txM7G
         Dt0G3DkOx5FyAT8tSkSNrFOj6XZgLmGLxI8KGhnWtMajSJrmYR6OWrI9ozcTE5qQ+GDs
         f67A==
X-Gm-Message-State: AOAM530+fhVyRsKL1tJCXN5qn9T8ujAB6WmhTRqFlib+dpIABpSaB4Vx
        Gx9nywyIgQBBf53mXOdu7pdlrNxThAI=
X-Google-Smtp-Source: ABdhPJxKMrk9jQMWbjYaAYIF+nb/QEcEXTKDrDOXr0xTeg7W0NLvx4ppJawnSzGv5tfutanEaaX//Q==
X-Received: by 2002:adf:8287:: with SMTP id 7mr2519596wrc.360.1628755348269;
        Thu, 12 Aug 2021 01:02:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm767600wrx.87.2021.08.12.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 01:02:26 -0700 (PDT)
Message-Id: <pull.1014.v3.git.1628755346354.gitgitgadget@gmail.com>
In-Reply-To: <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
References: <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
From:   "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Aug 2021 08:02:26 +0000
Subject: [PATCH v3] commit: restore --edit when combined with --fixup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joel Klinghed <the_jk@spawned.biz>,
        Joel Klinghed <the_jk@spawned.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Klinghed <the_jk@spawned.biz>

Recent changes to --fixup, adding amend suboption, caused the
--edit flag to be ignored as use_editor was always set to zero.

Restore edit_flag having higher priority than fixup_message when
deciding the value of use_editor by only changing the default
if edit_flag is not set.

Signed-off-by: Joel Klinghed <the_jk@spawned.biz>
---
    commit: restore --edit when combined with --fixup
    
    Recent changes to --fixup, adding amend suboption, caused the --edit
    flag to be ignored as use_editor was always set to zero.
    
    Restore edit_flag having higher priority than fixup_message when
    deciding the value of use_editor by only changing the default if
    edit_flag is not set.
    
    Changes since v1: Added test verifying that --fixup --edit brings up
    editor.
    
    Changes since v2: Clarify if condition and use write_script helper in
    test.
    
    Signed-off-by: Joel Klinghed the_jk@spawned.biz

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1014%2Fthejk%2Ffixup_edit-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1014/thejk/fixup_edit-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1014

Range-diff vs v2:

 1:  0ee926d4149 ! 1:  6bc5d8bbe61 commit: restore --edit when combined with --fixup
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
       			fixup_commit = fixup_message;
       			fixup_prefix = "fixup";
      -			use_editor = 0;
     -+			if (0 > edit_flag)
     ++			if (edit_flag < 0)
      +				use_editor = 0;
       		}
       	}
     @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'commit --fixup -
       '
      +test_expect_success 'commit --fixup --edit' '
      +	commit_for_rebase_autosquash_setup &&
     -+	cat >e-append <<-\EOF &&
     -+	#!/bin/sh
     ++	write_script e-append <<-\EOF &&
      +	sed -e "2a\\
      +something\\
      +extra" <"$1" >"$1-"
      +	mv "$1-" "$1"
      +	EOF
     -+	chmod 755 e-append &&
      +	EDITOR="./e-append" git commit --fixup HEAD~1 --edit &&
      +	commit_msg_is "fixup! target message subject linesomething
      +extra"


 builtin/commit.c                          |  3 ++-
 t/t7500-commit-template-squash-signoff.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43b..560aecd21b1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1333,7 +1333,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		} else {
 			fixup_commit = fixup_message;
 			fixup_prefix = "fixup";
-			use_editor = 0;
+			if (edit_flag < 0)
+				use_editor = 0;
 		}
 	}
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 7d02f79c0de..a48fe859235 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -281,6 +281,19 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
 
 extra"
 '
+test_expect_success 'commit --fixup --edit' '
+	commit_for_rebase_autosquash_setup &&
+	write_script e-append <<-\EOF &&
+	sed -e "2a\\
+something\\
+extra" <"$1" >"$1-"
+	mv "$1-" "$1"
+	EOF
+	EDITOR="./e-append" git commit --fixup HEAD~1 --edit &&
+	commit_msg_is "fixup! target message subject linesomething
+extra"
+'
+
 get_commit_msg () {
 	rev="$1" &&
 	git log -1 --pretty=format:"%B" "$rev"

base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
-- 
gitgitgadget
