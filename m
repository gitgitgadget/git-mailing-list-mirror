Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6671F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbeDXV5R (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:57:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53789 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeDXV5O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:57:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id 66so3808867wmd.3
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N6jUMyNxVSlJOr4C2eAWIAENrYbiPfClH1MfB1Nj7xs=;
        b=Z4xKl37ia2V+29p5vv9KGsrX/emwA6U8dpI6qMHS91Q++Sm0elmYtKFEOc4TYyc7Uf
         chbboAaYsN/TZaImWJE1lnCiszOBLhca2QgF8M6DfxkaMAe4pJamEc3befWuvrAZkoAh
         zHQtYx0KNLqHH+s79dosNVVLSVQ5HPmOzErija6h2oc3GDcSQnzir9smZ6EsYo0VMtT8
         9SMqgc7ZUB/RsTSXI58i4ZcSW+RfCwH9iUDKJ73sQss067bLFa/nLb08N9CA9ib6hiTz
         puoTyIMVEp/nDnfAbabnU7SNFkWyezI3QZqGnDrRfvAiDZTuQ2SY57JaWByrYhxAruzg
         PrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N6jUMyNxVSlJOr4C2eAWIAENrYbiPfClH1MfB1Nj7xs=;
        b=CxTAdvxCmOhMLRoIBNChmE548DWo4K+Tq/hW+2mQHvq1VDQoxF1mHJfOCwYKr8XyTd
         FUKamrk9y7FslNUBmSBt8HOYS/V1mhb8L/RAYcnWG9WMPA46IGfBGn43mNer0cjmoxui
         aJJEVm3hKO3ui9TJ1y7eTyvNzhBKZ/GCZt+QxfOxsY1ZuuWj+6inzznGkyQJ61JVovDi
         PpUrXoFB9oSi7GBJpoFaU1UwoU0cGZwmBrMgMADsaZbW5Gc7x3mv3jJNb40AM+hnX40q
         TiH4CarFj5sIwLfO7cn4vO15JpMwjiP9670IygNckalBa03kSxCCUFL+dqDpwmkw4YCY
         aHMg==
X-Gm-Message-State: ALQs6tAALuyTDnpOqg3tG+XOTqFUEtbl+IWTievzvtaLhujBloXlyOe4
        P25csLGO/ABxrPwwNR4fDnKIQXn0
X-Google-Smtp-Source: AB8JxZpw8otnkyLNjqMlwp/8NM6k0I1EmrHsAljmz3+2xpXM8ZkPxwth0j39Xs4oJO9PJbwDubq7Hw==
X-Received: by 10.28.135.149 with SMTP id j143mr4316822wmd.149.1524607032810;
        Tue, 24 Apr 2018 14:57:12 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id g7-v6sm13435947wrb.60.2018.04.24.14.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:57:12 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v9 3/4] worktree: factor out dwim_branch function
Date:   Tue, 24 Apr 2018 22:56:34 +0100
Message-Id: <20180424215635.9183-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.76.ga910c1dec4
In-Reply-To: <20180424215635.9183-1-t.gummerer@gmail.com>
References: <20180423193848.5159-1-t.gummerer@gmail.com>
 <20180424215635.9183-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out a dwim_branch function, which takes care of the dwim'ery in
'git worktree add <path>'.  It's not too much code currently, but we're
adding a new kind of dwim in a subsequent patch, at which point it makes
more sense to have it as a separate function.

Factor it out now to reduce the patch noise in the next patch.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 39bf1ea865..6bd32b6090 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -387,6 +387,21 @@ static void print_preparing_worktree_line(int detach,
 	}
 }
 
+static const char *dwim_branch(const char *path, const char **new_branch)
+{
+	int n;
+	const char *s = worktree_basename(path, &n);
+	*new_branch = xstrndup(s, n);
+	UNLEAK(*new_branch);
+	if (guess_remote) {
+		struct object_id oid;
+		const char *remote =
+			unique_tracking_name(*new_branch, &oid);
+		return remote;
+	}
+	return NULL;
+}
+
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct add_opts opts;
@@ -439,17 +454,9 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !new_branch && !opts.detach) {
-		int n;
-		const char *s = worktree_basename(path, &n);
-		new_branch = xstrndup(s, n);
-		UNLEAK(new_branch);
-		if (guess_remote) {
-			struct object_id oid;
-			const char *remote =
-				unique_tracking_name(new_branch, &oid);
-			if (remote)
-				branch = remote;
-		}
+		const char *s = dwim_branch(path, &new_branch);
+		if (s)
+			branch = s;
 	}
 
 	if (ac == 2 && !new_branch && !opts.detach) {
-- 
2.16.1.74.g7afd1c25cc.dirty

