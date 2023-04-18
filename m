Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3AAC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDRTUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDRTUF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:20:05 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B3B771
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:39 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-555bc7f6746so26993377b3.6
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681845531; x=1684437531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJd2a9t1532cF2WjNpo/oHCfwwv+snJeLWbryabPFKk=;
        b=Sc0B7jtQhhF5pMWSGR+FZGCxVAaj8Yd1inJrtHa/jl0y5JXplncDRUAMgAfBV2ZJ3p
         QH6nEskvA/Dg+2J6kGsmAWFc9gNhM2lbIYAL3Q6YJvq9aUlx+h8TtumUqW4mskfuEDpJ
         9biAZkDG2foNVimB4E9uhVc2Un2fzH6P6BpHCN9Z8tdRtQ1Cg3RAW6SZoitWP0pKa4Zt
         MELsuaGyVK+wh0WAhV5B728ox3qlyqFWuiOtashLtKkPGFub6FCZb8ntZ4GqZds221Hj
         vg15yvu/nlCGGYCDykhiueae/S0+eu8npubELgW2w81P4DpptREL98U6WpS5q0RS1I5v
         2C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845531; x=1684437531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJd2a9t1532cF2WjNpo/oHCfwwv+snJeLWbryabPFKk=;
        b=d+7zIwiAHgFOt02y58ESQtsw1tKYOzTLm7w1PgeSuXhtdjz0hiwia6QdXz/AiE/uWz
         q/aGZejrTtuDWQIG3bvCmxoyFHn8HJrqtOXOQy6E7FktV639pV5mfipBJdFQFV0u68mC
         0cj5wj0IxUPmadOg1BhI6iVKVsUIMpJBzZIuJLNf7jMQRzxp0er9KM9KhG+RyhIt9xHO
         BbFMSyX3JPLpSJ0B9uR4BN4c3KZcM7QWaRoU/dVhZZGkGG6PLfn2q8v4WIYupxqBYDN+
         ZmaRGkCD4ookOXGWhX8sV0lVga+h4c+aEOpwJi54lIYUDdj5yRVX6l8HeMzRRo+wdHrO
         wH1g==
X-Gm-Message-State: AAQBX9dqqRScJFa6cPinMRBBc19CiqQtldaPk4HgORA36Gu5jcIYEDIE
        1ETzsb3AvASQZw7F6MOKXB9PnL/n8HTvvb8imqmM9A==
X-Google-Smtp-Source: AKy350Y8Ci75dc6JZwc9V+QX8gYRkK0LZcwEjGQ7+uqok6xWGwaDXGlQa465RIhDtj7A1YbVL3++HQ==
X-Received: by 2002:a81:91c6:0:b0:4fb:8b40:5899 with SMTP id i189-20020a8191c6000000b004fb8b405899mr1030266ywg.7.1681845531156;
        Tue, 18 Apr 2023 12:18:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 17-20020a810d11000000b00545a0818479sm3986892ywn.9.2023.04.18.12.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:18:50 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:18:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/6] t/helper/test-hashmap.c: avoid using `strtok()`
Message-ID: <0ae07dec3663d7cbb0f8662c47485c0667a879b9.1681845518.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681845518.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid using the non-reentrant `strtok()` to separate the parts of each
incoming command. Instead of replacing it with `strtok_r()`, let's
instead use the more friendly `string_list_split_in_place_multi()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-hashmap.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 36ff07bd4b..5a3e74a3e5 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -2,6 +2,7 @@
 #include "git-compat-util.h"
 #include "hashmap.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 struct test_entry
 {
@@ -150,6 +151,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
  */
 int cmd__hashmap(int argc, const char **argv)
 {
+	struct string_list parts = STRING_LIST_INIT_NODUP;
 	struct strbuf line = STRBUF_INIT;
 	int icase;
 	struct hashmap map = HASHMAP_INIT(test_entry_cmp, &icase);
@@ -159,21 +161,34 @@ int cmd__hashmap(int argc, const char **argv)
 
 	/* process commands from stdin */
 	while (strbuf_getline(&line, stdin) != EOF) {
-		char *cmd, *p1 = NULL, *p2 = NULL;
+		char *cmd, *p1, *p2;
 		unsigned int hash = 0;
 		struct test_entry *entry;
 
+		/*
+		 * Because we memdup() the arguments out of the
+		 * string_list before inserting them into the hashmap,
+		 * it's OK to set its length back to zero to avoid
+		 * re-allocating the items array once per line.
+		 *
+		 * By doing so, we'll instead overwrite the existing
+		 * entries and avoid re-allocating.
+		 */
+		string_list_setlen(&parts, 0);
 		/* break line into command and up to two parameters */
-		cmd = strtok(line.buf, DELIM);
+		string_list_split_in_place_multi(&parts, line.buf, DELIM, 2);
+
 		/* ignore empty lines */
-		if (!cmd || *cmd == '#')
+		if (!parts.nr)
+			continue;
+		if (!*parts.items[0].string || *parts.items[0].string == '#')
 			continue;
 
-		p1 = strtok(NULL, DELIM);
-		if (p1) {
+		cmd = parts.items[0].string;
+		p1 = parts.nr >= 1 ? parts.items[1].string : NULL;
+		p2 = parts.nr >= 2 ? parts.items[2].string : NULL;
+		if (p1)
 			hash = icase ? strihash(p1) : strhash(p1);
-			p2 = strtok(NULL, DELIM);
-		}
 
 		if (!strcmp("add", cmd) && p1 && p2) {
 
@@ -260,6 +275,7 @@ int cmd__hashmap(int argc, const char **argv)
 		}
 	}
 
+	string_list_clear(&parts, 0);
 	strbuf_release(&line);
 	hashmap_clear_and_free(&map, struct test_entry, ent);
 	return 0;
-- 
2.40.0.358.g56d2318a6d

