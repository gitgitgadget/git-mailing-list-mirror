Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E9CC56201
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED34920B1F
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 00:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgaZek4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgKZAQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 19:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgKZAQW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 19:16:22 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B311C061A4F
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 16:16:22 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l206so301916oif.12
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 16:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rhFx8cgz7NLXK+mcDt67MnwPgOaJv95HxU0iA1BqIo=;
        b=rgaZek4goRH58c/lK+c5vK9RGbM8bBENy3hzFNt24hyFIzt7DmW9EAippptsDD+AVd
         wU5z2uf9E0BYU/jVcNGNJya14pbf49aacMHJoq4DUFDWgLWa5EHlUcx3Ll4vczgwEPo/
         5ejwCL6ERfpmiKVET1IvLFj9zYNKP02AD0RTbxvtJhV5GVFnlsQANmR9rwaALqv8Gkz1
         kkYdgTz1c1jjxPwWwXSOsKW0WMEN5+dHOxXuoyJm6CWcJ1dmdBrBGk6OSCc9zvSsnjQJ
         P0uKUkk+aILVBfEjn1stohpNvAmToXq994ZHWkLhcL4bs4Cf4E8MUpR9vAUOiPbLZ52c
         IM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rhFx8cgz7NLXK+mcDt67MnwPgOaJv95HxU0iA1BqIo=;
        b=fwpbCCReE9Vi4v4rOhlyHwUAHpLxUUFiPMRa4hJZYosSztjGBL7l0W8MrWKqC1e/SP
         YOEM2NFcTOWRJ0g+vk4UeIN+mfCDyigQeDGd2rvfI7R3oaQxUDIwo0nEDMSrQ1zwGo0M
         Jhvh/ibd/CebBWLG3gtPgIb7Amor5yYeW7pjptbvgab1Aj0XylnXrgoMTvZ8TlhxRan+
         h1wbi0FA+nB12djhRwC1rFdIiaIUjYFA1tLrDPhfHghlDeppNuVDScQFIkUFm4gi6jaN
         /gj24nDYfTbvGaqauzp6DREypMn3OsO4dov5ZZaiGF/l1NclXz1lDcxJlfgXmzjHFpf0
         yOaA==
X-Gm-Message-State: AOAM531cYNkRQ6sNUFv1Dp1C3vY7HeS3eHX6UQwC6GrTmMPlmDH+fKeM
        m9VRA0PnKYxrUXNbk5J2ZESSw5637s6iRQ==
X-Google-Smtp-Source: ABdhPJxySVNDRJrqWhSBWZPNVazIJAJ6kj4axRcfKelPEO1U+bObxNBdfTFcinGMJ7jVnRpkVJpktw==
X-Received: by 2002:aca:b887:: with SMTP id i129mr434316oif.25.1606349781588;
        Wed, 25 Nov 2020 16:16:21 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j8sm2225507oif.55.2020.11.25.16.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:16:21 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 2/3] tests: push: trivial cleanup
Date:   Wed, 25 Nov 2020 18:16:15 -0600
Message-Id: <20201126001616.663910-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126001616.663910-1-felipe.contreras@gmail.com>
References: <20201126001616.663910-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No need to do two checkouts.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5516-fetch-push.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4077471937..245eafb170 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -457,8 +457,7 @@ test_expect_success 'push with HEAD nonexisting at remote' '
 test_expect_success 'push with +HEAD' '
 
 	mk_test testrepo heads/master &&
-	git checkout master &&
-	git checkout -b local &&
+	git checkout -b local master &&
 	test_when_finished "git checkout master; git branch -D local" &&
 	git push testrepo master local &&
 	check_push_result testrepo $the_commit heads/master &&
-- 
2.29.2

