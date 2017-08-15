Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B577208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 20:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751224AbdHOUNa (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 16:13:30 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33799 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdHOUN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 16:13:29 -0400
Received: by mail-pg0-f45.google.com with SMTP id u185so12003220pgb.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yXwGDM+yP2Rpb6Zt/q8Usddb+Clsr3ujQTiH7toqmDM=;
        b=cSjO07/QVZcFCkl5GGvAzBiieptEXKLtevfHzmozJ5zv4oVfdDf+obOmQNZahtAN+8
         FVhbY2VLPjd+zf//dn8oRk9j5hCYEeDMDGe7inOyNOPV3pxK/HdYRlSz/7+lZTsxzhjU
         VoxvNiF/gZ7a2/gMA0TiGWRE2SBLfSYhIbhCYuPA9yJEdiFzCSleeMAcnME3BKSrrdF/
         MRMvIp4SBVQ0N0vLPOC9JTDTM2iPOs8PA4moo/sVnoPkj3C4COeHa4pHNRTI9/teEIFA
         fQ7CulZw4ww5dyh8qFO5QdYhZuAAV06ZBYrtGehD+Xpp307nR9DPKF4rTImcNId3MiNM
         YT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yXwGDM+yP2Rpb6Zt/q8Usddb+Clsr3ujQTiH7toqmDM=;
        b=dFf9Ynj4KHoKOlHUba+Y+XatbpyZJ8YTe1BYJtiuo89Ok+Q71Iq9AFhlUqlgQkzb0/
         9pVzp9xEtFmAlUmD0ZD3txLLs7khZhOPZrIn3SFhC4iYfK1ukSSgyM2fow/SjasZCzrv
         qdTOomsKAlA3x2i/lZVJ6enH6TV+PHudjhyfxIjHG35UBQkLKQeE5cLq6E4q1AoxOuKO
         lFsOvej7WvcyUONwbyDwbYrDUolksm94592hwG0vFP26LWjVTmotD8VJRw34x+0LPB5e
         C4p3j3VHm/jBAE8mGpOybMAU8UkE7ROujVHM2QjFflgeV70y8GGbCvRz4frE3ug53oDd
         JRqQ==
X-Gm-Message-State: AHYfb5gnZrVw/mhw1Z0Cb5SykfRddjqiXX9E2TKTjVYVhdGYrRqTDId0
        eSdky9PiviiYS2K/
X-Received: by 10.98.202.214 with SMTP id y83mr30089740pfk.2.1502828009392;
        Tue, 15 Aug 2017 13:13:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:f954:a93e:8e20:9fe8])
        by smtp.gmail.com with ESMTPSA id v11sm19361231pfi.52.2017.08.15.13.13.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 13:13:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] sha1_file: make read_info_alternates static
Date:   Tue, 15 Aug 2017 13:13:19 -0700
Message-Id: <20170815201319.32395-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_info_alternates is not used from outside, so let's make it static.

We have to declare the function before link_alt_odb_entry instead of
moving the code around, link_alt_odb_entry calls read_info_alternates,
which in turn calls link_alt_odb_entry.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  This helps in a later refactoring (moving the object
  store to the_repository struct), too.
  
  Thanks,
  Stefan

 cache.h     | 1 -
 sha1_file.c | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 1c69d2a05a..4109efcf24 100644
--- a/cache.h
+++ b/cache.h
@@ -1551,7 +1551,6 @@ extern struct alternate_object_database {
 	char path[FLEX_ARRAY];
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
-extern void read_info_alternates(const char * relative_base, int depth);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index b60ae15f70..9186e2c6c7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -347,6 +347,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
  * SHA1, an extra slash for the first level indirection, and the
  * terminating NUL.
  */
+static void read_info_alternates(const char * relative_base, int depth);
 static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	int depth, const char *normalized_objdir)
 {
@@ -448,7 +449,7 @@ static void link_alt_odb_entries(const char *alt, int len, int sep,
 	strbuf_release(&objdirbuf);
 }
 
-void read_info_alternates(const char * relative_base, int depth)
+static void read_info_alternates(const char * relative_base, int depth)
 {
 	char *map;
 	size_t mapsz;
-- 
2.14.0.rc0.3.g6c2e499285

