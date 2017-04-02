Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FAE20966
	for <e@80x24.org>; Sun,  2 Apr 2017 19:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdDBTGx (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 15:06:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:62181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdDBTGw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 15:06:52 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Le64S-1cKdoT18m4-00ppuy; Sun, 02
 Apr 2017 21:06:49 +0200
Date:   Sun, 2 Apr 2017 21:06:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/8] Introduce a new "printf format" for timestamps
In-Reply-To: <cover.1491159939.git.johannes.schindelin@gmx.de>
Message-ID: <6a209fb5df18b4be1315314f0100ed8ca64c0e4c.1491159939.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <cover.1491159939.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:40yePW5o9VXdoS61L3Nq3fsU7oEj5H/txQw/LtDOMLTVTka/1fG
 nZfblNUZVMnTQi8ZP6Hctgd1pVdOEsaSwS24AqDU0mVo2X1jOiQ6vQ52njHINlaozQyNu7R
 7MB3O735hWQV0523jHGWDUiiQ18q9axa0RXnBZEPCDNduiSlHu4j5q46O72hrJOeTiME1YS
 XlGAFfdnNFPRpFPioKC8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kVo8dAatOrA=:QJv06RC7rO5AZzB2kuyruS
 2XtUUcNrgKQ+yjK5S4IBeCLrcllViaOauHErtVII/LAiWeKsgsYMzJEhD6ZFeND7q+Qkgb/2g
 tg/2XvHFXtRa5N9/LnSNkEbN3wQ/EaUd4OQ8Jsszw3rj9eBna7Aq3wIHSOyZumCs8auTOJmuE
 Usi/Eglk02v70y4tDoxo7LA+O4ZcMC5zUZCncdW5cesxLJggPHRqHohhGvrHByPkbXVSwIf3X
 T/ILLjNnVfFBVqJ7pZMbMLnimlN/1dJry5/xPoc0xCLruPN6ygDq288Oqpkc9KMUBxNrQlyHi
 QaxLqRBRPk0Y0+dOTYb5bMrcigjoXl0Bc41SIoILRiSQW4P5QIWah6QUU/LxeOzM1/FGORGKT
 3WaiuEq0Is8Uw9JDyNtV53l9fSuRQH+KjxnqyxT53Ogv+CpdAmzt5gbh8QT5VVqsl/peAzVXU
 DNUdf2acia2yA1Fcz8cc0jI9wK3GtimIQ8BEv/3y6tmsLyDgLP4pvetBeDcBxyvRy8i4kucOY
 Rk9zIkxOD0lYB4OikvQYFIO3U1VCW7QZ93aQcUZb6wUP/raVnVw7GndN1vmQEuck0Eqi2Cah0
 gtBEbTX1BZMHwzuc3s5cvULj8rPd0SdVqMZsoyvVUWu7xK9jPyc4JxZeJaf4QsJcYPVgXZIxk
 uHZx6e4vspIzhODeVUvCS9GmyQLxn5YOlmI6m8zoqmi9k0TazxRASiErg4H+zDJgnM/Wj/BPy
 j7e1IKIhuUdfpxAKndNS/a4wzN31qbYWIbniH2k81qJrle0sSdMakQ8KpwHcfRheTPSiICkMK
 Y1La4Gk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git's source code treats all timestamps as if they were
unsigned longs. Therefore, it is okay to write "%lu" when printing them.

There is a substantial problem with that, though: at least on Windows,
time_t is *larger* than unsigned long, and hence we will want to switch
away from the ill-specified `unsigned long` data type.

