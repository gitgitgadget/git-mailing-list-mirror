Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F33C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 12:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjBCMQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 07:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjBCMQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 07:16:26 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F3265F1C
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 04:16:23 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m2so14778215ejb.8
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 04:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om9xyFyMT6HrZ68IqVJAxK9ea/CxcSJCskNYUIGrZYo=;
        b=VuMGhjm0UozK8t/H5TNWBBYq50L+qw93Obr8kMOyW2VsLQHK03d/2br6VTyz7kapRH
         7kqa24oNBZ4izfFxcyeXGWYeRkmDPRJTGbOvcDb/5pMJR6F0qsGBajMIveo0LKHfKe9b
         NYgYEFiJAc9j6pcHOFcUtEocEIeNcPLTgSjeeAR4igJ1L2UMk90LNwEIuCaNf8Tyb7T7
         xbHH3w8/fj56U+eQYpj9PSLONbcmZlXxx4w90ti98w4f51njGhz28sifIN9teRwOLV4z
         wl/YnEdOubSHG23raRrktfyP/IKuTVqcZj6ixBmhM2hBaSl3ZwG07MgvhVkVjRcHj79S
         uHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om9xyFyMT6HrZ68IqVJAxK9ea/CxcSJCskNYUIGrZYo=;
        b=hz5+sEUi1nBo/iRDCXQTH2lyK3/dp89VOeQqFLTcU6q0W6zlxkk6y3IFF3HMfzE2Ds
         wuCR5hYjoI82ePa1+KkOw+L9CLG79TmTVAX8Yu6IrGvbp2dBaqemLJrYBuXjjQ+bGw8a
         HcsCJc577WVgB8LXFvF+2FHOUPkW4oYyoP/SVtnqc9bGb9fdizuVKumnGI9VaFcjw6Tl
         hjmYuu5uMk5oIgoPgdguWMYvPAKf+sNINXqdkNBCMSiZH9KMinScEB+dVPWnwEOjGJy4
         XG8x1xCndQG0yeB4xURhTetrJ0FLBau3zbFUwxIVEhdOX2Y+E6Fzx5bPED2NEJpnoN9r
         qvDw==
X-Gm-Message-State: AO0yUKV5ZxK0ttuHAKpwMk8bdyGlEAquG+vH7tOkjw9QybLJOIQN4OxJ
        oPN0yaJ+yi/mf7kXhrhZ9yk0qF/8Q8hg+92B
X-Google-Smtp-Source: AK7set92clsuGwGjQatVOfuek6mlYRYvzbizo9k7N6dwtWVg2XHZtfzuFjJq+dwOSSZKSsZP+ETUSA==
X-Received: by 2002:a17:907:7293:b0:886:ccbb:a610 with SMTP id dt19-20020a170907729300b00886ccbba610mr2052244ejc.12.1675426581267;
        Fri, 03 Feb 2023 04:16:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m24-20020a170906849800b0088b24b3aff8sm1286313ejx.183.2023.02.03.04.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 04:16:20 -0800 (PST)
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
Date:   Fri,  3 Feb 2023 13:15:32 +0100
Message-Id: <patch-v2-2.5-9a178577dcc-20230203T104319Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.gbe42486b8a4
In-Reply-To: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20230203T104319Z-avarab@gmail.com>
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
2.39.1.1397.g8c8c074958d

