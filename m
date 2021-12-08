Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED2EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 14:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhLHPBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhLHPBi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:01:38 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0AFC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 06:58:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso4342021wmr.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 06:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lty5ZgHv/4ifEMj4n3iRiEVfuS0p7Kf8zkNE0EEf6nU=;
        b=mmL7lcqkiTfZg+bg7iIAcr5u0DIIsCNQdPdr6GNvRsG7rfdZ2BpcYI47xIq01VVQuY
         ZUedSN0tozcaTYYXXpKrjTWyQ++ouakdz4WdlmwGNptrd9EIEw8c8r4md7LRXrDkXZ3N
         +8MAS6Kz5IRdaoimQg+m1Kr9qCSbARCgmAXGjZbqXVx545CojzEmjTYaPwzKk5AtRQVV
         8fxkiDfpCF20uQLV3dI1MhHLnx6qjrb07JPHJ3TiQ3W5pNnCsByNMj4r/lnHKcxj8FEt
         yoBnq3pPpy+Fkkzsr/1BlUEhWVHJ+yRxIIX9JYBxcElMRZ5u2wdC9Dkmhs4ec9AHDFyH
         C/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lty5ZgHv/4ifEMj4n3iRiEVfuS0p7Kf8zkNE0EEf6nU=;
        b=Hiv/9c4hJALLxV1GB1J7pcl/iFS8SkBKJn3Y2et6LkmifN+7lyNHxV559hFCQ+y7DA
         8bRb1O2Z23zx6hP2NgIEttKcF8/lCrCI85K/XekF6oga2iN1DCvS4Gd7Sb9oe0MpZg4R
         TgrcKELYFc/47ZKL4mNc0uF0vBWxLl+qR+ek6mm8hxqwaOjeUeFyNEpEhu8CM2rxp5hW
         zt02SwYIJq5t09UAHL1gGaLiSaTLeT0xS83EFmrArM5bd4k3rKTqpNVcoTlbOXej6cY8
         RjzsNDsyimrhaD2N4FYG4wbVeVmrgzvYYlvreVPXND85nG9XLhfXi21P0cOoSSPGYW0+
         iHTQ==
X-Gm-Message-State: AOAM532nW6yvtXftmY12gjLUAayChYdR83HpGNsqqxDKyyvTTHCzXGYy
        6Kio+ABt7cuG3RrJKy5Its02wnuri9Y=
X-Google-Smtp-Source: ABdhPJwe1XZLgLqUoNq1xTpeZgYtXEsB9AVejH/bHvPcS32gHlmoQa+9t2f04tLPG09ahggu9epipA==
X-Received: by 2002:a05:600c:34c2:: with SMTP id d2mr17432925wmq.102.1638975484811;
        Wed, 08 Dec 2021 06:58:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm2833226wrz.22.2021.12.08.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:58:04 -0800 (PST)
Message-Id: <a67a5a03b94ccbaec85da2c93ce5bbffcd5cfac9.1638975482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 14:57:49 +0000
Subject: [PATCH v2 02/14] t5403: refactor rebase post-checkout hook tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

These tests only test the default backend and do not check that the
arguments passed to the hook are correct. Fix this by running the
tests with both backends and adding checks for the hook arguments.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t5403-post-checkout-hook.sh | 42 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 1ec9e23be75..272b02687ba 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -49,23 +49,33 @@ test_expect_success 'post-checkout receives the right args when not switching br
 	test $old = $new && test $flag = 0
 '
 
-test_expect_success 'post-checkout is triggered on rebase' '
-	test_when_finished "rm -f .git/post-checkout.args" &&
-	git checkout -b rebase-test main &&
-	rm -f .git/post-checkout.args &&
-	git rebase rebase-on-me &&
-	read old new flag <.git/post-checkout.args &&
-	test $old != $new && test $flag = 1
-'
+test_rebase () {
+	args="$*" &&
+	test_expect_success "post-checkout is triggered on rebase $args" '
+		test_when_finished "rm -f .git/post-checkout.args" &&
+		git checkout -B rebase-test main &&
+		rm -f .git/post-checkout.args &&
+		git rebase $args rebase-on-me &&
+		read old new flag <.git/post-checkout.args &&
+		test_cmp_rev main $old &&
+		test_cmp_rev rebase-on-me $new &&
+		test $flag = 1
+	'
 
-test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
-	test_when_finished "rm -f .git/post-checkout.args" &&
-	git checkout -b ff-rebase-test rebase-on-me^ &&
-	rm -f .git/post-checkout.args &&
-	git rebase rebase-on-me &&
-	read old new flag <.git/post-checkout.args &&
-	test $old != $new && test $flag = 1
-'
+	test_expect_success "post-checkout is triggered on rebase $args with fast-forward" '
+		test_when_finished "rm -f .git/post-checkout.args" &&
+		git checkout -B ff-rebase-test rebase-on-me^ &&
+		rm -f .git/post-checkout.args &&
+		git rebase $args rebase-on-me &&
+		read old new flag <.git/post-checkout.args &&
+		test_cmp_rev rebase-on-me^ $old &&
+		test_cmp_rev rebase-on-me $new &&
+		test $flag = 1
+	'
+}
+
+test_rebase --apply &&
+test_rebase --merge
 
 test_expect_success 'post-checkout hook is triggered by clone' '
 	mkdir -p templates/hooks &&
-- 
gitgitgadget

