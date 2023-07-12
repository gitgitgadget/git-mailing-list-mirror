Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14EFEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjGLXjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjGLXiq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:46 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53540272C
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:21 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5701eaf0d04so82685697b3.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205100; x=1691797100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p30Z1OFGsL5nDL4WvWSG0hJmT7eu7c5o0Zjtih24t5k=;
        b=GzdXtb/iboi9v9EA2ibXAIGzlLpFlYt0CHPqE5z0iq2PRQlGLIMAKMY7zGmb9pRgFL
         fPXXpM8/z80pxmRm7C2ywxZyvsgSbDhGU0icRNU3WaEjqP2fblcctSMkHy7xXDDpOn8S
         OvZeovhUqjU2ximvQPCbFfSUI55FscRIdaY9bDTZEuwPac/qxlfdlUbnETGFiJc7W5eY
         jZUgoAvN+jLJNQKpUy4mw4t1RiMTXbGp8fjPdj81YVhKbMpW24FavDiOVzRUBfNKd6jz
         cz4kB+HIGJXXOnLhQZF1bTyfeouhFYgYd/WkcW5NYJlUOP2Y8B/yAq+rXhLjg8Ck9sy/
         O8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205100; x=1691797100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p30Z1OFGsL5nDL4WvWSG0hJmT7eu7c5o0Zjtih24t5k=;
        b=Vk4AGGKm92BRRRr5IeNuwOntKAR6NiYAZQIXjIj8UCufsdOgqFW75XjazEjCcxP3N2
         OROELsOqqOlwSBhCO9uyJl3aCwz6BfDt9Wg5fj2AJSBwG4LKEvLJC/kxVw7yDQafeePl
         4Oei5Ad0sOCmoMDP2TUFQtbvB7c33N5m2nr2nOchhoW/67kTzti1Qshi3cshQsqrwLA3
         FybK8Qr9jN3qbPHZ4/+UqzQlwRT7xBNIHQeGKvibR1fs20DhDR2BXMWLeTykraDbRakH
         w8yybkNsYBvca+59JxIoEp4iE6rXZpecEprZ9OrM+viQcFrxuSlYs1bLbGlBljdUOX/B
         9QDw==
X-Gm-Message-State: ABy/qLaYQ2b1q683AUFLx5h5njOjTZzPvU3/AAbS7PuGMtNM3NjyAr2M
        /0s1A4TyLPIW8/R7kwhrZMMYhWANKObGZyHQnd6bGQ==
X-Google-Smtp-Source: APBJJlFe/CsapXUCEq2JZImoIRrSMtWPSVM0lp3cUEAziWnujmuaL4Z2JPQ9hKXBerM/sSZS/hcV/g==
X-Received: by 2002:a0d:d445:0:b0:575:4b1c:e5f0 with SMTP id w66-20020a0dd445000000b005754b1ce5f0mr105544ywd.32.1689205100287;
        Wed, 12 Jul 2023 16:38:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w1-20020a5b05c1000000b00bcb4ac1fbc6sm1137705ybp.30.2023.07.12.16.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:38:20 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:38:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 20/20] commit-graph.c: prevent overflow in
 `verify_commit_graph()`
Message-ID: <55fff3eb84d8a70aa370aedaf1057ad292435a67.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, ensure that we don't overflow
when trying to read an OID out of an existing commit-graph during
verification.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 20d9296c8b..f7a3f97401 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2584,7 +2584,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit;
 
-		oidread(&cur_oid, g->chunk_oid_lookup + g->hash_len * i);
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i));
 
 		if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
 			graph_report(_("commit-graph has incorrect OID order: %s then %s"),
@@ -2632,7 +2632,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		timestamp_t generation;
 
 		display_progress(progress, i + 1);
-		oidread(&cur_oid, g->chunk_oid_lookup + g->hash_len * i);
+		oidread(&cur_oid, g->chunk_oid_lookup + st_mult(g->hash_len, i));
 
 		graph_commit = lookup_commit(r, &cur_oid);
 		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
-- 
2.41.0.347.g7b976b8871f
