Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 218311FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdFHXlZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:25 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36526 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbdFHXlV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:21 -0400
Received: by mail-pg0-f51.google.com with SMTP id a70so20691432pge.3
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8fFA97pkIvg/ZtGpPWjcuLoJ40ytj79ZJ4TAjTGqoR4=;
        b=eaWN48puJyK1ub8xl1RgNSkxnPk42cBEFfkxOMUVwNp/e+VKkZaqdoWyxPEZo3Hr6H
         N4aDUdGQMqVBQ8yW+pFBgcZTFdPKqH3OhunRbmojtUwgAclm2HRym4Ulk9PeRiVmknsa
         JYKzGsnT01o74JcCFJTA4s9psf2stNki9iP+ysGmrB5GnRjpmiIneRrHQQwJpooX2SWP
         /pEq9h1GZkrwpnnuupa6pO5qJr6hm341KOatmEgva0ee7OaPCfy0cd6PYLutALWE0njk
         HKen1AoLX27tCxxyOrvg6jx31NgDZQ0LC1cwH3pw9Nqib7+eO+9B61diAdoryOOf5uE5
         E2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8fFA97pkIvg/ZtGpPWjcuLoJ40ytj79ZJ4TAjTGqoR4=;
        b=h14FmMP/4xJHmBAC88gAcLFlbpqPnn+SK81wB156xzhR+F47hL8u9QWmlENZWRP3mJ
         mkUALbMLa410kBvkEEU5jTNszCQpH+woYD3mocDgeoP4co2miiLKu55t7AswOptWu4hP
         YS5yawVnJG4I0FQHU+uwTYytOC9oFeU8mGemb04lidhsc47/hqv/inosbrpQctW0mnA0
         OHYk0xMDeaxncfm3aiVymIRK8xNgKBEtWomF80mO/rvn41DcTN4MtoFrrn4sGs/3nEQ6
         UMHoL+/70s//edz3bD5G44QCkrmp6Q1O51GVhrExyUeQkaHUfsvGm6nr+PFzy3rPy9Q/
         TW8A==
X-Gm-Message-State: AODbwcBGD8M9vhBlUrpnc+a+v7QOCNikojvEPYz6TdO1gZcAGCympUfp
        c9rcqLsIyaqqSHMHL1cGHQ==
X-Received: by 10.84.218.136 with SMTP id r8mr37236452pli.265.1496965279563;
        Thu, 08 Jun 2017 16:41:19 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 04/32] config: don't implicitly use gitdir
Date:   Thu,  8 Jun 2017 16:40:32 -0700
Message-Id: <20170608234100.188529-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
not set up) added a 'git_dir' field to the config_options struct.  Let's
use this option field explicitly all the time instead of occasionally
falling back to calling 'git_pathdup("config")' to get the path to the
local repository configuration.  This allows 'do_git_config_sequence()'
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
2.13.1.508.gb3defc5cc-goog

