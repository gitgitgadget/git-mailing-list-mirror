Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96A01F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeBUBzl (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:41 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44401 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeBUBzP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:15 -0500
Received: by mail-pl0-f68.google.com with SMTP id w21so81790plp.11
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dTVsYjj9uuMBcdo5L/AwHjfkSy4tjs0xHlVUdBFzt/U=;
        b=L3L3Sw0cRwKVqWK+aLafZMSGyPSEJn3RL00fk1FEgzOZ3u/m5Wz/IvoVWKlI73PYj/
         fQHNqzyS6OZ1Vi0NyU3lnhAEeKCaTOiy++x0LnNw+hM4DFx4Ibps2oU1oJkgSclZkSbt
         NhKUmKJbHnPJK+y0wnl5rp+5k7aqpepGB/T1P3czSexi4smRFT9Ul2J7H9GNYCB6m+66
         r68kRq5n9NVWWzf24tFSx/p9QTNikOns97wXBpsg5ny78pSiL4HHJe8ixBe77xGEq2la
         wjK6H+HvKj49cwS4Z8q5qp8Xc0zgJcXT4tiaMEOHd4jJ4SDla7d7q1gTXfqLwLezd+VB
         dGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dTVsYjj9uuMBcdo5L/AwHjfkSy4tjs0xHlVUdBFzt/U=;
        b=bDwjYQy3/AW/hViji8LTASHs89kWBFx8lXROWSnLt5DIIXXMzlElD6TziUR5NbH8Rp
         3ZFgw93m4qLCkmBN46voZOHcKzxT517cfEkuQxC0LtzUJ/ZXHokDjf5zkXajW1YdZ+j2
         frpSumILTG9uNV0OmhiDa/av/FnctLFxznfdXLtYKfPoOH0IA3LKvL3E32Dgwc31VicP
         HVzplHrwWPMo4hYXPfRFa5tNab6O8aJKUBLFCXbDxieKBf9Boc4D4vG3re/QSzwVnBUL
         JW/x1l64bFZEAqb3SeXPsCvOBXPI3hsxLEHOseP1/IqT1mFz7DyBTrK8eI8SAsWK6AxM
         /51g==
X-Gm-Message-State: APf1xPB/7738XBQYkvr98D9Ehb4UbRGfYhg8MuNrdiN3KHR10C3k+df7
        YyAGf5OSf1AZWMLMLIS7bh3lTw==
X-Google-Smtp-Source: AH8x226lu9+mksKOcZlGAz1W+JItQz032FJ9DJj+AnTONnh12ylWE5jQhGNs8TQ0tZ4UDMKy5o46ng==
X-Received: by 2002:a17:902:b707:: with SMTP id d7-v6mr1546057pls.119.1519178114246;
        Tue, 20 Feb 2018 17:55:14 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id y21sm11303222pfd.17.2018.02.20.17.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 21/27] sha1_file: add repository argument to sha1_loose_object_info
Date:   Tue, 20 Feb 2018 17:54:24 -0800
Message-Id: <20180221015430.96054-22-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the sha1_loose_object_info caller
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 0d3ff99cf2..d1f77a4c80 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1159,9 +1159,10 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1,
-				  struct object_info *oi,
-				  int flags)
+#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
+static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
+						 struct object_info *oi,
+						 int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1280,7 +1281,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			break;
 
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
+		if (!sha1_loose_object_info(the_repository, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-- 
2.16.1.291.g4437f3f132-goog

