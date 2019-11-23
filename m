Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE7FC432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C481D2068F
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6jwMSlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKWT4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 14:56:46 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:41597 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKWT4q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 14:56:46 -0500
Received: by mail-wr1-f54.google.com with SMTP id b18so12654637wrj.8
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 11:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v1KLLP+JgQUt4fGzuGjq2KxrVlKQcOtOSt9f1IFf5y8=;
        b=m6jwMSlRDsXFtifYn8TAqCm388cGvwcz1SQ2gdUw0Lcd2yRGJ5CALeZBKanORMAM9u
         u8R0ZPqhsnbsoYmzqrdItwGlaWZztswdHJ6LtyvVeAuukJcjCZZ6zT1OzTmA6YxgQ2mW
         C3NsYRlrgWjWHQL/d0S4HUDt0XnDPavyvholl9mPka51DUoP/CrZdFEyeXk/VCgUVBD9
         DD2GLsLBc4TgQkVvU2yI3GXmCzv1g8TFeSiJOAqhwbLgygfkSV8DS9/I+51cVgFKRoso
         SJKd6alNigrLjo6wSIqOaXbsPP1sK5dw4SoibZlKgvqy78Ns3/TEEsJgw0NAaorPP97G
         ++Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v1KLLP+JgQUt4fGzuGjq2KxrVlKQcOtOSt9f1IFf5y8=;
        b=tw2kyBeDhc3MRFYvdqzeFp8vrdx6w/krEN7aOVLRoyUhdLlb4yjN3suEwZB4wytSKL
         +awA334Ew6J352FFORcZJ8cYGalEXu807KyeD/IO/WlM/nM9H4AF9lwBi1385Iph4kSW
         fJu8sZvHJRK9GWuJF3m9hx89FHmFtwGOECZJJ0EHG1dUXtxeNEIecH+8+5k82Ca76zRa
         WLtI2zy5uzFs+wV/KWKPrEg7gcj1lUHy/6P3DFDI+9KaBfECnar4qm6m7JvGCEoEa2x2
         IfuMM5RO4BV8Zm+nIr9FZ2KzdMsC53qwLY6yXvUY9scaQvwHUwHI3xbBeKS8URbDC21p
         7G/g==
X-Gm-Message-State: APjAAAUC7CWIWSNxP9B2iiNMrdl7ezDJ6YOjjToDmAHzXjS7FiF+ZINR
        493N1mnobNkrMVHjZBBAKNisZi1u
X-Google-Smtp-Source: APXvYqw9Z9eRz7bpRHpmseT4oDOawPEoWAjaNKfZJv1XoUlozoFK/MJrSDVtyFQq4LRzW5xEg5okWg==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr14759380wrm.4.1574539002934;
        Sat, 23 Nov 2019 11:56:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm3335793wrt.13.2019.11.23.11.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 11:56:42 -0800 (PST)
Message-Id: <68f3be6ca65b3904bd4664b743fccbe1ac4e7d22.1574539001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.475.git.1574539001.gitgitgadget@gmail.com>
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
From:   "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 19:56:40 +0000
Subject: [PATCH 1/1] add--interactive: skip index refresh in reset patch mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nika Layzell <nika@thelayzells.com>,
        Junio C Hamano <gitster@pobox.com>,
        Nika Layzell <nika@thelayzells.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nika Layzell <nika@thelayzells.com>

Uses the FILTER flag on patch flavours in git-add--interactive to
determine if the initial index refresh call is required. It is not
required for the reset patch modes, which use the 'index-only' filter,
as they do not interact with the worktree, so do not need up-to-date
stat information.

The refresh call can be quite expensive, especially on larger
checkouts or with a freshly created index file.

Signed-off-by: Nika Layzell <nika@thelayzells.com>
---
 git-add--interactive.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c20ae9e210..cd435b197f 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1861,7 +1861,9 @@ sub main_loop {
 }
 
 process_args();
-refresh();
+if ($patch_mode_flavour{FILTER} ne 'index-only') {
+	refresh();
+}
 if ($patch_mode_only) {
 	patch_update_cmd();
 }
-- 
gitgitgadget
