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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC8EC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB4E661178
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhGKQdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhGKQdn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57275C061793
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f9so15458969wrq.11
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJHfKOKPqgfi4LZvpQMrDOShrxS8fJLbsRy+4PtGM8Y=;
        b=dOIaC3Fl9CLEklx5ePTl09nAaTmC8GK3iuIjXZSF5ppz6lY10q/UJGkJO+omxScCKR
         l8KEMqHUqcX2ctOUfAiRL4k00JiUFpJH1D244UiepSTdMgRqjA3QRui5nrQ6FBFKahQ4
         i9J/Ne4MFIWbAf9LRBxT+rYkCJb4BCZ/AR4H6plV6Sg9yvMpszLgbmvRtYb5eeqFU0lG
         To4wgSRHdES+ljIXJYyOI2cc3wc+9kDNoWLmwBkBEBCc/FeahXUsRDl4ngJy1FjTYS+U
         e0k1Xxxt9cmKgqkd0EdayEoNiwuu4SHeqvQcZRN+/AVJN4T7CMy8jck/shFNRPY/HnJI
         qTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJHfKOKPqgfi4LZvpQMrDOShrxS8fJLbsRy+4PtGM8Y=;
        b=QQjFZ4cAJb3dJqX0cRTaZB81TlzOTHLWeD4O9PEaUJdrSH1OYkGpKL+RuwvMPuWnw1
         AlEOfLEy1MQQQ+4jzfmZ8U/+VpsXbeMjWj05nMC/4ZiIpFT4PTf1RpKGpMMn00JwY72S
         AV4ZJ/P6mjjecKfGIMzeVLIqefnc2KZB5rF80aKQdG/aw4tRU3BQvun1LU6AzaQ5qri9
         1EKplNMFKkglzuhZsJQp7fWlIQey6YCqZM1MM3WkPK4aFL51MWddWPr6HVqkvZYFOp29
         68TsgzooBxHEc15XgWXOan8DzEPo8TGLDLVdq/4a+R93MhtwwKfqFUBDgMXJn2AtUSYz
         fpuw==
X-Gm-Message-State: AOAM533Z0AHen5eqaf4zfG5GoeXIJFPftflbGx37IzEdhayWXfWNK7vK
        V8GRBRWCa9dqCjGusGVzmRmTf2JyoJPyAA==
X-Google-Smtp-Source: ABdhPJyE5rYmv/eUbH10n5y/T/Y4woJkmxr//wfLmcHaBha1an8X4ghEjQf2coKTxMjZxbIiCCi1MA==
X-Received: by 2002:a5d:4a0f:: with SMTP id m15mr15856220wrq.350.1626021054797;
        Sun, 11 Jul 2021 09:30:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 11/17] refs API: make resolve_gitlink_ref() not set errno
Date:   Sun, 11 Jul 2021 18:30:35 +0200
Message-Id: <patch-11.17-a359d1533bd-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have carefully read the upstream callers of resolve_gitlink_ref()
and determined that they don't care about errno. So let's move away
from the errno-setting refs_resolve_ref_unsafe() wrapper to
refs_resolve_ref_unsafe_with_errno(), and explicitly ignore the errno
it sets for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 91320f092fb..7a9cdb1d720 100644
--- a/refs.c
+++ b/refs.c
@@ -1814,14 +1814,15 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 {
 	struct ref_store *refs;
 	int flags;
+	int ignore_errno;
 
 	refs = get_submodule_ref_store(submodule);
 
 	if (!refs)
 		return -1;
 
-	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
-	    is_null_oid(oid))
+	if (!refs_resolve_ref_unsafe_with_errno(refs, refname, 0, oid, &flags,
+		    &ignore_errno) || is_null_oid(oid))
 		return -1;
 	return 0;
 }
-- 
2.32.0-dev

