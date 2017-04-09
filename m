Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA001FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 19:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdDITLO (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 15:11:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35111 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbdDITLM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 15:11:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id d79so6334719wmi.2
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ue/OBLOLhU+Ql8ptMYL5N+spKISEOpUm9WoFMrL11r4=;
        b=oF7JEV0UNAzymwD+h3+YPD32strXNfVlLekKziaUyY9LkfPl7+atIbHxybC5VGAXIW
         nxbs6aVVnFySdqEpawx49jsVeXqSGUMd79WsxxTf9yPwtfrUAsU1X9SWlv83Am9mwxvS
         NRv5LgTdBfXeLLFhHMu4q+NE0OiWQsfXJVwRSWtrm0xKkdFDaJXDn8wGZCQ3b0S6aGHK
         SAOv+4gcGuyf8Ye7un302FejD8Pz+C0HviDnzbICXlCPUchOqNWb0Tw2Jax3w3szzG6M
         a/A4RhoReJO7QY99dcV8/DVs+tPgsv3WD5l2cVr/0ty/zCddbTB3buNO2mEIOnK/A6KR
         PPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ue/OBLOLhU+Ql8ptMYL5N+spKISEOpUm9WoFMrL11r4=;
        b=tR30hTr6oIVTC0Ozu8GCPeM+M/Wm4bI+UY5Ra1m5jrhzXWq8i0lmush8lDoAI3H/2b
         9fx8hLTkezpk6SOJNNsbZbpHzgXvbvJJ6vJyfgsOVcAc2uaJJ0zvYp21rtXR2vbjN3NJ
         t5+0USS7vQzNHRJqDrc1jifyL+PlmQuvtcdXu+sMphcTyv56Jr2nMvkSjurtrdaZElt6
         pkWz+Cdfz/Q1IlkaEvj8QUZkltgcE8tUCwouVMgjE6gatNT5Z1Oj36Fu5SSBGecd5J10
         yOWthj1pr8StFPvqr9ksQcXDnEcWNsUJX9YxwlqTQxxSsfDJvT3DDxfP2JlIUReSjQ0/
         oRMQ==
X-Gm-Message-State: AN3rC/7kWK1WOKC87MU672HUchjubzs7f8KAXaK5dEosXuPg73UZ6GC1
        AUgsDDb5m3ThHw==
X-Received: by 10.28.91.1 with SMTP id p1mr7273849wmb.63.1491765069726;
        Sun, 09 Apr 2017 12:11:09 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB5F77.dip0.t-ipconnect.de. [93.219.95.119])
        by smtp.gmail.com with ESMTPSA id k13sm7319675wmi.28.2017.04.09.12.11.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 09 Apr 2017 12:11:08 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com
Subject: [PATCH v3 0/4] convert: add "status=delayed" to filter process protocol
Date:   Sun,  9 Apr 2017 21:11:03 +0200
Message-Id: <20170409191107.20547-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

in v3 "delay filter" became a series. Patch 1 to 3 are minor t0021 test
adjustments and patch 4 is the actual change.

Most significant change since v2:
If the filter delays a blob, then Git send the filter a "delay-id". Git uses
this "delay-id" as index in an array of delayed "cached entries". When Git
requests a previously delayed blob then it will only send the "delay-id"
to identify the blob. The actual blob content will not be send to the filter,
again.

If you review this series then please read the "Delay" section in
"Documentation/gitattributes.txt" first for an overview of the delay mechanism.
The changes in "t/t0021/rot13-filter.pl" are easier to review if you ignore
whitespace changes.

Thanks,
Lars

RFC: http://public-inbox.org/git/D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com/
v1: http://public-inbox.org/git/20170108191736.47359-1-larsxschneider@gmail.com/
v2: http://public-inbox.org/git/20170226184816.30010-1-larsxschneider@gmail.com/


Base Ref: v2.12.0
Web-Diff: https://github.com/larsxschneider/git/commit/08a461f103
Checkout: git fetch https://github.com/larsxschneider/git filter-process/delay-v3 && git checkout 08a461f103


Interdiff (v2..v3):

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index f6bad8db40..329baa945f 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -425,8 +425,8 @@ packet:          git< capability=clean
 packet:          git< capability=smudge
 packet:          git< 0000
 ------------------------
-Supported filter capabilities in version 2 are "clean" and
-"smudge".
+Supported filter capabilities in version 2 are "clean", "smudge",
+and "delay".

 Afterwards Git sends a list of "key=value" pairs terminated with
 a flush packet. The list will contain at least the filter command
@@ -473,15 +473,6 @@ packet:          git< 0000  # empty content!
 packet:          git< 0000  # empty list, keep "status=success" unchanged!
 ------------------------

-If the request cannot be fulfilled within a reasonable amount of time
-then the filter can respond with a "delayed" status and a flush packet.
-Git will perform the same request at a later point in time, again. The
-filter can delay a response multiple times for a single request.
-------------------------
-packet:          git< status=delayed
-packet:          git< 0000
-------------------------
-
 In case the filter cannot or does not want to process the content,
 it is expected to respond with an "error" status.
 ------------------------
@@ -521,12 +512,77 @@ the protocol then Git will stop the filter process and restart it
 with the next file that needs to be processed. Depending on the
 `filter.<driver>.required` flag Git will interpret that as error.

-After the filter has processed a blob it is expected to wait for
-the next "key=value" list containing a command. Git will close
+After the filter has processed a command it is expected to wait for
+a "key=value" list containing the next command. Git will close
 the command pipe on exit. The filter is expected to detect EOF
 and exit gracefully on its own. Git will wait until the filter
 process has stopped.

