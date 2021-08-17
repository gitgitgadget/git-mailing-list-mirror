Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845B0C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697A460249
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbhHQNnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbhHQNmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:42:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30213C0612AF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f5so28640325wrm.13
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=luGuMJDPRMnjXEoCSqhvE+ut/GB0VLXv5Jme/aSENz4=;
        b=NKvq1NtfhLspST/8yose4kDidR3E5UPk/rHnXT1dX4WbV1Mmnz67d/LSc7GhUJHmKv
         O3JsKVfJOcRRhhE5YcFwM8F9Vkg+GqGRfR3IVgFab+tzQIdaKqybL+CpFlFNXV8cluad
         cBMl9JAT+vAxKsspLElAU7mM/lB8n56aWyFuqL8KqCZP2Ktrtgizbsz3O/6iF3HXOH80
         L2rKaig1qFfsD00VqtsL9OhlUBlM+AkFEwMCeHNF6KsMwJFNuoOyEqTHaQgERt7ECx6E
         vifj0jJBJPDNmyvMF8S0r5b801Qa4NMHyOmqkgsjxYya6OMD28EOlcBRW35Cqm0H0GR0
         Oxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=luGuMJDPRMnjXEoCSqhvE+ut/GB0VLXv5Jme/aSENz4=;
        b=acgOD7PilqgtixszR5/4ZTtPMhzpGOHIHyvzCMRb2m5nzv1BL6QpqoisJOCgPS5x9A
         uj3b3TxGKr1HXKG3ZJ1nZQgJ43snX63nNrX4u0IdFkpVh1+4lPPo+nM8O5BAKwh04jB4
         zGrTaBO/U5lJcjROYWn73bJHBru/ePlWS7wlv4DMRqh1RR3hWZobXNytEQh9ddTLbtjz
         yn/HtyxnXfqfroqUi9fA11UtvNlt2hkPe4SM91bD7NxCnpWrccnAuipWzTHto0+mi4Kj
         42zPOWIUUfWzjMbDZ0XPnK8KkpLL7jWVFMSmy51JFglY0+yFvRBx2kUYTdw8w4EVYE/8
         ZGsA==
X-Gm-Message-State: AOAM530R/dan7Km6p9Cps5LtzGICMlO5eQ0Hj5Vs6rRZ0vst0iohHK/r
        mXJJEhMod1RLntXLNUtjy5n/Kt2Vzhg=
X-Google-Smtp-Source: ABdhPJxqHHZ5e2g+1luPkDBg16bvyIXgBkjPxgiIbIZ6KP+CD2re/VYfpcisGhoYOOhV27VwP1yNdA==
X-Received: by 2002:adf:e746:: with SMTP id c6mr4135942wrn.276.1629207649842;
        Tue, 17 Aug 2021 06:40:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10sm3119041wrq.32.2021.08.17.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:40:49 -0700 (PDT)
Message-Id: <a44956d7b08c6a7f73d2c6d2cb2e8bc3b4192c32.1629207607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
References: <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
        <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:40:05 +0000
Subject: [PATCH v3 23/25] t1301: document what needs to be done for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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

