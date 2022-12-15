Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7927C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiLOIwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLOIwn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288E2A718
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:33 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h10so2308109wrx.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMvwUWQBATO7msOgHm0f1TyK1B/ykbmbofYnwu30sA8=;
        b=TlYFyN3eXoBKhGSw+RGHr96EunqwTVWuli9lBBhMSitddpK96JgyT1KsO3wfF0u1Lk
         MkHwWl0jv6j1DrSyjUOQ7qQTnLvcRaQkTXuuqGhRe/wC2lOa6DK5uGyxhmvOmfuCIJyQ
         pJBhMv+fkoiPhpq6vHIBSS7JhbVzoHF7RWYcEfq1MtYGbB5m9K+ZCjZwWwv+WuSO9XhY
         Qar2dH9P3QCIJ0qn6QLXE4oQYazM99rA/DopbHkrCgdugw2l2jSYTf+IhKukzHYoWhE1
         0yToZ3Y2Ta/7wbZBtbKxJYD1GQCNxtA0ZiquxM3AkDSASOTtSR4lHiqpFpLy+4iV38Gx
         nysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMvwUWQBATO7msOgHm0f1TyK1B/ykbmbofYnwu30sA8=;
        b=O2SP6sbnxAQtIBcFgex4Th7CsQPQeCLwnlebw6gr4FRaCVUgSlShyLLHEufFI7OsbC
         GzD6CwZS/8d4psdxioQYiok5pzohEty6ggvDn1r3WQFu7j828Fd3XupFbMbZ4xEDDOku
         tBrAh4xchxGZ2eZgMbhFVXLjbAint6dFKUKED93x6z1sbelT/mLNqK6h/IEkxFx11S/s
         bj619dTodAMoY6nXaTFj42PfmTzrEd5oqrFgprwL7LI4McDPQ8hOc67O4jcekh5wDrP4
         wm1vAnguv9hPVaFlblBmJ8cdFa68b0EDfmmrrPHMR9fFW2fMCEjX6V668REOEymi8DTr
         vvGA==
X-Gm-Message-State: ANoB5pnEqiJ7+lzqJaugQKXaqudWKPQOII+sPjq6/rwCjInHTXqAHESs
        Jx0k6Zgs3uGZo+Sf8zJO00BHkvFHU+xxtQ==
X-Google-Smtp-Source: AA0mqf7UpveEJ+WSuy4purRTv4r3edDR+5C6p4qy1ayk4IaqG3FL5JnRkMuWLw9eO0L989hT3l99CA==
X-Received: by 2002:adf:db81:0:b0:236:695b:82d4 with SMTP id u1-20020adfdb81000000b00236695b82d4mr17180825wri.30.1671094352509;
        Thu, 15 Dec 2022 00:52:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 08/12] merge-index: stop calling ensure_full_index() twice
Date:   Thu, 15 Dec 2022 09:52:12 +0100
Message-Id: <patch-v10-08.12-45cf7995448-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When most of the ensure_full_index() calls were added in
8e97852919f (Merge branch 'ds/sparse-index-protections', 2021-04-30)
we could add them at the start of cmd_*() for built-ins, but in some
cases we couldn't do that, as we'd only want to initialize the index
conditionally on some branches in the code.

But this code added in 299e2c4561b (merge-index: ensure full index,
2021-04-01) (part of 8e97852919f) isn't such a case. The merge_all()
function is only called by cmd_merge_index(), which before calling it
will have called ensure_full_index() unconditionally.

We can therefore skip this. While we're at it, and mainly so that
we'll see the relevant code in the context, let's fix a minor
whitespace issue that the addition of the ensure_full_index() call in
299e2c4561b introduced.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 4d91e7ea122..cd160779cbf 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -61,8 +61,7 @@ static void merge_one_path(const char *path)
 static void merge_all(void)
 {
 	int i;
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
+
 	for (i = 0; i < the_index.cache_nr; i++) {
 		const struct cache_entry *ce = the_index.cache[i];
 		if (!ce_stage(ce))
@@ -122,7 +121,6 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
 
-
 	if (all)
 		merge_all();
 	else
-- 
2.39.0.rc2.1048.g0e5493b8d5b

