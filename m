Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9046C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9374561131
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350958AbhIHT0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350769AbhIHT0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:26:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F1C06179A
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:24:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id e26so2562367wmk.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oKygtjLAStTyInzHGfikqfjJckUMFyUKn7JkaG2HLdo=;
        b=k/0ptA3hK2B4z9QCDDfQsP6iBNpfIph1pYfYjeKn3SqY43kWCgtJ/4Rq2XkGi52A1E
         5kzEDImoVo5Q/eHMlDKPfSNZNYzPTtQFzUjpxQs4Ek51wOus3OTP0yf/81R76Te54nG+
         ZPy47DAxQ2V1uCVa2Vr6OCWHT14+LqwuA1/lfH3VSnwDxA9AWA75aN+A8p2cOjGohcu+
         IODO+4DrxnrrCDtDgoSV5FoblK8K76qmDAl/R/6zqw+5A8d7KSyTbZVDPE3Y+Df/Vlq9
         3lqRy3AMu7HL6K9yXV/nHLG99RrqvEb43LqtIxTwYlTtc4dbjouteZuh+QiAPs22dRdJ
         ZTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oKygtjLAStTyInzHGfikqfjJckUMFyUKn7JkaG2HLdo=;
        b=UsEkoVIeCN1t+koTYa3dWluPOSDPAq6F1TlPxTJLIzzd5URiGkpvx++N+OlmZcDyvh
         vRHQxfdhrRRpoGOhtbyrpW8uU/OeQnhX5CfRrI4pjTmgrEA15eIiDKtKgRrx7F0MeEYM
         BaIzr0XI61Tv2gnFPFYqKBzyUBKxFn0Iz4NyEy3LPd3qDZ+KOpkdyuEmzGbbp5oQZ2Cw
         u7ml2c3HrzXWEi1HGfXBgPJfTMR3YI2GCnp0KV3QJ08kFfc+kRMpPnwCHLP5lFHuiHE6
         mSYIuDi8F7NdSfehOSr/KAdiEzbip02mpdAGm4YYjkilH/08Qe5hQm3P9XFqB0dHQEMP
         67GA==
X-Gm-Message-State: AOAM531FNnRvUSE52c2T/OMXCRUCbLujm7mCjHfBxZP/LOlyWBCB1wdu
        0JePjLPMTB6Pc3sD1fyq1+UBo2cfeeU=
X-Google-Smtp-Source: ABdhPJzAKsdSYF70+hi/cuOjBoEkz2+4Rh/LhwZ+Mt8kfqWEeJphdnqTz8luCFJt0Jqa8wNKa3UJTA==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr5117672wmb.5.1631129091401;
        Wed, 08 Sep 2021 12:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm2827848wmb.35.2021.09.08.12.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:24:51 -0700 (PDT)
Message-Id: <d291d3723a6bb8e1d4f871b5279063c3e0a3fd79.1631129086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 19:24:37 +0000
Subject: [PATCH v3 07/15] scalar: implement 'scalar list'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The produced list simply consists of those repositories registered under
the multi-valued `scalar.repo` config setting in the user's Git config.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 11 +++++++++++
 contrib/scalar/scalar.txt | 11 ++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index d114c038b64..7f5436399da 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -257,6 +257,16 @@ static int unregister_dir(void)
 	return res;
 }
 
+static int cmd_list(int argc, const char **argv)
+{
+	if (argc != 1)
+		die(_("`scalar list` does not take arguments"));
+
+	if (run_git("config", "--global", "--get-all", "scalar.repo", NULL) < 0)
+		return -1;
+	return 0;
+}
+
 static int cmd_register(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -343,6 +353,7 @@ static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
+	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
 	{ NULL, NULL},
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index d9a79984492..f93e3d00efd 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -8,6 +8,7 @@ scalar - an opinionated repository management tool
 SYNOPSIS
 --------
 [verse]
+scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 
@@ -28,11 +29,19 @@ an existing Git worktree with Scalar whose name is not `src`, the enlistment
 will be identical to the worktree.
 
 The `scalar` command implements various subcommands, and different options
-depending on the subcommand.
+depending on the subcommand. With the exception of `list`, all subcommands
+expect to be run in an enlistment.
 
 COMMANDS
 --------
 
+List
+~~~~
+
+list::
+	List enlistments that are currently registered by Scalar. This
+	subcommand does not need to be run inside an enlistment.
+
 Register
 ~~~~~~~~
 
-- 
gitgitgadget

