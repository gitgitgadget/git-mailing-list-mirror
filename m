Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4660CC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 14:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF1E2072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 14:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiHSWh9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgEUOWC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 10:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgEUOWB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 10:22:01 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C6C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 07:22:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v16so8491798ljc.8
        for <git@vger.kernel.org>; Thu, 21 May 2020 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bx9sy++sIm4sHSieZqDtBj5pXghCX51tFw4eYsixHHs=;
        b=DiHSWh9UcCWHbcBrCFE/9mIlB83SMI3TLhXf4YBEG7Nb0L1J6fwb0KbExOBB3TLsP1
         ezsrgC4hPLlywK2OYNMiLzb3jENrd9koIMSIE7hQ9gsF9ISMQMGTJ9Rqf5tlKd0W7ho8
         RoMNWOC8/iV+ROtcTkYyfGFIL+vdNljuaXMnkYVyIrRZra3GhHopVQoqUtwCC7xWKwS+
         zepjny8S2fWTgZEnGt0zo9WA3EkHmsiT2aavZkdlY331ciAWjOTFyAfZabk6M+bCke4A
         AbKkws1y4NXuwNxuMiM2UvijNriUsqQMNduNbk5p25RwwGVQDMPFQvYgiMVHFzI/tBkG
         LveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Bx9sy++sIm4sHSieZqDtBj5pXghCX51tFw4eYsixHHs=;
        b=pQvPt/3WXvICxCYFoCc5jr0jv4JuSJ6A7GhAJxVX0kQT6uXY0oj2A9RQ+T1ZnD3R2/
         itVPdzNl7FpfFtBb35pTlyttmXlDyP0TTdjXw8engp72CwjlnbkHHqibt2mgv9krNDBM
         3WmKkS7ktSUAry7xAQnbMAdpq3fmVnkucAYaxgiuf8P/c25DgOv9JiqjMHKk4lGNuIPf
         UqZuFYP5MhINzBZ9LSx1McpRY8wMN3ZCv/EY9OMBa24dIVGLJVR0HB+uHH2VX8KgVpEr
         MR8N0ArXniifCHldrSHwU90ZxLNVP5kpE/Vln1d6jzFupfUjm6f/BGGLITWKtPujG1dP
         jVXg==
X-Gm-Message-State: AOAM532V2ZcHw/lzonIOXqDp3u7dvKn2GjIf3kezNBXCr4pSrVsufxPX
        DPNPXZRh/Ly0BrbQTfCiMdYEJHb6
X-Google-Smtp-Source: ABdhPJyH1lzmNYqdBswWAIDqB4FysPXGBDIuxSiwf3feZkXjQmPaRcV0eshDJIbVcsfdaWjyDAaolA==
X-Received: by 2002:a2e:a201:: with SMTP id h1mr3205729ljm.294.1590070919162;
        Thu, 21 May 2020 07:21:59 -0700 (PDT)
Received: from uncleman.localhost.localhost (dygyyw1rfqhphgdtwzl6t-4.rev.dnainternet.fi. [2001:14bb:140:955:c469:9862:8e12:a275])
        by smtp.gmail.com with ESMTPSA id t30sm1829053lfd.29.2020.05.21.07.21.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:21:58 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] completion: fix completing stashes with "show -p"
Date:   Thu, 21 May 2020 17:21:56 +0300
Message-Id: <20200521142156.4717-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.27.0.rc1.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Regression in df70b190bdd2add42a906819f9d41dbf91cf0809

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 70ad04e1b2..8dc4ad0e0d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2782,7 +2782,7 @@ _git_stash ()
 	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
-	if [ -n "$(__git_find_on_cmdline "-p")" ]; then
+	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
 		subcommand="push"
 	fi
 	if [ -z "$subcommand" ]; then
-- 
2.27.0.rc1.dirty

