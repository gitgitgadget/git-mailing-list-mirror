Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64E9C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJLVE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiJLVDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:03:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99446BF72
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bp11so15213727wrb.9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwLhduUbt94tVAmhwExY2jaT6aoxaLjnNIoAAroiiHE=;
        b=KJKtOXoa86NwMeX7JrQSWk8fkCD6oyTEJp6hIo64QZhedKM1PLyA9vDzpTW7GEUqNr
         /de7+LR7+nfztgFGFXu8DXDs8UYz0an4xWKltG2nZdzGLG87gck4fbjCRSjhXdvaffPC
         8PmLdFBfgtJmWjRLpEKrx3JESRS/6rQCyN/hvK/Pd0bcuExkkvE8FjU/ETdMmGeIP8Yq
         DGxNtPlgdufNTLsc89zWokNxJ1lgtxInu63+u4MAMLosS3fiOQy4duJP2IRBM73drLpq
         5IldfLslOxdufXumQwHlQkbRKMHhVma7wG1CnX0QM7cXEwEVKaqTyYBru/+CugjGAMgJ
         QKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwLhduUbt94tVAmhwExY2jaT6aoxaLjnNIoAAroiiHE=;
        b=q2p6NExktSyOT4zT3UqYtBlYk3xrTshJKOkE0+rvd4WnVY3HsEsNWCMfjzAfIupOqX
         C2iOWbSR/HB5hwL0/he8glKYKV7H2DmNpjD8yWcIgQu5Xegb6a5VmLFT4qfiWSKJatMR
         CjX+xAZ68ACuosAecqAO9gzuCftqVELW6tpBN7SUjNg9TThTdnPE1H/F2ONBBfwR0VY8
         sDryoDs2LLaYetKmUETcAZSlcdX8Cxa3mIa5jxauX17nlVtIDMq28mh3ss4rnMpIEImZ
         q/+W9Jk79Z+r5BZvHfgfFwPNGytMZgOlnfl9u/Nuarr089zQFjYGwMI6m39HtRM7Lhdv
         k3YQ==
X-Gm-Message-State: ACrzQf0eC3Ml6u7sp/2PZ/JzZRK7aAsmbkXtv3G239y70jdlxWo0qFCi
        BLAqBPNdybkYZBvyDPz2qLs8+RXZ+ulgOQ==
X-Google-Smtp-Source: AMsMyM6mfUcCZl8REa628PJ9rbmsHdlNnr8Nw/y/GRqVDqbmpQH2Ax59Ct0Vu1KPKVVSXAeFQZOvqA==
X-Received: by 2002:a05:6000:1ac9:b0:22e:3d0c:43ed with SMTP id i9-20020a0560001ac900b0022e3d0c43edmr19225819wry.34.1665608615386;
        Wed, 12 Oct 2022 14:03:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b6-20020adff246000000b00228a6ce17b4sm550079wrp.37.2022.10.12.14.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:03:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/15] run-command.c: don't copy "data" to "struct parallel_processes"
Date:   Wed, 12 Oct 2022 23:02:31 +0200
Message-Id: <patch-v3-12.15-3081dfc49d1-20221012T205712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the *_fn members removed in a preceding commit, let's not copy
the "data" member of the "struct run_process_parallel_opts" over to
the "struct parallel_processes". Now that we're passing the "opts"
down there's no reason to do so.

This makes the code easier to follow, as we have a "const" attribute
on the "struct run_process_parallel_opts", but not "struct
parallel_processes". We do not alter the "ungroup" argument, so
storing it in the non-const structure would make this control flow
less obvious.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 19d5cff8c65..d382c42f82d 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1497,8 +1497,6 @@ enum child_state {
 };
 
 struct parallel_processes {
-	void *const data;
-
 	const size_t max_processes;
 	size_t nr_processes;
 
@@ -1609,7 +1607,7 @@ static int pp_start_one(struct parallel_processes *pp,
 
 	code = opts->get_next_task(&pp->children[i].process,
 				   opts->ungroup ? NULL : &pp->children[i].err,
-				   pp->data,
+				   opts->data,
 				   &pp->children[i].data);
 	if (!code) {
 		if (!opts->ungroup) {
@@ -1628,7 +1626,7 @@ static int pp_start_one(struct parallel_processes *pp,
 		if (opts->start_failure)
 			code = opts->start_failure(opts->ungroup ? NULL :
 						   &pp->children[i].err,
-						   pp->data,
+						   opts->data,
 						   pp->children[i].data);
 		else
 			code = 0;
@@ -1705,7 +1703,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 
 		if (opts->task_finished)
 			code = opts->task_finished(code, opts->ungroup ? NULL :
-						   &pp->children[i].err, pp->data,
+						   &pp->children[i].err, opts->data,
 						   pp->children[i].data);
 		else
 			code = 0;
@@ -1758,7 +1756,6 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 	int spawn_cap = 4;
 	struct parallel_processes pp = {
 		.max_processes = opts->processes,
-		.data = opts->data,
 		.buffered_output = STRBUF_INIT,
 	};
 	/* options */
-- 
2.38.0.971.ge79ff6d20e7

