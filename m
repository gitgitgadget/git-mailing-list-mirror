Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF23CCA473
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiGYMjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiGYMjK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780D1A39D
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f15so5281868edc.4
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPI7RG6IX6Vmd8NZqy2/Z6IvWRXlFLbEijFlWYx6eD0=;
        b=ET4Nr1MtvwP0yb8olIgjJ1HU3obbnfSvWu5lubmsYBLJWBB3zc4CDWkrehM505vspr
         fGiFbHNfwo38n1hU4asReNTBbkrna7lnl17WwigeSNTgOqEBkUgFl2ylyFKk4gnejclR
         n1TAgW6G/UC/Nju1eEFnk0V60x6VfIq9QkhXo+zqCGCHCYCuZZaz8YqddJAuD/XZzmRJ
         x4L9Ft8tzqwPw8+0HGV50llMHazi6ddP6ntIn8ZdI9OfhwDsQPa9+hyqkvyzf+7pWp8a
         UoS5ULtzIWbylMU2Vz8owurqEZBR+o1Hq3Oz9PPzFjSKOUoO78w3ykWD6JlG2cmOkSaT
         lxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPI7RG6IX6Vmd8NZqy2/Z6IvWRXlFLbEijFlWYx6eD0=;
        b=5TAZisp5Gn69UEeKz+05G7XvDzc2pALK1hCbba8LVulaSzSo06C5x1ffOErYmV75jv
         N8ajibW5C7YRylbhJhwGQMnK3TT5NWX9b4++t8Bc3866RszrsdZkAq1nYEXoVsComnel
         DYE943T3TXCqsjDoUtl9lk+kki5jRnrmRs6FdKg00EI2NzDRTfyjdXDpMNHcxWZNkp2S
         hupUla8IQwsrC/LCenND+P/qNehfuKvOEdOf1DrgLNc61LOFh9fVLaXvgJk4d0pVM8xU
         QhDE58TZ+mtJvWxg2UmQMsDIua50OBNyf+BpZ/fC/0K2Pt7p2w9OZV87Tv0eZl0fj6l/
         +Huw==
X-Gm-Message-State: AJIora/K0C/57uznpCv6Bm41TQmk+FsdBAsxynyqJBruWZIhCHzoZVbv
        R82IX8NQygGd2ucuQ8T/PATYOjsRyEc=
X-Google-Smtp-Source: AGRyM1t85SzwnYaR267UgaiVed3Mp2xOuVc8ZqJ5iWhSuR0ZvPTOmxG1soLHrAkCduBC34HAsGvt1Q==
X-Received: by 2002:aa7:d994:0:b0:43b:d187:69fd with SMTP id u20-20020aa7d994000000b0043bd18769fdmr12914737eds.201.1658752747922;
        Mon, 25 Jul 2022 05:39:07 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709066d5500b0072a4bb6bce8sm5204707ejt.168.2022.07.25.05.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:07 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 03/20] t5505-remote.sh: check the behavior without a subcommand
Date:   Mon, 25 Jul 2022 14:38:40 +0200
Message-Id: <20220725123857.2773963-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git remote' without a subcommand defaults to listing all remotes and
doesn't accept any arguments except the '-v|--verbose' option.

We are about to teach parse-options to handle subcommands, and update
'git remote' to make use of that new feature.  So let's add some tests
to make sure that the upcoming changes don't inadvertently change the
behavior in these cases.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5505-remote.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 6c7370f87f..f075dd4afa 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -241,6 +241,35 @@ test_expect_success 'add invalid foreign_vcs remote' '
 	test_cmp expect actual
 '
 
+test_expect_success 'without subcommand' '
+	(
+		cd test &&
+		git remote >actual &&
+		echo origin >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'without subcommand accepts -v' '
+	cat >test/expect <<-EOF &&
+	origin	$(pwd)/one (fetch)
+	origin	$(pwd)/one (push)
+	EOF
+	(
+		cd test &&
+		git remote -v >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'without subcommand does not take arguments' '
+	(
+		cd test &&
+		test_expect_code 129 git remote origin 2>err &&
+		grep "^error: Unknown subcommand:" err
+	)
+'
+
 cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
2.37.1.633.g6a0fa73e39

