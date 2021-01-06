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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFCC433E6
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BFA2310D
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbhAFKCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhAFKCp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 05:02:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EBDC061357
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 02:02:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t16so1881017wra.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 02:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+vOJQsMft5q7E3s72vyMd4bot26X4jcMwe0TiApWEQ=;
        b=lmW0JKYCfSTbguUDkLGU7W9++VMU1wsf+4Itg5PaUN6Gu3AgMnOebaiDfPqr2OBzoU
         7TjqTW39xsmuE9m4kX8ZqZppedfU84VA5sP8fBuG47UiWjilaDx5gEgtLxY3fkD8NSkV
         rgoKTyyu+L9aX7vuPtajRpXUQYFAdAiD7MsGvlIso11zvUG/4weTt/Y0EcVGZOkQjvGA
         PDS8M6MJIA/WOSEhNSBE2hrfIeeRnJxVeh7RulpHH3B5PB1PZMm9oEe2OaO371VqoWJ8
         rbzq16tHqJPUwpLg76n0/iSqQXgLAC7J/4eRYMOtuo/tKS9iOfyFRc/ruuG90OJjAn/q
         ubRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+vOJQsMft5q7E3s72vyMd4bot26X4jcMwe0TiApWEQ=;
        b=OwYqtn7VfXCbmAA0KCHwtjx3XvSGU4+SySi6QVd0osUkaqbZHZWHhvVnipmd7MuIno
         1S1CxBWB7j+z9hPXg+P9ek6vIZyNuoQRKYKBw4xTkOlZxu6dlNICp0MdqG5sQ8XWtUlH
         pWXhibMTrgbbVXzgmliXgYiaPM7NUi1aMRDhQVmX91Dtwem2CmuUQQJ5ulxccg2tLKI6
         DJ/e9EChM1bkcmrqLx57p21UcgYBQI0CLSq2JK8ylX7xTRprDw3/Le2HDEFjvucpFQBf
         hzwXhOGbAue7ynJEsvLD2zeVPxyFrbR43G/I+Sef9c2ScNJYx5FPixx5IDrwQPwkmY7B
         YmoQ==
X-Gm-Message-State: AOAM531+R1/IzKC0+dnhG3qEuS/diZBSi87e9Dpd1uAgeqK/7aUatV7W
        Fy7aXcBYrGYEKu43RPWND5rrDGTHnfPi8A==
X-Google-Smtp-Source: ABdhPJyXdMlTNsDF3gtPgZEdfIEjyw4kkYiVFLopTetszl5y7BU9UfrekaF3PbgZEtg2v/mRqsV/Ww==
X-Received: by 2002:a5d:4e92:: with SMTP id e18mr3704263wru.66.1609927323196;
        Wed, 06 Jan 2021 02:02:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r13sm2538637wrs.6.2021.01.06.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:02:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>, git@matthieu-moy.fr,
        olyatelezhnaya@gmail.com, samuel.maftoul@gmail.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] branch tests: add to --sort tests
Date:   Wed,  6 Jan 2021 11:01:36 +0100
Message-Id: <20210106100139.14651-3-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
References: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Further stress the --sort callback in ref-filter.c. The implementation
uses certain short-circuiting logic, let's make sure it behaves the
same way on e.g. name & version sort. Improves a test added in
aedcb7dc75e (branch.c: use 'ref-filter' APIs, 2015-09-23).

I don't think all of this output makes sense, but let's test for the
behavior as-is, we can fix bugs in it in a later commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3203-branch-output.sh | 51 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index b945faf4702..f92fb3aab9d 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -210,7 +210,7 @@ EOF
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'git branch `--sort` option' '
+test_expect_success 'git branch `--sort=[-]objectsize` option' '
 	cat >expect <<-\EOF &&
 	* (HEAD detached from fromtag)
 	  branch-two
@@ -218,6 +218,55 @@ test_expect_success 'git branch `--sort` option' '
 	  main
 	EOF
 	git branch --sort=objectsize >actual &&
+	test_i18ncmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	  branch-one
+	  main
+	* (HEAD detached from fromtag)
+	  branch-two
+	EOF
+	git branch --sort=-objectsize >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'git branch `--sort=[-]type` option' '
+	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
+	  branch-one
+	  branch-two
+	  main
+	EOF
+	git branch --sort=type >actual &&
+	test_i18ncmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
+	  branch-one
+	  branch-two
+	  main
+	EOF
+	git branch --sort=-type >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'git branch `--sort=[-]version:refname` option' '
+	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
+	  branch-one
+	  branch-two
+	  main
+	EOF
+	git branch --sort=version:refname >actual &&
+	test_i18ncmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	  main
+	  branch-two
+	  branch-one
+	* (HEAD detached from fromtag)
+	EOF
+	git branch --sort=-version:refname >actual &&
 	test_i18ncmp expect actual
 '
 
-- 
2.29.2.222.g5d2a92d10f8

