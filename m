Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42818C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291FE60F22
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhHPUSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhHPUR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:17:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0888AC0613C1
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so710525wml.3
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M66o8jlMvL4PeeUtekVFtRg/hRORM9wxMnGQIcXA8eM=;
        b=f98JwHNPRswAe5xSFAS+EPrJeD4i7+xC4gD3voP1QaR16+QmRgDTyXcC8SAfkIW8m1
         27R4M3yLKyAKebqQ0fVtJAWZEKo/wFAEtK8gu13JXYPABdhhXrOemJeGFpcxdrvaBgB3
         3nxfzXb1WpxqLqpJijogtwpMY1SXxDpYjwy2StiLpJQwvEEa7nMQtvM2G8wT4yuaJEja
         p3cDAcE+JEujd7s88vmlF5BwGkascd/+b5oAg9I30STUlowVkapkkMUdGJ2UCLgIaW+D
         QnW68UAwkOaI81i4aSQGWZ+qcxUGvBUpKyZaBNYpKSPyXFN+r83DgDLr+D/Y8rB3KUv3
         Z9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M66o8jlMvL4PeeUtekVFtRg/hRORM9wxMnGQIcXA8eM=;
        b=VGNh9fuJ2j3r5mynJwKelPT5pbsNX1nk63eCm5I+pME/IjgkYfYOMm7ERcopoAz1iO
         ffPx3fh/fWOjmnoMPiLW3FkxO27UYfJSp216jcCNptmh4S2P7BsaVVYuaJT0RtrjbiLX
         s5AXwrPis5R9MVgZSTd2ipmWJLH0rA+hY8RQQtTwoaID5foyuVnweQsbr1Exfjjs2G/h
         TJF5nFRTkoQ+q1N7daylwOT0fx0WEPhEmmaF8D4euFG5NtKZEUt4gPshD56oMi9+EY+J
         FPr4e9+op/4g3nvQnoWKs2sj7xc6dhgevBzurF7BlNBvBrfnIDxkGiQJzGpcLz4C94k1
         8RIw==
X-Gm-Message-State: AOAM533AgqpGo5iOmfjxwVQY7oDhVRNJ9yBBijcB8sH4XDYB2gquW8vg
        TLKTePNhf3MnPSGTNdUqgP9/UD9ryzM=
X-Google-Smtp-Source: ABdhPJwcJRV6n+VXi3+lSz8SGCHv7LKQDTVbh3eX+eNgeF95Qd4g7jYho0E9rufPCIEVku5CqK725Q==
X-Received: by 2002:a05:600c:2e48:: with SMTP id q8mr26765wmf.38.1629145041695;
        Mon, 16 Aug 2021 13:17:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm131598wms.2.2021.08.16.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:21 -0700 (PDT)
Message-Id: <49dffeeae5866d01e8a88b21e722bf047e2eb778.1629145036.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:16:53 +0000
Subject: [PATCH v2 02/25] init-db: set the_repository->hash_algo early on
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable backend needs to know the hash algorithm for writing the
initialization hash table.

The initial reftable contains a symref HEAD => "main" (or "master"), which is
agnostic to the size of hash value, but this is an exceptional circumstance, and
the reftable library does not cater to this exception. It insists that all
tables in the stack have a consistent format ID for the hash algorithm.

Call set_repo_hash_algo directly after calling validate_hash_algorithm() (which
reads $GIT_DEFAULT_HASH).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/init-db.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 2167796ff2a..c2f03f6018e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -425,6 +425,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	validate_hash_algorithm(&repo_fmt, hash);
 
+	/*
+	 * At this point, the_repository we have in-core does not look
+	 * anything like one that we would see initialized in an already
+	 * working repository after calling setup_git_directory().
+	 *
+	 * Calling repository.c::initialize_the_repository() may have
+	 * prepared the .index .objects and .parsed_objects members, but
+	 * other members like .gitdir, .commondir, etc. have not been
+	 * initialized.
+	 *
+	 * Many API functions assume they are working with the_repository
+	 * that has sensibly been initialized, but because we haven't
+	 * really read from an existing repository, we need to hand-craft
+	 * the necessary members of the structure to get out of this
+	 * chicken-and-egg situation.
+	 *
+	 * For now, we update the hash algorithm member to what the
+	 * validate_hash_algorithm() call decided for us.
+	 */
+	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+
 	reinit = create_default_files(template_dir, original_git_dir,
 				      initial_branch, &repo_fmt,
 				      flags & INIT_DB_QUIET);
-- 
gitgitgadget

