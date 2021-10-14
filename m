Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E8CC433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795FE6113B
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJNAJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhJNAJD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:09:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD49FC061762
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i12so13777594wrb.7
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w4OKEV8dT7MqqU1hQfaaJEcFIsFEHQYaLHN78Ea6SQo=;
        b=MO0k89Rgfv6Z3WWVSUgNPIq0la9VmdLhqmVbe5jGBCmJnKOq/hyEvLpiJX6CqP/gVl
         2KRlmavAiizQ1XVdQuEuZqTW1G6NEiUJ71Somjwui12leULeMeiHahkKobUQZXPKSKew
         YDIBXW9EM2BpiI4pTT0wHQD8RF60YoUhKlS6kvYArsP1TvTfyCHi7YisD+jvu9FXyy/i
         PN2skBuc1YIxC11IwV3lZWvKmuQCm70eFdFvrZH6fJ08oNy1K7Y0+5pxgWZW40+9O36d
         rGMGYcSHeyanYTfn34/KHT4MVihUicSr6qKGtsFQDlMckpZtEeFiIVbb7e82WhTJa/uQ
         TiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w4OKEV8dT7MqqU1hQfaaJEcFIsFEHQYaLHN78Ea6SQo=;
        b=4oPmw6OD9y2D+ZG9bT6JfRgxVkBAOb3FKIoBkNQDaBCfvgny+CTB8mYbVxRVkG/1an
         3zcDWyFoBpwZvrsiaoPRl2nQE01A6/cpInTpRq+624Zf7rr2k/uj6qkNfCUIcVSZEfeR
         f6w4b08jlOxhB7F4AxY6LfumIh4jFrJyO5doAg+yL/+8dllSTkjPje1BGz9uHLjNg2ze
         g7jia78ri3faE3hZ9kb+YW0yJJ9GiFs7Q6BcfMVOEpGCJarUmhvV+FRYEGZsrYDkNe9g
         cOPDNkG4YuC9IydNhmvHrNh0hdVZcv+koZ2JTrjyfkOkhBdrb+NOPkLgst1xo1F/VPY0
         o+xg==
X-Gm-Message-State: AOAM532+xECIoexOsxAdMrA98vJXVGmmd0tY2AZptWg01k6YuyHKQNdV
        11Kclmf2InHMoRBkxLg3P7OJxjEOy/vtzA==
X-Google-Smtp-Source: ABdhPJwUMWJql3K5qpxF5Q3rTjwrBWqMdtyNWH+xNL0M7mkrQRN5Wd1vSPFz+bKiEyRNbTXdsAPKrg==
X-Received: by 2002:a1c:8054:: with SMTP id b81mr2411630wmd.87.1634170007323;
        Wed, 13 Oct 2021 17:06:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/20] refs API: make expand_ref() & repo_dwim_log() not set errno
Date:   Thu, 14 Oct 2021 02:06:29 +0200
Message-Id: <patch-17.20-e2885f13c9b-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
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
index 4b0c1a30a18..16f8220b108 100644
--- a/refs.c
+++ b/refs.c
@@ -653,13 +653,16 @@ int expand_ref(struct repository *repo, const char *str, int len,
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
@@ -688,12 +691,14 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
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
2.33.1.1346.g48288c3c089

