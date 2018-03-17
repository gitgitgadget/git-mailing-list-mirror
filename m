Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC1F1F404
	for <e@80x24.org>; Sat, 17 Mar 2018 22:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbeCQWF5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 18:05:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45989 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752613AbeCQWFy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 18:05:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id h2so14898856wre.12
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YtUI1BceLKzpq2WmezqmLDVTHuUANBxn/Np0/M39NMo=;
        b=Jk/P3dxiXQFuI7W3md3RL7FLuaOuzYC+4b/HqYBa4RAUO35rypv1BOVkLXwFMM4lwz
         w5DrMEb7hSNOgmtKXniKZUObQ1TJHmDU3kian6NBdyWH/sJFEuJHirvKKshTClN6Krgy
         UOBjc0E+Q7Mk85MKNmADDemQF8ZKdG4VowGmvBPtEdcnB92Ccyw2yT1XEzPQ/L5is8Mi
         y/Qr18ACf8WyolZTmBKZ+NqdrsHf3Df2q7m8VmI1ccPpKsaoRHf2magxwGbJmVXuhCis
         cqiAiM3Osgkmjzg3v34uRGRaRPISBsT96ZiNpwJwPDiaiBC3ZmJ+b/NJa1SxwYUwRfey
         pmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YtUI1BceLKzpq2WmezqmLDVTHuUANBxn/Np0/M39NMo=;
        b=uDNpJE8ey0TAl4RvwqA3nq5J92uraPNk3vcbTeliksuA2m/Te6X358aEXEnbt0d/9F
         elMatbhSiwaffYmfuIOlbZlgWKJeANRtKBsJqLkDGpdmkMb28natx7TVDi2fcVTeP1CU
         5eCJfM0hRixNy0EwDyDrhE8duBz30K1UKMpI4c+xpHDfrSi3hFO6YStZmky7tYY9Ak8F
         vE9kpCYxezN0GIDjqYMPohwDkHERV2/kLm5MQN7iR41gmc9rcJA4tvVo3TzwI3kFHimW
         KYpnug5hVjTz+e4LLvoeUujOgJOTGutFO1+QOPDiVMjD2r1jAo86fRO8J6HNQ2NTCXNI
         Ar8Q==
X-Gm-Message-State: AElRT7HvfNVZ+v+bkTof97l834pjqUd/EeN1IwXN5F2OcKlKdoUMAwSR
        sdGsEOyaxkBO7uRqYRLdn1f01Igv
X-Google-Smtp-Source: AG47ELvh9DjB/aP1ISoyb1TFIXcA0S5Rb+qJ2xvCA/i0c/FsjVRgMk/wCYQ+RKWrtS6yLNVTt6Xf0A==
X-Received: by 10.223.151.1 with SMTP id r1mr5217586wrb.126.1521324352884;
        Sat, 17 Mar 2018 15:05:52 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f84sm5929894wmh.44.2018.03.17.15.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 15:05:52 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/4] worktree: factor out dwim_branch function
Date:   Sat, 17 Mar 2018 22:08:29 +0000
Message-Id: <20180317220830.30963-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180317220830.30963-1-t.gummerer@gmail.com>
References: <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180317220830.30963-1-t.gummerer@gmail.com>
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

