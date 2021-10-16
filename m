Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455A2C433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271AE60E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbhJPJmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243957AbhJPJlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33921C0613F0
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g2so4274904wme.4
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+/GYTZZy8e5Kz/F593qTISxA5IriUQJ0TZs3Z7GU3w=;
        b=pPIuA0ZgEnNNoVvPmOv8E8bYcY1S1nITu3u3CMMySWGV/6I4UTrVuUZF/ik7AEsjsF
         SWmhV3XlINADn6CAk2bVM6uGMyCiCTKNwFz42TeX+GFpNXIRupQ7Hsi7cXyr7MgO0oaA
         5IwKULhNBPdbpOV/cd/DV4fAG7xgkGDbBEWc960a1jpoy098Qn4RbKvGJI0szmyo1Svo
         bKKsXDBXpCwDmRAO5+hInphUDwoNum+DnJ4xhkGFHDdpyANWxcXwa8kRABIm/8PfZ165
         RcPvqk11siQr85fsosk0lHQZaA+IbWXNdf9c2cp6Ko48edsFRofTmQ7C2hb7WNnlpD7/
         LAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+/GYTZZy8e5Kz/F593qTISxA5IriUQJ0TZs3Z7GU3w=;
        b=moGsTYzhfboBkLvt5fnqz+WzUlao36/RfBJrYRT0j4wKCfEfZ9uZQS3NMoJuc+hi6t
         IxRMQEpOPoe7FgwgU4N4ThHE53VpK+0V/iQ43sVLbiYmNr8I6kuGsjILQVr1P5s+f1tC
         rPllxtPGTmMIiv5HBU2FLh+ZxbfhFDB9aWIj4Q85CkDPbHt90dtQePjCWDlLkud7ZWwF
         imTBGG1xvjR1IZU2DdyhYCOhtD2lKCSl8oR51F6WS+vQzruw9NJ5SlWsotF0PAA9uPDC
         J14/Uw3Vt7UDeKZDwNA7XXmhJuoDRo+wcvBObKkclzOxgIq5H9aFdoi3zgXNgfjZ648N
         7nTw==
X-Gm-Message-State: AOAM533jTjJHhHf7PHWx6QT1OeE+ctcf+i6Ex9urEYnaieQLp9nL+wXX
        3i+JNesqAYslUa6hWMXukaF3pNi7n4sSPg==
X-Google-Smtp-Source: ABdhPJyV2vD/qv0qaNbuwOljb6T7tvbbGyCBhJ8naIgL36C4+nYdZe9o7orZn69y0ixSeiVRfyS1KQ==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr31921385wmc.126.1634377177604;
        Sat, 16 Oct 2021 02:39:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/21] refs API: make loose_fill_ref_dir() not set errno
Date:   Sat, 16 Oct 2021 11:39:16 +0200
Message-Id: <patch-v2-10.21-c99c59dcc57-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the refs_resolve_ref_unsafe() invoked in loose_fill_ref_dir()
to a form that ignores errno. The only eventual caller of this
function is create_ref_cache(), whose callers in turn don't have their
failure depend on any errno set here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 482d04de03a..759c21e88ae 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -280,10 +280,11 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len));
 		} else {
-			if (!refs_resolve_ref_unsafe(&refs->base,
+			int ignore_errno;
+			if (!refs_werrres_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
-						     &oid, &flag)) {
+						     &oid, &flag, &ignore_errno)) {
 				oidclr(&oid);
 				flag |= REF_ISBROKEN;
 			} else if (is_null_oid(&oid)) {
-- 
2.33.1.1338.g20da966911a

