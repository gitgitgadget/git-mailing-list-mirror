Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15F420966
	for <e@80x24.org>; Fri,  7 Apr 2017 19:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbdDGTYG (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 15:24:06 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36167 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755483AbdDGTYD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 15:24:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id 81so17406381pgh.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DuVXKOsUAY4Zx64li/z37VlYgT17RP5EVBGPlHD5yLI=;
        b=q6l5L+aDzsJghrOftJAu10Yll3FFTkB+Y+o5UR7+RALtVuUsVDlo4G0mmgW2/v6PBS
         pRsXWT8ZP6JABn58W67tMSP+T4OGQq/NUb5W5kuFzmYiXu9oeTuVizGP0/vzeN0dBPuJ
         kql5ZW1R5c9O3GXHtnNXa87TUcV0UFxDDlDFIMDlUO2fwE3/gYTodlYMJKlL+MpT4gvr
         knwIPD+xIo9W2m7kBCNCrAwOE2JbuguRKjdlUzirk68ECI0+e4ov69jBPxTevpKD1OwV
         4qs/10uIDTB25HENATdf1ZOM9fCIuukMXGMnIel0IAuz3n3/foWUcNZtoo2J+/xiGuq/
         gZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DuVXKOsUAY4Zx64li/z37VlYgT17RP5EVBGPlHD5yLI=;
        b=W1paBm+/DxQg4WtRGijJClhMmY7p5bIYfG8xYvICd6f+GXZJ1WKNHX5YMUIrSaB5zF
         c7zknCvfjmqT3qb0ew1iey1ynodAm8h7LcLj3LmJv5aBdzVjhokWloK+j/o8xwzVeNJS
         kkl2uUueFssrLzs35SrshLf4FrIlbprx6r7yhIMAOBiTqJnyJwgUzg/uMKWtQG2VIM3U
         34KseBBdq54GS38cbwsJoWzx7V1gB+/0odgFt6ttbmJBlKYm3xHMBaU5L61m4OhwRuSH
         FSvpBjqvMTLzkBPFqCnpbIEZFSrD8GLTlRKNvWq6SxGmPQ05g/VhjjQOBpnDPQO9QNL6
         D6Bg==
X-Gm-Message-State: AFeK/H2nmbDZTCXNte1PM1R38liRzTkm3eRG5cxIYeZ8VzrjpTBhEM3XFtSdg+huMGkhbw==
X-Received: by 10.99.47.67 with SMTP id v64mr24018978pgv.32.1491593042783;
        Fri, 07 Apr 2017 12:24:02 -0700 (PDT)
Received: from kewillf-git.redmond.corp.microsoft.com ([2001:4898:80e8:9::3b6])
        by smtp.gmail.com with ESMTPSA id u29sm11018797pfa.123.2017.04.07.12.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Apr 2017 12:24:02 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 0/3] fix working directory file issues while using sparse-checkout
Date:   Fri,  7 Apr 2017 12:23:54 -0700
Message-Id: <20170407192357.948-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.12.2.windows.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While using the sparse-checkout feature there are scenarios where 
the working directory should and should not be updated.  This patch
series addresses issues found in reset, apply, and merge conflicts.

Kevin Willford (3):
  merge-recursive.c: conflict using sparse should update file
  apply.c: do not checkout file when skip-worktree bit set
  reset.c: update files when using sparse to avoid data loss.

 apply.c                          | 18 +++++++++++++
 builtin/reset.c                  | 34 +++++++++++++++++++++++
 merge-recursive.c                |  8 ++++++
 t/t7114-reset-sparse-checkout.sh | 58 ++++++++++++++++++++++++++++++++++++++++
 t/t7614-merge-sparse-checkout.sh | 27 +++++++++++++++++++
 5 files changed, 145 insertions(+)
 create mode 100755 t/t7114-reset-sparse-checkout.sh
 create mode 100755 t/t7614-merge-sparse-checkout.sh

-- 
2.12.2.windows.2.1.g7df5db8d31

