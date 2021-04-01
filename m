Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF6C43460
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8166112E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhDASJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhDASDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:03:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A661CC02D54C
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so2267093wrt.6
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pjP4NA613LnanIGMR60vr8n0/EEt96pfhyIvjLJC8jU=;
        b=TSkjy+56g/uUW4wC4UWKbW4Uk+0xgJUxFxNJi3bZntwDxzFv6gXqhAFEVwDJkl6/96
         Kbs/n88Scb3N1PZ4CUEgpMAbrQBsUahZzQS6kmGvUu5eh4BIicwNjDNGz050waODpyrn
         3Kn8cAM07pMnZkxPEloV9HS9kAJ+/gcrVlOZUcPU/nfQWsnnyLobh+Jo7gljS0wo77vv
         uWDUx+x48nd7WzDhwRVgo3mCoxE0MefKTGNV7qC+HUTtSbopdvOJ/bp+a2iu6mWeB0Je
         xN2kqsh9WPyHoxz/IwrsJb03vN+G1mnQWsVARSoFi5yOp9UBVWHuK4/M0Qjt/eY3YF0a
         3j7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pjP4NA613LnanIGMR60vr8n0/EEt96pfhyIvjLJC8jU=;
        b=CmCkKAleSxvPMxr1RkvX6+OmcH/5GRhfCosLDQ7eJ/tQMy+Y5Xi8+3kzuDtSfnSoUe
         lVxfEsSNn2RbSZmYktFdguEqnsHZDM5n6+lOnwi/QXqfKXrAf2nAV50ha/M588k0LNp9
         w3dCXX1/j9YU7578F8ZG/1ToK4S96XtLNnDbRP6rLNOjFQ8ORg3oU85gCHwFwLTgZo+N
         1Xm6bI9VSp8cHBy7rwqUU3fjGkBmBRzRbyVi35Im6cE9ERvsiDQX+tkDAMoehvhXF4d1
         7eK48Gga5yfGdtJAHv+GrLr61B+lpta3bv3Jnyz1lK5vNEbjHMQNnEUinP8NBmCB92y/
         ktEA==
X-Gm-Message-State: AOAM5320i70MfDF78X3LrnJH5LL0ohFx0hqrWy+fETmh6dEs05j3zMHw
        47Y8v1IEeOx1d6vpLfUGsz+9rD0Hs3U=
X-Google-Smtp-Source: ABdhPJycqP6yM8lO+9pSIa0n4J0gDG9vmP3GVuFRF43KoQ8SG8uQSo8FaWJiYFr4d5b6qiWb3XMYaA==
X-Received: by 2002:adf:d207:: with SMTP id j7mr10420576wrh.150.1617291681497;
        Thu, 01 Apr 2021 08:41:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6sm10646158wmm.0.2021.04.01.08.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:21 -0700 (PDT)
Message-Id: <da5094e52032e28337cfcecd421dedb560952869.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:41:04 +0000
Subject: [PATCH 22/23] p7519: add fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
the "Simple IPC" interface.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 5eb5044a103c..2d018bc7d589 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -24,7 +24,8 @@ test_description="Test core.fsmonitor"
 # GIT_PERF_7519_SPLIT_INDEX: used to configure core.splitIndex
 # GIT_PERF_7519_FSMONITOR: used to configure core.fsMonitor. May be an
 #   absolute path to an integration. May be a space delimited list of
-#   absolute paths to integrations.
+#   absolute paths to integrations.  (This hook or list of hooks does not
+#   include the built-in fsmonitor--daemon.)
 #
 # The big win for using fsmonitor is the elimination of the need to scan the
 # working directory looking for changed and untracked files. If the file
@@ -135,10 +136,16 @@ test_expect_success "one time repo setup" '
 
 setup_for_fsmonitor() {
 	# set INTEGRATION_SCRIPT depending on the environment
-	if test -n "$INTEGRATION_PATH"
+	if test -n "$USE_FSMONITOR_DAEMON"
 	then
+		git config core.useBuiltinFSMonitor true &&
+		INTEGRATION_SCRIPT=false
+	elif test -n "$INTEGRATION_PATH"
+	then
+		git config core.useBuiltinFSMonitor false &&
 		INTEGRATION_SCRIPT="$INTEGRATION_PATH"
 	else
+		git config core.useBuiltinFSMonitor false &&
 		#
 		# Choose integration script based on existence of Watchman.
 		# Fall back to an empty integration script.
@@ -285,4 +292,30 @@ test_expect_success "setup without fsmonitor" '
 test_fsmonitor_suite
 trace_stop
 
+#
+# Run a full set of perf tests using the built-in fsmonitor--daemon.
+# It does not use the Hook API, so it has a different setup.
+# Explicitly start the daemon here and before we start client commands
+# so that we can later add custom tracing.
+#
+
+test_lazy_prereq HAVE_FSMONITOR_DAEMON '
+	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
+'
+
+if test_have_prereq HAVE_FSMONITOR_DAEMON
+then
+	USE_FSMONITOR_DAEMON=t
+
+	trace_start fsmonitor--daemon--server
+	git fsmonitor--daemon --start
+
+	trace_start fsmonitor--daemon--client
+	test_expect_success "setup for fsmonitor--daemon" 'setup_for_fsmonitor'
+	test_fsmonitor_suite
+
+	git fsmonitor--daemon --stop
+	trace_stop
+fi
+
 test_done
-- 
gitgitgadget

