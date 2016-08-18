Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856331F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 13:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947148AbcHRNTl (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 09:19:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34683 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947211AbcHRNQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 09:16:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so5574220wma.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 06:16:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d8OfZk4ZHLk0m+K3isuCYl9StWDRM1mwGuALKsXGc1c=;
        b=ThGkwRgKT7N2mSFSx8sIee+d2EvKlUbNr/RFFi0Kb0swcLsVe2d1UTcbKp7rLnH5IS
         Qnhacg4UhUy9MI8VlMEX56seuTbYLN9vndzFwBtyHnqk17Up86EHeDp6qxXTzmBsc6Qp
         HgnK6mxIEy37OYO2hUxBZL6Uv+hIXiqnF85YFSICl52U3V9Oq0aeh2ar7Jz30tDqn9Xu
         atnu1OG9Wd5YVFtOnJ3ZRrFmy7zlzQmwpncQsgLNp5LmNy3tRdnjh7PApTMCi81L/Mc5
         n7du30rBUVWtMdbVzL25tQJ6uc/9lRlRNfpN2lSE4a0fl6IteUpaJTHnaGVMlAc82k/X
         UpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d8OfZk4ZHLk0m+K3isuCYl9StWDRM1mwGuALKsXGc1c=;
        b=JBtW8aPBAn4RoYl9qlMw78WKp0D3bPhEBx2Vz+sQ71jso6wQThPBwGO7JZ3AbyC/Wc
         Ne9thUEfWN6lpReFIcEzDxA3W1N0cdY0gDM5Cwfc2jv2Pd7rMCT0F7Ne7SB4adZ4ytaS
         lv5NnirT4mD++fhFC2/ocVqnKruApPgQMBw+kgSYuTmzeqxaIBqdEQLWccv5ZY4XonLs
         X+XJ6xhrldEmniJPfZEMzYOdVEfhoY0K8/v9v5JjRtzLeACcg8Abk1euok4H6SOrgzzG
         ZEwOoUcL32/jM478FAWZe+KfwbfmC5cVVC5u1ltyCENkA4kMcEK5IxkvsJLcACJ4jc79
         zqrA==
X-Gm-Message-State: AEkoouvgJ6m+UMb0nwMaMXQFtLjcAonWSS0TXnhB8qClCOlc4UMpbCuaRHiSX3y9G0oUBA==
X-Received: by 10.194.28.5 with SMTP id x5mr2030661wjg.11.1471526183320;
        Thu, 18 Aug 2016 06:16:23 -0700 (PDT)
Received: from localhost.localdomain ([80.215.38.200])
        by smtp.gmail.com with ESMTPSA id s6sm2225856wjm.25.2016.08.18.06.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Aug 2016 06:16:22 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/3] index-pack: add --max-input-size=<size> option
Date:	Thu, 18 Aug 2016 15:15:51 +0200
Message-Id: <20160818131553.22580-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.rc0.3.geb1f4c9.dirty
In-Reply-To: <20160818131553.22580-1-chriscool@tuxfamily.org>
References: <20160818131553.22580-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff King <peff@peff.net>

When receiving a pack-file, it can be useful to abort the
`git index-pack`, if the pack-file is too big.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-index-pack.txt | 2 ++
 builtin/index-pack.c             | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 7a4e055..1b4b65d 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -87,6 +87,8 @@ OPTIONS
 	Specifying 0 will cause Git to auto-detect the number of CPU's
 	and use maximum 3 threads.
 
+--max-input-size=<size>::
+	Die, if the pack is larger than <size>.
 
 Note
 ----
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1d2ea58..4a8b4ae 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -87,6 +87,7 @@ static struct progress *progress;
 static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
+static off_t max_input_size;
 static unsigned deepest_delta;
 static git_SHA_CTX input_ctx;
 static uint32_t input_crc32;
@@ -297,6 +298,8 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die(_("pack too large for current definition of off_t"));
 	consumed_bytes += bytes;
+	if (max_input_size && consumed_bytes > max_input_size)
+		die(_("pack exceeds maximum allowed size"));
 }
 
 static const char *open_pack_file(const char *pack_name)
@@ -1714,6 +1717,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 					opts.off32_limit = strtoul(c+1, &c, 0);
 				if (*c || opts.off32_limit & 0x80000000)
 					die(_("bad %s"), arg);
+			} else if (skip_prefix(arg, "--max-input-size=", &arg)) {
+				max_input_size = strtoumax(arg, NULL, 10);
 			} else
 				usage(index_pack_usage);
 			continue;
-- 
2.10.0.rc0.3.geb1f4c9.dirty

