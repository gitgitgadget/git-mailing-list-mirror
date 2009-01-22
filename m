From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH] Use time_t for timestamps returned by approxidate() instead of unsigned
Date: Thu, 22 Jan 2009 18:07:02 -0500
Message-ID: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com>
Cc: gitster@pobox.com, Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 05:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQZlA-0001kE-Pe
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 05:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbZAXEAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 23:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbZAXEAG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 23:00:06 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:48077 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZAXEAC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 23:00:02 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2290354ywe.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 20:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=T7kNthZURHoEupUqQBF0I37ShXgTbpcXlFfXXzDd/9E=;
        b=E1nfkfnlPjS+OSv/6hwjEbXVTDhHQwsJrKGRVA5+hKYzqQs1D7wapBq/gygc7XYRzk
         /8ESFk4KGSzKtxFUcbYSkNV753Pe0zEEtuiGn0cqyqtnYlYlZ0QmUlZp9yQuLiA7OEyq
         gDY3aHoilhM/qVI8DBIyi+DIVR+n/Nd5gJGxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hMMdq2XyzMG5SMoa2UwTsMsZC9k3VlFmpbLTkZixxyQhH1J7+q8BUtd+TctTBUppbS
         mixINcX2UYTV3Ii0pO2rpsL14MJ0yrzgE/rlQqaPqL7ga3lAD4w9EG3xxTxF0gzNZyex
         G+w2P17Pcca6ql7B/XW3U/3y3+I+54BPNu4kw=
Received: by 10.64.195.20 with SMTP id s20mr1522847qbf.72.1232769600098;
        Fri, 23 Jan 2009 20:00:00 -0800 (PST)
Received: from localhost (d192-24-95-131.try.wideopenwest.com [24.192.131.95])
        by mx.google.com with ESMTPS id p30sm13794928qbp.17.2009.01.23.19.59.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 19:59:58 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106950>

Use time_t for timestamps returned by approxidate() instead of unsigned
long.  All references to approxidate were checked as well as references
to OPT_DATE.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

This is the first patch I have submitted, so please be brutal in your review so that I may learn ;).

This patch is intended to close one of the "Janitor" tasks listed in the GitWiki.  The change from unsigned long to time_t reached further than I originally anticipated as I looked into all the places where timestamps are used.  Please let me know if I should limit the scope of the changes to only the immediate consumers of values returned by approxidate().

There is at least one place in the code (builtin-for-each-ref.c:370) where what looks like a timestamp is compared against ULONG_MAX.  At first glance this sounds like a bad idea, but within the context of that function (grab_date) it appears to be safe.

-Tim

 Documentation/technical/api-parse-options.txt |    4 ++--
 builtin-gc.c                                  |    2 +-
 builtin-prune.c                               |    2 +-
 builtin-reflog.c                              |    4 ++--
 builtin-show-branch.c                         |    2 +-
 cache.h                                       |    2 +-
 date.c                                        |    2 +-
 parse-options.c                               |    2 +-
 reflog-walk.c                                 |    4 ++--
 refs.c                                        |    2 +-
 refs.h                                        |    2 +-
 revision.h                                    |    4 ++--
 sha1_name.c                                   |    2 +-
 test-parse-options.c                          |    2 +-
 14 files changed, 18 insertions(+), 18 deletions(-)
 mode change 100644 => 100755 builtin-gc.c
 mode change 100644 => 100755 builtin-reflog.c
 mode change 100644 => 100755 builtin-show-branch.c
 mode change 100644 => 100755 cache.h
 mode change 100644 => 100755 date.c
 mode change 100644 => 100755 parse-options.c
 mode change 100644 => 100755 reflog-walk.c
 mode change 100644 => 100755 refs.c
 mode change 100644 => 100755 refs.h
 mode change 100644 => 100755 revision.c
 mode change 100644 => 100755 revision.h
 mode change 100644 => 100755 sha1_name.c

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 539863b..c1dd29d 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -125,9 +125,9 @@ There are some macros to easily define options:
 	Introduce an option with integer argument.
 	The integer is put into `int_var`.
 
-`OPT_DATE(short, long, &int_var, description)`::
+`OPT_DATE(short, long, &time_var, description)`::
 	Introduce an option with date argument, see `approxidate()`.
-	The timestamp is put into `int_var`.
+	The timestamp is put into `time_var`.
 
 `OPT_CALLBACK(short, long, &var, arg_str, description, func_ptr)`::
 	Introduce an option with argument.
