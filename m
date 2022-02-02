Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D9AC433FE
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbiBBVEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbiBBVEK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:04:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F5C06173D
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:04:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j16so807540wrd.8
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdrA1i03uMFX8QjrER4L3h//cvONLC6Yv+rs96/JiGs=;
        b=pAbYEQ8E5rtz3LtMgpEjvZ2EP6dyLX8EPByfHcqZmuYKJHBytOWQlalTZqno5dW/Sb
         7JzXgkrC62UfKrREw+nZN20mUPoCGXcrHW7JVBlXYbyK+n+fxPkZF1eO/gPXCLYztMcd
         Y+jgXlNDR37o95H2O9yc9k4Mw6fQyxnWfq1MhXxQJi6piATvRHelptb6ogspyi+3wtPR
         jhqBjXTuDzQh+JycjJ1pB3Hr55gp6pZaevbq9Aqqs/rEfV6KvuQbOosiDgniHZkeWAdZ
         9ANkqnXPUi5kZF5FoLP5Rq0CivTM36t3MOGAfZ+7crZO6x8W1obSZBCHLlKzHmPU6Whc
         U04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdrA1i03uMFX8QjrER4L3h//cvONLC6Yv+rs96/JiGs=;
        b=AFi229YHehLW9qgQG12jqslTshu9SldTj7tRv7AqD+t4x5bR1Jwk++CDboFMsZ47lY
         LpfQ0GhTqf/WymV7zN0iLKB7rdWPaSN3aYn4y7op+FLjOg4HgtmCqdjrq8dxxD4SwbYQ
         64cJmE2Fw3oiN71FlhJnkiEtlyoPwSEWQhpUXJCD4m7XMm7cf5axHfjgrY6ChVoA1JDk
         FJNRlw3UvZNGcYyaF37h6cKc3JdY7i3Eq2RoNKgEFSi4M6oDj/QilVBEOgfHGTEZAEJu
         Bf+Ub0aWRkGSCZOWHVcCvs0mHZHE/SkpnH2rtEK+Dz9KK6F3dgRHPj2K8zHETu+1PATB
         QqOQ==
X-Gm-Message-State: AOAM533vNuHhOVpAI467RtWQDq22n5eNwZuMGjgsbsGBiaM3U1DigzsC
        JEacOyOwHTO6OJfvWYjbjiXe0FfvwuXG0w==
X-Google-Smtp-Source: ABdhPJxm4eJP410gUlu9P2ilx//D/oywA8Sygz8JsIbkWU20mE7s1LCXW3doAkufrujl2pjzA9lDgg==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr26352805wrp.52.1643835848589;
        Wed, 02 Feb 2022 13:04:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm17264592wry.50.2022.02.02.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:04:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] date API: add and use a date_mode_release()
Date:   Wed,  2 Feb 2022 22:03:53 +0100
Message-Id: <patch-5.5-b67e23549ed-20220202T195651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.920.g34be1f84792
In-Reply-To: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net> <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in the parse_date_format() function by providing a
new date_mode_release() companion function.

By using this in "t/helper/test-date.c" we can mark the
"t0006-date.sh" test as passing when git is compiled with
SANITIZE=leak, and whitelist it to run under
"GIT_TEST_PASSING_SANITIZE_LEAK=true" by adding
"TEST_PASSES_SANITIZE_LEAK=true" to the test itself.

The other tests that expose this memory leak (i.e. take the
"mode->type == DATE_STRFTIME" branch in parse_date_format()) are
"t6300-for-each-ref.sh" and "t7004-tag.sh". The former is due to an
easily fixed leak in "ref-filter.c", and brings the failures in
"t6300-for-each-ref.sh" down from 51 to 48.

Fixing the remaining leaks will have to wait until there's a
release_revisions() in "revision.c", as they have to do with leaks via
"struct rev_info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 date.c               | 5 +++++
 date.h               | 9 ++++++++-
 ref-filter.c         | 1 +
 t/helper/test-date.c | 2 ++
 t/t0006-date.sh      | 2 ++
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 54c709e4a08..68a260c214d 100644
--- a/date.c
+++ b/date.c
@@ -993,6 +993,11 @@ void parse_date_format(const char *format, struct date_mode *mode)
 		die("unknown date format %s", format);
 }
 
+void date_mode_release(struct date_mode *mode)
+{
+	free((char *)mode->strftime_fmt);
+}
+
 void datestamp(struct strbuf *out)
 {
 	time_t now;
diff --git a/date.h b/date.h
index 4ed83506de9..bfcd4eb458c 100644
--- a/date.h
+++ b/date.h
@@ -49,10 +49,17 @@ const char *show_date(timestamp_t time, int timezone, const struct date_mode *mo
  *
  * When the "date_mode_type" is DATE_STRFTIME the "strftime_fmt"
  * member of "struct date_mode" will be a malloc()'d format string to
- * be used with strbuf_addftime().
+ * be used with strbuf_addftime(), in which case you'll need to call
+ * date_mode_release() later.
  */
 void parse_date_format(const char *format, struct date_mode *mode);
 
+/**
+ * Release a "struct date_mode", currently only required if
+ * parse_date_format() has parsed a "DATE_STRFTIME" format.
+ */
+void date_mode_release(struct date_mode *mode);
+
 void show_date_relative(timestamp_t time, struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
diff --git a/ref-filter.c b/ref-filter.c
index 3399bde932f..7838bd22b8d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1276,6 +1276,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 		goto bad;
 	v->s = xstrdup(show_date(timestamp, tz, &date_mode));
 	v->value = timestamp;
+	date_mode_release(&date_mode);
 	return;
  bad:
 	v->s = xstrdup("");
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 111071e1dd1..45951b1df87 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -54,6 +54,8 @@ static void show_dates(const char **argv, const char *format)
 
 		printf("%s -> %s\n", *argv, show_date(t, tz, &mode));
 	}
+
+	date_mode_release(&mode);
 }
 
 static void parse_dates(const char **argv)
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 794186961ee..2490162071e 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test date parsing and printing'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # arbitrary reference time: 2009-08-30 19:20:00
-- 
2.35.0.913.g12b4baa2536

