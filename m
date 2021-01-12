Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151BBC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C9922E00
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405664AbhALIsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405621AbhALIse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:48:34 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7FC061795
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y187so1267323wmd.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=McZIHHbGhZYOXSIckzfGJFUnBSPH/1f/sE7o+RtDLyg=;
        b=ElqYPc/YsmJKpV4sL9evavnmCZittV5fbQ2QG6lHP60NemsjBoOT6zhA9ojKZaBV3z
         BfRFhb9fPKtrRD3nzji6GPe6rwHzyGvT2ul9cQdEWAhF7pudpUqmNw1Lk+7cagWkjNjB
         cKIVUiYRJTepXcwoVMNy5/k0wGAu/+mwp8Eia+n4qKWy4/aEvmcFOSryhkcw3H4bxr7S
         I6cRtBJpfPyyvqSFjK2KqX2PNh3mV7XGmroOiFePew+2xlLeAQahIWHt6sE4YCva37XV
         yfRvbqIA6acDRaJsJn+W5ye0UQ9kkePMfUo6y8rr2RrCA69csn0yLjwlp6rpsaKvdeOX
         AtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=McZIHHbGhZYOXSIckzfGJFUnBSPH/1f/sE7o+RtDLyg=;
        b=LpNc7jMY9Q0kFuU4AOZ3jmdgHG0fxBFSE0OTOVEN7vAUDZMd/fTyps6+6K0Vbz+JZA
         6dVoD8rCOdKTbRyzVVeTaXTr73GoHzfhAMqRs+Ko0C+j7+/nz7lFTCr1Mbaq2tIj9mrX
         gZHtq/C5xPr2SedWsNPdL5jr0AiDZeT2tlaMysv4mtUEBMcGuGt6UVRqoo2k1LD3mgV4
         tdStTQ+ZCXP1+97AIowDvajWSz3sWAnloGjL5VMi0hiPkuY90bx4yy2EsH8ifKNs98Tl
         qak+4H+RKeYATxrBik55OhRGvLdI0TvK/s5FkfZ3JXzdR+lTitfiC/KbOwnkd/bHNdo6
         u1Eg==
X-Gm-Message-State: AOAM531P3pduk7pgM9s3cuAvZf0lMXr5xWxFh82MXcA8Q3uv7ssr8o9T
        Y8dqVTxM5I5w4cUybQfeThKwk8sDX1E=
X-Google-Smtp-Source: ABdhPJzCgEKV5N5ZRiWDUF4LL/D3jje9TMLZBCgmcrCOnOKLqfhOzO9wPM5EtT3s+GIedZZ5Ez+TiA==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr2486531wml.50.1610441267572;
        Tue, 12 Jan 2021 00:47:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8sm3649130wrm.17.2021.01.12.00.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:47:46 -0800 (PST)
Message-Id: <978567b137e85d672c9f0591667d643945aa2bbb.1610441263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.836.git.1610441262.gitgitgadget@gmail.com>
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 08:47:34 +0000
Subject: [PATCH 03/11] parse-options: add forgotten translations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 parse-options-cb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 4542d4d3f92..00862af486e 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -91,7 +91,7 @@ int parse_opt_commits(const struct option *opt, const char *arg, int unset)
 	if (!arg)
 		return -1;
 	if (get_oid(arg, &oid))
-		return error("malformed object name %s", arg);
+		return error(_("malformed object name %s"), arg);
 	commit = lookup_commit_reference(the_repository, &oid);
 	if (!commit)
 		return error("no such commit %s", arg);
@@ -110,7 +110,7 @@ int parse_opt_commit(const struct option *opt, const char *arg, int unset)
 	if (!arg)
 		return -1;
 	if (get_oid(arg, &oid))
-		return error("malformed object name %s", arg);
+		return error(_("malformed object name %s"), arg);
 	commit = lookup_commit_reference(the_repository, &oid);
 	if (!commit)
 		return error("no such commit %s", arg);
-- 
gitgitgadget

