Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB9C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DD020A8B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeG0S4rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgDTIzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgDTIy6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 04:54:58 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C063C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 20so9679987qkl.10
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eoA79kLMgYsAzWpBCLtFmrwK5icL4lqTYhIcgy6IYaU=;
        b=ZeG0S4rmGYgHeYopqfq+qEe71vN+pEmfKPmOc+HdUJbbye331PwrX0uaRPTtOH6C6P
         QuQA7luliTI9fiiU4iOOXxjU08/8MsIU2n7LE9WiRYo38eHysiCkOWWY+ZX6SzOHyOkZ
         POPhVA1mCkvLW4qHAaifSbKHj6EOvnrhtd2acEO2I9o7fq5znGR549ZJpWmCql9h9hEL
         KTZ35k8G9O3AacDoOJyLsaIAQcJ+3WXxfQOBMlYmlwZ4bq8QCJFfN8g0rqgi9U409WaG
         4K+aaOTYgsl/m3PfHfsm2DCfMFU4eQFAVpNcWmMT8AfQ5byvKFlLpMnvYeNSUIWpklft
         WqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoA79kLMgYsAzWpBCLtFmrwK5icL4lqTYhIcgy6IYaU=;
        b=ITq59jHfApXWAx6xBD90tEaCP3jSRG7GXgvo/yFFdqcQQ8vHwgyKi0GwjGBFom3SdK
         rVMJldWwE/bOD9ev18wu8h1Ws95D24VeUmp17GPghJuTWwca82K3HaZ9eplBVoOF/yCd
         bLYnKXbCYtLYi4zy1HF2BTqGItZxm+iBjHtyrqDxfchWDXrOBtuyo5pBiSHn0/wBnqJD
         af0r/6BpQSk6fiWwlHCZJYu3JSRdqWwsSexb+PUdSJktgUMm6l0q7s7YORbFIjLXyFq9
         8KjylKL30V3UpHEWx0fM9FsLAt7H0guCGW2Hg8HIxDDwfRrXTypAKd/LBABahR9MqcGw
         Z9qQ==
X-Gm-Message-State: AGi0PuZSQR8fkSnW0GVtPtkvsALPTVkNq36hl2erHWxnBVS0rv0VlErs
        GSSRK/zAV0QVu+hHxDjb1udjhZjN
X-Google-Smtp-Source: APiQypIcwJ+TaePoFCymnlQGO4SyzCKYs8e+EmHBhIk6WSbJSO49FzpR+CCZ6iPmkx5Ld488TjckXA==
X-Received: by 2002:a05:620a:13b9:: with SMTP id m25mr14763867qki.456.1587372897485;
        Mon, 20 Apr 2020 01:54:57 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id p25sm203222qkk.18.2020.04.20.01.54.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:54:57 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/8] t9141: use test_path_is_missing()
Date:   Mon, 20 Apr 2020 04:54:42 -0400
Message-Id: <1eb50e1be2f548c65f5491a1554fc7d69fd261d4.1587372771.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1587372771.git.liu.denton@gmail.com>
References: <cover.1587372771.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() function should only be used for git commands since
we assume that external commands work sanely. Since, not only should
these directories not exist, but there shouldn't exist _any_ filesystem
entity in these paths, replace `test_must_fail test -d` with
`test_path_is_missing`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t9141-git-svn-multiple-branches.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9141-git-svn-multiple-branches.sh b/t/t9141-git-svn-multiple-branches.sh
index 8e7f7d68b7..bf168a3645 100755
--- a/t/t9141-git-svn-multiple-branches.sh
+++ b/t/t9141-git-svn-multiple-branches.sh
@@ -90,10 +90,10 @@ test_expect_success 'Multiple branch or tag paths require -d' '
 	) &&
 	( cd svn_project &&
 		svn_cmd up &&
-		test_must_fail test -d b_one/Nope &&
-		test_must_fail test -d b_two/Nope &&
-		test_must_fail test -d tags_A/Tagless &&
-		test_must_fail test -d tags_B/Tagless
+		test_path_is_missing b_one/Nope &&
+		test_path_is_missing b_two/Nope &&
+		test_path_is_missing tags_A/Tagless &&
+		test_path_is_missing tags_B/Tagless
 	)
 '
 
-- 
2.26.0.159.g23e2136ad0

