Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFA8C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D667D610A0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345157AbhIBNNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345116AbhIBNNP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1669C061764
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n5so2832713wro.12
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OnSrfzXP7u8eONAF7Ui2nz6Z6wCNrBu3vN14jd+MMt8=;
        b=dpvVcUA81jw6JOYbKd69HQizPU1ON6pwmxp9VreCnoVDcN6VbSRFlCMa1sEDDucv+I
         mABUX5Z5JIfbyc59bHW3CkpxN1V6f1lNKM2ss+SFqA/EJv8DZHwvTo8dshPcGGSJ41IX
         dPBr0ghfM/H/rUDW5AhWZRjDRfCIc5iMyYFoeo6tMa3UHf44WIIcmmcB5q0C9535NU5P
         qo1OzaOztxEHaiVJN4fVvP/gOdotqIn1pe0nPblUA/3ImMjSoYQXeiDkTYxVffRAryvp
         xufNTZRf/e58g2NFEQT9XlPOFTrAZI7h+UGdfMHWzM5q9wImt3mZA3+KyYQemZGV9u/n
         WaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnSrfzXP7u8eONAF7Ui2nz6Z6wCNrBu3vN14jd+MMt8=;
        b=B/TmRGnA550jJLcNg+Vc7RXU/0JQYdKU3ItOVuUmr5iKFcJH6Y/L6AzZ75Z5PIoFNr
         f1WFZieizFRAPEy8YNytfacb4GaIyIGlp3pwACFxSvMhhCcOpR3AivoUC/TUScOAHtyx
         l8tv9VPoQw1opbNDqzp4I9xeduJ775j/JA2PvoV4mw5Wh7f7ibp66EFt8HKdeI3uIwVJ
         /gaURlDE6A1owyDw8yuCouZ2OMSRzmbFQflR7OGVM+vSpabzSKw+DRNgsVFFw1vpRNut
         mJYs0HIN2dHehizsWJPNiEwalc4tIXlle6ou35LalFOHeKFqLyjUKG45lPYUYGZrNn/x
         YpUA==
X-Gm-Message-State: AOAM530VUJmoRYd0KtmKgHN7xVRr2n/H4h3kyBkThKKavgjNAUwVJODu
        0foFWIp8FPfpIFiEniWNoSlE3CwYH2+NtQ==
X-Google-Smtp-Source: ABdhPJzWXFC0xXqMG/0umT0veWH6HV6wP63jIRs2eWGFOn4Z52+onM/SUKwLdpWYoLX2Iz02qp9mYA==
X-Received: by 2002:a5d:6cb0:: with SMTP id a16mr3694670wra.245.1630588325112;
        Thu, 02 Sep 2021 06:12:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:12:04 -0700 (PDT)
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
Subject: [PATCH v5 21/36] run-command: allow stdin for run_processes_parallel
Date:   Thu,  2 Sep 2021 15:11:21 +0200
Message-Id: <patch-v5-21.36-994f6ad8602-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
index 1399243de8a..482ee2d76c6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1627,6 +1627,14 @@ static int pp_start_one(struct parallel_processes *pp)
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
@@ -1638,7 +1646,6 @@ static int pp_start_one(struct parallel_processes *pp)
 	}
 	pp->children[i].process.err = -1;
 	pp->children[i].process.stdout_to_stderr = 1;
-	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
 		code = pp->start_failure(&pp->children[i].err,
-- 
2.33.0.816.g1ba32acadee

