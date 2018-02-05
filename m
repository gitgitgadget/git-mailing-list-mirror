Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11281F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeBEXz7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:55:59 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37436 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbeBEXzo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:44 -0500
Received: by mail-pg0-f66.google.com with SMTP id o1so113167pgn.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HThM2jcmBnOY3Ubd2pA32DAlbmhx+71ldc+74RHhGe0=;
        b=et06sz63J5Qlui5Fmaso/uMtMOlFx7fZSUjjQxezKjSUO4dYvjILpZfJfg6xPt8XiA
         k+VrgYbuXJblFsVvwsQa66AALtMgY1bsWMAQC4G69G4qGeOfAss1MXUZ74fLf/AqMYBE
         6qi7BhUPVRvphw3ysyikSxEHZ50OiurWjWIHi0H0XEzHc1ev9Qw2SVkMB+jKZYExD21j
         PutwRnj7innT28hdo8GsskNcr4gJr/O6h+z9tlAP+RRovFgDmGnjh8UbZPHUQSD+v6qA
         ipH0Wlbtb8m/XTFHLhh2tROkkEZJBtvdkx7CaBRb4zbNA0kO6BEf2DxBCpHS61NEkb/w
         Tc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HThM2jcmBnOY3Ubd2pA32DAlbmhx+71ldc+74RHhGe0=;
        b=uj6GkL1s70bKUr1HM6btYFSgYSXB8oztyULlB61KHElNb0j0YKnvySCqep+jf8iWpO
         4n2OxPTGNar5dOGrQ1AjUFUNp5R1cubad+Sw5WkEeJX/re4YShNXVLilFaX0DMq3f8sr
         fZ2KKX3S6ijIbde4XmkBMrzfJXU/56w8jLCEdw9+hN+zCUF5PJGlvCD5csD8mYLiiT9j
         JT7I9AySGBH5dTHIME9jmvYQk16bH9hGjGZ//lO8LWNL0BjapC1WWkS6b7BJLBwwWjsA
         LfMb/NTjWdfDIhWWuJZ7ToJi5O2SzzxyQvH3dQ3yrrhThiAijvhTt7xOIuOYhKMwVT+B
         c7ZA==
X-Gm-Message-State: APf1xPBMex6jp4GDCjhMcRFirdNvkPi/5mO1vahaMTFxEofj85aTed6/
        NI86UU34Q2pKfStkc9NsFbMwaE0dFoM=
X-Google-Smtp-Source: AH8x224d6YVNLHwSlfe6AZTJtkWLdlcxvEoqQZp1mFzb8azYe63AnuFXIBm3BqVB5/ZTX+0zJ0kP3g==
X-Received: by 10.99.114.90 with SMTP id c26mr374772pgn.427.1517874943631;
        Mon, 05 Feb 2018 15:55:43 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i9sm20729818pfi.154.2018.02.05.15.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 008/194] sha1_file: add repository argument to read_info_alternates
Date:   Mon,  5 Feb 2018 15:52:02 -0800
Message-Id: <20180205235508.216277-9-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the read_info_alternates caller to
be more specific about which repository to read from. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commit, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 1e17246f5c..acb00b9680 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -393,7 +393,9 @@ static int alt_odb_usable_the_repository(struct strbuf *path,
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
2.15.1.433.g936d1b9894.dirty

