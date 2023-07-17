Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F90EB64DC
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 15:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGQPi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjGQPiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 11:38:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329CB103
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 08:38:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so47509565e9.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689608293; x=1692200293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hgfnE39bImkBE4BVRWtJFv4pFnVXelcafe4LZlhFvHY=;
        b=ZmpzS7GapnBua+QMQK4q6zaA9V6DFvo/aEYKmubVS+r0eQN08XY2xl2vpLu5RfginB
         DQJQ1PkbTgH3GK0DGIOdNS34tUzN+U4fJMhGaddmMaYpyW5CiqeBdS7DGD3vzGloI4Vd
         6Yi0lvCnn5GMvjWpDKpvNPuIDHkHD2ChklGwJC6dTiDzAOeieaedzPDQcJvGkQifsg1L
         E5PQboQGRRV09JjLk+bpU4Vy7XqNE1JYaZhPhbH7Clp4QNvjorJRDNP3eSfR3W1fm+aO
         GMfwuNP0V5NqRnMgkcVXg6HrPT6Yt4C+Lujhcpg2tjPz1aIMjqaDCQxtFocD/4+pafCI
         xENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689608293; x=1692200293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgfnE39bImkBE4BVRWtJFv4pFnVXelcafe4LZlhFvHY=;
        b=QwV39R7htfT1qg++c1DVFjWoXO5f9wub0YUBDOxkmXmOkZhgFO17MbU2Jplqpfn4hz
         xcyujZeKYrktvUdFFXYctDDnjHL2iAzN7DXlhvvj9yy9nfSFUectwk4SeFRL4HPyZMpt
         ivvD0SxaiwlY6740At4LMsf1d6eTJlvtfL3cD1+0X8507IVkiKSIyQGo5FdwKrkSYtdM
         CUOP1mj9wNTJA4YnyPFn2bBXPxRR71VJHADfcK37M53REY2TUo3lfG5VdkEyfXDL1tYu
         3/Agqpv4jN041ycFxWv6H66MLv+5thpf855NyoPypZxs4ONkx9+aAJT1yYd1qzc+WLBf
         vseQ==
X-Gm-Message-State: ABy/qLa2vlbRLJY6gR68SyBTPNzKOO24zAOdBlWsVPuB4yZ8CkzsXhZd
        1dJG9RMIL07jIzLLQjKPNoSevHaFGIM=
X-Google-Smtp-Source: APBJJlGQGG4h2TPBwOvdtGW9D2IBLzjowCTIFX5e76KGA2TOsVhOpfJn6fCT+doJevK8nhfedmEHuA==
X-Received: by 2002:a5d:4844:0:b0:314:10d6:8910 with SMTP id n4-20020a5d4844000000b0031410d68910mr10893245wrs.63.1689608293156;
        Mon, 17 Jul 2023 08:38:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17-20020a7bce91000000b003fbca942499sm8373164wmj.14.2023.07.17.08.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:38:12 -0700 (PDT)
Message-ID: <pull.1550.git.git.1689608291732.gitgitgadget@gmail.com>
From:   "AtariDreams via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Jul 2023 15:38:11 +0000
Subject: [PATCH] Prefer fgetc over fgets where possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     AtariDreams <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

fputc is meant for single characters,
fputs is for strings. We are better off
inserting sole \n characters as
characters, not whole strings.

Signed-off-by: Seija Kijin doremylover123@gmail.com
---
    Prefer fgetc over fgets where possible
    
    fputc is meant for single characters, fputs is for strings. We are
    better off inserting sole \n characters as characters, not whole
    strings.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1550%2FAtariDreams%2Ffgetc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1550/AtariDreams/fgetc-v1
Pull-Request: https://github.com/git/git/pull/1550

 wt-status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8a1a4fb1f04..4c267395cdf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1215,7 +1215,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
 				 comment_line_char);
 	else
-		fputs("\n", s->fp);
+		fputc('\n', s->fp);
 	strbuf_release(&sb);
 }
 
@@ -1814,7 +1814,7 @@ static void wt_longstatus_print_state(struct wt_status *s)
 	if (state->merge_in_progress) {
 		if (state->rebase_interactive_in_progress) {
 			show_rebase_information(s, state_color);
-			fputs("\n", s->fp);
+			fputc('\n', s->fp);
 		}
 		show_merge_in_progress(s, state_color);
 	} else if (state->am_in_progress)

base-commit: 830b4a04c45bf0a6db26defe02ed1f490acd18ee
-- 
gitgitgadget
