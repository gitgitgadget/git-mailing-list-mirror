Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BBDC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 19:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003DB61052
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 19:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhHITMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 15:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbhHITMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 15:12:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A1C0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 12:11:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so736212wmb.5
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5GGKoCqbL6VwW8rnWGWkhbmr1Oo7THOF9L0LtmPGy+I=;
        b=hnTiyDVzpM0rQJkOiNsna5ciYIeCX5LqLT9BWRo/2qobz+ytC/w2LIJJ13ETtD2ofR
         5ytDRcOdnRnny+5t+lv0ZvQ9969VBQA9xQmK7WkWVFmG7Y4akACkqtZZNl1S59JlD4zA
         NfXaoKaplUmp/vRgOCqYIxlutKhEUazVCH+JAbACzpT3JAdOsWc1ookGYIwM7O34G4xq
         mK+TrGOjpfps3BlAWGUFrWv57vhbQeEVwnlrI0QvUBH/WSO6X6MoHeuZLvNIf1hQGA3M
         Hwd56I6TC9BiWENBs7DzoW+cwD4mBuouD2agJ64amqoRMojtnFsKS4yXLdDXPJGvyXua
         C09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5GGKoCqbL6VwW8rnWGWkhbmr1Oo7THOF9L0LtmPGy+I=;
        b=ZrUr285ceS6CAIlQ1nRe9PQkhsJ4zXcauZOIGSkDnTz9s+pF4QJ8HFuT9z/Y3F1MXc
         wC/Bmj2bIzCLYa2W+nt7Ataye+pEezUrsymdkEd2SsGoQhAOz4m2t/XbUJ/bHYwhWdqS
         zkBzz2EKy3Imjj0R+Lh+rXLDHeJn81zWrDiMwUjHvutJJ9+TbFneifAb38GFZ7e/Ke6m
         Vb5pgkbyxg/TMkVzBtVR2AimdYhD2m2BzBvG8iSdKMOB/AlWM46crcP0VXSTAG3YRLQo
         AQ0tOJVovp8GEuU7Oc5gWhpi+Tu+CVAC8Syoeq9VOcaPxbhnTLuQDkuO5SvLpKzz8ykD
         e9EA==
X-Gm-Message-State: AOAM532NjFmixX3spGO2zokAj4XMInklVgwdUTGDApdM8zeKWHyNBrDh
        XyZBK3o2bzRXh1AwevpyGlfqFNHxKb8=
X-Google-Smtp-Source: ABdhPJwQMEbFDtcAjgaewZJJjnmGDasP6ndlRADXcWFaFHXGLQHlCxg7GzLOQw+7gTd7FPQkyH6KrA==
X-Received: by 2002:a05:600c:1c13:: with SMTP id j19mr18326462wms.164.1628536306975;
        Mon, 09 Aug 2021 12:11:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11sm398749wmc.23.2021.08.09.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:11:46 -0700 (PDT)
Message-Id: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
In-Reply-To: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
References: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
From:   "Mahi Kolla via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Aug 2021 19:11:45 +0000
Subject: [PATCH v4] clone: update submodule.recurse in config when using
 --recurse-submodule
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

When running 'git clone --recurse-submodules', developers might expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules. Set 'submodule.recurse' to true when 'git clone' is run with '--recurse-submodules'.

Since V1: Updated test and 'git clone' man page. Also updated commit message.

Signed-off-by: Mahi Kolla <mahikolla@google.com>
---
    clone: update submodule.recurse in config when using --recurse-submodule
    
    When running 'git clone --recurse-submodules', developers might expect
    various other commands such as 'pull' and 'checkout' to also run
    recursively into submodules. Set 'submodule.recurse' to true when 'git
    clone' is run with '--recurse-submodules'.
    
    Since V1: Updated test and 'git clone' man page. Also updated commit
    message.
    
    Signed-off-by: Mahi Kolla mahikolla@google.com
    
    cc: Philippe Blain levraiphilippeblain@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1006%2F24mahik%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1006/24mahik/master-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1006

