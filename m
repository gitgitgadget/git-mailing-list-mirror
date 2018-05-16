Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58FC1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeEPWVt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:21:49 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:45467 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeEPWVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:21:39 -0400
Received: by mail-pl0-f41.google.com with SMTP id bi12-v6so1224519plb.12
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p0wJY60iTObA6LNYp378UUuPlK7p7IZOaLo+0KEp5ak=;
        b=B5TXiA5M6PT4soygH3em54XWJhknB+fueruttwBs8OdDpVpUTbn6ULx+voz8A5ijbL
         WnXj3C05Dr9mgq988ZT/Im05FW0z2I6JnBcNlvzAYNksMt+B3W9TaBu58OPEpGuYNVVM
         vepghhGR0tlIhERCgQtgWhn+O1En+EFp5G7vbO53gmHTuFixycNZWAljbYDKCCnzjvbR
         6vLvRHdRAlB/+zimE8/wtcYZILIWhAnN+MiXjSrY1/rwSfJJey1Fr0AtymEW8Xt6xkOn
         RjXe8y6MJN1dsxdZ7u7damjOO302yNhaPIuboClXLBfqcVzA5HF0+Oacu+6zYYkIPZnk
         y+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p0wJY60iTObA6LNYp378UUuPlK7p7IZOaLo+0KEp5ak=;
        b=YC1T2eoIXReuJhxpp4NrXAx4RJYDoWRcqx45Ua0cNa8MzZUsk48dlzRSmfAA2gfz7B
         AP8L0Wdpj9pKonYFElFoY2wtwPJPJihkFJDdHw2ZASWgzb4XFvKo+WdSXF+BUJ0n184f
         UpaGAVTSC1SRANXkY6nGJoTyzD2MeZh4KDs88sxlsIAcAJWmkCPkrTTeTrU8GHorqHwb
         dZg6OXr39y4mYS4FJt/HO6Vae8IXJtwAegPEGgONOB/KBpd/TyDdECdVEFsTpUvyM3wY
         vrXnpeRSPqrdcXRJotEwmGyNhPq05kMMpXEY8yQ7X9lE5wfTGwYU4D0rNLE1HQudVwyz
         Itdg==
X-Gm-Message-State: ALKqPwe5bM2dW64YADhH3LIGC+4UAxzSR8Vdyf3S0o5eulrf+dIGYTNj
        vxG6r/dn/cMvoEMfQ9lDsP28Bg==
X-Google-Smtp-Source: AB8JxZpU/aIMo71P/leDGJWeZaRKCHFaB05R6OfesFlSNyyKEVeWYTQ8p6JYanwbZi0gtyVD2MqpMQ==
X-Received: by 2002:a17:902:bf4a:: with SMTP id u10-v6mr2734056pls.322.1526509298478;
        Wed, 16 May 2018 15:21:38 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z129-v6sm5237977pfb.108.2018.05.16.15.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 15:21:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     ao2@ao2.it, bmwill@google.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com
Subject: [PATCH 05/11] builtin/ls-files: use repo_read_index_or_die
Date:   Wed, 16 May 2018 15:21:12 -0700
Message-Id: <20180516222118.233868-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180516222118.233868-1-sbeller@google.com>
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
 <20180516222118.233868-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite ls-files being a plumbing command, which promises to not change its
output ever, and to be easy on machines (e.g. non-localized output),
it may make sense to localize the error message for a corrupt index
nevertheless:

1. that is more consistent with the rest of Git.
2. Searching for "ls-tree corrupt index file" on the web doesn't yield
   any hits, that suggest the exact string is parsed for.
   Probably the script authors rely on the exit code of ls-tree anyways.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/ls-files.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a71f6bd088a..502f2f6db04 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -20,6 +20,7 @@
 #include "run-command.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "repository.h"
 
 static int abbrev;
 static int show_deleted;
@@ -210,8 +211,7 @@ static void show_submodule(struct repository *superproject,
 	if (repo_submodule_init(&submodule, superproject, path))
 		return;
 
-	if (repo_read_index(&submodule) < 0)
-		die("index file corrupt");
+	repo_read_index_or_die(&submodule);
 
 	show_files(&submodule, dir);
 
@@ -579,8 +579,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		prefix_len = strlen(prefix);
 	git_config(git_default_config, NULL);
 
-	if (repo_read_index(the_repository) < 0)
-		die("index file corrupt");
+	repo_read_index_or_die(the_repository);
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
-- 
2.17.0.582.gccdcbd54c44.dirty

