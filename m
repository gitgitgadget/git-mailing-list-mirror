Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B44C4742C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0016822265
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptWka37z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgKAR2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgKAR2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:28:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEC5C061A04
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 09:28:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 13so7246865wmf.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 09:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SzdJTTCzvY22cpUuKgXDJ1J0DyVQ8i2sAbzsX73+t6I=;
        b=ptWka37zvg5zrfYvwP4teER0DemTfk9fTsWTM50KUSVT+G10tH4RyeAEUduag9xj47
         qH3qV7mN2gXTL/r9XEnAc3iEFmSc8TULsrJNF80K8sgw9j4acvLcnyLIpowUi1CAyQf3
         kB2Mk+NzU+3NH3Gj/2PFSAki3bTf27Hgi5gIYzbZ9q1tOUCNNdEQATUr1wPqcwLj1MTz
         VKYF/kxVjyk1yhe/zUSAXDO2H2DTgJn0R4/UKS67NMBI65e0qFgzlXufqqZ79gSVgxzQ
         WyzGjtA+SNgnh0EYjSUpCKWiurL1tvUiIXbyTnlQf7GpSNw3ityl78LT5UzjWgyJAVJl
         J5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SzdJTTCzvY22cpUuKgXDJ1J0DyVQ8i2sAbzsX73+t6I=;
        b=KzferB6KhtAyvR/BF9pMd6futdv9cztLkuwJ0RDNDHg9H7QQw4Brb6LylzfnCYGwEm
         Z3+PqHv7lYgBzQMuobhUgXyB9kaU6+QzpP8eT/1uXmtlZiJPVAkyOxs/ov2VYge/ZVJW
         SXzGsViALK2pdjm6luj0bYUbXt0heKw3koIUDtAt1qOnb4AtZGek74BHPZT/sAifXJhq
         8wSadlqdAbRM918apSra/MOufQtT4dWN3HK3NZ92/Hu+HlO8+md1t8+n6O82PJvuBxu8
         8m/9jLzXZHxxV4oYrkyRViiizUmIyKmEiidFJZ5z7olHLeQ6B4ytz1isLkUnnjbr/get
         O9tA==
X-Gm-Message-State: AOAM531b5Wq5DwRYlySfF6cqUqfJpWQnxkCTKVvlGk3JcS7rZXdHV4nA
        XybzcJjvxpAPzhBU+Ce+/FkI9Mpzu5c=
X-Google-Smtp-Source: ABdhPJxen3r5uAh+CugqZuwRz6N8MOVgHL6aNAWtoEzeHbE2bef+cdcE3N2GDc8WwmG7NVeXnYWA8Q==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr14313021wmb.129.1604251731649;
        Sun, 01 Nov 2020 09:28:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u81sm2039619wmb.27.2020.11.01.09.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 09:28:51 -0800 (PST)
Message-Id: <d38f0f7e268897effa200a4c61c03d5cf082eb13.1604251728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <pull.774.v2.git.1604251727.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 17:28:42 +0000
Subject: [PATCH v2 3/8] blame-options.txt: also mention 'funcname' in '-L'
 description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Make it clearer that a function can be blamed by feeding `git blame`
'-L :<funcname>' by mentioning it at the beginnning of the description
of the '-L' option.

Also, in 'line-range-options.txt', which is used for git-log(1) and
gitk(1), do not parenthesize the mention of the ':<funcname>' mode, to
place it on equal footing with the '<start>,<end>' mode.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/blame-options.txt      | 5 +++--
 Documentation/line-range-options.txt | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 48bf0eeec5..dc3bceb6d1 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -11,8 +11,9 @@
 
 -L <start>,<end>::
 -L :<funcname>::
-	Annotate only the given line range. May be specified multiple times.
-	Overlapping ranges are allowed.
+	Annotate only the line range given by '<start>,<end>',
+	or by the function name regex '<funcname>'.
+	May be specified multiple times. Overlapping ranges are allowed.
 +
 '<start>' and '<end>' are optional. `-L <start>` or `-L <start>,` spans from
 '<start>' to end of file. `-L ,<end>` spans from start of file to '<end>'.
diff --git a/Documentation/line-range-options.txt b/Documentation/line-range-options.txt
index 1c90127300..8e295a62b8 100644
--- a/Documentation/line-range-options.txt
+++ b/Documentation/line-range-options.txt
@@ -1,8 +1,8 @@
 -L<start>,<end>:<file>::
 -L:<funcname>:<file>::
 
-	Trace the evolution of the line range given by '<start>,<end>'
-	(or the function name regex '<funcname>') within the '<file>'. You may
+	Trace the evolution of the line range given by '<start>,<end>',
+	or by the function name regex '<funcname>', within the '<file>'. You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments, and
-- 
gitgitgadget

