Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E326C2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2852520936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u25puNMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766905AbgJYDOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766886AbgJYDOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:25 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B951C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:25 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id x7so888270ota.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SbBxvfoln6EKFeCnDCIvuxliBbQaB/eJv+xTK9cJb3E=;
        b=u25puNMvFsLIq2Y0V+YOillI8U+FqzNGVkFoXBpSWRrKpRI88z7JjmdILjwzF8i/Ty
         zj+FFUcbuYhk24vGuOKV8ygtYFTFqKmtDQ94Y6wbkuYf2w+6tv5sdG9VUGRaPMrYtI3+
         g0sJ1x5Gxh9UkLauQeXK8MaUdY1wctdlYf8HnxrqNlkXUuqwkAcfLg1WCfRGATX6E8IZ
         oM12lWstjfGzbESkeEsj/wmtX+dVLta3HpwXXOfPX8E/y+5nVqB3wJLwClXC8to/ND0X
         FI9Kqa0ShxRBmt5sMpVtBMUAfPuot6qvfZ1iMECnSg2REsSRQ3c6LxCxJO+uj4VHvwvi
         P/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbBxvfoln6EKFeCnDCIvuxliBbQaB/eJv+xTK9cJb3E=;
        b=oN4J++aqMdjxm4mvgBMPr2iAim1sIOW8Q+KF5mxxEnlXrCJKnkmPvhxXoJJXY3/Chm
         h/GKQcgoe24q1Zv/yhhzcHVcN2xqcuIwOCd+j6MDplIS/G0RwRwjZlAMzyeaGYQGJkc+
         KEDLuETKtC+boBDXA726lwHBhEOYtkZbfZMpiD3WS5AXx7kkBXKOOkl18rfu4dSj6QCi
         V1k31DpSI/P5y+GGPMoanFoXmSQHQgFbn7RhWPvw1+6Pp2t6o/VcgsqIOS1TBEVCITzT
         /4VPJmiSx3B8GDQbyPx4dlGkQPA3DfgSBXCITYQq9GgOedpYDlcEqvSb8i4jwik4Of1j
         tgpw==
X-Gm-Message-State: AOAM533Bvt76IY/c/g6nMZlavvCb1zdcOBaZOINmo+6R3Z6EKZlct0kI
        1PuGnvyiQJxVe1ETPNWOt4QTrfcZ6TeDXg==
X-Google-Smtp-Source: ABdhPJzfdwC7qkCJfvzIrLb34YUCuq2IZVwDDR4Zu0OUxeKePDzEOmYeiJItO1Xx84NZyY03RgN3Bw==
X-Received: by 2002:a05:6830:3141:: with SMTP id c1mr6587363ots.212.1603595664782;
        Sat, 24 Oct 2020 20:14:24 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id k15sm674306oor.11.2020.10.24.20.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 26/29] completion: bash: trivial cleanup
Date:   Sat, 24 Oct 2020 22:13:40 -0500
Message-Id: <20201025031343.346913-27-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to set a variable we are not going to use.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6de0e7b482..68e0acb232 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -416,14 +416,13 @@ __gitcomp_builtin ()
 	local options
 	eval "options=\${$var-}"
 
-	local completion_helper
-	if [ "$GIT_COMPLETION_SHOW_ALL" = "1" ]; then
-		completion_helper="--git-completion-helper-all"
-	else
-		completion_helper="--git-completion-helper"
-	fi
-
 	if [ -z "$options" ]; then
+		local completion_helper
+		if [ "$GIT_COMPLETION_SHOW_ALL" = "1" ]; then
+			completion_helper="--git-completion-helper-all"
+		else
+			completion_helper="--git-completion-helper"
+		fi
 		# leading and trailing spaces are significant to make
 		# option removal work correctly.
 		options=" $incl $(__git ${cmd/_/ } $completion_helper) " || return
-- 
2.29.0

