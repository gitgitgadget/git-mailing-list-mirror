Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F71CC77B78
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDQU6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjDQU5l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:57:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860244C10
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:55:27 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54fbb713301so190271197b3.11
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681764885; x=1684356885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8K8lizgoifAwA/PJTy4d9lD9cKZsgX0vjBcam+QEag=;
        b=1pt/mMkybErBr8CrACID7T5WDUU2mrglnmu1Ds+U+s6zEZDw2mywCdhbg5rq6SkETB
         gUT/yA6FLbSQ9XiFpGFtzg47oCNYHtJid2pH870/quZKUP4pnL5L3sgoAJU4V58nRgbt
         4XFv2VH57rPP/her50a+BlfuWTyKfE6Dr0/hMMNcae9SKJBwUu0Py9cnXGal2EB33vE1
         bOWarWg/VlHjU0nPTe78BNCC2pBCyTLhNko7QXStfcTY0+cz5j+Ffa9LE4zp5flgGKSz
         k4hgP7aP1MsJNuiSBGnx72wFjGNf1ohoIEY3Ql2i0lm3iKgiE5p55Pr5PpJUkW/6iC02
         rUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764885; x=1684356885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8K8lizgoifAwA/PJTy4d9lD9cKZsgX0vjBcam+QEag=;
        b=XPt9+19KtSE+zQjn/p3LJOU/On88cwBtN/9PnsB8w1mFNglsANz2DzFIvAKVqzqNJ1
         5o2bABU6Bbnck280g4x5ODg420lzWM5gsMujZJcgv3ys+tXIiBR0lfgzLL7eLGklNV5g
         yo7WZ1uNW7vE0KQs6F+ICB0e2UrxzE2KxN1PST0zPtfJf7noTUa1Hcr3BRCnn+pjXjST
         2tm4J6nZpxvwLJ4BaOpQgde7l4uC3eIrRnIoDO05pRUTUQQcE6SHrzo3VmW69o0gzBkM
         Jz18LGv/dhBoYtlimDECGxCg8GaFMOEaLxYsDVJmE10iS8x1SCZ3e8vkOnJ+T/cv0y6w
         OVSQ==
X-Gm-Message-State: AAQBX9dBoAMUixik9f8XETrIFIa7o/DtFfGuviKykI4i6N1yY7r/6/iB
        +b17jgBVQYLUFp5km9QXQt4Fk+tIyV5ZzFjqg2cN6w==
X-Google-Smtp-Source: AKy350YkjuSvn7mMJjSaOycvI1lWvXOj044vh1oSVjZBFQRXFDW4Xzjbm2AQJBtvkzlxHVaTWM+qzw==
X-Received: by 2002:a0d:db48:0:b0:54f:b7e1:8724 with SMTP id d69-20020a0ddb48000000b0054fb7e18724mr18558513ywe.1.1681764885058;
        Mon, 17 Apr 2023 13:54:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b10-20020a81bd0a000000b0054bfc94a10dsm3335337ywi.47.2023.04.17.13.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:54:44 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:54:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/10] repository.h: drop unused `gc_cruft_packs`
Message-ID: <fa15125454bb6596adbe68689555337a42cb80b7.1681764848.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of the previous commit, all callers that need to read the value of
`gc.cruftPacks` do so outside without using the `repo_settings` struct,
making its `gc_cruft_packs` unused. Drop it accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repo-settings.c | 4 +---
 repository.h    | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index 0a6c0b381f..a8d0b98794 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -41,10 +41,8 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
 
 	/* Defaults modified by feature.* */
-	if (experimental) {
+	if (experimental)
 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
-		r->settings.gc_cruft_packs = 1;
-	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
 		r->settings.index_skip_hash = 1;
diff --git a/repository.h b/repository.h
index 15a8afc5fb..50eb0ce391 100644
--- a/repository.h
+++ b/repository.h
@@ -33,7 +33,6 @@ struct repo_settings {
 	int commit_graph_generation_version;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
-	int gc_cruft_packs;
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
 	int sparse_index;
-- 
2.38.1
