Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2ABC433FE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 08:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FA56120D
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 08:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhIPI5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbhIPI5B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 04:57:01 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC98BC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 01:55:40 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t190so6568611qke.7
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dyqCeu1PwLlkm0Rowq8Q0dtkwo/thkQcID4VsnWH0xk=;
        b=hj2Lx4jWUOmp23LDpkj/sqQPH7SnJ8Xvb2b2Ib4PGDycgGbnLw7aYtpeTYe8qfxG7z
         rpzI3iLvJOQhogJCovae8Yqj3+5XmSpmcUL/HCqHJkw28BLPve6Z2G78uhNx8qSUC3SU
         GOYZ66rvSIok0znkK1fWwFON6y26nr/XFXqjGnf4Ij5Rs4i38pUn50bALGHWDJgTlYvo
         TW/m/ehYZTS1i7VFrPupxknbfCVWewD45mgL59554nzaDttIhJjZ4th0Cu2YEXIl99og
         lhpmggFiMZI/mH2gwpwPeZEvf0yYkzkLFUuUfa9hgWIX87zCjxVjfCYFsGzI6MbkCq/f
         dCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyqCeu1PwLlkm0Rowq8Q0dtkwo/thkQcID4VsnWH0xk=;
        b=N/mVWvHwMlYbaoeZTpOn1bJcfy2W/Y5Wu9lJvBJsQOCsh09JDdvdn2J3NcaFdlW/9c
         44FHEnNYFdealcgEPm7yKQeH+FvTyw3RzVjLzVBcKJS2HlQxuZSPaQ+vWlTDHxULxHkK
         q3H98m0fdlWj+HbgU9gQpXfxcb/VMdhIJo9ZlGS8zEGwRptRv2M2AfRwUbq3Of3LcFyX
         rm7fBCpD+yCKPsbkJv5F8j4V0A6Kahz8Y8lEy+vJqlhB4rrS68oG5DF1NFRaijxEC0ll
         MJhEM23+TOucO9RJlIsi0Z+kYBVQsbR2DJTnJdPUsdIXhKt4F9sSJyvGREECBMBIJpe2
         aJ2A==
X-Gm-Message-State: AOAM532XIwd9ucdfEy+C+upZj4msAKxf8PSmJAKUgbC3ZrB1qX+7qoA9
        +JtfrM8zRgdzrXidkizquznDKsTSj7w=
X-Google-Smtp-Source: ABdhPJxOUKQ249mRLrLA3Sos74CkmWcWRdYELwLga7qkm2Ax+ZTqzBCiU+Ldo88FPrW/HfINw1PU0g==
X-Received: by 2002:a05:620a:bc5:: with SMTP id s5mr3961717qki.47.1631782539938;
        Thu, 16 Sep 2021 01:55:39 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id e22sm1663868qtm.10.2021.09.16.01.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 01:55:39 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 2/2] t0000: avoid masking git exit value through pipes
Date:   Thu, 16 Sep 2021 01:55:23 -0700
Message-Id: <20210916085523.68581-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210916085523.68581-1-carenas@gmail.com>
References: <20210916023706.55760-1-carenas@gmail.com>
 <20210916085523.68581-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

9af0b8dbe2 (t0000-basic: more commit-tree tests., 2006-04-26) adds
tests for commit-tree that mask the return exit from git as described
in a378fee5b07 (Documentation: add shell guidelines, 2018-10-05).

Fix the tests, to avoid pipes by using a temporary file instead.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2:
* avoid changing some of the code as suggested by Taylor
* no need for pipes or stdin redirection as suggested by Junio

 t/t0000-basic.sh | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)y

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index cb87768513..5c342de713 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1271,28 +1271,29 @@ P=$(test_oid root)
 
 test_expect_success 'git commit-tree records the correct tree in a commit' '
 	commit0=$(echo NO | git commit-tree $P) &&
-	tree=$(git show --pretty=raw $commit0 |
-		 sed -n -e "s/^tree //p" -e "/^author /q") &&
+	git show --pretty=raw $commit0 >out &&
+	tree=$(sed -n -e "s/^tree //p" -e "/^author /q" out) &&
 	test "z$tree" = "z$P"
 '
 
 test_expect_success 'git commit-tree records the correct parent in a commit' '
 	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
-	parent=$(git show --pretty=raw $commit1 |
-		sed -n -e "s/^parent //p" -e "/^author /q") &&
+	git show --pretty=raw $commit1 >out &&
+	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" out) &&
 	test "z$commit0" = "z$parent"
 '
 
 test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
-	     parent=$(git show --pretty=raw $commit2 |
-		sed -n -e "s/^parent //p" -e "/^author /q" |
-		sort -u) &&
+	git show --pretty=raw $commit2 >out &&
+	cat >match.sed <<-\EOF &&
+	s/^parent //p
+	/^author /q
+	EOF
+	parent=$(sed -n -f match.sed out | sort -u) &&
 	test "z$commit0" = "z$parent" &&
-	numparent=$(git show --pretty=raw $commit2 |
-		sed -n -e "s/^parent //p" -e "/^author /q" |
-		wc -l) &&
-	test $numparent = 1
+	git show --pretty=raw $commit2 >out &&
+	test_stdout_line_count = 1 sed -n -f match.sed out
 '
 
 test_expect_success 'update-index D/F conflict' '
-- 
2.33.0.481.g26d3bed244