+Delay
+^^^^^
+
+If the filter supports the "delay" capability, then Git can send the
+flag "delay-able" after the filter command and pathname. This flag
+denotes that the filter can delay filtering the current blob (e.g. to
+compensate network latencies) by responding with no content but with
+the status "delayed" and a flush packet. Git will answer with a
+"delay-id", a number that identifies the blob, and a flush packet. The
+filter acknowledges this number with a "success" status and a flush
+packet.
+------------------------
+packet:          git> command=smudge
+packet:          git> pathname=path/testfile.dat
+packet:          git> delay-able=1
+packet:          git> 0000
+packet:          git> CONTENT
+packet:          git> 0000
+packet:          git< status=delayed
+packet:          git< 0000
+packet:          git> delay-id=1
+packet:          git> 0000
+packet:          git< status=success
+packet:          git< 0000
+------------------------
+
+If the filter supports the "delay" capability then it must support the
+"list_available_blobs" command. If Git sends this command, then the
+filter is expected to return a list of "delay_ids" of blobs that are
+available. The list must be terminated with a flush packet followed
+by a "success" status that is also terminated with a flush packet. If
+no blobs for the delayed paths are available, yet, then the filter is
+expected to block the response until at least one blob becomes
+available. The filter can tell Git that it has no more delayed blobs
+by sending an empty list.
+------------------------
+packet:          git> command=list_available_blobs
+packet:          git> 0000
+packet:          git< 7
+packet:          git< 13
+packet:          git< 0000
+packet:          git< status=success
+packet:          git< 0000
+------------------------
+
+After Git received the "delay_ids", it will request the corresponding
+blobs again. These requests contain a "delay-id" and an empty content
+section. The filter is expected to respond with the smudged content
+in the usual way as explained above.
+------------------------
+packet:          git> command=smudge
+packet:          git> pathname=test-delay10.a
+packet:          git> delay-id=0
+packet:          git> 0000
+packet:          git> 0000  # empty content!
+packet:          git< status=success
+packet:          git< 0000
+packet:          git< SMUDGED_CONTENT
+packet:          git< 0000
+packet:          git< 0000
+------------------------
+
+Example
+^^^^^^^
+
 A long running filter demo implementation can be found in
 `contrib/long-running-filter/example.pl` located in the Git
 core repository. If you develop your own long running filter
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 742e8742cd..e0a0bc92d4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -355,6 +355,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 	state.force = 1;
 	state.refresh_cache = 1;
 	state.istate = &the_index;
+
+	enable_delayed_checkout(&state);
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -369,7 +371,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
-	errs |= checkout_delayed_entries(&state);
+	errs |= finish_delayed_checkout(&state);

 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
