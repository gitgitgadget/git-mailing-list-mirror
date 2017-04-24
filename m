Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C267207E2
	for <e@80x24.org>; Mon, 24 Apr 2017 13:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171924AbdDXN6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 09:58:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:62213 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171920AbdDXN63 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 09:58:29 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRjd7-1caRQw3bzd-00T0Ne; Mon, 24
 Apr 2017 15:58:19 +0200
Date:   Mon, 24 Apr 2017 15:58:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 4/8] Specify explicitly where we parse timestamps
In-Reply-To: <cover.1493042239.git.johannes.schindelin@gmx.de>
Message-ID: <d6c1709475927a55c5bb0e6ce9d0b6be20b05735.1493042239.git.johannes.schindelin@gmx.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de> <cover.1493042239.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yZAC/2fLMf4saG4CdKfIfhSuDUUhF/kEiJQjSpMb+8FiQs9mn9p
 /fcK83+Tg2yuQsXvkb+WkEP0faYzMVHQx8EdS4n8iHjWbWRQd9WapcI2caHLszoXUrhVwuq
 l/IPLmswS7+TxSILNhjjaq4AQUJlK+RBI6e+dDu2Ywx9c9ttm2pAxnzfgUbKbHdnvqr07bj
 uDlgjWd3j0JXj0r9ZHGeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eyT2ZaRuLtM=:OtDKqif9FEp5WOEI3VvWpt
 p+UVfrIJgJ+1vIOYYFREWuM0xEsuQWXN3HI9NKBSlSOVYUBhdHRaR8RNnh8YBcjATEGPJU7L+
 hMJEUtYR0vpxfpVVKEh5YGuwbdQzQHWkpYdwk7h7EXEgxvJI4owPc3WZ3yHPNDTivitJQkHG5
 gszGVzuAeXaSqp5xrfWTvf52KltKTU1pNW8IVUsdHcoFsl/vVizmVFkEeye6mshHB66ssMHWA
 ByWEqVUDszyzYBj2vngH+ck2csotYRvfgMfNHVTVMHSUmtV4dUfGQnAxJAIF+RZdvX+28QLGg
 /EJujFTzIUazuAkZeVzoLuJPNSF+8oHItTBQIlNEJJJiXPP5bYDF+VxZOlCmuluSGObXVtvVz
 nUAaWjBCIq18SYq53qnb2iCqJqksSBaqzd8piOzjpWqApKRMtgJtSmK+CS+zEjCJfeRuYy1h9
 8yn2CJdCaVCkFWIrD2Gyp1vBMTH67AjeYeif0dc+2TBRgOB8hhAQWoGhwX+hqdMbgGn5rSwNe
 DL1Lv/zJ5+iArI2y1Ct2HBqqKcc1JEwU0zosUnMhzzTGW/3selKHSVyvt1KBd4xnNyNtxAlOn
 fZ4JzT3wFLctSb1qrmhwomGMpp2fWTQYZPq+AFMzPStrL0x3F0WlH2qrlJDd+CBicWN2EbPbN
 k7q9EnS8g7XxnYwZFScICgb6kB8qT/IeOCuaWdV4BY1DSI2QwRqe9sFFkdRx/5v5wB2ULLgRb
 d8Lm+Qjl+aM0s4F/6g40QRehwMSo1TXS0ggrQ24O/AVp8UqDDjZbDeXkhJ5clCSUPMXw5MN0a
 iBgY1kM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git's source code represents all timestamps as `unsigned
