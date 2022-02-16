Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC401C433FE
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiBPIOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:14:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBPIOg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:14:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E05254A7D
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n8so701641wms.3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8urM7VG877IDaNA72S3sLKTXReyCiarLAOHtJwnfa5Y=;
        b=Vz868hi/4yuso8mmQ+Jr9uH+EFh+83zkb3402lrnneR0sSyJBqacHbpUFTrMJteU7w
         La6gN5O2VsK3Ai9yZ8dG65YyBIi+8ZrM4Y11/+p1EhCKmjK7Rz1I8mcrcBgQ+CinVq8I
         MgfUGtZs6iHzmhiufx1hRI+lUB8gMoim4HauzRS/HW2WGaFgDCeN7ksu4LrLdUOctCJ0
         Azf59oG4j/eaDHGoJgdyNSBnmuE5TEltTXWuT0qJX1/4JJQGQbH0Q/s7d7JfOswmNO3T
         fpqsA+iKadd2Jv/5ECfbhGAdlFz5ib/PK9VbNqDa0wWH228aDm4ua5gtEgi8o/O3PzHc
         4p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8urM7VG877IDaNA72S3sLKTXReyCiarLAOHtJwnfa5Y=;
        b=i52bqb6y7ZXgXSeRet5U+J1iGOj+1b7CgdwxfkRVtC2Hrd3+XcTANzZuuSkClQBEl/
         KcPr7VKW4yn3LD2le719jEo4URWjLrfNaI63MOpT8UYnI8tKtlYc4u3Zk/n8Axo1PR2/
         djp5OsT6f6GYpO3HS3tvPiWK1Nw8is4y/OlsQpX9yZPmZUUWO+kx/YXNnLXHHjIk6m+N
         TdjjScnfXEYB3+vR8pV1aRTpWz2WdmySeVYyCH0/EBOsB3Uv0ZCLfadj9aM/4iRveo1G
         HKKBEl8ZTmNZpU0PC3fx49ryA3xb8wpuSUpdQinmzIfuafv5JI0BAEBqTJR9oTFQaUmw
         K8FQ==
X-Gm-Message-State: AOAM530CIibsf069DI5uHsrGobkLUoiRCMtY0Q6kmjuFvk+ta+PKboJE
        HT/yYbthbfHysx2djd8q5Oq/YLoibgpSvw==
X-Google-Smtp-Source: ABdhPJzij6eMizjEeDXmpbJ8pKGYid9zZKHWaEOf1sJ2Q0RbY6fp7yVT+YdiDemMl3DopAytBIUBpg==
X-Received: by 2002:a1c:3b06:0:b0:37b:bb14:1f87 with SMTP id i6-20020a1c3b06000000b0037bbb141f87mr448462wma.0.1644999258041;
        Wed, 16 Feb 2022 00:14:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b16sm26173443wrj.26.2022.02.16.00.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:14:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/5] date API: add and use a date_mode_release()
Date:   Wed, 16 Feb 2022 09:14:05 +0100
Message-Id: <patch-v3-5.5-b1ee9a30913-20220216T081203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
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

There is also a leak in "builtin/blame.c" due to its call to
parse_date_format() to parse the "blame.date" configuration. However
as it declares a file-level "static struct date_mode blame_date_mode"
to track the data, LSAN will not report it as a leak. It's possible to
get valgrind(1) to complain about it with e.g.:

    valgrind --leak-check=full --show-leak-kinds=all ./git -P -c blame.date=format:%Y blame README.md

But let's focus on things LSAN complains about, and are thus
observable with "TEST_PASSES_SANITIZE_LEAK=true". We should get to
fixing memory leaks in "builtin/blame.c", but as doing so would
require some re-arrangement of cmd_blame() let's leave it for some
other time.

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
index bbd6a6477b5..5d4eaba0a90 100644
--- a/date.h
+++ b/date.h
@@ -50,10 +50,17 @@ const char *show_date(timestamp_t time, int timezone, const struct date_mode *mo
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
2.35.1.1028.g2d2d4be19de

