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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126F0C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C2461363
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 22:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhFMXB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 19:01:58 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:44852 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFMXB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 19:01:57 -0400
Received: by mail-ot1-f50.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso9065060otm.11
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvnzbM1V/v21TQTXSkhY6XD51NKXzk91beoDIhOObL8=;
        b=Fa4B46/cgHCGPwcAd2HHPXOeSu88pIvwJW5jbymBGFsQnKFlk6+wB/PPz51C1+ewgS
         64U68W2ArwcxoGm1j6OCEgvS8+Dw0KlLpA8qufR2ks39CwdcgSxwmJ8vXn2UF2BcDv7h
         vKmOgy8hY8QY9nAaRFhOIFVuL3Yb/8W/u8Q3C6WO2Ra+45PESmxA4jlUymtRYHoaW5jF
         eVEii6vsitksauwHJH80ZDJGMQqxnBI5aeZJ+FCuq/MFHX0zkfMWxnHh1GeIxE8b+DXM
         j0CfffC91R7gKtFeRzomtgIuCOXYG+1OBKi0B6uLq2sSa/faJPn/zEqU3pDysP1xbiZQ
         3M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvnzbM1V/v21TQTXSkhY6XD51NKXzk91beoDIhOObL8=;
        b=mACqmvd64CHMcZ8XWRWXg0CWYTR2V6m43hf+y0hLU6ThOcx89tJobyPVm8ySxjST3j
         dIsYvRQcQNzL3Mz2q7oRfrz1HVtlyT8u+tohJUI0tZHYdiAz0oV4kFJvAIsn7620Za+h
         2HW5y7ktsRY3hMya5f6nSY2YSW4nhsGKcLE8suMj7QGO2nuIJWIDqDXQhOnb5SEPqgHl
         5O7BEwvPV0uuOC+6nVYMbfVXfFP/AaZrOjMo+In+5eKR26n5/GdvIxKW2rS6gWJ+7ZG9
         u+MaE38BmBHaR4O5yphTQlr+ApbcvlEANjlx82NhsGsv0q3NMyGmiO3ZRTBbgF4Ef7BA
         EP4w==
X-Gm-Message-State: AOAM532cvUTVXBf0OLhq+APpKrn0dKm/vdPhohDS0c/Vo2i0qH8rkN0I
        5xivhZJ4qcLheYkyW6QHByBg0dkVVxkJ3w==
X-Google-Smtp-Source: ABdhPJzzhrBeRRQuVIrO7Lr7PP8jcz32vmouslUuV6e7T6IzSs/8w1LLkkHkXZmumW910+0haoNDBw==
X-Received: by 2002:a9d:8cc:: with SMTP id 70mr10809423otf.289.1623625121308;
        Sun, 13 Jun 2021 15:58:41 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 30sm2407123ott.78.2021.06.13.15.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:58:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] merge: fix Yoda conditions
Date:   Sun, 13 Jun 2021 17:58:34 -0500
Message-Id: <20210613225836.1009569-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613225836.1009569-1-felipe.contreras@gmail.com>
References: <20210613225836.1009569-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge-file.c | 2 +-
 xdiff/xmerge.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 0186f4156a..6affccaf19 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -51,7 +51,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	if (startup_info->have_repository) {
 		/* Read the configuration file */
 		git_config(git_xmerge_config, NULL);
-		if (0 <= git_xmerge_style)
+		if (git_xmerge_style >= 0)
 			xmp.style = git_xmerge_style;
 	}
 
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1659edb453..ab3448ca88 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -487,7 +487,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		 * "diff3 -m" output does not make sense for anything
 		 * more aggressive than XDL_MERGE_EAGER.
 		 */
-		if (XDL_MERGE_EAGER < level)
+		if (level > XDL_MERGE_EAGER)
 			level = XDL_MERGE_EAGER;
 	}
 
@@ -603,10 +603,10 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	if (!changes)
 		changes = c;
 	/* refine conflicts */
-	if (XDL_MERGE_ZEALOUS <= level &&
+	if (level >= XDL_MERGE_ZEALOUS &&
 	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
 	     xdl_simplify_non_conflicts(xe1, changes,
-					XDL_MERGE_ZEALOUS < level) < 0)) {
+					level > XDL_MERGE_ZEALOUS) < 0)) {
 		xdl_cleanup_merge(changes);
 		return -1;
 	}
-- 
2.32.0

