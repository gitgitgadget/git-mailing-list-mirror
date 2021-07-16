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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5D5C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271E0613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbhGPOQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbhGPOQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060DCC061765
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so6984125wmf.5
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W4Xp1UVRShn6koTEGWpMy5JtQaqU8qxbSaIq2rqI3Xc=;
        b=je92ROuT3Ftfa4NFfEZo/x5zm11MXcH5lZwOD01bPUlwkmekJnkHEJ53t1zhpO8wZF
         RYhfPGDvBj1OVGvQoFOhSyRw9GVS+uMVcBmmZfgNX4cguE33i8zSBGviBR2LXhfDOxHH
         Bl/vTnBq6h+4xkEp235gY4UWUBrARS9v0mSh46svI++60/MIVslkbloWPh66sgmFbjY7
         zqv5KSAOIc/cGDnyP6YlvV8oASKhPcEgsUQqBSchtT/X8MAfX5knNuioK1lJh5zAK6ph
         r7SZgz2p54+IGtsbdRwDAqSINo1t5Ur0kta3FinA+KbuiNQaMrMHVnvem9nLpf+kL4Gf
         0DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W4Xp1UVRShn6koTEGWpMy5JtQaqU8qxbSaIq2rqI3Xc=;
        b=OlLj6kapfvlje1brLwOjIJqcLW5eRXWafAlvvlwBHb6Y5lgdWZya87WWM/Dn5L7oWm
         +sERpvArd5B6E/lsN6WW7pN31nZOg9PyV7NenG+zuY3+OCByJx0H81BmgMi8FvzxG+cz
         fGEBDAfVmmZlrkV0nZnh/sSvu6FeoqTGtdWpinCCtj30aILc21VVU8334f+UJiL89vO3
         TgvgRdOS8jM9wDD3BCYeNNpF9jZpb5q6GZYDG2zG0NFZTJ5JGlZILshlfdonY6yNdPZj
         5xJzkfrs2YyRzb55Z549dTVqKxeKnIntC6Nwdn7/tSAPWHzbuisglKAey+Z9S6J0Ri5r
         zqlw==
X-Gm-Message-State: AOAM530W0AAMbB7yZ7ycPK4xTQ003utrZnjIy2TOubv5/GXPDSA233MN
        RhEp5gjXeqk7tBbntvv/1R2dEVBgMNXbwQ==
X-Google-Smtp-Source: ABdhPJwnN1LVaUWBeFB9VdJgOVmrg35MfW91QOd4bg6fWf45cX2UWV98GyS5cfSov7wxSAQn4XN/2w==
X-Received: by 2002:a1c:38c7:: with SMTP id f190mr17120325wma.29.1626444802369;
        Fri, 16 Jul 2021 07:13:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/11] refs: make repo_dwim_log() accept a NULL oid
Date:   Fri, 16 Jul 2021 16:13:03 +0200
Message-Id: <patch-07.11-0fff2d32cfc-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
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
index 8c9490235ea..5e2330bf78e 100644
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
2.32.0.873.gb6f2f696497

