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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBE7C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C906F6108B
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 19:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhIKTL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbhIKTLp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 15:11:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8408C061757
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m9so7837332wrb.1
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvPtu2L10IXCUyXciVVSa2PSteuHFrM2C9k6MmBZTKo=;
        b=ZPm+MznhudE3YBhTXudP8IaHuOwF+w50yU3jSNet4jxmuUlMHcw0DTtVGqkuTsZgcR
         hnra6pLWhHnlnVIcdqdFiiomIRqMDeb0x60peo75Xz1+SmRvSTG9i3Ya1emJuA9SVrjg
         rhWT1ndXT4lSiuyxYah2yu7rXQrc63SofX1peagDZ7tduHNcLVj2xDh39/+kOvfe82mq
         2mLlhl8DXG1DGyNqP8DOvnQ7kkef2XMJ4vuK8yfpa/8ELuUuhV/2q8TKFBa2oVkcuCma
         SUOcjqlhAtLxb21t/ry5sJqseKEgg0kRWddylFr9LDAGlPRfKiaTK+OhYoBsnNmI4ofx
         nV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvPtu2L10IXCUyXciVVSa2PSteuHFrM2C9k6MmBZTKo=;
        b=LR8vV2T4go7Rznoiwydja3yyFPncMyg+AKIUhIOVBOc58bRhQTE2R0RWiuVesk05O9
         LZXM4r0ZK/Z4Fcl8HhiEC1lVo6aPDWzYOidwxKewItat2ByEkoOcoN7CNpvggmd5bRCA
         /Bz4yBMOu8LWTkolt3iFthyxKXO7zzbOLePfEEPBRr86EJz5bdvfMQkVhewoEM+tpQ/3
         Q69RJPNinhiXV+F8KcvhzIvBwiWsvxgarMLnv3qpRc67gk4ENjVJs1Wsf5Vn7VBFseIZ
         tQcG1tixlt5M1q615++92PfVFDJB4/gqBcP96//wqbGBjDHrRZmMI4BdqqO7VQcC9qWG
         DZAg==
X-Gm-Message-State: AOAM530APjKqErBuAdZ7vaeYW+WYHT9boj04r5bXZhc+W3fhh3Uv4wgF
        Iyp6AsP1PuboqwRogWU4TVFZDn4whe0Rmw==
X-Google-Smtp-Source: ABdhPJyfrQJTKNbhRLtyZJkWxOBULbsh5q8ypEjO0k3pBhmGGLrcHHg8kH7KJYRe4N9Swa4CniLSsQ==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr4223856wre.187.1631387430021;
        Sat, 11 Sep 2021 12:10:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm2256822wmk.2.2021.09.11.12.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 12:10:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/6] send-pack: properly use parse_options() API for usage string
Date:   Sat, 11 Sep 2021 21:09:04 +0200
Message-Id: <patch-v3-5.6-821e5e14132-20210911T190239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.995.ga5ea46173a2
In-Reply-To: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "send-pack" was changed to use the parse_options() API in
068c77a5189 (builtin/send-pack.c: use parse_options API, 2015-08-19)
it was made to use one very long line, instead it should split them up
with newlines.

Furthermore we were including an inline explanation that you couldn't
combine "--all" and "<ref>", but unlike in the "blame" case this was
not preceded by an empty string.

Let's instead show that --all and <ref> can't be combined in the the
usual language of the usage syntax instead. We can make it clear that
one of the two options "--foo" and "--bar" is mandatory, but that the
two are mutually exclusive by referring to them as "( --foo | --bar
)".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-send-pack.txt | 4 ++--
 builtin/send-pack.c             | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 44fd146b912..be41f119740 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,10 +9,10 @@ git-send-pack - Push objects over Git protocol to another repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
+'git send-pack' [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
 		[--verbose] [--thin] [--atomic]
 		[--[no-]signed|--signed=(true|false|if-asked)]
-		[<host>:]<directory> [<ref>...]
+		[<host>:]<directory> (--all | <ref>...)
 
 DESCRIPTION
 -----------
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 729dea1d255..89321423125 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -17,10 +17,10 @@
 #include "protocol.h"
 
 static const char * const send_pack_usage[] = {
-	N_("git send-pack [--all | --mirror] [--dry-run] [--force] "
-	  "[--receive-pack=<git-receive-pack>] [--verbose] [--thin] [--atomic] "
-	  "[<host>:]<directory> [<ref>...]\n"
-	  "  --all and explicit <ref> specification are mutually exclusive."),
+	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
+	   "              [--receive-pack=<git-receive-pack>]\n"
+	   "              [--verbose] [--thin] [--atomic]\n"
+	   "              [<host>:]<directory> (--all | <ref>...)"),
 	NULL,
 };
 
-- 
2.33.0.995.ga5ea46173a2