So let's introduce the pseudo format "PRItime" (currently simply being
defined to "lu") to make it easier to change the data type used for
timestamps.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/blame.c               |  6 +++---
 builtin/fsck.c                |  2 +-
 builtin/log.c                 |  2 +-
 builtin/receive-pack.c        |  4 ++--
 builtin/rev-list.c            |  2 +-
 builtin/rev-parse.c           |  3 ++-
 date.c                        | 26 +++++++++++++-------------
 fetch-pack.c                  |  2 +-
 git-compat-util.h             |  1 +
 refs/files-backend.c          |  2 +-
 t/helper/test-date.c          |  2 +-
 t/helper/test-parse-options.c |  2 +-
 upload-pack.c                 |  2 +-
 vcs-svn/fast_export.c         |  4 ++--
 14 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f7aa95f4bab..ff7b2df023b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1727,11 +1727,11 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 	get_commit_info(suspect->commit, &ci, 1);
 	printf("author %s\n", ci.author.buf);
 	printf("author-mail %s\n", ci.author_mail.buf);
-	printf("author-time %lu\n", ci.author_time);
+	printf("author-time %"PRItime"\n", ci.author_time);
 	printf("author-tz %s\n", ci.author_tz.buf);
 	printf("committer %s\n", ci.committer.buf);
 	printf("committer-mail %s\n", ci.committer_mail.buf);
-	printf("committer-time %lu\n", ci.committer_time);
+	printf("committer-time %"PRItime"\n", ci.committer_time);
 	printf("committer-tz %s\n", ci.committer_tz.buf);
 	printf("summary %s\n", ci.summary.buf);
 	if (suspect->commit->object.flags & UNINTERESTING)
@@ -1844,7 +1844,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 
 	strbuf_reset(&time_buf);
 	if (show_raw_time) {
-		strbuf_addf(&time_buf, "%lu %s", time, tz_str);
+		strbuf_addf(&time_buf, "%"PRItime" %s", time, tz_str);
 	}
 	else {
 		const char *time_str;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index f76e4163abb..af7b985c6eb 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -407,7 +407,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 			if (timestamp && name_objects)
 				add_decoration(fsck_walk_options.object_names,
 					obj,
-					xstrfmt("%s@{%ld}", refname, timestamp));
+					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
 			obj->used = 1;
 			mark_object_reachable(obj);
 		} else {
diff --git a/builtin/log.c b/builtin/log.c
index 670229cbb4c..079c659c754 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -903,7 +903,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 static void gen_message_id(struct rev_info *info, char *base)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addf(&buf, "%s.%lu.git.%s", base,
+	strbuf_addf(&buf, "%s.%"PRItime".git.%s", base,
 		    (unsigned long) time(NULL),
 		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE|IDENT_STRICT));
 	info->message_id = strbuf_detach(&buf, NULL);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fd8a24dd47e..8814e49893e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -459,12 +459,12 @@ static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
 
-	strbuf_addf(&buf, "%s:%lu", path, stamp);
+	strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
 	hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));;
 	strbuf_release(&buf);
 
 	/* RFC 2104 5. HMAC-SHA1-80 */
-	strbuf_addf(&buf, "%lu-%.*s", stamp, 20, sha1_to_hex(sha1));
+	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, 20, sha1_to_hex(sha1));
 	return strbuf_detach(&buf, NULL);
 }
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0aa93d58919..a30fbce3341 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -80,7 +80,7 @@ static void show_commit(struct commit *commit, void *data)
 	}
 
 	if (info->show_timestamp)
-		printf("%lu ", commit->date);
+		printf("%"PRItime" ", commit->date);
 	if (info->header_prefix)
 		fputs(info->header_prefix, stdout);
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 9e53a1a7ca4..f1c26ca6e62 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -218,7 +218,8 @@ static void show_datestring(const char *flag, const char *datestr)
 	/* date handling requires both flags and revs */
 	if ((filter & (DO_FLAGS | DO_REVS)) != (DO_FLAGS | DO_REVS))
 		return;
-	snprintf(buffer, sizeof(buffer), "%s%lu", flag, approxidate(datestr));
+	snprintf(buffer, sizeof(buffer), "%s%"PRItime,
+		 flag, approxidate(datestr));
 	show(buffer);
 }
 
