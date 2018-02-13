Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB321F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933203AbeBMBXE (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:04 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36525 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933198AbeBMBXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:02 -0500
Received: by mail-pl0-f67.google.com with SMTP id v3so5869252plg.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WJ/q4y3iWbiZ4Y7ZO6ydUVXW70k+xprG61b1Itu/8DM=;
        b=oAzgbmXbHSv/oHaC4aW2gUNz2vr5Lzs9zGV4AqXVKpUdCjiHdnRYzMsnA3PgGMoimH
         yU4OW+Ez+7nW+jU7rS1kuXhRtd9U1YPwg/XtIH8r2zsUcmL2KdrnIzwCqZEb+M5gZj95
         wjBRYVO6JWyMCbRna2yFTvKv/A4CeXpTfA+rcshMPiQzp0ZwLhMopCR1K5Rd3XztKqEH
         kei8M4t3ixct7UZnTsf9jpq9n98neum2m2FsZbmfX8zGrjFWwEPcYCv7/3/f9ps/X6zj
         nwDXyTGTYJXHOxSYXl+BploNodlYBkCwXP6YcPrZfq3QKsSC+MrRMixajnqbv/9Xc+gb
         5jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WJ/q4y3iWbiZ4Y7ZO6ydUVXW70k+xprG61b1Itu/8DM=;
        b=TUngHVCUFinDxrOsnOOZE/quYGk23vFh4Wfz6VWGqpgZmKmkQEOkJYdube84HAB0mg
         rb+jfPAlmLv5rO3cWck5hBhqrew01e2+Sh7RvE17Z55y/ZRCGxwDrlbtVBq1N9PqCDLl
         qiKQwMm6dicVjuAxxft8U0qdUwXqHLQ26rpcgdz5NxNDu9cm3w/YfDKUGEPMQZZlvP6M
         /Rr7gHseNOdv6Uy8BUja51pnsGxz2zSF7QnQkW9rDPZv0/tZePCSdJXI2wdiFO8OsVWI
         oG4Fheh5rgbeEk3/2COLn3mhKZT6kDHSL88XiLV01uEXx2b06Y08j1H+6RVb1GMYIuhE
         VQjw==
X-Gm-Message-State: APf1xPBgdGKLwE3s2rrZGGzXtvzHhVFQi2OXcvbMXiu8HXTa+IXA0eVs
        OKohwfmLE7ZHP9QdEXDzL8vDlg==
X-Google-Smtp-Source: AH8x225LPqPOgL4eorMAOGqDEonaNz7J/wySB4kbHZD0R3uqubv16Zoddnb3fOkrbaQexDj6BgIBOQ==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10-v6mr12029833plo.261.1518484981485;
        Mon, 12 Feb 2018 17:23:01 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d74sm32455341pfb.54.2018.02.12.17.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:00 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/26] sha1_file: add repository argument to read_info_alternates
Date:   Mon, 12 Feb 2018 17:22:25 -0800
Message-Id: <20180213012241.187007-11-sbeller@google.com>
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
 sha1_file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7dc5f690e2..4fdfdd945a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -393,7 +393,9 @@ static int alt_odb_usable(struct raw_object_store *o,
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
@@ -434,7 +436,7 @@ static int link_alt_odb_entry_the_repository(const char *entry,
 	ent->next = NULL;
 
 	/* recursively add alternates */
-	read_info_alternates(pathbuf.buf, depth + 1);
+	read_info_alternates(the_repository, pathbuf.buf, depth + 1);
 
 	strbuf_release(&pathbuf);
 	return 0;
@@ -500,7 +502,8 @@ static void link_alt_odb_entries(const char *alt, int sep,
 	strbuf_release(&objdirbuf);
 }
 
-static void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates_the_repository(const char *relative_base,
+						int depth)
 {
 	char *path;
 	struct strbuf buf = STRBUF_INIT;
@@ -684,7 +687,7 @@ void prepare_alt_odb(void)
 			&the_repository->objects.alt_odb_list;
 	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
 
-	read_info_alternates(get_object_directory(), 0);
+	read_info_alternates(the_repository, get_object_directory(), 0);
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.16.1.73.ga2c3e9663f.dirty

