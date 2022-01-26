Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E347C63684
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiAZNF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiAZNFy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:05:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5AC061747
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e8so23879133wrc.0
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lty5ZgHv/4ifEMj4n3iRiEVfuS0p7Kf8zkNE0EEf6nU=;
        b=ZMddRXpn4VubkeFRjLajXvvlBQV+wlCMQp6VcITMn+jSlqobxw6rLU2CY9weinXOlI
         oVefCZsVy5g972mbd4FiQInPS5ufm70GrZRbq3WQCIaQ9rqEvL/Wi9sVpGKsw1tdIIzG
         CSs/nXC6rYZxSAjJRdAFJlfhue/Sk6MmGWZ380E+7SWuOsM0JCFCM5LwyP9XvzMsOIcD
         WxBfST4Clz1Miz1Fa5uGReRRICfouyu12/AxpkEdQRM9LoTYSqhs6tJAp0szjlhBxYqI
         UbCvqF1vNSDpATL752KWbUIFy6mQf9wfJWYabXvkdK/5xvdmZvA/EIM+T0pcU1Ymo8CR
         RDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lty5ZgHv/4ifEMj4n3iRiEVfuS0p7Kf8zkNE0EEf6nU=;
        b=oTxwpAPrPDgj71CJnpIeWoGh+8qnhHlDGpAX1lSuGgqmYRj4uQk2U6RtYsJt9kucd5
         vCTCemhRt0h9tDo9Rxfz66yr/Rd8jYursxu05i0wl7KsB/5Vl3PntMEzCgLybhPM1WsA
         zpVzuKuHV5qYJdQ20uBE4GmMavUMLOrQbQdCbjeo0P3ADxSY7T5mSj6twiS6jd15pfcI
         sSoAUyPwfe/DUI9/v53MIkU3LBwRZB0OB78FIzLDQ+PXmQurTkyYCNU7+FhCU9Bdo/+G
         lyRIRjZpBqfUG2LJ/dZ3ZMMwzAwYCfnKVSgqdgUorMeULqbjV73MWob7U0pfJAYchUzz
         bVYg==
X-Gm-Message-State: AOAM530EI4Rm4IklGSGThd0jhKLMc57DKzTkR0WQ/QDinge2Vqu5wyT7
        wZxdEY8BMWGjqzm4NOOf7eBYXw43U1M=
X-Google-Smtp-Source: ABdhPJw2w1gj7BibVhJ2zi5Qxtycz59ieepHz8MKaMY54Z4OSiH2BNMkC6baiWFbH1lb4NObXRrnDg==
X-Received: by 2002:adf:f6d1:: with SMTP id y17mr21753975wrp.242.1643202352586;
        Wed, 26 Jan 2022 05:05:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i13sm4323801wmq.45.2022.01.26.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:05:52 -0800 (PST)
Message-Id: <a67a5a03b94ccbaec85da2c93ce5bbffcd5cfac9.1643202349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
References: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <pull.1049.v3.git.1643202349.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jan 2022 13:05:37 +0000
Subject: [PATCH v3 02/14] t5403: refactor rebase post-checkout hook tests
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

