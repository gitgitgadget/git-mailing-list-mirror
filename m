Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD99C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CBCA208E4
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWgfCrwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgEFRLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgEFRLx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:11:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C4C061A10
        for <git@vger.kernel.org>; Wed,  6 May 2020 10:11:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t40so1191943pjb.3
        for <git@vger.kernel.org>; Wed, 06 May 2020 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dk1iYYeHAHOdvJoBLT+K1slXrSHJ9o3vjc444475nhE=;
        b=lWgfCrwiTmyqqP4vhJEOUBOT0YMGs94dQwvtNNDo4vXzNgLdFILRvXFK5jRC5qKqx3
         avHQsgA6VvG8s3xIjHQI5jPA7hw6/F4vSFHzYpKM45Umg54KykBq2Z4RJER2Fo6IRjXZ
         yVIxE0uEvtXMZktu3zKjTqKmPm9syWv7RCKHCeld0XVolma7iBeKOfVaZqqyzSnbO4AU
         srdpJPrTtIauwKDYwijygIb3tcz9i4Mce0JczmsRdc5OnTD5/iZ9NDx6+4OpDp7YYOza
         d/INrqvH2eXGYJoXl3rMSSKmAi5FIdP4zOiJfl9eycsMCnoTbfVy5AJ7U5Xwzg0SEYMT
         owHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dk1iYYeHAHOdvJoBLT+K1slXrSHJ9o3vjc444475nhE=;
        b=NbYDBArd9E1BDyauPOSrOFUxwTjCxoLHoOg9LH09PhD+9jCLOfrp/ZDnQmZYvY7esc
         nRyXlNd3lDN6CAzfGl9vNut0uWMdTiZIBITqQpMPUDlwh9OU0LF2UIuqCm3vRoFHhY+f
         Re2vphgM/mYSPlZNf4vx3BUszYOw68Rn8AkOj0oG3/TR/LyxK2g1f8tlAoXzy+EkEWkK
         ZHe4apdG76mHcaQVuzihq6d7/rneTXnpeDsPc4JWwe+Bg8SPhGbEmBFDP9ttwxbrHYXk
         7eVv7n6r13kCvqtFdqMexTIT2rV+mHq5ZYyWD5kE7EtQRtCpUl+O8RasBAN6JFbhnGw/
         anmQ==
X-Gm-Message-State: AGi0PuZqFed2Ega8Bm0pDECDdQbXSJXaNZbnFtB3B6LJua/oyy8TNiNC
        JjcuPRkx9IMYF5ICrpEVHuBEgXqQhkbQZwrx
X-Google-Smtp-Source: APiQypJZPB77iD9yGqzD/mx3BnjWQwAekUWZ9JAS7XykdIOVDGdHTqGXNqqufvIVhdBiZEreA32uow==
X-Received: by 2002:a17:902:778a:: with SMTP id o10mr8708827pll.76.1588785110710;
        Wed, 06 May 2020 10:11:50 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id 6sm1961273pgw.47.2020.05.06.10.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:11:50 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v7 3/4] gitfaq: partial cloning a repository
Date:   Wed,  6 May 2020 22:41:09 +0530
Message-Id: <20200506171110.23124-3-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506171110.23124-1-shouryashukla.oo@gmail.com>
References: <20200506171110.23124-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common issue' section which covers issues with cloning
large repositories. Use partial cloning to selectively clone the
repository.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
Fixed a whitespace error pointed out by Elijah.

 Documentation/gitfaq.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 875cfa0acd..5a6c8fb07e 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -244,6 +244,17 @@ I want to change the remote of my repository. How do I do that?::
 One can list the remotes of a repository using `git remote -v` command.
 The default name of a remote is 'origin'.
 
+[[partial-cloning]]
+The repository I am trying to clone is too big.  Is there an alternative
+way of cloning it in lesser space?::
+	A good way to save space when cloning a repository is by using
+	`partial clones`.  A partial clone will clone the full history of
+	the repository but will skip out the entities specified by the
+	`--filter` option one uses in `git clone`.  Any entity which has
+	not been cloned to save space can be cloned on-demand (hence this
+	presumes that the user has an always-on network connection to the
+	original repository).  See linkgit:partial-clone[1].
+
 Hooks
 -----
 
-- 
2.26.2

