Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044CAC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 22:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjDXWU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjDXWUW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 18:20:22 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C1561B8
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:19 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54fb9384c2dso59593907b3.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682374819; x=1684966819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gF2sjAqaqKdtyrGJOlNZuAd3rzPeQPcWIGFZEps7Hn4=;
        b=muLB5P0ZxRDxgXczBVwyClVB1xXYEwxpzE8nX+XcYIcirEIP579q4xed5C4qexKINN
         JN1B3HekbkFCxBAFIU+e/QLWgubfbaXtpyGL2MHuOdgYIU/ckPPWqvjNLz98K5aTe9Z8
         weCpodNVBm4ZmwpK4yxHmwKAlVar6/rhBUzCHPoWpW2rkAoJGRnD3n9iX8oEgAVmQKKy
         7fk6lgFJuHeTMNDteQTAHDRHQRKUB349q/N/88N6ukvFhuLOwcmpDZgPXyRUMTPKvRrZ
         GxhZR6xdmzsdItWvU2QGCD06OyKcK10Cjz2eJD23VTchs1kZ6iP78pG59v1ncH7nwV5W
         y9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374819; x=1684966819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gF2sjAqaqKdtyrGJOlNZuAd3rzPeQPcWIGFZEps7Hn4=;
        b=asgC4UYY8k/Bg64p6LIE+5yTXzoxZMph9+loJlCsf9wASrJEETB570eUpxPnCKa5bA
         u3zsMCIFaRFLcZJ3PUo0M7PcSmu/jTKdSEKT1Kqz+FDOFqblkBqUM5xFFRi3e3rjwFYN
         ui36/sdxLcw2VJD7I/dxb2g8k0VwvfhQp53bTCCejzmhb7Z8UBdq76wepEGtbB47JTRe
         u8mp6PTQnXiJaB0L7fTJT3AReWnzUVRv0kZ4VUyEXYPwzb9g+d+1ym2sETqk1iF84n69
         z0pe0ilHEf8ujVSRcgjuLRcdHTc4GbO32z/ZTZFQjb5MdpFzLbpONitLqXBA9cEQcG2o
         Kdew==
X-Gm-Message-State: AAQBX9fXvksbD2XFhLS+V5AmaloOX2ZqyjIGGJ/yLmAtRi06aOnrWHBE
        WZq7UqoshVNOoyUX6xsN23R4BseNXtOc3KTtrUD9QQ==
X-Google-Smtp-Source: AKy350ZQBoYG+kMsyiyu08xW7dA4dyGJlPsOMB6q7+9azEIlEllqaRdmOeZA45Ag7juliXiBPbbOrg==
X-Received: by 2002:a0d:dd07:0:b0:54f:85a9:91c5 with SMTP id g7-20020a0ddd07000000b0054f85a991c5mr9040610ywe.24.1682374818806;
        Mon, 24 Apr 2023 15:20:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n207-20020a0dcbd8000000b00555df877a4csm3168656ywd.102.2023.04.24.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:20:18 -0700 (PDT)
Date:   Mon, 24 Apr 2023 18:20:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 3/6] t/helper/test-hashmap.c: avoid using `strtok()`
Message-ID: <78ecf13cb0a642c2591af20321245a77e9b0aadd.1682374789.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682374789.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid using the non-reentrant `strtok()` to separate the parts of each
incoming command. Instead of replacing it with `strtok_r()`, let's
instead use the more friendly pair of `string_list_split_in_place()` and
`string_list_remove_empty_items()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-hashmap.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 36ff07bd4b..0eb0b3d49c 100644
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
@@ -159,21 +161,26 @@ int cmd__hashmap(int argc, const char **argv)
 
 	/* process commands from stdin */
 	while (strbuf_getline(&line, stdin) != EOF) {
-		char *cmd, *p1 = NULL, *p2 = NULL;
+		char *cmd, *p1, *p2;
 		unsigned int hash = 0;
 		struct test_entry *entry;
 
 		/* break line into command and up to two parameters */
-		cmd = strtok(line.buf, DELIM);
+		string_list_setlen(&parts, 0);
+		string_list_split_in_place(&parts, line.buf, DELIM, 2);
+		string_list_remove_empty_items(&parts, 0);
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
 
@@ -260,6 +267,7 @@ int cmd__hashmap(int argc, const char **argv)
 		}
 	}
 
+	string_list_clear(&parts, 0);
 	strbuf_release(&line);
 	hashmap_clear_and_free(&map, struct test_entry, ent);
 	return 0;
-- 
2.40.0.380.gd2df7d2365

