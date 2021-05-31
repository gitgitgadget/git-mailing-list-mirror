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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2C6C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8710E60232
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhEaTxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhEaTx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:26 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30841C0613CE
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:35 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id d21so13228974oic.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lImqJ1uhmVCEhO9rOMRITpdlXQIFJE6VqL3intGO/7k=;
        b=SvgBFlmg49b8I+eo7It392KTAKjPuGboXPrd27h87u2gv1lkAD5lvNGei1UHKJv+/Q
         oivroJufnsiXOjfsv48euT97tpk0U+OsXu84lApv5lrbqWbkXbBomeVsmeKqzzABrfjr
         2ZANkbj0qEFBd3XKs7cgfRIJsmWADimjNjVZPLXnQcVZ4lgpwHH4k9aeC62uNPgQ+POH
         CZM5I6gZgtAyBl84N2fZV5KFGqOil/FsU4y24EIyC9TvJkY5EH9hQqSBuK3oZssn3wYW
         BR1iDpn2ZMHSb/WsZciiYyaDvBQSQF70ge/nwShpBW4Rm0cB/oraST5f5lSSI70kq8gu
         +7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lImqJ1uhmVCEhO9rOMRITpdlXQIFJE6VqL3intGO/7k=;
        b=pSvY/PiFQqoWf4rbPNVfsUyW8X7KPI4z4VZFSqW1j+v+Tw1jix4jqpdgctHYAaKQ7J
         2NxMfOQV1cpMtcfATmM+qNJzRZFcPJntmuoxX/WpVH7csgi5C9RrbbAbUbMUaXoMUoLg
         +G4NxCTGOqPFjDd2OheRCKQfMH5YkFin6I//MWaxrGBuWE3HQrHjV5xBqfTVJ20je6j2
         op8itB9grtOfIRwrWaA2s0R3+W/TP1EMbGLCNTw2Fkq4hKrd/+EiG7rpI7FaCpox6Ks4
         NfnEqRImOtbal5C8BZCyj5NtY2tqqxEABOErlPU+tnVulbKmr0m5Yxi0f+Zm+GUPEPJr
         6IdA==
X-Gm-Message-State: AOAM532zhTWt/dj5gDGwGevz8SYfGGe/3T/24zPorFuOBKbd+PjO9JzB
        aT1jFqJKTp09qY9kFMRBo+8SEs7mlnq6Ww==
X-Google-Smtp-Source: ABdhPJxN2dsoveUbQ+piF83SUBhrpa9iji/3CRVTICH7ldiMV8BpmTbsgfyAeos7MgRql8V+FALZCA==
X-Received: by 2002:aca:edc3:: with SMTP id l186mr7780746oih.43.1622490694296;
        Mon, 31 May 2021 12:51:34 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c19sm3003681oiw.7.2021.05.31.12.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/13] push: only get the branch when needed
Date:   Mon, 31 May 2021 14:51:16 -0500
Message-Id: <20210531195124.218325-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 8fcbd2878d..d9f9d20f39 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -243,7 +243,7 @@ static int is_same_remote(struct remote *remote)
 
 static void setup_default_push_refspecs(struct remote *remote)
 {
-	struct branch *branch = branch_get(NULL);
+	struct branch *branch;
 	int same_remote = is_same_remote(remote);
 
 	switch (push_default) {
@@ -259,6 +259,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		break;
 	}
 
+	branch = branch_get(NULL);
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 
-- 
2.32.0.rc0

