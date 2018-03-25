Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0FD1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 13:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeCYNqm (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 09:46:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33088 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753331AbeCYNqh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 09:46:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id z73so16337213wrb.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XYIpzdePiqNVZdiYs1GfsfLoIaUTSnDZEHsiYxHpfJM=;
        b=LF1GyXRjThsUPaPiZnkGC7649nqDcrnoYGNvZ4pYlo5FNAgCt1EKLMurVoB6HeLb/6
         6Dn5tOs/FteE6vBEF8/dZpUPjuJwU2IP2/d/t0TthAMCjOzF5Dt1/KQBa8/jYpvrkBdx
         T+QdWnnSLhPJ4hFYhoKYdAZNyKDEx2jp5zEDnFYpjD0OiZB7awjeD8i92zvOgmoNowkm
         yXCtWJomZP02wpyqvftixsBSXfMXKlQJgvsLdl56NeMXqBMk5QHzZSHbQF6uq36OKjd8
         CKK3reM9YLcVYjpxSO1vgZq4QEjmVsW4HDGA80YFNneVMmeNxsEijKRjAfrhb5eXiR6V
         P3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XYIpzdePiqNVZdiYs1GfsfLoIaUTSnDZEHsiYxHpfJM=;
        b=MF209Twlfyqb0zVthr9tAh1qy6xrxJfZ72agNkFkeQfeLgHeGZIOtgF+YMUJoeGdHn
         kp4SA5GjBLi6rVHUhGUnA4gjQqFSvyBvy/W9VsB5DmTdkMtt11F07AN+NCLgoKjswuTA
         Hjvmp/+EwPn9tC3KuzRTdp+jobwXQYoRyfqj+vuPrT5Bu3uP1D9/PnvxPshVoM55ynaf
         N8Q7ZSTDRUqqufZ2zS1q5CMeTNnvuSjvmZJDFjRtY+lu/Zy+ec7xo+tS+YdTGcPM++Py
         lC3TwvzlPtI4uhf8WcVJ6Hk0fMa8pW7UhfoK2sbRavm1PSClNX301HF5wUjOCnYHeHf/
         O5JA==
X-Gm-Message-State: AElRT7GmpQBofGBjduY0mRPCjL3udVV+rVuIYbAeLWCrRBSjOPtSQB0n
        rrYN3hreTPtj0ZgdrM7oRS9KMkV8
X-Google-Smtp-Source: AG47ELv28O6fJXRMaJUNDj8rE8Z9iuH7FXW0Fh+kX19PPvnDozWd+CX1FpgALbgbiuZ6mGxx1PEqPw==
X-Received: by 10.223.154.100 with SMTP id z91mr28452530wrb.120.1521985595296;
        Sun, 25 Mar 2018 06:46:35 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f22sm28752243wmi.39.2018.03.25.06.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 06:46:34 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 4/6] worktree: factor out dwim_branch function
Date:   Sun, 25 Mar 2018 14:49:45 +0100
Message-Id: <20180325134947.25828-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.77.g8685934aa2
In-Reply-To: <20180325134947.25828-1-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
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
 builtin/worktree.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 1e4a919a00..c296c3eacb 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -366,6 +366,20 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
 }
 
+static const char *dwim_branch(const char *path, struct add_opts *opts)
+{
+	int n;
+	const char *s = worktree_basename(path, &n);
+	opts->new_branch = xstrndup(s, n);
+	if (guess_remote) {
+		struct object_id oid;
+		const char *remote =
+			unique_tracking_name(opts->new_branch, &oid);
+		return remote;
+	}
+	return NULL;
+}
+
 static int add(int ac, const char **av, const char *prefix)
 {
 	struct add_opts opts;
@@ -417,16 +431,9 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !opts.new_branch && !opts.detach) {
-		int n;
-		const char *s = worktree_basename(path, &n);
-		opts.new_branch = xstrndup(s, n);
-		if (guess_remote) {
-			struct object_id oid;
-			const char *remote =
-				unique_tracking_name(opts.new_branch, &oid);
-			if (remote)
-				branch = remote;
-		}
+		const char *dwim_branchname = dwim_branch(path, &opts);
+		if (dwim_branchname)
+			branch = dwim_branchname;
 	}
 
 	if (ac == 2 && !opts.new_branch && !opts.detach) {
-- 
2.16.1.77.g8685934aa2

