Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C2C1F463
	for <e@80x24.org>; Sun, 22 Sep 2019 18:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbfIVSBu (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 14:01:50 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42421 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbfIVSBt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 14:01:49 -0400
Received: by mail-wr1-f49.google.com with SMTP id n14so11488443wrw.9
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hOOuxxFjKXrp2z3PIxk2zH5zz3r+VTR9DlLDjEN4Hm0=;
        b=MY1YZWlzqecDaalHRTkM+oMMJkHFYCjHRmHaBqsoGCXAmQJolO5im1TipKgryUDAwQ
         C9vUnRHogTSSjfSzkRxw3qhT/VJsY5CC1ZUuOGEvhnTCbgDrAZeL+CTJWHNDroFxZI4L
         ZBMlWxyQw4iT63TGYSbeScB1n8CnPrZmrxqQjHARG5KdPv06S9UyfNVt8XI5FrmdcU5t
         m37oM6/JCSeqkD4n70UdWdaQIO5M4+RM4QVDwtntCAdQ19rb+F7+i5U9Vit6XvdRe88/
         4BqrCO2wAbhvT8YlMx8nosJWwFCPRQO6xVMUk1pDPZ6gyiAKTiufpS/8eYvu+BHAWrQ3
         DFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hOOuxxFjKXrp2z3PIxk2zH5zz3r+VTR9DlLDjEN4Hm0=;
        b=ZNELJjazPPT9Dzx3BvuTIQAyFcazJC+WXprM69dNvX5zR4Y8/AYF00KcIFQul4FBKG
         o0fv6a+L0atFt0M/onKRf28QMo0qvVixOHiseHAWt1tcJKN/TCRXkxeOQko5Pf4xwyiL
         V+8t5c2R1GR5CTwhDLUfONw2ilqw+8hTUCDAKX76Orp58cZ8jUDheHxFBzPqoHLJzbOq
         JhJQTCMFoTUHFuM1a9ioPXmNNYhh560SqSGSP0bp7WHrglJ0fx5NBis5Qdh3dUaKHZOq
         7kZJT1NzsJ5dWS8gZEmrZ6hveDEI+6OobEJ7mmiqRtO1iYmMPZB6HpfhZRHz1//0xy1W
         eLLg==
X-Gm-Message-State: APjAAAWF4AUrvCtV8AOy3tiHtp7NROF252rtlEisR+bzFvO7+apdprGK
        jHz6bDfUhIKVov9XSXIg+dY=
X-Google-Smtp-Source: APXvYqzTMgiciVsaCMAldC34FceHi8NNDXTK9nqyQ6BXzUg2dkt0nft4SiiX7v5UYbN94vNCL53RcA==
X-Received: by 2002:a5d:40d2:: with SMTP id b18mr19047710wrq.4.1569175307470;
        Sun, 22 Sep 2019 11:01:47 -0700 (PDT)
Received: from localhost.localdomain (x4dbd3787.dyn.telefonica.de. [77.189.55.135])
        by smtp.gmail.com with ESMTPSA id 33sm10687017wra.41.2019.09.22.11.01.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Sep 2019 11:01:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] name-rev: avoid cutoff timestamp underflow
Date:   Sun, 22 Sep 2019 20:01:43 +0200
Message-Id: <20190922180143.25026-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.597.gb58f4577a1
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

Check whether substacting the slop from the oldest committer date
would lead to an underflow, and use a 0 as cutoff in that case.  This
way it will handle commits shortly after the epoch even if we were to
switch to a signed 'timestamp_t' (but then we'll have to worry about
signed underflow for very old commits).

Note that the type of the cutoff timestamp variable used to be signed
before 5589e87fd8 (name-rev: change a "long" variable to timestamp_t,
2017-05-20).  The behavior was still the same even back then, but the
underflow didn't happen when substracting the slop from the oldest
committer date, but when comparing the signed cutoff timestamp with
unsigned committer dates in name_rev().  IOW, this underflow bug is as
old as 'git name-rev' itself.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

This patch adds a test at the end of 't6120-describe.sh', so it will
conflict with my non-recursive name-rev patch series, which adds a
test there as well, but the conflict should be wasy to resolve.

  https://public-inbox.org/git/20190919214712.7348-7-szeder.dev@gmail.com/

 builtin/name-rev.c  | 15 ++++++++++++---
 t/t6120-describe.sh | 15 +++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c785fe16ba..a4d8d312ab 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -9,7 +9,11 @@
 #include "sha1-lookup.h"
 #include "commit-slab.h"
 
-#define CUTOFF_DATE_SLOP 86400 /* one day */
+/*
+ * One day.  See the 'name a rev close to epoch' test in t6120 when
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
+		if (cutoff - CUTOFF_DATE_SLOP < cutoff)
+			cutoff = cutoff - CUTOFF_DATE_SLOP;
+		else
+			cutoff = 0;
+	}
 	for_each_ref(name_ref, &data);
 
 	if (transform_stdin) {
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 2b883d8174..965e633c32 100755
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
+	near_commit_oid=$(git rev-parse HEAD) &&
+
+	echo "$near_commit_oid no-timestamp-underflow" >expect &&
+	git name-rev $near_commit_oid >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.23.0.597.gb58f4577a1

