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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B23CC43332
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3501064F41
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhCQSV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhCQSVS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:21:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177AC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y124-20020a1c32820000b029010c93864955so3940660wmy.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnJ3KDudFz8JR7MlAhUceLZ3oXaJi0ZT0ll69csfueg=;
        b=q+vInioQkFgtwNqrxEdAvkgQ5cGYKk6X9IyRnPdHRQLz31ezIqw/sAN+/0CoCX0NB7
         POTpFoyNToDhila3Q+i0rWdT9F4PRwiWSOlmqX/xiXBvffZz4xE8+JzCSy9i8FTGeOQn
         Ib844d1CgKdoWxz0sbh03gzu7JS8crsgVq/jJBc0CPkvc2Bxa5K9h8ChAyfzFcO53YVR
         bVKbHY62RXPrPPYg+IwYuU8POX+n+F0oTuxrejnp6QHZfGRk1bB2L9KYHZuPO45VmswA
         4RdXu0dcMV8CdqzpKqParvGePu907x3kBaddJ7D6TPJ9lvyu8amkAsEmDAh608+znSjP
         /L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnJ3KDudFz8JR7MlAhUceLZ3oXaJi0ZT0ll69csfueg=;
        b=nwM5yhnod6AbBpYd/Ey497CT0SkUGB4PCJMusrDtmip3wtvECrTzKPqMoyUYdLgxHN
         CXNtFpiWeU+YjeDuYYApyFSYGJ0Mh0r9HgfzTZiMMaxPcc4BrmemOxh/t14V8x5E5atH
         6HcgiP/Dt0G1+BfU/plOS7k2m3cpL2g03VDQVn4jkkgkzDJnslvGsGMXKrJfuei9+aux
         NgPS1yj8cSJN97bFd6Q9k9+udNLH1EntQaWM+zszb1/pgQyh5XcPXG78aDBB35owRxnM
         imhcDVBtKWHqG5rpHmAtakIdHDkLBTRwobmpncjhEaQTOERy+RB4n/vIMVBVcMKJqzb8
         kEIA==
X-Gm-Message-State: AOAM533wwPa6gpJbtDZ/fV6joP/ns/VeIURqg7Rcy/Z7zUJFDpvX7awM
        Hf9jcHNxhTh72hPY566JSyvYgsps77M64A==
X-Google-Smtp-Source: ABdhPJx6v5e9RnkctBjPdCYu9F13af3CdfXpWygHxoTbPCoPLfnk/fHng5YtO4yZ2I9MPkjE+Lt1uA==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr112554wmi.27.1616005276138;
        Wed, 17 Mar 2021 11:21:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x23sm3177205wmi.33.2021.03.17.11.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:21:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/19] fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
Date:   Wed, 17 Mar 2021 19:20:42 +0100
Message-Id: <20210317182054.5986-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
References: <20210316161738.30254-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor "if options->msg_type" and other code added in
0282f4dced0 (fsck: offer a function to demote fsck errors to warnings,
2015-06-22) to reduce the scope of the "int msg_type" variable.

This is in preparation for changing its type in a subsequent commit,
only using it in the "!options->msg_type" scope makes that change

This also brings the code in line with the fsck_set_msg_type()
function (also added in 0282f4dced0), which does a similar check for
"!options->msg_type". Another minor benefit is getting rid of the
style violation of not having braces for the body of the "if".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fsck.c b/fsck.c
index a9a8783aeb..2f23255f99 100644
--- a/fsck.c
+++ b/fsck.c
@@ -167,19 +167,17 @@ void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 static int fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
-	int msg_type;
-
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
-	if (options->msg_type)
-		msg_type = options->msg_type[msg_id];
-	else {
-		msg_type = msg_id_info[msg_id].msg_type;
+	if (!options->msg_type) {
+		int msg_type = msg_id_info[msg_id].msg_type;
+
 		if (options->strict && msg_type == FSCK_WARN)
 			msg_type = FSCK_ERROR;
+		return msg_type;
 	}
 
-	return msg_type;
+	return options->msg_type[msg_id];
 }
 
 static int parse_msg_type(const char *str)
-- 
2.31.0.260.g719c683c1d

