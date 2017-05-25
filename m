Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4319209FD
	for <e@80x24.org>; Thu, 25 May 2017 18:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036404AbdEYSgk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 14:36:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35061 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935977AbdEYSgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 14:36:38 -0400
Received: by mail-qt0-f195.google.com with SMTP id r58so31233521qtb.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jMikb1LIIjfB3n1DZqS2PzTonVfural9+7Lh5x2/xts=;
        b=TP2I0eCC6ezRa/j6nxhkMryAWXZiPY3cwmHsg1p7LZ1EDi9HthQ2Ccwg1d2IoXPGW4
         uqHfqSQUFGfdpBsx1SQ4ckIOaVAZXxT98spGS7Uto6LTomUQaZkstT34ffX4Xxay39d8
         WbzkDwANKWTjYiKeIHPrhr6z0KFNXPLMGgDsIGxTuGy8N0RQKSf+ab4FJbzHeRmUKsF+
         I7K52x/oyt/o4ha3qiuBxAqYnU+oLiKQAOIvQN1mOOaRcamRl3UgOPbL5bOdKUHP2Cgx
         q1kZJukkSbl1J65wUBMLU/y3GmOKxz1TGfPS6FZ38EaWtj8ncpQ3Bv9rIJf/h+u025AS
         2hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jMikb1LIIjfB3n1DZqS2PzTonVfural9+7Lh5x2/xts=;
        b=S9D4CZK/gNkSAfc2maiL6WYNare0GoCc+F6GEIA1Q+Cq2QRoPNnQLQafEqOh/iPmfd
         WsWt1b1sZwP09qwAJ2aDiIkc/nnjl5ekGkIvcHT5ftTu7eXwfZ9gUUMXXxlUL24fX9mE
         TyUfP0Px9/pZDPRmDIBQBb6GxCyMkAuS/5vFSVoueVS7Tu6cqunNknfgXDA6cNlEVAup
         jKlZxuc3QBK/luigpKdnm4v3MpRmq9fW4/pP8/fc5YqjMKYLeKDgkH01Akaz+FYnD7UZ
         HE8XCvpGKnpaQAhrPW5ChOV85LdiyTZVVjfRn/5FhRURCsa8boKb90a3LKBjFrZ9r4/z
         V/mA==
X-Gm-Message-State: AODbwcDCyktMeG4gbfhAAC0jJZvb4s5bdiyitZbKqGh7nycE+HNAU09G
        LzSRYfllvMyJtA==
X-Received: by 10.200.58.130 with SMTP id x2mr43697928qte.110.1495737397481;
        Thu, 25 May 2017 11:36:37 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j66sm5089231qte.26.2017.05.25.11.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 May 2017 11:36:36 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v3 0/6] Fast git status via a file system watcher
Date:   Thu, 25 May 2017 14:36:06 -0400
Message-Id: <20170525183612.3128-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V2 include:
 - switch to nanoseconds for last update time saved in index extension
   and passed to hook
 - pass the hook a version to enable simpler future updates
 - fixup compiler warnings found with different compilers
 - update test to run properly on Mac
 - fix documentation formatting and spelling errors
 - update code formatting based on feedback
 - rename fsmonitor_dirty_bitmap to fsmonitor_dirty

Ben Peart (6):
  bswap: add 64 bit endianness helper get_be64
  dir: make lookup_untracked() available outside of dir.c
  fsmonitor: teach git to optionally utilize a file system monitor to
    speed up detecting new or changed files.
  fsmonitor: add test cases for fsmonitor extension
  fsmonitor: add documentation for the fsmonitor extension.
  fsmonitor: add a sample query-fsmonitor hook script for Watchman

 Documentation/config.txt                 |   7 +
 Documentation/githooks.txt               |  23 +++
 Documentation/technical/index-format.txt |  19 +++
 Makefile                                 |   1 +
 builtin/update-index.c                   |   1 +
 cache.h                                  |   5 +
 compat/bswap.h                           |   4 +
 config.c                                 |   5 +
 dir.c                                    |  16 ++-
 dir.h                                    |   5 +
 entry.c                                  |   1 +
 environment.c                            |   1 +
 fsmonitor.c                              | 238 +++++++++++++++++++++++++++++++
 fsmonitor.h                              |   9 ++
 read-cache.c                             |  28 +++-
 t/t7519-status-fsmonitor.sh              | 158 ++++++++++++++++++++
 templates/hooks--query-fsmonitor.sample  |  37 +++++
 unpack-trees.c                           |   1 +
 18 files changed, 556 insertions(+), 3 deletions(-)
 create mode 100644 fsmonitor.c
 create mode 100644 fsmonitor.h
 create mode 100755 t/t7519-status-fsmonitor.sh
 create mode 100644 templates/hooks--query-fsmonitor.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index f7b4b4a844..48127e8729 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -450,12 +450,12 @@ processed by rebase.
 
 [[query-fsmonitor]]
 query-fsmonitor
