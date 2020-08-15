Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CBDC433E4
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5816920639
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaDpCHne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgHOWHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgHOVus (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C3FC061362
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 19:33:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y6so4996978plt.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQcHWeOzgc1KEpRQqPSKQk+hd4JQcxqTBsMNJ2wQ/ok=;
        b=kaDpCHnemZhXMFUEkF2hgRA4nQwj5iQQhzqxAUCuizG/q/xu2ZJz/GN3YG0mwbbvXa
         HJugen8qraPHboY46KWjROc3YJeLE4LGgT1iQ4dR1FwzgqMtbmdvLfAgsYpg5ARCXqmh
         3RBgP8HXOhKM7YqXtq+yzZ92w0EzZOZEo8vZnVgCAT57WWivKGG41RCFiA2J0tloBQat
         xZr02hOKhoH3fKsw3vnoQnM0q1y1w3InzYXi02V+xpCDHDDwFtotdY7HBvbkJ9iT6Q9G
         AAgEYDy0KtmEyymK5L00Fd1Spxkol4X4UCb6xZD2SPYI0RcFscx7jPgeU6YICFsIYvrV
         URLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQcHWeOzgc1KEpRQqPSKQk+hd4JQcxqTBsMNJ2wQ/ok=;
        b=hDuYPNH271x/C/xDicK3ktrFU20T8BdrESOllccJl7S2fGn+GhyT340zdOz3nCIIRI
         i9XowO5jGnblnx6bCJd8GRLOWngu1UWpcpTZP5kaM1OIxOuyXJMciS/8vAUm79P5zKM1
         HBV1AqBDeMKl+cUQ9+2BzaxGyGNkPG/Jpag2ei4+Olp3FesnZMmWBUu4Vk/GnZp79xwW
         4pZ0BldUvyT66SOW3rnTjed4P44botZACDYnax4S4LqU8W/1s75/HlwdKbv78XB2jeNM
         jmACtd2o/gODazbMTZtYuq5nE89hFViNJkpq9p/ZZeySuEbPV8mlOIOjXC6FvXPvj8bU
         J+nA==
X-Gm-Message-State: AOAM532H9f/Xc8vX68+F8j82sqcTWrJFZ3xKIV0/uIxpOGskXrJRWEss
        6ECFAzHd+MbykKFCCoo/Ts0=
X-Google-Smtp-Source: ABdhPJwKb3Q+lTejSIWkbMLGEW6yEtvwtaRHZfJckJ8Nuh9lemanbJkvWVuW+XB3XW386m2e+leYKw==
X-Received: by 2002:a17:90a:e292:: with SMTP id d18mr4509757pjz.181.1597458785261;
        Fri, 14 Aug 2020 19:33:05 -0700 (PDT)
Received: from localhost.localdomain (36-225-225-45.dynamic-ip.hinet.net. [36.225.225.45])
        by smtp.gmail.com with ESMTPSA id l17sm11059473pff.126.2020.08.14.19.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 19:33:04 -0700 (PDT)
From:   Danny Lin <danny0838@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git develop <git@vger.kernel.org>, Danny Lin <danny0838@gmail.com>
Subject: [PATCH] Revise supported options for --message in subtree doc.
Date:   Sat, 15 Aug 2020 10:32:47 +0800
Message-Id: <20200815023247.788-1-danny0838@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <CAMbsUu6WnHori2t1qG=6UVLWDNEw5FSXeTd-K6WKnpZi5h6q+w@mail.gmail.com>
References: <CAMbsUu6WnHori2t1qG=6UVLWDNEw5FSXeTd-K6WKnpZi5h6q+w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revise the documentation and remove previous "unsure" after making sure
that --message supports only 'add', 'merge', 'pull', and 'split --rejoin'.

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/subtree/git-subtree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 352deda69d..9ccd431c7f 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -139,7 +139,7 @@ OPTIONS
 
 -m <message>::
 --message=<message>::
-	This option is only valid for add, merge and pull (unsure).
+	This option is only valid for add, merge, pull, and split --rejoin.
 	Specify <message> as the commit message for the merge commit.
 
 
-- 
2.28.0.windows.1

