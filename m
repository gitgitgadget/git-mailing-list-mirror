Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443741FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdEaVo4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:44:56 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35952 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdEaVoy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:54 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so18549893pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iJ2Eykn1ewOk56qa2amxq5WGBZBv9G+Aa1wBxM1T3TE=;
        b=h4VjvT0OwbwfpxFYCfCAoTSIBq1ytaLS3kR0ysiRYr5nSaXXKpMrmNA4hQqWBGFGnG
         wR5AU9O0jt0ubW/aBJ3BGYs8wHp13aFQI/7fom5hNhGx4DUcFixl2VRB14dETN98GmZh
         ODBl2R28b2Vsr0bUX+RAQOX/uW9oTY/zEPgn1kBAEPX4m35bVesqfCD9QCxwn3WFZwJI
         aaiES3mNH3K+YlkK7uz7d3uhGxTTTckmfPaatM9AQHPy55C8rKbppYeIiEo076p3rytx
         S/deWep223iTXsUd3eSBT3SZZYQWAWPTqwRJRd13xewnY+5TNPIwqZRj49qFtGTm+yzO
         nfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iJ2Eykn1ewOk56qa2amxq5WGBZBv9G+Aa1wBxM1T3TE=;
        b=LEJLq5zFk2/DBgrHMcIsMemPN3vM9TO2NQ8+t+tsEXc6RWjWKx0j1OoFj4Mq+hcFYQ
         fil7dBETDqyG7T2TiNpIFS+4u7VQxhSmtFI8d5GVRDH/V7+NUcb4wtqiep+0hJEidu4c
         IRXSDKnzsip4fRgfPdwSfBnfURL9CkFYI2O3KHVwd2dqv+DRKiPTTc6FkOQ9ShmYagjj
         6vuBAB1qmVktePNlzcN89kUIdQVwSeJCP2NZK2MfrJqNsU4PtIkmIZUrYjNC/QR1hfVZ
         3pQUMFnmZVyEedqYdOSa5q68Y18BuS4QL6I7DGVAeOdoIfPIjHfaP45jaxvQVuKKwTsb
         jPog==
X-Gm-Message-State: AODbwcAAHPoamh0eoI1POZv5mYNdGfXhwt7nWkgAHubo8i82L/vEDf8A
        T+zK6VjqD7juIJpdl05TNQ==
X-Received: by 10.98.220.201 with SMTP id c70mr33436566pfl.230.1496267092928;
        Wed, 31 May 2017 14:44:52 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 13/31] repo: add repo_read_gitmodules
Date:   Wed, 31 May 2017 14:43:59 -0700
Message-Id: <20170531214417.38857-14-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the repo object to be able to populate the submodule_cache by
reading the repository's gitmodules file.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repo.c | 14 ++++++++++++++
 repo.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/repo.c b/repo.c
index 13b7d244f..6f7b2015f 100644
--- a/repo.c
+++ b/repo.c
@@ -116,6 +116,20 @@ void repo_read_index(struct repo *repo)
 		die(_("failure reading index"));
 }
 
+static int gitmodules_cb(const char *var, const char *value, void *data)
+{
+	struct repo *repo = data;
+	return submodule_config_option(repo, var, value);
+}
+
+void repo_read_gitmodules(struct repo *repo)
+{
+	char *gitmodules_path = xstrfmt("%s/.gitmodules", repo->worktree);
+
+	git_config_from_file(gitmodules_cb, gitmodules_path, repo);
+	free(gitmodules_path);
+}
+
 int repo_init(struct repo *repo, const char *gitdir)
 {
 	int error = 0;
diff --git a/repo.h b/repo.h
index ebce2a408..ad0184eaa 100644
--- a/repo.h
+++ b/repo.h
@@ -37,6 +37,7 @@ extern void repo_set_gitdir(struct repo *repo, const char *path);
 extern void repo_set_worktree(struct repo *repo, const char *path);
 extern void repo_read_config(struct repo *repo);
 extern void repo_read_index(struct repo *repo);
+extern void repo_read_gitmodules(struct repo *repo);
 extern int repo_init(struct repo *repo, const char *path);
 extern void repo_clear(struct repo *repo);
 
-- 
2.13.0.506.g27d5fe0cd-goog