diff --git a/cache.h b/cache.h
index 66dde99a79..46076279cf 100644
--- a/cache.h
+++ b/cache.h
@@ -1421,20 +1421,54 @@ const char *show_ident_date(const struct ident_split *id,
  */
 extern int ident_cmp(const struct ident_split *, const struct ident_split *);

+enum ce_delay_state {
+	CE_DELAY_DISABLED = 0,
+	CE_DELAY_AVAILABLE = 1,
+	CE_DELAY_APPLIED = 2,
+	CE_DELAY_RETRY = 3
+};
+
+struct delayed_checkout {
+	enum ce_delay_state state;
+	/* The value of "delay_id" has different meaning depending on the
+	 * "state" variable:
+	 *   - CE_DELAY_DISABLED  => "delay_id" not used.
+	 *   - CE_DELAY_AVAILABLE => "delay_id" is available to be presented
+	 *                           to the filter in case the filter wants to
+	 *                           delay the response of a blob.
+	 *   - CE_DELAY_APPLIED   => "delay_id" was presented to and applied by
+	 *                           the filter for a blob. The corresponding
+	 *                           cache entry in stored in the "entries"
+	 *                           array under the index "delay_id".
+	 *   - CE_DELAY_RETRY     => Git requests a blob from the filter that
+	 *                           was previously delayed using the "delay_id".
+	 */
+	int delay_id;
+	/* List of filter drivers that have delayed blobs. */
+	struct string_list filters;
+	/* Array of cache entries that have been delayed. */
+	struct cache_entry **entries;
+	int entries_nr;
+	int entries_alloc;
+};
+
 struct checkout {
 	struct index_state *istate;
 	const char *base_dir;
+	struct delayed_checkout *delayed_checkout;
 	int base_dir_len;
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
 		 refresh_cache:1;
 };
-#define CHECKOUT_INIT { NULL, "" }
+#define CHECKOUT_INIT { NULL, "", NULL }
+

 #define TEMPORARY_FILENAME_LENGTH 25
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
-extern int checkout_delayed_entries(const struct checkout *state);
+extern void enable_delayed_checkout(struct checkout *state);
+extern int finish_delayed_checkout(struct checkout *state);

 struct cache_def {
 	struct strbuf path;
diff --git a/convert.c b/convert.c
index 24d29f5c53..0d8fa0f833 100644
--- a/convert.c
+++ b/convert.c
@@ -4,7 +4,6 @@
 #include "quote.h"
 #include "sigchain.h"
 #include "pkt-line.h"
-#include "list.h"

 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -39,13 +38,6 @@ struct text_stat {
 	unsigned printable, nonprintable;
 };

-static LIST_HEAD(delayed_item_queue_head);
-
-struct delayed_item {
-	void* item;
-	struct list_head node;
-};
-
 static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
 {
 	unsigned long i;
@@ -503,6 +495,7 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le

 #define CAP_CLEAN    (1u<<0)
 #define CAP_SMUDGE   (1u<<1)
+#define CAP_DELAY    (1u<<2)

 struct cmd2process {
 	struct hashmap_entry ent; /* must be the first member! */
@@ -640,7 +633,8 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	if (err)
 		goto done;

-	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);
+	err = packet_write_list(process->in,
+		"capability=clean", "capability=smudge", "capability=delay", NULL);

 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
@@ -656,6 +650,8 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 			entry->supported_capabilities |= CAP_CLEAN;
 		} else if (!strcmp(cap_name, "smudge")) {
 			entry->supported_capabilities |= CAP_SMUDGE;
+		} else if (!strcmp(cap_name, "delay")) {
+			entry->supported_capabilities |= CAP_DELAY;
 		} else {
 			warning(
 				"external filter '%s' requested unsupported filter capability '%s'",
@@ -680,10 +676,12 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 }

 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
-				   int fd, struct strbuf *dst, int *delayed, const char *cmd,
-				   const unsigned int wanted_capability)
+				   int fd, struct strbuf *dst, const char *cmd,
+				   const unsigned int wanted_capability,
+				   struct delayed_checkout *dco)
 {
 	int err;
+	int is_delay_available = 0;
 	struct cmd2process *entry;
 	struct child_process *process;
 	struct strbuf nbuf = STRBUF_INIT;
@@ -734,6 +732,24 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;

+	if (CAP_DELAY & entry->supported_capabilities && dco) {
+		switch (dco->state) {
+		case CE_DELAY_AVAILABLE:
+			is_delay_available = 1;
+			err = packet_write_fmt_gently(
+				process->in, "delay-able=1\n");
+			break;
+		case CE_DELAY_RETRY:
+			err = packet_write_fmt_gently(
+				process->in, "delay-id=%i\n", dco->delay_id);
+			break;
+		default:
+			break;
+		}
+		if (err)
+			goto done;
+	}
+
 	err = packet_flush_gently(process->in);
 	if (err)
 		goto done;
@@ -746,18 +762,27 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 		goto done;

 	read_multi_file_filter_status(process->out, &filter_status);
-	if (delayed && !strcmp(filter_status.buf, "delayed")) {
-		*delayed = 1;
+	if (is_delay_available && !strcmp(filter_status.buf, "delayed")) {
+		/* The filter wants to delay the response. Send it a delay id. */
+		err = packet_write_fmt_gently(
+			process->in, "delay-id=%i\n", dco->delay_id);
+		if (err)
 			goto done;
+		err = packet_flush_gently(process->in);
+		if (err)
+			goto done;
+		string_list_insert(&dco->filters, cmd);
+		dco->state = CE_DELAY_APPLIED;
 	} else {
+		/* The filter got the blob and wants to send us a response. */
 		err = strcmp(filter_status.buf, "success");
 		if (err)
 			goto done;
-	}

 		err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
 		if (err)
 			goto done;
+	}

 	read_multi_file_filter_status(process->out, &filter_status);
 	err = strcmp(filter_status.buf, "success");
@@ -790,6 +815,74 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	return !err;
 }

+
+int async_query_available_blobs(const char *cmd, unsigned long **delay_ids,
+				int *delay_ids_nr)
+{
+	int err;
+	char *line;
+	char *end;
+	struct cmd2process *entry;
+	struct child_process *process;
+	struct strbuf filter_status = STRBUF_INIT;
+	unsigned long delay_id;
+	int delay_ids_alloc = 0;
+	*delay_ids_nr = 0;
+
+	entry = find_multi_file_filter_entry(&cmd_process_map, cmd);
+	if (!entry) {
+		error("external filter '%s' is not available anymore although "
+		      "not all paths have been filtered", cmd);
+		return 0;
+	}
+	process = &entry->process;
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	err = packet_write_fmt_gently(
+		process->in, "command=list_available_blobs\n");
+	if (err)
+		goto done;
+
+	err = packet_flush_gently(process->in);
+	if (err)
+		goto done;
+
+	for (;;) {
+		line = packet_read_line(process->out, NULL);
+		if (!line)
+			break;
+		delay_id = strtoul(line, &end, 10);
+		err = (line == end);
+		if (err) {
+			error("invalid delay id '%s'", line);
+			goto done;
+		}
+		ALLOC_GROW(*delay_ids, *delay_ids_nr+1, delay_ids_alloc);
+		(*delay_ids)[(*delay_ids_nr)++] = delay_id;
+	}
+
+	read_multi_file_filter_status(process->out, &filter_status);
+	err = strcmp(filter_status.buf, "success");
+
+done:
+	sigchain_pop(SIGPIPE);
+
+	if (err || errno == EPIPE) {
+		if (!strcmp(filter_status.buf, "error")) {
+			/* The filter signaled a problem with the file. */
+		} else {
+			/*
+			 * Something went wrong with the protocol filter.
+			 * Force shutdown and restart if another blob requires
+			 * filtering.
+			 */
+			error("external filter '%s' failed", cmd);
+			kill_multi_file_filter(&cmd_process_map, entry);
+		}
+	}
+	return !err;
+}
+
 static struct convert_driver {
 	const char *name;
 	struct convert_driver *next;
@@ -800,8 +893,9 @@ static struct convert_driver {
 } *user_convert, **user_convert_tail;

 static int apply_filter(const char *path, const char *src, size_t len,
-			int fd, struct strbuf *dst, int *delayed,
-			struct convert_driver *drv, const unsigned int wanted_capability)
+			int fd, struct strbuf *dst, struct convert_driver *drv,
+			const unsigned int wanted_capability,
+			struct delayed_checkout *dco)
 {
 	const char *cmd = NULL;

@@ -819,7 +913,8 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (cmd && *cmd)
 		return apply_single_file_filter(path, src, len, fd, dst, cmd);
 	else if (drv->process && *drv->process)
-		return apply_multi_file_filter(path, src, len, fd, dst, delayed, drv->process, wanted_capability);
+		return apply_multi_file_filter(path, src, len, fd, dst,
+			drv->process, wanted_capability, dco);

 	return 0;
 }
@@ -1165,7 +1260,7 @@ int would_convert_to_git_filter_fd(const char *path)
 	if (!ca.drv->required)
 		return 0;

-	return apply_filter(path, NULL, 0, -1, NULL, NULL, ca.drv, CAP_CLEAN);
+	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN, NULL);
 }

 const char *get_convert_attr_ascii(const char *path)
