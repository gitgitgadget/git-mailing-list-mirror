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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26267C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 11:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017F761156
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 11:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhIULQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhIULQl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 07:16:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AA5C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 04:15:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a7so4485365plm.1
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rB/1THhUmb5xFTv4rqJKcmcWTAxwDeI4pSoidc+2gw4=;
        b=FDTm7SgJGhVYLv40A+5CcZeMqTae1sif+GJ65eU6Bld8SBAFuQ32P+i05w9hs5SfJs
         uOVOipYfVwHIncL2RsZzGCNZ+3i2wShqw+fSFfmapYuO4EKF1143roQCSfMRFkm6vfI/
         1auFTwk1vXQEHS9IbGVp73i11lfcHL4qTklE0cMJ4r0rtiALo5oW/o+hyi3yhvKKni13
         +jdYnxPatg9akfYqdD7EKk8UUgZmV3mdesZFp1iErtcRE0hWkCZNyV9xVFRD7yYcSO1j
         d1dzCvUJwmQHjC4h3dlwG/ArtPAFpWUUImETbl8/vztS+rRhE+E+uTryCRO7zP83SiXO
         BYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rB/1THhUmb5xFTv4rqJKcmcWTAxwDeI4pSoidc+2gw4=;
        b=HqhJCMpwmXOs5dAR4vVj/W1k2qbEVomBkOcpqAhw6KNLVKJ5Vc0YioNLa2wTVSaIAf
         xY8Zad/n29xIR5TV7R7FasJ8nezRLARNNC6+qWGIRAbah2toEy/R02kdaaFaGDUsmev/
         msUt6nZVtxhlmqX01RsHQRQs/OPK5FE/28CYA8mg4AqmNW6lM0kEokBnY5ACWaqdZf2g
         MHujTBByHKMP/jyBJZjc0rSz23nW2t4/XddYBthbiubQcbCq5axQz16SzQlgAo5j7wzI
         gLbQXeMox7smLTHQxWxpRQFU5F5XNkKy7qv0n2dBgoQmEVQ/Zuns7mTcAdCTQWi6qew5
         b8FA==
X-Gm-Message-State: AOAM531gGN8IdxItUqW02IFLOc7iqbxvgUEGuy9HzTKRYxBXPfiCjoEL
        WUH+kEox2RfgTtZj/D6kuG1ZjzANbr34cQ==
X-Google-Smtp-Source: ABdhPJyRqwE5qqLIOQ8NW24pzh42cuutOFNflC1Uu+OT4hmksbPdXH1c67nkv0l/uyjd5B+SUZaNHw==
X-Received: by 2002:a17:903:120e:b0:138:d732:3b01 with SMTP id l14-20020a170903120e00b00138d7323b01mr26867275plh.21.1632222912528;
        Tue, 21 Sep 2021 04:15:12 -0700 (PDT)
Received: from ubuntu.mate (subs28-116-206-12-33.three.co.id. [116.206.12.33])
        by smtp.gmail.com with ESMTPSA id c199sm17373397pfb.152.2021.09.21.04.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 04:15:12 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        liu.denton@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] ls-files: use imperative mood for -X and -z option description
Date:   Tue, 21 Sep 2021 18:13:05 +0700
Message-Id: <20210921111304.887605-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Usage description for -X and -z options use descriptive instead of
imperative mood. Edit it for consistency with other options.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

Changes since v1 [1]:
  - Add missing "the" article in -z description (suggested by Taylor
    Blau)

Range-diff against v1 [1]:
1:  eee9d91fc1 ! 1:  9f02334bdf ls-files: use imperative mood for -X and -z option description
    @@ Commit message
         ls-files: use imperative mood for -X and -z option description
     
         Usage description for -X and -z options use descriptive instead of
    -    imperative mood. Change it for consistency with other options.
    +    imperative mood. Edit it for consistency with other options.
     
         Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
     
    @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
      		/* Think twice before adding "--nul" synonym to this */
      		OPT_SET_INT('z', NULL, &line_terminator,
     -			N_("paths are separated with NUL character"), '\0'),
    -+			N_("separate paths with NUL character"), '\0'),
    ++			N_("separate paths with the NUL character"), '\0'),
      		OPT_BOOL('t', NULL, &show_tag,
      			N_("identify the file status with tags")),
      		OPT_BOOL('v', NULL, &show_valid_bit,

[1]: https://lore.kernel.org/git/xmqqee9javtd.fsf@gitster.g/T/#t

 builtin/ls-files.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 29a26ad8ae..e6d415e077 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -614,7 +614,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	struct option builtin_ls_files_options[] = {
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &line_terminator,
-			N_("paths are separated with NUL character"), '\0'),
+			N_("separate paths with the NUL character"), '\0'),
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

