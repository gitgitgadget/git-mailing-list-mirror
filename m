Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257FAC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3A261361
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhHWLhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbhHWLhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A119C061796
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o15so10301139wmr.3
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tW26Fcp2CGQ4f1SMeqyp+VsGDGG5nOLyFn6hYbLR0eo=;
        b=p2VwxYt7Ogs13/9kfuW6qoTQPvmrL64PXbiGwO5svFpBlwIS5WUMKSoZo2ZseTgFUw
         9Kt+y5FXmlFAXFuU+2WYij49wy9Zf6uRNSfayx1Ofeh5QtxsLQjBK8U8BYgLqUogsOwY
         9zzHSMYskjIehD2fn3bTK97zmICF/s/TN36Fdz3lm8YPnv+zB27WIafDJLlAXShjwBxW
         CCAX5NhzJwNPVw7Azf6OuYCYv+jyi9NQhQD9lAeLcu9kcQtCmbkCtBCvaMZ9vATqInKC
         2fejfCWk/3OoP+ch49/vlPC5Q1RVtDUKr+XiFK2hLhIHroHLaTt4uB8gLFoqJdpcQhGX
         PxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tW26Fcp2CGQ4f1SMeqyp+VsGDGG5nOLyFn6hYbLR0eo=;
        b=OK8FwXYLq1vPhZaews260/njMPWUAsKvfFD8C0hbzc5E7olVNInGeRmtJvYrIc9ybN
         3uo3h91xZlw+H1N6grC3VwDhDbBPyP63vEQq4SIZ17OueUYn2uS6OFbByWze+6fIOm0B
         j+VQFivwU0iwuscVuehNXESnWelSVmEPx6FEE2ZjgfvGdkgC94yCXjbw46PCPdEIa64Z
         ZTZuiFT7cxIThwyo8/VUK2+jyPcrIWs8hnpTLlvXB95IKAM3dU8sNSTe31aXZBgbnmvk
         1/9UupW0ndK2GHn+Kwwq2RuxhbpOfxEHVLTqLVuc1y8tAQ8HTKoEFcSaa5gFlHRzTXMt
         CUuA==
X-Gm-Message-State: AOAM533c/5lW6NiGeeuqHWz5zAHTfMMlqCAJ/FecmQatpsfb8+yRrctQ
        TUSyCYZlSAIOdpz+Vv6O4txFQz5ijUoky7Fp
X-Google-Smtp-Source: ABdhPJzb/3adTYqWNNzB0A1yR4MPzPBjYFj3LOfhMZBrbMdJ4MpH2C8YvnPRpkIHXStBwfDwVwFVTQ==
X-Received: by 2002:a05:600c:26c4:: with SMTP id 4mr4938597wmv.111.1629718582712;
        Mon, 23 Aug 2021 04:36:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/13] refs: make repo_dwim_log() accept a NULL oid
Date:   Mon, 23 Aug 2021 13:36:08 +0200
Message-Id: <patch-v5-07.13-3b7daf03e5a-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
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
2.33.0.662.g438caf9576d

