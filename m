Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84370C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 04:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFDC6140A
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 04:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhDUEPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 00:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhDUEP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 00:15:29 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB8BC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 21:14:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s20so5056648plr.13
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 21:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0e6Z/ukVEFYHLnmQowuXVwGHfx5zYS6U4br9HrFxaw=;
        b=hcM/15Pg96II1GxAAjOxqH6nuXLWSyitTv9L0ca5JJsaoOF0CvcvplddskYt4OmZWi
         F3O8ckjhny9nsmiFS232MOdseDzFtIPTkELC38b+MficbFGX6/VrRLdcQ81yr5x6yhry
         a6JYPJ/8GEKgxJZsjYxb/LCzdiUnH6msBHpuVNmtdymguISKnpySlAmAICq0L8p+aSn1
         BfTgdzQPZ20EmyYjggoOvpX1HktY51AC9mJgU8ozAByVgHGjkcMTfL4ll6+EbGNli3Z7
         Ogt0OEz3iqGz0JfIOUb2JBmQJBZDrVJzUc+4GoeFIu3nqDaQ0PPUnOJfHJ198QZgtG4Q
         OvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0e6Z/ukVEFYHLnmQowuXVwGHfx5zYS6U4br9HrFxaw=;
        b=Xq3wy0MOpVZ3/+v6SVZDH2R7xeym/FrUhmyRcgDymrQc7XGgnVK98l+Q9py8tSw5tl
         ooV5K7hRiKncJpnGuxcSUwlv6Oq6HNYx1KBspRpXe/1qfRxArS7BMCQA7KnjPtO2fKSa
         OVX7EAcMN+U7XDamd6Rj4GQ63m1biBO1fBQT9901IEF2kPIsjmFdy3rF2/PWaVdXpXRI
         Dfz7F2+2NPlGB/JXTBz1By03TCoZBgyU4Ye+dvWcNIxpeFtvVdIrD+w7t2VmRhDL3Yyw
         rHShbIdDHreYZzU1e1d+5hJWCg+e0i54i+1smEq+4aiRUIWS1t7AUa6Ma3s1CEVufSC2
         jHFg==
X-Gm-Message-State: AOAM531EGYkXjL9AscVNEGyBrFeQixdX3pUKADX1xpGsYunwNiDvOmXz
        8AgN0YJJGbGk0++pxF/qshY=
X-Google-Smtp-Source: ABdhPJyacu8nRNaeB4T+Xi/fbNnSO7qA4BwAR8BEOcHwUxelAoBoIK6608XFggjGW+ZPdYgkWb+/QQ==
X-Received: by 2002:a17:902:8d83:b029:e6:508a:7b8d with SMTP id v3-20020a1709028d83b02900e6508a7b8dmr32799157plo.18.1618978490648;
        Tue, 20 Apr 2021 21:14:50 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-78.three.co.id. [180.214.233.78])
        by smtp.gmail.com with ESMTPSA id t23sm577570pju.15.2021.04.20.21.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 21:14:50 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     trygveaa@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        chriscool@tuxfamily.org, Johannes.Schindelin@gmx.de,
        pranit.bauva@gmail.com, tanushreetumane@gmail.com,
        mirucam@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] test: add test for git bisect skip with --term* arguments
Date:   Wed, 21 Apr 2021 11:08:10 +0700
Message-Id: <20210421040808.14185-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210418151459.GC10839@aaberge.net>
References: <20210418151459.GC10839@aaberge.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trygve Aaberge reported the current git bisect breakage on [1].
After starting bisection with --term-new and --term-old arguments to git
bisect start, skipping with git bisect skip does not change HEAD as
expected.

Let's add the test to catch this breakage.

[1]: https://lore.kernel.org/git/20210418151459.GC10839@aaberge.net/

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

Changes from v1:
  * style changes requested by Junio
  * rename test script and edit test description to be more descriptive
  * remove exec </dev/null (I don't know what it means)
  * repo initialization is now on test_expect_success block (as
    requested by Junio)
  
 t/t6031-bisect-skip-with-term.sh | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100755 t/t6031-bisect-skip-with-term.sh

diff --git a/t/t6031-bisect-skip-with-term.sh b/t/t6031-bisect-skip-with-term.sh
new file mode 100755
index 0000000000..f1e1c4c1a2
--- /dev/null
+++ b/t/t6031-bisect-skip-with-term.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+#
+# Copyright (c) 2021 Bagas Sanjaya
+#
+
+test_description='Tests skipping bisect which the bisection is started with --term* arguments'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# hash variables to be used in bisection test
+HASH_SKIPPED_FROM=
+HASH_SKIPPED_TO=
+
+# test repo initialization
+test_expect_success 'initialize testing repo with 20 commits' '
+	for i in $(test_seq 1 20); do
+		echo $i >>test &&
+		git add test && git commit -m "commit $i" &&
+		test_tick
+	done
+'
+
+# actual bisection test
+test_expect_success 'test moving HEAD when skip bisecting' '
+	git bisect start --term-new=ok --term-old=whoops HEAD HEAD~9 &&
+	HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
+	git bisect skip &&
+	HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
+	test $HASH_SKIPPED_FROM != $HASH_SKIPPED_TO
+'
+
+test_done

base-commit: b0c09ab8796fb736efa432b8e817334f3e5ee75a
-- 
2.25.1

