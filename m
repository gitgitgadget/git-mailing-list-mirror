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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946DEC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 777D9613F8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbhGPOQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbhGPOQO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6527C061760
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a13so12243716wrf.10
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJfrIJsyA3bFsHjP3U0w6NL9COiXZQDKDriUDYudU5U=;
        b=ksGXCGY5FjTCeBwpQsqYXebuGfkMaljLWQwHf+UnHUFChcY7agZMoOsNp7X8tFOi+e
         sGgAI1Xt1UoJHhSElo/jWEq9w5HfE/Y944bVksjEduc4G15XFvFERqVdRJJZLfMqMPX7
         m8O+C3WOFLGbtzlZp/fIpE5BO/s/cUn22hbx2+Qseg+uCYqyDZsTaGsG4A+Hn1A/5wEU
         rKa/2fNheVytcrlpN87eyMAWdg3AWsqHzpCZtO1bhE1VYFeCjs9sHYPWvig+jwMJIcoI
         kpkMUzybZZwwMMrLMLkgocJEAfGXaMo/XYmu8bewFVSfKB2twhMFkY291YnCGtvaHOuJ
         KaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJfrIJsyA3bFsHjP3U0w6NL9COiXZQDKDriUDYudU5U=;
        b=L0ijveIMuPnyiuYPsNSbHSibCxq1I1qiNJEBiCzHGxXQ6IYoRDCJMHUFzg0FSW+DXz
         tig9UOqeDZUAhlOtian8su2TEv7Fn8+WP9JaeTg/cpb0rjU7ue3bzZ4u6Rd3ruWXlhjg
         GOCtHQHqcf19OvCtgr/wuLiABGGrM3U3KgRt2chUuV4GzNEh3O6D6ct91uMtTDjxFKT6
         F6MGZAv6UNPhNaAHYayoqIl+YnJtzwNBVUi1BNQan+SJynRbmTeZO6GALffm21wRTVF0
         4V3BOKPSqNgIifH+y09a6Qb1SIKGkcBq+YceIyUX2Hw5ZRiJNr0EUP9PtvJ2BHUGheiZ
         4N6g==
X-Gm-Message-State: AOAM531fPRINXiABXPjm5W2UmjA/5kdYDEPGGw9CuMkrS+DKiIer3lDZ
        THUBBuO+oJ1sqyORzjDY2xeBOhrkY4U=
X-Google-Smtp-Source: ABdhPJxynrAiMf8Jl4pjwupyxi6y7KIORpuHNvEvmGIFEZA7ZAdoEFyth/o3moqLiS+r+2KtAYgiFA==
X-Received: by 2002:a05:6000:1c4:: with SMTP id t4mr12759601wrx.181.1626444797079;
        Fri, 16 Jul 2021 07:13:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/11] refs/packet: add missing BUG() invocations to reflog callbacks
Date:   Fri, 16 Jul 2021 16:12:57 +0200
Message-Id: <patch-01.11-30bd7679a5c-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e0cc8ac8202 (packed_ref_store: make class into a subclass of
`ref_store`, 2017-06-23) a die() was added to packed_create_reflog(),
but not to any of the other reflog callbacks, let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/packed-backend.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index dfecdbc1db6..53d1ec27b60 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1600,6 +1600,7 @@ static int packed_for_each_reflog_ent(struct ref_store *ref_store,
 				      const char *refname,
 				      each_reflog_ent_fn fn, void *cb_data)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
@@ -1608,12 +1609,14 @@ static int packed_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 					      each_reflog_ent_fn fn,
 					      void *cb_data)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
 static int packed_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
@@ -1627,6 +1630,7 @@ static int packed_create_reflog(struct ref_store *ref_store,
 static int packed_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
@@ -1638,6 +1642,7 @@ static int packed_reflog_expire(struct ref_store *ref_store,
 				reflog_expiry_cleanup_fn cleanup_fn,
 				void *policy_cb_data)
 {
+	BUG("packed reference store does not support reflogs");
 	return 0;
 }
 
-- 
2.32.0.873.gb6f2f696497

