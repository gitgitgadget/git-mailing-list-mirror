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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976A9C433FE
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8786103D
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 10:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbhIWKcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbhIWKco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 06:32:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA05C061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w29so15700187wra.8
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 03:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipjTa0w06K56mcyiKe5CVZq4/Wp+U09cjHG1UyJpP+s=;
        b=CTXeN9tZjC+7h33Hn60tfqtOK56oCoXAd9UlHV36JVNTsLqT76fWousyMSatntTNcy
         Nb1c5UhNuOzvdFfpKFZFjC3f4Xv2lJYHxvwl8v1VZxMASQID4mMb3ejVRwFrhQWJqM+P
         ERTZhN+jSCUAKpz+x8C82oihmhoCpW+HjZ/pvx3OIFLLc8tJUa4276cbfyQZqkbEi5YJ
         fI6P29UH/xlupR2k1vmqlehZD2NLAzZOtK6ceeMAsuvLB8dkn5nS69oNchtPsQOjrwbU
         c50R2DfjKKOuNPIwuMh+A61ZJfliSPq4aVbxc3KgG/2KkFFgGg3yImY2iSqZ9rCXGuWY
         09IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipjTa0w06K56mcyiKe5CVZq4/Wp+U09cjHG1UyJpP+s=;
        b=P3lJluiqS/v2QFwr7rqY8SMkZsum9athY5NM6EKC05tS4oEjp4Os2dM+QtX73TJh0g
         r2Y5ck4mbBKu2akm1FJNBpaZb1FxQW0bDRgSYOTiwuhtTwGFwuPai7biArRoQP3d9nTS
         kQPlZjYE+Cu7v7AJcRp07eBdqqsnNr/hPqklGlwQnYppdE7/mWZG2RN2kWTFvk3g70s9
         Ybt0Pfb9gDBVFWEAk/1xAgDnSAQcCS7YkOVqGnfNKbAte+Bh7g1CNlmctUViZo5NgCJy
         q9e3B14GGor1eeA5fMq6kEmgSuypJj5mH/h/X68gnkofDVtWC+CExKsFN0NGk7CDU2Cw
         773g==
X-Gm-Message-State: AOAM5326g79lr/856k53gIMGz1JSdJlE7hkvwnX3/tnpk08/CqCH1R6d
        3jJXFvC9L66Geq1xMXVtZ5WMEWcGBiSfLA==
X-Google-Smtp-Source: ABdhPJyyIs8iBpL/F0ij6ArWZLoEBhUwYCuF35qV38uE4jWPphlKsPgKWhuFUoW+e4zjLm1I4hPQ3A==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr4225030wrn.261.1632393070883;
        Thu, 23 Sep 2021 03:31:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b187sm9027312wmd.33.2021.09.23.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 03:31:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] Makefile: mark "check" target as .PHONY
Date:   Thu, 23 Sep 2021 12:29:56 +0200
Message-Id: <patch-1.8-91d0cd09c8e-20210923T095326Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1229.g50d2591fb53
In-Reply-To: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in 44c9e8594e (Fix up header file dependencies and add
sparse checking rules, 2005-07-03), we never marked the phony "check"
target as such.

Perhaps we should just remove it, since as of a combination of
912f9980d2 (Makefile: help people who run 'make check' by mistake,
2008-11-11) 0bcd9ae85d (sparse: Fix errors due to missing
target-specific variables, 2011-04-21) we've been suggesting the user
run "make sparse" directly.

But under that mode it still does something, as well as directing the
user to run "make test" under non-sparse. So let's punt that and
narrowly fix the PHONY bug.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9df565f27bb..e85a8e07d3e 100644
--- a/Makefile
+++ b/Makefile
@@ -2932,6 +2932,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
 
+.PHONY: check
 check: config-list.h command-list.h
 	@if sparse; \
 	then \
-- 
2.33.0.1229.g0a86d28df49

