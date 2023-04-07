Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87D6C77B6C
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 13:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbjDGN5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjDGN4s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 09:56:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC82AF14
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 06:56:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v1so42377980wrv.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680875762;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INArs5yM4NIhJ+0lqs1lb6ujwj5pjWYgyIzNqV55hTY=;
        b=bg3etl2XhnGDn8DRqYeDbUqXT5FO2bBYa72ncKTh+PKvz7KjRZZHFKqjQGw+DJQs2g
         62485m6doy7DDE+eCsPP4PoOXByFqvVORG/g0MlC6n5rOLD7/+fNNmk7nCfwqBl+erAh
         4tdj1JvFYIZYhxQBrlEMELowaIw+HMS25AfDduBYNFDF626VnILu/iQDc6pM3/n5kHfl
         Wj2mpWBU3NGxISytrtufIxcRV/dR2QANcY1x1opOPNkSmQNaJiTHpj6kW2Ij9KDzTJgu
         EwBSjsejqxoeVjvQvjVTVS+nPNoDFpTF1CxRhRWN2C2zftLR01S3c5cInO2HyT1I/qFe
         UbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680875762;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INArs5yM4NIhJ+0lqs1lb6ujwj5pjWYgyIzNqV55hTY=;
        b=v+ksE+2Mf5jhmIL5XfK3UODk3igTvMPV0cZu55UHDE5AoG7rOgCz4NlMtxMPYTcPhr
         5fSnnNLPrUCnWZZ8lEfffJmkC/yQkIHMo9gLjJvy3dsYl9xpeGETZG9HaegmhW2N5U3L
         +N1fVZGBs1su8kRa1Ys2hznZM1tv0WXUnz6zGJKE2pfDoH6Zz7NlIu9g+zNjgZq0Wmoj
         +Bw0VHxrNVchzoqaM1wqUVE0+flkIgXVckclVC/IAnhfgtIG9vFUol/EZOSiGpZeePi4
         pWbTahm+l16co4JcNVKElNBg6dj+hjc7/O9fomjeSsPUr1br2VRlTAA68gmAHYOF5n8E
         GMwQ==
X-Gm-Message-State: AAQBX9d402lHaHzfxMyigbYMr8lnhioPFT8i1foMTaL9mWHkw4Iz9KwM
        WkmO/gsJzYIRa5QXckNsuvodsNf+7dw=
X-Google-Smtp-Source: AKy350a0expZBTbryQDKXVIR4AF2AolpZqC65HW6NMTj/z+p4Kp+0nyaeBSellcF3ijqpAewzNzBzg==
X-Received: by 2002:adf:ef43:0:b0:2c5:5ec7:43bc with SMTP id c3-20020adfef43000000b002c55ec743bcmr1305695wrp.18.1680875762345;
        Fri, 07 Apr 2023 06:56:02 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id p15-20020a1c740f000000b003edc11c2ecbsm4742003wmc.4.2023.04.07.06.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:56:01 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/5] rebase: stop reading and writing unnecessary strategy state
Date:   Fri,  7 Apr 2023 14:55:31 +0100
Message-Id: <882b403423e5c2d90c3afc4eefb02bb499c4a02b.1680875701.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.670.g64ef305212.dirty
In-Reply-To: <cover.1680875701.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1680875701.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The state files for "--strategy" and "--strategy-option" are written and
read twice, once by builtin/rebase.c and then by sequencer.c. This is an
artifact of the scripted rebase and the need to support "rebase
--preserve-merges". Now that "--preserve-merges" no-longer exists we
only need to read and write these files in sequencer.c. This enables us
to remove a call to free() in read_strategy_opts() that was added by
f1f4ebf432 (sequencer.c: fix "opts->strategy" leak in
read_strategy_opts(), 2022-11-08) as this commit fixes the root cause of
that leak.

There is further scope for removing duplication in the reading and
writing of state files between builtin/rebase.c and sequencer.c but that
is left for a follow up series.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 24 ------------------------
 sequencer.c      |  1 -
 2 files changed, 25 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b7b908b66..3bd215c771 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -483,24 +483,6 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->gpg_sign_opt = xstrdup(buf.buf);
 	}
 
-	if (file_exists(state_dir_path("strategy", opts))) {
-		strbuf_reset(&buf);
-		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
-				   READ_ONELINER_WARN_MISSING))
-			return -1;
-		free(opts->strategy);
-		opts->strategy = xstrdup(buf.buf);
-	}
-
-	if (file_exists(state_dir_path("strategy_opts", opts))) {
-		strbuf_reset(&buf);
-		if (!read_oneliner(&buf, state_dir_path("strategy_opts", opts),
-				   READ_ONELINER_WARN_MISSING))
-			return -1;
-		free(opts->strategy_opts);
-		opts->strategy_opts = xstrdup(buf.buf);
-	}
-
 	strbuf_release(&buf);
 
 	return 0;
@@ -518,12 +500,6 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 		write_file(state_dir_path("quiet", opts), "%s", "");
 	if (opts->flags & REBASE_VERBOSE)
 		write_file(state_dir_path("verbose", opts), "%s", "");
-	if (opts->strategy)
-		write_file(state_dir_path("strategy", opts), "%s",
-			   opts->strategy);
-	if (opts->strategy_opts)
-		write_file(state_dir_path("strategy_opts", opts), "%s",
-			   opts->strategy_opts);
 	if (opts->allow_rerere_autoupdate > 0)
 		write_file(state_dir_path("allow_rerere_autoupdate", opts),
 			   "-%s-rerere-autoupdate",
diff --git a/sequencer.c b/sequencer.c
index 3be23d7ca2..c35a67e104 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2944,7 +2944,6 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 	strbuf_reset(buf);
 	if (!read_oneliner(buf, rebase_path_strategy(), 0))
 		return;
-	free(opts->strategy);
 	opts->strategy = strbuf_detach(buf, NULL);
 	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
 		return;
-- 
2.40.0.670.g64ef305212.dirty

