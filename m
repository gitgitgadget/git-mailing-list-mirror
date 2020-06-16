Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83895C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5964A20776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE/Koc8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgFPTUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgFPTUu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C21C06174E
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f185so4249855wmf.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sD08nvPKEureMPWUl3ZPXZUlGgVzCFnRDJ8XWySzO9I=;
        b=OE/Koc8+/GAdDAOGbz+vWKQNawEIIaxyp4iLCPg8X1TdMKdoQs05KTnP1WLnJSSjWt
         0BTrKS1boQnP/rQt3iWQlJQVjiNI3dK1Zu0+4jChHwNu0aCEsfz8ANMncHVXFHc4oVwz
         Df3ua020t4UsS6S4h6EVn48YTjYL9k34/BqZODi7UO9FYL9da+Ffh5s/FHy877Ymgmjd
         ncCduSE4fRlP1SA+CAoMPXpn+/D8TWcChxSrKcikGm/zWWvTCjvT6e1Flmxw7josjc0o
         7gqEyGvlsn+NS2RHP34SaeWt24HeGegon2N5O4XEdujyLqdtKMRGn9Fwj7XcGRs9CH/2
         dvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sD08nvPKEureMPWUl3ZPXZUlGgVzCFnRDJ8XWySzO9I=;
        b=FyQDUEu7S8/We/2dJXCv4kuHmmrWi0cGNz5AKK3APHypRV2MpgGXZpdXa1/X13JXbs
         Fn1JvhBugJBJZxK0H/ppglLJQ64pqv7WfeQZpHtPxbJHDTeWMuO1OIFmoLkZlrYxDK9m
         f31B2+Vk2uGLcHwpI79QVZds3jVodPiZb+j2Ly7GvBaZMzFS1e4lsYzdRJEb09SlJRch
         oq1z1vQLo/eRLfjmYkZ6msPnv94RKzKa7L23tJWaOcJZFpEYlNxFyJgSD1wb4Rpuju4m
         bY18nHwn7yeRaYp4WVvlSmT3QvoW0BAIru9h82rySL7nat6FimLlYtNtoXrF2N9HyLKJ
         CJQg==
X-Gm-Message-State: AOAM532nOGK9AepVzurfzAi5hrwLdPaob2Ski4xwwmJk2B26LL3DwTwO
        ShJWR293B3CBmw4x7qCEyrh7ZFGp
X-Google-Smtp-Source: ABdhPJzAsA0qtMxQ7ZqVa90dYMmusvHJi/ioBocN6c8LpD9UZ4VEdgxqghv3eoNH+A5pivpjNqGyqg==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr4643181wmc.134.1592335248171;
        Tue, 16 Jun 2020 12:20:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w14sm3137284wrt.55.2020.06.16.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:47 -0700 (PDT)
Message-Id: <1f8865f4b3ee35e375a9cf68a8a7a858e9a4908a.1592335242.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:29 +0000
Subject: [PATCH v17 04/17] Make refs_ref_exists public
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c | 2 +-
 refs.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 12908066b13..812fee47108 100644
--- a/refs.c
+++ b/refs.c
@@ -311,7 +311,7 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
-static int refs_ref_exists(struct ref_store *refs, const char *refname)
+int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
 }
diff --git a/refs.h b/refs.h
index 4dad8f24914..7aaa1226551 100644
--- a/refs.h
+++ b/refs.h
@@ -105,6 +105,8 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  const struct string_list *skip,
 				  struct strbuf *err);
 
+int refs_ref_exists(struct ref_store *refs, const char *refname);
+
 int ref_exists(const char *refname);
 
 int should_autocreate_reflog(const char *refname);
-- 
gitgitgadget

