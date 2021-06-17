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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF12CC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A578661057
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhFQKZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhFQKZj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E2C06124C
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id s6so3223929edu.10
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZBrjnoRSnoHbAnuAzfd9UwOW6z8IPdZ5pp0fPqGzxL0=;
        b=o9CTrup6bT0tQ0uJ4SBIHPPYJlmbtVcTLr6hGzaDBqReHuyoMdhHX4GQWZp3P74vZw
         NxGTfV/lkZwqsYX4ptsllzA6zhrwUVJnMOkIjfqQ1Ov3roGdYqD5MnibhIuZ2y5YDEIM
         f/WXwlFqkncyEpNDvBpUqD73ySHGLrr0fnVzL5Oj68z8fjao4wxHzXGf0RQAE9nWRlDM
         8XTWdfSlsynaFx/oEbqAe7Sjxf3r9i2IHkTGTkTbsh7w/fi5w2zOwZ9yADRAQTxY/ViU
         beecapoOjgdmNGNljYcLPEH2GP7VAu+MZfYW5gzwoyTxwftRqhBjvjZiOmeuZjK736No
         kyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBrjnoRSnoHbAnuAzfd9UwOW6z8IPdZ5pp0fPqGzxL0=;
        b=h+YaHgCchXLILbgStE69knkQ0dLN4XuCCosZY/RlQ52HrU7NWSCnUjNDBLnz+YKpab
         Ot4XxvrHAF6WyB3NPbANoga4woKBkz5qjyokfLY6RZsDoI6bd9ZP2Cod05gYwdagHK9f
         E+43152cV9alfhFkqCKoohkbUtY4Hud28Sl1kEVK+Siu/KAwPuryeFJbYAL7VpnRdUUt
         A2s0kkUTr3YGxZ+YR861be3rLYSnY8/FCb9HacfSjol8aYnbwhBjNTxYahG2jIQFDJdL
         D2BsefZAEVG5KTROFTCVJRcl1I3kCcQpTtRNfxCR+mAvnYrZNQTYZV+0QtNsa1qI3jC8
         Dvgg==
X-Gm-Message-State: AOAM5304bB3/kXI5EFuAqdlZHyVMu+9pT+lFu/P04Wr7SqtXoOBzNUBp
        eEUgTiaFr6L/zoensGya4uElYD/ioJW5Vg==
X-Google-Smtp-Source: ABdhPJz2yC4dbrG6gGSb6zMpqwSbTKE8IqLMNAUy4ZG6MW0W0io7JquIG/UitCrLnhG+FAUFMYUwYQ==
X-Received: by 2002:aa7:c594:: with SMTP id g20mr5377818edq.193.1623925400667;
        Thu, 17 Jun 2021 03:23:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:20 -0700 (PDT)
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
Subject: [PATCH 14/27] run-command: allow stdin for run_processes_parallel
Date:   Thu, 17 Jun 2021 12:22:48 +0200
Message-Id: <patch-14.27-477d75bf57-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
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
index 95c950a4a2..0bf771845e 100644
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
2.32.0.576.g59759b6ca7d

