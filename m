Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2BA81FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 14:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbdDOOlQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 10:41:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32768 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbdDOOlP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 10:41:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id l28so15441983wre.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fL2dztGn2uvp0F2B4ixoLQuUATpOjvGbc1jvxwobTvg=;
        b=lbJpQ0FdHdd03hz0bAdPvPd5/UQcewnsbKKine0d2iUv8d+tNFM3fKIPOAs/JLoTHo
         eJBpadlPh10z0xB3E0JOiHlybxcL4QsvqS1XjEAuAmTm7fmwdUMpiq5yBvQp9x6Us2jg
         WwcMc+hhn6nPizqWuca0Gi3184PLEiFmvLNREG+ebLEwJBaWAubuDDlB9pP2TDNTbMPA
         UjtUBUON99gync65f8tridCMYb/P4fwRWqBp4lajfVPu94ilhbk2tyfLbC1+YDmKfuh3
         SYa996TAcCOCw6qg0dmLzq16JJeCis3jAIGuiAshjw3N7xL5Dz1q7zse2BzNiAg4KwRw
         B3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fL2dztGn2uvp0F2B4ixoLQuUATpOjvGbc1jvxwobTvg=;
        b=bD1qgycEekknuFtwAvHPQSOJy1hdZETPEWs/UM76Zwae1U6K/rosxmNF28tunc0Ljq
         7YTBNq9y+iObGv0RESGZ4mHtHCyt0tid5oPZPOg0UkjtwsLl6QXaAx/Phs8ryA08VfRZ
         pxc6DD+E/Vfbv0ITN4EsG4TH+rjDVJYQVNN6XkcjH0Nnug4PJpSxftdcLNhAEzoeXBcl
         bOPdrDO9KaoaQ67HQa/s4l4nBVAbsZA4+31cIHAPvBqG36Ktg9yGLOcbmZSvuhICyiCn
         /D0eIPaYtZd5WADASc5JwUnwJGw2YawRIsCwJfpZVDvu02Tfp0iJeU88xkd6e3P14jc3
         3K5w==
X-Gm-Message-State: AN3rC/5rFlEYN/WChM7xtUN4rh+iXPJRVtFXhWRwgxLSfTKjC2saR17t
        5SyLq5hB3JGAQw==
X-Received: by 10.223.165.138 with SMTP id g10mr9238187wrc.19.1492267273795;
        Sat, 15 Apr 2017 07:41:13 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id 43sm6440177wry.31.2017.04.15.07.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Apr 2017 07:41:12 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/3] rebase --signoff
Date:   Sat, 15 Apr 2017 16:41:00 +0200
Message-Id: <20170415144103.11986-1-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.765.g2bf946761b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow signing off a whole patchset by rebasing it with the --signoff
option, which is simply passed through to git am.

Compared to previous incarnations, I've split the am massaging to
separate commits (for cleanliness and easier reverts if needed),
and introduced a test case for both --signoff and its negation.

Giuseppe Bilotta (3):
  builtin/am: obey --signoff also when --rebasing
  builtin/am: fold am_signoff() into am_append_signoff()
  rebase: pass --[no-]signoff option to git am

 Documentation/git-rebase.txt |  5 +++++
 builtin/am.c                 | 39 +++++++++++++++++--------------------
 git-rebase.sh                |  3 ++-
 t/t3428-rebase-signoff.sh    | 46 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 22 deletions(-)
 create mode 100755 t/t3428-rebase-signoff.sh

-- 
2.12.2.765.g2bf946761b

