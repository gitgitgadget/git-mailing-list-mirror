Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21121C4320E
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF5360F35
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhHPUSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhHPUS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 16:18:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BE2C06121D
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so743611wma.0
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=luGuMJDPRMnjXEoCSqhvE+ut/GB0VLXv5Jme/aSENz4=;
        b=Rnby5vl4y4XDqpzR12rJKDgWg6YNYWkw1/1gJk61wR0Vh8V988800TlV21rWRiWj17
         0vng1FdXxWbse6WnL1PTMXthcgyVDs66gs8xAqZ95s6dUKI+4chY5XwaXC5xFLsZi8fx
         bL7Kk/tr9CTIr+YE/spXwqTSBjA1Rg3hAKpzts8ygfzhBknqSLaAw4kYWhFh7f2/85k/
         hUrfFRKxxmzBYyQ8gXYyk9/3/1JUfs69XAgiBbkJGTNG6m+MU2REhxwjwh1RztkpkoVi
         2GMAW/hoSz82BWP6PnFhn/dAFUCWV4nNHAFM9GaaHsXom5V3eCTHWulilvi54bIrTAc0
         /STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=luGuMJDPRMnjXEoCSqhvE+ut/GB0VLXv5Jme/aSENz4=;
        b=DXFHq3yOj7Ozd4aAAjz+4zb/sB+LpmwRFY5l0bdCFE8V4d6ZCYWPtXg6z156YWu3yY
         /DAI2UdygKG+ZCFJ9cLkDWQ3vid6C/rjwsZ3NXu9FNftnjwCtaWk5aEjRwb9D+U6kFCY
         Oged+DIVkuQvKer36JIbHVfGnLesUoAonZHQx0WanC5JXFSN5VKI84KwcMRfxQIJ0EbG
         Y12Rs6W8gll+21usgefW/UjlrsaXQF2pXtTydlYSzZ9IMtHcT/orpkVITQ9ao1PN8qLO
         MFKoTEeNXp6BC/oLxarthjoqB7zhphJ8KkuIsr4zB/bITj6/v3Xubz2b2C+voHDMWkR3
         RRYA==
X-Gm-Message-State: AOAM531Ye2m46gWctAPzvBA8ti4FoKqwkbKKQuRu49+vrVIZk4FMifnj
        4Tp2GRHfpC76icyNLEfY3/SIpo2L76U=
X-Google-Smtp-Source: ABdhPJx+pF+GjqMVWXIeTfD+C5N495C5Hv8WF4ie9oDQVSGBfIkBQP20gNXj8GsTzGJlMDvsc7/ZiA==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr15044wmr.168.1629145061101;
        Mon, 16 Aug 2021 13:17:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10sm178515wmq.21.2021.08.16.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:17:40 -0700 (PDT)
Message-Id: <64dc87746db87b31e741cfa95e9da0fc7836df37.1629145037.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
        <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Aug 2021 20:17:14 +0000
Subject: [PATCH v2 23/25] t1301: document what needs to be done for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1301-shared-repo.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 84bf1970d8b..a5755b4a434 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -22,9 +22,10 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 	)
 '
 
+# TODO(hanwen): for REFTABLE should inspect group-readable of .git/reftable/
 for u in 002 022
 do
-	test_expect_success POSIXPERM "shared=1 does not clear bits preset by umask $u" '
+	test_expect_success REFFILES,POSIXPERM "shared=1 does not clear bits preset by umask $u" '
 		mkdir sub && (
 			cd sub &&
 			umask $u &&
@@ -114,7 +115,8 @@ test_expect_success POSIXPERM 'info/refs respects umask in unshared repo' '
 	test_cmp expect actual
 '
 
-test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
+# For reftable, the check on .git/reftable/ is sufficient.
+test_expect_success REFFILES,POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	umask 077 &&
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
@@ -201,7 +203,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)'
 	test_cmp expect actual
 '
 
-test_expect_success POSIXPERM 'template can set core.sharedrepository' '
+test_expect_success REFFILES,POSIXPERM 'template can set core.sharedrepository' '
 	rm -rf child.git &&
 	umask 0022 &&
 	git config core.sharedrepository 0666 &&
-- 
gitgitgadget

