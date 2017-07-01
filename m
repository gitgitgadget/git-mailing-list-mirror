Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 171E420209
	for <e@80x24.org>; Sat,  1 Jul 2017 13:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbdGANQT (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 09:16:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36476 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbdGANQS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 09:16:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id y5so12392468wmh.3
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hdmGl2GL6ajTjyInSPpX6u5+PDrNubqe8ntpJ8xZLew=;
        b=DHxZAIKKUTCWw9hGzmU/qmT8aZNWoNf9eqI8mEYOl7CcVKdwzip4ohVzePgzqHdSro
         M9NywRkHWBRrP6EDFDQUFxy5VZFiT8TSGCVGHb+Uav/+6u1EkFGH5gCIwmf0Gw5yyGwo
         tFGY8W0BaCxLX3jbOaVNkukazDVxyRR9E2g/kR+E9LhlBYdjp8bnCreHiUX2qtqspVEn
         kEsULL9Oqw59yqzjYzx6L0qcVgd/wfYiKQoMTPQW3yYHvRTr6mQQ5NKRSPImkzk8Pa+c
         ML1oDM8w/ZqK8EoolmizK2bF4wkKc4hNPJ1rh/Zxy+PZrh+qDYTi9TxQwcetYmZi7wBX
         XXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hdmGl2GL6ajTjyInSPpX6u5+PDrNubqe8ntpJ8xZLew=;
        b=GWb8Hyy844MgJ3S+wFAPcb4eLu5fVeB0LyhXm9HQp5TjvdlRYPVhCkwBHs4/R6BRxy
         uP+zakKjnKA5x9fGuKh58oxf1dhDzeIs4mYmTKkqtH6nTQC3Dm23EH4EhZsHQv2+3Ru/
         Ux66oq7Zerrr6+W6g39grhYooXiW3Mt3hLmIBIilYaS9lb/f/9XonFJLwbsEWfNz0rGL
         UVlBmoWjtTgGnApAL3JWilY9J+o/ngAZS/5OSZ1ATw8OE3LCBdFZbjbyNZdQN3acYI05
         5FYRUud+oeiefSx+S5RjCgbikK/mUdaRH4ZuDIvw7m/daj9/rxntqioOrvBnVgr25aFj
         zDmg==
X-Gm-Message-State: AKS2vOwDvX2T07NMWNDGiIBbroNBVQPkBi7LzpG1eKzJTLQl29LIQovQ
        fryqSsbPOmuQYEPAZtw=
X-Received: by 10.80.153.52 with SMTP id k49mr8857265edb.63.1498914976503;
        Sat, 01 Jul 2017 06:16:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c56sm4537622ede.21.2017.07.01.06.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 06:16:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 2/2] strbuf: change an always NULL/"" strbuf_addftime() param to bool
Date:   Sat,  1 Jul 2017 13:15:47 +0000
Message-Id: <20170701131547.973-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170701131547.973-1-avarab@gmail.com>
References: <20170701131547.973-1-avarab@gmail.com>
In-Reply-To: <10b2f9ba-89d1-851d-bf3c-bf70abebc8a7@web.de>
References: <10b2f9ba-89d1-851d-bf3c-bf70abebc8a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_addftime() allows callers to pass a time zone name for
expanding %Z. The only current caller either passes the empty string
or NULL, in which case %Z is handed over verbatim to strftime(3).
Replace that string parameter with a flag controlling whether to
remove %Z from the format specification. This simplifies the code.

Commit-message-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sat, Jul 01 2017, René Scharfe jotted:

> Am 01.07.2017 um 14:55 schrieb Ævar Arnfjörð Bjarmason:
>> strbuf_addstr() allows callers to pass a time zone name for expanding
>   ^^^^^^^^^^^^^^^
> That should be "strbuf_addftime()" instead (my typo), as Junio noted.

Oops. Fixed.

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
index c4e91a6656..89d22e3b09 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -779,7 +779,7 @@ char *xstrfmt(const char *fmt, ...)
 }
 
 void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
-		     int tz_offset, const char *tz_name)
+		     int tz_offset, int suppress_tz_name)
 {
 	struct strbuf munged_fmt = STRBUF_INIT;
 	size_t hint = 128;
@@ -808,8 +808,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
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
index 6809d7daa8..2075384e0b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -337,11 +337,12 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
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

