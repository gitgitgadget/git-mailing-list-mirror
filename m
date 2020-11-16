Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7A1C64E7A
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 18:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D31D22240
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 18:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="2CAf9JV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKPSlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgKPSlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 13:41:16 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53450C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 10:41:16 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id v143so17827371qkb.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 10:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/FO4J6M0NxJGQphV9tMTe9tDsyXanDuZn2o75R0R3U8=;
        b=2CAf9JV7XxxjSnk4xW0m+wuB4ZIwUuvzGTuvtGnslbkQPFU42DerAboWPUATXy5hDe
         xPVM4fOdy1P0jekbmAtFpPtQM49tsRSdLX4S26AiR3yqbsDOujitAhxDiBG/U7DwM/r8
         4+u3pfTo5qkOsxcZVHZsxKsgVlPP6YXkbsvDLsN304zPUj2jU/l2E9aIY4x81pS/SaZD
         lyRpvWcF0yM9oeN9t9jTci6kCAsJxWW1uSkidRz7KL21v9oyrjwiZmYSvH9CJx0zVzLD
         BrGLuo6Cic5AFpsubEs8q1NhDOP43kZCgAeHCENNBkFyIRxkKkLCGvLXu4HqJEl7QMY7
         b5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/FO4J6M0NxJGQphV9tMTe9tDsyXanDuZn2o75R0R3U8=;
        b=CWGk6kYNpOXwaqv9rQU/ddccFagr5ZuKsO22q9is6oeiKAwQD4VI6xaXe3ctF6ksXP
         gEn7wriihdxEbtiFeYqHYYRDaQiUmyebEcv++2nDHqWmEeF0HizUPuI0QJMZGmO6WNuX
         lDP9tvuQ8vNn8/u9aQrRlTqbLT3hltdfhbfKIfodzNrSPl7MUgrkIbIybPdLr6xdjAgV
         D9v/qOpllHFUGkkISyXWvx3L4NxOX9tC1LCqRYw8jagHFMTcu7FGpVHGpgb6ceNbCBg6
         ISjZYS69KAyY1ao6DS6bcQxct5rXSZXCXwqSTTwpzx/LIo4qXqOHkQw3y3/AL01VLvvR
         XJaQ==
X-Gm-Message-State: AOAM532QzW5LVjiBHzs+FbEMopwl6bVhglAhlrUrYw9hju0n1OLH29Vi
        Xl5rcZIV4It0/QIEZ6XBFYiLywo6j9eZdj/M
X-Google-Smtp-Source: ABdhPJxObtTPmTTMr7PWfht8+G4qcKVhzvTt0v1NfmPBpEeJHObNFBtcGgh3hBoGcFIqEpuUuh6nwA==
X-Received: by 2002:a05:620a:2202:: with SMTP id m2mr11451529qkh.251.1605552075305;
        Mon, 16 Nov 2020 10:41:15 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:990b:ddbb:a86d:1de2])
        by smtp.gmail.com with ESMTPSA id d12sm12208929qtp.77.2020.11.16.10.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 10:41:14 -0800 (PST)
Date:   Mon, 16 Nov 2020 13:41:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 1/3] repack: make "exts" array available outside cmd_repack()
Message-ID: <a235722df4e373cded3fa161124924cc0a301c0c.1605552016.git.me@ttaylorr.com>
References: <cover.1605552016.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1605552016.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We'll use it in a helper function soon.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 01e7767c79..03e2c2c44b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -202,6 +202,16 @@ static int write_oid(const struct object_id *oid, struct packed_git *pack,
 	return 0;
 }
 
+static struct {
+	const char *name;
+	unsigned optional:1;
+} exts[] = {
+	{".pack"},
+	{".idx"},
+	{".bitmap", 1},
+	{".promisor", 1},
+};
+
 static void repack_promisor_objects(const struct pack_objects_args *args,
 				    struct string_list *names)
 {
@@ -265,15 +275,6 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 
 int cmd_repack(int argc, const char **argv, const char *prefix)
 {
-	struct {
-		const char *name;
-		unsigned optional:1;
-	} exts[] = {
-		{".pack"},
-		{".idx"},
-		{".bitmap", 1},
-		{".promisor", 1},
-	};
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
-- 
2.29.2.312.gabc4d358d8

