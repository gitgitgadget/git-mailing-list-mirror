Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382CF1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeGQA5A (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:57:00 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:56860 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeGQA5A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 20:57:00 -0400
Received: by mail-qt0-f202.google.com with SMTP id k21-v6so1810931qtj.23
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 17:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=aGp2olnXWk9tzJ6iXgouk2mPcXZvPD/cJY44owsbw+U=;
        b=tyjV4ZbtcLlEL/GWXYxMcZRHqKeUFoXTiUIBVd360DHgRHE3zv4dX0ZxeDAiGaKg+H
         OEZt9g6p+x83aI54+j1xVq6+FmUnj+2OeO2HTm1N185jsfb5wrKpfLo8F04wAWHYjAmx
         caWw/jg/SxmolImsDCKlFw6zupE+N3bzqkKYVKbu8S7gy5IZLC9HzlCScfiiSKVQhxPP
         NnzJ1rjqYE095ENl6FalVwg+YB6lFbcXwmQv79+ISLjqKbmhYXcMIcpUTiTe8SRSHErE
         1TfGoM7xnNf2B7UfwgoI/s1DsaCKXZnAG/nBbY9taMtVkpxgSN25gN38pI0jTgu7veLi
         UaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=aGp2olnXWk9tzJ6iXgouk2mPcXZvPD/cJY44owsbw+U=;
        b=FU1RwlOgJjtDS5nJ+LWEx8pRG6/ljmBGOVkQgRxermIzbhRtEVelah2KBAmLHbxqMk
         stDX3q6sa9kIkoUANqEkDQG2JejliYOuLj+CKJje6MU98Xg+2I/1e95Ab9FUAuq2xC67
         Etu0d5nGcC4lQlg/dllEj/B/S/o4EzOD6NmByiMANlEv1c2vHtQyGGXbTVwFQFV8aApp
         RJNyYQK2ViBMwC8RutVt76EOBVzfYxQvf+cXMycwHAt2ip7WNJmcYFoUm1tooxCD2y50
         B8Zdfq8aHYQ1N434PMlXopO4m80hhlGmVTNc6+6sQ/IMDCv6lrJDwwSt0W2jwz6ras1m
         1/MQ==
X-Gm-Message-State: AOUpUlHXKHQL/VqQFLnFrvvyZ9mneN8IrZvjlhK6fTAi0uFPq0NQdxag
        ql/lBPXsYKthPtQoyNcEkgDuNng2/cBHLLkdpfxpFaHVotTQ0hqHRn+sr0/dkNFbHRAYuYZJQSy
        mk95Cx5fKBVHuzDCkrXHFrmSuIUNRVTD6ft7/O2saZhvzUAYeFyBP4mix3eWA
X-Google-Smtp-Source: AAOMgpfGzQ7t2EtW6S6EjTaA1nvh+jNT0ts0PBdxUkyETY+u6hW8KRuNbrO0iGUj3OyCeZrteZcaXbhLzCXc
MIME-Version: 1.0
X-Received: by 2002:a37:1206:: with SMTP id c6-v6mr10886238qkh.20.1531787229936;
 Mon, 16 Jul 2018 17:27:09 -0700 (PDT)
Date:   Mon, 16 Jul 2018 17:26:53 -0700
In-Reply-To: <20180717002654.120375-1-sbeller@google.com>
Message-Id: <20180717002654.120375-6-sbeller@google.com>
References: <20180717002654.120375-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 5/6] builtin/submodule--helper: factor out method to update
 a single submodule
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we'll find this method handy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fb54936efc7..034ba1bb2e0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1725,10 +1725,17 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
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
@@ -1747,16 +1754,9 @@ static int update_submodules(struct submodule_update_clone *suc)
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
2.18.0.203.gfac676dfb9-goog

