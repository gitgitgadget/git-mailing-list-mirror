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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798EFC56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3107F20872
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFhDhOdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgKYXes (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgKYXer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:34:47 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F01C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:34:47 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id o3so307054ota.8
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UaWiBJWw3BtW9QlipAAIVNtGE1BGaUW+gGrYJEvz0J0=;
        b=fFhDhOdq9y0TXFpnIVMShbvWorLqHApWpUI1dqiWnbbWTg4zu6hQcbspL/wyirzLl/
         TJb7ClPgrg+OUgdsZybsKUVdlDlJeiXitkjaM7a6HEkc3X0fjwr4cPsMOitLEURRsnaK
         ZVfYunJK255u8BVHSRX4p+vn69cPeRHFDCJqxT5Qj64Gho5o51u/3MM3/y7ueftxwq6j
         BcjEMrvHuek9hril9c8m0Ut3A5mxG/0y0pY0aOD1SkoE5eEeymBLa+AAYKuz/XTmTsyv
         jhtmsIPKJaRU1boDtlTCIaUKZOHdYvIOeYXMJhW1iwByEFbS3Pyh3pvLI5LytfqlDFQ3
         d9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UaWiBJWw3BtW9QlipAAIVNtGE1BGaUW+gGrYJEvz0J0=;
        b=JxaLRXZ9D/NGK01JJmGjQZQ8BQ6bJXncQVIYDsY9O+GuZojwUvX38pwnui39tasyYt
         PCxQ0jkea0nhRbSh+TukeOxfGv/IimMWGk8cmHdZtIvXyODNoyOkhEfAxxyRy2+6uEu/
         2kER1I90WLsWre0agMGc5meQTrPetvQC1pzNl82xECSDGGP87NwGfrol1Ln14x82b+S0
         QXD8B3qG3mjj7PpP3SjyF2aRi6z32r/yUjP+KH0YlhdTNUlIFjgeXZ1pFlzdiDY1fCG0
         jgcdrs4WeSFfvpNNoEkVAB0k4zRUnjR4GZy11ai43sTzqC8gRdasHQYm4VS1+b6IItKF
         QylQ==
X-Gm-Message-State: AOAM533NBMI2uBrNPXs3QxUKLQ0jOxW8M88keCqOw1C0r5wOCvUKh3qr
        BHSOM+EZ6klqQvt9nmE5/Ovyfw2u01fIOw==
X-Google-Smtp-Source: ABdhPJyVLC5eBbQhG9TTQnRTqax/w56pBdvhedvh5fjEwEtQu1ZsjR8EOApOQE6BsrveQJhisq2Egw==
X-Received: by 2002:a9d:5c04:: with SMTP id o4mr446235otk.372.1606347287090;
        Wed, 25 Nov 2020 15:34:47 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y8sm1958372ota.64.2020.11.25.15.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 15:34:46 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/3] tests: push: improve cleanup of HEAD tests
Date:   Wed, 25 Nov 2020 17:34:41 -0600
Message-Id: <20201125233443.63130-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125233443.63130-1-felipe.contreras@gmail.com>
References: <20201125233443.63130-1-felipe.contreras@gmail.com>
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

