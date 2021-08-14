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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B3CC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 01:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E641B610C8
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 01:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhHNBK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 21:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhHNBK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 21:10:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55C8C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 18:09:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so6522093wma.0
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 18:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cxmnHytbrdJNJHHNmZbMeyMTFXhkn8FA72I2o/bNaBk=;
        b=LpuVzsBxKLxZLk6mzsgSXkUoG4IlgERroTHLnlSjjIB9jSiGpJQnLZ5WjM1LJcZxOu
         pqIBxu2nwHG23LcYr/24AKWmd0G14jb1G50gUdKb0rKfEERgAa4zLEpMqZkPj/0TqRTZ
         wGSc0CDGeAzMz8Xer5X0+r56H1IU8usOCH7nzl+VZHjN0yJq9x46jZ3tVH0ZS8r0KP0h
         YVRWxV3q/j57lzyLxsPgdWxekrtPBpco4bAOQntqyRDX74oVJjVa4IkMdf2La2F1Uk3y
         vWpGLT7PLWTYHSmsJOYboGQX4P3/RarkJ6eIYzGwkKpGpfrMG0yJ48wj/3AXA054gq/n
         0Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cxmnHytbrdJNJHHNmZbMeyMTFXhkn8FA72I2o/bNaBk=;
        b=hfE+c5objZ8Qjbb7B/O0TdhhpglmM4/vQFapJ5+2oCjpys2XQ2qKqwHYuYqI2rHysY
         mMUjYfP23ixqI2Ju15pqFbpJ6Dvbry6K4nLAw+hA+HugpVvA6YOeoYwl6ST3PZHNBO7F
         ycPgB1HNGgvgd3gXtsl3IhAYfkEvlU7eb4mhOViak869ZDr6YJ8uGAizU7PTncgb6yIl
         AylYLr1wbVwrRfcXI3FH9SWSWpV8eNdhcJcFXzq6075DMRvpbJ5QeiMMz+Oy3c+w/QK1
         tru09po8CzKP7j0SFeZNnXdzIJxpbGUA+x38rMAgsi/s6y2iKJzvoqFjLqzZkFxWW5Jp
         SDoA==
X-Gm-Message-State: AOAM532/i5LbHJJZhTitFpNWDRCSrry1kzXb0DgSBJP4T0jJ09IDKlW2
        vaJ+EI2nnRPnAlP1lLfOrl+EZi+l1KM=
X-Google-Smtp-Source: ABdhPJxL+588YnUy+ZyMnGCeLJptgNfDjy2SVUy94N+1hVj8F7EVTwAfaTC1Du/nu++ny3Vmg3hrIA==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr4974474wmi.174.1628903398349;
        Fri, 13 Aug 2021 18:09:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm2988238wrq.44.2021.08.13.18.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 18:09:57 -0700 (PDT)
Message-Id: <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
References: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Aug 2021 01:09:56 +0000
Subject: [PATCH v6] clone: set submodule.recurse=true if
 submodule.stickyRecursiveClone enabled
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Mahi Kolla <mkolla2@illinois.edu>,
        Mahi Kolla <mkolla2@illinois.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mahi Kolla <mkolla2@illinois.edu>

Based on current experience, when running git clone --recurse-submodules,
developers do not expect other commands such as pull or checkout to run
recursively into active submodules. However, setting submodule.recurse=true
at this step could make for a simpler workflow by eliminating the need for
the --recurse-submodules option in subsequent commands. To collect more
data on developers' preference in regards to making submodule.recurse=true
a default config value in the future, deploy this feature under the opt in
submodule.stickyRecursiveClone flag.

Signed-off-by: Mahi Kolla <mkolla2@illinois.edu>
---
    clone: set submodule.recurse=true if submodule.stickyRecursiveClone
    enabled
    
    Based on current experience, when running git clone
    --recurse-submodules, developers do not expect other commands such as
    pull or checkout to run recursively into active submodules. However,
    setting submodule.recurse=true at this step could make for a simpler
    workflow by eliminating the need for the --recurse-submodules option in
    subsequent commands. To collect more data on developers' behavior and
    preferences when making submodule.recurse=true a default, deploy this
    feature under the opt in submodule.stickyRecursiveClone flag.
    
    Signed-off-by: Mahi Kolla mkolla2@illinois.edu
    
    Since V1: Made this an opt in feature under a custom
    submodule.stickyRecursiveClone flag as opposed to feature.experimental.
    Updated tests to reflect this design change. Also updated commit
    message. Additionally, I will be contributing from my personal email
    going forward as opposed to my @google email.
    
    cc: Philippe Blain levraiphilippeblain@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1006%2F24mahik%2Fmaster-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1006/24mahik/master-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1006

