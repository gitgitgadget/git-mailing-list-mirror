Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFEDC83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C97A20731
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 09:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef/0fbjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgD2Jip (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbgD2Jip (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 05:38:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D33C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:38:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n24so634812plp.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1zOeUqWUwZXh3Z/CoAi+h+y3jNsWmWfxpZoW30Ukns=;
        b=ef/0fbjGukgZ1t1wEaiXqRq7cfxwoCF0aUqNut8pOS7Iv7KbsPheg0c5Epyfg4buL0
         siyQfbqqHiRdCX5Ei0c0pyhLyxrBjQsOAz5qcPnBzLSE9z0AunCn3GXJ8FGj5xRLJaFY
         znjYJJzvDToc/WvqV8bXWheswCC7fuijFg9fxG2rogpolGLSr5pX/Y5WhWBaTrpNEIp9
         3YiRpvvRnR/1hM/CTk2h2m07MzunNU8m7GKObfQHccleetAMSdD1btIws1dphFRf4YS/
         1BZC+1BiDarM09+WI6BlhvxAlcXPgFuu9bMb9tMb6M93ul67ztPsG7Xc2baHSTg7/Mdq
         Hp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1zOeUqWUwZXh3Z/CoAi+h+y3jNsWmWfxpZoW30Ukns=;
        b=TX+AWT1bjAwWprteVh16U3OAasA608MslM85aoLiB/4h9pUT9HfPuHdqB//ZI8FVZt
         TtbIHlx0qaq0Ydz4Tj8pYYoRmvX3aeHAF8aR2ehqHym3G+z+Bk4e33d3aLDuzBGGOzEv
         juTQVd79JSzQJFHD/raKYvCMoKmpgYCzO8oYFZLwzn+M8LXMaCkXBMl/seMzOajX1vj3
         QuuYKChxKVPIWan57i/KHb+ZjwfvjQQR36GVeG1Lgvo63mlKE7dGDLEQHplmqF832nQh
         yeUUCUuIKpBTicbF1gNlCsMaXZ/UGnrPbbOhL5pq2jZo/AcHiqwxZYGpNQf7x977Da/V
         CYLw==
X-Gm-Message-State: AGi0PuaUZpYMbQ1PGToVDiYVsu5t2ckHiMCVtqPC8tDr20bU1nVryam9
        WU7GD7cH5wI1kaeF8glQo811A/Sg1DA=
X-Google-Smtp-Source: APiQypIrf7JC+UyKT5whq1GZUashvUwnr/5kJsG68o46podOW+yzIwEgnwmtixxG8CgaHeoSw818mQ==
X-Received: by 2002:a17:90a:5289:: with SMTP id w9mr1901134pjh.97.1588153123725;
        Wed, 29 Apr 2020 02:38:43 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.176])
        by smtp.gmail.com with ESMTPSA id o30sm667721pgn.12.2020.04.29.02.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:38:43 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v4 4/4] gitfaq: fetching and pulling a repository
Date:   Wed, 29 Apr 2020 15:08:11 +0530
Message-Id: <20200429093811.8475-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
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
index 6f32846e3d..e091513639 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -253,6 +253,26 @@ way of cloning it in lesser space?::
 	Any entity which has not been cloned to save space can be cloned
 	on-demand. See linkgit:partial-clone[1].
 
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
2.26.2

