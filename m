Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F87C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC86420770
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="RtViOGYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIJRW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgIJRVy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:21:54 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7810EC061786
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:53 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id q10so3734108qvs.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4f1kw0Re5Sk3KDMu/uikPLoRDuLXA2hNMJrYbQ7PV7U=;
        b=RtViOGYk1iIAFsB9FI4omHOXpN+P2W2EZfkTPxz9AeJaeumlWbadYz5rP3jW+u3nLi
         2dy8JyRNZ3MuARBewcSm1fc8Z9Ry0m9EZat8b8sOUqm/qZKKSsAxSysKk5OJrGX3g/4q
         xZCuwQ8q8nRFoLcGXVrvsEhgMyxetNAbWy4Gx4h8JbATanbHM0JWSi/QRLyvsAZD4gX5
         d6cwr034SPOQIGPNUdapuSDjLTmtrrGhXMqXYY37hY4fLmlEW/2mD/ZfwUConi9F1Yy8
         OYryn5ZIjhfhGyLXCL8rwT8cGNe2VdSQcbfs3gyiwZ1pqQlZqVzYWugjMjV+2bIHBJLc
         qTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4f1kw0Re5Sk3KDMu/uikPLoRDuLXA2hNMJrYbQ7PV7U=;
        b=K1h7h2ax42AiNVLwy1tmkE7K8oMRtoU5CxGqNMVMuhMWmiKvI8CZqOcr9BmXldJJlg
         m2HG0nBGwCQooFRVelJh4Xb+wPgIaaZyRepz5L2TOHvlSwqhKzRbe7u3zA6p9JeZ1azt
         4yUUMMNe6YSqAewdUW4KRpwRmk2e3i1NG4OESrHuU8v+UweaGxy+MmsNYOqrBn7CJg7J
         fCC/CWcwfvJiMXjRHwACPaz2Mp3/aUGXAXYrR1kT5BIniWfVBH87z95HbIyx6wqEOn2F
         lzim+l4brrtR/M0cPgqUwvm8IYLCl7HBCTR/NDAe64SF/kunaNmFGKIligkqX7r0sKSq
         n4xA==
X-Gm-Message-State: AOAM531aYhxR7QXqSErbQpD/oiyMGHEEnfvNO9NysSMuyAytXJ2KdDxJ
        +otALyYt1PpUIQSHluMQU+ElrULlXEBxnA==
X-Google-Smtp-Source: ABdhPJwUhzH/NgX37ZGrg1zFOptpbvzBCqSxKdTzRJWWZtO5pAClxaSf2HczNeOAU569fHF5Z1JuHw==
X-Received: by 2002:a0c:b2d4:: with SMTP id d20mr9639349qvf.1.1599758506608;
        Thu, 10 Sep 2020 10:21:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id h18sm7037437qkl.12.2020.09.10.10.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:21:45 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v6 2/9] t1308-config-set: avoid false positives when using test-config
Date:   Thu, 10 Sep 2020 14:21:21 -0300
Message-Id: <3c2d722152575d8a4f7aa01d958823a66c5ba26e.1599758167.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599758167.git.matheus.bernardino@usp.br>
References: <cover.1599758167.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One test in t1308 expects test-config to fail with exit code 128 due to
a parsing error in the config machinery. But test-config might also exit
with 128 for any other reason that leads it to call die(). Therefore the
test can potentially succeed for the wrong reason. To avoid false
positives, let's check test-config's stderr, in addition to the exit
code, and make sure that the cause of the error is the one we expect in
this test.

Moreover, the test was using the auxiliary function check_config, which
optionally takes a number to compare with test-config's exit code, and a
string to compare with its stdout. Because the function does not check
stderr, it can induce improper uses, like the one corrected in this
patch. To avoid this, remove the optional expect_code parameter,
disallowing tests that expect an error from test-config to use this
helper function. There is one error, though, which is printed to
stdout despite returning a non-zero code: "value not found" (exit code
1). For this one, let's add another function which properly checks
stdout and the code.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t1308-config-set.sh | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 3a527e3a84..66c6363080 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -7,18 +7,15 @@ test_description='Test git config-set API in different settings'
 # 'check_config get_* section.key value' verifies that the entry for
 # section.key is 'value'
 check_config () {
-	if test "$1" = expect_code
-	then
-		expect_code="$2" && shift && shift
-	else
-		expect_code=0
-	fi &&
-	op=$1 key=$2 && shift && shift &&
-	if test $# != 0
-	then
-		printf "%s\n" "$@"
-	fi >expect &&
-	test_expect_code $expect_code test-tool config "$op" "$key" >actual &&
+	test-tool config "$1" "$2" >actual &&
+	shift && shift &&
+	printf "%s\n" "$@" >expect &&
+	test_cmp expect actual
+}
+
+check_not_found () {
+	test_expect_code 1 test-tool config "$1" "$2" >actual &&
+	echo "Value not found for \"$2\"" >expect &&
 	test_cmp expect actual
 }
 
@@ -108,7 +105,7 @@ test_expect_success 'key with case insensitive section header & variable' '
 '
 
 test_expect_success 'find value with misspelled key' '
-	check_config expect_code 1 get_value "my.fOo Bar.hi" "Value not found for \"my.fOo Bar.hi\""
+	check_not_found get_value "my.fOo Bar.hi"
 '
 
 test_expect_success 'find value with the highest priority' '
@@ -121,7 +118,7 @@ test_expect_success 'find integer value for a key' '
 
 test_expect_success 'find string value for a key' '
 	check_config get_string case.baz hask &&
-	check_config expect_code 1 get_string case.ba "Value not found for \"case.ba\""
+	check_not_found get_string case.ba
 '
 
 test_expect_success 'check line error when NULL string is queried' '
@@ -130,7 +127,8 @@ test_expect_success 'check line error when NULL string is queried' '
 '
 
 test_expect_success 'find integer if value is non parse-able' '
-	check_config expect_code 128 get_int lamb.head
+	test_expect_code 128 test-tool config get_int lamb.head 2>result &&
+	test_i18ngrep "fatal: bad numeric config value .none. for .lamb\.head." result
 '
 
 test_expect_success 'find bool value for the entered key' '
-- 
2.28.0

