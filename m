Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 233CC1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 18:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753610AbdBJS4z (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 13:56:55 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33954 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdBJS4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 13:56:24 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so3721718pgv.1
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 10:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vtvaYtRKjcsd1pSbqyi9F7hu3WbgDQ1MSs61oJOIeZo=;
        b=aiXy2jST/plIEtdUC13XxU6nyIjCGC2q5trhD57QITf4C+e9lq0nhOEMZQ0LKvo0mO
         jJDnKbgMf1InL18Jo9dV77+WyAe7UOD9pBnIR/yr/ypqmjijE75dtnXhJnwj8umy8ojg
         6RFu1DGclBTGJ3wRtUpJVA+wBk6Gigz4ZTOZsfAYb+wSnOI3cW6YfDX52XD8d3E0+QG4
         jVjNsrXede6S1bRLW69b6ETu9QT5CztEjTWYzl21LBS7idLpDL0EBrpPa+dc/2YSrJSe
         C+tkQz6ONxY68HRTXYm9cr77IaIeJHmh13vLRr+46c23CqGK4ygAlYEwUzWKiM6W78xk
         oCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vtvaYtRKjcsd1pSbqyi9F7hu3WbgDQ1MSs61oJOIeZo=;
        b=OnhWt64Pnzyq3DqSmI7zkjLiK2gLC8lXrMtTjlKefl3UGm5HfzVUPRyPdcKnVM9qlN
         WZb23qu9ID3aKZOnVTMhJCf9IpJFYilLOz4BsNrbJzooVpOLP1iGgPsqidQ8DccE6dmF
         E6lnab57meL3HN6VmBMRq6kQT4bscKGVXPKHJ7M4Wra+LnBY8bWDnjjz81Zcav5ARADD
         pRWt/7OWo3mG96GzMP+Ym6GuHF+Y1rvnLmg/w+XeOfKmAqyVgw17xWqTz2pNuLur6N3f
         DRiS6gXjsx9nWgTP9KtzyTKwWlNJu9uCJ4wDetzLTKjQRdFwTSdzHv2P1/xHp0JWcj2v
         VuiA==
X-Gm-Message-State: AMke39kltSGlBqMCbo2Rjq5G6CCbVcwx8qmoKzPaZO096RD9dEpV6GFOZPNX45569Kbykw==
X-Received: by 10.84.149.102 with SMTP id b35mr13337884plh.3.1486752977182;
        Fri, 10 Feb 2017 10:56:17 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id l25sm7092693pfb.24.2017.02.10.10.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 10:56:15 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 1/2 v3] revision.c: args starting with "-" might be a revision
Date:   Fri, 10 Feb 2017 18:55:25 +0000
Message-Id: <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

setup_revisions used to consider any argument starting with "-" to be either a
valid option or nothing at all. This patch will teach it to check if the
argument is a revision before declaring that it is nothing at all.

Before this patch, handle_revision_arg was not called for arguments starting
with "-" and once for arguments that didn't start with "-". Now, it will be
called once per argument.

This patch prepares the addition of "-" as a shorthand for "previous branch".

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
 revision.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index b37dbec..4131ad5 100644
--- a/revision.c
+++ b/revision.c
@@ -2205,6 +2205,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
+		int handle_rev_arg_called = 0, args;
 		if (*arg == '-') {
 			int opts;
 
@@ -2234,11 +2235,18 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
-			continue;
+
+			args = handle_revision_arg(arg, revs, flags, revarg_opt);
+			handle_rev_arg_called = 1;
+			if (args)
+				continue;
+			else
+				--left;
 		}
 
 
-		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
+		if ((handle_rev_arg_called && args) ||
+				handle_revision_arg(arg, revs, flags, revarg_opt)) {
 			int j;
 			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
-- 
2.1.4

