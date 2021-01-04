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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B3BC4332D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B9722519
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbhADXvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbhADXvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:13 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31687C061795
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:33 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id p5so34094864oif.7
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6qDFKHYv2+CPcQFqk/39OmXiYJ8Imm+KW7HA6oTQ+E=;
        b=fisqyIcbBu5uO88l9n6gyryRVM3W4x4dH+ftcPBRj6M9kkkpDk3cyj9lA5okgfm4Rd
         eIt0LmEeeWKqFiD/qliEYMC+DgLYaRhLvA7SJKVC/UfifigGtX9/4aNFHw4s24BxHSLC
         Mw8lSySW/41DiwQNDsjs7hydrQ6+vLy8pNVEq77+f0Un2wAd0eA1n2pUH1pCReog8FKy
         6aWoV1ORj2ecXZGlFS6AD/ucE0D9mmPuYp20T7xASjK+ZRZ+1BEkV7WpzHc3XHOtHeS/
         FJ61fRwL14/x9AU30cedMUd7Rl7OQM8LAXi7P5AjP0F30BB7lwRsI1ZY1mB4erjyC/MD
         bWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6qDFKHYv2+CPcQFqk/39OmXiYJ8Imm+KW7HA6oTQ+E=;
        b=fgkXDmuot8jg6Vfo8twaKzV4kaDKwEOoOlPKm4PcTaqKMkZCMsDYuUvQgIQMwqZ5O1
         d+SmqNHOgTuX15gpWfHTI5So+9Yq5nH4cr6Nw7WjSoW0iEmvvK5U1/sVv3MytUP6k/Bo
         Qu85l0Enb+CeFtyY715aaRugpv4Ow5Eqm0XonjAGIBvDtKarxC26EFktP2fFlPIjoZ/S
         FBXCCtGUwSlUDtomaciDdiMJrtMnIXzDjNj2Mb9PBcAhr5XfYmDKy/Q5pxWKE0I0EYOB
         yLkmlrlA0XnHRC9LcbyR6nN6hwCFEu8QEWaGzR9wHhBXR1l6sYvJTKoP5kzEHciptgq0
         bQXQ==
X-Gm-Message-State: AOAM531kqOV15pQ0tMWY/Qv18ZospdGj0MQgdsezPY8vtq/Cb4qyfIup
        9VydpV0FZsM7T1WFXObfqGNvXRy2bJg=
X-Google-Smtp-Source: ABdhPJxULeXwUZBMmge6DxRbN5gFb+g+oreTQuGqDiTZoP/lXUbRezVwUrFfGcKvIkdzuj9uzXIs4Q==
X-Received: by 2002:a05:6808:199:: with SMTP id w25mr932374oic.151.1609804232526;
        Mon, 04 Jan 2021 15:50:32 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:32 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 03/17] merge-ort: collect which directories are removed in dirs_removed
Date:   Mon,  4 Jan 2021 15:49:52 -0800
Message-Id: <20210104235006.2867404-4-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 8b190b0ea5..f67ecdd171 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -532,6 +532,27 @@ static void setup_path_info(struct merge_options *opt,
 	result->util = mi;
 }
 
+static void collect_rename_info(struct merge_options *opt,
+				struct name_entry *names,
+				const char *dirname,
+				const char *fullname,
+				unsigned filemask,
+				unsigned dirmask,
+				unsigned match_mask)
+{
+	struct rename_info *renames = &opt->priv->renames;
+
+	/* Update dirs_removed, as needed */
+	if (dirmask == 1 || dirmask == 3 || dirmask == 5) {
+		/* absent_mask = 0x07 - dirmask; sides = absent_mask/2 */
+		unsigned sides = (0x07 - dirmask)/2;
+		if (sides & 1)
+			strset_add(&renames->dirs_removed[1], fullname);
+		if (sides & 2)
+			strset_add(&renames->dirs_removed[2], fullname);
+	}
+}
+
 static int collect_merge_info_callback(int n,
 				       unsigned long mask,
 				       unsigned long dirmask,
@@ -632,6 +653,12 @@ static int collect_merge_info_callback(int n,
 		return mask;
 	}
 
+	/*
+	 * Gather additional information used in rename detection.
+	 */
+	collect_rename_info(opt, names, dirname, fullpath,
+			    filemask, dirmask, match_mask);
+
 	/*
 	 * Record information about the path so we can resolve later in
 	 * process_entries.
-- 
2.29.1.106.g3ff750dc32.dirty

