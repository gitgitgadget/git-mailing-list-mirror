Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD2CC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 12:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A285610EA
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 12:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhDOMed (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbhDOMe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 08:34:26 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3158C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 05:34:01 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r8so38790913lfp.10
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nbCtY6+gFzAXnUf/rkTs0zSlv+18A3clXj4NQp8AeBo=;
        b=dd8/NGOCCTyKq9x82X9G4Rmsz9efiHMEmOXk1S9jWvwGDAXJvKFeoqv+r0vr3jONHK
         ZgHPxCVuL6q8ot1OJfcTQGjGmb1jFhGOL6cvXOJhnRFlEmrSAzxKmXKdMZjMarART0EU
         /SfA6KpQWyqAttuzfih5SbICSMcFEN8fMGPYSmqzkUmzNn5bwPDCUY4Ds4jZchZp0AEc
         ukWMtrE238MwjTon9WbVj+znAK+1PyCyDWlvCSvEBpJB/WaYfjJOKIG7v0dQ/HcXJ9Wr
         gLRnEU73XyIySHeMfWNoMN9ZasgzFawkBQok4RPId1blt65qlPPlROdmQYrss45bLMRd
         zunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nbCtY6+gFzAXnUf/rkTs0zSlv+18A3clXj4NQp8AeBo=;
        b=DHpzh6GlGA7BYl05nadI8CEJHSQOzEjL7MoPYsks1dLY/0G9SfDUaX0JnFwsRI7I4g
         63mUqDhawcDLkXCd4aa3XAp4Be6r73yhnEfDijewre/yoBWbyUWLn+6i7Ml2FgjQ/1go
         t58hJWrV9+rbDX5dZVdgTEBQTtEeunzoet0OW5fcgX4OIJvqpmMf19/vBDyEeD83LbcS
         GdeFSqlCPHDL/iLs8Qe+pZRxqj/ww4LxlyzSGtG0NoUBNqGcnBjCZvESSYNeNgxlunwU
         DNC6MR1OLBkRjyyj4/RBi/uCxJV0HGucRWuEzK0txCPA4MUWkb+TTxHuMlzZ6lvqy9Do
         L1GA==
X-Gm-Message-State: AOAM5307h0lb/3TobNZOo64RPw0CgQcIzQvL8InF0ng2krG9r8zzHTSF
        k8XJ2QF6ArTDfMu1szOiYj8BiEvwl3ySAA==
X-Google-Smtp-Source: ABdhPJxW/Sn1F09HO4EN3hzVK7lK7BeZo21YkdzdVeXDd7Srzq3FRp848vPpqL4XuwSmBoeB8ycYCw==
X-Received: by 2002:a05:6512:3188:: with SMTP id i8mr2503884lfe.265.1618490040002;
        Thu, 15 Apr 2021 05:34:00 -0700 (PDT)
Received: from raspberrypi.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id c2sm648965lfi.143.2021.04.15.05.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 05:33:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] transport: respect verbosity when setting upstream
Date:   Thu, 15 Apr 2021 14:33:53 +0200
Message-Id: <20210415123353.14686-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A command such as `git push -qu origin feature` will print "Branch
'feature' set up to track remote branch 'feature' from 'origin'." even
when --quiet is passed. In this case it's because install_branch_config() is
always called with BRANCH_CONFIG_VERBOSE.

struct transport keeps track of the desired verbosity. Fix the above
issue by passing BRANCH_CONFIG_VERBOSE conditionally based on that.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
 t/t5523-push-upstream.sh |  7 +++++++
 transport.c              | 10 +++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 9fbe7f784d..fdb4292056 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -119,4 +119,11 @@ test_expect_success TTY 'quiet push' '
 	test_must_be_empty output
 '
 
+test_expect_success TTY 'quiet push -u' '
+	ensure_fresh_upstream &&
+
+	test_terminal git push --quiet -u --no-progress upstream main 2>&1 | tee output &&
+	test_must_be_empty output
+'
+
 test_done
diff --git a/transport.c b/transport.c
index ef66e73090..62b6eeed21 100644
--- a/transport.c
+++ b/transport.c
@@ -108,11 +108,11 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		if (!remotename || !starts_with(remotename, "refs/heads/"))
 			continue;
 
-		if (!pretend)
-			install_branch_config(BRANCH_CONFIG_VERBOSE,
-				localname + 11, transport->remote->name,
-				remotename);
-		else
+		if (!pretend) {
+			int flag = transport->verbose < 0 ? 0 : BRANCH_CONFIG_VERBOSE;
+			install_branch_config(flag, localname + 11,
+				transport->remote->name, remotename);
+		} else if (transport->verbose >= 0)
 			printf(_("Would set upstream of '%s' to '%s' of '%s'\n"),
 				localname + 11, remotename + 11,
 				transport->remote->name);
-- 
2.20.1

