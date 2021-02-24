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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0600C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5611964F06
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhBXT4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhBXTx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:53:57 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D8BC061221
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:09 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d11so3037821wrj.7
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qmS9PrfdhIeIeFeP3x40mGKAshC9wGUO7SYkvYbIEk=;
        b=XeqF8G6Bruv7YnqaG1CcVGnS4Q6+jtXWPhwfYoM61Qo+/CsaTf6Fn2Fys7L4v+6U+q
         pdxu7xI6yaYuzTsosd0To2PLeal9X76USsnxPSvf2ty/F5H0zjGpRlXY7Wq2grHzNUCP
         FYY7NalLuMZIShcIh6D9UIg1m+Ox7Jq+OCgrHhR0oROCQTb1YFgezMsETACRhr1oSeJy
         S+1a8Pskz1LlLia03AORATg3EYN/p3+itZxXiTWzpxxvD/kZTrwGLEPhNmXMEMIjuKML
         tILdlbxTFqth3+NmxzDf2xaZ1PG7IB6DpSvVQkLw2e35y0IxUxPHuT6z//Y7qT0rG+hk
         w8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qmS9PrfdhIeIeFeP3x40mGKAshC9wGUO7SYkvYbIEk=;
        b=mZ6yE8BoIf+WM7NKDUpxoDEWu7QUAGuSNdKxHg35N3JBXQ7ccrgpPBsev7Ake6gtn2
         yAOtml7YyMDHOh4+CaSpVQboqLPJvfT+Frss7AkFexTLkTkyhAjUx9+EZek4Oo4dDh9P
         M4reZtivpqGxKjdgi213pC8745radbCxHQcIgRMMjFXSZrJtrpuKcTkQUq9x22dhtEb6
         jyxE8zJY2Orjb/rairYSFjHrbUkJ/ynrR2fZze+mrHQrOvBao3JYiNqWSH5rX4/lglWj
         WvltVIlCELHomYHIkTtVhHHOy5dZgcsTBHxCi28zjGxQ99AkteuPxVwFwUE9kx0jbTeG
         Mgtg==
X-Gm-Message-State: AOAM531oLth0ei66rhgN9HGD6IbDADwGTrppB3Br8i5YgeZbM6jo0YiK
        P9Dw4zkMlbG3LdDpVAbmHuW8KzV62S8faw==
X-Google-Smtp-Source: ABdhPJxwImwfjJ+3Z4eqKCMBJB45Tc61Thwg6ubu32YdxGkhOZi+xolJOTLxhkKhfN3j22liSd0l0g==
X-Received: by 2002:adf:f211:: with SMTP id p17mr24377133wro.346.1614196327815;
        Wed, 24 Feb 2021 11:52:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 18/35] userdiff tests: remove hack for "RIGHT" token
Date:   Wed, 24 Feb 2021 20:51:12 +0100
Message-Id: <20210224195129.4004-19-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the "RIGHT" token isn't how we select the desired hunk header
line in the test anymore we can revert a hack added in
f1b75fbaf1 (t4018: convert custom pattern test to the new
infrastructure, 2014-03-21) and go back to the regular expression we
were testing before that change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/custom.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 59d855c01c5..b208a771d28 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -33,14 +33,14 @@ public class Beer
 EOF_TEST
 
 test_expect_success 'custom: setup match to end of line' '
-	git config diff.custom.funcname "......Beer\$"
+	git config diff.custom.funcname "Beer\$"
 '
 
 test_diff_funcname 'custom: match to end of line' \
 	8<<\EOF_HUNK 9<<\EOF_TEST
-RIGHT_Beer
+Beer
 EOF_HUNK
-public class RIGHT_Beer
+public class Beer
 {
 	int special;
 	public static void main(String args[])
-- 
2.30.0.284.gd98b1dd5eaa7

