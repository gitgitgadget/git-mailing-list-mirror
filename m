Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF07C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243829AbiD0RKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243817AbiD0RK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:10:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F67321B1
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:07:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z99so2694141ede.5
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HoMeCLHSoY8bzvsz1SzKmQRGNJzKXNC79Vn7FBLHMF4=;
        b=ocAEUC1hr0jMIkr1Nnya4WY5DMM4MxzsjfCTyFJMvKRhY1zF+0f88BDcPjCDWbCCco
         B/MAx9ItR8FR/+MYH7o8SFU3TpfNyM40ETM8XTBFsGw9RG+d0E7+Mmm3wWamqb8tq+iw
         q+MEex7OeL8perqQQLRg7N5cwWkTQvffY4w+3QgYyGx0x7uhGBygOtvxXoyr3EBGMZy1
         hASLxyYLUNgetN8w2RAuMSOBzr7Ik9IkQFYh4WbPlc+JmAHIZ8+rIMbUL9uRPvBgWBqs
         wZVMM3sEQc0CD2wBEYLwBjlypkHqJb7NGo6I8j3+TVHrLWhqc1LDE9awH+8TarjtKNvn
         sLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HoMeCLHSoY8bzvsz1SzKmQRGNJzKXNC79Vn7FBLHMF4=;
        b=U1SOPRjvODDGzoOgtdIPETeUq4BXnXpefUBvFcaoUu/sbsal0FzyrI+GDmQndaig8D
         uXCUIFHW7vbc0dMjVkNzSoKb35dvfchdSMj/Ys6KLJmumi513c8x2sRHAnsRuhZIFVt/
         B6apz0AA1JX8ZfYhpe9NojjodHI0EBEW/F4kOvgzMI7++Wy6KsOPWg1NDtT5sVxInhWd
         U2Yq/dHcEiOVIYeoL/O2EIhsahsmxd3o2hWtcSEkp4rcCWFuDbLtcIzz+fx2cAffqNQF
         CSLmGCRJGHwDWiSy09MxYpBkc8KdXM04WqWW0+LsAmu3M9loK0wK5NsdvZZw2KHuDyIy
         Fylg==
X-Gm-Message-State: AOAM533TBXX0OI3Nr7oDV/c7UWy3n1gzaTR6PvP+l49o0TfWXJob0eVG
        IL1i+7hIScbmxi1HbCRq9e3POwEu3U4P+A==
X-Google-Smtp-Source: ABdhPJysKdLkJC0Fvp45D73M3O6eAJj6VrW6TFBPXF23cMOX8cXJ+UhyYzgDFwDiAq8Kky+cfkxv0w==
X-Received: by 2002:aa7:c6c3:0:b0:425:b13b:94f with SMTP id b3-20020aa7c6c3000000b00425b13b094fmr31271402eds.313.1651079234581;
        Wed, 27 Apr 2022 10:07:14 -0700 (PDT)
Received: from buzz.local (62-165-236-195.pool.digikabel.hu. [62.165.236.195])
        by smtp.gmail.com with ESMTPSA id jl5-20020a17090775c500b006f3b76a87ffsm2748849ejc.51.2022.04.27.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:07:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] safe.directory: document and check that it's ignored in the environment
Date:   Wed, 27 Apr 2022 19:06:49 +0200
Message-Id: <20220427170649.4949-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.36.0.676.gf39b21ed98
In-Reply-To: <20220427170649.4949-1-szeder.dev@gmail.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of 'safe.directory' mentions that it's respected in
the system and global configs, and ignored in the repository config
and on the command line, but it doesn't mention whether it's respected
or ignored when specified via environment variables (nor does the
commit message adding 'safe.directory' [1]).

Clarify that 'safe.directory' is ignored when specified in the
environment, and add tests to make sure that it remains so.

[1] 8959555cee (setup_git_directory(): add an owner check for the
                top-level directory, 2022-03-02)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config/safe.txt |  4 ++--
 t/t0033-safe-directory.sh     | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 6d764fe0cc..ae0e2e3bdb 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -13,8 +13,8 @@ override any such directories specified in the system config), add a
 `safe.directory` entry with an empty value.
 +
 This config setting is only respected when specified in a system or global
-config, not when it is specified in a repository config or via the command
-line option `-c safe.directory=<path>`.
+config, not when it is specified in a repository config, via the command
+line option `-c safe.directory=<path>`, or in environment variables.
 +
 The value of this setting is interpolated, i.e. `~/<path>` expands to a
 path relative to the home directory and `%(prefix)/<path>` expands to a
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 82dac0eb93..238b25f91a 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -21,6 +21,21 @@ test_expect_success 'ignoring safe.directory on the command line' '
 	grep "unsafe repository" err
 '
 
+test_expect_success 'ignoring safe.directory in the environment' '
+	test_must_fail env GIT_CONFIG_COUNT=1 \
+		GIT_CONFIG_KEY_0="safe.directory" \
+		GIT_CONFIG_VALUE_0="$(pwd)" \
+		git status 2>err &&
+	grep "unsafe repository" err
+'
+
+test_expect_success 'ignoring safe.directory in GIT_CONFIG_PARAMETERS' '
+	test_must_fail env \
+		GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
+		git status 2>err &&
+	grep "unsafe repository" err
+'
+
 test_expect_success 'ignoring safe.directory in repo config' '
 	(
 		unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
-- 
2.36.0.676.gf39b21ed98