-~~~~~~~~~~~~
+~~~~~~~~~~~~~~~
 
 This hook is invoked when the configuration option core.fsmonitor is
 set and git needs to identify changed or untracked files.  It takes
-a single argument which is the time in elapsed seconds since midnight,
-January 1, 1970.
+two arguments, a version (currently 1) and the time in elapsed
+nanoseconds since midnight, January 1, 1970.
 
 The hook should output to stdout the list of all files in the working
 directory that may have changed since the requested time.  The logic
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index b002d23c05..7aeeea6f94 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -307,7 +307,8 @@ The remaining data of each directory block is grouped by type:
   - 32-bit version number: the current supported version is 1.
 
   - 64-bit time: the extension data reflects all changes through the given
-	time which is stored as the seconds elapsed since midnight, January 1, 1970.
+	time which is stored as the nanoseconds elapsed since midnight,
+	January 1, 1970.
 
   - 32-bit bitmap size: the size of the CE_FSMONITOR_DIRTY bitmap.
 
diff --git a/cache.h b/cache.h
index 36423c77cc..58e5abf69f 100644
--- a/cache.h
+++ b/cache.h
@@ -344,8 +344,8 @@ struct index_state {
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
 	struct untracked_cache *untracked;
-	time_t fsmonitor_last_update;
-	struct ewah_bitmap *fsmonitor_dirty_bitmap;
+	uint64_t fsmonitor_last_update;
+	struct ewah_bitmap *fsmonitor_dirty;
 };
 
 extern struct index_state the_index;
diff --git a/fsmonitor.c b/fsmonitor.c
index 9f08e66db9..3ce262d47d 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -5,6 +5,9 @@
 #include "strbuf.h"
 #include "fsmonitor.h"
 
+#define INDEX_EXTENSION_VERSION	1
+#define HOOK_INTERFACE_VERSION		1
+
 static struct untracked_cache_dir *find_untracked_cache_dir(
 	struct untracked_cache *uc, struct untracked_cache_dir *ucd,
 	const char *name)
@@ -56,20 +59,20 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
 
 	hdr_version = get_be32(index);
 	index += sizeof(uint32_t);
-	if (hdr_version != 1)
+	if (hdr_version != INDEX_EXTENSION_VERSION)
 		return error("bad fsmonitor version %d", hdr_version);
 
-	istate->fsmonitor_last_update = (time_t)get_be64(index);
+	istate->fsmonitor_last_update = get_be64(index);
 	index += sizeof(uint64_t);
 
 	ewah_size = get_be32(index);
 	index += sizeof(uint32_t);
 
-	istate->fsmonitor_dirty_bitmap = ewah_new();
-	ret = ewah_read_mmap(istate->fsmonitor_dirty_bitmap, index, ewah_size);
+	istate->fsmonitor_dirty = ewah_new();
+	ret = ewah_read_mmap(istate->fsmonitor_dirty, index, ewah_size);
 	if (ret != ewah_size) {
-		ewah_free(istate->fsmonitor_dirty_bitmap);
-		istate->fsmonitor_dirty_bitmap = NULL;
+		ewah_free(istate->fsmonitor_dirty);
+		istate->fsmonitor_dirty = NULL;
 		return error("failed to parse ewah bitmap reading fsmonitor index extension");
 	}
 
@@ -86,7 +89,7 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 	uint32_t ewah_size = 0;
 	int fixup = 0;
 
-	hdr_version = htonl(1);
+	hdr_version = htonl(INDEX_EXTENSION_VERSION);
 	strbuf_add(sb, &hdr_version, sizeof(uint32_t));
 
 	tm = htonll((uint64_t)istate->fsmonitor_last_update);
@@ -132,18 +135,21 @@ static void mark_file_dirty(struct index_state *istate, const char *name)
 /*
  * Call the query-fsmonitor hook passing the time of the last saved results.
  */
-static int query_fsmonitor(time_t last_update, struct strbuf *query_result)
+static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *query_result)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
+	char ver[64];
 	char date[64];
-	const char *argv[3];
+	const char *argv[4];
 
 	if (!(argv[0] = find_hook("query-fsmonitor")))
 		return -1;
 
+	snprintf(ver, sizeof(version), "%d", version);
 	snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
-	argv[1] = date;
-	argv[2] = NULL;
+	argv[1] = ver;
+	argv[2] = date;
+	argv[3] = NULL;
 	cp.argv = argv;
 	cp.out = -1;
 
