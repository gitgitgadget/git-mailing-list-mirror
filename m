Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A3BECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiH3Jch (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiH3Jc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:26 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B47A925E
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:05 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f11d932a8so6967008fac.3
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QPRSVzXcyD14zgWjFMeYAQTcyvIGsx3ocDkIgXd3Fcc=;
        b=WT/8+zXtOrANIWGS9FQW/MUKDdptcyIBFjb+GILDb62b4AUN8FgATNBidRhde6tpzR
         Gof2ILa+9oibnLpGLvuPeau4AUEvD52AmW6mIHbq92D6ZNRQL5t095Md/tf1UKu3gWO1
         wHMDrAF5cunJWie4Y3DUeuoLX/CGFijLe8fDUUwvV6zeC1ivAiKDnLD000mU0BOo93dz
         64VuAf+5yYRGGS2bX4XVEofR1FHzgNvYmj7nYpw/L0QsICNsU0B71j24Mm495aMXA+4K
         rQyvgfm09X9jzvT+Me9xUqgg7Ht1FQUmQgeUJpZnDqZtT0++ZYeSmD4C8ouQ7ipdqX5A
         TiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QPRSVzXcyD14zgWjFMeYAQTcyvIGsx3ocDkIgXd3Fcc=;
        b=N2vRR4sxp7ZB0vstjWpwdRKvIvw978+08VhZv+REQ609KBDDIJolH9K6DtnAwvrpAp
         4n8js3kJQKaW/XKxp3RkZWEUfu9s9ecgZ85o1ZG1/8sTNsPDYFJLgwNDgqv2kdc9cKjE
         k4BruaEUhQw/8SrinXoeq9nE5v1aXWNuUHyHrpB5srrsid1HI2MaawWiJF4isfYQ90OV
         nMTf/W9YNDdF8auL/3IKX8DhaydrNeb4ocnPAp3VuiheHsWivtWnSmTBUMrJgwTL2EEB
         KIFxV9vTzeZLyiOPrXx55PBDiltTI/PlZ718Af2iuATv0jGxzIfAuupnKJR5UKTkX3Tl
         nS3A==
X-Gm-Message-State: ACgBeo0uYQXmzPXSKNFlDJiPg8kFNvNarpXb46ZYimqmeTw7Wtx7fak4
        arkqa2dGY3VvURVTFQH+Ae2YraRQxAM=
X-Google-Smtp-Source: AA6agR6IOHyiSVf7lJHj/B39JATf6O1DKrWNG9BH8Mo3TuwKOvHXBlPwrsyhP7a1zjrPOcr4vybRAQ==
X-Received: by 2002:a05:6870:3914:b0:11c:7f09:96fa with SMTP id b20-20020a056870391400b0011c7f0996famr9416521oap.50.1661851923454;
        Tue, 30 Aug 2022 02:32:03 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id 37-20020a9d0c28000000b006394136eae0sm6970134otr.57.2022.08.30.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/51] test: completion: switch __gitcomp_nl prefix test
Date:   Tue, 30 Aug 2022 04:31:01 -0500
Message-Id: <20220830093138.1581538-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default COMP_WORDBREAKS includes =, so it's not realistic to test for
a prefix that almost never will be there.

In bash there are no functional changes, but in zsh this makes the test
pass.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh     | 6 +++---
 t/t9904-zsh-completion.sh | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 031f05cf47..2fe056ab59 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -565,9 +565,9 @@ test_expect_success '__gitcomp_nl - trailing space' '
 '
 
 test_expect_success '__gitcomp_nl - prefix' '
-	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
-	--fixup=main Z
-	--fixup=maint Z
+	test_gitcomp_nl "branch.m" "$refs" "branch." "m" <<-EOF
+	branch.main Z
+	branch.maint Z
 	EOF
 '
 
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index e9df29c135..dbd0671ab6 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -180,10 +180,10 @@ test_expect_success '__gitcomp_nl - trailing space' '
 	EOF
 '
 
-test_expect_failure '__gitcomp_nl - prefix' '
-	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
-	--fixup=main Z
-	--fixup=maint Z
+test_expect_success '__gitcomp_nl - prefix' '
+	test_gitcomp_nl "branch.m" "$refs" "branch." "m" <<-EOF
+	branch.main Z
+	branch.maint Z
 	EOF
 '
 
-- 
2.37.2.351.g9bf691b78c.dirty

