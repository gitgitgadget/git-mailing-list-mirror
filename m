Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8078B20951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdCQWpa (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:45:30 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34253 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdCQWp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:45:29 -0400
Received: by mail-pf0-f176.google.com with SMTP id p189so20024423pfp.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=63KCTix55xC9mVj14CNqsBMnFsyLGixqnWa+FQ12YuE=;
        b=FDLUqLybQd3Han8RRgtWbycoKpFRKmnEwkVUbUEYj6dPkjL/UDti15NwYRQZRBrDqu
         Di9RmYuuw4yODOWLzbU77FRGWt192fNHYsQF8ksnPndsv0xQmLu/xGXLJGpLPUKR4We8
         +PNTe6hJJHPBa9nP6z5a3U8rAJuKaOFLGSWhhk3LXogj8LB6zSM4rR7WAshadug8RvsA
         PWPfwooEqa9qm+uxh7ZtvtyzrA08BccxBte82zDpC3QND3+0DLzFDfBQ+jqAE22i2jha
         BOfoSlo8TtHisCq/FIY7FoI5EqqEqU1G0HCfAVdacE9MPFWn/ZC5b2hsEmHx+lIEdjtF
         3RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=63KCTix55xC9mVj14CNqsBMnFsyLGixqnWa+FQ12YuE=;
        b=hB/gLibxZhe8xWoSRuH9rQaEUsGmdtUYxME8jbQPr/IFi4Cn4tuYRHezfKIQ2lG+NJ
         qvp8rI6ICkvBuDPjT19wDHQMdt7Sj79c52+FsHADaGQ5vizLJlt0iT+qvHRfA5ahkaOl
         vEiPsHBCt1YhL8JCCe4fFqYlH/8gP13U4Ro/PHOtS64m9F6J71Dxe+5FH/k81LdZAaN+
         8vdjjlSPL8XhbPZEGwBEWeXqoXHAk6HkcmvXTcmmIywHf/kmKY+RM4zzTy7mxEmYyp8h
         Efkhln2C2hEr9hwr1wG7ZruDuQIyzeeGIQ2NwAVwbwuhivki7xi9CropvtZo1YVjdOsd
         g1Uw==
X-Gm-Message-State: AFeK/H2RWdPSho7R++591lsztfLyJasopm7Tm3+KFxz7rMRgHajrb/F3DvbNXZAjl9BCOOc1
X-Received: by 10.98.152.91 with SMTP id q88mr19400546pfd.69.1489790302029;
        Fri, 17 Mar 2017 15:38:22 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id d3sm18699763pfc.51.2017.03.17.15.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:38:21 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 05/10] submodule--helper clone: check for configured submodules using helper
Date:   Fri, 17 Mar 2017 15:38:00 -0700
Message-Id: <20170317223805.95271-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317223805.95271-1-bmwill@google.com>
References: <20170316222952.53801-1-bmwill@google.com>
 <20170317223805.95271-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the 'is_submodule_initialized()' helper to check for configured
submodules instead of manually checking for the submodule's URL in the
config.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5fe7e23b1..f38e332c5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -759,7 +759,6 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	struct strbuf displaypath_sb = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	const char *displaypath = NULL;
-	char *url = NULL;
 	int needs_cloning = 0;
 
 	if (ce_stage(ce)) {
@@ -793,15 +792,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		goto cleanup;
 	}
 
-	/*
-	 * Looking up the url in .git/config.
-	 * We must not fall back to .gitmodules as we only want
-	 * to process configured submodules.
-	 */
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	git_config_get_string(sb.buf, &url);
-	if (!url) {
+	/* Check if the submodule has been initialized. */
+	if (!is_submodule_initialized(ce->name)) {
 		next_submodule_warn_missing(suc, out, displaypath);
 		goto cleanup;
 	}
@@ -835,7 +827,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--depth=1");
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
-	argv_array_pushl(&child->args, "--url", url, NULL);
+	argv_array_pushl(&child->args, "--url", sub->url, NULL);
 	if (suc->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &suc->references)
@@ -845,7 +837,6 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, suc->depth);
 
 cleanup:
-	free(url);
 	strbuf_reset(&displaypath_sb);
 	strbuf_reset(&sb);
 
-- 
2.12.0.367.g23dc2f6d3c-goog

