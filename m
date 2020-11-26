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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85958C6379D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283A22168B
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1naS74b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgKZAQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKZAQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 19:16:22 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB406C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 16:16:20 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id v202so319652oia.9
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 16:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UaWiBJWw3BtW9QlipAAIVNtGE1BGaUW+gGrYJEvz0J0=;
        b=i1naS74blYKCMAAftAJ1m86T06oLR3N0BdNZ0yOl51jEUC69Zo9ETMtgOUbj+IZT+b
         siI+5v4VcFW/W1Zc1gRLOEhx58Awqdv9v64bGKtlO+wy6RHZDXTbILUGvXpZnQL4ngyc
         eKc2W/LTpCMCMC4dQOVtV4mwIi9utQBX2I8ZgIVj7fLEpJ0BRZcuYW0rZVstys+twxI3
         +cB9sgeI6jc2xNi2oA2cQsRYvzxOfQrB5Y2bQJiMgruuJ9jEDcuR2l/rliOg3YX1nviq
         YCuIguOv/juipPR0Cwsn2DIllkxhU5/T2vAHQ3PyUuK+MTunF5e20H8TVMTLwORHVI0Z
         NxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UaWiBJWw3BtW9QlipAAIVNtGE1BGaUW+gGrYJEvz0J0=;
        b=V+3s8OZDU6pYQeHc9N4f4hXa0oehohIKUd9UCxiY6ZviBwLHf6/uZPwtoeaTlCk3Mf
         QZcWtQ2ETOJnoUpIbZoSoXTRkA7ygW9pPMIgizseqcKa9VqjFcw4Xzzs6/xWtO2qfTTy
         R/jihGn0G36ZGWRzrXecu4IlRDGYoljM981uvc330jVRyw+brWjRJBgcxeJ0ozaSkRts
         1qiP2dp4UsyqFocqGyLdvjYV4A6FOMRh2YZUhgHp8fBV4cJBs9Q8kWt61DQxcZhZP43X
         sRemWZAAkrqA4p5N0OGPWR7hTEu7GrsR4Irm39ZkJLYkdEgfjdIBHhrdk2S+mLt/WPAg
         LboQ==
X-Gm-Message-State: AOAM533zWJvY9Y0ovzZjLKND+nUuvoNMH+LdA6/LdMoj2B7qymAWCvPv
        sHzQjL/DkMIEPOlj7R0ZNcpsDFiKSMkZ9Q==
X-Google-Smtp-Source: ABdhPJw9SeVrAHQQ1ofI7XdGh0OzVSiSblTMB9dkTARn0QjwfIJh+MjxH6lpQY9toJaFd0duvOILKw==
X-Received: by 2002:aca:c416:: with SMTP id u22mr446686oif.12.1606349780057;
        Wed, 25 Nov 2020 16:16:20 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m2sm2036749ots.11.2020.11.25.16.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:16:19 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 1/3] tests: push: improve cleanup of HEAD tests
Date:   Wed, 25 Nov 2020 18:16:14 -0600
Message-Id: <20201126001616.663910-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126001616.663910-1-felipe.contreras@gmail.com>
References: <20201126001616.663910-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So that we are not left in an inconsistent state between them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5516-fetch-push.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index d11382f769..4077471937 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -449,6 +449,7 @@ test_expect_success 'push with HEAD nonexisting at remote' '
 
 	mk_test testrepo heads/master &&
 	git checkout -b local master &&
+	test_when_finished "git checkout master; git branch -D local" &&
 	git push testrepo HEAD &&
 	check_push_result testrepo $the_commit heads/local
 '
@@ -457,8 +458,8 @@ test_expect_success 'push with +HEAD' '
 
 	mk_test testrepo heads/master &&
 	git checkout master &&
-	git branch -D local &&
 	git checkout -b local &&
+	test_when_finished "git checkout master; git branch -D local" &&
 	git push testrepo master local &&
 	check_push_result testrepo $the_commit heads/master &&
 	check_push_result testrepo $the_commit heads/local &&
@@ -488,6 +489,7 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 	mk_test testrepo heads/local &&
 	git checkout master &&
 	git branch -f local $the_commit &&
+	test_when_finished "git branch -D local" &&
 	(
 		cd testrepo &&
 		git checkout local &&
-- 
2.29.2

