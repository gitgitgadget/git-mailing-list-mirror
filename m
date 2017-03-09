Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B2420135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754732AbdCIBaw (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:30:52 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35492 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdCIBav (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:30:51 -0500
Received: by mail-pg0-f47.google.com with SMTP id b129so19759008pgc.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C6PPVWd8akRKUKyhV9KW9KQXSEc/bRBe8FDgEKdZc3w=;
        b=XFr61PKd3CrNpUYBj1Ljm3nvwOlF9K1aYnfeyNGrwjLkTYq85jFDAI1DHr5s3XN0im
         TTXGdiSkiY0mZ2f1fM5B4VBfklHa+UGJrLfgxpSQu17vzU88qB5W4qSuxFIFj0RZ/3PK
         G9M4LgHHg0sziwz18Pw3rIzHyZ1Tw6PcKpgir0uSkEs9yi7CYiM8ML2qMBKtT8ADF6qA
         dGBPc3iVlXgQ7WjzCtEL4I9EgP599UjBL5bkIOBD/NusDDz2urW7QmflSAacOpeOl1+M
         G33ZsFjw1HY9iNOGJyaUSnBevG1wetclAURYM7QrgyRNAv6a1p8BuDM4PDPG3Dspdqzw
         YAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C6PPVWd8akRKUKyhV9KW9KQXSEc/bRBe8FDgEKdZc3w=;
        b=pxpXYvoXpYWHE4BVtCOe5zJB/bc/pK+qCqkMIueHm+CFnfx7ESLprHvrVp5mcib6zZ
         kFo0vceUO3NqtGB7rqUhQ7jQz0iuk6AdR9AvySo+wFsBIGknJQAGaKJaw1hLySGx1OlI
         khOcwS/mq2OYG/a3EdkjDtDxEq9yap8014Ax5KaW1sSqFGg55437CmyDmibPaL1xH52j
         TU815oKUHqTD9UHRhISqmMaHibgpLR9U2IaizbV7zO+OsVCzgXg9OgqoPpqVOI8RrDRA
         mfnJigPndb3cpaz25SSrV2kBxIwgam1io+lcErRjleiKz4Uzh1qOhBiRsNYRSgoylmHY
         0D1g==
X-Gm-Message-State: AMke39mKxfWMMWAZUnw3CHtnzii1vOG7Vntka6dJdOT6rsNabd9f63DLyD6Vzk/qO6V/Gkup
X-Received: by 10.84.224.3 with SMTP id r3mr12976181plj.6.1489022641317;
        Wed, 08 Mar 2017 17:24:01 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:24:00 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 05/11] submodule--helper clone: check for configured submodules using helper
Date:   Wed,  8 Mar 2017 17:23:39 -0800
Message-Id: <20170309012345.180702-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
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
index dac02604d..bceb62a20 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -760,7 +760,6 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	struct strbuf displaypath_sb = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	const char *displaypath = NULL;
-	char *url = NULL;
 	int needs_cloning = 0;
 
 	if (ce_stage(ce)) {
@@ -794,15 +793,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
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
@@ -836,7 +828,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--depth=1");
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
-	argv_array_pushl(&child->args, "--url", url, NULL);
+	argv_array_pushl(&child->args, "--url", sub->url, NULL);
 	if (suc->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &suc->references)
@@ -846,7 +838,6 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, suc->depth);
 
 cleanup:
-	free(url);
 	strbuf_reset(&displaypath_sb);
 	strbuf_reset(&sb);
 
-- 
2.12.0.246.ga2ecc84866-goog

