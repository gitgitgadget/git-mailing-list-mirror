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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C7C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2EE223123
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 19:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbhAFTU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 14:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbhAFTU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 14:20:27 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36FC061575
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 11:19:46 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c5so3410025wrp.6
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 11:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=tIvyCKSj2FwviZRwretd44apP3we67c+BOaPGZUlXfk=;
        b=JOHI/2UpMHLyk2mz2MlwZKjP26wPBf6qPOeWc8O/MONsO4oIWUFu2WHPgyF0uCHJEY
         MJWSSmes3Annl9V0P81dkun+R3NsN4uE8+LYQHEuTKn3XlXNshp8oiO/5bk/Qit7SzTT
         JPPCzWggs8wNVvFNC+fxiLRQdlw67XFrcXxCYA8hSnNb2B22BOo51Pt3aWRrMSuagxso
         AMK0jJt1cF9jCeH7mX5X7bQ97RL9jpEcLNHdmq2KPT8IWE2oIQCBGtH5Dr67gExK1I6p
         ntuf4IZ1MTfMrEMSs6DOWQeldLTqP+vlr0t42JWDJkhzGDg515SswVzKRVkv6P16Z4FA
         L8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=tIvyCKSj2FwviZRwretd44apP3we67c+BOaPGZUlXfk=;
        b=duB5Obzs8IOl7D5TA8+ICYlIjh5YsDemss1N94GBShhtlNvgIbljq5shfEmC7B4CUC
         bC6ImBUTxDBPRlufI76lTxcujI4zxCLiiGt3CJD3yOlworOZ8NNgCRj15m/SNESDTnvH
         qBhmsPbbCXqkmdzGScYZ1qQWgEprhgLyWqADlOdkW/Mu0zGJNW4p/X61v/01nPheMqbD
         9M3WYYBgAk4EAiVtDEt94BZDDOqzo+ySbB23hCn3lDLMNMCWAUvqHeeRMPNNU0zQb7w+
         NyogUjUHwbHG7Ok6i1yq+mbnKMP22h6hlm+bfp4BFStJvS3np1S6aIq1BBhBkFsXdsaB
         lHWA==
X-Gm-Message-State: AOAM530gi6AvuIEQG9yC41Vbibvo1O/KvSxbXu+g8NQuG7+A8s2yl+yT
        GiGeM04rd81JZkJilbinZQi+zxKBoSo=
X-Google-Smtp-Source: ABdhPJxSDZae2cfhGhskfjfnuKgJXjEz3en8z9/iDtlX2XKTrOICVlVsTerZnsYLcwKdCGkEfX53cw==
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr5542868wrr.184.1609960785096;
        Wed, 06 Jan 2021 11:19:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c190sm3959485wme.19.2021.01.06.11.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 11:19:44 -0800 (PST)
Message-Id: <pull.834.v2.git.1609960783988.gitgitgadget@gmail.com>
In-Reply-To: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 19:19:43 +0000
Subject: [PATCH v2] for-each-repo: do nothing on empty config
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

'git for-each-repo --config=X' should return success without calling any
subcommands when the config key 'X' has no value. The current
implementation instead segfaults.

A user could run into this issue if they used 'git maintenance start' to
initialize their cron schedule using 'git for-each-repo
--config=maintenance.repo ...' but then using 'git maintenance
unregister' to remove the config option. (Note: 'git maintenance stop'
would remove the config _and_ remove the cron schedule.)

Add a simple test to ensure this works.

Reported-by: Andreas Bühmann <dev@uuml.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    for-each-repo: do nothing on empty config
    
    Thanks, Andreas, for drawing my attention to this bug.
    
    [1] https://github.com/gitgitgadget/git/issues/833

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-834%2Fderrickstolee%2Ffor-each-repo-empty-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-834/derrickstolee/for-each-repo-empty-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/834

Range-diff vs v1:

 1:  36dccbb8c20 ! 1:  a1f1300bacb for-each-repo: do nothing on empty config
     @@ Commit message
          Add a simple test to ensure this works.
      
          Reported-by: Andreas Bühmann <dev@uuml.de>
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/for-each-repo.c ##
     @@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc, const char **argv, cons
       	values = repo_config_get_value_multi(the_repository,
       					     config_key);
       
     ++	/*
     ++	 * Do nothing on an empty list, which is equivalent to the case
     ++	 * where the config variable does not exist at all.
     ++	 */
      +	if (!values)
     -+		return result;
     ++		return 0;
      +
       	for (i = 0; !result && i < values->nr; i++)
       		result = run_command_on_repo(values->items[i].string, &args);
     @@ t/t0068-for-each-repo.sh: test_expect_success 'run based on configured value' '
       '
       
      +test_expect_success 'do nothing on empty config' '
     -+	git for-each-repo --config=bogus.config -- these args would fail
     ++	# will fail if any subcommand is run
     ++	git for-each-repo --config=bogus.config -- false
      +'
      +
       test_done


 builtin/for-each-repo.c  | 7 +++++++
 t/t0068-for-each-repo.sh | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 5bba623ff12..52be64a4373 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -51,6 +51,13 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	values = repo_config_get_value_multi(the_repository,
 					     config_key);
 
+	/*
+	 * Do nothing on an empty list, which is equivalent to the case
+	 * where the config variable does not exist at all.
+	 */
+	if (!values)
+		return 0;
+
 	for (i = 0; !result && i < values->nr; i++)
 		result = run_command_on_repo(values->items[i].string, &args);
 
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 136b4ec8392..c3efba4da0b 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -27,4 +27,9 @@ test_expect_success 'run based on configured value' '
 	grep again message
 '
 
+test_expect_success 'do nothing on empty config' '
+	# will fail if any subcommand is run
+	git for-each-repo --config=bogus.config -- false
+'
+
 test_done

base-commit: 4950b2a2b5c4731e4c9d5b803739a6979b23fed6
-- 
gitgitgadget
