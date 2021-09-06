Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A22C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3C760F92
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbhIFHGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbhIFHGa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:06:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3B7C0613CF
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:05:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m9so8255381wrb.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UfhI+MD4SQEg+/6VZJpd76yUTzMXwr340ZO6HPZWdlQ=;
        b=l9qt379wk+2AHVzs4aVkqT4/44PDjttS289Zl7l2wq/9xrOu8KGkr6Ef6ylogqtg30
         tNL7NY0dWtVeFRux9T9i78LytBnuNprXwXCa0SqJ/egwoz3pnt9b7nYZJmOWFsSWpRNX
         jFKfXq1U5QQwMI6mfZ849KA2lDa4zCnxCEhPotn0Dfgd4EuMplo7aSd63IDG1tQ9ZQMt
         U/Lx65R8QTKv6eazyCNZIchEtWHHik5zsXCQhnhbjDInGgqmqj9bpdbvLA6MVChS+WT2
         gc3Qi8WErI9m8wrVpWu+/6grFYZg+V4iT8z4dbuNYiZovqLlyZO9vGNR8rT194DL+5e/
         JR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfhI+MD4SQEg+/6VZJpd76yUTzMXwr340ZO6HPZWdlQ=;
        b=pFJlQyWBO5tRxk8ZsqCCzUfi5Fygbbd631fb5UXTlH5FLIRhvPOHLbWSFKHmbMKXcs
         ab0Xj/kUEp5qu55lczYF2ZkL4fPJ7feU7I0PyDrsTpKkQ3xYNCzSsEy0NeI1p922HsY1
         NEEz7uD6T/nJEsgHYtbGFmMdO7b8efoGIcUrcpGym0XOawvOQnzhejY0bBcjACchSEI3
         UB/7cMoKQtrB+MD5diGxPyKRZUe5ppwVRK/0ry+UqDDrR8+3RjVPehyFI3TaxAWUcNLg
         LUgwM8rEzb7KfCYaiYa6my7CCkocfjogD6+im3J3aFT0s0jH/B139heIRztxETq1jSVP
         qNVw==
X-Gm-Message-State: AOAM533cnE68A6zlxLwkmbixvh2BEY8H3AGKHcbfvolL8eURRmfSJ3AU
        bK4flfLy73CXdkV7BPlGYWpeEa0e31agTw==
X-Google-Smtp-Source: ABdhPJwZTRUoa0OL35moYWBf65RDecr/WXzdnCAu55080ZbsMsXO/Bp/mUwm5GqcpYBI1um4rTkjXg==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr11782503wrq.213.1630911924245;
        Mon, 06 Sep 2021 00:05:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm8076684wrt.63.2021.09.06.00.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:05:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/7] git-sh-setup: clear_local_git_env() function to git-submodule.sh
Date:   Mon,  6 Sep 2021 09:05:15 +0200
Message-Id: <patch-v2-4.7-46c018aa860-20210906T070201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
In-Reply-To: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 14111fc4927 (git: submodule honor -c credential.* from command
line, 2016-02-29) the clear_local_git_env() function has only been
used in the sanitize_submodule_env() function, let's inline its
one-line functionality there.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh  | 7 -------
 git-submodule.sh | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 3fc8830cb36..b3a97d6455a 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -290,13 +290,6 @@ get_author_ident_from_commit () {
 	parse_ident_from_commit author AUTHOR
 }
 
-# Clear repo-local GIT_* environment variables. Useful when switching to
-# another repository (e.g. when entering a submodule). See also the env
-# list in git_connect()
-clear_local_git_env() {
-	unset $(git rev-parse --local-env-vars)
-}
-
 # Generate a virtual base file for a two-file merge. Uses git apply to
 # remove lines from $1 that are not in $2, leaving only common lines.
 create_virtual_base() {
diff --git a/git-submodule.sh b/git-submodule.sh
index aeb96c58243..c9dca58fdaa 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -69,7 +69,7 @@ isnumber()
 sanitize_submodule_env()
 {
 	save_config=$GIT_CONFIG_PARAMETERS
-	clear_local_git_env
+	unset $(git rev-parse --local-env-vars)
 	GIT_CONFIG_PARAMETERS=$save_config
 	export GIT_CONFIG_PARAMETERS
 }
-- 
2.33.0.821.gfd4106eadbd

