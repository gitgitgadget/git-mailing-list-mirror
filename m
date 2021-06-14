Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B83C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC7C61451
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhFNKjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:39:02 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46726 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhFNKhB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:37:01 -0400
Received: by mail-wr1-f41.google.com with SMTP id a11so13963020wrt.13
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c583cjIJKRhFUjc4wOuKeRSYLzv0VZfpzMGrECZj7uY=;
        b=GBuLw2t1fiD7gUO22FwnICFCFRA9FcYqbDggIyaN+DFTuAlZPstiBxRcrpTvC4HAsT
         lbpJgxVGY1g2iE8T0LE14F3aLiYtih8UZ00NPyKtZIKDYIQ6qru6+n+m3VMS+65w0Tqt
         1c3/0BSDbnMK3nbuUTtM679zgRKtNAuQwM6j1XXv7oMyjB21rGyai2EQGpv7qY2kuugz
         ME55v5bXc6p/KnQj5R8hAqTX/GAHQm1WElIDPLcmG8s8lgbvohzRpFURNmkbagrmOBSm
         lZeeXNTY8xuny9MVYbepwV23y47Es0xd8BSYDIGTyPoe3IDPBp3pctBiKJXB6mCpbbDl
         mzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c583cjIJKRhFUjc4wOuKeRSYLzv0VZfpzMGrECZj7uY=;
        b=bieEe9CWP+MHC4cbrgezF7hurK5d1URamRY0YswONpFLNWyidAh2wwHs0f0KJPHMOE
         0T7g/VU/elMe85o66lOzPdrB9QMf0D5VboKynVq1QJWzJ2yJiYt5umZdfz/R2boekrUn
         4O5CNTWuyeBwXcY+9mutPlVxVHIfYSej+I83nr/XSs9Gcnps/76qKo4slhoiD0giwxrb
         D+l6oiI0SFJK9miuQjsYatKKKMb0/zVv/J6Q0s7tL4x7ZiQOquJzjY0BO9/HBiqwAWGj
         eFM8fwgo+1D61X9+S1b91GRaJG9Iku0gzlNUd57GoZGybro9Fe31yRq7SGxnmi1Bmw8Z
         PC0w==
X-Gm-Message-State: AOAM532f5D6aWKDvtb76T4YNtczds0SFCmcxuxsBvqSQwDr7V7Q8SUcH
        esb/J7zN3dpzIbt37oZnvyQaSLVIjpuyEA==
X-Google-Smtp-Source: ABdhPJxjFwfFc2LMKHsaAtPSseHDyevrvIkzUN1x3sub1S27aW1K1Rm2wg11U9GoiF7PYvOmyHMOXg==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr18249846wrq.336.1623666837849;
        Mon, 14 Jun 2021 03:33:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/30] run-command: allow stdin for run_processes_parallel
Date:   Mon, 14 Jun 2021 12:33:05 +0200
Message-Id: <patch-16.30-53a3877a476-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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
index 95c950a4a2b..0bf771845e4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1628,6 +1628,14 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		BUG("bookkeeping is hard");
 
+	/*
+	 * By default, do not inherit stdin from the parent process - otherwise,
+	 * all children would share stdin! Users may overwrite this to provide
+	 * something to the child's stdin by having their 'get_next_task'
+	 * callback assign 0 to .no_stdin and an appropriate integer to .in.
+	 */
+	pp->children[i].process.no_stdin = 1;
+
 	code = pp->get_next_task(&pp->children[i].process,
 				 &pp->children[i].err,
 				 pp->data,
@@ -1639,7 +1647,6 @@ static int pp_start_one(struct parallel_processes *pp)
 	}
 	pp->children[i].process.err = -1;
 	pp->children[i].process.stdout_to_stderr = 1;
-	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
 		code = pp->start_failure(&pp->children[i].err,
-- 
2.32.0.rc3.434.gd8aed1f08a7

