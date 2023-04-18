Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3817C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjDRTUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjDRTUN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:20:13 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A1DC3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:42 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fe82d8bf5so157689137b3.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681845534; x=1684437534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLjgfWaKe+/siMa8MFjhmCmCV5Uh0/l+qwY/ehc6PLE=;
        b=FaFN2QiE1gczhU0pAdWOJB2C8ZmYmYLItX/Y8I4CzElJVcmA7hM/A23s7tTzvqyag8
         v0webUcqlxoRY/YAgKSJX/Gr2cWqZ0crGgJwucS4rnMYYTYkpGOLQ5UvN8yP6dS9Q7KV
         Xn8YR4Om2wUAcctHZXYtcg15IWC7YXWyKUZel6hAOm9QcFrFzOmlNYmLnhslWFWFhBV/
         io20FiBc+JHxdSyCPad780SxgrhqTjO2auEzn0zFez4cKS75tiusmfnsEN8w9wrUUhYt
         1t4sdQFq3egeExeqvrfnhxEghnmh7sYwWEDIcNWZLcojfCt0BmHlM5m6B8m380Inbsmi
         YtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845534; x=1684437534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLjgfWaKe+/siMa8MFjhmCmCV5Uh0/l+qwY/ehc6PLE=;
        b=XT41PL+ZJ1F8YRs3Musu4hgW4BGej3vZaxtiZBaEeIzDz4AB+/IAK74X/hAp7u+5Lf
         ASVDC57/DIND+XkOMuSVNt4Xp6rXqc4fKrHCi7DbQdlfchZX7XnKpHRx0Jo6mRk1fah4
         lYA31998UEUENr0jkAhG5FoWMLA4ZnbDEm18oCfbnSpRMtnpP1ypW+FP/YfmgUm08ZcV
         d8i0FFJFxXTsxup6rouYSPBUj+iSbJ22f8qAPY0goEqUZuTc+K8nMrbXWmUQ6MiVa6Jj
         mXFbVpTmhFDtmHz3ckSwXX/oW5PUeOiLrMdN4v0bgh771UoiqP1bHyuFRQzkgpnARCiM
         UgLg==
X-Gm-Message-State: AAQBX9d3SzBAFIxZy1Wf7djKy3RbJQjqUtdZFUFWkLNbfGRm9Ir7v5BL
        UrtMhDqReyfQWvoK9ZhmefxTjkzrViA350W+i2hgFg==
X-Google-Smtp-Source: AKy350ayX3aqRlYeEPVOUtpwCk8gGz1XZ0XZMcVyv3e8B7NbWPx996rB2bJlAtVWRf6H5E1uOIQ9IQ==
X-Received: by 2002:a0d:ebd0:0:b0:552:d913:ea18 with SMTP id u199-20020a0debd0000000b00552d913ea18mr1000930ywe.45.1681845534328;
        Tue, 18 Apr 2023 12:18:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l69-20020a812548000000b00552a118d059sm2710621ywl.117.2023.04.18.12.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:18:53 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:18:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] t/helper/test-oidmap.c: avoid using `strtok()`
Message-ID: <a659431e9cf84831bf4a1480bbb0eb8c30389a65.1681845518.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681845518.git.me@ttaylorr.com>
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
index a7b7b38df1..bca2ca0e06 100644
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
2.40.0.358.g56d2318a6d

