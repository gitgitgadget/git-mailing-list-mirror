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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB40C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 02:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E3160724
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 02:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhHLCqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 22:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbhHLCqd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 22:46:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3F6C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 19:46:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f12-20020a05600c4e8c00b002e6bdd6ffe2so86011wmq.5
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 19:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WfOEFzlIROuYtzDMfz2Y2ISzdO/WxUEjtSMByH81lR0=;
        b=lfhq9mcAFdfdAVCBHwZ6dHenUPI2p6d+2CASRwqXM/O9Q7b+AzRwGIEgV8Ii/lptMG
         +YER2eL8hGkeGqgJbaUtQJOXjMT6CDQynJ15ZLDN5ZQwb5+4Vp1ZKRA+x0skoPFCLuyv
         pAmUB74D9fW0pwI0oWbRtKU9u6gca4TjlCDy/qhTVFPJd1zMuV9dga0YFfM32AU30CCc
         jDSRDi/iS+6+WGrWnJyEIhwSS/Ueniw7iOCMu/5zLoYCzrQeIf6T4U5tHHOORvrvS+g3
         1RrFV19l/35Ne0IJeMIEaK4sgXvC33/3Y5HQHGie2PwPjjtlsMhIioZf3crt77YI5T/y
         Wt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WfOEFzlIROuYtzDMfz2Y2ISzdO/WxUEjtSMByH81lR0=;
        b=p2VBSZLgDwYpOTQx78kQs2iU4BE9MZVFecxZpzHDOEFvyZMGEe6EalL8fB8dSY/bzD
         OWHWehElEwkwE9hlVOeoeOlZ1vQsA5khNwM/gu2/GIggloA5Xwck+S4zso0PM/Xqral5
         p6JTuCCGHYfjx9fiFxi5FMRz/ETi/RCYGDhcs3KdiqdW8MNyUf1qwoOEScJCybG/3XYr
         3ooFi1v33yybaEXvYPhoYgTUJr/1BAUKSlgQj36u/zDqqBIhYDQJUNOUqYIvRCUH26Be
         VwdUGuJuizskQ1vEZ7RxtCb+weNMoiV33Ok0uWqnE9NwVss9q/kl01fk1lj4wAE0uBhu
         QEmw==
X-Gm-Message-State: AOAM532hXRksYw9cUG9CoIzcQHrBua2CjWHHlqZZc90Ni1qYNWJPxxYo
        c4FelP2KhqtMHu3zZrcdZpCzc/bn4hU=
X-Google-Smtp-Source: ABdhPJyiZhr9znaq1sYtZG5BAglLwQw7EW4vyiDJqmpY6h5+SOL3U9+YplBg5sZTZiRaO0NUNC4IlA==
X-Received: by 2002:a05:600c:21ce:: with SMTP id x14mr1454510wmj.187.1628736367633;
        Wed, 11 Aug 2021 19:46:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm1009882wmc.41.2021.08.11.19.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 19:46:07 -0700 (PDT)
Message-Id: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Aug 2021 02:46:06 +0000
Subject: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>,
        Mahi Kolla <mahikolla@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mahi Kolla <mahikolla@google.com>

Currently, when running 'git clone --recurse-submodules', developers do not expect other commands such as 'pull' or 'checkout' to run recursively into active submodules. However, setting 'submodule.recurse' to true at this step could make for a simpler workflow by eliminating the '--recurse-submodules' option in subsequent commands. To collect more data on developers' preference in regards to making 'submodule.recurse=true' a default config value in the future, deploy this feature under the opt in feature.experimental flag.

Since V1: Made this an opt in feature under the experimental flag. Updated tests to reflect this design change. Also updated commit message.

Signed-off-by: Mahi Kolla <mahikolla@google.com>
---
    clone: set submodule.recurse=true if feature.experimental flag enabled
    
    Based on current experience, when running git clone
    --recurse-submodules, developers do not expect other commands such as
    pull or checkout to run recursively into active submodules. However,
    setting submodule.recurse=true at this step could make for a simpler
    workflow by eliminating the need for the --recurse-submodules option in
    subsequent commands. To collect more data on developers' preference in
    regards to making submodule.recurse=true a default config value in the
    future, deploy this feature under the opt in feature.experimental flag.
    
    Since V1: Made this an opt in feature under the experimental flag.
    Updated tests to reflect this design change. Also updated commit
    message.
    
    Signed-off-by: Mahi Kolla mahikolla@google.com
    
    cc: Philippe Blain levraiphilippeblain@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1006%2F24mahik%2Fmaster-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1006/24mahik/master-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1006

