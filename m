Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CDE91F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933223AbeBMBXI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:08 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:40164 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbeBMBXD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:03 -0500
Received: by mail-pg0-f67.google.com with SMTP id g2so8741642pgn.7
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qKamZyk6bt3ArxzFisbDy4JSaINArkkbqGCJ5LjxMjI=;
        b=T5WeX6UY5ZxNgi3KCra/fbH/CJ3fzFXWvpofHG70FEomgVTaQEWNN9ac3DT/2zUq2F
         BnYfkS4QMlhH/T933dUOgB1VwxmkNc8eYZterIOLv0V2ghWV4g/AHPVBiw4nNg1Nus/X
         EnzAXXVxccLPqXbd869fCqU4nwrn9z/6ntR2C7Rh4huBkGGLEWtLIfpdYBoWFuCBnhcY
         +3xIART4U9cFCLDpuN9BLOAkpf2r/wMobQPYeT5Ky9eWc0OO857DK0uMgiPaBunjb9ZN
         TuVuh8ClPaft32Kvf4tNULd7L8oBceZAbzF2ubIytaXe4ylp+2oIxDKuDrPkXK5RoB6w
         WGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qKamZyk6bt3ArxzFisbDy4JSaINArkkbqGCJ5LjxMjI=;
        b=JB1cuLRpzbt6SX23mKVjULMNLbX1ki+nqh7TTNuRDZoX7pIt+ns9h6GimPhETZ888S
         ogBiy1rr+1x2xNF4S65LS3z/nFcZB+GKxtVJu9bXC5RVF4T9pxv2c9rlqXap2/r/UW6g
         JEIUUhLpTP+qd/FFMXTk+mG2hObSt8nvhnlXsqQ8Y1QiJRe/BbwHVMdtYJDtTh38JFFS
         /hhtTdAvN85rC8Iw1LQT4cHRC+vWRplP1vvRYXnjOeZT99Ib0oHN9LzbZKRo/7MUBJV6
         zpChpbJaZEa4lnYZOqH9jE87eaGnoAACx+A+STNnnjkp7mf2dcrFSvXRFWxmsn/DfMQB
         irLw==
X-Gm-Message-State: APf1xPDTcJfPpDyrvHQYlACn66ray/SlZxdBVzj6nQ8T5Yn/05O4RSMC
        XMlqB6agvg3WKIHMNjGMAiixGZG8uj4=
X-Google-Smtp-Source: AH8x227g/VJ/AAy2ZP7NPko7dmvCkViO3hoY5Ez494XivCw3dbkZ/aD7lvgJ1q9IJDQNWgv6IpnHCg==
X-Received: by 10.101.69.67 with SMTP id x3mr10785408pgr.69.1518484982933;
        Mon, 12 Feb 2018 17:23:02 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i86sm2115476pfj.89.2018.02.12.17.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:02 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/26] sha1_file: add repository argument to link_alt_odb_entries
Date:   Mon, 12 Feb 2018 17:22:26 -0800
Message-Id: <20180213012241.187007-12-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4fdfdd945a..b090f403d8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -471,8 +471,12 @@ static const char *parse_alt_odb_entry(const char *string,
 	return end;
 }
 
-static void link_alt_odb_entries(const char *alt, int sep,
-				 const char *relative_base, int depth)
+#define link_alt_odb_entries(r, a, s, rb, d) \
+	link_alt_odb_entries_##r(a, s, rb, d)
+static void link_alt_odb_entries_the_repository(const char *alt,
+						int sep,
+						const char *relative_base,
+						int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf entry = STRBUF_INIT;
@@ -515,7 +519,7 @@ static void read_info_alternates_the_repository(const char *relative_base,
 		return;
 	}
 
-	link_alt_odb_entries(buf.buf, '\n', relative_base, depth);
+	link_alt_odb_entries(the_repository, buf.buf, '\n', relative_base, depth);
 	strbuf_release(&buf);
 	free(path);
 }
@@ -569,7 +573,8 @@ void add_to_alternates_file(const char *reference)
 		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (the_repository->objects.alt_odb_tail)
-			link_alt_odb_entries(reference, '\n', NULL, 0);
+			link_alt_odb_entries(the_repository, reference,
+					     '\n', NULL, 0);
 	}
 	free(alts);
 }
@@ -582,7 +587,8 @@ void add_to_alternates_memory(const char *reference)
 	 */
 	prepare_alt_odb();
 
-	link_alt_odb_entries(reference, '\n', NULL, 0);
+	link_alt_odb_entries(the_repository, reference,
+			     '\n', NULL, 0);
 }
 
 /*
@@ -685,7 +691,8 @@ void prepare_alt_odb(void)
 
 	the_repository->objects.alt_odb_tail =
 			&the_repository->objects.alt_odb_list;
-	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(the_repository, alt,
+			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(the_repository, get_object_directory(), 0);
 }
-- 
2.16.1.73.ga2c3e9663f.dirty

