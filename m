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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33797C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 06:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2265206E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 06:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbhALGPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 01:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbhALGPH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 01:15:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A70C061575
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 22:14:27 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so839340plp.8
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 22:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pe4Hl/WgKhqKdP1yprSiJGRVru0YUMrTUfk2CpvK7iM=;
        b=EJWjhEi5Rh2cEjEjcq/95SO7JNZWJ9Ay99EC+p+dPbtbx7lWE3J0HRyQlXpGGs0FL0
         MPiGAQYSOEmqaeC+XEQldIwrwX+kcKFyLDoFsl20ftAWtmIcaczR9HJPX4TCMA3NDbnG
         S7RYqJqxbpe1CIzIyu7jXgioNhMntHC8ZWIclgBAL0mbybQajDc2WUODe8ZaYhcc20Uc
         ySDgimJOFA1JNBguM5A11ggDqKJKH4a7c0uAwT9sdqQUXNT0UJMQII6mRBbA49ttho3/
         QNNJDB1pwOvU7h+mgoj8bPfbYF8EJ/xUaP8QoThUhYN5eI92mAgSXOhZzVcH4g/7RO3/
         6cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pe4Hl/WgKhqKdP1yprSiJGRVru0YUMrTUfk2CpvK7iM=;
        b=aE34W1e1ey11baVRlwOLlz9+YKB1GmwQILOJz/EyKBiLmLR8QZZ4o39JkLnXzD1ECI
         cuEI8RZ79UaFRqYTUVT6+7AJr/wvd+RQO2LegARnH2XneDRsrgRgksL7FH+fZ4vZNk5a
         l1d9aJva68TuiAow2gyNzBVRjP3WfAblMzuUUr+tMylXID9hjm00Z+Tnf49gTZTkOsAT
         JXU4w2Ko5OCtW+sZsKUdA770SArxdcxs2NDBA9ypAzQpfd4VtnZGgyAyDs5hMG++rsmg
         h6nxZXomt/1QF7kqlc5firY6+nyY1q7RZXo50d3xfpzrg7yLkRajG6IGv7jKj9El0NKP
         eriQ==
X-Gm-Message-State: AOAM530aOVPzCaTwD+hPbfBQ7U73aWKGhS1CVvgbCvnQxFipIL5zRPVE
        nnMj9CiWT2gHIylMzFFLxVbtWA+es44=
X-Google-Smtp-Source: ABdhPJxsDw4EylaCus8XNMCDfnADTmWcPlr98BhSVb54Z4wu724HHVm7YrVetStO+uQfZRQZjy0zVQ==
X-Received: by 2002:a17:90b:1202:: with SMTP id gl2mr2886650pjb.123.1610432066903;
        Mon, 11 Jan 2021 22:14:26 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id t23sm1724496pfc.0.2021.01.11.22.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 22:14:25 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: [PATCH v3] fixup! refs: allow @{n} to work with n-sized reflog
Date:   Mon, 11 Jan 2021 22:14:14 -0800
Message-Id: <d51c9ccca7c58524d5c735c596c142583029a36c.1610432037.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
In-Reply-To: <X/tkFuESnia/n35e@ruderich.org>
References: <X/tkFuESnia/n35e@ruderich.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e70dcd33f7..03968ad787 100644
--- a/refs.c
+++ b/refs.c
@@ -906,7 +906,7 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 	cb->date = timestamp;
 
 	/*
-	 * It is not possible for cb->cnt == 0 on the first itertion because
+	 * It is not possible for cb->cnt == 0 on the first iteration because
 	 * that special case is handled in read_ref_at().
 	 */
 	if (cb->cnt > 0)
-- 
2.30.0.284.gd98b1dd5ea

