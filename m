Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED8EC11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C81F206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXSm573h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgBTVrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:47:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35516 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgBTVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 16:47:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id n17so4057184qtv.2
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 13:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zetI/vpp4aQsGwzj4bNzs69G3SSEcmmkBSNH9l4EyrY=;
        b=lXSm573h7sGP+XnmlAVHoKpdSQaCizfvKTQl0hNImJrYo/O/k/M538GHW2xoYlhw5q
         xe8ZUhHJjX5Y1b7KdaB5IvD7bsNDcMG35H7yZNwkfdXZM6DdEQubWD9Jhl6Gww2V8GLQ
         nMZ/4R8IK+VGv03bGQR/ieSL1cbRFX+byYRWi9QroSNenBsNKQ+/kmPXwK68HfDIr4Yk
         q20ynNevwM9pGedpAb4Z+bZxj/ulQosfET/PzEwJypFWNI8JVylFg5djOYSD++Q/uAXt
         sD90zlN0n1YOx2J8p4qrPmjssckPMDjPmLZcFoQ03dtlsngcCBbwQs5shpGX5Zp/X/du
         QuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zetI/vpp4aQsGwzj4bNzs69G3SSEcmmkBSNH9l4EyrY=;
        b=p/hbcLvmhmZyBeFx/UOrvVdRU5zVaccI8BDn66NXCgrx9lrOi748/m5pc5ku5cbMDy
         8lUnNlE2x6YpH/itq5rsZEIp2atOea/LZBixdZWxKFZl0I4joirQGFyaJyOP2FiOdNDI
         kNsf+A4Rm2eE/CK9weC9YzZTzjcQLK2NmaY7KW28JDvx1gyAYHJ2+gqoIokZwDtwbBnE
         dTENbKOH0Kk4z0OW1IhCMszzlU9SZ1SCaeqC0k2i6JVqpncuXEEQI0AMD6g41w4XU/q/
         lVS770RYYMfCDTOyP7RZ8/emVS+qtlJsFf1KbNbVJR5aoj4FLOfXewSOjmtk1RmGwflv
         t1cA==
X-Gm-Message-State: APjAAAVOprL+cmBQ5d+wgY4nd6l5C/ECCn+dDqDLUaAVCtTKmbmDFFDn
        E1e+rqtyeb/YU4FoZmRJxNHd2XCz4j/fCw==
X-Google-Smtp-Source: APXvYqzPG6qOzU9iSPQfbNMo65IuyABJ7LZXsbEKNZHTxNDbIilUkhj9MTarSw1fi4mdl1/OlJtEeg==
X-Received: by 2002:ac8:176f:: with SMTP id u44mr28144949qtk.379.1582235224414;
        Thu, 20 Feb 2020 13:47:04 -0800 (PST)
Received: from kir-rhat.redhat.com (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id p92sm449787qtd.14.2020.02.20.13.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:47:03 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, matheus.bernardino@usp.br,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH] completion: add diff --color-moved[-ws]
Date:   Thu, 20 Feb 2020 13:46:47 -0800
Message-Id: <20200220214647.451064-1-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These options are available since git v2.15, but somehow
eluded from the completion script.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 contrib/completion/git-completion.bash | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1aac5a56c0..43cb6a312d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1487,9 +1487,16 @@ __git_diff_algorithms="myers minimal patience histogram"
 
 __git_diff_submodule_formats="diff log short"
 
+__git_color_moved_opts="no default plain blocks zebra dimmed-zebra"
+
+__git_color_moved_ws_opts="no ignore-space-at-eol ignore-all-space
+			allow-indentation-change"
+
 __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch-with-stat --name-only --name-status --color
 			--no-color --color-words --no-renames --check
+			--color-moved --color-moved= --no-color-moved
+			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
@@ -1520,6 +1527,14 @@ _git_diff ()
 		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
 		return
 		;;
+	--color-moved=*)
+		__gitcomp "$__git_color_moved_opts" "" "${cur##--color-moved=}"
+		return
+		;;
+	--color-moved-ws=*)
+		__gitcomp "$__git_color_moved_ws_opts" "" "${cur##--color-moved-ws=}"
+		return
+		;;
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index
-- 
2.24.1

