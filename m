Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB041F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbdB0Vsr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:48:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:52861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbdB0Vsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:48:33 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M6wWn-1cLYpo4AWD-00wjmi; Mon, 27
 Feb 2017 22:30:34 +0100
Date:   Mon, 27 Feb 2017 22:30:32 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] Specify explicitly where we parse timestamps
In-Reply-To: <cover.1488231002.git.johannes.schindelin@gmx.de>
Message-ID: <12b60c14dad15e3252e314771b3fe369305bbfc5.1488231002.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:crT6EyFxxnkAEu7hcmyYdzF8u1mcBpePMwp0tdiIFh4qzBK5owl
 P0y6F+ISCvBTGbwkZ8cdDngSfaFQ5lgl9s1rzHqUbT1F6C5Uz9Yz6lIT9bo9P8JDYWG6Ego
 HEdirtWtVNz9OMJZBqvudPSMZ4KjjHpeRr1hjlP4tfM8aLavC2uMtiNIcWx3K2Bw6doIMwM
 svn+6AC2x11LlF0eVhWTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ccCiqMdSmRk=:XIkKv6A1H0LlxJ9TJb75zE
 46mXCpz6dBg5l0YlG5J3nwXDAfUyyHJKYZbt/eLs6XIHVv88UqGdSCERWvFpIhMGKHqyhkQ6+
 xHIcA99icbZsKSZY1SC6ugdOK7Ul+if8OebDeAlWaFrJwAxyx1LB2u08NV91XhCUJbZQ7oQLy
 UNPWjbDEADQobH5t4PxsdGqtR8NBLABKga0WBcIajidxwRvAneQLu88fO/kH0aGlUKU90pSoz
 jgBL3qdO7P0xe44eZyToi6PQDL77NmaZTG/dpmhv687JTYUwMq4xIMpzMjk46uBrBV+JlD9xC
 qdy6k5yrClGcylNc6AE4WdURMvkjwUc4vIvBTl2nNJtQY0AM2XLQ3qEafMt4mb0JujcQzk9su
 0jK5xcJVJjjISllpyk4Kbhm/IqgONXK68NpJKeF1wKhxJL+JORv86o6MDkx0lYptalk57c5mp
 mLD8OhXEEPHyzXLxrKMmS6mHv9VGlbxjnbu5RAXXZtwCwfhMHavf3hvl9O/N3DjOnL1XKXWfu
 5+z+VxSJqhQnrnfRRBin52MmOH1nR0p13V+WTiJxpTMkgnAM0OwU1QN1nEmD0Y7PdVJpgx+NA
 JEKXg6SKfMQ1CR7TxjnkX7INPykB5hVP3Wfloxx6QlLMeU44jl+R42azohWUOAKxbLQAZi58j
 MQKi2A2EJJtXl0DKY5F8uTmhibkpxc4JK3tY+2baImetgJ/PpIhO7RWCvk+2FYcYO9N2HaHs9
 8JHtUSdIkngARsIhOE2v/9y77EcBDyfTlAHrA0Lt/JGhjEHxKDQpCASJb6bi8Hx/L5qidMRD7
 kY2X+HZa3VPfAZLMZpmu4md1Rp2yg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git's source code represents all timestamps as `unsigned
