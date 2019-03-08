Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED20F20248
	for <e@80x24.org>; Fri,  8 Mar 2019 21:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCHVzi (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 16:55:38 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:37720 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCHVzi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 16:55:38 -0500
Received: by mail-it1-f201.google.com with SMTP id q141so13172866itc.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 13:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/T1g0yV2QOlVxhv7pQ6ewK8IHn8UwKGZh5cup4X5Lcs=;
        b=cbm+k83DCYh2Po3dn1TlzcVKXABOi9jcjQ0BkkxF4bJp+RiyhcPQEqg79W7d9625sb
         vrXQKbXt3jIRFxz+yFNHtH8v4rR5SHItqEzK0n4wHID8xz0NIrFCX26BUyjP1MatAcsF
         E40bCUMofLIPAAf1vzGrJiy/6/+8YbYKkZef6ao19AFJnXkQk3m6ED00hZU0QF5rpMOf
         8SntiU7I+sgW+PMlQ+YdXwJj+cAr1NspJXg1F8nfR8pIUVKVYPBkI45ly6gBHfw0hX8/
         eQIk1CY95wMUTaAUcf9KclDf5DxWl4rTywJZoxF1lxcHIBV8Rr6wTlJ55QHjgr6JzWoP
         YrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/T1g0yV2QOlVxhv7pQ6ewK8IHn8UwKGZh5cup4X5Lcs=;
        b=hb6ZSbFc4rMMx7sNYMCZ8/51V1qyrj+cIa8YKUCsl9vscvHMxIUELLjCqw+Q9v2l/i
         u6/p+2FrvCsmShP0RXEQ+4MhwERMKBgHRhBqvyUF8MiEyk6yP7/vIIFa1SS5E1UtNbJb
         XLxE/NfZFq3F3aF7JXln57qtr1K+214C3Xg/Xtxt/XYHVdZRtiRh0Tr+nZ4tv0RTtymR
         96f6ZWTorzCXCQpYCL9nO/4Lzkm9gbGK4hz9vKnUxZNsBxUsZFbdpAXEAydqpnEU1fcu
         7Tkhv+TC7CYHZQvjFF4vMoUc+O2GuZNPBHSFH/0aGw3gr3NLhGBQxlZA7ayd+28ewWX1
         sv/w==
X-Gm-Message-State: APjAAAV+11eszzF85SDH8Lw7t+TkQmR9OvNeiAVy1JHt+bJ/4maZmxtI
        gsNugAVqZaTmlB37YWaU7DViDpIQnZkDd6rsELAF
X-Google-Smtp-Source: APXvYqyQLw3965yFutFqxRWrzgflBTfSO56iSGJGz5uCwxW3WsOElARuHWUtUhS4sh0LgTugXKY9SFcOm6y/ZPAjsFMQ
X-Received: by 2002:a24:6283:: with SMTP id d125mr13502677itc.14.1552082137628;
 Fri, 08 Mar 2019 13:55:37 -0800 (PST)
Date:   Fri,  8 Mar 2019 13:55:13 -0800
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
Message-Id: <87173d0ad1f1e611b6c2f539ca203be5bb9efb53.1552073690.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 1/8] http: use --stdin when getting dumb HTTP pack
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Git fetches a pack using dumb HTTP, it reuses the server's name for
the packfile (which incorporates a hash), which is different from the
behavior of fetch-pack and receive-pack.

A subsequent patch will allow downloading packs over HTTP(S) as part of
a fetch. These downloads will not necessarily be from a Git repository,
and thus may not have a hash as part of its name.

Thus, teach http to pass --stdin to index-pack, so that we have no
reliance on the server's name for the packfile.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/http.c b/http.c
index a32ad36ddf..34f82af87c 100644
--- a/http.c
+++ b/http.c
@@ -2204,9 +2204,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 {
 	struct packed_git **lst;
 	struct packed_git *p = preq->target;
-	char *tmp_idx;
-	size_t len;
 	struct child_process ip = CHILD_PROCESS_INIT;
+	int tmpfile_fd;
+	int ret = 0;
 
 	close_pack_index(p);
 
@@ -2218,35 +2218,24 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	if (!strip_suffix(preq->tmpfile.buf, ".pack.temp", &len))
-		BUG("pack tmpfile does not end in .pack.temp?");
-	tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile.buf);
+	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
 	argv_array_push(&ip.args, "index-pack");
-	argv_array_pushl(&ip.args, "-o", tmp_idx, NULL);
-	argv_array_push(&ip.args, preq->tmpfile.buf);
+	argv_array_push(&ip.args, "--stdin");
 	ip.git_cmd = 1;
-	ip.no_stdin = 1;
+	ip.in = tmpfile_fd;
 	ip.no_stdout = 1;
 
 	if (run_command(&ip)) {
-		unlink(preq->tmpfile.buf);
-		unlink(tmp_idx);
-		free(tmp_idx);
-		return -1;
-	}
-
-	unlink(sha1_pack_index_name(p->sha1));
-
-	if (finalize_object_file(preq->tmpfile.buf, sha1_pack_name(p->sha1))
-	 || finalize_object_file(tmp_idx, sha1_pack_index_name(p->sha1))) {
-		free(tmp_idx);
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
 
 	install_packed_git(the_repository, p);
-	free(tmp_idx);
-	return 0;
+cleanup:
+	close(tmpfile_fd);
+	unlink(preq->tmpfile.buf);
+	return ret;
 }
 
 struct http_pack_request *new_http_pack_request(
-- 
2.19.0.271.gfe8321ec05.dirty

