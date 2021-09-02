Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A7C43214
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4865F610D2
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345069AbhIBNMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbhIBNMo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:12:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF7C061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:11:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso1340970wmr.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDACj8AlTebPdYzdVkvvWEYbk7RRMjgrwuCw+v/OEzs=;
        b=SlvMgun6lH1fH3nU6PvduWVEPHEY4ZPqtOk5Gl+YZ805fczhGyM/uNaSwqa81CNSQB
         mqgbMhOkdeH1jdw4ESR7JeT791gpD6DzqqJlorRtj1N3koyfokH142rft0YKElmUFw7K
         EZHQbH/SGrvIotDzs8JceqJ0/aa8hBm9vozqQkxf0j/g08DooBTp0zNjVOvPbql1B1AJ
         EeX/JleKeHehJVOgk70TaQxu6IZOXZ0rAuD02jr5yvFjT4Lq5ENhtiGzoijTEPVDR3hY
         ebjwBMPWsPQFMm6cYMM3eSfhiNMF4a+f968A/2BXIAJb3+K0g41q96bQ+TGUAjiiaQYy
         hbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDACj8AlTebPdYzdVkvvWEYbk7RRMjgrwuCw+v/OEzs=;
        b=dRj/y6Ii8gvgydgS/B+aD1XF5eAomtmyxW48F3KhsrzsJsLeDxcBGkFxrs2hkmpj1i
         ujwohdp9nh/HMEwLpKqeFDazkez8bnhDwavQ0Wq1dTns8WjQYUfdMI/LPgUeKO1pLnbC
         R69sj2kqBlI9H3ZSbcfXtJUUdGE1oM7XWq1xZ8pOAfrAw87/vZnWFjQURJKpRLHFGRFy
         7ZDnpYTidmLj/Z5AzNhqWlLVDw10ewGzFTBlYyIrSSIRntlC1FjqRT6tgjBOOuCFsUl7
         qTvdtQagMF8F3Qa135bBkt6qERoBHbCMdWf6ogjiV6N5QJG7XBMz1OBOBTLrREjx4pbF
         U2yw==
X-Gm-Message-State: AOAM532Ob4jsboonpIIeG+ZSADXCYMhHnZLFvOnW+0S/GAbPC8P8BHRf
        SofLKBiGaqwbbza98tw7JcxL8AbfprWa2A==
X-Google-Smtp-Source: ABdhPJy6PW3iU8VQj/+VKQjJb03jJOLQfk6y7hS1PoPeKx9L9sRBmeDQ5zuaIuXamaBUnL9nBdxmRQ==
X-Received: by 2002:a05:600c:230a:: with SMTP id 10mr3061283wmo.79.1630588304081;
        Thu, 02 Sep 2021 06:11:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 03/36] Makefile: remove an out-of-date comment
Date:   Thu,  2 Sep 2021 15:11:03 +0200
Message-Id: <patch-v5-03.36-ffef1d3257e-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This comment added in dfea575017 (Makefile: lazily compute header
dependencies, 2010-01-26) has been out of date since
92b88eba9f (Makefile: use `git ls-files` to list header files, if
possible, 2019-03-04), when we did exactly what it tells us not to do
and added $(GENERATED_H) to $(OBJECTS) dependencies.

The rest of it was also somewhere between inaccurate and outdated,
since as of b8ba629264 (Makefile: fold MISC_H into LIB_H, 2012-06-20)
it's not followed by a list of header files, that got moved earlier in
the file into LIB_H in 60d24dd255 (Makefile: fold XDIFF_H and VCSSVN_H
into LIB_H, 2012-07-06).

Let's just remove it entirely, to the extent that we have anything
useful to say here the comment on the
"USE_COMPUTED_HEADER_DEPENDENCIES" variable a few lines above this
change does the job for us.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Makefile b/Makefile
index 4f1f13b5f0a..53c67f4a726 100644
--- a/Makefile
+++ b/Makefile
@@ -2524,13 +2524,6 @@ ifneq ($(dep_files_present),)
 include $(dep_files_present)
 endif
 else
-# Dependencies on header files, for platforms that do not support
-# the gcc -MMD option.
-#
-# Dependencies on automatically generated headers such as command-list.h
-# should _not_ be included here, since they are necessary even when
-# building an object for the first time.
-
 $(OBJECTS): $(LIB_H) $(GENERATED_H)
 endif
 
-- 
2.33.0.816.g1ba32acadee

