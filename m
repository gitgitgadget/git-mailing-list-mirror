Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900151F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeCXHZ3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:25:29 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40786 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCXHZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:25:25 -0400
Received: by mail-lf0-f65.google.com with SMTP id e5-v6so21382029lfb.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIP8CsvE/iGnVD94d+NukYAD8nQfqSOswYmh+xt+HV8=;
        b=c8ijEKlof4g+yaF7LauHtuRXINnSKyQT5tM7Abx8y7gI5G0PYyDCO0TqT91X1gQuUO
         BRxmuKQOfiwWpnjVoPPFxczdnFCXEawgbG5WBAMVppFJbY9zul/oxZw4mkCAbRBDd0fn
         NJXub7xbcXcyTbiakOSxME7hZ1j0CWy0YHxubOGLKKkB2JePzZZCvwBKHAeu2WbyFgW/
         aOcjw0dE/aOXWjQwW2rZ0EdMxNgdemIUixnkedeG6r4ZzZt5RY+PBzf6QUzBt9n/vsqu
         mpVm5ZTd1shfHIqyRdyFIkuTxSDDedidCBBqE17O0yD9RVzxeHVdGxT+uXvT8IzrPuKH
         O+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIP8CsvE/iGnVD94d+NukYAD8nQfqSOswYmh+xt+HV8=;
        b=cZZ6FNu+jsu6mbCLKC95GL5zX2VHafAoARma6Xe8DsYMVPVWPROB25KqgMjKDNYMO+
         yN3PGfyb82+Uxb/O9fpPqOo4cFQgMwOebkqz3/ZS8WMEDbPXdNPa+YVc8KPytC6mcKFF
         zJp9CrVNzC/evEaJsWZD5YaMn9YOJ0FYYZD6Tde7Qt311Cnl7d+OLQKrHhetGlEKCaHy
         yHSbfNM2Lbyr/UwfwfTFKG5r8+tSC9BJ+X3LvACVq9XsDH6HDJQqUiKWHFGUCBgMbOHm
         Sy1RINltnIxC4qmNfO8nqafoV3qhE74KWNkUACntjLnj4zqkqGJTDAiEk3xYBREI9xsK
         ADRA==
X-Gm-Message-State: AElRT7HKpoW6gELcq+kJViGGxB84+L3JbeUZtaVxHuXOYgVJHasszmrI
        lW/qgTAS8AD72/qRJFjRxIA=
X-Google-Smtp-Source: AG47ELvB045xc/kA0h554kHxSDkg7GND8nlKeQVhrf2WGAXIx5QizYT1FGWQe7BtwdUY6LE3OfZ0rQ==
X-Received: by 10.46.85.196 with SMTP id g65mr5768384lje.10.1521876324324;
        Sat, 24 Mar 2018 00:25:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id b67-v6sm2684028lfh.26.2018.03.24.00.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:25:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH v4 6/7] gc --auto: exclude base pack if not enough mem to "repack -ad"
Date:   Sat, 24 Mar 2018 08:25:06 +0100
Message-Id: <20180324072507.21059-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324072507.21059-1-pclouds@gmail.com>
References: <20180316192745.19557-1-pclouds@gmail.com>
 <20180324072507.21059-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pack-objects could be a big memory hog especially on large repos,
everybody knows that. The suggestion to stick a .keep file on the
giant base pack to avoid this problem is also known for a long time.

Recent patches add an option to do just this, but it has to be either
configured or activated manually. This patch lets `git gc --auto`
activate this mode automatically when it thinks `repack -ad` will use
a lot of memory and start affecting the system due to swapping or
flushing OS cache.

gc --auto decides to do this based on an estimation of pack-objects
memory usage, which is quite accurate at least for the heap part, and
whether that fits in half of system memory (the assumption here is for
desktop environment where there are many other applications running).

This mechanism only kicks in if gc.bigBasePackThreshold is not configured.
If it is, it is assumed that the user already knows what they want.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-gc.txt |  9 +++-
 builtin/gc.c             | 98 +++++++++++++++++++++++++++++++++++++++-
 builtin/pack-objects.c   |  2 +-
 config.mak.uname         |  1 +
 git-compat-util.h        |  4 ++
 pack-objects.h           |  2 +
 t/t6500-gc.sh            |  7 +++
 7 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 0adf381b52..7549094900 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -58,8 +58,13 @@ If the number of packs exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file
 or over `gc.bigPackThreshold` limit)
 are consolidated into a single pack by using the `-A` option of
-'git repack'. Setting `gc.autoPackLimit` to 0 disables
-automatic consolidation of packs.
+'git repack'.
+If the amount of memory is estimated not enough for `git repack` to
+run smoothly and `gc.bigPackThreshold` is not set, the largest
+pack will also be excluded (this is the equivalent of running `git gc`
+with `--keep-base-pack`).
+Setting `gc.autoPackLimit` to 0 disables automatic consolidation of
+packs.
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
diff --git a/builtin/gc.c b/builtin/gc.c
index 74d3aaa270..d0b04e369e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -20,6 +20,10 @@
 #include "argv-array.h"
 #include "commit.h"
 #include "packfile.h"
+#include "pack.h"
+#include "pack-objects.h"
+#include "blob.h"
+#include "tree.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -40,6 +44,7 @@ static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
 static unsigned long big_pack_threshold;
+static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
 static struct argv_array reflog = ARGV_ARRAY_INIT;
