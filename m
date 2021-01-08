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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AD4C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 02:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0FE23603
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 02:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbhAHCbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 21:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbhAHCbg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 21:31:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C880C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 18:30:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q18so7544768wrn.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 18:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=PwtjR5FjoD6YczNu8tIdF+qyYvQNwu8WniGgQJ0zqyE=;
        b=SFz/cOn3GycWrOalFBSH/g4q9jwudiGyXGyYn/3aqvwjPk40gKoWnptv/KU3exne1X
         rlnks1OOKKp9IRdxAD47xoIXb6TPTL/zYiJLMba17VUouR7CxFUMJpF+gqR8cv4W7EEJ
         eInaqajMdpMi1CQqUnbjo8nSoMhGATSNPR+FS2H7cu9VqnCAlnDx37hv5dvce0yT1QkQ
         s8UWDoq4wXy51KvVPnvEL+jlbqZ/GoM5wBFcN26AWs2TfbkJOW9R1EHbCcGDZ6k9Xa6Z
         Ud+2KhaFk9gWjpOXMYXAX2Ckc0KzPV/wVUcyCC4LY9FxxQZ7yQUQ1uZMDwFDoeJ5Znt8
         ILOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=PwtjR5FjoD6YczNu8tIdF+qyYvQNwu8WniGgQJ0zqyE=;
        b=cR2Ij1JyO6qiR4Eqh1mJtXmtJuZBgLQNcx9W5Vs7b7HFnRolTVMd61fBAMaQhYwdVF
         gIBFaVlsgRFWnYM9iXa2uZpVuZeRgqH2hltS1QfjqRoKwf1NzeKTdHOseCqXXCrqbZ20
         BuoIVQSjBtzeqLQGWHml+OjnCGU+gyFoSoz33y0XKivSyd8ZVlT2nwH+IVpaC6CzAPm8
         hxA16BcFnk4xmZQSvqsvqUH4h7DZgm2ZSue38fHHAO6Y2NIeL0EGpzEPbhieM3CIPlOg
         RaFzGCCTxUFfJuQpPcIF+O4Zds7I0R2TSrj3sfYiTh+x/Ac/1YPoArT0t8mN+w6Ut84d
         BKbw==
X-Gm-Message-State: AOAM533d5/Qj2TWtGVXZKLJYUXMjuJn+I4VM2YP2Qj9dfgU3n3DKVN3T
        6HMCdHugVYkEga/ZqZlI/A7xEdaGhVQ=
X-Google-Smtp-Source: ABdhPJzaT55pBpM5Cyx6fEEYUgxs8BkuxeW23A99NZ4fQvYdzMBiOePNZmN1oCFcGdOtK4z7Xh9y7Q==
X-Received: by 2002:a5d:678d:: with SMTP id v13mr1285985wru.71.1610073048641;
        Thu, 07 Jan 2021 18:30:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 189sm10627048wma.22.2021.01.07.18.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 18:30:47 -0800 (PST)
Message-Id: <pull.834.v3.git.1610073047135.gitgitgadget@gmail.com>
In-Reply-To: <pull.834.v2.git.1609960783988.gitgitgadget@gmail.com>
References: <pull.834.v2.git.1609960783988.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 02:30:46 +0000
Subject: [PATCH v3] for-each-repo: do nothing on empty config
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

Add a simple test to ensure this works. Use 'git help --no-such-option'
as the potential subcommand to ensure that we will hit a failure if the
subcommand is ever run.

Reported-by: Andreas Bühmann <dev@uuml.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    for-each-repo: do nothing on empty config
    
    Thanks, Andreas, for drawing my attention to this bug.
    
    V3: update comment in test and use git help --no-such-option as the
    subcommand to fail.
    
    [1] https://github.com/gitgitgadget/git/issues/833

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-834%2Fderrickstolee%2Ffor-each-repo-empty-config-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-834/derrickstolee/for-each-repo-empty-config-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/834

Range-diff vs v2:

 1:  a1f1300bacb ! 1:  31350c7845c for-each-repo: do nothing on empty config
     @@ Commit message
          unregister' to remove the config option. (Note: 'git maintenance stop'
          would remove the config _and_ remove the cron schedule.)
      
     -    Add a simple test to ensure this works.
     +    Add a simple test to ensure this works. Use 'git help --no-such-option'
     +    as the potential subcommand to ensure that we will hit a failure if the
     +    subcommand is ever run.
      
          Reported-by: Andreas Bühmann <dev@uuml.de>
          Helped-by: Eric Sunshine <sunshine@sunshineco.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/for-each-repo.c ##
     @@ t/t0068-for-each-repo.sh: test_expect_success 'run based on configured value' '
       '
       
      +test_expect_success 'do nothing on empty config' '
     -+	# will fail if any subcommand is run
     -+	git for-each-repo --config=bogus.config -- false
     ++	# the whole thing would fail if for-each-ref iterated even
     ++	# once, because "git help --no-such-option" would fail
     ++	git for-each-repo --config=bogus.config -- help --no-such-option
      +'
      +
       test_done


 builtin/for-each-repo.c  | 7 +++++++
 t/t0068-for-each-repo.sh | 6 ++++++
 2 files changed, 13 insertions(+)

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
index 136b4ec8392..4675e852517 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -27,4 +27,10 @@ test_expect_success 'run based on configured value' '
 	grep again message
 '
 
+test_expect_success 'do nothing on empty config' '
+	# the whole thing would fail if for-each-ref iterated even
+	# once, because "git help --no-such-option" would fail
+	git for-each-repo --config=bogus.config -- help --no-such-option
+'
+
 test_done

base-commit: 4950b2a2b5c4731e4c9d5b803739a6979b23fed6
-- 
gitgitgadget
