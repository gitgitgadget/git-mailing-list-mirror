Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11DA81F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeBEXzz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:55:55 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32952 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeBEXzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:43 -0500
Received: by mail-pg0-f66.google.com with SMTP id u1so123651pgr.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b/KlKHdQ3hQtgJkU/EJlsctuqSyofy8wsSVz39Xgp+E=;
        b=YLH69tZopkbbFtyWCRK/aKjBTjRbrMdt92zR7+b2gDKuPgp5T0hnYRQxDJkofKW2Yw
         wfRr8Im+jJue8MKOGXm2a9AO/XUI0FILRVO1AHiz7kO1gZ8FjSTbV7jZE2pmu90sr81b
         G941S2bP40y26Wc3fLyDiz9+srLv2IqX7bg8TlGrMr6XF48kS+gglDAGwbuSj73UUS7h
         XZ9hGjVwykCgMuGWtwnT5FCMjaNCeHSb2XZ0ow0314CeqKZQKIKMNBAWYjAW0L0xYBK0
         6sRHRCkH6pD8fF7XPqrXOa8TSbvqwa8ixUG9Exhi3hLxa3BytnpxwT9hMaFXCKy8Zo7o
         oXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b/KlKHdQ3hQtgJkU/EJlsctuqSyofy8wsSVz39Xgp+E=;
        b=lhn6fnkThRGpfC72OYkEdS1KyH6K/DlkQ4uxJaf3dlQlttagOLZnRZtjtnQmqD2gI8
         Vzxg89Q3eqnhQZeDGXubITxOUOQLmPWaL9BJu0VoCksjLRCUCWm7K5mU/amAQlOFSCcG
         Mq/Pl9Gbcb0PNLhgA2SpKL6qH8ni+41QoXWPOtA36PwBDKAgstr7Wxu/zxsmeQM0LDae
         o4zAAaATTc3/4AlgTxD864Pts6iKxpDSgVtzlqNODCukq7JfLkIEyu3xtDlsKUEMPKXW
         Ppi+qpAmr7O6IvsqIo/SMXmylsUYlst+RsTc8b0oV19KAsAi1U48IhEI76yBi+a+58au
         4oUQ==
X-Gm-Message-State: APf1xPBuuVBCfKpK/ujRb9ipW8l53yJe0GL/gKd0nCjxS/tpRSq6LR87
        7dK7bK+1utVtkhkLN7QvxeMGt2h4V7s=
X-Google-Smtp-Source: AH8x227aMKLrsVBNXgH8GJklgizpiVLZWjc8Sk0X31tZRqBoX8MMYFfPvzagekLRjBPWxIa6JhSJ4Q==
X-Received: by 10.98.83.71 with SMTP id h68mr490671pfb.198.1517874942300;
        Mon, 05 Feb 2018 15:55:42 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 203sm15268653pfa.110.2018.02.05.15.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:41 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 007/194] sha1_file: add repository argument to link_alt_odb_entry
Date:   Mon,  5 Feb 2018 15:52:01 -0800
Message-Id: <20180205235508.216277-8-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the link_alt_odb_entry caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commit, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index ca002a272d..1e17246f5c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -394,8 +394,9 @@ static int alt_odb_usable_the_repository(struct strbuf *path,
  * terminating NUL.
  */
 static void read_info_alternates(const char * relative_base, int depth);
-static int link_alt_odb_entry(const char *entry, const char *relative_base,
-	int depth, const char *normalized_objdir)
+#define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
+static int link_alt_odb_entry_the_repository(const char *entry,
+	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -492,7 +493,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(entry.buf, relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(the_repository, entry.buf,
+				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
 	strbuf_release(&objdirbuf);
-- 
2.15.1.433.g936d1b9894.dirty

