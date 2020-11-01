Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4081DC55178
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E997222268
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycd5HXZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgKAR24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKAR2z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:28:55 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CEFC0617A6
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 09:28:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so11936123wrm.4
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 09:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=djn1VAWcD1Br4UvqOydWf0SGdcel8IzKRyZ/nnATuVw=;
        b=Ycd5HXZVb/nzHCBQwI2QFNXr1Ta1zuEb/Ald7zqca+medVgEDE2+iX72KRinhslkRy
         pmZE88fuCY3OfnTBKS2LP4g/MEA3PTtxNyCuxiecX6lAFhxFJiiSwiZYrU8d9wk/3Q6w
         cMKLye1S9lHVO7L+KrAZ2ZrhhZiHOsMw9dduSuyNrSpaohB/ejEKP5AG+CkSsY7+jbsh
         hel7SN0tJFMe5s4y5iwRPk53jVMumcVTx83cIN+R09VUhZoe1qNCAOO+ZkPJb7DxwvuV
         N8iH6FruuJ2/49klwXnf4EWKualC7Soam20juG++lNTlT++9mOgtQtrKuE/rRbZqLxgN
         IMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=djn1VAWcD1Br4UvqOydWf0SGdcel8IzKRyZ/nnATuVw=;
        b=kvwCNNJ4uOrS6nAGUGtkwKjzLTAIRX4gmBgwk0MboQwkv1vIaTebM2zf6DMgP+CxaI
         rlf8W7V6VNdaXRtbiO/6Q4ac8ZsQKazXILuXtL4b301J/UtIb3ff3bHxQIKlO8Gb/LIS
         YxN47BFn0r/7D+pvJ9D9ypPzbvETh27t8n8KHNnEEpTdo25aTxPtAunpdyWiJezzcVmP
         C+Sq0rp+DFrFWUju7uwSSVbkVbQDkDOfsylrm+UEpBnmn2dNKOMdPsUHxFZN+jKudnGD
         JsxEA2SgJpB5sxmZgrhEwFhCkG39CDkYZ0i1k9vkkV5mDFXbJdFtP33/Kjez2CKWSr/0
         cvfw==
X-Gm-Message-State: AOAM530qLRVKN6HIND9ENmSLxbEAODdL1DcMI6XNV5nvGHE9n2/uk9lw
        MjF+MJXU1we/Hn/dCQysau+U9acp67w=
X-Google-Smtp-Source: ABdhPJwrx1k/vGtpBID1+Tpug0fs0Zs63sP9Z5Fm0hoYOEs0gzm+r2BzIneDxksghpGzIyMc9Mj6gg==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr16444635wru.71.1604251733222;
        Sun, 01 Nov 2020 09:28:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s133sm5684863wmf.30.2020.11.01.09.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:28:52 -0800 (PST)
Message-Id: <ae61d27a3869aefa5eb568b0d9e1e462aceacc93.1604251728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 17:28:44 +0000
Subject: [PATCH v2 5/8] line-log: mention both modes in 'blame' and 'log'
 short help
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

'git blame -h' and 'git log -h' both show '-L <n,m>' and describe this
option as "Process only line range n,m, counting from 1". No hint is
given that a function name regex can also be used.

Use <range> instead, and expand the description of the option to mention
both modes. Remove "counting from 1" as it's uneeded; it's uncommon to
refer to the first line of a file as "line 0".

Also, for 'git log', improve the wording to better reflect the long help.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/blame.c | 3 ++-
 builtin/log.c   | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index bb0f29300e..224b6f18d4 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -889,7 +889,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
 		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
 		OPT_CALLBACK_F('M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback),
-		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
+		OPT_STRING_LIST('L', NULL, &range_list, N_("range"),
+				N_("Process only line range <start>,<end> or function :<funcname>")),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
diff --git a/builtin/log.c b/builtin/log.c
index 0a7ed4bef9..c87ce09325 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -183,8 +183,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 				N_("pattern"), N_("do not decorate refs that match <pattern>")),
 		OPT_CALLBACK_F(0, "decorate", NULL, NULL, N_("decorate options"),
 			       PARSE_OPT_OPTARG, decorate_callback),
-		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
-			     N_("Process line range n,m in file, counting from 1"),
+		OPT_CALLBACK('L', NULL, &line_cb, "range:file",
+			     N_("Trace the evolution of line range <start>,<end> or function :<funcname> in <file>"),
 			     log_line_range_callback),
 		OPT_END()
 	};
-- 
gitgitgadget

