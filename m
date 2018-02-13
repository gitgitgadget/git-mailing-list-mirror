Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 752041F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933273AbeBMBXe (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:34 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41430 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeBMBXc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:32 -0500
Received: by mail-pg0-f66.google.com with SMTP id t4so7691073pgp.8
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=68F2QFmA8zva5KlGMxJkC4sLFRjAY0uAMxOLcZf+DzY=;
        b=quYlW4EdbJKafVkURtgNx/JvQkyskZOEwOPst1GBI22HKhhtmhd/eBW4Z0HTAzxFbN
         S5sSOcjC7vjHTT8lCBG+z8dIpcJQ07B5GlSoZhTyxWe+USDq9n5L3PMGtjC1wOXqv/1l
         dfO7m+SFv6eghUTL8r8lffVbmAx2viHXV1fvjEjjzsTImXXtyKLQgEaPwqllce0CowBd
         l7opW/kp3JVjueePRssQK83TUab2TTw06T0yKjbSK/tgN409hrpM4gY84iWRSw6bBWWN
         rKtb9pL3pbgMod3oWmllAUIse3iGRX80V8kGXbbZaMZMyTJrnftTZI3wJRPsvXvJO0tm
         0vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=68F2QFmA8zva5KlGMxJkC4sLFRjAY0uAMxOLcZf+DzY=;
        b=FtkU+kBGivuibdd40HUwiwYlWrMc0E3fqORDR+JS3hctAipXaT7lJ3GZHxkzZ8i7mD
         cWXUDClVV73hdrEM+mB0Rro/CBnCwU791uvxZ26pjbZHbXzZc5vQFg24TgdhOncrmxS0
         Cm+0Cz48AQrK8AEgDUx6ANBfCAPsUkVpxWI4bO0G+VMJszdzfKtmj9GQvSl9kAkewXrg
         jt4qjI3zkhfIwETVSBl8P51qKUaioVtWIE+7A42S0hHBvuCMBf5qDmcRvcirEELn6OeR
         aZmtKtE8QEtJQXBF/Y6oy02bsQ2ihv3hm1njtfB+SwiQmlzu1Kc7B8h/ItMw/bXNpG6L
         o8WQ==
X-Gm-Message-State: APf1xPAyxpJl+HNvxS2lZyUCu12tb1bGjmu6KedjfrcCcWtmh4CZ6A2B
        kb0gxkPrXlF+rueBu0Df0FNQ2A==
X-Google-Smtp-Source: AH8x226l6zjFwNj5imwC6nQJzLMCsxnKXuUkTCSSzrhDksT202vSuF4PxRwZNa67oKOpT0OlMx85Iw==
X-Received: by 10.98.6.4 with SMTP id 4mr3775734pfg.181.1518485011287;
        Mon, 12 Feb 2018 17:23:31 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z15sm9424896pgr.68.2018.02.12.17.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 26/26] sha1_file: allow sha1_loose_object_info to handle arbitrary repositories
Date:   Mon, 12 Feb 2018 17:22:41 -0800
Message-Id: <20180213012241.187007-27-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6237d59a59..c3f35914ce 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1148,10 +1148,9 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
-static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
-						 struct object_info *oi,
-						 int flags)
+static int sha1_loose_object_info(struct repository *r,
+				  const unsigned char *sha1,
+				  struct object_info *oi, int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1175,14 +1174,14 @@ static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
 	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
-		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
+		if (stat_sha1_file(r, sha1, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
 
-	map = map_sha1_file(the_repository, sha1, &mapsize);
+	map = map_sha1_file(r, sha1, &mapsize);
 	if (!map)
 		return -1;
 
-- 
2.16.1.73.ga2c3e9663f.dirty

