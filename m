Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB07C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D5520781
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEZ//0NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgDUNLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728391AbgDUNLd (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:11:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE339C061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:11:32 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p8so6735487pgi.5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzJ9J1wtHzrN/KosoPr/+d14bcRLxzvn6r16lLzNga0=;
        b=cEZ//0NZN2C66Vb21L89blncR0yRgF8shycXLY35yu4gmx1kO6K20KViSQJcLqVqnQ
         Cn+FsvtbRojbOonlh5XppQ8zmoX5e/XdpiStDbFNi4pHcdaBIk2UmdYoL+4q9jKVoGv0
         /HvscLUntUOTVkdUXpVORlIQnRbMnBXQ7vEt7cbzOk1u6PxUj1TGWkAVwWkkFb+Jh8sq
         kH16DghWmwzLn/ZcOOVW9FbvUQ6VgB3GPFr6mxURSgaBj6UYBxbIxPXcChsORHkBfEZn
         C2SO8raA4OVFKSjU8N9ZsH9QdTFR/hxrzxgvUvlE3zlIqr1bP2ydjPtslNRsGttMBcAZ
         izVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzJ9J1wtHzrN/KosoPr/+d14bcRLxzvn6r16lLzNga0=;
        b=JiSlq5pAI1Rvfnk9Go6mcfkSJpe5XQBA4sCbsm8l6HpkFpiThSwhC5tObT20cecMK2
         Qe7BJmAHpBuKGz6Ytv++a5tDNky4xPdb1M2R+L1ntd7jWd4Gy+yvLl8i4ed9/O3xNX8W
         51Ai7MlgLU0+coahHX09JXgctis/fQyJMilq221ahqedcVkTUKdAQTzaaSUmD8219C51
         8qf2jkR7aZW6n6HESVBExKxE4zbHR/9zrnmnnf+21fJ4unc9gShmlktJUqyD7e07tRva
         bmjNzmjeJ9RWGrCwPoUah0lXk/BM+VGomYWQmlldMqDXRW+/ZssY7lD84WyyDOjdWOzk
         zjCw==
X-Gm-Message-State: AGi0PuYYeoxgOqR+fvDf0XhjDQCK2bTEaYQrLRnGolt88uxcGTUSA9yw
        th2zRCcE6413xZPCrqZZPy2fN2eQt2E=
X-Google-Smtp-Source: APiQypJFMiEtP/2F56JniwhVZiWWJoCniG94MEdLxpuItdEUzs+l0agZnSLvlDFrvlAG/2rXujOFNA==
X-Received: by 2002:a62:1d1:: with SMTP id 200mr2361647pfb.286.1587474692025;
        Tue, 21 Apr 2020 06:11:32 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id i8sm2529422pfq.126.2020.04.21.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:11:31 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3 4/4] gitfaq: fetching and pulling a repository
Date:   Tue, 21 Apr 2020 18:41:11 +0530
Message-Id: <20200421131111.29201-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421131111.29201-1-shouryashukla.oo@gmail.com>
References: <20200421131111.29201-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an issue in 'Common Issues' section which addresses the confusion
between performing a 'fetch' and a 'pull'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index cea293cf07..e93785f2f8 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -289,6 +289,26 @@ way of cloning it in lesser space?::
 	would mean fetching only the top level commits of the repository
 	See linkgit:git-clone[1].
 
+[[fetching-and-pulling]]
+How do I know if I want to do a fetch or a pull?::
+	A fetch brings in the latest changes made upstream (i.e., the
+	remote repository we are working on). This allows us to inspect
+	the changes made upstream and integrate all those changes (if
+	and only if we want to) or only cherry pick certain changes.
+	Fetching does not have any immediate effects on the local
+	repository.
+
+	A pull is a wrapper for a fetch and merge. This means that doing
+	a `git pull` will not only fetch the changes made upstream but
+	integrate them as well with our local repository. The merge may
+	go smoothly or have merge conflicts depending on the case. A pull
+	does not allow you to review any changes made upstream but rather
+	merge those changes on their own.
++
+This is the reason why it is sometimes advised to fetch the changes
+first and then merge them accordingly because not every change might
+be of utility to the user.
+
 Hooks
 -----
 
-- 
2.20.1

