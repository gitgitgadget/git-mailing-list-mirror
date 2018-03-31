Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A73C1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 15:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeCaPPD (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 11:15:03 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34044 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752861AbeCaPOy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 11:14:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id o8so10125208wra.1
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KG2LeyOpLJfv44tU/F6FEG9IqZJf0Qi5KaT/LN3MGAc=;
        b=k+L0z2evrBIjnT9AZMxKc9dd4nr22EMd0fXdUiOzb/SSGHtvvkBHwIt7a4hvHSHtnK
         Sj6aNVdtQYNK4Cz0FmjsnDnBvAZdOAxpwySj5+1LjajoPiCI6W3tpjM6M6sDIC9dSul5
         nodABDJ7KKYx/J1GZ01hQLVZ0UDBE+Wyo77y+5+iQuRkQwMKmjuKYv+9ha1zWCyggt0e
         4oFd2fGQ+b43Ke0q6d0ctQBNBA4O7mJplvNlgrf4ZWFCcHzY5ANPIM+soglB2JrNSDaN
         HqAFL3qgdU/iz4GwRBU1jTwlJEu09qz67CejezmWFhwSlDm0+fwyvxltW4JO9kJgkp6L
         fn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KG2LeyOpLJfv44tU/F6FEG9IqZJf0Qi5KaT/LN3MGAc=;
        b=I0lnYsQ85vWDBrnSL/5zv/DPl61fDKjz1WVhuepvVLqeEwO/TyCygtErA+iOb1q1II
         4Y0SQafZN5e6wZUHG0Linxxer4DBMRyee/dBuCkxOq9BcCSWCROopdvmDC6fAYfWjnYw
         TsmwsOT4ge28w2B+x1eRqTJVhHXFSEpTOuENYUv55pXgd5klcz68BgEiCo10HBAsPGic
         omUqMN4tULS8po2usZd+dj940osURnnroqPLzS9eOdyEzCSr+qgj7hC/uRCWXxwCqTh0
         ywDGEjj7QVxFbU3DFWMGcOGaYu5Shlr6ABxkdweMDh2ECvJkTSqN2cs5Wcx2sLerTIeM
         i5MA==
X-Gm-Message-State: AElRT7GR/rxpwUBQ8lUcfJmdakOYZzScERBZpeygz1KEEt1iA1b3KicD
        PJ3rP1mJ2YIqaGZMXTqo7K7Mr6e9
X-Google-Smtp-Source: AIpwx4+a7sb7Ydl6sNlf48W9amNzckLO5D+FWNu6u3UiuXfFCZJ0SmM9BUygcc61msoFiJm0wx1imA==
X-Received: by 10.223.210.82 with SMTP id o18mr2274918wri.85.1522509291868;
        Sat, 31 Mar 2018 08:14:51 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id g185sm5975439wmf.40.2018.03.31.08.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 08:14:51 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 5/6] worktree: factor out dwim_branch function
Date:   Sat, 31 Mar 2018 16:18:03 +0100
Message-Id: <20180331151804.30380-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.78.ga2082135d8
In-Reply-To: <20180331151804.30380-1-t.gummerer@gmail.com>
References: <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180331151804.30380-1-t.gummerer@gmail.com>
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
index f686ee1440..47189d50dd 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -363,6 +363,20 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
 }
 
+static const char *dwim_branch(const char *path, const char **new_branch)
+{
+	int n;
+	const char *s = worktree_basename(path, &n);
+	*new_branch = xstrndup(s, n);
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
@@ -415,16 +429,9 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (ac < 2 && !new_branch && !opts.detach) {
-		int n;
-		const char *s = worktree_basename(path, &n);
-		new_branch = xstrndup(s, n);
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
2.16.1.78.ga2082135d8

