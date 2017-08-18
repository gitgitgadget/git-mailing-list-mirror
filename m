Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F85208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbdHRWU4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:20:56 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:37602 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbdHRWUy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:54 -0400
Received: by mail-pg0-f51.google.com with SMTP id y129so72155613pgy.4
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sIdZpzjcx6Jc5naoZ213rSJLNCseB+OHsF7Y+PXl+xE=;
        b=AZCmylOjOgEUjAdk3dzv/J82Jfc0m0FyZtkjNtiYcRUnhWEKDpTe6sgZqCdnd+11rZ
         t3/HmA3+CrsGWTiILcDr+UXeD7esLKaAkd1aapHu+ZNMx6pPFjKDW/Di8radMr6Kdvxx
         DDz5BsZ5H1RWsJEbk2SHpHc8thdS6f7fAYoG2AXVMyuASApMZv2QFJ0V0jFPdOahmkzm
         0nUmS6jdl7s82toT/9nyKKslhTBfoVkbCz1UbWXoN0vfewCuJYBr4yUe6SZC3iO3I2hC
         ga2u4/Uo75xfZVLfx9kgIX8sOYIKzo1VUDfWhqMx9ZFBfDkLqF3pM5wAbTID9aeJojl9
         9tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sIdZpzjcx6Jc5naoZ213rSJLNCseB+OHsF7Y+PXl+xE=;
        b=qiNNk624kAeyO5nYVkI6Wulw9T6bXtfDm5++RC+0Znt6nMGRHOcEfXWh+IMe8eCN40
         B0rU6+s2hqCRiZoHbnZ4Dj6L+XtnNs0unnMmQXhYBfsXNQJn3zwpCQeJJfJ214cAk0iR
         Bu0OzXG/gAh7ROcL82mO2wss3R8zhops+wC2vVdlqbGP7ja6yqkwxB+s1NbJY+LVsy8C
         I/MvRud6Fu95JOLH1pLaKcn0ZLbpXpfvAeu0u0kkQ7x8WyWnBIIht1kSnzpIW74b4/d6
         7ZmNynM3042RR8dHJL9MUgfQNsHPPNeizPdmvx6if2NC5tELkqAmR2C3x1twF0tXrlL1
         vrmw==
X-Gm-Message-State: AHYfb5hBaGPRWFFMaiwhpktSVIhtFcnSka89Vq+QFrcvGU1UwpRR8U3F
        +UHDAZcybJJIhq6FE/LHOA==
X-Received: by 10.84.238.200 with SMTP id l8mr5847071pln.302.1503094853409;
        Fri, 18 Aug 2017 15:20:53 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:52 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 07/23] pack: move use_pack()
Date:   Fri, 18 Aug 2017 15:20:22 -0700
Message-Id: <b5755433713183f1c4f9066f6c80d93e2c4974e9.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function open_packed_git() needs to be temporarily made global. Its
scope will be restored to static in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |   1 -
 packfile.c  | 303 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 packfile.h  |  14 +--
 sha1_file.c | 285 --------------------------------------------------------
 streaming.c |   1 +
 5 files changed, 298 insertions(+), 306 deletions(-)

diff --git a/cache.h b/cache.h
index bbc56566e..a27018210 100644
--- a/cache.h
+++ b/cache.h
@@ -1645,7 +1645,6 @@ extern int odb_mkstemp(struct strbuf *template, const char *pattern);
  */
 extern int odb_pack_keep(const char *name);
 
-extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, size_t *);
 extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
diff --git a/packfile.c b/packfile.c
index c8e2dbdee..ea451d27e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -24,14 +24,14 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 	return odb_pack_name(&buf, sha1, "idx");
 }
 
-unsigned int pack_used_ctr;
-unsigned int pack_mmap_calls;
-unsigned int peak_pack_open_windows;
-unsigned int pack_open_windows;
+static unsigned int pack_used_ctr;
+static unsigned int pack_mmap_calls;
+static unsigned int peak_pack_open_windows;
+static unsigned int pack_open_windows;
 unsigned int pack_open_fds;
-unsigned int pack_max_fds;
-size_t peak_pack_mapped;
-size_t pack_mapped;
+static unsigned int pack_max_fds;
+static size_t peak_pack_mapped;
+static size_t pack_mapped;
 struct packed_git *packed_git;
 
 static struct mru packed_git_mru_storage;
@@ -228,7 +228,7 @@ static void scan_windows(struct packed_git *p,
 	}
 }
 
