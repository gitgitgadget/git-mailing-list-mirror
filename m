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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC04FC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C0220784
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBZQcVxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgDUNMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728866AbgDUNMo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:12:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0ABC061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n24so5212299plp.13
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rzJ9J1wtHzrN/KosoPr/+d14bcRLxzvn6r16lLzNga0=;
        b=nBZQcVxOTSamF0tgV7QfJIclbx2ZKDsao1s4MDDtUbhLaj8P9kRyLQ9PRD4uwPbr6P
         Ilxmpf1qGBURk68phKdQvzxQZYYU9ukALM0nE3yOy4p+y2cwLnP2IHcDB8fRri/KXO57
         sqZ3voWNqbM4Ji5eXcOVOghWbMn+TxExbQ8zfSimByDD6tMLtKnKikiUusUGLgoRznII
         R6ZwHFNKcb+IsbjN1OJclZprFC2qv2MLd22Ej0odADmt/uugsn0fLe4VPr9SIXfaStNN
         c73jiUMQcbb1XEdOBdcTfxBMK5LXXTYgvFlSFbWIe79YUguacO8GWjxGwgJptCA3zTVD
         lF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzJ9J1wtHzrN/KosoPr/+d14bcRLxzvn6r16lLzNga0=;
        b=TefDZiJEHDJYQPLGrisWPd3buXekcKInmS166HwrC67im6HCFnOEmhtXhbchc6YYd0
         00+P/bvmFoGHujCwBO1YSLaV3O7dRMxfew2b14Umy4foYWcnjuL4Fk3/ntWrtV1wBBAl
         B8yUIhs9PnsQY7MqbQXTM7iz2SM2z2gxZnN58pcUENuLrM9XfXk7Txp2/CH/VAlI2kvj
         nk6AaDjqAcx9cXRFIaTUSFAcVYuBQq+hdsafQpE4w1insEb2+zKs/6hOuXgW8uAl5fsf
         bNtbO6s6tYhTtYw4dIL/aeI15Qo5jY3A+Oe2J5+yPDs2WchLqKcZ4zHyN5gdZw6bLvja
         CDmg==
X-Gm-Message-State: AGi0PuY02srbZL1VynXzVi8is26APfZis1vUwox+5ACL7q5F2nq1Bh7B
        g3fASZ2+N8DEjUJNx2gJOfbSwBTHw6I=
X-Google-Smtp-Source: APiQypJxcWThnUqLbRSSSJcsznY3BVZEv/sX12T7J96XnZ6DwLGGUnOIEMtHgBORFimpppI9RTK7IA==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr5374423pjv.171.1587474762939;
        Tue, 21 Apr 2020 06:12:42 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id g2sm2451492pjd.9.2020.04.21.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:12:42 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v3 4/4] gitfaq: fetching and pulling a repository
Date:   Tue, 21 Apr 2020 18:42:23 +0530
Message-Id: <20200421131223.29337-5-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
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

