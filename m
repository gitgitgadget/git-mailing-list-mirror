Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761BE1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeCQWUe (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:20:34 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46587 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbeCQWUa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:20:30 -0400
Received: by mail-wr0-f194.google.com with SMTP id s10so2121254wra.13
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YtUI1BceLKzpq2WmezqmLDVTHuUANBxn/Np0/M39NMo=;
        b=G6HiB9XGQI/4mwUT3B9dr9nnuLOYBBmGtQYQS0qn13cu4L3bsLlh/eSRtwHiFXY9qp
         Epcoojt8cWUqNlHWm9pT1Qzi+E/W4pRV8cvIkk7VuL+9rxV9bhFFAEN7vt5etGO0RGYS
         X4LVF37fwHY+fvqazaSE7x4YKYb2yoqBRZJmgMZMbQS7WbgObGNrd2mM01gua0G/DzM+
         SZB4V8wKDYEzZaVNUOC4Fl/2tAnQ6OHMSJTUjsiF+rvZ+YMREXWX7VFY8i+uSK9V6Iln
         ENkTuvqQ4eJwdNTJcepAhKVgRvVCFCMBpCV/KPoaMntrCwhXXAU6TRI3fYUecKacW0gX
         gZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YtUI1BceLKzpq2WmezqmLDVTHuUANBxn/Np0/M39NMo=;
        b=kc8E6HQbaspNjmNOWQZhUNyst9mvqkQ/ySbqGiRVfWoAyFwVabfXmWTbOZdN+xFxIg
         TkuQOGkGnSaUBLcAHJa9YA6BziVgZZkkO4n6GqIqfZ/TP+QEd+nlJkwSXmou6x99NTQX
         dhy+Y7cezRhZ33pz+fCfGinxaqDWwqPiIMVhz39PVo/tF2eIoNOXEBHnImQ1rivwup0w
         wUsTJkLH2qss0tLx11HXQxexVl+5ymJiFSrOz32RRJxGunWC6kmWaPZ45VPR8ea0lOlh
         dDrFBRFuBAvxYKYIgiVfEL4PKKiBAFJGTrj4jtFZUJxf209wrFo1C55FDcvXSIM3zRjC
         /qlA==
X-Gm-Message-State: AElRT7F0XZ6bRi8GlpO6aUHeVY8w/BzSspM8B88sqhz5KrqYmU3u2lqt
        lxdymeOUMOMIBUK6AK1zzHJU70jd
X-Google-Smtp-Source: AG47ELuDbe76WQyjcf+BxZpJzAV921A5pEcRuQFwxpzccXM9IiqUYkQg9UyigYCuiUnIIERbXzelYQ==
X-Received: by 10.223.161.10 with SMTP id o10mr5614602wro.60.1521325228874;
        Sat, 17 Mar 2018 15:20:28 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id t6sm7640567wre.50.2018.03.17.15.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:20:28 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 3/4] worktree: factor out dwim_branch function
Date:   Sat, 17 Mar 2018 22:22:18 +0000
Message-Id: <20180317222219.4940-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180317222219.4940-1-t.gummerer@gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com>
 <20180317222219.4940-1-t.gummerer@gmail.com>
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
index 2266c132f9..52049b447a 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -367,6 +367,20 @@ static int add_worktree(const char *path, const char *refname,
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
@@ -419,16 +433,9 @@ static int add(int ac, const char **av, const char *prefix)
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
2.17.0.rc0.231.g781580f06

