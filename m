Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6193AC38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjAWRP0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjAWRPX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:23 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C8C2887F
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:16 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id kt14so32402080ejc.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ju+V7h+2LsytSHAkzvcd1pMbTPZ3YBeKNDl1iHJ4lnM=;
        b=gfcHOQq0BokKxz3dgex+kO+vrN2aMEP+PhnATLp81dboaFZ+S5FCp/r8oVNJseh6Fr
         EjM1slgDBoDlt+jWjtHM0qFWHfLM+SALsqMMvLIUwrbHpTbxk9mNT65QrMEL6TPWKtV7
         SF74tkQh+1I3pcyPmbYfcgizL4Kqx8YGeTw46wpeow1TT+O6ijp2g6G6KSMJB3amUduP
         X4xsAhR8fMILW+LdpYIZsiRSkDvTl6CCVwFhqdItxDcZmUUCfAT+1+OWJ8hGMXjfL0lb
         S0r1TXe54tWD5VeqyiZI2siqslKGbywzn0DBtqayYK25pw7U2OyDUBtrTvltPElhtRih
         tF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju+V7h+2LsytSHAkzvcd1pMbTPZ3YBeKNDl1iHJ4lnM=;
        b=0pHTd+UgfReEX54e2sthh8o0dTjjiZpJt7U7snX3H4kLVtZnI8yUnog5jX2aURYcVo
         vMaBptkEQeze8JAZdFzC4nE5dIaeg+xu5WFt06zwO494oW7G8eka4yBtovn18FrQcb7w
         EV9/VbWY5SZcDnWuc5LHmIpEqYy9J/qJMZUDozvyCqMsfdFWOv1SgsJ+kaBqlfg3ZJAL
         Dq1FzI9ngyz4QxM5a2sKCgmduOntSGBirfpIb36MR9pZJTBqcJdUHnF3r49sHMSY9cNN
         tphV4UMRORQn9TAWpQLCA8zwt2+cPhpenUghV+Ijf4DmcJm1Lv1vzjlNBpxWJD197nKc
         IEgQ==
X-Gm-Message-State: AFqh2kpiqclrSY/qm+CRHrlzsIHEL95G51zDSvxFQsjm/jsIO0x74WHm
        Gt9r8U/mmP7xc9n5Nlukqu4tgkucshwV+A==
X-Google-Smtp-Source: AMrXdXs5VW6PJqjsPmbiAAXYmDiEPYvvZZe2v6X62GdS/YO2JTDtpEvdTAhKj2Be+I6Tp0Tr8rLQEQ==
X-Received: by 2002:a17:907:a056:b0:84d:28d9:ce6 with SMTP id gz22-20020a170907a05600b0084d28d90ce6mr25347721ejc.35.1674494114479;
        Mon, 23 Jan 2023 09:15:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906164400b007c11e5ac250sm22771754ejd.91.2023.01.23.09.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:15:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] run-command: allow stdin for run_processes_parallel
Date:   Mon, 23 Jan 2023 18:15:06 +0100
Message-Id: <patch-2.5-81eef2f60a0-20230123T170551Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1301.gffb37c08dee
In-Reply-To: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
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
2.39.1.1301.gffb37c08dee