Range-diff vs v5:

 1:  2c6ffe00736 ! 1:  e668fa403cf clone: set submodule.recurse=true if user enables feature.experimental flag
     @@
       ## Metadata ##
     -Author: Mahi Kolla <mahikolla@google.com>
     +Author: Mahi Kolla <mkolla2@illinois.edu>
      
       ## Commit message ##
     -    clone: set submodule.recurse=true if user enables feature.experimental flag
     +    clone: set submodule.recurse=true if submodule.stickyRecursiveClone enabled
      
     -    Currently, when running 'git clone --recurse-submodules', developers do not expect other commands such as 'pull' or 'checkout' to run recursively into active submodules. However, setting 'submodule.recurse' to true at this step could make for a simpler workflow by eliminating the '--recurse-submodules' option in subsequent commands. To collect more data on developers' preference in regards to making 'submodule.recurse=true' a default config value in the future, deploy this feature under the opt in feature.experimental flag.
     +    Based on current experience, when running git clone --recurse-submodules,
     +    developers do not expect other commands such as pull or checkout to run
     +    recursively into active submodules. However, setting submodule.recurse=true
     +    at this step could make for a simpler workflow by eliminating the need for
     +    the --recurse-submodules option in subsequent commands. To collect more
     +    data on developers' preference in regards to making submodule.recurse=true
     +    a default config value in the future, deploy this feature under the opt in
     +    submodule.stickyRecursiveClone flag.
      
     -    Since V1: Made this an opt in feature under the experimental flag. Updated tests to reflect this design change. Also updated commit message.
     -
     -    Signed-off-by: Mahi Kolla <mahikolla@google.com>
     +    Signed-off-by: Mahi Kolla <mkolla2@illinois.edu>
      
       ## builtin/clone.c ##
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	struct remote *remote;
       	int err = 0, complete_refs_before_fetch = 1;
       	int submodule_progress;
     -+	int experimental_flag;
     ++	int sticky_recursive_clone;
       
       	struct transport_ls_refs_options transport_ls_refs_options =
       		TRANSPORT_LS_REFS_OPTIONS_INIT;
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       					   strbuf_detach(&sb, NULL));
       		}
       
     -+		if(!git_config_get_bool("feature.experimental", &experimental_flag) &&
     -+		    experimental_flag) {
     ++		if (!git_config_get_bool("submodule.stickyRecursiveClone", &sticky_recursive_clone)
     ++		    && sticky_recursive_clone) {
      +		    string_list_append(&option_config, "submodule.recurse=true");
      +		}
      +
     @@ t/t5606-clone-options.sh: test_expect_success 'setup' '
       
       '
       
     -+test_expect_success 'feature.experimental flag manipulates submodule.recurse value' '
     ++test_expect_success 'submodule.stickyRecursiveClone flag manipulates submodule.recurse value' '
      +
     -+	test_config_global feature.experimental true &&
     ++	test_config_global submodule.stickyRecursiveClone true &&
      +	git clone --recurse-submodules parent clone_recurse_true &&
      +	test_cmp_config -C clone_recurse_true true submodule.recurse &&
      +
     -+	test_config_global feature.experimental false &&
     ++	test_config_global submodule.stickyRecursiveClone false &&
      +	git clone --recurse-submodules parent clone_recurse_false &&
      +	test_expect_code 1 git -C clone_recurse_false config --get submodule.recurse
      +


 builtin/clone.c          |  6 ++++++
 t/t5606-clone-options.sh | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c8..a08d9012243 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -986,6 +986,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
+	int sticky_recursive_clone;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1130,6 +1131,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					   strbuf_detach(&sb, NULL));
 		}
 
+		if (!git_config_get_bool("submodule.stickyRecursiveClone", &sticky_recursive_clone)
+		    && sticky_recursive_clone) {
+		    string_list_append(&option_config, "submodule.recurse=true");
+		}
+
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
 			die(_("clone --recursive is not compatible with "
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3a595c0f82c..d822153e4d2 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -16,6 +16,18 @@ test_expect_success 'setup' '
 
 '
 
+test_expect_success 'submodule.stickyRecursiveClone flag manipulates submodule.recurse value' '
+
+	test_config_global submodule.stickyRecursiveClone true &&
+	git clone --recurse-submodules parent clone_recurse_true &&
+	test_cmp_config -C clone_recurse_true true submodule.recurse &&
+
+	test_config_global submodule.stickyRecursiveClone false &&
+	git clone --recurse-submodules parent clone_recurse_false &&
+	test_expect_code 1 git -C clone_recurse_false config --get submodule.recurse
+
+'
+
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&

base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
-- 
gitgitgadget
