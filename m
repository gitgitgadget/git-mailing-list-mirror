Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC8120D09
	for <e@80x24.org>; Sat,  3 Jun 2017 10:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdFCKk6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 06:40:58 -0400
Received: from mout.web.de ([212.227.15.3]:64942 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751149AbdFCKk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 06:40:57 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lj88M-1dsvPN2iGE-00dIre; Sat, 03
 Jun 2017 12:40:39 +0200
Subject: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     Jeff King <peff@peff.net>, Ulrich Mueller <ulm@gentoo.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
Date:   Sat, 3 Jun 2017 12:40:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:e1CiTdEwLwi5zIVnyX+fCXOpiofOivOyjPh+IIfDvsUEmfMJXqP
 OZI90FTeUb0IqNfiEGurnJSfarmG0AfJ7VsMESrlbvxazo9QMLz7zkcuKp9AlE3n8Utx6q0
 CBTH5U19PsQjdVGAc0DNFb10Ta3uTrTpjwcLmEZ5GMDWf57cYRsQ1F5YMfzJR6FSgusJAcx
 TO9E2nQ8C8qfB6qLQv+DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rBhISjJ3ehc=:Oe4WAInX1IEjYQq95cjYzg
 YTpe9W74mj331zwlfwbVcEJvgf5mdTd+tH3xB1MyscKdNKPcdPkJtSKJlg+2OTd3M3MrY9MIk
 vBDlcWjDVqGGuqscpjjNi80CROkOApWneyXsR/0rirzf1MBYHgnezFQICr1lsyY+gWsPIoaV1
 qAxbbJjbBUy+CqwkB0B7D6LdNAtMed2IlHqmA9n/PL+A9f5hKNEeIhhHW9zzNRZi5MNeoHECL
 RloU//B/RXmd81Y1XYoFJ6CcgqM1GY60BjvNzQn2JQ8uMoe0ZabcUz6o42hBsUFejZsj7w/Yo
 QbFcHtNLpf3MiX4NNc1C2r7Jr6if55Pncu2D0nodanyLx+9kvD6nydBFQyGhs10eOGamZN/4z
 gDOkCsImI4PRMVDWbme1e1EFODTgQ5SgDoTBeCkYj4A3ITnAo4Mm6f0Qg1VXs7jJgAJpT/ubT
 PCrKslePDcP0oNuxP4nMwsZBJQf9KwpnA+FHJwtdYGnVMhLn/XZIf3O7ZeR2wsEBvraND4e8E
 vlL54gsKWmobWw3cNxULYt33J6yjv2D3ubenaVJC9AGraV3bXUpkLxWr5f40/E2A5CepdtbZD
 QbV6+ywbaseUiwiy+ymsx0Dckt1SvAD0JVpTq6DP8o9gPqXKw91m83plmqL7WVEHrdn69ZPhq
 NXBsUXJPk3Cl3cpSWTyc3qcAk8O4jeNu0xM6uNTYQL38T1VoahfvDP+tjXhuRX3tUzME6ke7y
 IvtcLLMDuZJogwM6/m5Dc6dnrj4c3en8jUM6yGPiOv6z9HuV1NU78/RgKAhVq4FoTLTsRoKN8
 8ybfLKX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no portable way to pass timezone information to strftime.  Add
parameters for timezone offset and name to strbuf_addftime and let it
handle the timezone-related format specifiers %z and %Z internally.
Callers can opt out by passing NULL as timezone name.

Use an empty string as timezone name in show_date (the only current
caller) for now because we only have the timezone offset in non-local
mode.  POSIX allows %Z to resolve to nothing in case of missing info.

Helped-by: Ulrich Mueller <ulm@gentoo.org>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Duplicates strbuf_expand to a certain extent, but not too badly, I
think.  Leaves the door open for letting strftime handle the local
case.

 date.c                     |  2 +-
 strbuf.c                   | 42 ++++++++++++++++++++++++++++++++++++++----
 strbuf.h                   | 11 ++++++++---
 t/t6006-rev-list-format.sh | 12 ++++++++++++
 4 files changed, 59 insertions(+), 8 deletions(-)

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
index 00457940cf..b880107370 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -785,14 +785,47 @@ char *xstrfmt(const char *fmt, ...)
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
+	if (tz_name) {
+		for (;;) {
+			const char *percent = strchrnul(fmt, '%');
+			strbuf_add(&munged_fmt, fmt, percent - fmt);
+			if (!*percent)
+				break;
+			fmt = percent + 1;
+			switch (*fmt) {
+			case '%':
+				strbuf_addstr(&munged_fmt, "%%");
+				fmt++;
+				break;
+			case 'z':
+				strbuf_addf(&munged_fmt, "%+05d", tz_offset);
+				fmt++;
+				break;
+			case 'Z':
+				strbuf_addstr(&munged_fmt, tz_name);
+				fmt++;
+				break;
+			default:
+				strbuf_addch(&munged_fmt, '%');
+			}
+		}
+		fmt = munged_fmt.buf;
+	}
+
 	strbuf_grow(sb, hint);
 	len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
 
@@ -804,17 +837,18 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
 		 * output contains at least one character, and then drop the extra
 		 * character before returning.
 		 */
-		struct strbuf munged_fmt = STRBUF_INIT;
-		strbuf_addf(&munged_fmt, "%s ", fmt);
+		if (fmt != munged_fmt.buf)
+			strbuf_addstr(&munged_fmt, fmt);
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
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index a1dcdb81d7..dc0bed8d90 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -483,4 +483,16 @@ test_expect_success 'unused %G placeholders are passed through' '
 	test_cmp expect actual
 '
 
+test_expect_success 'date format "%F %T %z" is the same as iso' '
+	git log -1 --format="%ad" --date=iso >expect &&
+	git log -1 --format="%ad" --date="format:%F %T %z" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'date format "%%z" expands to percent zed' '
+	echo "%z" >expect &&
+	git log -1 --format="%ad" --date="format:%%z" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.13.0
