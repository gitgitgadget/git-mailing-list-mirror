Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0337CC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 07:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCB6221EC
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 07:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="URhkDW9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgITHsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 03:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgITHsh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 03:48:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE0C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 00:48:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w5so9591084wrp.8
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 00:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8KSMdmLX4/XV558FNQh9XA/B7e6fkFxHu/ERlT3qPCM=;
        b=URhkDW9HD1QGlsyjqmaEKXq5LJeVXJwNYtihOw5VJ2F+L4v+RjKVST1g9cE7KbW+q8
         DbtbXCdyv1RZfO7iWDmbPscDml/XmOmiHbpaZwoqh4GMqzKltR9CJeQUMyN8cZrSDqFW
         XTp/0+I/mlJHFsNkXDHbcia9RH6u4SC9lLVmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8KSMdmLX4/XV558FNQh9XA/B7e6fkFxHu/ERlT3qPCM=;
        b=hrrK9bp+lUQz3k1e/bbQqZNnAS3QQDWwm9xY1/lw4jumfyFndImgu8r2Gr8n8a8uOC
         6D46nWNNggg5GlqdzwJacUtcUOOyQAYlmSBIgs6u7ulpaZ/nME7jqAYbnstDCQ8yhMyu
         g1jEl4iQdoPLJNR643wPOzd9GsYLz0qwzE/SHJDJJKaPpCVuqIXqq6GJPuIt9gZDh5oC
         iuCf7Q8mR9Ml8ZkhaqDhU9PtC4X+ikPbqOAVl/jzg1JYt0hNWUAhr7bBF5heH8LSALeO
         /MBBaXO5QWVhsFYsSQ7aWxXp4xWY9TU4PvFHg2epPTfdQjdrni9Al4PcSaxhxUQvrsTq
         sThw==
X-Gm-Message-State: AOAM532rMzqeUDSL27FSyLEXN70cpFIbk0A4fwKOonVElk0SqyLGnRg1
        trhGV2vYfJjsnfu2wrSySwbVWLcKEqbPSw==
X-Google-Smtp-Source: ABdhPJwHcelEaUDZETvCXZLAQNBoHmUPM8Ak1SRNrKI1fz2XWRjBT1jgA/8+rauhFGZXHv/4ZzvxWw==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr45409778wrm.422.1600588115691;
        Sun, 20 Sep 2020 00:48:35 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id u17sm15140329wri.45.2020.09.20.00.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 00:48:35 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 2/2] git-p4: fix `unshelve` bug finding parent commit
Date:   Sun, 20 Sep 2020 08:48:41 +0100
Message-Id: <20200920074841.17043-3-luke@diamand.org>
X-Mailer: git-send-email 2.28.0.762.g324f61785e
In-Reply-To: <20200920074841.17043-2-luke@diamand.org>
References: <20200920074841.17043-1-luke@diamand.org>
 <20200920074841.17043-2-luke@diamand.org>
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
index feda4499dd..7194fb2855 100755
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
2.20.1.390.gb5101f9297