diff --git a/date.c b/date.c
index 495c207c64f..5c33dfd8ee7 100644
--- a/date.c
+++ b/date.c
@@ -100,41 +100,41 @@ void show_date_relative(unsigned long time, int tz,
 	diff = now->tv_sec - time;
 	if (diff < 90) {
 		strbuf_addf(timebuf,
-			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
+			 Q_("%"PRItime" second ago", "%"PRItime" seconds ago", diff), diff);
 		return;
 	}
 	/* Turn it into minutes */
 	diff = (diff + 30) / 60;
 	if (diff < 90) {
 		strbuf_addf(timebuf,
-			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
+			 Q_("%"PRItime" minute ago", "%"PRItime" minutes ago", diff), diff);
 		return;
 	}
 	/* Turn it into hours */
 	diff = (diff + 30) / 60;
 	if (diff < 36) {
 		strbuf_addf(timebuf,
-			 Q_("%lu hour ago", "%lu hours ago", diff), diff);
+			 Q_("%"PRItime" hour ago", "%"PRItime" hours ago", diff), diff);
 		return;
 	}
 	/* We deal with number of days from here on */
 	diff = (diff + 12) / 24;
 	if (diff < 14) {
 		strbuf_addf(timebuf,
-			 Q_("%lu day ago", "%lu days ago", diff), diff);
+			 Q_("%"PRItime" day ago", "%"PRItime" days ago", diff), diff);
 		return;
 	}
 	/* Say weeks for the past 10 weeks or so */
 	if (diff < 70) {
 		strbuf_addf(timebuf,
-			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
+			 Q_("%"PRItime" week ago", "%"PRItime" weeks ago", (diff + 3) / 7),
 			 (diff + 3) / 7);
 		return;
 	}
 	/* Say months for the past 12 months or so */
 	if (diff < 365) {
 		strbuf_addf(timebuf,
-			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
+			 Q_("%"PRItime" month ago", "%"PRItime" months ago", (diff + 15) / 30),
 			 (diff + 15) / 30);
 		return;
 	}
@@ -145,20 +145,20 @@ void show_date_relative(unsigned long time, int tz,
 		unsigned long months = totalmonths % 12;
 		if (months) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
+			strbuf_addf(&sb, Q_("%"PRItime" year", "%"PRItime" years", years), years);
 			strbuf_addf(timebuf,
 				 /* TRANSLATORS: "%s" is "<n> years" */
-				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
+				 Q_("%s, %"PRItime" month ago", "%s, %"PRItime" months ago", months),
 				 sb.buf, months);
 			strbuf_release(&sb);
 		} else
 			strbuf_addf(timebuf,
-				 Q_("%lu year ago", "%lu years ago", years), years);
+				 Q_("%"PRItime" year ago", "%"PRItime" years ago", years), years);
 		return;
 	}
 	/* Otherwise, just years. Centuries is probably overkill. */
 	strbuf_addf(timebuf,
-		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
+		 Q_("%"PRItime" year ago", "%"PRItime" years ago", (diff + 183) / 365),
 		 (diff + 183) / 365);
 }
 
@@ -179,7 +179,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 
 	if (mode->type == DATE_UNIX) {
 		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%lu", time);
+		strbuf_addf(&timebuf, "%"PRItime, time);
 		return timebuf.buf;
 	}
 
@@ -188,7 +188,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 
 	if (mode->type == DATE_RAW) {
 		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
+		strbuf_addf(&timebuf, "%"PRItime" %+05d", time, tz);
 		return timebuf.buf;
 	}
 
@@ -643,7 +643,7 @@ static void date_string(unsigned long date, int offset, struct strbuf *buf)
 		offset = -offset;
 		sign = '-';
 	}
