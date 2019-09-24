Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF38C1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 07:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438442AbfIXHcT (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 03:32:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35369 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391594AbfIXHcS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 03:32:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id y21so838967wmi.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3aozaoX8r8MZQVlxUY7oVk35Wzs2QLfAc0WYPpOVkwQ=;
        b=vbiR66OCK+S7be3dYYayNyLerunBYp1viCYnt007kFsuRifEspuAUNbvLc67bvgx1v
         9e+qhEZvWr1URk39NIdjRshetz7TI9IEKx4THR0iNavTBJezeCE8ra4VB7yyCn/C0Xf3
         N7H9mh2dFuyQg9XCOlsH0ReC6IiLGBea+vZ8g2gOXK2TuevPAUb5Uv8PiUNjgUQzae37
         xSfj7MfiQ7We7S/ymFgFUpNHigQqkUJ0jXxG2ijHXiyQB4Qim30/R/gjRV6UfBR50cJ9
         OqmkwrAKwJVH7zGeAEJVJuy6qybpJJ8KNMha7126hH9hqg1bX875FQLlqHdqGwFrqbjP
         PNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aozaoX8r8MZQVlxUY7oVk35Wzs2QLfAc0WYPpOVkwQ=;
        b=SKt2H3ejudoj5i99NoNTmS427GCCSHiRveuPVMIIrneIh9iqNQIp7eVKeatkdE1hL6
         fyACKkGeiw/rEjJ//qWGSgzJK+kKZNkDHIBPwSviqkq+p0Q0aYD8MaFm6VxZvIGjER4K
         liaISyGyJZImMVnlEVts0gjl3lsyKmOj0/PAXu6AmBi16eZfyQnTMBPdk/XcRf3FM1bd
         2Nn046l59fiT9pRX3hcI0KwKuN1hVDyo63/FVZhmK/IJXhpiQbwAr8YGP2nsyVIGjk9i
         6pkinBg+6V/pYsSaP+vqEa3pkrHku+e0fhpeIbecZ03CVN9TLq9kuHLaGjMN4anIUuZW
         jYTg==
X-Gm-Message-State: APjAAAW3cYNSk33Ek03YSRnibJrgOgeq7xiZ0b8zTYVY/yadwn6cAEeC
        78+2xjv3jkXNjdsbpPhfvcM=
X-Google-Smtp-Source: APXvYqybVu9oilPgdjPqhEkhI7qeEu/3tibbrnskp9jx+GqIamMnrJt50xotVx+BwIp/Fo+bK48lfA==
X-Received: by 2002:a1c:c589:: with SMTP id v131mr1373887wmf.163.1569310336717;
        Tue, 24 Sep 2019 00:32:16 -0700 (PDT)
Received: from localhost.localdomain (x4dbd468e.dyn.telefonica.de. [77.189.70.142])
        by smtp.gmail.com with ESMTPSA id w125sm1737309wmg.32.2019.09.24.00.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 00:32:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] name-rev: avoid cutoff timestamp underflow
Date:   Tue, 24 Sep 2019 09:32:13 +0200
Message-Id: <20190924073213.7125-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.597.gb58f4577a1
In-Reply-To: <20190922180143.25026-1-szeder.dev@gmail.com>
References: <20190922180143.25026-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 'git name-rev' is invoked with commit-ish parameters, it tries to
save some work, and doesn't visit commits older than the committer
date of the oldest given commit minus a one day worth of slop.  Since
our 'timestamp_t' is an unsigned type, this leads to a timestamp
underflow when the committer date of the oldest given commit is within
a day of the UNIX epoch.  As a result the cutoff timestamp ends up
far-far in the future, and 'git name-rev' doesn't visit any commits,
and names each given commit as 'undefined'.

Check whether subtracting the slop from the oldest committer date
would lead to an underflow, and use no cutoff in that case.  We don't
have a TIME_MIN constant, dddbad728c (timestamp_t: a new data type for
timestamps, 2017-04-26) didn't add one, so do it now.

