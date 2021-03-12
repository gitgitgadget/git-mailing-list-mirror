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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E7AC43381
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDFE64F8F
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhCLUUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234682AbhCLUUB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:20:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01642C061761
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:00 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y16so5504475wrw.3
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ROXeQyOVRgVKS0s5296KQ8eIHVrbXdXWgu65MvPeWGE=;
        b=QSqDAus2t1NdGA7OEA/ujrnbw8PNDbbTzzEie6dpZ132d2na6qj1MNPWl+dTPR4AAJ
         hZGlDpDYdlNvRKM0Hc1RnXCOBaVU+MiuRa7TGEa6RSFS0ih3GJMSHmnzO9u4L2QEV31a
         /gheNYwi+C4fddm6wiN6/FBQCV5+QvxPvYafxD27czAeEB3DmmY1bmKLpyxzRiSX4w7I
         nxTU0Vr/g2/L35Df22tpNgmguCXxAERtuHY63hWGS1IwiskshUi+LfE7v8Hw/9EAayAD
         9Qv7FD1oywqPF73iPgxpFcveQV0Vgh3raKhGnf6qjHf2lPXh5pfijQ6U5RHwpynivFMa
         za0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ROXeQyOVRgVKS0s5296KQ8eIHVrbXdXWgu65MvPeWGE=;
        b=K8xevd8Itw2xZ6pVQalIBy9eQgw89+POY9X2qc0ag4T8mcXMoRO3e4ipl7y++BUR5n
         rnVFaUJnK5N23EPW5/x4HnQSBN0cS3G3DsAwYs39FqmPXyBxSqz/ZjR0YeTikxYoVXDo
         6i022Wr0SCWfwCkGsGi9YovTM1/2kZmVWOa8M6CaFR/DqbPj7pYT2MymZMZEFnzD/nat
         jU/Ht+utocGHWls09aMg1+pAKQRGeAudYtPBP1vk/jC1z6w+IlaPR5+R9ImdXNZvhzKq
         bWy76wlSdUH11zeJ7sxXXoCLM1iZitFVHvxtuKlsciiY2crpE3qM2paeFi+gXsyoQ5bH
         rxqg==
X-Gm-Message-State: AOAM532rm3BYQll5dyDqsKpudkqXW2onbFHJI0oSze6zCgB4Ni8Xd3GU
        caq/88urAkAYKjoCmoEZQaNGx+7CtW4=
X-Google-Smtp-Source: ABdhPJxdZoA2deJ7RjNvmTRmm44sF3fu3oeXYgwM8TFpapyVg/yiPluUwYe22t5yqZaMntxMnMBozg==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr15538296wro.350.1615580399729;
        Fri, 12 Mar 2021 12:19:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm3894551wmd.27.2021.03.12.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:19:59 -0800 (PST)
Message-Id: <e1d1d9f498070fa9a55e740ec433630824340525.1615580397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
        <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 20:19:42 +0000
Subject: [PATCH v5 01/15] init-db: set the_repository->hash_algo early on
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
index dcc45bef5148..7766661a4755 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -438,6 +438,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
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

