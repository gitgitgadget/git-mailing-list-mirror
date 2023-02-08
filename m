Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C26BC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 19:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjBHTVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjBHTVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 14:21:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C387564B2
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 11:21:37 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hx15so53566884ejc.11
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 11:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96BbuNrsta3M++1CyknaUQDLObubEczaFZyb1SKal0M=;
        b=N9Pb7kDgSwHfOo45jn/dyW5IILvg144NGUqY1oU7nm7foe77/aBqD142yWKwVJJNc0
         YznNhnbN/jRy8etpyZdIJhtjmLJ4KJ6Dh3iS5nP8GicK+MtjKhgtcyl3EitCHdXEvBoo
         Pg9Wz06KyVM8sforInadVMJeAmdyHnBf5YH65fsWvd7Ig2zzfka4Cedp6EYzsB7g2j+A
         zlH6m9YEyoIfdr43TNJGcvaCGz+t98Iv1RPTZYlsp5QAr+vM2e4bcoU7++RRHexAW1z2
         EVGIKeg2JcP6o1T8ZtxAR3cCRYajYPCHFpvYO48PKHL1mR/4LyeAVBXy9hrII2xqSJAp
         V1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96BbuNrsta3M++1CyknaUQDLObubEczaFZyb1SKal0M=;
        b=TxVVc4zf+bNPzITaXaaP15LwJGHxU3MP2x29Yb07DGdpU3/wydsvM+xHgQRIrfHAzg
         4YTVw19+EQ7zF1tAv/OPACx+P6LntV3rjS6DmzoqruQFwZf1eciz5RT4UcXIMz0nUtqG
         FmPosoJzTDBeWMGeia10Hfj1YX/6D+m8sTSt1MS6I4GYms1Qmd0CvQPCslAHfOEnLgPJ
         yyPrzNEMtFRuW94XTB2egX0/DfSNRIHIcIHRhOVCwMhHMf3NUJDZVgNW9xUBizuP4BGv
         8hF4SwWe+uEj89iHv5OLR7iEeCEx5Ncv/hkJMKCdCzHwRUr8zPd4XUPGfcR0YGMw/wUy
         q6VQ==
X-Gm-Message-State: AO0yUKV8rnXKTGcECi5sBm1geNuFtlnoBsTfopeW7hXsIwxOE9w4zvO+
        PaFyeRKFlRObTsV4q5oJXN0lz1WyVWvUoIOo
X-Google-Smtp-Source: AK7set86xj3X+gFu3WiseABumzfYuf6Y+Q+EHS/UYJBAMRaLLRh6lwCuSQsjtmi3rmBsm+1KFxS7CA==
X-Received: by 2002:a17:907:6d03:b0:8af:22b4:9952 with SMTP id sa3-20020a1709076d0300b008af22b49952mr2019552ejc.38.1675884095240;
        Wed, 08 Feb 2023 11:21:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15-20020a1709062c0f00b008964fdd5bbfsm6244227ejh.155.2023.02.08.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:21:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] run-command: allow stdin for run_processes_parallel
Date:   Wed,  8 Feb 2023 20:21:12 +0100
Message-Id: <patch-v2-2.5-9a178577dcc-20230208T191924Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1475.gc2542cdc5ef
In-Reply-To: <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20230208T191924Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

While it makes sense not to inherit stdin from the parent process to
avoid deadlocking, it's not necessary to completely ban stdin to
children. An informed user should be able to configure stdin safely. By
setting `some_child.process.no_stdin=1` before calling `get_next_task()`
we provide a reasonable default behavior but enable users to set up
stdin streaming for themselves during the callback.

`some_child.process.stdout_to_stderr`, however, remains unmodifiable by
`get_next_task()` - the rest of the run_processes_parallel() API depends
on child output in stderr.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index b439c7974ca..6bd16acb060 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1586,6 +1586,14 @@ static int pp_start_one(struct parallel_processes *pp,
 	if (i == opts->processes)
 		BUG("bookkeeping is hard");
 
+	/*
+	 * By default, do not inherit stdin from the parent process - otherwise,
+	 * all children would share stdin! Users may overwrite this to provide
+	 * something to the child's stdin by having their 'get_next_task'
+	 * callback assign 0 to .no_stdin and an appropriate integer to .in.
+	 */
+	pp->children[i].process.no_stdin = 1;
+
 	code = opts->get_next_task(&pp->children[i].process,
 				   opts->ungroup ? NULL : &pp->children[i].err,
 				   opts->data,
@@ -1601,7 +1609,6 @@ static int pp_start_one(struct parallel_processes *pp,
 		pp->children[i].process.err = -1;
 		pp->children[i].process.stdout_to_stderr = 1;
 	}
-	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
 		if (opts->start_failure)
-- 
2.39.1.1475.gc2542cdc5ef

