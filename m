Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1DD31F453
	for <e@80x24.org>; Thu, 21 Feb 2019 22:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfBUWiT (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 17:38:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45123 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfBUWiS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 17:38:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so216699wrn.12
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwbrF5nVorrCR5MSE08wrKKmQnVK66AjZC0kK56q1S0=;
        b=T+igBBY5ZPmum87M3RuiTsP3zosODojOtfmlDv0z6sPh1bmMISd81Z/Ak7WfVWibZ7
         UzGK4smPOy1XfpcpKeIwdpWDIdEnY7e9kIcvbJ1tmXXca41CKv7p320g2o/Zhk6J7x3O
         Ao6BjXzuvZMgnZksUWm+SJ/qmgZ/e4YEnT48YqtTwmAU+VZYjD5eNZgpBxqZDekq5zRd
         J8U8A+gx05VnVdTCemcrcfdyr6tOU2d802jaHxMfgo1Fl0//VRvz1BJT1szABbkCoJol
         7FmV0jTAadVyhUHUtt4dzleZFPlOCQCS+0ZlL6YkOy/p68ePHSlB5z6L/FtTpPpjy1pW
         4v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwbrF5nVorrCR5MSE08wrKKmQnVK66AjZC0kK56q1S0=;
        b=hv7wrWXsu7f2mgbCK+2zCWdhXXMKrb0U7ntWOm4BG8rtWtlOMDZZ6pyN6wQNgGZhsW
         MwIFbUkANtKb4FsJhZGG95o52KycBFkeFvlxpN/jQO8JtQKwpYHs2wDxDpgOZ6bziSLt
         pgsOMQKEyxQONxzWQcLgxPmRX8rn8vyFD0/IOA/deCGXVcS2qDj2DxM/3GAjLMhpRa4F
         gbTyXMjejEsGEQ3UDcU8CiNuhGq/8L7uE1voRWnqQp4xuzruxR5/Bb0IHgYxz17JCVPj
         XjlN04LzQAxlYLkFrwUnTOOpoy2fiBZ9YyGNXicAKjl7b96oT+03XYhZLOTEBVjiUIMl
         O35Q==
X-Gm-Message-State: AHQUAuaCO8jIlfUt6tfK14tZyzWGAp6uHxje2K1OD5ZgXzfZyWTvcdOT
        NLyfsbTnv/lA0JknFqvfWw9AjzlZEe8=
X-Google-Smtp-Source: AHgI3Ib87yrccBmOtXjpvfZXdTmOJcxinxjYBfaA39n0jrH1dyVcr9cUGsmD2xh/iCM7LILJ3m+URQ==
X-Received: by 2002:adf:d4cd:: with SMTP id w13mr547760wrk.35.1550788695551;
        Thu, 21 Feb 2019 14:38:15 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v196sm110803wmf.15.2019.02.21.14.38.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 14:38:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] commit-graph: don't pass filename to load_commit_graph_one_fd_st()
Date:   Thu, 21 Feb 2019 23:37:50 +0100
Message-Id: <20190221223753.20070-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An earlier change implemented load_commit_graph_one_fd_st() in a way
that was bug-compatible with earlier code in terms of the "graph file
%s is too small" error message printing out the path to the
commit-graph (".git/objects/info/commit-graph").

But change that, because:

 * A function that takes an already-open file descriptor also needing
   the filename isn't very intuitive.

 * The vast majority of errors we might emit when loading the graph
   come from parse_commit_graph(), which doesn't report the
   filename. Let's not do that either in this case for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 4 ++--
 commit-graph.c         | 7 +++----
 commit-graph.h         | 3 +--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 32bcc63427..8196fdbe9c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -64,7 +64,7 @@ static int graph_verify(int argc, const char **argv)
 	open_ok = open_commit_graph(graph_name, &fd, &st);
 	if (!open_ok)
 		return 0;
-	graph = load_commit_graph_one_fd_st(graph_name, fd, &st);
+	graph = load_commit_graph_one_fd_st(fd, &st);
 	FREE_AND_NULL(graph_name);
 
 	if (!graph)
@@ -102,7 +102,7 @@ static int graph_read(int argc, const char **argv)
 	if (!open_ok)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
 
-	graph = load_commit_graph_one_fd_st(graph_name, fd, &st);
+	graph = load_commit_graph_one_fd_st(fd, &st);
 	if (!graph)
 		return 1;
 
diff --git a/commit-graph.c b/commit-graph.c
index b1ba7a09cc..d945e8f3e0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -92,8 +92,7 @@ int open_commit_graph(const char *graph_file, int *fd, struct stat *st)
 	return 1;
 }
 
-struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
-						 int fd, struct stat *st)
+struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st)
 {
 	void *graph_map;
 	size_t graph_size;
@@ -103,7 +102,7 @@ struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
 
 	if (graph_size < GRAPH_MIN_SIZE) {
 		close(fd);
-		error(_("graph file %s is too small"), graph_file);
+		error(_("commit-graph file is too small"));
 		return 0;
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
@@ -127,7 +126,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	if (!open_ok)
 		return NULL;
 
-	return load_commit_graph_one_fd_st(graph_file, fd, &st);
+	return load_commit_graph_one_fd_st(fd, &st);
 }
 
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
diff --git a/commit-graph.h b/commit-graph.h
index e4f17071e2..36d8109901 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -54,8 +54,7 @@ struct commit_graph {
 };
 
 struct commit_graph *load_commit_graph_one(const char *graph_file);
-struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
-						 int fd, struct stat *st);
+struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
 
 struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 					size_t graph_size);
-- 
2.21.0.rc0.258.g878e2cd30e

