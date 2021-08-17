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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D43C4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C60160249
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbhHQNov (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbhHQNos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:44:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF5C06179A
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso1935966wmc.5
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M66o8jlMvL4PeeUtekVFtRg/hRORM9wxMnGQIcXA8eM=;
        b=HtTh79uk3HVqt9vDBHDR0+qZseAybHeEDfY3FVng+ZBydVwAcGykuoTL3GVQ2dLHeF
         f8ZaLRKDhZsa/0aW8l0gk5WHbpkEtgRHocnWbiyEoYvsHL7GuWFHPadeFoCtgfKgD9bM
         XatLia9OFXPN0KruINr7ETV2OOJPBiiib9bmKL6xLGEvZFI/B23ZuWTgN7kMbzW3F7Ed
         JSquYn9W/09rbVgzKEiN6Mp9k2Eumx+oSTnpaCdABJ5c949Tb737Lum4EBAsUGlfoTuq
         uUTQKNBl+3js49+A/++YbtFnkmt5jaLSiZzIkKMM/qKwab677jEfmyk7BA62N2HavEOX
         xaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M66o8jlMvL4PeeUtekVFtRg/hRORM9wxMnGQIcXA8eM=;
        b=XDdLj3dH+Rz1JqYC3DFkYJAL+8ZeezkcXwc+QfFnlBFZUnEiH1gyp5yz9lMYucax1v
         q0vpwDTI5mVbzJV3WaxkEwe0bJK631ZNUDnU1irKdwE4uWi8Pz3JYeKGqoMpVBYvF7r2
         AjAoUEyanwvLev97xgvBQb45WFvl2mPn6EMwhjFtzfoZCVz51OsRUlUJfE8XKSANs2zt
         63Y82/ueHUqAiV2V7D4kpJvV7R8G30YhBwTgRwr6sLz/zDngE+s5YBE7twgNK/OIBIvJ
         YA2y3r4oz8WGQzxb0QYbhcfIwrQxcngHSulp9nnGHx5JCjqLe6Wo+F00dp48L3u1jbxF
         mrxg==
X-Gm-Message-State: AOAM532ZtHCM9S/i1pDg6PENI5UoFg2Z8mJDCHV+1SuUze3N1gWnEzGG
        eH1rqo8iHybURdHjAw1wAGn1Ebqh2Fc=
X-Google-Smtp-Source: ABdhPJxvO0+DMRlG6lXXAwKQsTPAoJK65S8iub6Z0bQ99gmTwdj1kGkzXwS6F85WhcCT0cEIaXlbBw==
X-Received: by 2002:a05:600c:b51:: with SMTP id k17mr3409920wmr.149.1629207612449;
        Tue, 17 Aug 2021 06:40:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm2148033wmi.42.2021.08.17.06.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:11 -0700 (PDT)
Message-Id: <97aba3ae406859231ca4d978becf23497511da87.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:39:44 +0000
Subject: [PATCH v3 02/25] init-db: set the_repository->hash_algo early on
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
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