@@ -152,38 +158,41 @@ static int query_fsmonitor(time_t last_update, struct strbuf *query_result)
 
 void process_fsmonitor_extension(struct index_state *istate)
 {
-	if (!istate->fsmonitor_dirty_bitmap)
+	if (!istate->fsmonitor_dirty)
 		return;
 
-	ewah_each_bit(istate->fsmonitor_dirty_bitmap, mark_no_fsmonitor, istate);
-	ewah_free(istate->fsmonitor_dirty_bitmap);
-	istate->fsmonitor_dirty_bitmap = NULL;
+	ewah_each_bit(istate->fsmonitor_dirty, mark_no_fsmonitor, istate);
+	ewah_free(istate->fsmonitor_dirty);
+	istate->fsmonitor_dirty = NULL;
 }
 
 void refresh_by_fsmonitor(struct index_state *istate)
 {
-	static int has_run_once = FALSE;
+	static int has_run_once = 0;
 	struct strbuf query_result = STRBUF_INIT;
 	int query_success = 0;
 	size_t bol = 0; /* beginning of line */
-	time_t last_update;
+	uint64_t last_update;
 	char *buf, *entry;
 	int i;
 
 	if (!core_fsmonitor || has_run_once)
 		return;
-	has_run_once = TRUE;
+	has_run_once = 1;
 
 	/*
 	 * This could be racy so save the date/time now and the hook
 	 * should be inclusive to ensure we don't miss potential changes.
 	 */
-	last_update = time(NULL);
+	last_update = getnanotime();
 
-	/* If we have a last update time, call query-monitor for the set of changes since that time */
-	if (istate->fsmonitor_last_update) {
-		query_success = !query_fsmonitor(istate->fsmonitor_last_update, &query_result);
-	}
+	/*
+	 * If we have a last update time, call query-monitor for the set of
+	 * changes since that time.
+	 */
+	if (istate->fsmonitor_last_update)
+		query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION,
+							istate->fsmonitor_last_update, &query_result);
 
 	if (query_success) {
 		/* Mark all entries returned by the monitor as dirty */
@@ -210,11 +219,9 @@ void refresh_by_fsmonitor(struct index_state *istate)
 		 * untracked-cache itself, we can mark the untracked cache for
 		 * fsmonitor usage.
 		 */
-		if (istate->untracked) {
+		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 1;
-		}
-	}
-	else {
+	} else {
 		/* if we can't update the cache, fall back to checking them all */
 		for (i = 0; i < istate->cache_nr; i++)
 			istate->cache[i]->ce_flags |= CE_FSMONITOR_DIRTY;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index d3cffc758f..395db46d55 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -7,7 +7,7 @@ test_description='git status with file system watcher'
 clean_repo () {
 	git reset --hard HEAD
 	git clean -fd
-	rm marker -f
+	rm -f marker
 }
 
 dirty_repo () {
@@ -31,6 +31,11 @@ dirty_repo () {
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
 	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	if [ $1 -ne 1 ]
+	then
+		echo -e "Unsupported query-fsmonitor hook version.\n" >&2
+		exit 1;
+	fi
 	: >marker
 	printf "untracked\0"
 	printf "dir1/untracked\0"
diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
index 4bd22f21d8..615f3332fa 100644
--- a/templates/hooks--query-fsmonitor.sample
+++ b/templates/hooks--query-fsmonitor.sample
@@ -4,13 +4,23 @@
 # (https://facebook.github.io/watchman/) with git to provide fast
 # git status.
 #
-# The hook is passed a time_t formatted as a string and outputs to
-# stdout all files that have been modified since the given time.
-# Paths must be relative to the root of the working tree and
+# The hook is passed a time in nanoseconds formatted as a string and
+# outputs to stdout all files that have been modified since the given
+# time. Paths must be relative to the root of the working tree and
 # separated by a single NUL.
 #
 # To enable this hook, rename this file to "query-fsmonitor"
 
+# check the hook interface version
+if [ $1 -eq 1 ]
+then
+	# convert nanoseconds to seconds
+	time_t=$(($2/1000000000))
+else
+	echo -e "Unsupported query-fsmonitor hook version.\nFalling back to scanning...\n" >&2
+	exit 1;
+fi
+
 # Convert unix style paths to escaped Windows style paths
 case "$(uname -s)" in
 MINGW*|MSYS_NT*)
@@ -22,6 +32,6 @@ MINGW*|MSYS_NT*)
 esac
 
 # Query Watchman for all the changes since the requested time
-echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $1, \"fields\":[\"name\"]}]" | \
+echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $time_t, \"fields\":[\"name\"]}]" | \
 watchman -j | \
 perl -e 'use JSON::PP; my $o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o->{'error'}.\nFalling back to scanning...\n" if defined($o->{"error"}); print(join("\0", @{$o->{"files"}}));'


-- 
2.13.0.windows.1.9.gc201c67b71

