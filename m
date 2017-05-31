Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4901FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdEaVoy (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:44:54 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35927 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdEaVou (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:44:50 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so18548736pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pCzAjitf5Mhf/MMk9tivoIvi8SPSC7eUMw/A3U1kEQA=;
        b=gxoiYqXPxTpQKuW1581JHm/4cYNkTD9u/QqmQZdaIbJ0c0kd2WbsRtGnODDeFIA85+
         +MUninxuntTZTrkRXdb0UaCqPXNd00yxShNepjJAr0Rc69gCKdmFwp61CiMmvdPTPELZ
         CwCopK07XSkyEQQrcKB8rtx0VJ8jwABr1xF5Z8o11ECENHc0ToG7FTF/nGUAPM+K6YB9
         OsW8plebNYfYP43uNt4LUYPUVCW7hMwGM8LgQ6ftJLMK5uu66/Em1I4HTaEe8/IQ1lnS
         874GtqOuZI/uPe/Nfbju2ttXT2axd5HdihioC9C6lPJfyHLOr763IOtvTiyxvuIJMxXe
         auNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pCzAjitf5Mhf/MMk9tivoIvi8SPSC7eUMw/A3U1kEQA=;
        b=f6RwVxmSgKq5ZEsRYLP0jal24Md11kwPNkybO+Lwa+KNY/ZM6aG6v6dMpESyl0/0Il
         wLCiTKz5OWn4n+jfIGbBNF8o5zS5qTfBueeN1iiul9vbjYskuRZdCDSAXhGqWRQNIG2Z
         xMggMu6QdVnDg5+YwSIf/wc8WZ/vEwKZU1w9zqQDKaXe/AnTGwUnHGk82CR1WvRAmsaZ
         kxg98e1xcfQ0yTxCwhn69clnKyuUCCFFwb//nmqKDwRea9OsNr3cIoCLqnsGJDYiadpe
         GkgRGo563VHGmxQuS/3ldjPCJdTsGi9qUOvo+GbpPc7M54rALjXZCRjLlFYsg8sSGFbQ
         iziw==
X-Gm-Message-State: AODbwcAl7znIZJKX2vMdhGsfA9vPauVB9WUJgGzSQxMSp+/TdiA7odTu
        zZq9MJSR72Y7QONT
X-Received: by 10.84.215.213 with SMTP id g21mr4798805plj.47.1496267089704;
        Wed, 31 May 2017 14:44:49 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:44:48 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 11/31] repo: add index_state to struct repo
Date:   Wed, 31 May 2017 14:43:57 -0700
Message-Id: <20170531214417.38857-12-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repo.c | 17 +++++++++++++++++
 repo.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/repo.c b/repo.c
index c67cad5a2..c79d29534 100644
--- a/repo.c
+++ b/repo.c
@@ -104,6 +104,17 @@ void repo_read_config(struct repo *repo)
 	git_config_with_options(config_set_callback, repo->config, NULL, &opts);
 }
 
+void repo_read_index(struct repo *repo)
+{
+	if (!repo->index)
+		repo->index = xcalloc(1, sizeof(struct index_state));
+	else
+		discard_index(repo->index);
+
+	if (read_index_from(repo->index, repo->index_file) < 0)
+		die(_("failure reading index"));
+}
+
 int repo_init(struct repo *repo, const char *gitdir)
 {
 	int error = 0;
@@ -149,4 +160,10 @@ void repo_clear(struct repo *repo)
 		free(repo->config);
 		repo->config = NULL;
 	}
+
+	if (repo->index) {
+		discard_index(repo->index);
+		free(repo->index);
+		repo->index = NULL;
+	}
 }
diff --git a/repo.h b/repo.h
index 284452832..756cda9e1 100644
--- a/repo.h
+++ b/repo.h
@@ -2,6 +2,7 @@
 #define REPO_H
 
 struct config_set;
+struct index_state;
 
 struct repo {
 	/* Environment */
@@ -20,6 +21,7 @@ struct repo {
 	 * ~/.gitconfig, XDG config file and the global /etc/gitconfig)
 	 */
 	struct config_set *config;
+	struct index_state *index;
 
 	/* Configurations */
 	unsigned ignore_env:1;
@@ -32,6 +34,7 @@ extern struct repo the_repository;
 extern void repo_set_gitdir(struct repo *repo, const char *path);
 extern void repo_set_worktree(struct repo *repo, const char *path);
 extern void repo_read_config(struct repo *repo);
+extern void repo_read_index(struct repo *repo);
 extern int repo_init(struct repo *repo, const char *path);
 extern void repo_clear(struct repo *repo);
 
-- 
2.13.0.506.g27d5fe0cd-goog