@@ -1202,7 +1297,7 @@ int convert_to_git(const char *path, const char *src, size_t len,

 	convert_attrs(&ca, path);

-	ret |= apply_filter(path, src, len, -1, dst, NULL, ca.drv, CAP_CLEAN);
+	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN, NULL);
 	if (!ret && ca.drv && ca.drv->required)
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

@@ -1227,7 +1322,7 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 	assert(ca.drv);
 	assert(ca.drv->clean || ca.drv->process);

-	if (!apply_filter(path, NULL, 0, fd, dst, NULL, ca.drv, CAP_CLEAN))
+	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
 		die("%s: clean filter '%s' failed", path, ca.drv->name);

 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
@@ -1235,8 +1330,8 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
 }

 static int convert_to_working_tree_internal(const char *path, const char *src,
-					    size_t len, struct strbuf *dst, int *delayed,
-					    int normalizing)
+					    size_t len, struct strbuf *dst,
+					    int normalizing, struct delayed_checkout *dco)
 {
 	int ret = 0, ret_filter = 0;
 	struct conv_attrs ca;
@@ -1261,7 +1356,8 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 		}
 	}

-	ret_filter = apply_filter(path, src, len, -1, dst, delayed, ca.drv, CAP_SMUDGE);
+	ret_filter = apply_filter(
+		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
 		die("%s: smudge filter %s failed", path, ca.drv->name);

@@ -1269,42 +1365,20 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 }

 int async_convert_to_working_tree(const char *path, const char *src,
-								  size_t len, struct strbuf *dst, void *item)
+				  size_t len, struct strbuf *dst,
+				  void *dco)
 {
-	int delayed = 0;
-	struct delayed_item *delayed_item;
-	if (convert_to_working_tree_internal(path, src, len, dst, &delayed, 0)) {
-		if (delayed) {
-			delayed_item = xmalloc(sizeof(*delayed_item));
-			delayed_item->item = item;
-			list_add_tail(&delayed_item->node, &delayed_item_queue_head);
-			return ASYNC_FILTER_DELAYED;
-		}
-		return ASYNC_FILTER_SUCCESS;
-	}
-	return ASYNC_FILTER_FAIL;
-}
-
-void* async_filter_finish(void)
-{
-	struct delayed_item *head;
-	if (!list_empty(&delayed_item_queue_head)) {
-		head = list_first_entry(&delayed_item_queue_head,
-			struct delayed_item, node);
-		list_del(&head->node);
-		return head->item;
-	}
-	return NULL;
+	return convert_to_working_tree_internal(path, src, len, dst, 0, dco);
 }

 int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	return convert_to_working_tree_internal(path, src, len, dst, NULL, 0);
+	return convert_to_working_tree_internal(path, src, len, dst, 0, NULL);
 }

 int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(path, src, len, dst, NULL, 1);
+	int ret = convert_to_working_tree_internal(path, src, len, dst, 1, NULL);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/convert.h b/convert.h
index acc016de9f..da6c702090 100644
--- a/convert.h
+++ b/convert.h
@@ -4,15 +4,6 @@
 #ifndef CONVERT_H
 #define CONVERT_H

-enum async_filter {
-	ASYNC_FILTER_SUCCESS = 0,
-	ASYNC_FILTER_FAIL = 1,
-	ASYNC_FILTER_DELAYED = 2
-};
-
-extern enum async_filter async_filter;
-
-
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
@@ -53,8 +44,9 @@ extern int convert_to_working_tree(const char *path, const char *src,
 				   size_t len, struct strbuf *dst);
 extern int async_convert_to_working_tree(const char *path, const char *src,
 					 size_t len, struct strbuf *dst,
-					 void *item);
-extern void* async_filter_finish(void);
+					 void *dco);
+extern int async_query_available_blobs(const char *cmd, unsigned long **delay_ids,
+				       int *delay_ids_nr);
 extern int renormalize_buffer(const char *path, const char *src, size_t len,
 			      struct strbuf *dst);
 static inline int would_convert_to_git(const char *path)
diff --git a/entry.c b/entry.c
index d15e69a55e..963e94dee8 100644
--- a/entry.c
+++ b/entry.c
@@ -136,6 +136,86 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 	return result;
 }

