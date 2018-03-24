Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D52F1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 18:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeCXSjJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 14:39:09 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41567 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeCXSjI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 14:39:08 -0400
Received: by mail-pl0-f68.google.com with SMTP id b7-v6so9398243plr.8
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=eCCbPzAHFR3MSfIAhHTW8uo/CBA9idiB3IMJQPIYT+E=;
        b=Jd4GVQDGF0nJ1j2f/zymukx3vzbqkGeKBswTzt4OLC6gwCuDSfRXxyv3JLY71rVglr
         nzxZ8XUqyu2cVqeNEjRu/N5H9bvMsMxx6gjZAIdYcbNRXRNDiEPUDZy9WBbJNKlO2N4W
         G/+HXrVsNFFw2sKLtaPaidYKP3VkjuhFcnKsZX1aqlTx3OS1jfAdR+Z+I27xtBeqz0wU
         x7d7oWxRDMamqq7y8oNvD+fx1T3TIp//bpUoddhGdX4erT1n/F6eR+Qqg/IEPNncknSV
         jdA/j0aiXIVB6rKcmdi94OU6oBbP7Q5F/Do10DR7/xF9qluId5axoK0Qepq552l3QnUQ
         gkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=eCCbPzAHFR3MSfIAhHTW8uo/CBA9idiB3IMJQPIYT+E=;
        b=R0a6PCJtgkGYk5ERG3CNJCvorFYAUaTf+b+tBqrW1f2kLO3wYk+TYOJEp4iuZGFGC6
         Rbmjota+TqC+4dafhoIXaAZJAtY5MExDZPlfrtdhAQgwMZr09HD/jbVPSj14QiqbgEDt
         RhisCSaIRQnewNOZ0CnqytaY2dhRIxQn0zz39jpmkzwhRQ/XPxOno1MCET9Fyn0VWovc
         mp3x0IxP5ylClTgY/UMklfRSunOxKJIjLXhUqrutXPP56A0926qDpUz+RrOnb/IUqFe+
         Ect9aYLMqdrew1CFCKI9r/MyMQ8BZxc9EzrSu3Ohn3omYm98cZMq/Esslv1zyNye3kmO
         lnUg==
X-Gm-Message-State: AElRT7GaOaiV8XhuIwXhPEoccp2Vl8WJAPMgzy7HU+N09fBFGK8eH1Fo
        FOBm3MPqv7QBNqlqNeQjqxDXIgQ4QUmXQQ==
X-Google-Smtp-Source: AG47ELsJBDGNvM9bq2vH9rfBOxKqhGSg5VBJ1aO/XG6O2m8PqZrblfRpDpr7k2MJ+DTicPmFR0y+kw==
X-Received: by 2002:a17:902:144:: with SMTP id 62-v6mr34799617plb.202.1521916747700;
        Sat, 24 Mar 2018 11:39:07 -0700 (PDT)
Received: from localhost.localdomain ([106.208.183.108])
        by smtp.gmail.com with ESMTPSA id m1sm25625907pfi.80.2018.03.24.11.39.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 11:39:06 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH] branch -l: print useful info whilst rebasing a non-local branch
Date:   Sun, 25 Mar 2018 00:08:44 +0530
Message-Id: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing interacitvely (rebase -i), "git branch -l" prints a line
indicating the current branch being rebased. This works well when the
interactive rebase was intiated when a local branch is checked out.

This doesn't play well when the rebase was initiated on a remote
branch or an arbitrary commit that is not pointed to by a local
branch. In this case "git branch -l" tries to print the name of a
branch using an unintialized variable and thus tries to print a "null
pointer string". As a consequence, it does not provide useful
information while also inducing undefined behaviour.

So, print the commit from which the rebase started when interactive
rebasing a non-local branch.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 ref-filter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index f9e25aea7..a4c917c96 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1310,8 +1310,16 @@ char *get_head_description(void)
 	wt_status_get_state(&state, 1);
 	if (state.rebase_in_progress ||
 	    state.rebase_interactive_in_progress)
+	{
+		const char *rebasing = NULL;
+		if (state.branch != NULL)
+			rebasing = state.branch;
+		else
+			rebasing = state.detached_from;
+
 		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
-			    state.branch);
+			    rebasing);
+	}
 	else if (state.bisect_in_progress)
 		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
-- 
2.17.0.rc0.231.g781580f06

