Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E8C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27DD61356
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbhDLT0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhDLT0P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:26:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BEC06174A
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:25:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so2093132wrm.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rJaShWjEu4eUF7ydhTR+EmPjwOi/kD1/15/JKYSZUWM=;
        b=K/ZHu7uiIBIJ1pWxqlZ59y7uas1mkZshffp0VkZQ485FanPxWo71TLjVpTro1jeD85
         6V+5plyP4vHW+o1jtQ3MdehNUgcSeBZAbgLheM7tHK9NJoCavFxQo3KwKemvY/L7NitX
         KA0NoJcMk77tdcFTewbr7VRXb3ZuBHXXU96nqoMoCSOIQe/sqbhUx3hQgC5OY6lZtRrH
         8hHCM3TnWxcXWcmb2Dmiv3UxxRxSfyAp5fhjEuSsfSk3lfplpX1pQvdDF94m7o1idkdw
         SxODRT5S31yYUJ7INNQhZnVfTf5dk37pVMXAzG0wYi62QqVgQcMT1yoruwK7rm3XGX0a
         WlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rJaShWjEu4eUF7ydhTR+EmPjwOi/kD1/15/JKYSZUWM=;
        b=lh5sqx62MrU5XRMC87Zn6RPJTotgUtis4yXaQ1Y7J7qtn15fFxFwqdXwTx/vAuFKov
         VuPQfIzjjQ7jlsivqwXqjxR0ugMwV+Xxtr2ek1L2FLTejuOi3hzeA/FAsBi1NYmCaqT/
         EGl4c4FVBR+VOnrMM3Ktz4ztDbUCvs7BQ05MhXCSVx3mC4XpfwQoY3HNfbO66Ux+qbAN
         hUGB6ud/TARwC5Aj2SL+vJ+YyLYy3/tdxKx4SBoHt3zF1KzNPzYSZkZFBfIB6ShrZzS5
         KgItGjwQF31UWoX1POgKSZ5IMEbMV/RcoruAhi6Zy+5j615AUojoLFzKGwju6Y7KVYFh
         Ayxg==
X-Gm-Message-State: AOAM5337RhUs30rj7Czb2g1FLLzuZZMHlHryZTRd+NbadbD4gICusPUE
        2ht8lJq1gusXEfLbj2DghRebOrHYQIs=
X-Google-Smtp-Source: ABdhPJwI3snDPgV1Gv+WUpsFfLA7xe9GtFsdSrmLHCtcHCUvcm36XJVChfo70CPG3KkvUCbPkeobXQ==
X-Received: by 2002:adf:f692:: with SMTP id v18mr22950353wrp.206.1618255555824;
        Mon, 12 Apr 2021 12:25:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3sm18211983wrc.67.2021.04.12.12.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:25:55 -0700 (PDT)
Message-Id: <15b8306fbe4b86f8c6b8b26b76f6e65944a4a4dc.1618255552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 19:25:33 +0000
Subject: [PATCH v6 01/20] init-db: set the_repository->hash_algo early on
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index c19b35f1e691..ff06fe4b9a49 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -424,6 +424,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
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