Range-diff vs v3:

 1:  fea3d6d72b6 ! 1:  73937d48a53 clone: update submodule.recurse in config when using --recurse-submodule
     @@ Metadata
       ## Commit message ##
          clone: update submodule.recurse in config when using --recurse-submodule
      
     -    When running 'git clone --recurse-submodules', developers expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules.The submitted code updates the 'submodule.recurse' config value to true when 'git clone' is run with the '--recurse-submodules' option.
     +    When running 'git clone --recurse-submodules', developers might expect various other commands such as 'pull' and 'checkout' to also run recursively into submodules. Set 'submodule.recurse' to true when 'git clone' is run with '--recurse-submodules'.
     +
     +    Since V1: Updated test and 'git clone' man page. Also updated commit message.
      
          Signed-off-by: Mahi Kolla <mahikolla@google.com>
      
     + ## Documentation/git-clone.txt ##
     +@@ Documentation/git-clone.txt: branch of some repository for search indexing.
     + 	This option can be given multiple times for pathspecs consisting
     + 	of multiple entries.  The resulting clone has `submodule.active` set to
     + 	the provided pathspec, or "." (meaning all submodules) if no
     +-	pathspec is provided.
     ++	pathspec is provided. In addition, `submodule.recurse` is set to true.
     + +
     + Submodules are initialized and cloned using their default settings. This is
     + equivalent to running
     +
       ## builtin/clone.c ##
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       					   strbuf_detach(&sb, NULL));
       		}
       
     -+                string_list_append(&option_config, "submodule.recurse=true");
     ++		string_list_append(&option_config, "submodule.recurse=true");
       		if (option_required_reference.nr &&
       		    option_optional_reference.nr)
       			die(_("clone --recursive is not compatible with "
     @@ t/t5606-clone-options.sh: test_expect_success 'setup' '
       
      +test_expect_success 'clone --recurse-submodules sets submodule.recurse=true' '
      +
     -+        git clone --recurse-submodules parent clone-rec-submodule &&
     -+        test_config_global submodule.recurse true 
     ++	git clone --recurse-submodules parent clone-rec-submodule &&
     ++	test_cmp_config -C clone-rec-submodule true submodule.recurse
      +
      +'
      +
 2:  dd13a65ef0f < -:  ----------- clone: update submodule.recurse in config when using --recurse-submodule
 3:  020eaa2c819 < -:  ----------- clone test: update whitespace according to style guide
 4:  f3ddb344b49 < -:  ----------- clone: update whitespace according to style guide


 Documentation/git-clone.txt | 2 +-
 builtin/clone.c             | 1 +
 t/t5606-clone-options.sh    | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 3fe3810f1ce..1d6aeb9e367 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -276,7 +276,7 @@ branch of some repository for search indexing.
 	This option can be given multiple times for pathspecs consisting
 	of multiple entries.  The resulting clone has `submodule.active` set to
 	the provided pathspec, or "." (meaning all submodules) if no
-	pathspec is provided.
+	pathspec is provided. In addition, `submodule.recurse` is set to true.
 +
 Submodules are initialized and cloned using their default settings. This is
 equivalent to running
diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c8..c6bb38d2fde 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1130,6 +1130,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					   strbuf_detach(&sb, NULL));
 		}
 
+		string_list_append(&option_config, "submodule.recurse=true");
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
 			die(_("clone --recursive is not compatible with "
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3a595c0f82c..055b74069b3 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -16,6 +16,13 @@ test_expect_success 'setup' '
 
 '
 
+test_expect_success 'clone --recurse-submodules sets submodule.recurse=true' '
+
+	git clone --recurse-submodules parent clone-rec-submodule &&
+	test_cmp_config -C clone-rec-submodule true submodule.recurse
+
+'
+
 test_expect_success 'clone -o' '
 
 	git clone -o foo parent clone-o &&

base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
-- 
gitgitgadget
