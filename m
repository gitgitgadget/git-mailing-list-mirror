Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E94C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378428AbiBDXx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378340AbiBDXxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBCCC103DF8
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:53:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r17so4990180wrr.6
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cka9gv2FJRo33/y5IIOgigdh/JUPtSbkAPp0ahuz2e8=;
        b=gbHUgM033GeS/89/rdxRch38J6V2dI6B1UJOsBJ1oFKVFsOw/Lcwd8TfvsZ22vnhhN
         W+HBRZLDv9KW2BNbm2uHkQpLkfPQvvp+5PzPZBxKXoKZ6Z46SQihFdzxvzmlbCXaxxH+
         CPA+E2cT76lwSnocaNKcVf9osWmK8b+f7oZzeZ5rfwsFygh7g5zLiYCeX9qxr7EoYrXC
         iEmcN6Y0PMMq8KPADS5YzCmMeqE+kym653dRtIMwjryqZAl62Wa1yFwjY0pvIsGgMWeo
         AXKqLbokOUMhhgmWwgIR9e32WL2hozF6x+eqDnET5ygmhc804McKZm7u5BdV7Xkf+bVj
         5xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cka9gv2FJRo33/y5IIOgigdh/JUPtSbkAPp0ahuz2e8=;
        b=gy1wiAtchuFmtPfCiF9ILdZIVitcGzyYxvu/OXh+iud3n+QUfJx8OYNk/9/XaO8N7x
         d82o6TC3owkUn/QvJ8tBfFgeTPqhwoFTYTO5aH7GvpCHcphGctbI3TP9+uQjtdEtbhW8
         ZaSpEhWYvvT+uy5gfHtH5VFOhMzVWbaZ4Ix94Uc7uR6TFmYWsCM/H15uUd89gH5Y67zP
         f45NU1WWyC4FD8Qnm8hbyqceF+aeHbwi1CZ9cChV8wPi1f/a27VprxV/NKSa/yq3/zsJ
         Rdh606ws9pQebm+rsi9s6Biy6Bfo4pXoy86I/h1O1q1JaQhT9/CESHwsPwBQHEaoU3uh
         Wcjw==
X-Gm-Message-State: AOAM532kIsHC/HtpSS7gyze5xRinsOUBBx7Z36tDv6/yyp+AgRALVvgw
        XhED1UqBk59DnxEEDVADCFoRe4DWXk+9sQ==
X-Google-Smtp-Source: ABdhPJz6MpHCP/G/aBiwBAfzINgAnzcNWNdVqSfOlyEnNZm37jpBb3L1QK1EJIcmllgPRfNIXiK0qg==
X-Received: by 2002:a05:6000:1b88:: with SMTP id r8mr1004856wru.447.1644018793509;
        Fri, 04 Feb 2022 15:53:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm3304507wrw.5.2022.02.04.15.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:53:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] date API: add and use a date_mode_release()
Date:   Sat,  5 Feb 2022 00:53:06 +0100
Message-Id: <patch-v2-5.5-60dbadacb16-20220204T235143Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
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
2.35.1.940.ge7a5b4b05f2

