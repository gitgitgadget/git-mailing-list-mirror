Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C340EC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiGAKiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiGAKhz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:37:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EBD70E4E
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so1325088wmb.1
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJEbKCiMRVyYD1ZK/CPnJ3T5Sv6LQ3KX3JhCBC38oTw=;
        b=HwDr7n833LCLfUfz7NjNa2Z9vU/lOEhYif9EFltxLQpRQEG8BFDjxt7m9uO3PR5t4P
         8Dhl2+yvRDx7DPaAp5hE7Dtu0xB711cATu6wPHg/cotOPxr+d8+Nwo5KuLLS8Oe3DLQc
         JXI3B1wcECywDby58fHtSz2lJfDDQ+c7Qd5jelLPDqrD2k41r3tIn1zMkZCnb2UFy6am
         Sn30l5s+Yo1lZXnkA+fnzF9Grr8ZPb3Ggvo3kqcCEOITcq0jLUwGYGoTOOm1uWzBx8HZ
         f8Uux80mHcvjJ4U4m5S+6xiET0hBXdOSa5MDZTIjpjumlhFIdeI/3EUmLiKUXyt9Lgc5
         MMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJEbKCiMRVyYD1ZK/CPnJ3T5Sv6LQ3KX3JhCBC38oTw=;
        b=CEtPwLzWd389dEknK2V5VxHxHaqAA/VTyHghxBU6a4l1df0doT0RKPksq06SfY+vOi
         stBoFHD5O17WEJnSudbFfUuSX3iM3XCBXvRFhQDUKv+vXemo8M7ftmLRRwU7PIW91wVM
         s2wkv8hGbinSw8UXtkDSvRygM3MuZjRCW00qJZTeFrL1+WdKbRtkcxAvzK4pFnU8Cr4/
         M9emrzgO8RJmiSw6PnD4DYCxUGCJ8spDxl4obNezGJ9A2Gp2G/ZkGsLkRM0IkTDJQEIE
         3j3odozXTPibWfm0TpRHUc4vHe896Hy1/WT/PKJqX7MA+RFSx7p3o3//VEyOg0wa7Qot
         +Q7A==
X-Gm-Message-State: AJIora9NZiTNyxo9/nfP39OQA+yW7dKGPI2oU++yuLHODGhmaZMEH6S1
        z99NKFwV3rd8QVTIqbCTlRgxzudFq6OLiQ==
X-Google-Smtp-Source: AGRyM1umENE07WMv6J0AuJaPnL7PlYlIAntbwrsvZcMviYeleVf7qH2Jk8ardIhd6g2czc3ZwCOpHw==
X-Received: by 2002:a05:600c:1d96:b0:3a0:30b6:bb1a with SMTP id p22-20020a05600c1d9600b003a030b6bb1amr16954477wms.93.1656671872525;
        Fri, 01 Jul 2022 03:37:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/9] test-tool regex: call regfree(), fix memory leaks
Date:   Fri,  1 Jul 2022 12:37:36 +0200
Message-Id: <patch-v2-5.9-940cd5378ad-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in "test-tool regex" which have been there since
c91841594c2 (test-regex: Add a test to check for a bug in the regex
routines, 2012-09-01), as a result we can mark a test as passing with
SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true".

We could regfree() on the die() paths here, which would make some
invocations of valgrind(1) happy, but let's just target SANITIZE=leak
for now. Variables that are still reachable when we die() are not
reported as leaks.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-regex.c           | 9 ++++++---
 t/t7812-grep-icase-non-ascii.sh | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index d6f28ca8d14..bd871a735b4 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -34,6 +34,7 @@ static int test_regex_bug(void)
 	if (m[0].rm_so == 3) /* matches '\n' when it should not */
 		die("regex bug confirmed: re-build git with NO_REGEX=1");
 
+	regfree(&r);
 	return 0;
 }
 
@@ -94,18 +95,20 @@ int cmd__regex(int argc, const char **argv)
 		die("failed regcomp() for pattern '%s' (%s)", pat, errbuf);
 	}
 	if (!str)
-		return 0;
+		goto cleanup;
 
 	ret = regexec(&r, str, 1, m, 0);
 	if (ret) {
 		if (silent || ret == REG_NOMATCH)
-			return ret;
+			goto cleanup;
 
 		regerror(ret, &r, errbuf, sizeof(errbuf));
 		die("failed regexec() for subject '%s' (%s)", str, errbuf);
 	}
 
-	return 0;
+cleanup:
+	regfree(&r);
+	return ret;
 usage:
 	usage("\ttest-tool regex --bug\n"
 	      "\ttest-tool regex [--silent] <pattern>\n"
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index ac7be547145..31c66b63c2c 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -2,6 +2,7 @@
 
 test_description='grep icase on non-English locales'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 doalarm () {
-- 
2.37.0.900.g4d0de1cceb2

