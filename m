Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B62C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF66520719
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 04:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWlf14mK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgCZEhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:37:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41576 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgCZEhw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 00:37:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so1672622plr.8
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 21:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmWIKRsliB6qei1iFgIOmQDpdqR2nj9u0F+OOavpSw4=;
        b=VWlf14mKMfkGrMz/wBnhTUvgXni/q5dO5MmQIQKzvcJebmkDXn0MUxgTyQCNIs8567
         kHEFtJPYuSn+VaN/75KMCbUl06wRnLgMdXXSzH/qUqJwAv7DvYnQWovr0k0rCh7yJ2Ny
         p/xlW7+k5SqvTOPDUKUT5GlOmp0rm0QWSioSTjb8pnBtUyvOvSuqZlq/iyqeTFcjRLeJ
         QAZvlh+JD4P9kEPriAsAvj6KTLAOjmmokz+QcKVEUqAEjRWMGVxPCJJIGxacJaBiOWYB
         J4cKdsvhz0ng8wL0qUDqlu3iwaJDqX7d4PZkPcdFW11crlYTe0SePT+MGkrflDniwxmG
         VKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmWIKRsliB6qei1iFgIOmQDpdqR2nj9u0F+OOavpSw4=;
        b=Zx4pMw0Qj38TGNcBVlslSZzzoY5jAZ2u6laJWeA7eWIJH79KPbRkvoZuutR8MTIYsl
         /vBWuWQC+sHeyFyScfvFB4z0q99Scq3BYgFQCfGaa4wZGyqYbxOTBI1tbrWUcI25BlUm
         1LhV2/YZiMIJ3cYI1okdJNznESUzq5R+haCYSGKozPTH9aWXJnJyRMIvFARirA3AvkCy
         uaf7VlB4CAtvtf+JhREWsxVgbWijriq69VKoi0dYvfP+Ag6tSKs8VMLM54bwTyg7TAiN
         zlUC4xtAF444Aqoeu083TP9DNqXKzlTPnlvHTVFsAFJSGIFdD6a+tetNo/Rr9r8m9K1Y
         /uPg==
X-Gm-Message-State: ANhLgQ0b5ZLGjElrqPe7Hl4ll9IyFO7oVNaYXGiWkUjlze44+PO4a88T
        6I3c1Q835WpaS0o0VtLXFyVcC9Ni
X-Google-Smtp-Source: ADFU+vvqN3ehfuh2XnWQBva/cUau3BDz72VKXokaxxsStA6S2O1JgwKXSfmnZT2rd9BZDmZEpqzOdg==
X-Received: by 2002:a17:90a:240a:: with SMTP id h10mr1007192pje.123.1585197470701;
        Wed, 25 Mar 2020 21:37:50 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:c347:544a:f0cc:8a21:fee3])
        by smtp.gmail.com with ESMTPSA id u21sm639344pjy.8.2020.03.25.21.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2020 21:37:49 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 2/8] test-lib-functions: test_cmp: eval $GIT_TEST_CMP
Date:   Thu, 26 Mar 2020 11:37:32 +0700
Message-Id: <31d4a9b2e8f29b8477be5a53890d86b28fe13f8a.1585197360.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.357.g1e1ba0441d
In-Reply-To: <cover.1585197360.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com> <cover.1585197360.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shell recognises first non-assignment token as command name.
With /bin/sh linked to either /bin/bash or /bin/dash,
`cd t/perf && ./p0000-perf-lib-sanity.sh -d -i -v` reports:

> test_cmp:1: command not found: diff -u

Using `eval` to unquote $GIT_TEST_CMP as same as precedence in `git_editor`.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 352c213d52..ab0e47ae17 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -905,7 +905,7 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp() {
-	$GIT_TEST_CMP "$@"
+	eval "$GIT_TEST_CMP" '"$@"'
 }
 
 # Check that the given config key has the expected value.
-- 
2.26.0.rc2.357.g1e1ba0441d