diff --git a/builtin-gc.c b/builtin-gc.c
old mode 100644
new mode 100755
index a201438..eea891b
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -58,7 +58,7 @@ static int gc_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "gc.pruneexpire")) {
 		if (value && strcmp(value, "now")) {
-			unsigned long now = approxidate("now");
+			time_t now = approxidate("now");
 			if (approxidate(value) >= now)
 				return error("Invalid %s: '%s'", var, value);
 		}
diff --git a/builtin-prune.c b/builtin-prune.c
index 545e9c1..a0f1a63 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -13,7 +13,7 @@ static const char * const prune_usage[] = {
 };
 static int show_only;
 static int verbose;
-static unsigned long expire;
+static time_t expire;
 
 static int prune_tmp_object(const char *path, const char *filename)
 {
diff --git a/builtin-reflog.c b/builtin-reflog.c
old mode 100644
new mode 100755
index d95f515..bae0c3e
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -361,7 +361,7 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 	return ent;
 }
 
-static int parse_expire_cfg_value(const char *var, const char *value, unsigned long *expire)
+static int parse_expire_cfg_value(const char *var, const char *value, time_t *expire)
 {
 	if (!value)
 		return config_error_nonbool(var);
@@ -380,7 +380,7 @@ static int parse_expire_cfg_value(const char *var, const char *value, unsigned l
 static int reflog_expire_config(const char *var, const char *value, void *cb)
 {
 	const char *lastdot = strrchr(var, '.');
-	unsigned long expire;
+	time_t expire;
 	int slot;
 	struct reflog_expire_cfg *ent;
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
old mode 100644
new mode 100755
index 306b850..695d553
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -716,7 +716,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			base = strtoul(reflog_base, &ep, 10);
 			if (*ep) {
 				/* Ah, that is a date spec... */
-				unsigned long at;
+				time_t at;
 				at = approxidate(reflog_base);
 				read_ref_at(ref, at, -1, sha1, NULL,
 					    NULL, NULL, &base);
diff --git a/cache.h b/cache.h
old mode 100644
new mode 100755
index 8d965b8..397adf1
--- a/cache.h
+++ b/cache.h
@@ -699,7 +699,7 @@ enum date_mode {
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
-unsigned long approxidate(const char *);
+time_t approxidate(const char *);
 enum date_mode parse_date_format(const char *format);
 
 #define IDENT_WARN_ON_NO_NAME  1
diff --git a/date.c b/date.c
old mode 100644
new mode 100755
index 950b88f..5971266
--- a/date.c
+++ b/date.c
@@ -841,7 +841,7 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num)
 	return end;
 }
 
-unsigned long approxidate(const char *date)
+time_t approxidate(const char *date)
 {
 	int number = 0;
 	struct tm tm, now;
diff --git a/parse-options.c b/parse-options.c
old mode 100644
new mode 100755
index 9eb55cc..0501ee2
--- a/parse-options.c
+++ b/parse-options.c
@@ -480,7 +480,7 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 			     int unset)
 {
-	*(unsigned long *)(opt->value) = approxidate(arg);
+	*(time_t *)(opt->value) = approxidate(arg);
 	return 0;
 }
 
diff --git a/reflog-walk.c b/reflog-walk.c
old mode 100644
new mode 100755
index f751fdc..73b4932
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -68,7 +68,7 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 }
 
 static int get_reflog_recno_by_time(struct complete_reflogs *array,
-	unsigned long timestamp)
+	time_t timestamp)
 {
 	int i;
 	for (i = array->nr - 1; i >= 0; i--)
@@ -139,7 +139,7 @@ void init_reflog_walk(struct reflog_walk_info** info)
 int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name)
 {
-	unsigned long timestamp = 0;
+	time_t timestamp = 0;
 	int recno = -1;
 	struct string_list_item *item;
 	struct complete_reflogs *reflogs;
diff --git a/refs.c b/refs.c
old mode 100644
new mode 100755
index 33ced65..63327b8
--- a/refs.c
+++ b/refs.c
@@ -1347,7 +1347,7 @@ static char *ref_msg(const char *line, const char *endp)
 	return xmemdupz(line, ep - line);
 }
 
-int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
+int read_ref_at(const char *ref, time_t at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
 	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
 	char *tz_c;
diff --git a/refs.h b/refs.h
old mode 100644
new mode 100755
index 06ad260..262728c
--- a/refs.h
+++ b/refs.h
@@ -55,7 +55,7 @@ extern void unlock_ref(struct ref_lock *lock);
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
+extern int read_ref_at(const char *ref, time_t at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
diff --git a/revision.c b/revision.c
old mode 100644
new mode 100755
diff --git a/revision.h b/revision.h
old mode 100644
new mode 100755
index 7cf8487..660607b
--- a/revision.h
+++ b/revision.h
@@ -106,8 +106,8 @@ struct rev_info {
 	/* special limits */
 	int skip_count;
 	int max_count;
-	unsigned long max_age;
-	unsigned long min_age;
+	time_t max_age;
+	time_t min_age;
 
 	/* diff info for patches and for paths limiting */
 	struct diff_options diffopt;
diff --git a/sha1_name.c b/sha1_name.c
old mode 100644
new mode 100755
index 159c2ab..fe915c8
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -339,7 +339,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 
 	if (reflog_len) {
 		int nth, i;
-		unsigned long at_time;
+		time_t at_time;
 		unsigned long co_time;
 		int co_tz, co_cnt;
 
diff --git a/test-parse-options.c b/test-parse-options.c
index 61d2c39..c8d110d 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -3,7 +3,7 @@
 
 static int boolean = 0;
 static int integer = 0;
-static unsigned long timestamp;
+static time_t timestamp;
 static int abbrev = 7;
 static int verbose = 0, dry_run = 0, quiet = 0;
 static char *string = NULL;
-- 
1.6.0.6


>From 22354d185e5c89a5b492898b9b5eba429fed85d3 Mon Sep 17 00:00:00 2001
From: Tim Henigan <tim.henigan@gmail.com>
Date: Thu, 22 Jan 2009 16:08:42 -0500
Subject: [PATCH] Further changes to migrate timestamp vars in the code from type unsigned long to time_t.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 builtin-cat-file.c    |    2 +-
 builtin-reflog.c      |   18 +++++++++---------
 builtin-show-branch.c |    2 +-
 date.c                |    4 ++--
 refs.c                |    6 +++---
 refs.h                |    2 +-
 sha1_name.c           |    2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 8fad19d..1d7a361 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -42,7 +42,7 @@ static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long
 					 */
 					const char *sp = tagger;
 					char *ep;
-					unsigned long date;
+					time_t date;
 					long tz;
 					while (sp < cp && *sp != '>')
 						sp++;
diff --git a/builtin-reflog.c b/builtin-reflog.c
index bae0c3e..74284af 100755
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -17,8 +17,8 @@ static const char reflog_expire_usage[] =
 static const char reflog_delete_usage[] =
 "git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
 
-static unsigned long default_reflog_expire;
-static unsigned long default_reflog_expire_unreachable;
+static time_t default_reflog_expire;
+static time_t default_reflog_expire_unreachable;
 
 struct cmd_reflog_expire_cb {
 	struct rev_info revs;
@@ -27,8 +27,8 @@ struct cmd_reflog_expire_cb {
 	int rewrite;
 	int updateref;
 	int verbose;
-	unsigned long expire_total;
-	unsigned long expire_unreachable;
+	time_t expire_total;
+	time_t expire_unreachable;
 	int recno;
 };
 
@@ -210,7 +210,7 @@ static int keep_entry(struct commit **it, unsigned char *sha1)
 }
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, time_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
@@ -335,8 +335,8 @@ static int collect_reflog(const char *ref, const unsigned char *sha1, int unused
 
 static struct reflog_expire_cfg {
 	struct reflog_expire_cfg *next;
-	unsigned long expire_total;
-	unsigned long expire_unreachable;
+	time_t expire_total;
+	time_t expire_unreachable;
 	size_t len;
 	char pattern[FLEX_ARRAY];
 } *reflog_expire_cfg, **reflog_expire_cfg_tail;
@@ -462,7 +462,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cb;
-	unsigned long now = time(NULL);
+	time_t now = time(NULL);
 	int i, status, do_all;
 	int explicit_expiry = 0;
 
@@ -554,7 +554,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 }
 
 static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *email, time_t timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cb = cb_data;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 695d553..73b3dc0 100755
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -726,7 +726,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		for (i = 0; i < reflog; i++) {
 			char *logmsg, *m;
 			const char *msg;
-			unsigned long timestamp;
+			time_t timestamp;
 			int tz;
 
 			if (read_ref_at(ref, 0, base+i, sha1, &logmsg,
diff --git a/date.c b/date.c
index 5971266..d185ea6 100755
--- a/date.c
+++ b/date.c
@@ -84,13 +84,13 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
 
-const char *show_date(unsigned long time, int tz, enum date_mode mode)
+const char *show_date(time_t time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
 	static char timebuf[200];
 
 	if (mode == DATE_RELATIVE) {
-		unsigned long diff;
+		time_t diff;
 		struct timeval now;
 		gettimeofday(&now, NULL);
 		if (now.tv_sec < time)
diff --git a/refs.c b/refs.c
index 63327b8..159d136 100755
--- a/refs.c
+++ b/refs.c
@@ -1347,13 +1347,13 @@ static char *ref_msg(const char *line, const char *endp)
 	return xmemdupz(line, ep - line);
 }
 
-int read_ref_at(const char *ref, time_t at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
+int read_ref_at(const char *ref, time_t at_time, int cnt, unsigned char *sha1, char **msg, time_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
 	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
 	char *tz_c;
 	int logfd, tz, reccnt = 0;
 	struct stat st;
-	unsigned long date;
+	time_t date;
 	unsigned char logged_sha1[20];
 	void *log_mapped;
 	size_t mapsz;
@@ -1467,7 +1467,7 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 	while (fgets(buf, sizeof(buf), logfp)) {
 		unsigned char osha1[20], nsha1[20];
 		char *email_end, *message;
-		unsigned long timestamp;
+		time_t timestamp;
 		int len, tz;
 
 		/* old SP new SP name <email> SP time TAB msg LF */
diff --git a/refs.h b/refs.h
index 262728c..604d5a3 100755
--- a/refs.h
+++ b/refs.h
@@ -55,7 +55,7 @@ extern void unlock_ref(struct ref_lock *lock);
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
 /** Reads log for the value of ref during at_time. **/
-extern int read_ref_at(const char *ref, time_t at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
+extern int read_ref_at(const char *ref, time_t at_time, int cnt, unsigned char *sha1, char **msg, time_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
diff --git a/sha1_name.c b/sha1_name.c
index fe915c8..8a65def 100755
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -340,7 +340,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (reflog_len) {
 		int nth, i;
 		time_t at_time;
-		unsigned long co_time;
+		time_t co_time;
 		int co_tz, co_cnt;
 
 		/* Is it asking for N-th entry, or approxidate? */
-- 
1.6.0.6


>From 7fb1e3d6390d46433e7ce10841bf11cab3b1d0ff Mon Sep 17 00:00:00 2001
From: Tim Henigan <tim.henigan@gmail.com>
Date: Thu, 22 Jan 2009 17:08:06 -0500
Subject: [PATCH] Final changes to convert unsigned longs to time_t

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 cache.h       |    2 +-
 date.c        |    8 ++++----
 pretty.c      |    4 ++--
 reflog-walk.c |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 397adf1..a18730c 100755
--- a/cache.h
+++ b/cache.h
@@ -696,7 +696,7 @@ enum date_mode {
 	DATE_RFC2822
 };
 
-const char *show_date(unsigned long time, int timezone, enum date_mode mode);
+const char *show_date(time_t time, int timezone, enum date_mode mode);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 time_t approxidate(const char *);
diff --git a/date.c b/date.c
index d185ea6..59b4426 100755
--- a/date.c
+++ b/date.c
@@ -37,7 +37,7 @@ static const char *weekday_names[] = {
 	"Sundays", "Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays"
 };
 
-static time_t gm_time_t(unsigned long time, int tz)
+static time_t gm_time_t(time_t time, int tz)
 {
 	int minutes;
 
@@ -52,7 +52,7 @@ static time_t gm_time_t(unsigned long time, int tz)
  * thing, which means that tz -0100 is passed in as the integer -100,
  * even though it means "sixty minutes off"
  */
-static struct tm *time_to_tm(unsigned long time, int tz)
+static struct tm *time_to_tm(time_t time, int tz)
 {
 	time_t t = gm_time_t(time, tz);
 	return gmtime(&t);
@@ -62,7 +62,7 @@ static struct tm *time_to_tm(unsigned long time, int tz)
  * What value of "tz" was in effect back then at "time" in the
  * local timezone?
  */
-static int local_tzoffset(unsigned long time)
+static int local_tzoffset(time_t time)
 {
 	time_t t, t_local;
 	struct tm tm;
@@ -632,7 +632,7 @@ void datestamp(char *buf, int bufsize)
 	date_string(now, offset, buf, bufsize);
 }
 
-static void update_tm(struct tm *tm, unsigned long sec)
+static void update_tm(struct tm *tm, time_t sec)
 {
 	time_t n = mktime(tm) - sec;
 	localtime_r(&n, tm);
diff --git a/pretty.c b/pretty.c
index cc460b5..6ab3222 100644
--- a/pretty.c
+++ b/pretty.c
@@ -126,7 +126,7 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 {
 	char *date;
 	int namelen;
-	unsigned long time;
+	time_t time;
 	int tz;
 	const char *filler = "    ";
 
@@ -330,7 +330,7 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	/* currently all placeholders have same length */
 	const int placeholder_len = 2;
 	int start, end, tz = 0;
-	unsigned long date = 0;
+	time_t date = 0;
 	char *ep;
 
 	/* advance 'end' to point to email start delimiter */
diff --git a/reflog-walk.c b/reflog-walk.c
index 73b4932..1bc9675 100755
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -11,7 +11,7 @@ struct complete_reflogs {
 	struct reflog_info {
 		unsigned char osha1[20], nsha1[20];
 		char *email;
-		unsigned long timestamp;
+		time_t timestamp;
 		int tz;
 		char *message;
 	} *items;
-- 
1.6.0.6