+void enable_delayed_checkout(struct checkout *state)
+{
+	if (!state->delayed_checkout) {
+		state->delayed_checkout = xmalloc(sizeof(*state->delayed_checkout));
+		state->delayed_checkout->entries_nr = 0;
+		state->delayed_checkout->entries_alloc = 0;
+		state->delayed_checkout->delay_id = -1;
+		state->delayed_checkout->state = CE_DELAY_AVAILABLE;
+		ALLOC_ARRAY(state->delayed_checkout->entries, 0);
+		string_list_init(&state->delayed_checkout->filters, 0);
+	}
+}
+
+int finish_delayed_checkout(struct checkout *state)
+{
+	int errs = 0;
+	struct string_list_item *filter;
+	struct delayed_checkout *dco = state->delayed_checkout;
+
+	if (!state->delayed_checkout) {
+		return errs;
+	}
+
+	while (dco->entries_nr > 0 && dco->filters.nr > 0) {
+		for_each_string_list_item(filter, &dco->filters) {
+			int i;
+			int delay_ids_nr;
+			unsigned long *delay_ids;
+			ALLOC_ARRAY(delay_ids, 0);
+			if (!async_query_available_blobs(
+				filter->string, &delay_ids, &delay_ids_nr)) {
+				/* Filter reported an error */
+				errs = 1;
+				filter->string = "";
+				free(delay_ids);
+				continue;
+			}
+			if (delay_ids_nr <= 0) {
+				/* Filter responded with no entries. That means
+				   the filter is done and we can remove the
+				   filter from the list
+				   (see "string_list_remove_empty_items" call
+				   below).
+				*/
+				filter->string = "";
+				free(delay_ids);
+				continue;
+			}
+			for (i = 0; i < delay_ids_nr; i++) {
+				struct cache_entry* ce;
+				unsigned long delay_id = delay_ids[i];
+				assert(delay_id >= 0 && delay_id < dco->entries_nr);
+				ce = dco->entries[delay_id];
+				dco->entries[delay_id] = NULL;
+				dco->delay_id = delay_id;
+				dco->state = CE_DELAY_RETRY;
+				/* Shrink entries array as much as possible */
+				while (
+					dco->entries_nr > 0 &&
+					delay_id == dco->entries_nr - 1 &&
+					!dco->entries[i]
+				) {
+					delay_id--;
+					dco->entries_nr--;
+				}
+				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
+			}
+			free(delay_ids);
+		}
+		string_list_remove_empty_items(&dco->filters, 0);
+	}
+
+	string_list_clear(&dco->filters, 0);
+	free(dco->entries);
+	free(dco);
+	state->delayed_checkout = NULL;
+
+	return errs;
+}
+
 static int write_entry(struct cache_entry *ce,
 		       char *path, const struct checkout *state, int to_tempfile)
 {
@@ -178,16 +258,44 @@ static int write_entry(struct cache_entry *ce,
 		 * Convert from git internal format to working tree format
 		 */
 		if (ce_mode_s_ifmt == S_IFREG) {
-			ret = async_convert_to_working_tree(ce->name, new, size, &buf, ce);
-			if (ret == ASYNC_FILTER_SUCCESS) {
-				free(new);
-				new = strbuf_detach(&buf, &newsize);
-				size = newsize;
+			struct delayed_checkout *dco = state->delayed_checkout;
+			if (dco && dco->state != CE_DELAY_DISABLED) {
+				switch (dco->state) {
+				case CE_DELAY_AVAILABLE:
+					dco->delay_id = dco->entries_nr; break;
+				case CE_DELAY_RETRY:
+					new = NULL; size = 0; break;
+				default: break;
 				}
-			else if (ret == ASYNC_FILTER_DELAYED) {
+				assert(dco->delay_id >= 0);
+				ret = async_convert_to_working_tree(
+					ce->name, new, size, &buf, dco);
+				if (ret && dco->state == CE_DELAY_APPLIED) {
+					assert(dco->delay_id == dco->entries_nr);
 					free(new);
+					dco->entries_nr++;
+					ALLOC_GROW(
+						dco->entries, dco->entries_nr,
+						dco->entries_alloc);
+					dco->entries[dco->delay_id] = ce;
+					dco->state = CE_DELAY_AVAILABLE;
+					dco->delay_id = -1;
 					goto finish;
 				}
+			} else
+				ret = convert_to_working_tree(
+					ce->name, new, size, &buf);
+
+			if (ret) {
+				free(new);
+				new = strbuf_detach(&buf, &newsize);
+				size = newsize;
+			}
+			/*
+			 * No "else" here as errors from convert are OK at this
+			 * point. If the error would have been fatal (e.g.
+			 * filter is required), then we would have died already.
+			 */
 		}

 		fd = open_output_fd(path, ce, to_tempfile);
@@ -297,16 +405,3 @@ int checkout_entry(struct cache_entry *ce,
 	create_directories(path.buf, path.len, state);
 	return write_entry(ce, path.buf, state, 0);
 }
-
-int checkout_delayed_entries(const struct checkout *state)
-{
-	struct cache_entry *ce;
-	int errs = 0;
-
-	while ((ce = async_filter_finish())) {
-		ce->ce_flags &= ~CE_UPDATE;
-		errs |= checkout_entry(ce, state, NULL);
-	}
-
-	return errs;
-}
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 8ae5b1a521..21d4cd9453 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -28,7 +28,7 @@ file_size () {
 }

 filter_git () {
-	rm -f rot13-filter.log &&
+	rm -f *.log &&
 	git "$@"
 }

@@ -42,10 +42,10 @@ test_cmp_count () {
 	for FILE in "$expect" "$actual"
 	do
 		sort "$FILE" | uniq -c |
-		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp" &&
-		mv "$FILE.tmp" "$FILE" || return
+		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp"
 	done &&
-	test_cmp "$expect" "$actual"
+	test_cmp "$expect.tmp" "$actual.tmp" &&
+	rm "$expect.tmp" "$actual.tmp"
 }

 # Compare two files but exclude all `clean` invocations because Git can
@@ -56,10 +56,10 @@ test_cmp_exclude_clean () {
 	actual=$2
 	for FILE in "$expect" "$actual"
 	do
-		grep -v "IN: clean" "$FILE" >"$FILE.tmp" &&
-		mv "$FILE.tmp" "$FILE"
+		grep -v "IN: clean" "$FILE" >"$FILE.tmp"
 	done &&
-	test_cmp "$expect" "$actual"
+	test_cmp "$expect.tmp" "$actual.tmp" &&
+	rm "$expect.tmp" "$actual.tmp"
 }

 # Check that the contents of two files are equal and that their rot13 version
@@ -342,7 +342,7 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
 '

 test_expect_success PERL 'required process filter should filter data' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -375,7 +375,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
-		test_cmp_count expected.log rot13-filter.log &&
+		test_cmp_count expected.log debug.log &&

 		git commit -m "test commit 2" &&
 		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&
@@ -388,7 +388,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&

 		filter_git checkout --quiet --no-progress empty-branch &&
 		cat >expected.log <<-EOF &&
@@ -397,7 +397,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: clean test.r $S [OK] -- OUT: $S . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&

 		filter_git checkout --quiet --no-progress master &&
 		cat >expected.log <<-EOF &&
@@ -409,7 +409,7 @@ test_expect_success PERL 'required process filter should filter data' '
 			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&

 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
 		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
@@ -419,7 +419,7 @@ test_expect_success PERL 'required process filter should filter data' '

 test_expect_success PERL 'required process filter takes precedence' '
 	test_config_global filter.protocol.clean false &&
-	test_config_global filter.protocol.process "rot13-filter.pl clean" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -439,12 +439,12 @@ test_expect_success PERL 'required process filter takes precedence' '
 			IN: clean test.r $S [OK] -- OUT: $S . [OK]
 			STOP
 		EOF
-		test_cmp_count expected.log rot13-filter.log
+		test_cmp_count expected.log debug.log
 	)
 '

 test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -462,7 +462,7 @@ test_expect_success PERL 'required process filter should be used only for "clean
 			IN: clean test.r $S [OK] -- OUT: $S . [OK]
 			STOP
 		EOF
-		test_cmp_count expected.log rot13-filter.log &&
+		test_cmp_count expected.log debug.log &&

 		rm test.r &&

@@ -474,12 +474,12 @@ test_expect_success PERL 'required process filter should be used only for "clean
 			init handshake complete
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log
+		test_cmp_exclude_clean expected.log debug.log
 	)
 '

 test_expect_success PERL 'required process filter should process multiple packets' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&

 	rm -rf repo &&
@@ -514,7 +514,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 			IN: clean 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
 			STOP
 		EOF
-		test_cmp_count expected.log rot13-filter.log &&
+		test_cmp_count expected.log debug.log &&

 		rm -f *.file &&

@@ -529,7 +529,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 			IN: smudge 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&

 		for FILE in *.file
 		do
@@ -539,7 +539,7 @@ test_expect_success PERL 'required process filter should process multiple packet
 '

 test_expect_success PERL 'required process filter with clean error should fail' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
 	mkdir repo &&
@@ -558,7 +558,7 @@ test_expect_success PERL 'required process filter with clean error should fail'
 '

 test_expect_success PERL 'process filter should restart after unexpected write failure' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -579,7 +579,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		git add . &&
 		rm -f *.r &&

-		rm -f rot13-filter.log &&
+		rm -f debug.log &&
 		git checkout --quiet --no-progress . 2>git-stderr.log &&

 		grep "smudge write error at" git-stderr.log &&
@@ -588,14 +588,14 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge smudge-write-fail.r $SF [OK] -- OUT: $SF [WRITE FAIL]
+			IN: smudge smudge-write-fail.r $SF [OK] -- [WRITE FAIL]
 			START
 			init handshake complete
 			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
 			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&

 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
 		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
@@ -609,7 +609,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
 '

 test_expect_success PERL 'process filter should not be restarted if it signals an error' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -634,12 +634,12 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge error.r $SE [OK] -- OUT: 0 [ERROR]
+			IN: smudge error.r $SE [OK] -- [ERROR]
 			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
 			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&

 		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
 		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
@@ -648,7 +648,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
 '

 test_expect_success PERL 'process filter abort stops processing of all further files' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
+	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
 	rm -rf repo &&
 	mkdir repo &&
 	(
@@ -673,10 +673,10 @@ test_expect_success PERL 'process filter abort stops processing of all further f
 		cat >expected.log <<-EOF &&
 			START
 			init handshake complete
-			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
+			IN: smudge abort.r $SA [OK] -- [ABORT]
 			STOP
 		EOF
-		test_cmp_exclude_clean expected.log rot13-filter.log &&
+		test_cmp_exclude_clean expected.log debug.log &&

 		test_cmp "$TEST_ROOT/test.o" test.r &&
 		test_cmp "$TEST_ROOT/test2.o" test2.r &&
@@ -702,55 +702,75 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
 '

 test_expect_success PERL 'delayed checkout in process filter' '
-	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
-	test_config_global filter.protocol.required true &&
+	test_config_global filter.a.process "rot13-filter.pl a.log clean smudge delay" &&
+	test_config_global filter.a.required true &&
+	test_config_global filter.b.process "rot13-filter.pl b.log clean smudge delay" &&
+	test_config_global filter.b.required true &&
+
 	rm -rf repo &&
 	mkdir repo &&
 	(
 		cd repo &&
 		git init &&
-		echo "*.r filter=protocol" >.gitattributes &&
-		cp "$TEST_ROOT/test.o" test.r &&
-		cp "$TEST_ROOT/test.o" test-delay1.r &&
-		cp "$TEST_ROOT/test.o" test-delay3.r &&
+		echo "*.a filter=a" >.gitattributes &&
+		echo "*.b filter=b" >>.gitattributes &&
+		cp "$TEST_ROOT/test.o" test.a &&
+		cp "$TEST_ROOT/test.o" test-delay10.a &&
+		cp "$TEST_ROOT/test.o" test-delay11.a &&
+		cp "$TEST_ROOT/test.o" test-delay20.a &&
+		cp "$TEST_ROOT/test.o" test-delay10.b &&
 		git add . &&
 		git commit -m "test commit 1"
 	) &&

-	S=$(file_size repo/test.r) &&
-	rm -rf repo-cloned &&
-	filter_git clone repo repo-cloned &&
-	cat >expected.log <<-EOF &&
+	S=$(file_size "$TEST_ROOT/test.o") &&
+	cat >a.exp <<-EOF &&
 		START
 		init handshake complete
-		IN: smudge test.r $S [OK] -- OUT: $S . [OK]
-		IN: smudge test-delay1.r $S [OK] -- OUT: $S [DELAYED]
-		IN: smudge test-delay1.r $S [OK] -- OUT: $S . [OK]
-		IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
-		IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
-		IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
-		IN: smudge test-delay3.r $S [OK] -- OUT: $S . [OK]
+		IN: smudge test.a $S [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay10.a $S [OK] -- [DELAYED]
+		IN: smudge test-delay11.a $S [OK] -- [DELAYED]
+		IN: smudge test-delay20.a $S [OK] -- [DELAYED]
+		IN: list_available_blobs test-delay10.a test-delay11.a [OK]
+		IN: smudge test-delay10.a 0 [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay11.a 0 [OK] -- OUT: $S . [OK]
+		IN: list_available_blobs test-delay20.a [OK]
+		IN: smudge test-delay20.a 0 [OK] -- OUT: $S . [OK]
 		STOP
 	EOF
-	test_cmp_count expected.log repo-cloned/rot13-filter.log &&
-
-	(
-		cd repo-cloned &&
-		rm *.r rot13-filter.log &&
-		filter_git checkout . &&
-		cat >expected.log <<-EOF &&
+	cat >b.exp <<-EOF &&
 		START
 		init handshake complete
-			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
-			IN: smudge test-delay1.r $S [OK] -- OUT: $S [DELAYED]
-			IN: smudge test-delay1.r $S [OK] -- OUT: $S . [OK]
-			IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
-			IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
-			IN: smudge test-delay3.r $S [OK] -- OUT: $S [DELAYED]
-			IN: smudge test-delay3.r $S [OK] -- OUT: $S . [OK]
+		IN: smudge test-delay10.b $S [OK] -- [DELAYED]
+		IN: list_available_blobs test-delay10.b [OK]
+		IN: smudge test-delay10.b 0 [OK] -- OUT: $S . [OK]
+		IN: list_available_blobs [OK]
 		STOP
 	EOF
-		test_cmp_count expected.log rot13-filter.log
+
+	rm -rf repo-cloned &&
+	filter_git clone repo repo-cloned &&
+	test_cmp_count a.exp repo-cloned/a.log &&
+	test_cmp_count b.exp repo-cloned/b.log &&
+
+	(
+		cd repo-cloned &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay11.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay20.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.b &&
+
+		rm *.a *.b &&
+		filter_git checkout . &&
+		test_cmp_count ../a.exp a.log &&
+		test_cmp_count ../b.exp b.log &&
+
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay11.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay20.a &&
+		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test-delay10.b
 	)
 '

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index ece0d314b4..05024c6e1b 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -2,8 +2,9 @@
 # Example implementation for the Git filter protocol version 2
 # See Documentation/gitattributes.txt, section "Filter Protocol"
 #
-# The script takes the list of supported protocol capabilities as
-# arguments ("clean", "smudge", etc).
+# The first argument defines a debug log file that the script write to.
+# All remaining arguments define a list of supported protocol
+# capabilities ("clean", "smudge", etc).
 #
 # This implementation supports special test cases:
 # (1) If data with the pathname "clean-write-fail.r" is processed with
@@ -18,9 +19,10 @@
 #     to process the file and any file after that is processed with the
 #     same command.
 # (5) If data with a pathname that is a key in the DELAY hash is
-#     processed (e.g. 'test-delay1.r') then the filter signals n times
-#     to Git that the processing is delayed (n being the value of the
-#     DELAY hash key).
+#     requested (e.g. 'test-delay10.a') then the filter responds with
+#     a "delay" status and sets the "requested" field in the DELAY hash.
+#     The filter will signal the availability of this object after
+#     "count" (field in DELAY hash) "list_available_blobs" commands.
 #

 use strict;
@@ -28,15 +30,17 @@ use warnings;
 use IO::File;

 my $MAX_PACKET_CONTENT_SIZE = 65516;
+my $log_file                = shift @ARGV;
 my @capabilities            = @ARGV;
-my $DELAY3 = 3;
-my $DELAY1 = 1;

-my %DELAY;
-$DELAY{'test-delay1.r'} = 1;
-$DELAY{'test-delay3.r'} = 3;
+open my $debug, ">>", $log_file or die "cannot open log file: $!";

-open my $debug, ">>", "rot13-filter.log" or die "cannot open log file: $!";
+my %DELAY = (
+	'test-delay10.a' => { "requested" => 0, "count" => 1, "delay_id" => -1 },
+	'test-delay11.a' => { "requested" => 0, "count" => 1, "delay_id" => -1 },
+	'test-delay20.a' => { "requested" => 0, "count" => 2, "delay_id" => -1 },
+	'test-delay10.b' => { "requested" => 0, "count" => 1, "delay_id" => -1 },
+);

 sub rot13 {
 	my $str = shift;
@@ -74,7 +78,7 @@ sub packet_bin_read {

 sub packet_txt_read {
 	my ( $res, $buf ) = packet_bin_read();
-	unless ( $buf =~ s/\n$// ) {
+	unless ( $buf eq '' or $buf =~ s/\n$// ) {
 		die "A non-binary line MUST be terminated by an LF.";
 	}
 	return ( $res, $buf );
@@ -109,6 +113,7 @@ packet_flush();

 ( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
 ( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
+( packet_txt_read() eq ( 0, "capability=delay" ) )  || die "bad capability";
 ( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";

 foreach (@capabilities) {
@@ -123,6 +128,31 @@ while (1) {
 	print $debug "IN: $command";
 	$debug->flush();

+	if ( $command eq "list_available_blobs" ) {
+		# Flush
+		packet_bin_read();
+
+		foreach my $pathname (sort keys %DELAY) {
+			if ( $DELAY{$pathname}{"requested"} == 1 ) {
+
+				# die $pathname;
+				$DELAY{$pathname}{"count"} = $DELAY{$pathname}{"count"} - 1;
+				if ($DELAY{$pathname}{"count"} == 0 ) {
+					print $debug " $pathname";
+					# packet_txt_write($pathname);
+					packet_txt_write($DELAY{$pathname}{"delay_id"});
+				}
+			}
+		}
+
+		packet_flush();
+
+		print $debug " [OK]\n";
+		$debug->flush();
+		packet_txt_write("status=success");
+		packet_flush();
+	}
+	else {
 		my ($pathname) = packet_txt_read() =~ /^pathname=(.+)$/;
 		print $debug " $pathname";
 		$debug->flush();
@@ -131,8 +161,25 @@ while (1) {
 			die "bad pathname '$pathname'";
 		}

-	# Flush
-	packet_bin_read();
+		# Read until flush
+		my ( $done, $buffer ) = packet_txt_read();
+		while ( $buffer ne '' ) {
+			if ( $buffer eq "delay-able=1" ) {
+				if ( exists $DELAY{$pathname} and $DELAY{$pathname}{"requested"} == 0 ) {
+					$DELAY{$pathname}{"requested"} = 1;
+				}
+			}
+			elsif ( $buffer =~ m/^delay-id=/ ) {
+				my ($delay_id) = $buffer =~ /^delay-id=(.+)$/;
+				if ( $DELAY{$pathname}{"delay_id"} != $delay_id ) {
+					die "unexpected delay-id for '$pathname'";
+				}
+			} else {
+				die "Unknown message '$buffer'";
+			}
+
+			( $done, $buffer ) = packet_txt_read();
+		}

 		my $input = "";
 		{
@@ -148,7 +195,10 @@ while (1) {
 		}

 		my $output;
-	if ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
+		if ( exists $DELAY{$pathname} and exists $DELAY{$pathname}{"output"} ) {
+			$output = $DELAY{$pathname}{"output"}
+		}
+		elsif ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
 			$output = "";
 		}
 		elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
@@ -161,9 +211,6 @@ while (1) {
 			die "bad command '$command'";
 		}

-	print $debug "OUT: " . length($output) . " ";
-	$debug->flush();
-
 		if ( $pathname eq "error.r" ) {
 			print $debug "[ERROR]\n";
 			$debug->flush();
@@ -178,12 +225,28 @@ while (1) {
 		}
 		elsif ( $command eq "smudge" and
 			exists $DELAY{$pathname} and
-		    $DELAY{$pathname} > 0 ) {
-		$DELAY{$pathname} = $DELAY{$pathname} - 1;
+			$DELAY{$pathname}{"requested"} == 1 and
+			$DELAY{$pathname}{"delay_id"} < 0
+		) {
 			print $debug "[DELAYED]\n";
 			$debug->flush();
 			packet_txt_write("status=delayed");
 			packet_flush();
+			my ( $done, $buffer ) = packet_txt_read();
+			if ( $buffer =~ m/^delay-id=/ ) {
+				my ($delay_id) = $buffer =~ /^delay-id=(.+)$/;
+				if ( $delay_id eq "" ) {
+					die "bad delay_id '$delay_id'";
+				}
+				$DELAY{$pathname}{"delay_id"} = $delay_id;
+				$DELAY{$pathname}{"output"} = $output;
+			}
+
+			# Flush
+			packet_bin_read();
+
+			packet_txt_write("status=success");
+			packet_flush();
 		}
 		else {
 			packet_txt_write("status=success");
@@ -195,6 +258,9 @@ while (1) {
 				die "${command} write error";
 			}

+			print $debug "OUT: " . length($output) . " ";
+			$debug->flush();
+
 			while ( length($output) > 0 ) {
 				my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
 				packet_bin_write($packet);
@@ -213,3 +279,4 @@ while (1) {
 			packet_flush();
 		}
 	}
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index 6b3246db03..9f50a417ec 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -301,6 +301,7 @@ static int check_updates(struct unpack_trees_options *o)
 	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();

+	enable_delayed_checkout(&state);
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];

@@ -315,7 +316,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 	}
-	errs |= checkout_delayed_entries(&state);
+	errs |= finish_delayed_checkout(&state);
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);


Lars Schneider (4):
  t0021: keep filter log files on comparison
  t0021: make debug log file name configurable
  t0021: write "OUT" only on success
  convert: add "status=delayed" to filter process protocol

 Documentation/gitattributes.txt |  73 ++++++++++++-
 builtin/checkout.c              |   3 +
 cache.h                         |  37 ++++++-
 convert.c                       | 150 +++++++++++++++++++++++----
 convert.h                       |   5 +
 entry.c                         | 124 +++++++++++++++++++++-
 t/t0021-conversion.sh           | 135 ++++++++++++++++++------
 t/t0021/rot13-filter.pl         | 220 ++++++++++++++++++++++++++++------------
 unpack-trees.c                  |   2 +
 9 files changed, 624 insertions(+), 125 deletions(-)


base-commit: e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7
--
2.12.2

