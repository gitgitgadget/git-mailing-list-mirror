Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB922C433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D3520825
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 15:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsa/LG2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgH1PbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgH1PbX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 11:31:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D40C061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:31:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so1684266wro.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=wvgSXlfFLmZGKA63lMmn0f297NVEThzdjT+gdqSgXr8=;
        b=Dsa/LG2aznQ41doXxXtdHPpoo3fqz9l+dS67VNP0oKdQ+ulinw6o+sfA1oZ1XIrW+/
         NJ5QeqsgwGyHLx5gDBS4+Qz20tz6BmSvJg26F6E/HfPIkSk1YJJe8Iijif7Jfr0Uz4KY
         fE3S5mS+Tooo0cjfg4AmsMinYbaW+LYDcYpiXNBw5d+bM6o5/tOQL06NTDqiYJFHqgMc
         4qmJgl6mJoAGTvrxqdMJW5uSZLe3n7DWS/IKhI4EUP3mo6ePyxxzPqCypd2VpMq0Ejjh
         UNIPxr9yrqzMErnqIrJv1ZuHouf/L9VbP0VJL9/Mlu6ga0NMwfUROP5HNRnuTcSUzXF9
         v8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wvgSXlfFLmZGKA63lMmn0f297NVEThzdjT+gdqSgXr8=;
        b=s1CsXUGWz6F5flrsUK2QVx77/IBO55yNrGcUayVpc5/1vmjKetBjS1KYQ28uK4A6/A
         1yxZmH0MwBDMsQVU2rHR0qOvxyJtTG0Y8S+5FcvCToFX5U6jSUZ68sNPAAoMsXgicxUt
         RB6k7D/ofzqqgyTRC5KFVhDZRSyq1EyACt4MsbRy8iLTDz61VhEtExhJAV1Ao1ondiVf
         49SUGLPnsepuuizHExzzZt08tsDaaiM5Sf5mQ3O5OKeooRLsJLKg0cygrArgJSbWcE6R
         XZzY5U1rxCKbUX6pmUovN/t7az1rrSqLFF9WHMVZC1fxrfaHNQJ1i6scG8dFQtr+qYg6
         hsLQ==
X-Gm-Message-State: AOAM533IGztAQlktc/64AYp/yRQq6ikSwHRi3mGTWM/MOOwVGj2tAIh/
        Srxv9qL35/TLeZ5Q+Uf8G2MejGlnR+U=
X-Google-Smtp-Source: ABdhPJxGBh5lKnb8NFm3hje7UJxrU+IH/5eqF4HiqDTJzSHOUzhRs+eWVxTP8nBSMU973hNJ8U28qQ==
X-Received: by 2002:adf:ed05:: with SMTP id a5mr1454858wro.364.1598628680823;
        Fri, 28 Aug 2020 08:31:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8sm2712002wrl.7.2020.08.28.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:31:20 -0700 (PDT)
Message-Id: <pull.711.git.1598628679830.gitgitgadget@gmail.com>
From:   "Hugo Locurcio via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Aug 2020 15:31:19 +0000
Subject: [PATCH] bisect: swap command-line options in documentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hugo Locurcio <hugo.locurcio@hugo.pro>,
        Hugo Locurcio <hugo.locurcio@hugo.pro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hugo Locurcio <hugo.locurcio@hugo.pro>

The positional arguments are specified in this order: "bad" then "good".
To avoid confusion, the options above the positional arguments
are now specified in the same order. They can still be specified in any
order since they're options, not positional arguments.

Signed-off-by: Hugo Locurcio <hugo.locurcio@hugo.pro>
---
    rebase: swap command-line options in documentation
    
    I wasted an hour because I thought I'd have to specify "good" then "bad"
    since I followed the order of the options instead of the positional
    arguments. Let's make this harder to happen in the future :)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-711%2FCalinou%2Frebase-doc-swap-options-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-711/Calinou/rebase-doc-swap-options-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/711

 Documentation/git-bisect.txt | 2 +-
 builtin/bisect--helper.c     | 2 +-
 git-bisect.sh                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 0e993e4587..fbb39fbdf5 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 The command takes various subcommands, and different options depending
 on the subcommand:
 
- git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
+ git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
 		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index cdda279b23..7dcc1b5188 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -27,7 +27,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-check-and-set-terms <command> <good_term> <bad_term>"),
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
-	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
+	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	NULL
 };
diff --git a/git-bisect.sh b/git-bisect.sh
index c7580e51a0..3ec7558bdc 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -3,7 +3,7 @@
 USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
-git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
+git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
 		 [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
 	reset bisect state and start bisection.
 git bisect (bad|new) [<rev>]

base-commit: 20de7e7e4f4e9ae52e6cc7cfaa6469f186ddb0fa
-- 
gitgitgadget
