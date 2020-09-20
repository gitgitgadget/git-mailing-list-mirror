Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298DDC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F0220EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="V4DbzYfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgITItJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 04:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITItF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 04:49:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59AFC061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 01:49:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c18so9673769wrm.9
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ue8w0znpULflcyzNrAzYpFbrqDG8/YnpAQk4OriQZ0o=;
        b=V4DbzYfSkv5mKdRnc0XFfUaZRb2Wp6egza52cowLb8OOj4m5owvjpBZvC7QPteqRCI
         /gOBriTxEEIzWLxZugUC3j3Z4FgFAqHesnpzSbijKmpkGJaF8Xeat4h/2ESCzyagCsJ/
         QqCbatHXRlRM8xar/mM+n1nxKCSQAHl1v2JUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ue8w0znpULflcyzNrAzYpFbrqDG8/YnpAQk4OriQZ0o=;
        b=IhAaKRmntDfZ1hMjElPGGe92YLIrArm8asAHMI9//J/0uOAf6cluzJ5uGs/bSLTRXK
         N5oEh8n43qDsjyx7YIJ4sRwohiuKUuO5VdlDH58HNqhZ+cnosgIoxNn9bCCUVMRXbkJG
         FN6x8Mw9ur2VCUoANTk7aQLkoX4rTMZTYaCHqBTM4H8F7lljVQfOM2oM6Fsmty8A2YTh
         QvtMyi4LRkk2LWsEfwb61t9u47zP98v9VN0dBrOwZpiVStJLw43jS9oCGVN2qpB48qxo
         IXEbbtcTRDG1SM+Fk8/sdStHe+fT6K+pSi6lld7BvBRXVFgGfFwiZ8dro5E1CiTaAWKN
         a/xA==
X-Gm-Message-State: AOAM533nWGdJeA/2dXSyRwas9BcpJbpjrTbnRZg3HSm3q6vQ8neSrn0h
        ajtHsV3OuQ+MWAUCZCmrNNQEQAAyVT/5Jg==
X-Google-Smtp-Source: ABdhPJwaDr3EA1ujPj7QBM31qIEqKN4erghlfFIOM9cST8sUhTMKBTScckEZByGnknCCZshr/qEwhg==
X-Received: by 2002:adf:a418:: with SMTP id d24mr38936657wra.80.1600591743425;
        Sun, 20 Sep 2020 01:49:03 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id 11sm13437567wmi.14.2020.09.20.01.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 01:49:02 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 2/2] git-p4: fix `unshelve` bug finding parent commit
Date:   Sun, 20 Sep 2020 09:49:09 +0100
Message-Id: <20200920084909.17794-3-luke@diamand.org>
X-Mailer: git-send-email 2.28.0.762.g324f61785e
In-Reply-To: <20200920084909.17794-2-luke@diamand.org>
References: <20200920084909.17794-1-luke@diamand.org>
 <20200920084909.17794-2-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`unshelve` was using HEAD^$n to find the parent commit. This meant that
any intervening commits between HEAD and the last git-p4 commit would
cause the unshelve to fail.

e.g.
    123ab Local git-only commit
    234bc Another local git-only commit
    345cd Perforce tip revision

Unshelve needs to find 345cd.

Use HEAD~$n instead.

Reported-by: Liu Xuhui (Jackson) <Xuhui.Liu@amd.com>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py           | 2 +-
 t/t9832-unshelve.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index ca79dc0900..4433ca53de 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4237,7 +4237,7 @@ def findLastP4Revision(self, starting_point):
         """
 
         for parent in (range(65535)):
-            log = extractLogMessageFromGitCommit("{0}^{1}".format(starting_point, parent))
+            log = extractLogMessageFromGitCommit("{0}~{1}".format(starting_point, parent))
             settings = extractSettingsGitLog(log)
             if 'change' in settings:
                 return settings
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index c08234bea0..c2200a5b69 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -80,7 +80,7 @@ EOF
 	)
 '
 
-test_expect_failure 'update shelved changelist and re-unshelve' '
+test_expect_success 'update shelved changelist and re-unshelve' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$cli" &&
-- 
2.28.0.762.g324f61785e

