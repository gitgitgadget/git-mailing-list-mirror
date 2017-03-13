Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB92920373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbdCMVoL (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:44:11 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34038 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754062AbdCMVoD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:44:03 -0400
Received: by mail-pg0-f44.google.com with SMTP id 77so70561507pgc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FkHnZbK2mCcGypGecHY/OFn6ElxjgneovOGZQiYd2Kw=;
        b=t4q3COuzSZWH8SN453k8prKguO3yYiUYHpc/u0q04wPF1zahe7QxgCTLGMj4Ur2xy1
         k9PZk4PdqJBWhDcAC2Z0LKYrreepzfnAU3BhWNHUw4xEc5+8LBsu2RUO7feCL3XKvGdf
         /3LYKqMdXbe861lMl4vj3P+62VeoWuJ9KxY5NVx3QiqQRTg9v+U928EdhKNQfZBPDjd7
         AnaHEDTojeWdjxJnQ1Y6sREgIq3p7bLnO1pUmsQdgBOQ/M2iiVPYy2O8Zvjhfa0nfnrN
         FJaOqmWkgKPYl0Sioimek+47r9BmRwAKj4p8LdOcBIfFo2jSinImqNh4VGhU3QL+vpBP
         HO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FkHnZbK2mCcGypGecHY/OFn6ElxjgneovOGZQiYd2Kw=;
        b=MVaCFnVyWvBgkqHPxY8QMPFBBUwO6HtGdxooiBMLJfbR5n+WXO/4dXWNzAXKGNms5G
         y9UuawWZDx8uqAaJfXTUr4r7fw/7o1voi/OSNgeykDrsLf5gPHmjgxOyl4hzjc9LeX4b
         O5yFP25IF86V12eBDpkIveQSZ5HJgIDsmTXZfpKT0v8zGTwPp3gOI0n02S2w7IE3VaFy
         RQWBl1V1GYQX5yv8cV9PYM/e8JlEwDSnn+YpCrO5Rjs3HzCGyDN6tbJZ77IteTKyEWUL
         yBa9f9LXfBStOu4iBeSibTcdq/ll1xUknfGqQScRllt4lMGcMqXs+MzbDaaEvzD8w1Qv
         tsiA==
X-Gm-Message-State: AMke39lJsnS1M7HXY3U2V38l1tcMFjKhINiWgYvazyxwCWxGZPcNDfZXEATbpeeJ1YG3iP0J
X-Received: by 10.99.124.10 with SMTP id x10mr38268376pgc.25.1489441431725;
        Mon, 13 Mar 2017 14:43:51 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:50 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 04/10] submodule--helper clone: check for configured submodules using helper
Date:   Mon, 13 Mar 2017 14:43:35 -0700
Message-Id: <20170313214341.172676-5-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
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
2.12.0.246.ga2ecc84866-goog

