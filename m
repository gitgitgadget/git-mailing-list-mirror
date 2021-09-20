Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC6C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C456109E
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 12:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhITMVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbhITMVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 08:21:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24C9C061764
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:20:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r2so17111856pgl.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J4TfT52f8OOkSRc+j6EroTapto67etHiDhMLbylAq8g=;
        b=Vs6rS7kVh1fIuvSUPf4Q7XV40LRWtDjIbM4Kfi3poA5OjZiBwz4p1MteWH4HwjiiXC
         DYOXAkgchDB/+p4cdABiovABnnDuXu+hZgg2uRPGhOVtYokK9OKmnoBwrqWtuegUEbZ5
         lvoB6UypRkJBqTsRKZL9T7CUutOsRWqSoIY4q3m4L8xKEks/ZwsJc96fECSoCEmF3ZiK
         uKDVA0jbMgnA3ZwZd4z+pjHWMC/U8ZNX5OPLgd5rH7XDhwTTDJehYqLTNIuj/iHCoMDW
         SOrWXWdCVEgARFrZsfdGeuBN+xc0JgP3xOLTMnJD2W/0j58Z3/ivG8gfwh8WWRKLg67z
         XEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J4TfT52f8OOkSRc+j6EroTapto67etHiDhMLbylAq8g=;
        b=mZiokQAbvMZF3+RbsNJCGTqS3HSlKU0ePaXTugUp5SlZkNlxIOzoL9qzWwUXA7AC5r
         5kyX3mxRBb2a8LLBTDFmJeeQ5uRLUnqeKS+feKnGCPEtYnARSZ52miI+azz//hSGKsE8
         m+0RBaoz4wDAG4Rs7+X6NglQ5jeQSOU5w2QJl7+Vqusik0rbpHM2IYooWKLBW1/gQvg5
         cmtjZ03mfTIAvO3SdGaJKP5pvzgosFwAETA+VdaR4QhlontUCG8+5E9NtBJKiWaJp681
         XarUuMEscc6R0rzXHG287W2V9YWwhNoOnlFNpfuzF0qywtKGSruSsI/p+xzgeXYPJ0IJ
         FKyg==
X-Gm-Message-State: AOAM5305Orm5GijGHN2+rgea2ApwdMQvD3sJJjsGheHy/0aStAcZylnG
        fvdaKE7lQ+i5OJKWWgXAFlXcz2p4/58f7g==
X-Google-Smtp-Source: ABdhPJyDnKBo6RHFoAAoO1Tcyfvb+0onPzBtIeFzmxcEv+HAErw3GZHWwazT2hSiQZXrWf8Yx1OFEQ==
X-Received: by 2002:a63:8c42:: with SMTP id q2mr10689140pgn.325.1632140408266;
        Mon, 20 Sep 2021 05:20:08 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-78.three.co.id. [180.214.233.78])
        by smtp.gmail.com with ESMTPSA id o2sm2563922pja.7.2021.09.20.05.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 05:20:08 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>,
        liu.denton@gmail.com
Subject: [PATCH] ls-files: use imperative mood for -X and -z option description
Date:   Mon, 20 Sep 2021 19:19:41 +0700
Message-Id: <20210920121940.905549-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Usage description for -X and -z options use descriptive instead of
imperative mood. Change it for consistency with other options.

Cc: Jeff King <peff@peff.net>
Cc: <liu.denton@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 builtin/ls-files.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 29a26ad8ae..1f38cd7b17 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -614,7 +614,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	struct option builtin_ls_files_options[] = {
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &line_terminator,
-			N_("paths are separated with NUL character"), '\0'),
+			N_("separate paths with NUL character"), '\0'),
 		OPT_BOOL('t', NULL, &show_tag,
 			N_("identify the file status with tags")),
 		OPT_BOOL('v', NULL, &show_valid_bit,
@@ -651,7 +651,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("skip files matching pattern"),
 			PARSE_OPT_NONEG, option_parse_exclude),
 		OPT_CALLBACK_F('X', "exclude-from", &dir, N_("file"),
-			N_("exclude patterns are read from <file>"),
+			N_("read exclude patterns from <file>"),
 			PARSE_OPT_NONEG, option_parse_exclude_from),
 		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, N_("file"),
 			N_("read additional per-directory exclude patterns in <file>")),

base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
-- 
2.25.1