-	strbuf_addf(buf, "%lu %c%02d%02d", date, sign, offset / 60, offset % 60);
+	strbuf_addf(buf, "%"PRItime" %c%02d%02d", date, sign, offset / 60, offset % 60);
 }
 
 /*
diff --git a/fetch-pack.c b/fetch-pack.c
index d07d85ce302..fb268e328a4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -393,7 +393,7 @@ static int find_common(struct fetch_pack_args *args,
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
 	if (args->deepen_since) {
 		unsigned long max_age = approxidate(args->deepen_since);
-		packet_buf_write(&req_buf, "deepen-since %lu", max_age);
+		packet_buf_write(&req_buf, "deepen-since %"PRItime, max_age);
 	}
 	if (args->deepen_not) {
 		int i;
diff --git a/git-compat-util.h b/git-compat-util.h
index fc1b5fe1a6c..cd522903eda 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,6 +319,7 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
+#define PRItime "lu"
 #define parse_timestamp strtoul
 
 #ifndef PATH_SEP
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fe3e2ac8afe..9b486980722 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3976,7 +3976,7 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 			printf("prune %s", message);
 	} else {
 		if (cb->newlog) {
-			fprintf(cb->newlog, "%s %s %s %lu %+05d\t%s",
+			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
 				oid_to_hex(ooid), oid_to_hex(noid),
 				email, timestamp, tz, message);
 			oidcpy(&cb->last_kept_oid, noid);
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 52d1fc34454..269040f028f 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -53,7 +53,7 @@ static void parse_dates(const char **argv, struct timeval *now)
 
 		strbuf_reset(&result);
 		parse_date(*argv, &result);
-		if (sscanf(result.buf, "%lu %d", &t, &tz) == 2)
+		if (sscanf(result.buf, "%"PRItime" %d", &t, &tz) == 2)
 			printf("%s -> %s\n",
 			       *argv, show_date(t, tz, DATE_MODE(ISO8601)));
 		else
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index a01430c24bd..7d93627e454 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -161,7 +161,7 @@ int cmd_main(int argc, const char **argv)
 	show(&expect, &ret, "boolean: %d", boolean);
 	show(&expect, &ret, "integer: %d", integer);
 	show(&expect, &ret, "magnitude: %lu", magnitude);
-	show(&expect, &ret, "timestamp: %lu", timestamp);
+	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
 	show(&expect, &ret, "string: %s", string ? string : "(not set)");
 	show(&expect, &ret, "abbrev: %d", abbrev);
 	show(&expect, &ret, "verbose: %d", verbose);
diff --git a/upload-pack.c b/upload-pack.c
index f17f4dd1233..4966f0b8a09 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -863,7 +863,7 @@ static void receive_needs(void)
 
 		argv_array_push(&av, "rev-list");
 		if (deepen_since)
-			argv_array_pushf(&av, "--max-age=%lu", deepen_since);
+			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
 		if (deepen_not.nr) {
 			argv_array_push(&av, "--not");
 			for (i = 0; i < deepen_not.nr; i++) {
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 97cba39cdf5..6c9f2866d8b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -73,7 +73,7 @@ void fast_export_begin_note(uint32_t revision, const char *author,
 	static int firstnote = 1;
 	size_t loglen = strlen(log);
 	printf("commit %s\n", note_ref);
-	printf("committer %s <%s@%s> %lu +0000\n", author, author, "local", timestamp);
+	printf("committer %s <%s@%s> %"PRItime" +0000\n", author, author, "local", timestamp);
 	printf("data %"PRIuMAX"\n", (uintmax_t)loglen);
 	fwrite(log, loglen, 1, stdout);
 	if (firstnote) {
@@ -107,7 +107,7 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 	}
 	printf("commit %s\n", local_ref);
 	printf("mark :%"PRIu32"\n", revision);
-	printf("committer %s <%s@%s> %lu +0000\n",
+	printf("committer %s <%s@%s> %"PRItime" +0000\n",
 		   *author ? author : "nobody",
 		   *author ? author : "nobody",
 		   *uuid ? uuid : "local", timestamp);
-- 
2.12.2.windows.1


