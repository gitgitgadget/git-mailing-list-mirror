Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDDCC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8A52073B
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9S5aD7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbgDCK2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:28:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35740 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390580AbgDCK2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:28:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id c12so2549933plz.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kf3JSs8Fgl7Az6Mg3L9eHU85CNRXBMCrJPxrQHjQgws=;
        b=i9S5aD7LHppV+FhEZyw+3GdKciH9QBiHTz784SmpbBKGUxP9rgtJQNdGUP0iYO3N85
         lWg7a+PSiaRv4S4OS/kbCyBMWVtoKCKqVamOAoJo96MsmcEV3Ul4jilAIPqDxJhFpdgj
         nLdak2A8j8Q8VUe3qvyZz4oiPZok7LSNqcEnjwkcukYTFKrnsJptBSiivj5nUb47vueR
         Bhv5V+roQ2isIUl9nn6PyU1jmSrUQVXTPTcvyW+vxoRBF4E/aCajyZlTAfFypyLHyOia
         TWGDuQUjLJ60NRT9vYqOuGPwhUhHhBC5HOWIn/ky5Hz4N0J6R1K9akU2Wq0HusMZynHU
         ZegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kf3JSs8Fgl7Az6Mg3L9eHU85CNRXBMCrJPxrQHjQgws=;
        b=YuQ8qIcKTblzWGHM9HGpHszJZ9nkMpFGzatRwE543YkW79C9RsdmTMXitVUPWbFQd3
         6pdJ6LHr/wStI5ltglfxzDBlJ32WgBi8673fIy1uELwNZCwtp4Ubv9DeDmyEw74mussI
         1gCQV5fWQ2XUvv13V6ZFsjLqOgX5zDd3cV+LFWm9G7VKc5dG+QCKmr0HBT8Zrcx4t2jp
         W2QEAW7Aa8J/ZwquQVymJg28d9WyVvrA2aOL1wKU0JOkJZ0f0YSC/9+GVEyNChj0JXsc
         bEILdz7NY8TC265NeffJkXn1c2u5OFwrrAOFN5fj6e3kdkSMfsDZ78Um9XfgwQgJztJ/
         097w==
X-Gm-Message-State: AGi0PuZ5eOF/0fiN3Bl9QHRVkn0AP0BNZW10sd2Aez0j0RJvwsvNR4eB
        P2IPkqCuftXvoF5bF+u6vQreC2c6
X-Google-Smtp-Source: APiQypIMFu0FXu3dA1DBYKqS1ybMgpgo9UW1npfM/gkOHJF+GkJysIe+OrPpLwMgYznDGLtq7+Xy+w==
X-Received: by 2002:a17:902:9348:: with SMTP id g8mr7332001plp.112.1585909721525;
        Fri, 03 Apr 2020 03:28:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id c21sm4958126pgn.84.2020.04.03.03.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 03:28:41 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 6/6] Documentation: document merge option --no-gpg-sign
Date:   Fri,  3 Apr 2020 17:28:07 +0700
Message-Id: <b1a3d42355aeafab2c68eeab7abd4247274aea10.1585909453.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585909453.git.congdanhqx@gmail.com>
References: <20200331064456.GA15850@danh.dev> <cover.1585909453.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/merge-options.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 40dc4f5e8c..fb3a6e8d42 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -61,9 +61,12 @@ When not possible, refuse to merge and exit with a non-zero status.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
+--no-gpg-sign::
 	GPG-sign the resulting merge commit. The `keyid` argument is
 	optional and defaults to the committer identity; if specified,
-	it must be stuck to the option without a space.
+	it must be stuck to the option without a space. `--no-gpg-sign`
+	is useful to countermand both `commit.gpgSign` configuration variable,
+	and earlier `--gpg-sign`.
 
 --log[=<n>]::
 --no-log::
-- 
2.26.0.334.g6536db25bb

