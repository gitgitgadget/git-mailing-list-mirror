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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD6C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5FF60FD8
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344528AbhERGUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 02:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhERGUR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 02:20:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C320C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 23:19:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id e19so6654970pfv.3
        for <git@vger.kernel.org>; Mon, 17 May 2021 23:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IuaeRjLJlsHpAxX7mDfyDqAG/Yyhg7yOvqWJL5TIT7o=;
        b=b4xzWqfk7FmIm7jNo7C/Ui/c6kpZwV3rJsh/4alIwWMyrq4GC+fA0k1Lw7heFYbulr
         M4lvkubaDT3M8VAtx31qaFD08GlUipRjUl1/FuXZAw8yC2QRiSVDgiQgOoJ7oPCzVGzP
         1aRPZB004sGJWyiAVIaxDgXhCWcUm5tRH9BkviPXLfkedUvSmStPBhzOloGA09IiaySR
         rT/snD9M4S67Z+BNLA8siL2V6j2WHo47aezeg5RBIzBilqseUzoQoNUDvTNrrGkFP1jm
         2yEdsmBPJxjGW0VnHAc4QdUW9PXIcLz2oFZIFvkSnc085rMd9+MCHQvJFuzCsPy3Nwhb
         D/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IuaeRjLJlsHpAxX7mDfyDqAG/Yyhg7yOvqWJL5TIT7o=;
        b=fFDmJEE0z4oJSOf7T3m172ROJzdIfDLOarGD3ZgFWawD7a9pB/tjN8jQCc9jQbOvwr
         co5Hwu0xZHGjwEQs4WKw54v750OiDN8tHorry1zAJxvMzKsLoS9O8N5x3tB04O4nimHF
         Gfxilq+gFG62v2OwZPEhiUEwJxvkvdVfsyhtedvyx2k9HBl6V9bOHRRJh7nuMaEV6H/f
         nfCEjCgDnh+ZA4pNQm4H9g4kOeRh6NFcEUKiU5ajVmtEGjj5dVlXkp/biRTNydmSd2Yw
         BmQZaJHzOGTK/bJalv4kUS+PM2BiwF5byZJ+aATy25IJb+bIzFuk5PkL6gXOCi0y83r+
         Pd8w==
X-Gm-Message-State: AOAM532mdK9jCb/JtMh6efyEpNH0pQFUaCSYNUWTd+fjTkKkAi4JwD1j
        PqwZXXYS8mabYemxevD6PptCA5fuoFo=
X-Google-Smtp-Source: ABdhPJwPhggXKfqjgS8YkJ1Iso98C1gLzY/4AyVnyxDSD6dddfiuA2S+a8cp6SD3c3szLJywTcARXg==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr3472002pgs.206.1621318739672;
        Mon, 17 May 2021 23:18:59 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id k14sm2944289pfu.80.2021.05.17.23.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 23:18:59 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] fetch: improve grammar of "shallow roots" message
Date:   Tue, 18 May 2021 00:18:55 -0600
Message-Id: <20210518061855.57478-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 97c4fe6e6d..c19a041526 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1123,7 +1123,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 
 			if (rm->status == REF_STATUS_REJECT_SHALLOW) {
 				if (want_status == FETCH_HEAD_MERGE)
-					warning(_("reject %s because shallow roots are not allowed to be updated"),
+					warning(_("rejected %s because shallow roots are not allowed to be updated"),
 						rm->peer_ref ? rm->peer_ref->name : rm->name);
 				continue;
 			}
-- 
2.31.1

