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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E41C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3486A64E74
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhB1T4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhB1Tz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A1FC0617A7
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b13so8749037edx.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kjEJRnzoURDSPkSV1D6hu2Z2a33+WTPK5d4In75OYs=;
        b=gX4npLyEh0PaqE2z2/EY15kWsr+XG1HSQp8/JXHKZhb8Mt4jIhbH878OGinkQdg3OG
         TP3AshSUzgCAPN8nNatCfOTDFje5jRL6+Rwzziv6JA4BeGqYBzYicG0Y4CR2PTmWmJk2
         k0QQnT5SJZW2MotoUZoUl+nwBwXeCo0YuynEZRtXqJtpZzsacN3fCc9MGY5e77seyjRN
         cGGG2CdjSYOKw2S0q6H1O3IjbnVNy2Db+iQfpSs1XiN7+cfENXDtt2p3/DBVWaQrapRN
         XPYlBXVqqefAWK18ShS5PBgTGpvq9XyYvlLcudtG8rfMEfCIlcIOm/XhZgSXzOB3t7pN
         4e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kjEJRnzoURDSPkSV1D6hu2Z2a33+WTPK5d4In75OYs=;
        b=Unkjm8gzcwFaAI0g+GTF/40+r2H+NSWJrzw3VLETcm9vFsIn929eV9a14hJ3GpvBUI
         nc7onLaRlOFQbHBc/mcTCbE27KtAwmc6jBH7ryaUsSUsomJbEZzL6rUI3/jcQ3SQZnE6
         5wK52rWddXLjG/f5I1AWcqAJXswemcCQdlQJ4lA3HfBU909q5v/8AZqj2+R9RPnzNYPz
         fIb1XdD84sE/aMpq+GREBkdw/qRVHNTnSRpVcn+695cuyk8sDgdqDBrtnxgyzaF6Pi2L
         57VWGfglu9NGbH+y8yRvf+HllKinQGn7zX6ukjKGPAjpLlTSlsonv1zEnVJII8ex1/1x
         uBuA==
X-Gm-Message-State: AOAM531bIUoDxkoyyo7x7pE4HSicTzGJwmTmtXlqkpXG/iQPqjOTnGlu
        EscAm2I8jpPARYZKVBq7m1SAskt0+1LTMA==
X-Google-Smtp-Source: ABdhPJxlgEhhfkEdkGUGHYrtQBkhbVMAfvzdKLZrzrP3Fj8++wFErv/OjRYzhc0kCYL7pfgvK62afA==
X-Received: by 2002:a05:6402:2707:: with SMTP id y7mr12863640edd.5.1614542081995;
        Sun, 28 Feb 2021 11:54:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/10] test-lib: return 1 from test_expect_{success,failure}
Date:   Sun, 28 Feb 2021 20:54:14 +0100
Message-Id: <20210228195414.21372-11-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An earlier commit fixed an issue in "check_describe" with
"test_expect_success" being called within another
"test_expect_success", causing the test to succeed even if it should
fail.

Let's try to guard against this in the test library by returning 1
from these two functions. This change would have caught the issue I've
now fixed in the "check_describe" function.

I could equivalently add this "return 1" to the "test_finish_"
function itself, but I think doing it here is more readable.

Because of this change any tests which ran under "set -e" needed to be
refactored not to use "set -e". Luckily there were only two such
tests, earlier commits did that refactoring.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c6cdabf53e..3dd68091bb 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -636,6 +636,7 @@ test_expect_failure () {
 		fi
 	fi
 	test_finish_
+	return 1
 }
 
 test_expect_success () {
@@ -656,6 +657,7 @@ test_expect_success () {
 		fi
 	fi
 	test_finish_
+	return 1
 }
 
 # test_external runs external test scripts that provide continuous
-- 
2.31.0.rc0.116.g45ec00aa00

