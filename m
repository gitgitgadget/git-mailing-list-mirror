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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2EBC433E6
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE8C61606
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 18:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhBRSyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 13:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhBRSur (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 13:50:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7229C061793
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 10:50:07 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c11so1895645pfp.10
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFOIqFnsaInbwRiLJH0779WMimDaB29eU43fsNIx9wQ=;
        b=hT1gbqL6H7QjyNw8CDtrC7hxwOnDMCasNnW/8psYnNosrG78IVJrVYwVj4XXVSfZWy
         hbLSCUKH9VcdZCG/VA8+3tCBOvYiTnZSMa6ipGFGBSGBrsc38+RkB5/BwsLFmKhml9AZ
         OGBVfQadLoaExNjSutQFoi1tRSQGynxtnRlEJTVB4sDl5cSnm6q3nwfDq5Y6xgBaO+hR
         8jJDCzL7s0kycrwCJHeSYP9BS1gjzZfOTdyKy00Y9bW30mc0pGg4RXIDqvw0ONqrRVbE
         yrmYJF/PqqjcEBJJ69dcn9XkLfYSiWbyjsH4Fpjl8Lw3gkadi4AwMoLtEkBEbHLME2cN
         4YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFOIqFnsaInbwRiLJH0779WMimDaB29eU43fsNIx9wQ=;
        b=hMZ+Nw2BrrTjuX97ZXMAnxk12iY8AlkA3R94sSWawqsR2wUnY5CDOV96OVbz8OxPnQ
         jZa/nfGg70XRKhrri9Bqw/6k0eDTkIIqDCwl/GHvx0Az4UAUben7noT8J8m/a1J7AsKL
         ic3XIAmdnEpYJXEufYqRC/LvhQY3vDfJtH8smGzgtMke74Z9J1M3HxfbUoZT8i1j4o9t
         ML//L9oc9EwJHek+VdyAc8/ICy8kZqbvqhar+BMMb463PgnGrmQnTyQj9WilUMkzrQxd
         d6MjE7JVsee7QXBqBdIqlht6IK/j05BOOYlSum8earYuxsHijp18cowNgXmh/quTHuhK
         ydCA==
X-Gm-Message-State: AOAM532zfstCLwrr7spdW8c+WX/xKu3ldWdlishUoTzbtI73CeY+MY/a
        hcI8ZLK00V8o2qf3eKD0ZApy5/Q/UH0=
X-Google-Smtp-Source: ABdhPJwjfDl0zV3LWO1JaZhhDTSQJ/Ccff5Gg6ueodWnGoOtaOMdQQ3Y125nmch47L0C1TEMpG4Xzw==
X-Received: by 2002:a62:aa06:0:b029:1ec:ec68:474a with SMTP id e6-20020a62aa060000b02901ecec68474amr5564992pff.40.1613674207298;
        Thu, 18 Feb 2021 10:50:07 -0800 (PST)
Received: from localhost.localdomain ([122.176.159.190])
        by smtp.gmail.com with ESMTPSA id s22sm6790879pfe.133.2021.02.18.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:50:07 -0800 (PST)
From:   Shourya Shukla <periperidip@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com,
        Shourya Shukla <periperidip@gmail.com>
Subject: [PATCH 2/2] t3600: amend test 46 to check for '.gitmodules' modification
Date:   Fri, 19 Feb 2021 00:19:31 +0530
Message-Id: <20210218184931.83613-3-periperidip@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218184931.83613-1-periperidip@gmail.com>
References: <20210218184931.83613-1-periperidip@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following commit e5a439dc71 (rm: changes in the '.gitmodules' are
staged after using '--cached', 2021-02-18), amend test 46 of the script
to ensure that the test also checks for '.gitmodules' modification after
a 'git rm --cached <submodule>' i.e., the entry of the submodule in
question is removed from the file.

Signed-off-by: Shourya Shukla <periperidip@gmail.com>
---
 t/t3600-rm.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 7547f11a5c..45aff97b90 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -309,6 +309,7 @@ cat >expect.modified_untracked <<EOF
 EOF
 
 cat >expect.cached <<EOF
+M  .gitmodules
 D  submod
 EOF
 
@@ -390,16 +391,14 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
 	test_must_fail git config -f .gitmodules submodule.sub.path
 '
 
-test_expect_success 'rm --cached leaves work tree of populated submodules and .gitmodules alone' '
+test_expect_success 'rm --cached leaves work tree of populated submodules alone' '
 	git reset --hard &&
 	git submodule update &&
 	git rm --cached submod &&
 	test_path_is_dir submod &&
 	test_path_is_file submod/.git &&
 	git status -s -uno >actual &&
-	test_cmp expect.cached actual &&
-	git config -f .gitmodules submodule.sub.url &&
-	git config -f .gitmodules submodule.sub.path
+	test_cmp expect.cached actual
 '
 
 test_expect_success 'rm --dry-run does not touch the submodule or .gitmodules' '
-- 
2.25.1

