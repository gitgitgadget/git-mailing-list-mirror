Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C8C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E5061165
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbhDSLjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbhDSLid (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B070DC061760
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w186so13467150wmg.3
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rJaShWjEu4eUF7ydhTR+EmPjwOi/kD1/15/JKYSZUWM=;
        b=DQK+/k8ggwR6dVvlXatzzIw3HIybR8W/SOIp9SW52pO2uRfUeo6DzSYfUsvLlwRTy4
         VG0S+wE7nqq/gmREpbn24Y8vI9stO9LfPV1Rv46TjIddEDR5A7YtwgZ4PxFQHZVD+2cw
         mtRzTZX6ey771hnTrP/HeguH/qsOTB9JtsoF+pthErwN13v7fm5erfwy5ufMje3n9LzY
         Rfmh41Vd80wL01v538VJvG1soduYfGH5VfK5ueCA25fphKul/OYDiRBYMDm8rTIHHU2g
         UrnwHtSsT9J0kA9NA3gqjHIPnY2j/p5ld0S3/9NhCUYkQg64XX16KOp7GF6ho+qZSIDn
         hr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rJaShWjEu4eUF7ydhTR+EmPjwOi/kD1/15/JKYSZUWM=;
        b=Q4XeKkrDy20N7aYNFmP3TD+GRoKhRS8GC8hCx99ueQhi4saaYoiCQkOZLMnIzaFpx4
         9rbFXWTrMJq3+UAiXngLHJjy5ORs9oumYEfUGwdaQcgZfeESZpaG3TjZXIk/ThusTJC8
         eKjJWQnf6DqsC6WuK9aOj6GIfVK/YyH7ZuoAXfPYybgZ+v8va7mCu0lkeZ6zOyWQ267i
         pE8X2MyWZCXM/b2trerca2etSTlaFImTzN85bhs4lE6LHp5GRJ5vJw59NdFaJSeVVuD5
         NRvTNIGqtfYGpDjjHcLhpoxaQef+/b0oAuzhV2z89o6n1Mp2jOqBQZHx+IxyFyifMXsD
         BlsA==
X-Gm-Message-State: AOAM533hnKKckjoxbVNDX9kKLnXWmVrXA2MCGpzABBv4z8Vch58e43uP
        ruNCuR+oWsbArboYldFMxjNTgqdCvUA=
X-Google-Smtp-Source: ABdhPJyZ89P5l4nrNcjhoJB5Ho+h3V5ySiDIfehXO4XPwrHnwCC4TzKc/j6C1SYNJ7/zKODsVDrg8A==
X-Received: by 2002:a7b:c5c8:: with SMTP id n8mr21174287wmk.63.1618832282525;
        Mon, 19 Apr 2021 04:38:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l4sm22680284wrx.24.2021.04.19.04.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:02 -0700 (PDT)
Message-Id: <fa64aa9ce7c107e9349c5c2e58b276eea053f2ac.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:33 +0000
Subject: [PATCH v7 05/28] init-db: set the_repository->hash_algo early on
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
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
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

