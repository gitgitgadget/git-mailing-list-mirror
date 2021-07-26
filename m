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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D3C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C57600CD
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbhGZXEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbhGZXEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E207FC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n12so9444898wrr.2
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QM0y+WMxfpMN5yNQhUpWsSMS/xysQ3vVWVghsn2/Zv8=;
        b=SD/jmBe/62znWyBTsZrmVfjjhJZWB2/jvJ1+3EDp2JAiXoOSkeshT2U7Timn12Hz4u
         TddRwyvt/8gpjcuEZs2oFdryvdnKnrGKIdVXAFy/B6xXd2qDl3wJ/7hXEQ0wKmPHFOaO
         xq3Zbwz/WNtncO80MJg2RfQEGD61eE8U8quiKBYLSrwr8mI9appZ3w45Nnc5Y878HDiA
         oQGseP2MeJrfbMdRMF5+Yuy3MJA+/aC8R86XCFR++J7m9cJxk4pLh2gcfp4t+j7Cwb5D
         61C2Rh93YNs5n1huhX9a/E/jXYTkDTMnQ/jdNs8jToJeDVIdEwKWd0mZUMXqAHFpvoHF
         exmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QM0y+WMxfpMN5yNQhUpWsSMS/xysQ3vVWVghsn2/Zv8=;
        b=nFQ//+hg7xB1u1qtVlhIWPRa0OYlPfyzU55YoBrx3wm7Q+A466X3E6tyenza/m+y+U
         1dcdWQHUOv5Mlt8d88gSGAjRCqwxtwjgcqTwarXQgzIHFtKJYMd+rGzAAXS7YarDLS//
         hS/nqe9lJH/bSyCxbyxUSJVPzXiKwygXQne4oxM/qTkboMw9qXcbKaHGTHR1MdLulpno
         +frqriKvq13qNcyKd9a1ZzZ++7fB14CDmorq9fJ78KdJeBisDYmRkV55jpkDOhvxn3BW
         U9zY2hDkhKIvFf5Cn3BhLQStQ82MxTw+bQqXtp008naC+Oa9djT18XaqUL0gmXzakpJc
         NaNQ==
X-Gm-Message-State: AOAM532Af93ihtleyUjYWQTGw/MURzZMmh50LmqJHQQXXkP7V48C6sbT
        qYRdIBmJRrQ3fRSFtYCIme458ECnFz0yDw==
X-Google-Smtp-Source: ABdhPJx8oQwZcK8PfDY+d6sRzpLpQIOPWIvdnxbnN/p10gY+qu0SLYPzIgMousDQn97os0F4lCeZyw==
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr21636350wrx.271.1627343075297;
        Mon, 26 Jul 2021 16:44:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 06/11] refs: make repo_dwim_log() accept a NULL oid
Date:   Tue, 27 Jul 2021 01:44:22 +0200
Message-Id: <patch-06.11-b75e7673d7-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
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
index e9cd328369..8ac4b284b6 100644
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
index 8b9f7c3a80..d963543675 100644
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
2.32.0.956.g6b0c84ceda8

