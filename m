Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8590C2B9FB
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14E161261
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhEVN7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhEVN6y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6BC0613ED
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a4so23772188wrr.2
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=juZn1iwAaJab6sNAP3JmCQ0mmV46nXh55l2jz5p/6IE=;
        b=dnd/aFeE6pzuqfox1lapuq/RCBbOi6BnNuyC1uI0WgV94peENPhdJ0DUuCiy7wH3rx
         BgtVcCBhyqns4g8amzH5dxnZlHSXOXyR5inTx1cZGD9wSXMWEcxWj5KrzP7f34KPeYR2
         6Mi+Bm6Vy2RrjtU38dt0oCku/hAjKs4zzo/a9Gk3OjlvSYv8lLAMDTw4ZMlxIr0IOoTb
         7l/B48oKzZtMnOcHAt04RpxKbhJE+linAyLtRvIJW/Aa3V9Vc0DsChDcyl4LXf8dj5gU
         qsERW+cAhLIqFuXBl+sfQ2xkgPK+YPKL6dCKaP9PQuM3JGsBpvg82PtTE/Ws7915azZn
         XVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=juZn1iwAaJab6sNAP3JmCQ0mmV46nXh55l2jz5p/6IE=;
        b=SQlqyTdJ/C12f9cSvStCZyViJX/sVP2UL6cNPCou20SDwk8fQCy8RQQqOqvs5ckDkW
         bHMmFA+gU3xRx1IrkpSrrArJIHdo3TvzAd2J9ThQ9mFUtrCKGwqGhMDU71KCs1vKxATa
         2mvICkHMotcpxbWnpz9JLwtCZSxnJjt77MGyfqF+DYMn7G7N9UzKGyY4emVbd/Yp8WRg
         ORSOPG6m9CCHPfq70SlP+qFJ+H1VeVyjAMlOHb+r20FZdmW/7TcoDeo0Vuu8Y1eXe21O
         /8+Wh3WcFqLoa12a6oLTDCr4XY7NIjvKo+YOZ+1OC2NZYmE6N0OOtdwRSkKipq8key+M
         uRIg==
X-Gm-Message-State: AOAM532p9Kdil6CQYnaLXN1JMUFxWESjBOASDb+E1Qxu96KxY+g9cr6v
        ae3phIhRqKQjrZXIv1l4m81YbYOIups=
X-Google-Smtp-Source: ABdhPJyYS10QNuy0Vr2wz1rl7/3SmgSR0GyQ8KphL1SIDGidmV3Ibs/LfAIo0VbV8C8l/F6YOl0M2g==
X-Received: by 2002:a5d:48ce:: with SMTP id p14mr14601289wrs.170.1621691846724;
        Sat, 22 May 2021 06:57:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u132sm726970wmg.31.2021.05.22.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:26 -0700 (PDT)
Message-Id: <5b035c6e0d60157cae5da515a0b1ae366fc38e30.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:57:05 +0000
Subject: [PATCH v2 26/28] p7519: add fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Repeat all of the fsmonitor perf tests using `git fsmonitor--daemon` and
the "Simple IPC" interface.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 42 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 5eb5044a103c..542ae61c99d2 100755
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
@@ -174,7 +181,10 @@ test_perf_w_drop_caches () {
 }
 
 test_fsmonitor_suite() {
-	if test -n "$INTEGRATION_SCRIPT"; then
+	if test -n "$USE_FSMONITOR_DAEMON"
+	then
+		DESC="builtin fsmonitor--daemon"
+	elif test -n "$INTEGRATION_SCRIPT"; then
 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
 	else
 		DESC="fsmonitor=disabled"
@@ -285,4 +295,30 @@ test_expect_success "setup without fsmonitor" '
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
+	git fsmonitor--daemon start
+
+	trace_start fsmonitor--daemon--client
+	test_expect_success "setup for fsmonitor--daemon" 'setup_for_fsmonitor'
+	test_fsmonitor_suite
+
+	git fsmonitor--daemon stop
+	trace_stop
+fi
+
 test_done
-- 
gitgitgadget

