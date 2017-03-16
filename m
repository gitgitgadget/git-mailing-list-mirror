Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1727020323
	for <e@80x24.org>; Thu, 16 Mar 2017 22:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754472AbdCPWhC (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:37:02 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33160 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbdCPWg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:36:57 -0400
Received: by mail-pf0-f180.google.com with SMTP id w189so30682957pfb.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=63KCTix55xC9mVj14CNqsBMnFsyLGixqnWa+FQ12YuE=;
        b=OyhgNUpulsZuPEmGNaD7hrtn+sfpt9Bes+Dd9bVMMzWdmMUe4mu3I3uk+vT/eEMbep
         FvvAWqWoS0NbyFxipueBLGK2/nYxPLpphKazadqbl/8QJI9IgJpMQTTpTl8gpibdqUGf
         nUDETQTall5CMXWXtbY7MBcEyxuDi0j78FlxhgVOlPeX/kAFO+pXwefc1/eFVsZnaWhE
         U+4J25+5R20VaO+waB30YLpH7IhGQ52VHi74Up7bRLzT0c7rwAeBSn+w+aLbm28zqhCX
         eGGiokOf+HzlAnVhPO1oR5EuJTe4Ru4aKcCdia4B6XVdQu//54Mu2XDXVJFPMhlqjJoL
         jZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=63KCTix55xC9mVj14CNqsBMnFsyLGixqnWa+FQ12YuE=;
        b=r3GdILi60XEeeK7mqTsE3/K2Hsmq5zpLgrtmppO257g78sidfp0iujn98W4Jz7vdY2
         IeuRK0ksiK7JUpZi6OaNE1aO7WUwAnI8m55dLd2DDAgvIKjC+cM/Gr/8ct3EmLcw+kAz
         5TRyj7aUoCx383wqhGqMsXRvc833V1G0wV+aZsCu1MRvxjN7T6PSKryy5e96BBivO7gQ
         Xsxj5Nb6HCS8PEaJBU9wKHwSx0yXWCRHv44qnG7N95q89e1fAzpinIIDGFEDiAVDqD+p
         1KyDXjIIgek3eN5wersm+Vy4o/B8fWxBzVyfnBp0nlD/0/ZFat8V4W12Ww3/8gCKx9EA
         4nJw==
X-Gm-Message-State: AFeK/H1JRtbKgn/1hDOa56798uVMaKIBxfLFjbPUjxT6LhRYz4gob2hLnoBY4gJ+lSNqtoxi
X-Received: by 10.98.204.195 with SMTP id j64mr12754585pfk.213.1489703406330;
        Thu, 16 Mar 2017 15:30:06 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t5sm12520946pgb.36.2017.03.16.15.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:30:05 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 05/10] submodule--helper clone: check for configured submodules using helper
Date:   Thu, 16 Mar 2017 15:29:47 -0700
Message-Id: <20170316222952.53801-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170316222952.53801-1-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
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