long`. In preparation for using `time_t` instead, let's introduce a
symbol `parse_timestamp` (currently being defined to `strtoul`) where
appropriate, so that we can later easily switch to use `strtoull()`
instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c         | 2 +-
 bundle.c             | 2 +-
 commit.c             | 4 ++--
 date.c               | 6 +++---
 fsck.c               | 2 +-
 git-compat-util.h    | 2 ++
 pretty.c             | 2 +-
 ref-filter.c         | 2 +-
 t/helper/test-date.c | 2 +-
 tag.c                | 2 +-
 upload-pack.c        | 2 +-
 11 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 31fb60578f6..75e2d939036 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -882,7 +882,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 			char *end;
 
 			errno = 0;
-			timestamp = strtoul(str, &end, 10);
+			timestamp = parse_timestamp(str, &end, 10);
 			if (errno)
 				return error(_("invalid timestamp"));
 
diff --git a/bundle.c b/bundle.c
index bbf4efa0a0a..f43bfcf5ff3 100644
--- a/bundle.c
+++ b/bundle.c
@@ -227,7 +227,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	line = memchr(line, '>', lineend ? lineend - line : buf + size - line);
 	if (!line++)
 		goto out;
-	date = strtoul(line, NULL, 10);
+	date = parse_timestamp(line, NULL, 10);
 	result = (revs->max_age == -1 || revs->max_age < date) &&
 		(revs->min_age == -1 || revs->min_age > date);
 out:
diff --git a/commit.c b/commit.c
index 2cf85158b48..7f56b643704 100644
--- a/commit.c
+++ b/commit.c
@@ -90,7 +90,7 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 	if (buf >= tail)
 		return 0;
 	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
-	return strtoul(dateptr, NULL, 10);
+	return parse_timestamp(dateptr, NULL, 10);
 }
 
 static struct commit_graft **commit_graft;
@@ -608,7 +608,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	    !ident.date_begin || !ident.date_end)
 		goto fail_exit; /* malformed "author" line */
 
-	date = strtoul(ident.date_begin, &date_end, 10);
+	date = parse_timestamp(ident.date_begin, &date_end, 10);
 	if (date_end != ident.date_end)
 		goto fail_exit; /* malformed date */
 	*(author_date_slab_at(author_date, commit)) = date;
diff --git a/date.c b/date.c
index a996331f5b3..a8848f6e141 100644
--- a/date.c
+++ b/date.c
@@ -510,7 +510,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 	char *end;
 	unsigned long num;
 
-	num = strtoul(date, &end, 10);
+	num = parse_timestamp(date, &end, 10);
 
 	/*
 	 * Seconds since 1970? We trigger on that for any numbers with
@@ -658,7 +658,7 @@ static int match_object_header_date(const char *date, unsigned long *timestamp,
 
 	if (*date < '0' || '9' < *date)
 		return -1;
-	stamp = strtoul(date, &end, 10);
+	stamp = parse_timestamp(date, &end, 10);
 	if (*end != ' ' || stamp == ULONG_MAX || (end[1] != '+' && end[1] != '-'))
 		return -1;
 	date = end + 2;
@@ -1066,7 +1066,7 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
 				     time_t now)
 {
 	char *end;
-	unsigned long number = strtoul(date, &end, 10);
+	time_t number = parse_timestamp(date, &end, 10);
 
 	switch (*end) {
 	case ':':
diff --git a/fsck.c b/fsck.c
index 939792752bf..33a66e68a83 100644
--- a/fsck.c
+++ b/fsck.c
@@ -690,7 +690,7 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	p++;
 	if (*p == '0' && p[1] != ' ')
 		return report(options, obj, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
-	if (date_overflows(strtoul(p, &end, 10)))
+	if (date_overflows(parse_timestamp(p, &end, 10)))
 		return report(options, obj, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
 	if ((end == p || *end != ' '))
 		return report(options, obj, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
diff --git a/git-compat-util.h b/git-compat-util.h
index ef6d560e156..5eff97bea2e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,6 +319,8 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
+#define parse_timestamp strtoul
+
 #ifndef PATH_SEP
 #define PATH_SEP ':'
 #endif
diff --git a/pretty.c b/pretty.c
index 5e683830d9d..6d1e1e87e7d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -409,7 +409,7 @@ const char *show_ident_date(const struct ident_split *ident,
 	long tz = 0;
 
 	if (ident->date_begin && ident->date_end)
-		date = strtoul(ident->date_begin, NULL, 10);
+		date = parse_timestamp(ident->date_begin, NULL, 10);
 	if (date_overflows(date))
 		date = 0;
 	else {
diff --git a/ref-filter.c b/ref-filter.c
index 3820b21cc75..6fab0db5e0d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -637,7 +637,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 
 	if (!eoemail)
 		goto bad;
-	timestamp = strtoul(eoemail + 2, &zone, 10);
+	timestamp = parse_timestamp(eoemail + 2, &zone, 10);
 	if (timestamp == ULONG_MAX)
 		goto bad;
 	tz = strtol(zone, NULL, 10);
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 4727bea255c..98637053760 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -33,7 +33,7 @@ static void show_dates(const char **argv, const char *format)
 		 * Do not use our normal timestamp parsing here, as the point
 		 * is to test the formatting code in isolation.
 		 */
-		t = strtol(*argv, &arg, 10);
+		t = parse_timestamp(*argv, &arg, 10);
 		while (*arg == ' ')
 			arg++;
 		tz = atoi(arg);
diff --git a/tag.c b/tag.c
index 243d1fdbbcb..55d07725777 100644
--- a/tag.c
+++ b/tag.c
@@ -111,7 +111,7 @@ static unsigned long parse_tag_date(const char *buf, const char *tail)
 	if (buf >= tail)
 		return 0;
 	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
-	return strtoul(dateptr, NULL, 10);
+	return parse_timestamp(dateptr, NULL, 10);
 }
 
 int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
diff --git a/upload-pack.c b/upload-pack.c
index 7597ba3405e..8c47dc1707a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -775,7 +775,7 @@ static void receive_needs(void)
 		}
 		if (skip_prefix(line, "deepen-since ", &arg)) {
 			char *end = NULL;
-			deepen_since = strtoul(arg, &end, 0);
+			deepen_since = parse_timestamp(arg, &end, 0);
 			if (!end || *end || !deepen_since ||
 			    /* revisions.c's max_age -1 is special */
 			    deepen_since == -1)
-- 
2.11.1.windows.1.379.g44ae0bc


