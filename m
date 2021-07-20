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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A60C636CA
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B10A61186
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbhGTJtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DACEC0613BD
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f10-20020a05600c4e8ab029023e8d74d693so1716384wmq.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IM+n33hI6Lqx7U/j+V12GnoODEmZo1L/cn2BWi4aFoA=;
        b=e4HwgtYRvoWMwxR2Ft+c1G56W1T2KAz4gnwIwttOpn4RTdqNNr2XcI4Bp4v0g9Jfo/
         CsMcDX/eOgA8gxmGjjRsedT6VLBcsftqXjoMwASUW03UonetXA7/m2bibPNRTRE/ilLY
         U4qffWJ29HrPF8MMgbabAoRFJwBKo28+lvYnrcAvdkO5zRsqHcqibM++lQ788Yunn42P
         A8Zi2wtV29Hb2lij179G3kvaMbt8N/vevmkVYWezDSz99Vzb7R9aNm9WyUVbVV16AHJX
         qDxmc+Zm5Rhpy0YV4ey9iE2FwSvkW+OTIyLoPYTYWrwMYQtli2z1iWxDOQ60xQWWau7r
         huog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IM+n33hI6Lqx7U/j+V12GnoODEmZo1L/cn2BWi4aFoA=;
        b=rY4nOCadIcafT9HQc6oBxenzw6GY9nENZQaCT0bBijDO91tOYbkmjEW2PExpGC+RvI
         bRdAx2KvC/i2thBujT+Q3Ww286CYDCVmpHQyg30TQVxL+ycb4kDytTLCpJBRG2OqPqCa
         uACTceDpAFUk4ohcVmDeC+aGrWNp+DnflhXVC6KjfKtP8iRTfL/But2HZb7asi8dcOKe
         v4zDQ1TGG04mUYBCv9ubOquJN2OOk4Wg7yrLqmHH0NSv8NFxL26ufP17PkMCU/OJNfyN
         n5vjADZvsdsn/molEmOcUb5lFdi3J2BDOotI7QIV4HXblJvQQxbG09yE7hQQw2O/kaOc
         zGkA==
X-Gm-Message-State: AOAM530SOG/iJnXiIab2+egq66KT78MYMn9ZUO4VtHjPJemr5fzDB+af
        ii48Q6Zjsc4hcCItYxqliwTkgx1sUxvafw==
X-Google-Smtp-Source: ABdhPJwNBtHyYiLIl6PqI+TtWdMnmCP9WLTU0ps2VsA6+NUMzAFLEFCFWFfbp99d3drZj5j6iC61Vg==
X-Received: by 2002:a7b:c385:: with SMTP id s5mr30049740wmj.43.1626776668409;
        Tue, 20 Jul 2021 03:24:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/12] refs: make repo_dwim_log() accept a NULL oid
Date:   Tue, 20 Jul 2021 12:24:12 +0200
Message-Id: <patch-07.12-e45ec439db0-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the repo_dwim_log() function initially added as dwim_log() in
eb3a48221fd (log --reflog: use dwim_log, 2007-02-09) to accept a NULL
oid parameter. The refs_resolve_ref_unsafe() function it invokes
already deals with it, but it didn't.

This allows for a bit more clarity in a reflog-walk.c codepath added
in f2eba66d4d1 (Enable HEAD@{...} and make it independent from the
current branch, 2007-02-03). We'll shortly use this in
builtin/reflog.c as well.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reflog-walk.c | 3 +--
 refs.c        | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index e9cd3283694..8ac4b284b6b 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -158,10 +158,9 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		}
 		reflogs = read_complete_reflog(branch);
 		if (!reflogs || reflogs->nr == 0) {
-			struct object_id oid;
 			char *b;
 			int ret = dwim_log(branch, strlen(branch),
-					   &oid, &b);
+					   NULL, &b);
 			if (ret > 1)
 				free(b);
 			else if (ret == 1) {
diff --git a/refs.c b/refs.c
index 8b9f7c3a80a..d9635436759 100644
--- a/refs.c
+++ b/refs.c
@@ -698,7 +698,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 		strbuf_addf(&path, *p, len, str);
 		ref = refs_resolve_ref_unsafe(refs, path.buf,
 					      RESOLVE_REF_READING,
-					      &hash, NULL);
+					      oid ? &hash : NULL, NULL);
 		if (!ref)
 			continue;
 		if (refs_reflog_exists(refs, path.buf))
@@ -710,7 +710,8 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 			continue;
 		if (!logs_found++) {
 			*log = xstrdup(it);
-			oidcpy(oid, &hash);
+			if (oid)
+				oidcpy(oid, &hash);
 		}
 		if (!warn_ambiguous_refs)
 			break;
-- 
2.32.0.874.ge7a9d58bfcf

