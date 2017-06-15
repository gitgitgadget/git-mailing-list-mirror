Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 310B31FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 08:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbdFOIqd (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 04:46:33 -0400
Received: from mout.web.de ([212.227.15.3]:63380 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdFOIqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 04:46:31 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMmwZ-1dSrbJ3291-008ce9; Thu, 15
 Jun 2017 10:46:10 +0200
Subject: [PATCH v2] strbuf: let strbuf_addftime handle %z and %Z itself
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
 <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
 <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d578d104-79c6-6c07-db4d-3e4ccb0c0dd9@web.de>
Date:   Thu, 15 Jun 2017 10:46:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:JhYvwAJsgvC1tHuniIArTS0Jbx88aZPHZFe+V7luT00xm2Uo4jN
 NjDqONG/pULvOXXi0VheNvNPs1KWJB6ad23gZcLO6hipn7MbcRjMFe0zoc9Xo4HtpHxP2ch
 bRAD44p971OHQhLvJvdNCIv1M3hZIPk0FbCtmQIglS5Ldn0wz+Pfj+xFkmQlIVAD3nSO36a
 n/Hn+0ndA000wZ9RaFNKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iKS88sQ2lE0=:Ztti7vwi1Wt3cZ3Ejd4vQC
 ALlGC/Nsnt4mYViJQ2r0Ss+5by8LBSRur62rdpKFFHgz3BmAbqjCoqSswFD6cCfPaDf3RjUx4
 uuUVVIS7WYVZ5G74Uv56wEPAqvN2Myf0L3Wa1+GlpTblMQqIlpVYsP42xkCNuoPh0uzmeaO4S
 ZxAT6BW8+UOcmP1hX1ZZzzJxIdBU+AwjlOxvs5BSLk7HyJls5dweW4f8rD01MIlKENvugJK60
 a74yVlYtsPAWGoCCAzkt0PdF5smzvS9g2OxfhFZMfrrSp5H0XKx0MQLczqs6/OO8Ai0WoYBBU
 Z7kbaUpyLdBdfZa/VJYeBtWrTtM2fNbUpZBv5F14v1T2FbT3FpO3Gw+2L58MM2iBIu7roqNp+
 pEqWdn5x0vfOG7Vn23tXNXCVYkYKskKYMgPan8taOleqKl8QdQ6/yzlAyf9j90bFQ5pYUw0gV
 Lv+xwDoYQyyvxBgtqLyLmCviuPT1vmensxYLlWEbP14Xyvb+Hv3ksqX5+OW/EQ8bu4S27+qXb
 MIg2wWzb9sE2N716gJ3uEadMU5g2P4DbnafIV2cYCN5mbf8rIz+xo/sEzJL8NCv7UO9FN9bZM
 KxiaY1/Wr5YmhhaBQeMGMzjsjtGrMuRc2IMrGnvRG4GZyNh6WbHYIyTEXep8wi8BbliX9e+In
 jIFQi5VugywauEaScMKr0OJtG31Iqwlmz9GeiR3Ek9cVDTVNzFy0lybSzvKnKseoTU7zWQb14
 aJegtt8N3AGzpyDNE8PaYbdlZ9eAIcal0EGHA2agYHBUJOYjF8cQ6tBwQogVx7pToV37uqTnH
 Yw53yFS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no portable way to pass timezone information to strftime.  Add
parameters for timezone offset and name to strbuf_addftime and let it
handle the timezone-related format specifiers %z and %Z internally.

Callers can opt out for %Z by passing NULL as timezone name.  %z is
always handled internally -- this helps on Windows, where strftime would
expand it to a timezone name (same as %Z), in violation of POSIX.
Modifiers are not handled, e.g. %Ez is still passed to strftime.

Use an empty string as timezone name in show_date (the only current
caller) for now because we only have the timezone offset in non-local
mode.  POSIX allows %Z to resolve to an empty string in case of missing
information.

Helped-by: Ulrich Mueller <ulm@gentoo.org>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Changes from v1:
- Always handle %z internally.
- Move tests from t6006 to t0006, as that's a more appropriate place.
- Changed tests to only use %%, %z and %Z to avoid incompatibilities.
- Tested on mingw (applies there with patch and some fuzz).

 date.c          |  2 +-
 strbuf.c        | 41 +++++++++++++++++++++++++++++++++++++----
 strbuf.h        | 11 ++++++++---
 t/t0006-date.sh |  6 ++++++
 4 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/date.c b/date.c
index 63fa99685e..5580577334 100644
--- a/date.c
+++ b/date.c
@@ -246,7 +246,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else if (mode->type == DATE_STRFTIME)
-		strbuf_addftime(&timebuf, mode->strftime_fmt, tm);
+		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz, "");
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
diff --git a/strbuf.c b/strbuf.c
index 00457940cf..be3b9e37b1 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -785,14 +785,48 @@ char *xstrfmt(const char *fmt, ...)
 	return ret;
 }
 
