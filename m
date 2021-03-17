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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA0C43332
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C0864DE5
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhCQU5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhCQU4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D36C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x16so3243708wrn.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZxdZonIIkiEgqwFHMeBDrDZ/VP8Vwk4px6+a99sgrYc=;
        b=HCxfLcCSWR1p8+pJ2yPTLEtMaYm3ekGa9oVULHz9qjG9UJZqBRpWNel9hwyv91n9rW
         zLopxjF/wWc5cc2HxDbWA0Of/t0e1Hoy7LeZsqH8lky4HbvmCr1ogyutnf9pdi3UbvXC
         P4WeYUfOXD+k3a73td1kBAkHM98oOL0FPj+ltHLct23yA5myH3k2nZYJljST7gocv4Mz
         AezK7lvy4u/T4Ul3A4aFUCWkl0GBxzi+U3HIipqXynIxYuaQVbyoRN+ui4s21W6TrHGf
         PgbRvIBlFvKjtBjEHgmnVfXJBNABBQm+/TYyFw/CzwN7HQ3bHF7XtWsOCYBYRNsaPTTO
         bL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZxdZonIIkiEgqwFHMeBDrDZ/VP8Vwk4px6+a99sgrYc=;
        b=TcUbm4gS4F6M8Kt1FktXtf7Q9ozTXc2O0yxwZ6QNerNaADUV6bTjTi85mJ5mnv3d0Q
         NAMUf//rCuNeGvXbwolHfE7IU1IwYDcp/kwnYUZtlm7ht+A5tv2weYbzh6/2TArjvMaq
         yKtX3h3lHx0wwnDY6f9Jk038e0BP3vE9vwHeXNEAOJv09p6Zc74atyP9NN/5C8/64JhJ
         1RqlR2KXIJpDn46vrWOBZ434pJSCGuOcIE5R4P2Cbi0dpnaKYbzs31h37HFMedxHYIHM
         7qotqInfe2Nl5dfTDO5LFEy7vUEhcnW3r8j+RGtYZy3L170Xwf6kN5HMmYvckZsQ6KDb
         lEiw==
X-Gm-Message-State: AOAM531+DOzRwtfFiG7JYsg/hvVcgpD36du2Oh06GeF8NzUwLUhCBFOr
        CGPQ3nugfgaCMhaPbNceBbDxlWjKPkY=
X-Google-Smtp-Source: ABdhPJzo4xgr9kNWU5brFkCp3/IpjqR0gO0U9GGa2hfXsv6jpSqzY0fMEP/RLaklhcjK6j3RxXRv6Q==
X-Received: by 2002:a5d:4708:: with SMTP id y8mr6520756wrq.382.1616014601317;
        Wed, 17 Mar 2021 13:56:41 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:40 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 05/15] merge-index: drop the index
Date:   Wed, 17 Mar 2021 21:49:29 +0100
Message-Id: <20210317204939.17890-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an effort to reduce the usage of the global index throughout the
codebase, this removes references to it in `git merge-index'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge-index.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 70f440d9a0..49ddf3f9cd 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "builtin.h"
 #include "merge-strategies.h"
 #include "run-command.h"
@@ -38,6 +37,7 @@ static int merge_one_file_spawn(struct index_state *istate,
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
+	struct repository *r = the_repository;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -47,7 +47,8 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	if (argc < 3)
 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
 
-	read_cache();
+	if (repo_read_index(r) < 0)
+		die("invalid index");
 
 	i = 1;
 	if (!strcmp(argv[i], "-o")) {
@@ -69,13 +70,13 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "-a")) {
-				err |= merge_all_index(&the_index, one_shot, quiet,
+				err |= merge_all_index(r->index, one_shot, quiet,
 						       merge_one_file_spawn, NULL);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
-		err |= merge_index_path(&the_index, one_shot, quiet, arg,
+		err |= merge_index_path(r->index, one_shot, quiet, arg,
 					merge_one_file_spawn, NULL);
 	}
 
-- 
2.31.0

