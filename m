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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964ACC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D6260EE7
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbhIMAO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 20:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhIMAOx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 20:14:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2D4C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:13:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b21-20020a1c8015000000b003049690d882so2827308wmd.5
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2GR4nfgYhhIwjTv6Kyo1FfmSwih5XNCV7n5pTFzzxA=;
        b=owW3eEUD4WKkAlx5P5MJIv5AlBegyLK2zE3P/DOmVWW9/vnr3b/hYPAkosRGzk2MyF
         tjdsAacpO51i7dc0eMA//e57GJ4jnmh9fq55nDY5L0QPQPbwu/phuTcRT82jLi5eFdyx
         L+vdGKIKJs2zqr0iL5S3IIAK26AcWzHwdRJGdbkUx8fpiTRpaHRQpvlHx+GOzxo1XAAH
         KhxQUMSz6jrF9dvh2eIGAKtodnuziX4KFYmHr6lmVgBx4egDyhom05OwVW3uHaMP+wTE
         lzpo9edztSiEey6scAiflmzgNOmzcg9IceTgpExeP/VmZF7JNq5GdbVcnYN3OT6FMc/A
         5C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2GR4nfgYhhIwjTv6Kyo1FfmSwih5XNCV7n5pTFzzxA=;
        b=rX0kcPaEDUInEUG179omLtTlccOUh8zZZTh7CtLC9ANEZfhuFnx2xMDNscjlBL+6A0
         1XiJmH26mJqhF0FJ4eV/H8PromTkGHdtqsgjxHIgy40WZ9USMHknhf8O/oLX0IfbwYwp
         Yy9BJ12243OtYBatUtvYY1k3uLZP7eXs5Je0CxPAEfJ6x7f6e/O6TG6oNuJgG9uZ7Urn
         hKEKN9d79KsHwGIcMHa55hVm+/pY4MowxB2bS4QfDNSYCxgzjkYbmwY+Fz0eFPCuMplQ
         CtmTT0DoB3l7ykQdl0o947UgApPV2+amh2PjEQ4RT9YD/dWqf8rF+Ictl8h26aQTI2v5
         3U/Q==
X-Gm-Message-State: AOAM532KqlfchIgStjqEUBBsn6lg4U1SsS/U6cKI17es3cenN9uiQ/XE
        LJY7SMJXoT65ctvfD4lIzKmUuWtCZzD4eg==
X-Google-Smtp-Source: ABdhPJw6pt3nknhVfO5k5Sd5Yluj6YIkJqtnqD1uBeZSZbPcB8ZD7zGUBWZplDwmhqaIY0r4akDjug==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr8613671wmj.63.1631492016826;
        Sun, 12 Sep 2021 17:13:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j14sm5827974wrp.21.2021.09.12.17.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 17:13:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/4] send-pack: properly use parse_options() API for usage string
Date:   Mon, 13 Sep 2021 02:13:20 +0200
Message-Id: <patch-v4-2.4-f10ff775c69-20210912T235347Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1001.g3ab2ac1eaae
In-Reply-To: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com> <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
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
2.33.0.1001.g3ab2ac1eaae