Range-diff vs v4:

 1:  73937d48a53 ! 1:  2c6ffe00736 clone: update submodule.recurse in config when using --recurse-submodule
     @@ Metadata
      Author: Mahi Kolla <mahikolla@google.com>
      
       ## Commit message ##
     -    clone: update submodule.recurse in config when using --recurse-submodule
     +    clone: set submodule.recurse=true if user enables feature.experimental flag
      
     -    When running 'git clone --recurse-submodules', developers might expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules. Set 'submodule.recurse' to true when 'git clone' is run with '--recurse-submodules'.
     +    Currently, when running 'git clone --recurse-submodules', developers do not expect other commands such as 'pull' or 'checkout' to run recursively into active submodules. However, setting 'submodule.recurse' to true at this step could make for a simpler workflow by eliminating the '--recurse-submodules' option in subsequent commands. To collect more data on developers' preference in regards to making 'submodule.recurse=true' a default config value in the future, deploy this feature under the opt in feature.experimental flag.
      
     -    Since V1: Updated test and 'git clone' man page. Also updated commit message.
     +    Since V1: Made this an opt in feature under the experimental flag. Updated tests to reflect this design change. Also updated commit message.
      
          Signed-off-by: Mahi Kolla <mahikolla@google.com>
      
     - ## Documentation/git-clone.txt ##
     -@@ Documentation/git-clone.txt: branch of some repository for search indexing.
     - 	This option can be given multiple times for pathspecs consisting
     - 	of multiple entries.  The resulting clone has `submodule.active` set to
     - 	the provided pathspec, or "." (meaning all submodules) if no
     --	pathspec is provided.
     -+	pathspec is provided. In addition, `submodule.recurse` is set to true.
     - +
     - Submodules are initialized and cloned using their default settings. This is
     - equivalent to running
     -
       ## builtin/clone.c ##
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 	struct remote *remote;
     + 	int err = 0, complete_refs_before_fetch = 1;
     + 	int submodule_progress;
     ++	int experimental_flag;
     + 
     + 	struct transport_ls_refs_options transport_ls_refs_options =
     + 		TRANSPORT_LS_REFS_OPTIONS_INIT;
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       					   strbuf_detach(&sb, NULL));
       		}
       
     -+		string_list_append(&option_config, "submodule.recurse=true");
     ++		if(!git_config_get_bool("feature.experimental", &experimental_flag) &&
     ++		    experimental_flag) {
     ++		    string_list_append(&option_config, "submodule.recurse=true");
     ++		}
     ++
       		if (option_required_reference.nr &&
       		    option_optional_reference.nr)
       			die(_("clone --recursive is not compatible with "
     @@ t/t5606-clone-options.sh: test_expect_success 'setup' '
       
       '
       
     -+test_expect_success 'clone --recurse-submodules sets submodule.recurse=true' '
     ++test_expect_success 'feature.experimental flag manipulates submodule.recurse value' '
     ++
     ++	test_config_global feature.experimental true &&
     ++	git clone --recurse-submodules parent clone_recurse_true &&
     ++	test_cmp_config -C clone_recurse_true true submodule.recurse &&
      +
     -+	git clone --recurse-submodules parent clone-rec-submodule &&
     -+	test_cmp_config -C clone-rec-submodule true submodule.recurse
     ++	test_config_global feature.experimental false &&
     ++	git clone --recurse-submodules parent clone_recurse_false &&
     ++	test_expect_code 1 git -C clone_recurse_false config --get submodule.recurse
      +
      +'
      +


 builtin/clone.c          |  6 ++++++
 t/t5606-clone-options.sh | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c8..24f242b4a60 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -986,6 +986,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
+	int experimental_flag;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1130,6 +1131,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					   strbuf_detach(&sb, NULL));
 		}
 
+		if(!git_config_get_bool("feature.experimental", &experimental_flag) &&
+		    experimental_flag) {
+		    string_list_append(&option_config, "submodule.recurse=true");
+		}
+
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
 			die(_("clone --recursive is not compatible with "
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3a595c0f82c..f20cdfa6fca 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -16,6 +16,18 @@ test_expect_success 'setup' '
 
 '
 
+test_expect_success 'feature.experimental flag manipulates submodule.recurse value' '
+
+	test_config_global feature.experimental true &&
+	git clone --recurse-submodules parent clone_recurse_true &&
+	test_cmp_config -C clone_recurse_true true submodule.recurse &&
+
+	test_config_global feature.experimental false &&
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
