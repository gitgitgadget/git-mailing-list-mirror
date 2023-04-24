Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485B2C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 22:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjDXWU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjDXWU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 18:20:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D407694
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:22 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b983027d0faso6743406276.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682374822; x=1684966822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPHoAacekqzdeU0Yxd6Hn6hyK2B3LLTAZI3RMhSxhlM=;
        b=fHRW97v6f0XdUfsyjC7wA0o7FkZtVJY53qvLvBFr+/WZLIppkysFAU529KAdJz5fEj
         wQ0+Wzf0tWGA37E9AKeq8amnEW06AHU7sz2teFh8t2dfcTgwS5CCxNDY0rAmTMiLVBJ4
         P8G6YTnsU4a1SSrCWlFwsRVH86oC0LC2R6hMfKKEE0SOCoJEeNhnCad41NEZ2k59JRD4
         PnhBbJX5PJZI1Qr6fJTWZYVDGx6lWwTvdYcV6tIj2SrIB6WgUEq9t4wwort3IxbW5GWZ
         29FLws+jlsBSAzZSJvYsbSu0bixQ9H/c0e5TWZaQZo8FKeEpNgogDkzcEeGL0NBOitoD
         +vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374822; x=1684966822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPHoAacekqzdeU0Yxd6Hn6hyK2B3LLTAZI3RMhSxhlM=;
        b=RzGu6auTI+lZ5nAENP9mUIKooaoXWEJMQILQoxwZ2yDHl6+SXcx7p/lGLCnRX2Lbxh
         dkc1w3VCLd6m0Bw0Py6C2B6akdwbUpVz/U+3qtvuMnwiyCktCD7rL+zFF8Q6p4uYBfsl
         MPM2chpr3PsrowDewn8LsekDv/eOmU0PZp8XvuAHokPeu/1NwccRso0kyWFQH0jdgh4j
         pNCsBuqJkOiX3b7RMA0lJ5CLA0mRH6CNRXo8+IQIlOSSjdwUIC/EUg6Q3lHWbxMv5tvN
         cI3KdgIVCAE61Rk6Pf6FTm2nsgymvTBVKhMPCkyr2gPYaqd1+Uy/AJyFlLbwTYBua3jH
         JhMw==
X-Gm-Message-State: AAQBX9eRzFvhGWPG8l+suEZAs8/Q0fXCgKXLfWuloqk6lvQXtD6JDHos
        OAlVnE0tM/tqCD05JY+U0IJkRhLarJuncSKZliy0yA==
X-Google-Smtp-Source: AKy350aHRy098RrVq2GBENfitDVq6r9dxBMIMICNYTY0Fit/GTgRn1YEjCxvGAnVz6Nyt3IUtaCbsw==
X-Received: by 2002:a25:ab84:0:b0:b8c:48b3:eaad with SMTP id v4-20020a25ab84000000b00b8c48b3eaadmr9787005ybi.47.1682374821859;
        Mon, 24 Apr 2023 15:20:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m132-20020a25588a000000b00b7767ca747bsm3148576ybb.24.2023.04.24.15.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:20:21 -0700 (PDT)
Date:   Mon, 24 Apr 2023 18:20:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 4/6] t/helper/test-oidmap.c: avoid using `strtok()`
Message-ID: <c9b929406a4e895e5148cf292af672ead2b5b5dc.1682374789.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682374789.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply similar treatment as in the previous commit to remove usage of
`strtok()` from the "oidmap" test helper.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-oidmap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index a7b7b38df1..5ce9eb3334 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -4,6 +4,7 @@
 #include "oidmap.h"
 #include "setup.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 /* key is an oid and value is a name (could be a refname for example) */
 struct test_entry {
@@ -25,6 +26,7 @@ struct test_entry {
  */
 int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
 {
+	struct string_list parts = STRING_LIST_INIT_NODUP;
 	struct strbuf line = STRBUF_INIT;
 	struct oidmap map = OIDMAP_INIT;
 
@@ -35,19 +37,24 @@ int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
 
 	/* process commands from stdin */
 	while (strbuf_getline(&line, stdin) != EOF) {
-		char *cmd, *p1 = NULL, *p2 = NULL;
+		char *cmd, *p1, *p2;
 		struct test_entry *entry;
 		struct object_id oid;
 
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
-		if (p1)
-			p2 = strtok(NULL, DELIM);
+		cmd = parts.items[0].string;
+		p1 = parts.nr >= 1 ? parts.items[1].string : NULL;
+		p2 = parts.nr >= 2 ? parts.items[2].string : NULL;
 
 		if (!strcmp("put", cmd) && p1 && p2) {
 
@@ -108,6 +115,7 @@ int cmd__oidmap(int argc UNUSED, const char **argv UNUSED)
 		}
 	}
 
+	string_list_clear(&parts, 0);
 	strbuf_release(&line);
 	oidmap_free(&map, 1);
 	return 0;
-- 
2.40.0.380.gd2df7d2365

