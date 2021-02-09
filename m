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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60495C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B94C64EA6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhBIRfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhBIReb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:34:31 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF91C061793
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:33:20 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id j12so12317468pfj.12
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Za395WSwiabtFFeu22KUW7sCRPfd356ZKXC8plECEGA=;
        b=r86MfST5BKE5vhjLJ/MKm+l3p3a0DE0pQnXTe1NuqIuIz5MkGz7YWoMvkrE0y7GFsU
         Gic6bGvTRg0qM1nKkz7+DLyusC0tB0g5Fn9jvMx5rPPPWc4wyC2Z9i5LsvmvGVxtw9UR
         ovicZ01W86d7txj95smsQkOfgvohj/idL3mwJHJ9dFdbA3wgOx6Ge1wAemjJooMVh+Br
         sh/TYrp3G+eMqMEzaV2YCeKV3cUHtkmijDV0ku1owKb1wGuAYKEy+fE1hJK18yWxT74z
         7TwzDFLQY6rsyv222xwCEL6NEMQfSvVsGj/rZ+VD3wSDZ4T1REGIcTNP57GKK2KGgWvT
         YJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Za395WSwiabtFFeu22KUW7sCRPfd356ZKXC8plECEGA=;
        b=BtMbz95YlRGXJEENNLooigMZx1A48yXsBpPXQ08WDDvW+t/2exfpbRpq7recwsNHxd
         F6ZlrovCDW3mGBsPpWFp6h2y9dUs2lOhe6bpXLA/vhLGsXun5ffNmVFybJ6gtaK9yt3V
         Uc6pV9+PQkl5U/k8U/29wDB1NyDM9G+1DhafnQBNKe7sIJlQOkLkpeYhyq7VAMLfStCb
         b12ITSsYPS15H1y2Za/UhE47Jphat3UYvJnNXWZ4pzpcZcjb/MrM2165xZNwDU4pXUAs
         LkPGfYNXaOnY4u8GIxjD2P7Pi693Bd/477xhJQxuDWSXWt/xxmsNs/aS28hAIqalk4NB
         YBoQ==
X-Gm-Message-State: AOAM533WENbMSuLM/apkcg68DzZgQm8GuAtd0gm0kmswZnA23MzhLts9
        YHXWomIPhvjPl37q8edtHDjJ/bu8ob9SAg==
X-Google-Smtp-Source: ABdhPJyaiH7M6V38TOcB9Q9trDWZ6mvLy4L2SlrQoxBaH4mSgeIiOYACLkWc8e9gWLBhqGUHvPSyew==
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id 144-20020a6218960000b0290197491cbe38mr23426467pfy.15.1612891999687;
        Tue, 09 Feb 2021 09:33:19 -0800 (PST)
Received: from localhost.localdomain ([47.9.143.68])
        by smtp.gmail.com with ESMTPSA id g3sm20682607pfo.149.2021.02.09.09.33.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:33:19 -0800 (PST)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 08/10] t7001: put each command on a separate line
Date:   Tue,  9 Feb 2021 23:02:52 +0530
Message-Id: <20210209173254.17712-9-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com>
References: <20210209173254.17712-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modern practice is to avoid multiple commands per line, and
instead place each command on its own line.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 1671241fc8..9a73232c7c 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -143,7 +143,9 @@ test_expect_success 'checking the commit' '
 '
 
 test_expect_success 'do not move directory over existing directory' '
-	mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
+	mkdir path0 &&
+	mkdir path0/path2 &&
+	test_must_fail git mv path2 path0
 '
 
 test_expect_success 'move into "."' '
-- 
2.25.1

