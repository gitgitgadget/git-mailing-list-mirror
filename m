Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A632C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 23:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjDMXb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDMXb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 19:31:56 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5183592
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:51 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id by8so960712ybb.9
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 16:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681428710; x=1684020710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jo8JRwRzSH+SB1J4ZOUrIyRxeAmpW9jQ2+eORzP3B4c=;
        b=Zsxbw5GwsmdrnIBJ3JKq0j6rlEHdh0PrEmmIKASwGGMAtJtMwE3CMR3Wqq+zudI58W
         RDWTMmNNHX3NPx+vFw2q2+kuE7gw4CbkfSFEbCnMNMsRLdn2de8wZhscXge3GKaE2HbG
         ik6fy+1DrcgMoHBBBOnZB7RCP/B+IJ02AcKX775/NpFsc0r2MGbw4c3Wrlvt0ha3XC3t
         wvn0msE7Qm5pXAYNc/ajBcmPsHPrzyFfeN2ie796Vb4E6qOyyhMB2YdSQDarzLi2dAez
         DGtja1DjstMHVkse3/ZMfnB7C4mvhyQb5EL+kNwVaGTKhNKwmMvfi0LWFmKkEAi1Wnj5
         AP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681428710; x=1684020710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo8JRwRzSH+SB1J4ZOUrIyRxeAmpW9jQ2+eORzP3B4c=;
        b=KEwoI4wM1ROwaoH6R9nFTvCwjwHCktWktVxkMayB8HD762+XlW6gxMoQX8nwW4DmzB
         i3mrAMT50dPYbhFt4HaxzfUbRdkwy2ogfDMh2WRnA5533ImkpO3E07U8ASPanqOThMud
         8+3jx1TLe7saSozJrp8WQtAxokA//l+zmt0IZA65S9uT9gJ5I1FQLQVrYXuyBF8MtKfV
         WdoJwXhGyywV43s+xEzh0UlmF9F7xEjMsaALxtAiK9KOjFaZRcvX4HKmolQrhvI6B/fE
         4BYMf+QIS18petE7OTWXDqzHCBWHEqovBRHqrCl0GhmSofPgXtLp0WAZWJ9lB6mGIOo9
         3VMw==
X-Gm-Message-State: AAQBX9eTyipSHRRUp6N49RTkq0GJwL4nx93bcbb+3Nn7/ZdOnDWOdG9/
        KK78NPq8hoIivp/U4/sZJd3EG+FBQvVcE6RAWjPkxg==
X-Google-Smtp-Source: AKy350aZcnCXAiPrYY0qwCAO//5buGM75UKLplTnId6cOdShv84nglUxZL0VBLotcWgIRR2qT9JxLg==
X-Received: by 2002:a25:3743:0:b0:b8f:3eda:30b7 with SMTP id e64-20020a253743000000b00b8f3eda30b7mr4253612yba.13.1681428709982;
        Thu, 13 Apr 2023 16:31:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11-20020a25bb8b000000b00b7767ca747fsm763726ybg.28.2023.04.13.16.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:31:49 -0700 (PDT)
Date:   Thu, 13 Apr 2023 19:31:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] t/helper/test-oidmap.c: avoid using `strtok()`
Message-ID: <135222d04e4d9cb85c149e0e12ea531d5f43d9cd.1681428696.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681428696.git.me@ttaylorr.com>
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
index a7b7b38df1f..cf4d2f7c085 100644
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
 
+		/* see the comment in cmd__hashmap() */
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
2.38.0.16.g393fd4c6db

