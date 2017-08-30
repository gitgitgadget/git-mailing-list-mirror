Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76D7208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 06:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdH3Gzy (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:55:54 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33209 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdH3Gzx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:55:53 -0400
Received: by mail-pg0-f66.google.com with SMTP id m15so4481541pgc.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rrNNgL2GEDHFZgEE9z0tl+AFxIzvS2WNN+yy4sFD+YI=;
        b=kkIJCkUg98FoDHzylgCoaGDFlva6ZR1Ml4BB5Vb1lscW39RZfVOiFbzbuOAbdvf5wu
         ysgBDP2jtWgvT3i7bSADYdgxA5/ansdYGO1YcU4Pw3SwE48rnzRjyq5LZl+xjK2vjUJg
         V7JCPNPq7uqIXZlXjQ9Fwfwit/Oe3zoq6+dSGwy6COvOknqCKSmlFQ7pVikpgyq7+Uu9
         HMy2X21jIrHzo/U9LjIxKTJMrcAqD0gDE/9pqffWy7kYhFeNWLxHmi3C27Jac9gjCW5k
         BbGK6yDnW+A9eCowN4QWtvB/M0vZyhLe5o5KH+QGO6THRac65j6A2CcjVf9DzHGJoEz+
         PwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rrNNgL2GEDHFZgEE9z0tl+AFxIzvS2WNN+yy4sFD+YI=;
        b=kspD5Hagf2M9Tuhpy0l0+PchR6FZALQYfXnnet/tb6xncjyWapApUabRy9ZgjB20+o
         OMYX2fAjiG0sHbhkaY8beMUsIHxEy4vdLOmnuKwLo03MlgOqJVFQaxr4UfkC3y5v9gfY
         mfv/6szjudRj67nuhTGHqWILPx/2E1bvHu7xDkpI8b8B/XGULpAKqrYE+5KrWUNfjNpy
         I/dPS9xkJha13zGozxbSAd1myN1uW84TCaWKTqU0tMltPpcV+0tj47/jNRfBnJ85D6r8
         jWvtHnIwPV2aHxu/8az8AnrappF77gOJuWy/i67H2rOmW5UaC5VucPz/rUK1YUX+GK3C
         fzgQ==
X-Gm-Message-State: AHYfb5gHJ8t/kjH3+/4epDCijvCuchNz8x/7DU6c+N3Lp8KrTBsdJ/QD
        5F2wlxa5CCHvWElDQBc=
X-Received: by 10.101.70.130 with SMTP id h2mr618927pgr.54.1504076152415;
        Tue, 29 Aug 2017 23:55:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id v16sm8235043pgc.26.2017.08.29.23.55.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:55:51 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:55:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 06/39] pack: move approximate object count to object store
Message-ID: <20170830065550.GG153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The approximate_object_count() function maintains a rough count of
objects in a repository to estimate how long object name abbreviates
should be.  Object names are scoped to a repository and the
appropriate length may differ by repository, so the object count
should not be global.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 10 +++++++++-
 packfile.c     | 11 +++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/object-store.h b/object-store.h
index 14129fbba1..99f77d10cd 100644
--- a/object-store.h
+++ b/object-store.h
@@ -16,13 +16,21 @@ struct object_store {
 	struct alternate_object_database *alt_odb_list;
 	struct alternate_object_database **alt_odb_tail;
 
+	/*
+	 * A fast, rough count of the number of objects in the repository.
+	 * These two fields are not meant for direct access. Use
+	 * approximate_object_count() instead.
+	 */
+	unsigned long approximate_object_count;
+	unsigned approximate_object_count_valid : 1;
+
 	/*
 	 * Whether packed_git has already been populated with this repository's
 	 * packs.
 	 */
 	unsigned packed_git_initialized : 1;
 };
-#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL, 0 }
+#define OBJECT_STORE_INIT { NULL, MRU_INIT, NULL, NULL, 0, 0, 0 }
 
 struct packed_git {
 	struct packed_git *next;
diff --git a/packfile.c b/packfile.c
index c54fe0ac1c..98267f014f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -786,8 +786,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
-static int approximate_object_count_valid;
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -797,8 +795,8 @@ static int approximate_object_count_valid;
  */
 unsigned long approximate_object_count(void)
 {
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
+	if (!the_repository->objects.approximate_object_count_valid) {
+		unsigned long count;
 		struct packed_git *p;
 
 		prepare_packed_git();
@@ -808,8 +806,9 @@ unsigned long approximate_object_count(void)
 				continue;
 			count += p->num_objects;
 		}
+		the_repository->objects.approximate_object_count = count;
 	}
-	return count;
+	return the_repository->objects.approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
@@ -883,7 +882,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
-	approximate_object_count_valid = 0;
+	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
 	prepare_packed_git();
 }
-- 
2.14.1.581.gf28d330327

