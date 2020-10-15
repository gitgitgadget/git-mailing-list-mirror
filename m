Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04525C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 21:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B45D2076A
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 21:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pey6guL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgJOV7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 17:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgJOV7X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 17:59:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C11C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 14:59:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e18so306145wrw.9
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YPOFjOFpzvDc2rnSuf0/QFTMa1PctbJiNumbYn8x0PY=;
        b=pey6guL3+19xPDyAtCaIC1tXfy1YptufzA3zcXteR9n2E46SZfs6LlQvEA77RCteC6
         9aKN1lQhMSJktJ1RlYwOi0wm2amxh1c6ouBNpws9CLM/8nFlnOnfhSV8RUXMUSGXkN0d
         zyHzFZChfW0ZUDxiW1zv2XWtlDXuQW2qR9K2U1VF0OZASEcqNTazXELUI1EKoSnIZafn
         XOZrpm3y7JMix0g9U8XyKZHQcEk8UVkK8Jv/XNZEuT35LWlzl+Z7Y2nRDJy1TsdeMWEI
         LkMYspkbSY5eKk7ICOvAZ/0IWhKwdR7V2ORW+YIMd0G6sJ93zCLQNqwxLs62nMjMTZaM
         OmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YPOFjOFpzvDc2rnSuf0/QFTMa1PctbJiNumbYn8x0PY=;
        b=Krc2FjZo9M9ehA/u1KvpDuXfR7GS5312afA0mSmZD87hCnFyQIRtrIC9bD+vP7C7Xb
         o7Aee8SlOntYEZy3+LwQhtLBeDm+gS9vvoFfsYFBqSk/2CRuePWkaJ8vOJM3Ik/lrZSo
         6ki5ePW6FdgIyjIcEo/peLUT2vAGzJ7Noa1N9aG7EsoPoL1p+H82dylhurC2RIqBbzH9
         lY/Dgg3xXBahTNvmYPr3RntjxD1jT/H+UxGT+9qzSfjywCpB4gOpigbFP8OFtCt/LzAQ
         49sYtiVAvy4HRm8fn7+d2ga/x/HTvtp99KpFMqnW9MKwggjuQ2n5uLPZKtCKRNkEQLRV
         hfjQ==
X-Gm-Message-State: AOAM530ZWeVV5PUL9cLNeS7Pf7x1qNdPE/70i5Ehrn96xMwtI9gIdrqr
        Du6DatcEQwGTK9kLUcgI+hfnENZZY7k=
X-Google-Smtp-Source: ABdhPJw32c7yVk0/6HJJPiKJghN1LbXJJXgrWwzDHbKvFy0U4I8zCqDsrvkVKLqjME+ErEonANaocw==
X-Received: by 2002:adf:e589:: with SMTP id l9mr365702wrm.110.1602799161486;
        Thu, 15 Oct 2020 14:59:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h206sm440131wmf.47.2020.10.15.14.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 14:59:21 -0700 (PDT)
Message-Id: <pull.881.git.git.1602799160623.gitgitgadget@gmail.com>
From:   "Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 21:59:20 +0000
Subject: [PATCH] credential: load default config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Koutcher <thomas.koutcher@online.fr>,
        Thomas Koutcher <thomas.koutcher@online.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Koutcher <thomas.koutcher@online.fr>

Make `git credential fill` honour the core.askPass variable.

Signed-off-by: Thomas Koutcher <thomas.koutcher@online.fr>
---
    credential: load default config
    
    Make git credential fill honour the core.askPass variable.
    
    Signed-off-by: Thomas Koutcher thomas.koutcher@online.fr
    [thomas.koutcher@online.fr]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-881%2Fkoutcher%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-881/koutcher/maint-v1
Pull-Request: https://github.com/git/git/pull/881

 builtin/credential.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/credential.c b/builtin/credential.c
index 879acfbcda..d75dcdc64a 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "credential.h"
 #include "builtin.h"
+#include "config.h"
 
 static const char usage_msg[] =
 	"git credential [fill|approve|reject]";
@@ -10,6 +11,8 @@ int cmd_credential(int argc, const char **argv, const char *prefix)
 	const char *op;
 	struct credential c = CREDENTIAL_INIT;
 
+	git_config(git_default_config, NULL);
+
 	if (argc != 2 || !strcmp(argv[1], "-h"))
 		usage(usage_msg);
 	op = argv[1];

base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
-- 
gitgitgadget