-void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
+void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
+		     int tz_offset, const char *tz_name)
 {
+	struct strbuf munged_fmt = STRBUF_INIT;
 	size_t hint = 128;
 	size_t len;
 
 	if (!*fmt)
 		return;
 
+	/*
+	 * There is no portable way to pass timezone information to
+	 * strftime, so we handle %z and %Z here.
+	 */
+	for (;;) {
+		const char *percent = strchrnul(fmt, '%');
+		strbuf_add(&munged_fmt, fmt, percent - fmt);
+		if (!*percent)
+			break;
+		fmt = percent + 1;
+		switch (*fmt) {
+		case '%':
+			strbuf_addstr(&munged_fmt, "%%");
+			fmt++;
+			break;
+		case 'z':
+			strbuf_addf(&munged_fmt, "%+05d", tz_offset);
+			fmt++;
+			break;
+		case 'Z':
+			if (tz_name) {
+				strbuf_addstr(&munged_fmt, tz_name);
+				fmt++;
+				break;
+			}
+			/* FALLTHROUGH */
+		default:
+			strbuf_addch(&munged_fmt, '%');
+		}
+	}
+	fmt = munged_fmt.buf;
+
 	strbuf_grow(sb, hint);
 	len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
 
@@ -804,17 +838,16 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
 		 * output contains at least one character, and then drop the extra
 		 * character before returning.
 		 */
-		struct strbuf munged_fmt = STRBUF_INIT;
-		strbuf_addf(&munged_fmt, "%s ", fmt);
+		strbuf_addch(&munged_fmt, ' ');
 		while (!len) {
 			hint *= 2;
 			strbuf_grow(sb, hint);
 			len = strftime(sb->buf + sb->len, sb->alloc - sb->len,
 				       munged_fmt.buf, tm);
 		}
-		strbuf_release(&munged_fmt);
 		len--; /* drop munged space */
 	}
+	strbuf_release(&munged_fmt);
 	strbuf_setlen(sb, sb->len + len);
 }
 
diff --git a/strbuf.h b/strbuf.h
index 80047b1bb7..39d5836abd 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -339,9 +339,14 @@ __attribute__((format (printf,2,0)))
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 /**
- * Add the time specified by `tm`, as formatted by `strftime`.
- */
-extern void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm);
+ * Add the time specified by `tm`, as formatted by `strftime`.  `tz_offset`
+ * and `tz_name` are used to expand %z and %Z internally, unless `tz_name`
+ * is NULL.  `tz_offset` is in decimal hhmm format, e.g. -600 means six
+ * hours west of Greenwich.
+ */
+extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
+			    const struct tm *tm, int tz_offset,
+			    const char *tz_name);
 
 /**
  * Read a given size of data from a FILE* pointer to the buffer.
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 42d4ea61ef..71082008f0 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -51,6 +51,12 @@ check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
 check_show raw-local "$TIME" '1466000000 +0000'
 check_show unix-local "$TIME" '1466000000'
 
+check_show 'format:%z' "$TIME" '+0200'
+check_show 'format-local:%z' "$TIME" '+0000'
+check_show 'format:%Z' "$TIME" ''
+check_show 'format:%%z' "$TIME" '%z'
+check_show 'format-local:%%z' "$TIME" '%z'
+
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
 check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
-- 
2.13.0

