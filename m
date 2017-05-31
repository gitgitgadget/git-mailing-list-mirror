Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7650D1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbdEaVov (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:44:51 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36863 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdEaVor (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so18544487pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ONjwUQUU1qj9gYCHNDPyWQPakI+/s2C7OMb1wVmjG9o=;
        b=EMcZdUOD4P1KKQF1E3IQ7Qs8zxGsZiVfsJp63TIsnqCUy5VJJIPucQtL/khh7n0bAQ
         ctq87ppbIha4lGTZWrvJFKDEF6IXTD1R0jGyorZ1XnlA1MjWTnv7CS7nCZ7sR7NgtpBZ
         bsgjE9V9RoNv9bGbP+aaqEFbu1KlAiMq16zUdgejlDldS4DJYP5OEFSiOVtwWEdOtxRx
         qDusN4adDA+L7PHdpxG4soWyw2RFUTU5DEWmHp+EVfeH/+UmCGZBbOqbPrWt2qUBjhaU
         zivCtWyum3F0PiXKGBpMkdff2rcKz2WRAkOgjtpntAdMvquLo87+WwhR7OJugHqqr255
         lSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ONjwUQUU1qj9gYCHNDPyWQPakI+/s2C7OMb1wVmjG9o=;
        b=ObTjwtLo4mdvA0uMeAH9jJ56oQJYSnmPA102oKhA2bkrLz1anYTR1l1wAbJYbKn47c
         u1CD9TWO/QfSBWsRBWhWwKXz1O2NzbYzMbsPHeDiKytb1VQUibqHTuAfBtaWojDU2FsM
         2Zvu6pWi5mwhBbzd+XyQ5P2YwX8PbxX4BFk7oLDc7gEU6SXpQ+uC90nt95hhWfKoD18v
         10jOYz5g86UuQtMMlfIPYP4bKaTLyx4pQHexp1UxmZBogIJ6nWtHuN6I+y87b69Pmx2L
         88eIQHx7ffnnLZeZDADLWvuClwW4v6Tt31/HPyYHm2t57y2Fm9tsY/Yj3xdmidagaMQ2
         AkIA==
X-Gm-Message-State: AODbwcAIF83iE4PtMT044M0pPHOjSPWanrshq7If9hgHZKiOOCrHut8x
        +1a9KSkNIkmBhSi3bzuxOA==
X-Received: by 10.99.149.70 with SMTP id t6mr28194415pgn.168.1496267075894;
        Wed, 31 May 2017 14:44:35 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:34 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 03/31] config: don't implicitly use gitdir
Date:   Wed, 31 May 2017 14:43:49 -0700
Message-Id: <20170531214417.38857-4-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
not set up) added a 'git_dir' field to the config_options struct.  Let's
use this option field explicitly all the time instead of occasionally
falling back to calling 'git_pathdup("config")' to get the path to the
local repository configuration.  This allows 'go_git_config_sequence()'
to not implicitly rely on global repository state.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/config.c | 2 ++
 config.c         | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 753c40a5c..90f49a6ee 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -539,6 +539,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		config_options.respect_includes = !given_config_source.file;
 	else
 		config_options.respect_includes = respect_includes_opt;
+	if (have_git_dir())
+		config_options.git_dir = get_git_common_dir();
 
 	if (end_null) {
 		term = '\0';
diff --git a/config.c b/config.c
index 2390f98e3..ff09b27b8 100644
--- a/config.c
+++ b/config.c
@@ -1548,8 +1548,6 @@ static int do_git_config_sequence(const struct config_options *opts,
 
 	if (opts->git_dir)
 		repo_config = mkpathdup("%s/config", opts->git_dir);
-	else if (have_git_dir())
-		repo_config = git_pathdup("config");
 	else
 		repo_config = NULL;
 
@@ -1613,6 +1611,8 @@ static void git_config_raw(config_fn_t fn, void *data)
 	struct config_options opts = {0};
 
 	opts.respect_includes = 1;
+	if (have_git_dir())
+		opts.git_dir = get_git_common_dir();
 	if (git_config_with_options(fn, data, NULL, &opts) < 0)
 		/*
 		 * git_config_with_options() normally returns only
-- 
2.13.0.506.g27d5fe0cd-goog

