Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F21C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 23:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDMXbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 19:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDMXbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 19:31:50 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493783592
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:48 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id v7so15722254ybi.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681428707; x=1684020707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MSRfufCEBnlAzjUuqVX4v8aSYZAk11unkkEjgdcn4I=;
        b=X85E6aNOu6CyKx6KbjtXs3STNVt/CO3/IdN/AgKRHvNtViLU2xV1tdy8MZlx6o/vJE
         MgofWgK1aF2VvSqjxSNpUweoFw4bL6/eVKPaOi89Sn7eSzL5rqnaLAUXzKA4eArkBfcb
         +eIvo8gzeWnszEa8ZDOTVMt7ZSKhuxFookI3KrB6QhKjDoPl4k51Sb1xKuAoT+TdCtDX
         htOpLfxjV4C1tA4jkNjahsSSBBPn0ReGtGW3uEYxW9KxJESQ2d3KfAVTbsWrJ/8Gu+B7
         twiHTiv7Rfy3csIBrFokAqOlT5o/1AgKlZNeDBeT2jiuhYc4kuNc9D1w5gd4IX63/k+k
         Lk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681428707; x=1684020707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MSRfufCEBnlAzjUuqVX4v8aSYZAk11unkkEjgdcn4I=;
        b=IL/xgkfj0bA5rFZD4BVtPTAmaTygPOU4U1IWV1AGVRHHRTYsBFgOgeNXdvIwQ7OVOW
         rKm0ayQR+jQJq3CWXwLJ/MvTiiYiBpR9v1cQz5wvdV957ksc2eFAsu5OjHwq6N86A6yf
         Fz8IuDx20DUeLdmgiBEBSxpQLATwHPxaveLIqiZOz+jsTdX8OwHR1cM9fyLaW0/8sMQe
         U8gJtw++sV/q6pZ1g3exMa1u1sfjckY7qCAmKkew5+Syh9vB8yXOKuw6GTWD907tSCG7
         908Eg5I4rrTgmgTj1DDee531X9geOifPyrVyGX3yAENM5j1EvThESqa09EoMNlMt0gKM
         q2lw==
X-Gm-Message-State: AAQBX9c4gvKL4gaHP6k0neKDUVaZJuLq8XglDFgc0JTQdiBIi3o/z8TO
        qD4vstehw1UHVxCv6xagw2eENtuSR4Zk9O5BUVbI1w==
X-Google-Smtp-Source: AKy350Z1tvTznCKcDgL5324Mj1gaQUGZAVhZBxvGT9oCz95MOFNsiOODPmiljkgeFfhq6719/MEmFQ==
X-Received: by 2002:a25:d751:0:b0:b67:663a:4c6e with SMTP id o78-20020a25d751000000b00b67663a4c6emr3803329ybg.25.1681428707249;
        Thu, 13 Apr 2023 16:31:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 2-20020a250102000000b00b8f3b826e58sm779185ybb.19.2023.04.13.16.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:31:47 -0700 (PDT)
Date:   Thu, 13 Apr 2023 19:31:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] t/helper/test-hashmap.c: avoid using `strtok()`
Message-ID: <0f199468a3b8375dbec0f56fdc831c3ac298eb4e.1681428696.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681428696.git.me@ttaylorr.com>
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
index 36ff07bd4be..902ceb55113 100644
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
+		parts.nr = 0;
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
2.38.0.16.g393fd4c6db

