Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E8720282
	for <e@80x24.org>; Fri, 23 Jun 2017 16:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753379AbdFWQgn (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 12:36:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35113 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdFWQgm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 12:36:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id z45so13821745wrb.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPALe4OwYvcwOkqzKQPGfxeud2yuHFqra4tPivrX4zc=;
        b=B4kKnQfUDEDPIeaw7eNnZ598wq97maycb+OxQqGkRPK7eU5OXAmzyNL6VAvLleqxlB
         tr6ZHcy6JEItXVMyaK1ECmYN3YPBgOqZhoHE/qu8YWCCa+3DdNTJpxJowMgaN8B32Pe5
         x3Hg+AtjZbSEVxCZfGYbInLN2hJTu2iLOIaToXQWIAsqVCfNmd7NOBdKdNucx7wIJniG
         1LNYsTJhyvQTXa/T9rnZLaePes6DgOdpd1qqb1nZO13J4zg5CcJ0p8nnhZz9/3JTI392
         jMG5g/cTvNiW6Zs0BpROiziiXVIUqTrVVFKKHLV166VQ75aOirf8SmjHdSHPivzV87af
         NtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPALe4OwYvcwOkqzKQPGfxeud2yuHFqra4tPivrX4zc=;
        b=ON/vJu98APAQZgf6YHAnErIQj6VgMHMwYDuSM18THhrTz68rQTj1GGtVXSAd30fU1m
         WkYNNRxJAuO4OaMkvxgeyG+GEqViB9dFQ8y+EQa0gu7Se/GsolgiIIcPTKxUBT0jqeP3
         fbOBAGLgH5k7sAF4IpaQaU3EEYCtZmFpbjF/ZwZt0/a4sbNIaR2L61I/xK9X4j8SCSHJ
         r6iM0FcNTxe4U4hAg2QXSlf3xXRtP2OZvhNevWKcNTmATGj2Rd0M9vNrAX8Ezlifneaf
         pfxP6NPJrVI2MqaKNhZoAFhrAi9CSUOt7pMVhQSURkJwP+s1IHKLneY+C0Yoj1xqPtyf
         x1eg==
X-Gm-Message-State: AKS2vOzetnJd09I83NopiT04e/yJm/4+FjLsHn3olxxoCz3PBdU7EW5m
        PmvR1hrxIi1rVfQ5JvA=
X-Received: by 10.80.181.15 with SMTP id y15mr6945198edd.109.1498235800052;
        Fri, 23 Jun 2017 09:36:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w26sm662070edw.24.2017.06.23.09.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 09:36:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH -v2] strbuf: change an always NULL/"" strbuf_addftime() param to bool
Date:   Fri, 23 Jun 2017 16:36:06 +0000
Message-Id: <20170623163606.27571-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170623152344.gdk4haizpziwryrd@sigill.intra.peff.net>
References: <20170623152344.gdk4haizpziwryrd@sigill.intra.peff.net>
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
strftime() %Z format should be expanded to an empty string, which is
what this code is actually doing.

This code grew organically between the changes in 9eafe86d58 ("Merge
branch 'rs/strbuf-addftime-zZ'", 2017-06-22) yielding an end result
that wasn't very readable.

Out of context it looked as though the call to strbuf_addstr() might
be adding a custom tz_name to the string, but actually tz_name would
always be "", so the call to strbuf_addstr() just to add an empty
string to the format was pointless.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I believe this addresses the comments in the thread so far. Also Re:
René's "why const?" in a2673ce4-5cf8-6b40-d4db-8e2a49518138@web.de:
Because tzname_from_tz isn't changed in the body of the function, only
read.

 date.c   | 2 +-
 strbuf.c | 5 ++---
 strbuf.h | 5 +++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/date.c b/date.c
index 1fd6d66375..17db07d905 100644
--- a/date.c
+++ b/date.c
@@ -256,7 +256,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else if (mode->type == DATE_STRFTIME)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
-				mode->local ? NULL : "");
+				mode->local);
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
diff --git a/strbuf.c b/strbuf.c
index be3b9e37b1..92b7bda772 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -786,7 +786,7 @@ char *xstrfmt(const char *fmt, ...)
 }
 
 void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
-		     int tz_offset, const char *tz_name)
+		     int tz_offset, const int tzname_from_tz)
 {
 	struct strbuf munged_fmt = STRBUF_INIT;
 	size_t hint = 128;
@@ -815,8 +815,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 			fmt++;
 			break;
 		case 'Z':
-			if (tz_name) {
-				strbuf_addstr(&munged_fmt, tz_name);
+			if (!tzname_from_tz) {
 				fmt++;
 				break;
 			}
diff --git a/strbuf.h b/strbuf.h
index 4559035c47..eba5d59a77 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -340,14 +340,15 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 /**
  * Add the time specified by `tm`, as formatted by `strftime`.
- * `tz_name` is used to expand %Z internally unless it's NULL.
  * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
  * of Greenwich, and it's used to expand %z internally.  However, tokens
  * with modifiers (e.g. %Ez) are passed to `strftime`.
+ * `tzname_from_tz` when set, means let `strftime` format %Z, instead
+ * of intercepting it and doing our own formatting.
  */
 extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
 			    const struct tm *tm, int tz_offset,
-			    const char *tz_name);
+			    const int omit_strftime_tz_name);
 
 /**
  * Read a given size of data from a FILE* pointer to the buffer.
-- 
2.13.1.611.g7e3b11ae1

