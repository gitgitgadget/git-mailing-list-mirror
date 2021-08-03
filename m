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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080C2C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E935760BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbhHCTkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbhHCTjv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0086C0617BB
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so26504189wrr.2
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbWqkuv0PyqhDLloi7TIGIcoxvgpIrHZqEfmBs1BDF8=;
        b=tfSu5b3TOpGpl5L8M6xhoyNBL5gETUiG9JO/PkW29CnBEr5Oo+V0xm+8AzboIUhM1t
         D7X8spqiF9eYlsen76Ethgq+olquM4TKOTAjSv7VpA3IEd1/Wzfbi8U7Rr3iqt5bRsQJ
         gtQMeeQv0zKPEdu5Tw7PRqZ+BWspPe93avm5zWEFhNhzQZ9HYNiR5AaScdW9qeb4ZUhJ
         x2eKJyPC4ayiX3w336j8kRsCWiP686OXD4d2V0TFjNZdplKNOvyXpF5CvmSzZ2DIsDwA
         gqrgQS2RUE7oB53x+SYseljIjmi0QOHG7xOvdk62NSXN74mZEhB75u4rJrzE2GvyRmaa
         R+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbWqkuv0PyqhDLloi7TIGIcoxvgpIrHZqEfmBs1BDF8=;
        b=Ks0SLxoyBF4xkhnBeN9MV7EjRhZtmTCDzOeo0scroytFQdnd9s2DHWyx4cZfhoZOjG
         yzWd/XMJWSdjosSagSG8nzGOrqWUUmHIgVV2uYEgaU6ds0/ORElL8qnXgx5HDdk/z+hK
         YGl8ofUoS8/ISXweKBmsaXXAb7lXgOGH8SL8+lnOajzyviA75U7jTrY616wM/2mE9pDy
         Lape8dQ13Lpm0PddWC/86pNlWK/zi+DV/BtwRqtXbrja6lwqWm+xfR69QN8xvEAKtlfB
         uSRu7pxfvIOgKqggJrXkFKTKfkzyVZE/LbET9CKoAfw8uIm0xrrtzhh67G2nbligqcHe
         uv9g==
X-Gm-Message-State: AOAM530Unp1zS2rcSeXYpyL/qfcSZLJuwEFj+coN+1o+jpuNZFBWQdY2
        TMjUzhoY9rQIsDI9eHzlqn9YoSFEAkWlbQ==
X-Google-Smtp-Source: ABdhPJw5CRdzX6T/ugmkuw41fGv4qYG5mJqyci5SOKTrTUXD6zz5WzOAfIYXgC5zs6hSOcza3oNBXA==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr25624692wrq.98.1628019571229;
        Tue, 03 Aug 2021 12:39:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:30 -0700 (PDT)
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
Subject: [PATCH v4 21/36] run-command: allow stdin for run_processes_parallel
Date:   Tue,  3 Aug 2021 21:38:47 +0200
Message-Id: <patch-v4-21.36-1028e0c1667-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
2.33.0.rc0.595.ge31e012651d

