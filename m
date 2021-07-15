Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07C5C47E48
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9346C61396
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 02:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhGOCnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 22:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhGOCnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 22:43:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F2CC061762
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f17so5655667wrt.6
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 19:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fjqjbHaovHy3/vGHLL5OMWi8ZWpUM+5EZGbRH1StEtE=;
        b=AioK5e6InOXm5yGG7R/MlS8EdqvrPK9FpBm5Dj++gnJNccEn25vhDAk9XkJ4CMDL5a
         8d1N+8S8izIbR61s6/EvCD99nx093u0lD1S9NnV2xqWlDAuQtMh8miAHBgudzOY/700r
         bjcbvy0n1RLfCmPG1BEUO/ZwMnj2NCAQSqqRm6kv3Cc1aTqkDuR4D/itR/2IzY33IZjR
         TpPcIEo9rRf20SlLJ4YCXuDGBfdhFgYmlEpgXnF8U8w8PVLqZphJ+zy144NmCAjivuA2
         qdZ7429XHXEmp4mmCSW7P71bZNNDggY+0qpf9Je1FaY3CyGGWttF0BMU56AhrNSEQdtz
         a1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fjqjbHaovHy3/vGHLL5OMWi8ZWpUM+5EZGbRH1StEtE=;
        b=ECusBN1vGOI3h39RT5LMYNiHCd0wrs7ipdTZQax5af7JpA2GGqrRSY7aMX+yuOX78B
         Nv5yN5/2tPO2zDUwnfirNNEjUInq4Uy7iN6hQp3WkWJQOaPTlbI4d/PxG78Q2mijnSix
         9i85JdW4FG0AZQoZsfS0vp4JHorRVykaWqhEuRrSjU6rMJ8SKEgUwA1ajtGdxhO6+ZuI
         PMG6D8iWCb9yjW0leWvZCIX7iYjeS5+6PROQ7hqbhb08a8VCsiAMx8Wwsr+hLuWG9nNg
         yrN3nG1vBa4lno2Id0HTknehqLSr60WdNczLfqkxH+2BYZQuYibDhOHYNn9q1WdU6+LZ
         iH6g==
X-Gm-Message-State: AOAM533Q5f5Ub7JwOVmK62MoijKlpprKmhmA5I5VeXUHvuEm2JD7PgU7
        9imYqwuLtJfPqyZ3pMG04f+XTYrfL3c=
X-Google-Smtp-Source: ABdhPJxmtIw6xf78AfUPiDgQE+lbmk2g5UIZT5/zsIfG/W4iu88Kqn/CIES+e1ns71+mNyec98uqHQ==
X-Received: by 2002:a5d:4402:: with SMTP id z2mr1769069wrq.44.1626316852159;
        Wed, 14 Jul 2021 19:40:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm4598593wrx.21.2021.07.14.19.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 19:40:51 -0700 (PDT)
Message-Id: <2fc7344863103dc8f94499e60a16d0a8b47bda22.1626316849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 02:40:46 +0000
Subject: [PATCH 2/5] pull: convert OPT_PASSTHRU for fast-forward options to
 OPT_CALLBACK
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This results in no functional changes, but allows us to add logic to
the callback in a subsequent commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/pull.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 61c68e4143f..d99719403d0 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -112,6 +112,16 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
 	return *value == REBASE_INVALID ? -1 : 0;
 }
 
+static int parse_opt_ff(const struct option *opt, const char *arg, int unset)
+{
+	if (unset)
+		opt_ff = "--no-ff";
+	else
+		opt_ff = xstrfmt("--%s", opt->long_name);
+
+	return 0;
+}
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -154,12 +164,14 @@ static struct option pull_options[] = {
 		N_("edit message before committing"),
 		PARSE_OPT_NOARG),
 	OPT_CLEANUP(&cleanup_arg),
-	OPT_PASSTHRU(0, "ff", &opt_ff, NULL,
-		N_("allow fast-forward"),
-		PARSE_OPT_NOARG),
-	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
-		N_("abort if fast-forward is not possible"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_CALLBACK_F(0, "ff", &opt_ff, NULL,
+			N_("allow fast-forward"),
+			PARSE_OPT_NOARG,
+			parse_opt_ff),
+	OPT_CALLBACK_F(0, "ff-only", &opt_ff, NULL,
+			N_("abort if fast-forward is not possible"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			parse_opt_ff),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
-- 
gitgitgadget

