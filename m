Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11281C43381
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84EB22573
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbhAZFCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731627AbhAYTSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:18:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654ECC06178B
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:29 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f16so397502wmq.5
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ag+63Vxzue5/LXXH7lgT7VDmTGYjOaGULxBGDZSh4I=;
        b=RfeYFNqpO2RrYP5fc+e30S+k9Wox1soeL0qXgMUy/PmrOmVkqc8x61Io2gu89ISn85
         kbsP8RYtI5jg96l5EgnH7HVecqTAUOD6Xk34wRJzszxd6J8AC6o8buA/l4fj3YUIyOmi
         /PI0IKdakX3wXH4cD4TUVXVIDL3hWOvE1llH8vAoTbO3QMrHkdJIpN3jJ9c3OlWsvXNg
         vw3R/+WTrnELqS00ngV4oPb3GzluuEsgbOJ055Wh7gmAqUi6JVpV7cr6aVeeb+/lxRPc
         TCeIqCiDu7gOmMipWCfQvFuR7MejK4zVmNHDc0eMgTyijiNSlUtt7yVq7FJb4cWpIAP0
         yl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ag+63Vxzue5/LXXH7lgT7VDmTGYjOaGULxBGDZSh4I=;
        b=F5qG28IW/AVHZUsaBB7oIZYLMAHxgIUEa5XLVcYx2OzqsDxmJaVs4AsckeDJ2LqmHH
         GGzeLiKYzTbVMmHCK8ERKE3PtgpbGiXPsz/usN4jER8YVemTzGR097Xrerp23pcm2Yci
         jNkfRhT/s4vDgIrW24YdGO6QM7RhwWWmd/dxd3FM5HgxaUlVz3Y049MxGNVx8O/s6otP
         WBxslOdSA9l3ok6yypvj4WeqvTW8oKGP7X26P60zqNEEhZsKWXuvJRrGEaWeyXYAPm04
         SlZyzCw4tcrdxZdfxzOabJbzOjULP81ghE+AHBmLILmAC8ZWlnHqMDDL+WOZhyyoTo60
         AlLg==
X-Gm-Message-State: AOAM532mBYkHaOz8fZgZ7qXBuGE0apSQ/bWez9XZ1ISn27GEMIlD63tm
        KSR97DxROJVgSdY5t2GUVB3/S5KtQzs=
X-Google-Smtp-Source: ABdhPJwiokuIZWvkX8vnfATry9tVNrdgHQMsyCMB/eo1EO3D6Co3q90scx52AQzgrfM/iSe0UCchbw==
X-Received: by 2002:a1c:4e05:: with SMTP id g5mr1482052wmh.105.1611602248251;
        Mon, 25 Jan 2021 11:17:28 -0800 (PST)
Received: from localhost.localdomain ([81.0.37.108])
        by smtp.gmail.com with ESMTPSA id e4sm11665895wrw.96.2021.01.25.11.17.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:17:27 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 4/7] bisect--helper: use `res` instead of return in BISECT_RESET case option
Date:   Mon, 25 Jan 2021 20:17:07 +0100
Message-Id: <20210125191710.45161-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125191710.45161-1-mirucam@gmail.com>
References: <20210125191710.45161-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Use `res` variable to store `bisect_reset()` output in BISECT_RESET
case option to make bisect--helper.c more consistent.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0b16653f13..8232e795fa 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1043,7 +1043,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_RESET:
 		if (argc > 1)
 			return error(_("--bisect-reset requires either no argument or a commit"));
-		return !!bisect_reset(argc ? argv[0] : NULL);
+		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
 	case CHECK_AND_SET_TERMS:
 		if (argc != 3)
-- 
2.29.2

