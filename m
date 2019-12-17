Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF1C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE4D207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6B2O+s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLQMBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:45 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:43004 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLQMBp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:45 -0500
Received: by mail-pl1-f175.google.com with SMTP id p9so1765627plk.9
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7ALs8fUkjKgVaZDZ9NjVwuPxUlFirl7OgFe2AWO2kaw=;
        b=u6B2O+s8MIZkO6L5eDC9Cl6lfwRNj8UkZJvB6z+oNVN7Hf34RrmubIxhdwBR+F9w1m
         TIBDSRlM1syOqj7cyheAbVR9DBYg6g5wlWOGaXWWzzikqD9uf6/rQ+a+NPkZLis1INyT
         JLRAoa+9RHfHKWATeuHN6wBaGxMFQgMijXgmdLUWCOsbrRcuMNvAxM5yeuQ24veAim88
         xVNgcjlXV4QoAS5nGH6CpVzLKxXShhcHJf6HLgyhEduDFKgif2mEYMNeFnN6atd6iSH+
         VBalPRRk42+l8ihN/sSBkjOhcIVdB6RKwqJz8oKsQ86n3aUIQJZPnCoLd/5+9ISU5wPM
         L75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ALs8fUkjKgVaZDZ9NjVwuPxUlFirl7OgFe2AWO2kaw=;
        b=EdWxtnd+cLaaaqnfD+s3TK40glD+IxDSLKrRdjydP6tTXNzwFh0aAR+dyT5eWst6Qz
         jt0YeHrHlqr0OaAcrF/lct/PFZr4lPgJK3OujVS4AwCxVZ0YjQ+MwCaYCwWJAHlU/nrb
         uVGzvKCUBAs8XqcDGHk3JYaFF2G+7RgCUIQ3M3RCFJo7n2d5d2cOB5oESv46/NxbYQJq
         jM/zMdOdccrKNtN7tN2a1dLWbx5gcRg+35ieOR14ZpVhdByMNjhvRWgsygNBjc2WqBYj
         bKJTF9jNVB5aGHWJP7yNXsC50+WDLFx9Pvja64M1nAPYJ+C8lSkc0UrEGwduAi0KRfL4
         xaQg==
X-Gm-Message-State: APjAAAUTI6/kCE+F9VIVH7+KmPuEaZ6Ywaq0B96Bz6mPoSaOgMq10JGA
        kLdNy0xvwhGbEW/8kW0gxYAYEhoq
X-Google-Smtp-Source: APXvYqzzIfnw2BUv8zAJVeNOwqUQ0NLpRLdsVtmCk2e9meUCBac6WfzDhs4oZJEB6wEA1WhOMDFSJQ==
X-Received: by 2002:a17:90a:e2d4:: with SMTP id fr20mr5660541pjb.85.1576584103947;
        Tue, 17 Dec 2019 04:01:43 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:43 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 01/15] test-lib-functions: introduce test_non_git_might_fail()
Date:   Tue, 17 Dec 2019 04:01:26 -0800
Message-Id: <85cee927656cebed34bc93280d0b2d89e0caa570.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will be preventing the use of the
test_must_fail()-family of functions (including test_might_fail()) on
non-git comands. To prep for this, introduce the
test_non_git_might_fail() function which is used to replace non-git
invocations of test_might_fail().

The test_non_git_might_fail() function is a lightweight replacement,
always masking the return status of the command and returning a
non-error exit code. Unlike test_might_fail(), it does not check for
abnormal exit conditions such as a segv. This is because we are not in
the business of checking the sanity of the external environment and we
can assume that it works properly.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/test-lib-functions.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 284c52d076..61d27f1ec6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -891,6 +891,15 @@ test_expect_code () {
 	return 1
 } 7>&2 2>&4
 
+# Similar to test_might_fail, but much simpler. This is intended for use
+# with non-git commands that we can assume will work sanely so we don't
+# need to check for conditions such as a segv.
+
+test_non_git_might_fail () {
+	"$@" 2>&7
+	return 0
+}
+
 # test_cmp is a helper function to compare actual and expected output.
 # You can use it like:
 #
-- 
2.24.0.627.geba02921db