long`. In preparation for using a more appropriate data type, let's
introduce a symbol `parse_timestamp` (currently being defined to
`strtoul`) where appropriate, so that we can later easily switch to,
say, use `strtoull()` instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c           | 2 +-
 builtin/receive-pack.c | 4 ++--
 bundle.c               | 2 +-
 commit.c               | 6 +++---
 date.c                 | 6 +++---
 fsck.c                 | 2 +-
 git-compat-util.h      | 2 ++
 pretty.c               | 2 +-
 ref-filter.c           | 2 +-
 refs/files-backend.c   | 2 +-
 t/helper/test-date.c   | 2 +-
 tag.c                  | 4 ++--
 upload-pack.c          | 2 +-
 13 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 805f56cec2f..ffb7a6355fb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -886,7 +886,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 			char *end;
 
 			errno = 0;
-			timestamp = strtoul(str, &end, 10);
+			timestamp = parse_timestamp(str, &end, 10);
 			if (errno)
 				return error(_("invalid timestamp"));
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f96834f42c9..d25a57931f8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -534,7 +534,7 @@ static const char *check_nonce(const char *buf, size_t len)
 		retval = NONCE_BAD;
 		goto leave;
 	}
-	stamp = strtoul(nonce, &bohmac, 10);
+	stamp = parse_timestamp(nonce, &bohmac, 10);
 	if (bohmac == nonce || bohmac[0] != '-') {
 		retval = NONCE_BAD;
 		goto leave;
@@ -552,7 +552,7 @@ static const char *check_nonce(const char *buf, size_t len)
 	 * would mean it was issued by another server with its clock
 	 * skewed in the future.
 	 */
-	ostamp = strtoul(push_cert_nonce, NULL, 10);
+	ostamp = parse_timestamp(push_cert_nonce, NULL, 10);
 	nonce_stamp_slop = (long)ostamp - (long)stamp;
 
 	if (nonce_stamp_slop_limit &&
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
index 73c78c2b80c..0d2d0fa1984 100644
--- a/commit.c
+++ b/commit.c
@@ -89,8 +89,8 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 		/* nada */;
 	if (buf >= tail)
 		return 0;
-	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
-	return strtoul(dateptr, NULL, 10);
+	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
+	return parse_timestamp(dateptr, NULL, 10);
 }
 
 static struct commit_graft **commit_graft;
@@ -607,7 +607,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	    !ident.date_begin || !ident.date_end)
 		goto fail_exit; /* malformed "author" line */
 
-	date = strtoul(ident.date_begin, &date_end, 10);
+	date = parse_timestamp(ident.date_begin, &date_end, 10);
 	if (date_end != ident.date_end)
 		goto fail_exit; /* malformed date */
 	*(author_date_slab_at(author_date, commit)) = date;
diff --git a/date.c b/date.c
index a996331f5b3..495c207c64f 100644
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
+	unsigned long number = parse_timestamp(date, &end, 10);
 
 	switch (*end) {
 	case ':':
diff --git a/fsck.c b/fsck.c
index e6152e4e6d4..d589341cddf 100644
--- a/fsck.c
+++ b/fsck.c
@@ -691,7 +691,7 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	p++;
 	if (*p == '0' && p[1] != ' ')
 		return report(options, obj, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
-	if (date_overflows(strtoul(p, &end, 10)))
+	if (date_overflows(parse_timestamp(p, &end, 10)))
 		return report(options, obj, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
 	if ((end == p || *end != ' '))
 		return report(options, obj, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
diff --git a/git-compat-util.h b/git-compat-util.h
index bd04564a69a..d78cc36dd1a 100644
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
index d0f86f5d85c..24fb0c79062 100644
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
index 92871266001..c7836ae07bd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -868,7 +868,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 
 	if (!eoemail)
 		goto bad;
-	timestamp = strtoul(eoemail + 2, &zone, 10);
+	timestamp = parse_timestamp(eoemail + 2, &zone, 10);
 	if (timestamp == ULONG_MAX)
 		goto bad;
 	tz = strtol(zone, NULL, 10);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index c9d900fd128..801d26468e0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3247,7 +3247,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
 	    !(email_end = strchr(p, '>')) ||
 	    email_end[1] != ' ' ||
-	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
+	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
 	    !message || message[0] != ' ' ||
 	    (message[1] != '+' && message[1] != '-') ||
 	    !isdigit(message[2]) || !isdigit(message[3]) ||
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index ac7c66c733b..52d1fc34454 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -34,7 +34,7 @@ static void show_dates(const char **argv, const char *format)
 		 * Do not use our normal timestamp parsing here, as the point
 		 * is to test the formatting code in isolation.
 		 */
-		t = strtol(*argv, &arg, 10);
+		t = parse_timestamp(*argv, &arg, 10);
 		while (*arg == ' ')
 			arg++;
 		tz = atoi(arg);
diff --git a/tag.c b/tag.c
index 243d1fdbbcb..9b6725e02c9 100644
--- a/tag.c
+++ b/tag.c
@@ -110,8 +110,8 @@ static unsigned long parse_tag_date(const char *buf, const char *tail)
 		/* nada */;
 	if (buf >= tail)
 		return 0;
-	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
-	return strtoul(dateptr, NULL, 10);
+	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
+	return parse_timestamp(dateptr, NULL, 10);
 }
 
 int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
diff --git a/upload-pack.c b/upload-pack.c
index ffb028d6231..f17f4dd1233 100644
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
2.12.2.windows.2.406.gd14a8f8640f