-int unuse_one_window(struct packed_git *current)
+static int unuse_one_window(struct packed_git *current)
 {
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
@@ -274,7 +274,7 @@ void close_pack_windows(struct packed_git *p)
 	}
 }
 
-int close_pack_fd(struct packed_git *p)
+static int close_pack_fd(struct packed_git *p)
 {
 	if (p->pack_fd < 0)
 		return 0;
@@ -311,3 +311,288 @@ void close_all_packs(void)
 		else
 			close_pack(p);
 }
+
+/*
+ * The LRU pack is the one with the oldest MRU window, preferring packs
+ * with no used windows, or the oldest mtime if it has no windows allocated.
+ */
+static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struct pack_window **mru_w, int *accept_windows_inuse)
+{
+	struct pack_window *w, *this_mru_w;
+	int has_windows_inuse = 0;
+
+	/*
+	 * Reject this pack if it has windows and the previously selected
+	 * one does not.  If this pack does not have windows, reject
+	 * it if the pack file is newer than the previously selected one.
+	 */
+	if (*lru_p && !*mru_w && (p->windows || p->mtime > (*lru_p)->mtime))
+		return;
+
+	for (w = this_mru_w = p->windows; w; w = w->next) {
+		/*
+		 * Reject this pack if any of its windows are in use,
+		 * but the previously selected pack did not have any
+		 * inuse windows.  Otherwise, record that this pack
+		 * has windows in use.
+		 */
+		if (w->inuse_cnt) {
+			if (*accept_windows_inuse)
+				has_windows_inuse = 1;
+			else
+				return;
+		}
+
+		if (w->last_used > this_mru_w->last_used)
+			this_mru_w = w;
+
+		/*
+		 * Reject this pack if it has windows that have been
+		 * used more recently than the previously selected pack.
+		 * If the previously selected pack had windows inuse and
+		 * we have not encountered a window in this pack that is
+		 * inuse, skip this check since we prefer a pack with no
+		 * inuse windows to one that has inuse windows.
+		 */
+		if (*mru_w && *accept_windows_inuse == has_windows_inuse &&
+		    this_mru_w->last_used > (*mru_w)->last_used)
+			return;
+	}
+
+	/*
+	 * Select this pack.
+	 */
+	*mru_w = this_mru_w;
+	*lru_p = p;
+	*accept_windows_inuse = has_windows_inuse;
+}
+
+static int close_one_pack(void)
+{
+	struct packed_git *p, *lru_p = NULL;
+	struct pack_window *mru_w = NULL;
+	int accept_windows_inuse = 1;
+
+	for (p = packed_git; p; p = p->next) {
+		if (p->pack_fd == -1)
+			continue;
+		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
+	}
+
+	if (lru_p)
+		return close_pack_fd(lru_p);
+
+	return 0;
+}
+
+static unsigned int get_max_fd_limit(void)
+{
+#ifdef RLIMIT_NOFILE
+	{
+		struct rlimit lim;
+
+		if (!getrlimit(RLIMIT_NOFILE, &lim))
+			return lim.rlim_cur;
+	}
+#endif
+
+#ifdef _SC_OPEN_MAX
+	{
+		long open_max = sysconf(_SC_OPEN_MAX);
+		if (0 < open_max)
+			return open_max;
+		/*
+		 * Otherwise, we got -1 for one of the two
+		 * reasons:
+		 *
+		 * (1) sysconf() did not understand _SC_OPEN_MAX
+		 *     and signaled an error with -1; or
+		 * (2) sysconf() said there is no limit.
+		 *
+		 * We _could_ clear errno before calling sysconf() to
+		 * tell these two cases apart and return a huge number
+		 * in the latter case to let the caller cap it to a
+		 * value that is not so selfish, but letting the
+		 * fallback OPEN_MAX codepath take care of these cases
+		 * is a lot simpler.
+		 */
+	}
+#endif
+
+#ifdef OPEN_MAX
+	return OPEN_MAX;
+#else
+	return 1; /* see the caller ;-) */
+#endif
+}
+
+/*
+ * Do not call this directly as this leaks p->pack_fd on error return;
+ * call open_packed_git() instead.
+ */
+static int open_packed_git_1(struct packed_git *p)
+{
+	struct stat st;
+	struct pack_header hdr;
+	unsigned char sha1[20];
+	unsigned char *idx_sha1;
+	long fd_flag;
+
+	if (!p->index_data && open_pack_index(p))
+		return error("packfile %s index unavailable", p->pack_name);
+
+	if (!pack_max_fds) {
+		unsigned int max_fds = get_max_fd_limit();
+
+		/* Save 3 for stdin/stdout/stderr, 22 for work */
+		if (25 < max_fds)
+			pack_max_fds = max_fds - 25;
+		else
+			pack_max_fds = 1;
+	}
+
+	while (pack_max_fds <= pack_open_fds && close_one_pack())
+		; /* nothing */
+
+	p->pack_fd = git_open(p->pack_name);
+	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
+		return -1;
+	pack_open_fds++;
+
+	/* If we created the struct before we had the pack we lack size. */
+	if (!p->pack_size) {
+		if (!S_ISREG(st.st_mode))
+			return error("packfile %s not a regular file", p->pack_name);
+		p->pack_size = st.st_size;
+	} else if (p->pack_size != st.st_size)
+		return error("packfile %s size changed", p->pack_name);
+
+	/* We leave these file descriptors open with sliding mmap;
+	 * there is no point keeping them open across exec(), though.
+	 */
+	fd_flag = fcntl(p->pack_fd, F_GETFD, 0);
+	if (fd_flag < 0)
+		return error("cannot determine file descriptor flags");
+	fd_flag |= FD_CLOEXEC;
+	if (fcntl(p->pack_fd, F_SETFD, fd_flag) == -1)
+		return error("cannot set FD_CLOEXEC");
+
+	/* Verify we recognize this pack file format. */
+	if (read_in_full(p->pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
+		return error("file %s is far too short to be a packfile", p->pack_name);
+	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
+		return error("file %s is not a GIT packfile", p->pack_name);
+	if (!pack_version_ok(hdr.hdr_version))
+		return error("packfile %s is version %"PRIu32" and not"
+			" supported (try upgrading GIT to a newer version)",
+			p->pack_name, ntohl(hdr.hdr_version));
+
+	/* Verify the pack matches its index. */
+	if (p->num_objects != ntohl(hdr.hdr_entries))
+		return error("packfile %s claims to have %"PRIu32" objects"
+			     " while index indicates %"PRIu32" objects",
+			     p->pack_name, ntohl(hdr.hdr_entries),
+			     p->num_objects);
+	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
+		return error("end of packfile %s is unavailable", p->pack_name);
+	if (read_in_full(p->pack_fd, sha1, sizeof(sha1)) != sizeof(sha1))
+		return error("packfile %s signature is unavailable", p->pack_name);
+	idx_sha1 = ((unsigned char *)p->index_data) + p->index_size - 40;
+	if (hashcmp(sha1, idx_sha1))
+		return error("packfile %s does not match index", p->pack_name);
+	return 0;
+}
+
+int open_packed_git(struct packed_git *p)
+{
+	if (!open_packed_git_1(p))
+		return 0;
+	close_pack_fd(p);
+	return -1;
+}
+
+static int in_window(struct pack_window *win, off_t offset)
+{
+	/* We must promise at least 20 bytes (one hash) after the
+	 * offset is available from this window, otherwise the offset
+	 * is not actually in this window and a different window (which
+	 * has that one hash excess) must be used.  This is to support
+	 * the object header and delta base parsing routines below.
+	 */
+	off_t win_off = win->offset;
+	return win_off <= offset
+		&& (offset + 20) <= (win_off + win->len);
+}
+
+unsigned char *use_pack(struct packed_git *p,
+		struct pack_window **w_cursor,
+		off_t offset,
+		size_t *left)
+{
+	struct pack_window *win = *w_cursor;
+
+	/* Since packfiles end in a hash of their content and it's
+	 * pointless to ask for an offset into the middle of that
+	 * hash, and the in_window function above wouldn't match
+	 * don't allow an offset too close to the end of the file.
+	 */
+	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
+		die("packfile %s cannot be accessed", p->pack_name);
+	if (offset > (p->pack_size - 20))
+		die("offset beyond end of packfile (truncated pack?)");
+	if (offset < 0)
+		die(_("offset before end of packfile (broken .idx?)"));
+
+	if (!win || !in_window(win, offset)) {
+		if (win)
+			win->inuse_cnt--;
+		for (win = p->windows; win; win = win->next) {
+			if (in_window(win, offset))
+				break;
+		}
+		if (!win) {
+			size_t window_align = packed_git_window_size / 2;
+			off_t len;
+
+			if (p->pack_fd == -1 && open_packed_git(p))
+				die("packfile %s cannot be accessed", p->pack_name);
+
+			win = xcalloc(1, sizeof(*win));
+			win->offset = (offset / window_align) * window_align;
+			len = p->pack_size - win->offset;
+			if (len > packed_git_window_size)
+				len = packed_git_window_size;
+			win->len = (size_t)len;
+			pack_mapped += win->len;
+			while (packed_git_limit < pack_mapped
+				&& unuse_one_window(p))
+				; /* nothing */
+			win->base = xmmap(NULL, win->len,
+				PROT_READ, MAP_PRIVATE,
+				p->pack_fd, win->offset);
+			if (win->base == MAP_FAILED)
+				die_errno("packfile %s cannot be mapped",
+					  p->pack_name);
+			if (!win->offset && win->len == p->pack_size
+				&& !p->do_not_close)
+				close_pack_fd(p);
+			pack_mmap_calls++;
+			pack_open_windows++;
+			if (pack_mapped > peak_pack_mapped)
+				peak_pack_mapped = pack_mapped;
+			if (pack_open_windows > peak_pack_open_windows)
+				peak_pack_open_windows = pack_open_windows;
+			win->next = p->windows;
+			p->windows = win;
+		}
+	}
+	if (win != *w_cursor) {
+		win->last_used = pack_used_ctr++;
+		win->inuse_cnt++;
+		*w_cursor = win;
+	}
+	offset -= win->offset;
+	if (left)
+		*left = win->len - xsize_t(offset);
+	return win->base + offset;
+}
diff --git a/packfile.h b/packfile.h
index c6a07de62..97cfc5e70 100644
--- a/packfile.h
+++ b/packfile.h
@@ -24,14 +24,7 @@ extern char *sha1_pack_name(const unsigned char *sha1);
  */
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 
-extern unsigned int pack_used_ctr;
-extern unsigned int pack_mmap_calls;
-extern unsigned int peak_pack_open_windows;
-extern unsigned int pack_open_windows;
 extern unsigned int pack_open_fds;
-extern unsigned int pack_max_fds;
-extern size_t peak_pack_mapped;
-extern size_t pack_mapped;
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
@@ -49,13 +42,12 @@ extern int open_pack_index(struct packed_git *);
  */
 extern void close_pack_index(struct packed_git *);
 
+extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, size_t *);
 extern void close_pack_windows(struct packed_git *);
 extern void close_all_packs(void);
 
-extern int close_pack_fd(struct packed_git *);
-
-extern int unuse_one_window(struct packed_git *current);
-
 extern void release_pack_memory(size_t);
 
+extern int open_packed_git(struct packed_git *p);
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 7913a69f1..7704801d1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -718,79 +718,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-/*
- * The LRU pack is the one with the oldest MRU window, preferring packs
- * with no used windows, or the oldest mtime if it has no windows allocated.
- */
-static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struct pack_window **mru_w, int *accept_windows_inuse)
-{
-	struct pack_window *w, *this_mru_w;
-	int has_windows_inuse = 0;
-
-	/*
-	 * Reject this pack if it has windows and the previously selected
-	 * one does not.  If this pack does not have windows, reject
-	 * it if the pack file is newer than the previously selected one.
-	 */
-	if (*lru_p && !*mru_w && (p->windows || p->mtime > (*lru_p)->mtime))
-		return;
-
-	for (w = this_mru_w = p->windows; w; w = w->next) {
-		/*
-		 * Reject this pack if any of its windows are in use,
-		 * but the previously selected pack did not have any
-		 * inuse windows.  Otherwise, record that this pack
-		 * has windows in use.
-		 */
-		if (w->inuse_cnt) {
-			if (*accept_windows_inuse)
-				has_windows_inuse = 1;
-			else
-				return;
-		}
-
-		if (w->last_used > this_mru_w->last_used)
-			this_mru_w = w;
-
-		/*
-		 * Reject this pack if it has windows that have been
-		 * used more recently than the previously selected pack.
-		 * If the previously selected pack had windows inuse and
-		 * we have not encountered a window in this pack that is
-		 * inuse, skip this check since we prefer a pack with no
-		 * inuse windows to one that has inuse windows.
-		 */
-		if (*mru_w && *accept_windows_inuse == has_windows_inuse &&
-		    this_mru_w->last_used > (*mru_w)->last_used)
-			return;
-	}
-
-	/*
-	 * Select this pack.
-	 */
-	*mru_w = this_mru_w;
-	*lru_p = p;
-	*accept_windows_inuse = has_windows_inuse;
-}
-
-static int close_one_pack(void)
-{
-	struct packed_git *p, *lru_p = NULL;
-	struct pack_window *mru_w = NULL;
-	int accept_windows_inuse = 1;
-
-	for (p = packed_git; p; p = p->next) {
-		if (p->pack_fd == -1)
-			continue;
-		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
-	}
-
-	if (lru_p)
-		return close_pack_fd(lru_p);
-
-	return 0;
-}
-
 void unuse_pack(struct pack_window **w_cursor)
 {
 	struct pack_window *w = *w_cursor;
@@ -800,218 +727,6 @@ void unuse_pack(struct pack_window **w_cursor)
 	}
 }
 
