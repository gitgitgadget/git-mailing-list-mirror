Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E281AC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0D460E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbhJPJnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244013AbhJPJlz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BB9C061765
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r18so30735450wrg.6
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjnL0ehFdK4CUXwhC4UFwdhLlXhGx5//yFCl6dg/Vso=;
        b=m6KjyTogS1mMB+2ZAdrBr8VAG1Me/TRl1MiKDyysVFL9aF1e0xdktoNSlIz2rssNcd
         zrYSdyv8UFfPLRyP/oOgLOID8vnJ6J8RY4OxShQqlO7/cKZOb+/eYVYFLsWtnqphmrQM
         RguRrBbFuu5+Iuelvo+UHq81vnBafA+wu60QLsNAhOHbeMkXapoO0bL/YFiRKhaOEbc4
         ZAcrUWyUgQZxg2KtSQADTTarU+IjOSzDB5lgIY4wQDpfmIT78/is5zYAjpxmH6VTaChv
         NzxGaSkGmjUrIyOp5JIpL0EYVSJ4cvy5VM4khusErreScHjZIQPQjdGvIoZWrfh8mz10
         aaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjnL0ehFdK4CUXwhC4UFwdhLlXhGx5//yFCl6dg/Vso=;
        b=lq1lwRInk7RyEdjrenhQzSrZkwTbLCr585D2Bl3UlnvifWmDlfn47JndweEpOTESB1
         RQ9wXAECeXxk9yB9NZWGtrcQWNojN79uietIq79UumX11WD2tpL4sUX+IBc1MgJtzH+j
         YUGRHKRfQ6JIQKDXgoR5/qsqjaTVBof5CbI7gs3hwj9oM92u+LnpK58dX5nzPjDzDyXv
         yGV9gBuIWFs1tUyh65fLeMeQstwPcqsd89sQS6bQ47ehbRwdFfhfINlKwPVZ7bvAEEy/
         /JEoOXNTSWN33NalBhnM06Fc2p1s3W6BypdRW/B0ezygdtrrqRZLdMJ78lOTvuw3SIzb
         78lw==
X-Gm-Message-State: AOAM5311YAOJxFjmvVf+FUwgQDIXTcqMLNbACsZ0UevRfckyGUilyveT
        gGlYO6/HMKkhpt3ZpTABbSxB59z1Pv4KHg==
X-Google-Smtp-Source: ABdhPJyRpQopG38K+Iq7J7s9FLHJ77WV8so6L1X1JOxoJbBjH3yYRqwfrd5snuAIehYe9OgyZtc31A==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr20435866wry.12.1634377183664;
        Sat, 16 Oct 2021 02:39:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/21] refs API: make expand_ref() & repo_dwim_log() not set errno
Date:   Sat, 16 Oct 2021 11:39:24 +0200
Message-Id: <patch-v2-18.21-146b030a142-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of these two is rather trivial, and it's easy to see none of
their callers care about errno. So let's move them from
refs_resolve_ref_unsafe() to refs_resolve_ref_unsafe_with_errno(),
these were the last two callers, so we can get rid of that wrapper
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index b563729782b..43fe9e6d89d 100644
--- a/refs.c
+++ b/refs.c
@@ -654,13 +654,16 @@ int expand_ref(struct repository *repo, const char *str, int len,
 		struct object_id oid_from_ref;
 		struct object_id *this_result;
 		int flag;
+		struct ref_store *refs = get_main_ref_store(repo);
+		int ignore_errno;
 
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
-		r = refs_resolve_ref_unsafe(get_main_ref_store(repo),
-					    fullref.buf, RESOLVE_REF_READING,
-					    this_result, &flag);
+		r = refs_werrres_ref_unsafe(refs, fullref.buf,
+					    RESOLVE_REF_READING,
+					    this_result, &flag,
+					    &ignore_errno);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
@@ -689,12 +692,14 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 	for (p = ref_rev_parse_rules; *p; p++) {
 		struct object_id hash;
 		const char *ref, *it;
+		int ignore_errno;
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
-		ref = refs_resolve_ref_unsafe(refs, path.buf,
+		ref = refs_werrres_ref_unsafe(refs, path.buf,
 					      RESOLVE_REF_READING,
-					      oid ? &hash : NULL, NULL);
+					      oid ? &hash : NULL, NULL,
+					      &ignore_errno);
 		if (!ref)
 			continue;
 		if (refs_reflog_exists(refs, path.buf))
-- 
2.33.1.1338.g20da966911a

