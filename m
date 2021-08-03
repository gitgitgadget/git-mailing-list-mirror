Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD79C4320E
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FC860EC0
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbhHCPfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbhHCPfl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E059C06175F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n28-20020a05600c3b9cb02902552e60df56so2419858wms.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2QPEZ90F6+sZdVdQ44dX266o26AHMoYaOlmu3t7V6xQ=;
        b=cT0Aol0j30o5illAk0ZDAYwv2r41+uWQb1kPOv6vabZHzosX+SY9rL5OTCHJaMx6V6
         exJjVc3+/Tg6if2o5RxDlfhk6K83tHikXynyQHjhzyL9mX45r3S0fNGrl3lNW6DX3gBd
         LHgVoUQA7xmH4NVyf4hmiKKzBzUZMIwHKUHabiaPLFgvDE0Qu+B48AvIZZMc9meQYAlu
         +IWwt0QXHzgM1A9gV3/yyaxH1mk/8FN+yhgoNsiw+en6iXMIE6cFjtYB8IbdGsF2mx3r
         GMtPx8YojpSlN2/XqL/vrg8OjCpCMx4gGAvyQIh6Vn3ijJ8B+bDzPkSYuYeAGhtcdw+E
         +mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2QPEZ90F6+sZdVdQ44dX266o26AHMoYaOlmu3t7V6xQ=;
        b=lNgAWanQvnSINp4UHxcHdzcWyOv2rCSfUJexCM29/gp5UVzUdcz/ZzSXyjtpJmcwse
         cC9v8VybXeMRgzVP8o3OtbJba6oHyh+Ngsj9XHZyrjND7EJr67/C5tK9V1sCZbPf2G5Q
         BqFSGXE8bMa5omLXYaQDRxR0ekAcEj4Q+RqBpp3Ntpbh4C0UxOUhoQgSSQLLP9QhfhHK
         fJkUNixu/CV5lWHqfJ99XlQm3PKNBtvkD11/U7yqfyUbvBYPvLAkiCJLbefvaai54d3P
         qvDfsyo72lZDUTxU+fpo5qbm3D3iO9v6t3JWurBQzQmzFETzIC8OlWadNa0QnLqyXYdH
         Ebng==
X-Gm-Message-State: AOAM531CwIpbkoIgdJ2t2dUcxsxwr6IG2e7VoCAB9rQfN2fRoAD8HyiQ
        NyCvy4z8kE0NYIL9dyPIrRnxQmYjTgs=
X-Google-Smtp-Source: ABdhPJzY8vjghuhtXY6Wq3EcGsM7OqOVxxR8pp9U4cebVC1XAaCaAK0NdzTsYFncCypAENtA3MiF4Q==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr22472739wmc.86.1628004929202;
        Tue, 03 Aug 2021 08:35:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5sm15535427wrd.74.2021.08.03.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:28 -0700 (PDT)
Message-Id: <7eecf879d608d8be17d4aa0ae087fb610156019c.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:17 +0000
Subject: [PATCH 07/10] merge-strategies.txt: explain why no-renames might be
 useful
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index eb43befac7b..d21dbd1e051 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -75,9 +75,10 @@ no-renormalize;;
 	`merge.renormalize` configuration variable.
 
 no-renames;;
-	Turn off rename detection. This overrides the `merge.renames`
-	configuration variable.
-	See also linkgit:git-diff[1] `--no-renames`.
+	Turn off rename detection, which can be computationally
+	expensive.  This overrides the `merge.renames`
+	configuration variable.  See also linkgit:git-diff[1]
+	`--no-renames`.
 
 find-renames[=<n>];;
 	Turn on rename detection, optionally setting the similarity
-- 
gitgitgadget