-static unsigned int get_max_fd_limit(void)
-{
-#ifdef RLIMIT_NOFILE
-	{
-		struct rlimit lim;
-
-		if (!getrlimit(RLIMIT_NOFILE, &lim))
-			return lim.rlim_cur;
-	}
-#endif
-
-#ifdef _SC_OPEN_MAX
-	{
-		long open_max = sysconf(_SC_OPEN_MAX);
-		if (0 < open_max)
-			return open_max;
-		/*
-		 * Otherwise, we got -1 for one of the two
-		 * reasons:
-		 *
-		 * (1) sysconf() did not understand _SC_OPEN_MAX
-		 *     and signaled an error with -1; or
-		 * (2) sysconf() said there is no limit.
-		 *
-		 * We _could_ clear errno before calling sysconf() to
-		 * tell these two cases apart and return a huge number
-		 * in the latter case to let the caller cap it to a
-		 * value that is not so selfish, but letting the
-		 * fallback OPEN_MAX codepath take care of these cases
-		 * is a lot simpler.
-		 */
-	}
-#endif
-
-#ifdef OPEN_MAX
-	return OPEN_MAX;
-#else
-	return 1; /* see the caller ;-) */
-#endif
-}
-
-/*
- * Do not call this directly as this leaks p->pack_fd on error return;
- * call open_packed_git() instead.
- */
-static int open_packed_git_1(struct packed_git *p)
-{
-	struct stat st;
-	struct pack_header hdr;
-	unsigned char sha1[20];
-	unsigned char *idx_sha1;
-	long fd_flag;
-
-	if (!p->index_data && open_pack_index(p))
-		return error("packfile %s index unavailable", p->pack_name);
-
-	if (!pack_max_fds) {
-		unsigned int max_fds = get_max_fd_limit();
-
-		/* Save 3 for stdin/stdout/stderr, 22 for work */
-		if (25 < max_fds)
-			pack_max_fds = max_fds - 25;
-		else
-			pack_max_fds = 1;
-	}
-
-	while (pack_max_fds <= pack_open_fds && close_one_pack())
-		; /* nothing */
-
-	p->pack_fd = git_open(p->pack_name);
-	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
-		return -1;
-	pack_open_fds++;
-
-	/* If we created the struct before we had the pack we lack size. */
-	if (!p->pack_size) {
-		if (!S_ISREG(st.st_mode))
-			return error("packfile %s not a regular file", p->pack_name);
-		p->pack_size = st.st_size;
-	} else if (p->pack_size != st.st_size)
-		return error("packfile %s size changed", p->pack_name);
-
-	/* We leave these file descriptors open with sliding mmap;
-	 * there is no point keeping them open across exec(), though.
-	 */
-	fd_flag = fcntl(p->pack_fd, F_GETFD, 0);
-	if (fd_flag < 0)
-		return error("cannot determine file descriptor flags");
-	fd_flag |= FD_CLOEXEC;
-	if (fcntl(p->pack_fd, F_SETFD, fd_flag) == -1)
-		return error("cannot set FD_CLOEXEC");
-
-	/* Verify we recognize this pack file format. */
-	if (read_in_full(p->pack_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
-		return error("file %s is far too short to be a packfile", p->pack_name);
-	if (hdr.hdr_signature != htonl(PACK_SIGNATURE))
-		return error("file %s is not a GIT packfile", p->pack_name);
-	if (!pack_version_ok(hdr.hdr_version))
-		return error("packfile %s is version %"PRIu32" and not"
-			" supported (try upgrading GIT to a newer version)",
-			p->pack_name, ntohl(hdr.hdr_version));
-
-	/* Verify the pack matches its index. */
-	if (p->num_objects != ntohl(hdr.hdr_entries))
-		return error("packfile %s claims to have %"PRIu32" objects"
-			     " while index indicates %"PRIu32" objects",
-			     p->pack_name, ntohl(hdr.hdr_entries),
-			     p->num_objects);
-	if (lseek(p->pack_fd, p->pack_size - sizeof(sha1), SEEK_SET) == -1)
-		return error("end of packfile %s is unavailable", p->pack_name);
-	if (read_in_full(p->pack_fd, sha1, sizeof(sha1)) != sizeof(sha1))
-		return error("packfile %s signature is unavailable", p->pack_name);
-	idx_sha1 = ((unsigned char *)p->index_data) + p->index_size - 40;
-	if (hashcmp(sha1, idx_sha1))
-		return error("packfile %s does not match index", p->pack_name);
-	return 0;
-}
-
-static int open_packed_git(struct packed_git *p)
-{
-	if (!open_packed_git_1(p))
-		return 0;
-	close_pack_fd(p);
-	return -1;
-}
-
-static int in_window(struct pack_window *win, off_t offset)
-{
-	/* We must promise at least 20 bytes (one hash) after the
-	 * offset is available from this window, otherwise the offset
-	 * is not actually in this window and a different window (which
-	 * has that one hash excess) must be used.  This is to support
-	 * the object header and delta base parsing routines below.
-	 */
-	off_t win_off = win->offset;
-	return win_off <= offset
-		&& (offset + 20) <= (win_off + win->len);
-}
-
-unsigned char *use_pack(struct packed_git *p,
-		struct pack_window **w_cursor,
-		off_t offset,
-		size_t *left)
-{
-	struct pack_window *win = *w_cursor;
-
-	/* Since packfiles end in a hash of their content and it's
-	 * pointless to ask for an offset into the middle of that
-	 * hash, and the in_window function above wouldn't match
-	 * don't allow an offset too close to the end of the file.
-	 */
-	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
-		die("packfile %s cannot be accessed", p->pack_name);
-	if (offset > (p->pack_size - 20))
-		die("offset beyond end of packfile (truncated pack?)");
-	if (offset < 0)
-		die(_("offset before end of packfile (broken .idx?)"));
-
-	if (!win || !in_window(win, offset)) {
-		if (win)
-			win->inuse_cnt--;
-		for (win = p->windows; win; win = win->next) {
-			if (in_window(win, offset))
-				break;
-		}
-		if (!win) {
-			size_t window_align = packed_git_window_size / 2;
-			off_t len;
-
-			if (p->pack_fd == -1 && open_packed_git(p))
-				die("packfile %s cannot be accessed", p->pack_name);
-
-			win = xcalloc(1, sizeof(*win));
-			win->offset = (offset / window_align) * window_align;
-			len = p->pack_size - win->offset;
-			if (len > packed_git_window_size)
-				len = packed_git_window_size;
-			win->len = (size_t)len;
-			pack_mapped += win->len;
-			while (packed_git_limit < pack_mapped
-				&& unuse_one_window(p))
-				; /* nothing */
-			win->base = xmmap(NULL, win->len,
-				PROT_READ, MAP_PRIVATE,
-				p->pack_fd, win->offset);
-			if (win->base == MAP_FAILED)
-				die_errno("packfile %s cannot be mapped",
-					  p->pack_name);
-			if (!win->offset && win->len == p->pack_size
-				&& !p->do_not_close)
-				close_pack_fd(p);
-			pack_mmap_calls++;
-			pack_open_windows++;
-			if (pack_mapped > peak_pack_mapped)
-				peak_pack_mapped = pack_mapped;
-			if (pack_open_windows > peak_pack_open_windows)
-				peak_pack_open_windows = pack_open_windows;
-			win->next = p->windows;
-			p->windows = win;
-		}
-	}
-	if (win != *w_cursor) {
-		win->last_used = pack_used_ctr++;
-		win->inuse_cnt++;
-		*w_cursor = win;
-	}
-	offset -= win->offset;
-	if (left)
-		*left = win->len - xsize_t(offset);
-	return win->base + offset;
-}
-
 static struct packed_git *alloc_packed_git(int extra)
 {
 	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
diff --git a/streaming.c b/streaming.c
index 9afa66b8b..6f1c60f12 100644
--- a/streaming.c
+++ b/streaming.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "streaming.h"
+#include "packfile.h"
 
 enum input_source {
 	stream_error = -1,
-- 
2.14.1.480.gb18f417b89-goog