Note that the type of the cutoff timestamp variable used to be signed
before 5589e87fd8 (name-rev: change a "long" variable to timestamp_t,
2017-05-20).  The behavior was still the same even back then, but the
underflow didn't happen when substracting the slop from the oldest
committer date, but when comparing the signed cutoff timestamp with
unsigned committer dates in name_rev().  IOW, this underflow bug is as
old as 'git name-rev' itself.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
Range-diff:
1:  3bef6bdf7b ! 1:  b053181af9 name-rev: avoid cutoff timestamp underflow
    @@ Commit message
         far-far in the future, and 'git name-rev' doesn't visit any commits,
         and names each given commit as 'undefined'.
     
    -    Check whether substacting the slop from the oldest committer date
    -    would lead to an underflow, and use a 0 as cutoff in that case.  This
    -    way it will handle commits shortly after the epoch even if we were to
    -    switch to a signed 'timestamp_t' (but then we'll have to worry about
    -    signed underflow for very old commits).
    +    Check whether subtracting the slop from the oldest committer date
    +    would lead to an underflow, and use no cutoff in that case.  We don't
    +    have a TIME_MIN constant, dddbad728c (timestamp_t: a new data type for
    +    timestamps, 2017-04-26) didn't add one, so do it now.
     
         Note that the type of the cutoff timestamp variable used to be signed
         before 5589e87fd8 (name-rev: change a "long" variable to timestamp_t,
    @@ Commit message
         unsigned committer dates in name_rev().  IOW, this underflow bug is as
         old as 'git name-rev' itself.
     
    +    Helped-by: Johannes Sixt <j6t@kdbg.org>
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      ## builtin/name-rev.c ##
    @@ builtin/name-rev.c
      
     -#define CUTOFF_DATE_SLOP 86400 /* one day */
     +/*
    -+ * One day.  See the 'name a rev close to epoch' test in t6120 when
    ++ * One day.  See the 'name a rev shortly after epoch' test in t6120 when
     + * changing this value
     + */
     +#define CUTOFF_DATE_SLOP 86400
    @@ builtin/name-rev.c: int cmd_name_rev(int argc, const char **argv, const char *pr
     -		cutoff = cutoff - CUTOFF_DATE_SLOP;
     +	if (cutoff) {
     +		/* check for undeflow */
    -+		if (cutoff - CUTOFF_DATE_SLOP < cutoff)
    ++		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
     +			cutoff = cutoff - CUTOFF_DATE_SLOP;
     +		else
    -+			cutoff = 0;
    ++			cutoff = TIME_MIN;
     +	}
      	for_each_ref(name_ref, &data);
      
      	if (transform_stdin) {
     
    + ## git-compat-util.h ##
    +@@ git-compat-util.h: typedef uintmax_t timestamp_t;
    + #define PRItime PRIuMAX
    + #define parse_timestamp strtoumax
    + #define TIME_MAX UINTMAX_MAX
    ++#define TIME_MIN 0
    + 
    + #ifndef PATH_SEP
    + #define PATH_SEP ':'
    +
      ## t/t6120-describe.sh ##
     @@ t/t6120-describe.sh: test_expect_success 'describe complains about missing object' '
      	test_must_fail git describe $ZERO_OID
    @@ t/t6120-describe.sh: test_expect_success 'describe complains about missing objec
     +	# in builtin/name-rev.c.
     +	GIT_COMMITTER_DATE="@1234 +0000" \
     +	git commit -m "committer date shortly after epoch" &&
    -+	near_commit_oid=$(git rev-parse HEAD) &&
    ++	old_commit_oid=$(git rev-parse HEAD) &&
     +
    -+	echo "$near_commit_oid no-timestamp-underflow" >expect &&
    -+	git name-rev $near_commit_oid >actual &&
    ++	echo "$old_commit_oid no-timestamp-underflow" >expect &&
    ++	git name-rev $old_commit_oid >actual &&
     +	test_cmp expect actual
     +'
     +

 builtin/name-rev.c  | 15 ++++++++++++---
 git-compat-util.h   |  1 +
 t/t6120-describe.sh | 15 +++++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c785fe16ba..b0f0776947 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -9,7 +9,11 @@
 #include "sha1-lookup.h"
 #include "commit-slab.h"
 
-#define CUTOFF_DATE_SLOP 86400 /* one day */
+/*
+ * One day.  See the 'name a rev shortly after epoch' test in t6120 when
+ * changing this value
+ */
+#define CUTOFF_DATE_SLOP 86400
 
 typedef struct rev_name {
 	const char *tip_name;
@@ -481,8 +485,13 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		add_object_array(object, *argv, &revs);
 	}
 
-	if (cutoff)
-		cutoff = cutoff - CUTOFF_DATE_SLOP;
+	if (cutoff) {
+		/* check for undeflow */
+		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
+			cutoff = cutoff - CUTOFF_DATE_SLOP;
+		else
+			cutoff = TIME_MIN;
+	}
 	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
diff --git a/git-compat-util.h b/git-compat-util.h
index f0d13e4e28..d2e884e46a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -344,6 +344,7 @@ typedef uintmax_t timestamp_t;
 #define PRItime PRIuMAX
 #define parse_timestamp strtoumax
 #define TIME_MAX UINTMAX_MAX
+#define TIME_MIN 0
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2b883d8174..45047d0a72 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -424,4 +424,19 @@ test_expect_success 'describe complains about missing object' '
 	test_must_fail git describe $ZERO_OID
 '
 
+test_expect_success 'name-rev a rev shortly after epoch' '
+	test_when_finished "git checkout master" &&
+
+	git checkout --orphan no-timestamp-underflow &&
+	# Any date closer to epoch than the CUTOFF_DATE_SLOP constant
+	# in builtin/name-rev.c.
+	GIT_COMMITTER_DATE="@1234 +0000" \
+	git commit -m "committer date shortly after epoch" &&
+	old_commit_oid=$(git rev-parse HEAD) &&
+
+	echo "$old_commit_oid no-timestamp-underflow" >expect &&
+	git name-rev $old_commit_oid >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.23.0.597.gb58f4577a1

