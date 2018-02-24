Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F5E1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeBXAtQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:49:16 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38889 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbeBXAsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:14 -0500
Received: by mail-pf0-f195.google.com with SMTP id d26so4189461pfn.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x4LDcnN0i7/CpmWTYWZwItDCZ6xiD0YbVKpJ4SUkQx0=;
        b=cuu9BiuCRc4c7EfV67GtAXchqyqKenRzIlC2sWpmZ4YBKymWZhaGb98BcGr2AAbyfZ
         T2ea4gsspYYG+paDmf2CB/zrZb0kAn3UGGgs+9VJsxH5+crxE+EaqE4BHC64yLRcfMi7
         pDLxSn/ldp3qg63xmj/ypDRoBHO+ErIYSmufdkRCl6wuNp1mwue59ck1lgusui6cMQw+
         yTNU3YakDBHkWNvYk7VVySoqv4dwEa4sapCI6OKTPBgdHZ1lepey0cTvuUBiHlwW5Lc+
         YL7Xzc1aATYrjjjjXeqRlFFv4gaZHyQbzcbmJhSCs8RVT1eanNHIdGT5RjrUWgAZelaP
         cnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x4LDcnN0i7/CpmWTYWZwItDCZ6xiD0YbVKpJ4SUkQx0=;
        b=DNjnxWLRXouVr077XPJczzn/Gst558088DNWBZ4xptgVxz8gwhH9juZVWjDzuRzHcT
         7gBizDUIMRhXVPT1+YzXwRUrrWsY8A9Bxa7JGv+g+N90QnS+su4BolUBONj/GKWs/L98
         IydwPivEF75ZU+oBtItBmJS5+F3U5MX/SapSrOjFlQopu3oMOk8Ke3LrH4T3RsiAD8o0
         /tj/39UUf9UyIR8/bmYObV5J2Xc8ORlurAECn9vYS5vj7G+THIvPdsY0wgKPvkm2C7DF
         SW0Lmwa4OlvZdVE3pUaF1/5Ez/WESZBCgspQzkR+IW8lDODsfAzv6i0tjnYA0yQbttOd
         qrcA==
X-Gm-Message-State: APf1xPBA4NfBw8jZk/2IVmJHYVxeFyvg/KX2gYZv2CeaEw59N6UUL3vh
        oHSeEwd4PcQ02YOnUmybqaGTJQ==
X-Google-Smtp-Source: AH8x2255KGZiI4hZkQjj6cYE8hm9T/O1wq0aR5zIUvsPBau7ZmXIF4IzqL020bAh2WSmsky73a/Qpg==
X-Received: by 10.101.67.71 with SMTP id k7mr2764430pgq.136.1519433294070;
        Fri, 23 Feb 2018 16:48:14 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 10sm7720991pfq.51.2018.02.23.16.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 11/27] sha1_file: add repository argument to read_info_alternates
Date:   Fri, 23 Feb 2018 16:47:38 -0800
Message-Id: <20180224004754.129721-12-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See previous patch for explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index e5fe0aa04ef..f93d3b95b54 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -387,7 +387,9 @@ static int alt_odb_usable(struct raw_object_store *o,
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
-static void read_info_alternates(const char * relative_base, int depth);
+#define read_info_alternates(r, rb, d) read_info_alternates_##r(rb, d)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth);
 #define link_alt_odb_entry(r, e, rb, d, n) link_alt_odb_entry_##r(e, rb, d, n)
 static int link_alt_odb_entry_the_repository(const char *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
@@ -428,7 +430,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(pathbuf.buf, depth + 1);
+	read_info_alternates(the_repository, pathbuf.buf, depth + 1);
 
 	strbuf_release(&pathbuf);
 	return 0;
@@ -494,7 +496,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth)
 {
 	char *path;
 	struct strbuf buf = STRBUF_INIT;
@@ -678,7 +681,7 @@ void prepare_alt_odb(void)
 			&the_repository->objects.alt_odb_list;
 	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
 
-	read_info_alternates(get_object_directory(), 0);
+	read_info_alternates(the_repository, get_object_directory(), 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.16.1.291.g4437f3f132-goog

