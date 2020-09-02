Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95BBC433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82688206C0
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 06:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="m6Ctl2IJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIBGSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBGSD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 02:18:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59A4C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 23:18:02 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x12so2817476qtp.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0VberAqpc1x0Z+mFJnxBDTxTAo9C56gpsKF8M/TTdK4=;
        b=m6Ctl2IJe4lXVt6Dvv3mYdPq7KMPE0LFjF1uJ0jmf7lIVOT6Nqx2ClOIs5AEOgr0cs
         b9Tqiaw9ChyUD7EGwGKEobNk4RxbWSQ5OCRX/xMhcdkZaAkSN/FeZ+p/er1f4YkSzB6A
         C59XPNBxQ3bOBE50XYwklNj3MyEkd27r2EZknAQBlASP5nWIME8cRTfT/WM8xfYE39cs
         /6sUo/xt1yhI7uArCK5clNo9r4vgWAUz1BaCQ2Il0ZyQmfygU9Ux6BtFC55AKHA5YOkV
         e3v/4n4bPuxyC4wzriiFzltj+62rBb/SvkA0BRddWgdUK1TvNS7wXW/gjRe/LB+Z1fQi
         nl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0VberAqpc1x0Z+mFJnxBDTxTAo9C56gpsKF8M/TTdK4=;
        b=PN6N/cUpEqptOtKwwbxW/yMCcrRWk3RWa3cDXHaxYz4PSPtfx0wttOtuoLrVlJrHvE
         1RzROAnJUQP1GpfNmETItfTTz1NAigHudsuaVLfFajy7SGBtCOrvmkHVK9VGCVqK1uBO
         akpFmP7tlss6sTl1TXPbuAPdVGQvHikt33y58NOFoWeXb9FE3zZZT5LNMTRnsjyfWVD5
         ZFceyKgOcIa0qwuX73oD0lUDdGHLkLMR94Pl6Rit4PEu0DLLlLSCqUQS0iqMSVjt8goS
         T1FdJwqUaMDYFMeC0SFGZlUa4vdUVPQmhF3AMlmSvpKod3BFkEgSrqoAfgw4yRd8Xd4s
         qv8g==
X-Gm-Message-State: AOAM530maSKzUFr25PIDgyCc0uIsTRovMWZ+KODQsnx8kjtMMprAskfU
        cjbVPaZg6IX7nyvP7yWtAqT6UvhXy4Ir3A==
X-Google-Smtp-Source: ABdhPJzNUFa7cwbEL90qw5XoTceTEJjCT2TH70U6toDyMa1uM1JHeK9O6FG+PwPkz+BegAPFJR2MyQ==
X-Received: by 2002:aed:2a01:: with SMTP id c1mr208714qtd.24.1599027480927;
        Tue, 01 Sep 2020 23:18:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id x28sm3731234qki.55.2020.09.01.23.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 23:18:00 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, newren@gmail.com,
        jonathantanmy@google.com, jrnieder@gmail.com
Subject: [PATCH v5 2/8] t1308-config-set: avoid false positives when using test-config
Date:   Wed,  2 Sep 2020 03:17:31 -0300
Message-Id: <f53782f14c5f53da5d5537b369a810a94f9ce184.1599026986.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599026986.git.matheus.bernardino@usp.br>
References: <cover.1599026986.git.matheus.bernardino@usp.br>
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
positives, let's check test-config's output, in addition to the exit
code, and make sure that the cause of the error is the one we expect in
this test.

Moreover, the test was using the auxiliary function check_config which
optionally takes a string to compare the test-config stdout against.
Because this string is optional, there is a risk that future callers may
also check only the exit code and not the output. To avoid that, make
the string parameter of this function mandatory.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 t/t1308-config-set.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 3a527e3a84..cff17120dc 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -14,10 +14,7 @@ check_config () {
 		expect_code=0
 	fi &&
 	op=$1 key=$2 && shift && shift &&
-	if test $# != 0
-	then
-		printf "%s\n" "$@"
-	fi >expect &&
+	printf "%s\n" "$@" >expect &&
 	test_expect_code $expect_code test-tool config "$op" "$key" >actual &&
 	test_cmp expect actual
 }
@@ -130,7 +127,8 @@ test_expect_success 'check line error when NULL string is queried' '
 '
 
 test_expect_success 'find integer if value is non parse-able' '
-	check_config expect_code 128 get_int lamb.head
+	test_expect_code 128 test-tool config get_int lamb.head 2>result &&
+	test_i18ngrep "fatal: bad numeric config value '\'none\'' for '\'lamb.head\''" result
 '
 
 test_expect_success 'find bool value for the entered key' '
-- 
2.28.0

