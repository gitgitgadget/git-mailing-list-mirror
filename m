Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995D51F404
	for <e@80x24.org>; Mon, 13 Aug 2018 22:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeHNB1M (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:27:12 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:43084 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeHNB1M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:27:12 -0400
Received: by mail-oi0-f74.google.com with SMTP id e23-v6so18420361oii.10
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gEOr1g6DxttF1FJtHF0+Yrx5Y8P8duLk35NxzIUJTXo=;
        b=EiekrqdHS5pAt1RLVSTcAbYIUWmNZUeZCZKvPgTPsQvZWfJguLYDVi+cv1MKYX9Sg6
         QLeMHYPlOpsHsVoZdsv823+kBuzOwSOysmk9hcYr9o9in/S1E4P/pUSq2ii9jdgiagPg
         dx9xDcw2pWxJjhDGBx5XKGILsMb9t4N0Z6CW35pL256wq0jQe8IfWyK0S/8Tj1/kCNQ1
         f/z22JKYvCcgDlrhpRG+Tm9bFwQ5YsdVgW1xaOVpKdRthPmlcxwMzXqk2zsDgCa8t/kg
         uuWJxTnPtSAJYj5ET7E42T3nNSt4uKepIt9KqLoVaaxEH8OiagpEWmAHng/DBd1mxhwc
         J9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gEOr1g6DxttF1FJtHF0+Yrx5Y8P8duLk35NxzIUJTXo=;
        b=PBzdH9yr+U6ZoCRgooL97yTbXKEq8fbAH0/AGu/AzaCfWTgrHudmVP6PpdmcikB5io
         1KG5ZI7Qx5cGhtZwJBH8b96B0Uf99suApOEcp3p9XQ0xUAFPnZ4xIIN2Nhqy2SL+CCBg
         a+h4MAfjAIoTpGoi50/FLq8Mki+1RdJWwSr6Gc9hl6HdmMB6+sQEc700uIIfq5kHNMzY
         PE4PB/NOntPFUzJOaQ3nCfdXJdSeL+pxXptv2yBC7uSlom7zcdPlP/WpcVqpsX+W+1Rc
         SwMkAJEF7uW039H0R3xTHNZa3SbTBkP766bEbC8aHvIcsd+Xtq0/UpVi7W23LMn0FY/E
         xwnA==
X-Gm-Message-State: AOUpUlF11LzcejtQhwb32KPD/lEPX+gBlkgH3rEAUM9OfI5E7tfipOms
        CMQG4VmL1k2dDsHQy4yBIGBdxMJcpSEM
X-Google-Smtp-Source: AA+uWPxjsG6FlubnjVkzczLLbUcHPHrnulYi8VjUpjtsJmrNtQnC5upmBUIkKcRDwkhmMCGbc/p56URCMxmo
X-Received: by 2002:aca:f346:: with SMTP id r67-v6mr12697763oih.34.1534200175934;
 Mon, 13 Aug 2018 15:42:55 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:42:33 -0700
In-Reply-To: <20180813224235.154580-1-sbeller@google.com>
Message-Id: <20180813224235.154580-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180813224235.154580-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 5/7] builtin/submodule--helper: factor out method to update a
 single submodule
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we'll find this method handy.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 40b94dd622e..8b1088ab58a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1727,10 +1727,17 @@ static int git_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
+static void update_submodule(struct update_clone_data *ucd)
+{
+	fprintf(stdout, "dummy %s %d\t%s\n",
+		oid_to_hex(&ucd->oid),
+		ucd->just_cloned,
+		ucd->sub->path);
+}
+
 static int update_submodules(struct submodule_update_clone *suc)
 {
 	int i;
-	struct strbuf sb = STRBUF_INIT;
 
 	run_processes_parallel(suc->max_jobs,
 			       update_clone_get_next_task,
@@ -1749,16 +1756,9 @@ static int update_submodules(struct submodule_update_clone *suc)
 	if (suc->quickstop)
 		return 1;
 
-	for (i = 0; i < suc->update_clone_nr; i++) {
-		strbuf_addf(&sb, "dummy %s %d\t%s\n",
-			oid_to_hex(&suc->update_clone[i].oid),
-			suc->update_clone[i].just_cloned,
-			suc->update_clone[i].sub->path);
-		fprintf(stdout, "%s", sb.buf);
-		strbuf_reset(&sb);
-	}
+	for (i = 0; i < suc->update_clone_nr; i++)
+		update_submodule(&suc->update_clone[i]);
 
-	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.18.0.865.gffc8e1a3cd6-goog

