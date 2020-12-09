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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380E3C4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A3423B51
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbgLIOBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgLIOBO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:01:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13DFC0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:00:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v14so1572731wml.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vo6M8ti1rMOOBfY3vJMb/+0k6SEpCQ9PI6s3OSwMbqo=;
        b=kR/8qolaJxtVaO6D8VMSeFm6E99kTsbDAULOfMhPd+ir1zoLXDrJcL7sfYXmBjLbqT
         l6wBtu76aKMp+nL+URUobBAtIiHv38q75WWMNqL5UfBrohPKKZ5ugp57Tpbsk1Sz1x6d
         d1hhPbV1alYNFBzdD/jPNEtQ/SE6Xmjx+izk20HMPk2WW9PE/IWWWCtPiF4VlChdaTLJ
         wf3PhVOvRDRHp3IYXDW9756fSF3jgqggZnGafqwM5IdT7No4sFqQQH2BnTosgqchhB2G
         Dk1p+azeIHUmkDZtLtChXe8COwNr7zzkl/lR7oX+UDTzNLzmr7dT4GGmHaF551t+cN5T
         lzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vo6M8ti1rMOOBfY3vJMb/+0k6SEpCQ9PI6s3OSwMbqo=;
        b=myLwWh6aJeP+DjVYN4sq7TcBhk3JdmIIUhfALIjt074tCjuvlJJbfiJ/Oiig3TlwkS
         eYuZj48f/lWtLsilN1cawq4BXqLKR3B8vnAz2nMAOzkxnbRo/A0yS7jIMoJEmBuX0Zau
         3WTTjmmpURrLkWSvWbrgYJTqlIuS0EDwoZTis9tbn27ALPBRO+uNH6sU4/oZ+/Xo1oAv
         U2WeFQVF7Ay24ex8SxIRyPP13VgTzQyu72g1sqBsGswpK6PoiMYdCVTSZe2kipSI4PDG
         pB/rNC/h+KDsGJ/Ld0lnSw4sIMjNZboKVtgFD4KOjlkFhBwaLpItT9UVB6fIWZC8vZz8
         f8Bw==
X-Gm-Message-State: AOAM530azSDrtwiIdE0WC7afy+hrCnfawEjSw0fx2ofAQFA1fXmwcMe1
        5lp5gsNKAAoKwhW0b0G3y/n6/mcNV+Y=
X-Google-Smtp-Source: ABdhPJy+gw7ze0Z+dhPafDTlhdVjCr3hfvBUEn8zZ1GjHehqZkJr/fEhCqhrp7ObUZZ5JK2T16QWWg==
X-Received: by 2002:a1c:5447:: with SMTP id p7mr2953578wmi.116.1607522432498;
        Wed, 09 Dec 2020 06:00:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm3626935wrr.2.2020.12.09.06.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:00:32 -0800 (PST)
Message-Id: <40ac041d0efef7a7baec56354265176235137444.1607522429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
        <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 14:00:15 +0000
Subject: [PATCH v4 01/15] init-db: set the_repository->hash_algo early on
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
index 01bc648d416..dcb7015db48 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -437,6 +437,27 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
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
 				      initial_branch, &repo_fmt);
 	if (reinit && initial_branch)
-- 
gitgitgadget

