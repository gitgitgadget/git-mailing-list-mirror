Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3AE51F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933192AbeBMBXA (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:00 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34724 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbeBMBW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:22:58 -0500
Received: by mail-pl0-f68.google.com with SMTP id bd10so1023536plb.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hlmIo4nVYi9ILXQPC4IsFyDWJ9hB0+h36O6rTRzs0WE=;
        b=Po1KTbbAiyfO0XDWxw3HgBYQfocKlM/sTbTipCn2pPFNrh9f4wEo+j9u8RVT0rAgBS
         2k7rvaj4vIdcvDelFJQdyB0OCKpLZpgtogqXJITfkNIgfbgnQwvMqsYyafllWagPRRrA
         GnAd3FGeOsPJOX/K3qH/mUcOkx208ATvKjDjxc9j/cFEHPCmzSUFOVhC91XSxw8rsNVV
         b+JLB9kAyXZl9vk5k1quau13v0oQ4NJZVz5630kzUkGrjVf5XTRpzAh53RWea+cosP3I
         l/6tc3/yyqCkw17ocXSTPzRneax9uEomGFCuyZP12wBxcHjrrHTsnpPrBLsEcSqJo0yp
         tzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hlmIo4nVYi9ILXQPC4IsFyDWJ9hB0+h36O6rTRzs0WE=;
        b=ViuxlE28eftcEDMEUgsmm9BbV37y6hcTOGhKc5T65AV1gz3KmVqC0kVuofps/hVPsN
         eCVFnYqkapa8++HLOsCL8+5YP3T52deglQOblQIERQUDDtnsHqtJxrwY9iVnqPO5T3Y8
         68ujfHuuNJch9d+YTHJo9fIDc3tFwrgl+pCjVc/bqM2mDg4E5W4+ggHA+VNJQsnHwf9b
         aKAEzLSmy76g0jdHQf7bL5B/3X4qKbjDY4TINDNKsEYfMnWa3MrJM8UnzvLvIVbes9VP
         LwXxnZ8WsCHDMREJpcu+mPSSkxQNe/SG8EmMfnaybDI8Q/PAXRmn/bwn9EQzAEvEPUeO
         Rymw==
X-Gm-Message-State: APf1xPBN9n8Ms20ttK+jhp7Jb0P8FWwdWXQyCMIi1zg3iApV0EaFpsOt
        uhWC10j4nv/zjkoS9GspzHNaOw==
X-Google-Smtp-Source: AH8x225suBq8ile0zsmoPi4IhLFgqw5xEx7VuI6+OyxY9spShC9s3illi029CDt8rOJik08WYAxGXA==
X-Received: by 2002:a17:902:594c:: with SMTP id e12-v6mr4918890plj.323.1518484978192;
        Mon, 12 Feb 2018 17:22:58 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i86sm2114251pfj.89.2018.02.12.17.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:22:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 08/26] sha1_file: add raw_object_store argument to alt_odb_usable
Date:   Mon, 12 Feb 2018 17:22:23 -0800
Message-Id: <20180213012241.187007-9-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a raw_object_store to alt_odb_usable to be more specific about which
repository to act on. The choice of the repository is delegated to its
only caller link_alt_odb_entry.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 sha1_file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 2826d5d6ed..d25b68a8fb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -350,7 +350,9 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
+static int alt_odb_usable(struct raw_object_store *o,
+			  struct strbuf *path,
+			  const char *normalized_objdir)
 {
 	struct alternate_object_database *alt;
 
@@ -366,7 +368,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * Prevent the common mistake of listing the same
 	 * thing twice, or object directory itself.
 	 */
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = o->alt_odb_list; alt; alt = alt->next) {
 		if (!fspathcmp(path->buf, alt->path))
 			return 0;
 	}
@@ -418,7 +420,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(&pathbuf, normalized_objdir)) {
+	if (!alt_odb_usable(&the_repository->objects, &pathbuf, normalized_objdir)) {
 		strbuf_release(&pathbuf);
 		return -1;
 	}
-- 
2.16.1.73.ga2c3e9663f.dirty

