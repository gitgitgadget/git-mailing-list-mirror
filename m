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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB1EC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8353E611BD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbhE1MO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbhE1MNh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0658C061346
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so4425139wmf.5
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C48NOrtXqZ8LJ2Cu1DC9QJu+9kYGnkR+sIoDge4AOPQ=;
        b=elXKzD/69G8hiOHZT5n0eGVUwXyUeAkR7qhGxgGFtySaxff+kljvOusWAhAw6z5CCr
         Eo478THmrORzkJS3R2ubUrv1rPUHKwdk58sdCXRRkCnNLDXYMzdUb/3D4C9HqO65F/1F
         vVx/97XOQCIk5r3ekY62TBbxTqRY3rDwuB9JL5pQSUGgdk8L1mLsoqTiBnv/o96EFsy0
         skkJI8onalahiybtX5oyzIbgW0+phrC1ZVG1szMa/81LKZyu8ztPg75PUxhbMvNJ/zYA
         lPykK+HzGLzAEs0cu8Wcz5gpeyvRh2EgXugbUZzH/BVyexfPEVCOq7L9c7xh9hg5sXgY
         5JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C48NOrtXqZ8LJ2Cu1DC9QJu+9kYGnkR+sIoDge4AOPQ=;
        b=cNx1dw7IQQJ9C/+kp6xFRTL/lFEBD23O1/WrnVFT+AIYh3wVX85+pyPUi1FQXpesZV
         QRpFW7MOgkrm8lMEYBuDzrvFY5CzQPZFNH+/AZWmmpwqsdS10bCqrOudPmICBKI9k6uz
         yDK3tiAmmA179xXiSWsD1eOape7C6iRpt6G6boxRb/y//hGYLQC7UuRkyXY5i+XE/iny
         jzf4nYkQSUHSZQNvuyQ68amPpr310Sydv74El+NFRm/m4ZXo0ot2s1ysjQ8b9IiY5RP8
         lpbsP0lYsRoroifhUSmrNeguqPzJM5WlFYXY0ArTMvMp0bh3jfsLebcA3TUsjlhh9yP7
         dpmA==
X-Gm-Message-State: AOAM532N5aoUBeVQxOjhLl1ybjhvLTqpjOmIBQxUqqeaf/y2VVXV/h6s
        orJ5uqivAICFordQtwbhdJcmw9kUDz3JAA==
X-Google-Smtp-Source: ABdhPJxZkjeV7Lb5zGjcDyVJJi27g722/dqKGTJldgNjWgmxFmSv9pI0t/2HvaGuHL3kq/43+YhyRg==
X-Received: by 2002:a1c:f717:: with SMTP id v23mr13050815wmh.32.1622203916148;
        Fri, 28 May 2021 05:11:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:55 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 17/31] run-command: allow stdin for run_processes_parallel
Date:   Fri, 28 May 2021 14:11:19 +0200
Message-Id: <patch-17.31-7020cf10c8e-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
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
2.32.0.rc1.458.gd885d4f985c

