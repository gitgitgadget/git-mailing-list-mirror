Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D976C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58A664DF0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBPMC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhBPL7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:49 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CD3C061797
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id x4so14211805wmi.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1PEm4oYYa+XXB9tO8b2SBvVI5mbt03QL6heWMW0u0o8=;
        b=A8u01WjHP/oUMId8PpUjEV8QIWOQLVaRsKdvaIHJ64ohSfc0XZtwdEbsUgp1fCXS8k
         7mgH7V92ozmAApIILsn5ywgVeTebTvdOdy31V+sObq4ocb02J8FzuxlZ2G9qoF6MFf/R
         aH6WqROEGN1tsQ5OesOLQDg9z+xWscyxbcySvUo5kt259/nCy4AaxpaMyzQZp9T3p3Bj
         RaT1gWSeqWqYUfIJiCa8h2xJVBAvRPOYGzsc6La+pbO2kRzOfqODfPBUs2CcvGiGsqCj
         54tE7TgtauzzXsZPzD/gpvuTHuRDt+6Ai/1Tja8BxxyXxqF9zhmOy3xxN1VIATGSj+iE
         l3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1PEm4oYYa+XXB9tO8b2SBvVI5mbt03QL6heWMW0u0o8=;
        b=uhyFeUS//hOCYdiO2Yt+6hrAEWT8kFdAP45A38g8fNuWka7BT+oa6KJXbZRWEEhiub
         40GTyV62OHZa/h935wbTCbJV/a1g8JWvLYam76hmHbfw/DepEkKQoaeBRlL16dn7xIwE
         BVAV6BGTFy1hxMZ/qwYfiwIfOPH6E7b9PHLo5fBkxsWPM10q1uUaN9tCFWAYPiUTad71
         5212vJrD7bSp7MXMjR9HOq7ip4OvT8z6qgTkDoVAI7/AJtWoEFNQbcevwv+YvNqLgEXT
         ZaWipMxE4eFUY63UggvK38ynWgk1mSVBOd5Q02Gadkcxf6ssAA4Y63WWnWzHWP5/ITyS
         y+rg==
X-Gm-Message-State: AOAM5319y38Oc66JiMuDvY952xYW2Iv8wxjI5u8ousTX/cUB0FHkhqSM
        sLTbSrcaXYTLZT2z/XE++UWoRW91ucCxZg==
X-Google-Smtp-Source: ABdhPJzHLqlYke22NXUSs8UO3kbrbxcJwzDFxvAi3vFGRoHhIimNeuKF0aXzV32as1QIEbYv/cDQZg==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr2989187wmc.183.1613476701095;
        Tue, 16 Feb 2021 03:58:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/22] pickaxe: die when --find-object and --pickaxe-all are combined
Date:   Tue, 16 Feb 2021 12:57:49 +0100
Message-Id: <20210216115801.4773-11-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neither the --pickaxe-all documentation nor --find-object's has ever
suggested that you can combine the two. See f506b8e8b5 (git log/diff:
add -G<regexp> that greps in the patch text, 2010-08-23) and
15af58c1ad (diffcore: add a pickaxe option to find a specific blob,
2018-01-04).

But we've silently tolerated it, which makes the logic in
diffcore_pickaxe() harder to reason about. Let's assert that we won't
have the two combined.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c                 | 3 +++
 diff.h                 | 2 ++
 t/t4209-log-pickaxe.sh | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/diff.c b/diff.c
index 96da1fe6167..63c49ecaef1 100644
--- a/diff.c
+++ b/diff.c
@@ -4633,6 +4633,9 @@ void diff_setup_done(struct diff_options *options)
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
 		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
 
+	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
+		die(_("---pickaxe-all and --find-object are mutually exclusive, use --pickaxe-all with -G and -S"));
+
 	/*
 	 * Most of the time we can say "there are changes"
 	 * only by checking if there are changed paths, but
diff --git a/diff.h b/diff.h
index 668d496d7a5..8f0dc7ef43b 100644
--- a/diff.h
+++ b/diff.h
@@ -537,6 +537,8 @@ int git_config_rename(const char *var, const char *value);
 				 DIFF_PICKAXE_KIND_OBJFIND)
 #define DIFF_PICKAXE_KINDS_G_REGEX_MASK (DIFF_PICKAXE_KIND_G | \
 					 DIFF_PICKAXE_REGEX)
+#define DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK (DIFF_PICKAXE_ALL | \
+					     DIFF_PICKAXE_KIND_OBJFIND)
 
 #define DIFF_PICKAXE_IGNORE_CASE	32
 
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 46dc5f14b3b..bcaca7e882c 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -66,6 +66,9 @@ test_expect_success 'usage' '
 	test_i18ngrep "mutually exclusive" err &&
 
 	test_expect_code 128 git log -Gstring --find-object=HEAD 2>err &&
+	test_i18ngrep "mutually exclusive" err &&
+
+	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
 	test_i18ngrep "mutually exclusive" err
 '
 
-- 
2.30.0.284.gd98b1dd5eaa7

