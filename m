Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DAA02022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751491AbdBWXtG (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:49:06 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36019 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdBWXs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:48:58 -0500
Received: by mail-pg0-f52.google.com with SMTP id s67so2688677pgb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lUISOOjtJZMt561pX5GgrgQ1nfDLKlE8Qqk5JUz3bok=;
        b=dVZeI8J8Ho6Kuob87o/vNRTpb6APHewwyBMOkJWZspQdM/65bAWMl4wNeNFH0uygpp
         uvHo4Z1aHBpcXN142F+zpzQHlCiqWdsSvsA8LApTnKxZ0vq60rOsS5jO8RdVd1kbetUx
         wjzuujoTbBhjRD1PLtv5Bv/3cv2mNc4m5uRi9hTH5DvidgUpggF39x6LLJFPg8Y1Snb3
         f1rDkJmZ0sIMT+C2ncjONcxR0CWptRxVsYn9q21Lizaly2dz6WqEtoKirPlHV9Qk9Kgv
         kaaBCjxxcG/9gYhqSqIUxZUzKuPmm15ws3t1mi2h7E3NlXb03uNsB5D9RBTOAAgcfRDe
         NVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lUISOOjtJZMt561pX5GgrgQ1nfDLKlE8Qqk5JUz3bok=;
        b=V1dEoTNNrtraq7FUDjhZdWqDuOiEKBccJ0t5YZL2zoasOkBvaapiNdj20C6brzloJ1
         34k9yTOqIjQiKW4BFOCTv+PE0TIimkENoJIEVRtPnXBDzeE4wyHNlqwtm+6ZXQb2d3Rp
         kyimjeiREE8EFT6lp4DzuRx6oK4p02t3zRvMIjEofOOJ8CMwFssGuc0AGw2Bt20UBeGb
         ydPny0R+8ibcRSvAQVnCFnCCJscjhH0RNKR8DOiVz+2l24EnXjFAH0xGwStQRgawpKCd
         wmKkvz03yjR2vAPzybcJWwI89Mm8Dz3ETnDFvdiqGlKFc43a6Rbh6wZzhbui1noNJYRm
         NafA==
X-Gm-Message-State: AMke39nWmNzQ8otpXdIPhDN9bBILK/+LtZ1tsRzhFgATprL33JL0OC8ai8hgDJxIMTrJqAmB
X-Received: by 10.98.59.8 with SMTP id i8mr25776609pfa.132.1487893673747;
        Thu, 23 Feb 2017 15:47:53 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r74sm11660300pfb.67.2017.02.23.15.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:47:52 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 10/10] submodule--helper clone: check for configured submodules using helper
Date:   Thu, 23 Feb 2017 15:47:28 -0800
Message-Id: <20170223234728.164111-11-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the 'is_submodule_initialized()' helper to check for configured
submodules instead of manually checking for the submodule's URL in the
config.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dac02604d..68d21b600 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -760,7 +760,6 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	struct strbuf displaypath_sb = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	const char *displaypath = NULL;
-	char *url = NULL;
 	int needs_cloning = 0;
 
 	if (ce_stage(ce)) {
@@ -795,14 +794,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	}
 
 	/*
-	 * Looking up the url in .git/config.
+	 * Check if the submodule has been initialized.
 	 * We must not fall back to .gitmodules as we only want
 	 * to process configured submodules.
 	 */
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	git_config_get_string(sb.buf, &url);
-	if (!url) {
+	if (!is_submodule_initialized(ce->name)) {
 		next_submodule_warn_missing(suc, out, displaypath);
 		goto cleanup;
 	}
@@ -836,7 +832,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, "--depth=1");
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
-	argv_array_pushl(&child->args, "--url", url, NULL);
+	argv_array_pushl(&child->args, "--url", sub->url, NULL);
 	if (suc->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &suc->references)
@@ -846,7 +842,6 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_push(&child->args, suc->depth);
 
 cleanup:
-	free(url);
 	strbuf_reset(&displaypath_sb);
 	strbuf_reset(&sb);
 
-- 
2.11.0.483.g087da7b7c-goog