@@ -128,6 +133,7 @@ static void gc_config(void)
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
 
 	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
+	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
 
 	git_config(git_default_config, NULL);
 }
@@ -167,7 +173,8 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
-static void find_base_packs(struct string_list *packs, unsigned long limit)
+static struct packed_git *find_base_packs(struct string_list *packs,
+					  unsigned long limit)
 {
 	struct packed_git *p, *base = NULL;
 
@@ -186,6 +193,8 @@ static void find_base_packs(struct string_list *packs, unsigned long limit)
 
 	if (base)
 		string_list_append(packs, base->pack_name);
+
+	return base;
 }
 
 static int too_many_packs(void)
@@ -211,6 +220,79 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit < cnt;
 }
 
+static uint64_t total_ram(void)
+{
+#if defined(HAVE_SYSINFO)
+	struct sysinfo si;
+
+	if (!sysinfo(&si))
+		return si.totalram;
+#elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM))
+	int64_t physical_memory;
+	int mib[2];
+	size_t length;
+
+	mib[0] = CTL_HW;
+# if defined(HW_MEMSIZE)
+	mib[1] = HW_MEMSIZE;
+# else
+	mib[1] = HW_PHYSMEM;
+# endif
+	length = sizeof(int64_t);
+	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
+		return physical_memory;
+#elif defined(GIT_WINDOWS_NATIVE)
+	MEMORYSTATUSEX memInfo;
+
+	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
+	if (GlobalMemoryStatusEx(&memInfo))
+		return memInfo.ullTotalPhys;
+#endif
+	return 0;
+}
+
+static uint64_t estimate_repack_memory(struct packed_git *pack)
+{
+	unsigned long nr_objects = approximate_object_count();
+	size_t os_cache, heap;
+
+	if (!pack || !nr_objects)
+		return 0;
+
+	/*
+	 * First we have to scan through at least one pack.
+	 * Assume enough room in OS file cache to keep the entire pack
+	 * or we may accidentally evict data of other processes from
+	 * the cache.
+	 */
+	os_cache = pack->pack_size + pack->index_size;
+	/* then pack-objects needs lots more for book keeping */
+	heap = sizeof(struct object_entry) * nr_objects;
+	/*
+	 * internal rev-list --all --objects takes up some memory too,
+	 * let's say half of it is for blobs
+	 */
+	heap += sizeof(struct blob) * nr_objects / 2;
+	/*
+	 * and the other half is for trees (commits and tags are
+	 * usually insignificant)
+	 */
+	heap += sizeof(struct tree) * nr_objects / 2;
+	/* and then obj_hash[], underestimated in fact */
+	heap += sizeof(struct object *) * nr_objects;
+	/* revindex is used also */
+	heap += sizeof(struct revindex_entry) * nr_objects;
+	/*
+	 * read_sha1_file() (either at delta calculation phase, or
+	 * writing phase) also fills up the delta base cache
+	 */
+	heap += delta_base_cache_limit;
+	/* and of course pack-objects has its own delta cache */
+	heap += max_delta_cache_size;
+
+	return os_cache + heap;
+}
+
 static int keep_one_pack(struct string_list_item *item, void *data)
 {
 	argv_array_pushf(&repack, "--keep-pack=%s", basename(item->string));
@@ -261,6 +343,20 @@ static int need_to_gc(void)
 				string_list_clear(&keep_pack, 0);
 				find_base_packs(&keep_pack, 0);
 			}
+		} else {
+			struct packed_git *p = find_base_packs(&keep_pack, 0);
+			uint64_t mem_have, mem_want;
+
+			mem_have = total_ram();
+			mem_want = estimate_repack_memory(p);
+
+			/*
+			 * Only allow 1/2 of memory for pack-objects, leave
+			 * the rest for the OS and other processes in the
+			 * system.
+			 */
+			if (!mem_have || mem_want < mem_have / 2)
+				string_list_clear(&keep_pack, 0);
 		}
 
 		add_repack_all_option(&keep_pack);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7ec70131a9..8b2f8b72bf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -80,7 +80,7 @@ static uint16_t write_bitmap_options;
 static int exclude_promisor_objects;
 
 static unsigned long delta_cache_size = 0;
-static unsigned long max_delta_cache_size = 256 * 1024 * 1024;
+static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
diff --git a/config.mak.uname b/config.mak.uname
index 6a1d0de0cc..ae9cbccec1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
+	BASIC_CFLAGS += -DHAVE_SYSINFO
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 07e383257b..e373af48b8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -284,6 +284,10 @@ extern char *gitdirname(char *);
 #include <openssl/err.h>
 #endif
 
+#ifdef HAVE_SYSINFO
+# include <sys/sysinfo.h>
+#endif
+
 /* On most systems <netdb.h> would have given us this, but
  * not on some systems (e.g. z/OS).
  */
diff --git a/pack-objects.h b/pack-objects.h
index 03f1191659..af4f46c026 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,8 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+#define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
+
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;	/* uncompressed size */
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index a95969af2a..100f287b97 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -5,6 +5,13 @@ test_description='basic git gc tests
 
 . ./test-lib.sh
 
+test_expect_success 'setup' '
+	# do not let the amount of physical memory affects gc
+	# behavior, make sure we always pack everything to one pack by
+	# default
+	git config gc.bigPackThreshold 2g
+'
+
 test_expect_success 'gc empty repository' '
 	git gc
 '
-- 
2.17.0.rc0.348.gd5a49e0b6f

