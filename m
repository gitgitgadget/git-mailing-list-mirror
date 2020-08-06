Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C912C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FFE2311A
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oo1sZ5r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgHFQsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729104AbgHFQmp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B03C0A893D
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:41:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z20so7169242plo.6
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYsWR4N0FaViQvx0u0sEE0dvKb6/ML6Q2YctyD6XQq8=;
        b=oo1sZ5r8mX7zvtBbwTPc5/d36/izsN85OobelWp7M6A4DFVFAYshI9OsrM+zC6PRCK
         aqAtH4BJjrD6DWCJopNv7wWEvCe327CW84RAD05brpGbtpWMoY3SiRUZOz8J9Y+I6GFb
         iVqyLoujBNxmpYjjj//mAWuj5GOhyqis9G4Hrhbx3vZEub0d/Lk42XmtPuCdOLvdfh/A
         XP/QGN3gSEq9MAYd9rxZCCU7nlhQHY5YqYi0aRx3uZfRbk+TjX5kEhgOaPI7m6eY58DU
         musGhJAeJl6ywsxQCmkC3YlZkzsP/MTg3gIV+z19fPFI3/3bWs6tud6UbDoKUtHt6zUJ
         E1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYsWR4N0FaViQvx0u0sEE0dvKb6/ML6Q2YctyD6XQq8=;
        b=R6FbozBSwyv8LVqr+umTSaMHQidFiIUT+Un174XOZUvt2aYlOJlYYp+7Adv9by3631
         IyJarrk6HStrRYSuia6+rce5PPFNDxJ5gcchtGzfSnutUyMrgs4pT1i1GoJERIxfNziM
         WJRXK4hVJm0ZgCx0FJG1rBVGtvzGJLhapDC+cOKRSBj58kmAKCA34n2ERZyr0a7VBLcX
         YrQqVmexFcBYb8S7M6vl4L8u6ZFNycifW9+1geXM7B8tIvGsH/nXXknPDeAT4s5m5Gwg
         8tjMOPMnEKH4JI99cPpc9ASd6V0+xhHk3LXzR7GMHiSB53Eoj4SA+spE+LSDO5p0jF8Q
         sTTA==
X-Gm-Message-State: AOAM533AOy04g4b9rdR1Dg0aBJSmYMoHg+KwMNY4/lPMTmKZjffQKWpX
        mVVevkXUzr96WWXVUY/i2dtu4eumfUU=
X-Google-Smtp-Source: ABdhPJyUQ1uDs1zFFo+hiB3ZXUaUyxAK/bYv43xtqyCNtgnjJ04r/FMQrZcZE1D43M4C0C3VtSOMrw==
X-Received: by 2002:a17:90a:1d0f:: with SMTP id c15mr9668116pjd.180.1596732089495;
        Thu, 06 Aug 2020 09:41:29 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.60])
        by smtp.gmail.com with ESMTPSA id w16sm8008381pjd.50.2020.08.06.09.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:41:28 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com, Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/5] t7421: introduce a test script for verifying 'summary' output
Date:   Thu,  6 Aug 2020 22:11:01 +0530
Message-Id: <20200806164102.6707-5-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

't7401-submodule-summary.sh' uses 'git add' to add submodules. Therefore,
some commands such as 'git submodule init' and 'git submodule deinit'
do not work as expected.

So, introduce a test script for verifying the 'summary' output for
submodules added using 'git submodule add'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7421-submodule-summary-add.sh | 69 ++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 t/t7421-submodule-summary-add.sh

diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-add.sh
new file mode 100755
index 0000000000..829fe26d6d
--- /dev/null
+++ b/t/t7421-submodule-summary-add.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (C) 2020 Shourya Shukla
+#
+
+test_description='Summary support for submodules, adding them using git submodule add
+
+This test script tries to verify the sanity of summary subcommand of git submodule
+while making sure to add submodules using `git submodule add` instead of
+`git add` as done in t7401.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'summary test environment setup' '
+	git init sm &&
+	test_commit -C sm "add file" file file-content file-tag &&
+
+	git submodule add ./sm my-subm &&
+	test_tick &&
+	git commit -m "add submodule"
+'
+
+test_expect_success 'submodule summary output for initialized submodule' '
+	test_commit -C sm "add file2" file2 file2-content file2-tag &&
+	git submodule update --remote &&
+	test_tick &&
+	git commit -m "update submodule" my-subm &&
+	git submodule summary HEAD^ >actual &&
+	rev1=$(git -C sm rev-parse --short HEAD^) &&
+	rev2=$(git -C sm rev-parse --short HEAD) &&
+	cat >expected <<-EOF &&
+	* my-subm ${rev1}...${rev2} (1):
+	  > add file2
+
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule summary output for deinitialized submodule' '
+	git submodule deinit my-subm &&
+	git submodule summary HEAD^ >actual &&
+	test_must_be_empty actual &&
+	git submodule update --init my-subm &&
+	git submodule summary HEAD^ >actual &&
+	rev1=$(git -C sm rev-parse --short HEAD^) &&
+	rev2=$(git -C sm rev-parse --short HEAD) &&
+	cat >expected <<-EOF &&
+	* my-subm ${rev1}...${rev2} (1):
+	  > add file2
+
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule summary output for submodules with changed paths' '
+	git mv my-subm subm &&
+	git commit -m "change submodule path" &&
+	rev=$(git -C sm rev-parse --short HEAD^) &&
+	git submodule summary HEAD^^ -- my-subm >actual 2>err &&
+	test_i18ngrep "fatal:.*my-subm" err &&
+	cat >expected <<-EOF &&
+	* my-subm ${rev}...0000000:
+
+	EOF
+	test_cmp expected actual
+'
+
+test_done
-- 
2.28.0

