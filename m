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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C539C07E9B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16873613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhGEMew (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhGEMeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:34:50 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BDAC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:13 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso4424386ooc.5
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cJPEeERMgmIEQBlUZqAse60BHilUUWsxDNjbCAk9sg=;
        b=hyzQOONzxMDx4+wrGajms/pF3CISDFLIFO8hwShMS98VG2bcHKo7QnaM4cERxPO3uY
         2btrxCr10or8QX7DMGqYOTqGW6ZgPMkLuUDGG4vP4AeRzbmuiljir9zOGmcww2udhGHW
         BRlEtTBwFroCVkV4/DiZAoWCsv0YqG/X7fQ3qmEvc9WICBDQybtk24XNU5OJRa3mgMxW
         13EXGVwIK/iNb7Qaja7N4VCplr9vonqkJbj12d1N4f121rx8VFgKGxDmQYXT/cwH6KRB
         g97Gp3ad++0a4OqIQgMe+VYFqb+4CyuNqWyV6B7Ojqbn0rzXXPAKbYd0dHi+08FJTK5Q
         tLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cJPEeERMgmIEQBlUZqAse60BHilUUWsxDNjbCAk9sg=;
        b=H2Xf5HC9WJGiluLhBQRWWJdIBJgMBBDJX5+5JE9IOFWfUlc99iwzpX73CvmhxJEyiW
         tPkO1AuJMg1BWE6GOW9a4NJhoPXnWBKw/gVXKAN5HvBNbzgkgzCMqkGYI2kjyJrfrlPW
         AQrZLVY49aHazOaIcIDHiVg6/jxIkKqfQAfwptEVMEJnHTQk4RUAhnNmfHtpoQ+zbF68
         j/JBTpFQbvUwuBNv38tsJZ9zKB0HyC5XzpvvwoAV6Kr8Hd36RdRZAV9uVe5qIjRTGE5r
         56FNM443H9K/ZyigJGDPubN0LaGzJ4Z8pnOJTTnEniKF9UjumH+mrpXc6ecriGLQ7Lo8
         z8Yg==
X-Gm-Message-State: AOAM531ZP38aRKYRmIvT/Jww98gAZvkKTAbneEQK8pQa+CISJYfOf34C
        HMPLpkg/Vf+8KTGRew3kFRKuvk6If+WLVQ==
X-Google-Smtp-Source: ABdhPJynnudK+/pHb8BA8ln13O+/DSVm9JfjFQAX9QFk34R2Rg4/BiPIy94Zm9zhDoPXpE3/zjmLww==
X-Received: by 2002:a4a:98ce:: with SMTP id b14mr9859228ooj.69.1625488333001;
        Mon, 05 Jul 2021 05:32:13 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id d7sm2529381otb.66.2021.07.05.05.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 01/35] merge: improve fatal fast-forward message
Date:   Mon,  5 Jul 2021 07:31:35 -0500
Message-Id: <20210705123209.1808663-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f5..05e631229d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1620,7 +1620,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (fast_forward == FF_ONLY)
-		die(_("Not possible to fast-forward, aborting."));
+		die(_("unable to fast-forward"));
 
 	if (autostash)
 		create_autostash(the_repository,
-- 
2.32.0.36.g70aac2b1aa

