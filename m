Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6EB20133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbdCFVIk (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:08:40 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34013 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932086AbdCFVId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:08:33 -0500
Received: by mail-pg0-f54.google.com with SMTP id 77so26120607pgc.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+stxkB16UR0WhZMnDeVOrviOq/1N4LpAnz4kQUUDuKM=;
        b=VxueOkjpl27ZSnmFM7HpPkqPtyYxvUxKCQzK8KdGBXPjzuMamdAtgCrQvJ8dVYa8NQ
         ulSwNOq9ablLmAuOmC5Jri8DLb56waiq1qsw5+NPoawoeKhB4+WVP5a0kHcW3JlAU1L9
         zw52GdjBAK3AfSxjbiQ9bPPNpumDQZMYM3h4f669AUKUWuZ+Gl5hkKf5ynd2z3E/g83j
         PsRIUqVDxd+fVqnDTJ8MT8/fnIzVApRtv9UAbYuJ+6Q5sq7JxJhnF0o6xSio6CN37gqW
         x5x/yLDA6lWI+mFJDITRnaWX8J/L9i3VMjF+8Y1F5Tk9rGmCMqtyqDGgj1E1fhHsP2GI
         zAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+stxkB16UR0WhZMnDeVOrviOq/1N4LpAnz4kQUUDuKM=;
        b=LxI9ZkpkimUQg/sarT+oz3M01iIQsXWYDRq9kkPmHHoRZbPc233UNfGIlZ1pcuAnlc
         qUS/OuAewELhefPCbXAcCbYjycHDc3dmYTX7awck7AMbHA2LPMmBKk/Bat0poYCvdOTs
         InMrZdwGwrmqiLJ8roB/snIIY12NPDO//e/nB/7V++ouyjok2/XLykHC4KvbQ2+KoxH7
         FGYBYd+pZeR1YnYrHY9IUj1+QYTail41sT3OnLGEfiDThvUF7aiXWcX4ag1uZ4sVgZXz
         dowZdxAbeRUg5ajqVwVpRInyQm0hHuMDzLOmhA46a/H8shQyCuKrGm77XqYCthfvKr8A
         oW5g==
X-Gm-Message-State: AMke39lcc7pd4Kxmb+YTG1EcV7Pa4j6geEaRykghAwau1Oj0yNRNgR7HkrW03qu8B8lvXgja
X-Received: by 10.99.112.75 with SMTP id a11mr22551081pgn.7.1488833977420;
        Mon, 06 Mar 2017 12:59:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id q90sm41300195pfk.73.2017.03.06.12.59.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 11/18] update submodules: move up prepare_submodule_repo_env
Date:   Mon,  6 Mar 2017 12:59:12 -0800
Message-Id: <20170306205919.9713-12-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we need to prepare the submodule environment with
another git directory, so split up the function.

Also move it up in the file such that we do not need to declare the
function later before using it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/submodule.c b/submodule.c
index 8b2c0212be..0b2596e88a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -356,6 +356,23 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 	strbuf_release(&sb);
 }
 
+static void prepare_submodule_repo_env_no_git_dir(struct argv_array *out)
+{
+	const char * const *var;
+
+	for (var = local_repo_env; *var; var++) {
+		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
+			argv_array_push(out, *var);
+	}
+}
+
+void prepare_submodule_repo_env(struct argv_array *out)
+{
+	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
+			 DEFAULT_GIT_DIR_ENVIRONMENT);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -1390,18 +1407,6 @@ int parallel_submodules(void)
 	return parallel_jobs;
 }
 
-void prepare_submodule_repo_env(struct argv_array *out)
-{
-	const char * const *var;
-
-	for (var = local_repo_env; *var; var++) {
-		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
-			argv_array_push(out, *var);
-	}
-	argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
-			 DEFAULT_GIT_DIR_ENVIRONMENT);
-}
-
 /*
  * Embeds a single submodules git directory into the superprojects git dir,
  * non recursively.
-- 
2.12.0.rc1.52.ge239d7e709.dirty

