Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1FC20401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbdFXMPI (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:15:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34060 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFXMPH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:15:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so18867928wrc.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pkpzvx9Hx28lvegMXcr3XJHnYGFlX7ZGae3nKDDJYmY=;
        b=HCiPIwPEgMkLMbmtBRojw6tG18aXJf7qAvulKTMQS1H7WSUkByRXM9KeN9tDmNKrC8
         J2+cMmvft0hJmAkafcGsgWWlKanOanFq0EgpYZAZGv0I16MUvOxNR+Mt16enFop7QY7H
         2lZepwdi07uEya9jTKnNgq3LZz2iWJ/KnagEWkCSthIkMKgwr5Z7qiJb6ZpXlJjkaAuQ
         Op7LrIrDdzubi7EIY67+30mMlS81fRGc5rw2kG3m0G+bLnysTE/M9ETJr5xTH1BGD/sy
         Q9fJPcNVe5+Is9IZ26HlHu+ginLH0LLJ+g+ls/LH3DngZfGynoaP21cXvu98P6MFIJ1D
         6rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pkpzvx9Hx28lvegMXcr3XJHnYGFlX7ZGae3nKDDJYmY=;
        b=Y8VLwImgBaQ+Wboj8fIId20hCGdZ2u4CN/Fa+ntsBEwwcVK2oIUKMArBtDQ3Qw22xw
         4BpkEbOdZo3LE2xZ1haWl31sWoyy6BgN9HcRq382cFe9A3Td64LIyQvBA/t0ZAPanwyh
         7RJX5ErcOlTX2Dbvp/xKUN2D/yPLR4h0HGORgOpiLPwf2M+oAFirpj5C0TwZT4wH2l0d
         37w0lwYgTBnu8P5XOVGtY7ojN9Gda7yWNqPy5CLO4zdkPnV1oiVkSn7gdId1+ygF4Rov
         4IT1EX5miBL98Zy6jxpqPmMPAz2NiuRxc4/bKGeakOy0LICZi5E9mWIXlMMjGaqvglZx
         qGFA==
X-Gm-Message-State: AKS2vOy7TlwH8fPt858ne7rg3N+1SPm0bEc3WJRYZaTbP1lPazdixFLZ
        CenS9HhqCy04VX7UTxE=
X-Received: by 10.80.142.143 with SMTP id w15mr9482288edw.34.1498306505871;
        Sat, 24 Jun 2017 05:15:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e22sm302062edd.26.2017.06.24.05.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 05:15:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 2/2] strbuf: change an always NULL/"" strbuf_addftime() param to bool
Date:   Sat, 24 Jun 2017 12:14:52 +0000
Message-Id: <20170624121452.7952-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170624121452.7952-1-avarab@gmail.com>
References: <20170624121452.7952-1-avarab@gmail.com>
In-Reply-To: <20170624121023.2636-2-avarab@gmail.com>
References: <20170624121023.2636-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the code for deciding what's to be done about %Z to stop
passing always either a NULL or "" char * to
strbuf_addftime(). Instead pass a boolean int to indicate whether the
strftime() %Z format should be suppressed by converting it to an empty
string, which is what this code is actually doing.

This code grew organically between the changes in 9eafe86d58 ("Merge
branch 'rs/strbuf-addftime-zZ'", 2017-06-22). The intent was to use
this API in the future to pass a custom leave the door open to pass a
custom timezone name to the function (see my [1] and related
messages).

But that's not what this code does now, and this strbuf_addstr() call
always being redundant makes it hard to understand the current
functionality. So simplify this internal API to match its use, we can
always change it in the future if it gets a different use-case.

1. CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com
   (https://public-inbox.org/git/CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sat, Jun 24, 2017 at 2:10 PM, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Thanks. Docs fixed per your suggestion. I sent a v4 of 1/2 too, but
> that's unchanged, just thought it was simpler than having just one
> patch have a v4...

Urgh, mistake on my end, sent v3 again as v4. Here's v5 with the
*actual* fixes. Sorry.

 date.c   | 2 +-
 strbuf.c | 5 ++---
 strbuf.h | 5 +++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/date.c b/date.c
index 1fd6d66375..c3e673fd04 100644
--- a/date.c
+++ b/date.c
@@ -256,7 +256,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else if (mode->type == DATE_STRFTIME)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
-				mode->local ? NULL : "");
+				!mode->local);
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
diff --git a/strbuf.c b/strbuf.c
index be3b9e37b1..89e40bb496 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -786,7 +786,7 @@ char *xstrfmt(const char *fmt, ...)
 }
 
 void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
-		     int tz_offset, const char *tz_name)
+		     int tz_offset, int suppress_tz_name)
 {
 	struct strbuf munged_fmt = STRBUF_INIT;
 	size_t hint = 128;
@@ -815,8 +815,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 			fmt++;
 			break;
 		case 'Z':
-			if (tz_name) {
-				strbuf_addstr(&munged_fmt, tz_name);
+			if (suppress_tz_name) {
 				fmt++;
 				break;
 			}
diff --git a/strbuf.h b/strbuf.h
index 6708cef0f9..9262615ca0 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -343,11 +343,12 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
  * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
  * of Greenwich, and it's used to expand %z internally.  However, tokens
  * with modifiers (e.g. %Ez) are passed to `strftime`.
- * `tz_name` is used to expand %Z internally unless it's NULL.
+ * `suppress_tz_name`, when set, expands %Z internally to the empty
+ * string rather than passing it to `strftime`.
  */
 extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
 			    const struct tm *tm, int tz_offset,
-			    const char *tz_name);
+			    int suppress_tz_name);
 
 /**
  * Read a given size of data from a FILE* pointer to the buffer.
-- 
2.13.1.611.g7e3b11ae1

