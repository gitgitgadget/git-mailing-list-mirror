Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E2CC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7F561165
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhHYCXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbhHYCXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:23:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED1DC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h1so9704389pjs.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r0d4YQsFc37dzg9Th5FxMivQJQ7VL1aQx42dqW780Iw=;
        b=uvJDnR0ybNQqJQZbiZv3C5Wo6L9R4Zr5l0IXPBCO0MkLAGyE7RvyLGyrRVvhSXEugD
         AbaLMDfdVSj6I60MT/AffpI1hDyUzPbcwgDIOPz7VESM8WICY/roDYZRgDqFwU0wgKb4
         40RzK9yzKHHmxsVy3b/qo/rWP1FHFpD/zsG8cJ/yZ8cJO/APixL87p9N1LwS+GIEA7gU
         YS11CSUH6SIyjnfHMXc/DGSskecLrc+XSYF+/tz+4jGZJdVi4zARrfcgQf0SeiabN1mC
         +cGmo0qhfndTNHw6ynXsa7QsJHfn0df/9FEs6AdzTM5qFtWNPuZATUzN/mlgy42aOd7N
         SKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r0d4YQsFc37dzg9Th5FxMivQJQ7VL1aQx42dqW780Iw=;
        b=tdvZyyHYLw5R35KXw1H3OjzgWcHa2ri+G6noJwRpk89mFQcQghxOX3ZnHAmahhOPgi
         A/pX09M0VH/1Rs7//RRORGs2iqhl8m8/FJxYMoMBqV7O8GXbdo1UhCrsS/uobHEckM3A
         8bw7JRux0cPr9zhiu/hrnazkksH6XKXrOZE9+e08KVfSsZTWgTyllo/xhzG3K8xIbhFI
         U8hVZYSKMcd/LPgXprHN4ijJxubb+q161ldMX/SMx4JdpiMrEf6cwQL4WLq0umP9cEG3
         sTk2e1NZNyI6Ea9e+tP/AVToWKXQOcYKFFAF7/dlhGOZ8ec5vlAwxJjlglgW6WnKvddI
         QTnQ==
X-Gm-Message-State: AOAM5309QUmxRc+F9jCGYSwi/gbkkroM9iXtpxNLfTIZNxBwzZwyCNtN
        3AtExuHPcb9XUOSPH8hPGB0=
X-Google-Smtp-Source: ABdhPJwxKNA5ICFwBFSnxes1H58wgoj/SUhrR2DlksKjta7WinFBPLD6WCRMzW2u0P88BYEFgvXuvg==
X-Received: by 2002:a17:902:e8ce:b0:132:b140:9540 with SMTP id v14-20020a170902e8ce00b00132b1409540mr16735161plg.28.1629858142170;
        Tue, 24 Aug 2021 19:22:22 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id e14sm3628683pjg.40.2021.08.24.19.22.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Aug 2021 19:22:21 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com, dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
Subject: [PATCH v5 06/14] t5702: replace with "test_when_finished" for cleanup
Date:   Wed, 25 Aug 2021 10:21:50 +0800
Message-Id: <f3b1cba7e102b3132f04b27be48e532da7d448c9.1629805396.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.gec51e24953
In-Reply-To: <cover.1629805395.git.dyroneteng@gmail.com>
References: <cover.1629805395.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t5702-protocol-v2.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2e1243ca40..e6314b53b0 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -753,7 +753,7 @@ test_expect_success 'ls-remote with v2 http sends only one POST' '
 '
 
 test_expect_success 'push with http:// and a config of v2 does not request v2' '
-	test_when_finished "rm -f log" &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
 	# Till v2 for push is designed, make sure that if a client has
 	# protocol.version configured to use v2, that the client instead falls
 	# back and uses v0.
@@ -776,7 +776,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 '
 
 test_expect_success 'when server sends "ready", expect DELIM' '
-	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child" &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
@@ -796,7 +796,7 @@ test_expect_success 'when server sends "ready", expect DELIM' '
 '
 
 test_expect_success 'when server does not send "ready", expect FLUSH' '
-	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
@@ -834,7 +834,7 @@ configure_exclusion () {
 
 test_expect_success 'part of packfile response provided as URI' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -883,7 +883,7 @@ test_expect_success 'part of packfile response provided as URI' '
 
 test_expect_success 'packfile URIs with fetch instead of clone' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -904,7 +904,7 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -935,7 +935,7 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -959,7 +959,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -989,7 +989,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 
 test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmodules is separate from tree' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child &&
+	test_when_finished "rm -rf \"$P\" http_child" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -1015,7 +1015,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodules separate from tree is invalid' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child err &&
+	test_when_finished "rm -rf \"$P\" http_child err" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -1038,4 +1038,4 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-test_done
+test_done
\ No newline at end of file
-- 
2.31.1.456.gec51e24953

