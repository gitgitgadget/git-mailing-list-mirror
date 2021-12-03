Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11F2C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 10:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379827AbhLCKXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379807AbhLCKXc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 05:23:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B055C06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 02:20:09 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4459303wml.1
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 02:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m5n1BavdEwWizSzJKbFIKKiIimMk3AO7SMn+WCgS7gk=;
        b=ggzkMEm4cWJd+vAPKvfyvevSimBbYJX5CbeT2bnIwbmFq5mwLH/nDxWEFlH5DoJRam
         /JDU3Krh8WT0pqh7l8g7+HjFo0QphEHZKVWAXOdO25ot+F+eW4feJRu+HEV72egzULML
         TNm8/PEy2c86uUKDOnZQIRMdHE2z0oppEeis2FxEmawb+YGSDCFA9QvwMjDyM5sdo7Ld
         2QjN/Mn35BIPrTn/I1PnLARQIwAn71LnSVOTPSWFz1XrtmyJYMRb+Fgf2ouJQKtW6YBa
         CHaNq4J6jgTaBbYS/iDjrhFGglI63G77JZZtHaIzAIKpWEepiCWLNBuMD+FYarHc99qD
         ZiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m5n1BavdEwWizSzJKbFIKKiIimMk3AO7SMn+WCgS7gk=;
        b=F5XQGlH06LXYKTQt/15DNt6xrvz4srkBHanmkR5vfL+I+ILQKHsFHqZ7OgFiPEFpev
         oURF1eqk8kZhARjr2l5ByxyGyF/WjmvYCKR76YvwUDkOjIplb6rgGWD+g+izshif0St6
         WzTKei2y68bAu/XNut1vokvroH3Ni2WSIzndmJmWS7x5F/8B7LS7/yHL6porIoHl3pld
         l3IGTV92dDjBxOghSzA8NDk3mjKugCdXwUIYczvrk7tMZHzwSdXEkKPXpdwZMY1pDm/N
         8M+d1pyKegzqISPRIcNbbZBaTXFoSsqUWjv6oE3gh9/8eqOCOsjNbYE7G5nWzzL56Gjq
         3JRw==
X-Gm-Message-State: AOAM531FZFhdqHpiNeQb1aUHFAewSHJqlQpqHeQygeelLnMx5SFkhUvi
        OD4lLsWZ/6+RE9SAun+RQzQEFnY9mmurSQ==
X-Google-Smtp-Source: ABdhPJyzYHsO4MigwXfPesFbPnaS3eR8qPXsKo8qERkvcRP4LOU45sD7N8o/QXufnJe3uhWM4f1HkQ==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr13961689wmp.165.1638526807450;
        Fri, 03 Dec 2021 02:20:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r8sm2798448wrz.43.2021.12.03.02.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:20:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/7] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Fri,  3 Dec 2021 11:19:48 +0100
Message-Id: <patch-v4-1.7-d7d232b2b52-20211203T101348Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.875.gb925cffed1e
In-Reply-To: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "regex_t" in grep_opt has not been used since
f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
we still use a "regex_t" for compiling regexes, but that's in the
"grep_pat" struct".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3e8815c347b..95cccb670f9 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 
 	const char *prefix;
 	int prefix_length;
-	regex_t regexp;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.34.1.875.gb925cffed1e

