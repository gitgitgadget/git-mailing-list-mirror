Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA16C47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB898613CD
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhE2HrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhE2Hqt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:49 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A879C0613CE
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:12 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so5779925otk.5
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaDUUJtBHOSKUGXjCQ9xiQOF0tQz+VG/Rz1liXUEdgo=;
        b=AW1yfeePsXEvucoFP/QgoeGUbAfQhp/p2D6lAa12Jn9I41iHPjGixqa/mNMFW70GDO
         jFRALJYAli1B1Xmn9SDezEXx94Y8q5hlOv/CLJSxM3fHTgSWiliwoAPNFXOdlLJMWQPp
         oIgqMuIravtcLp/buCpHWaQGV9Y3xH2O4Cad8y3OuJ/n3sPAs2OQOrl7atEM16fLfiRB
         KK6XdZxGxl84WmFtKn0pOIGBF6cyWBNy7gAfsyx0MMKt8sHX1gmXKvebyrGWRqsS8nIx
         9oatQskRQhbC+pNG8HbSqpc65tP00jFi9euVb0eRxsXJdmxRxRX0y42eH6OmXc5Y2tcn
         ZTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaDUUJtBHOSKUGXjCQ9xiQOF0tQz+VG/Rz1liXUEdgo=;
        b=k/qUny5M8Aa0gwAdD8/EDMZ+ECblXkd7xs8Kks+YXbcUmFwiVWH55PotBunRvwTbou
         WO9qurmwodJCI349iKm2wgv1DUFbqDP9YEMaUdKF2rV5wvoSP/ONxKoBRl+CISdjbORb
         LzYUGriUEsnGoacJP0+isUF4DVQ1yIc+RNOldpogUK6YbTMLaxnTR2cbXWn8AX3/xEki
         fNHUuTFG+zlR97coRkTdz+kN37UBwy6OcSwHjgN7uX6ZVlOnnnGv8o3DDaQBXj2NUNTf
         uEmr1kwrEn1U8/50THWpFET98+mOIzOfDYE6nbsoFPV4nOBaF98Fa60nXTjswnM49k+g
         leww==
X-Gm-Message-State: AOAM532P8llV6EfMOlweiLA0Hmsm7Kp+3boXOa0DQKRV2qOGpOHOa53V
        K0cYcQjgZBGmshsLODDtPuDAKU50gmwlcA==
X-Google-Smtp-Source: ABdhPJygEK0iQcM9v7FzU5JjlfdKMtVJr7GXIURarJXjTNRMTecOcwzXNS4mzrcb/R5rL2nvffp5Nw==
X-Received: by 2002:a05:6830:1103:: with SMTP id w3mr10026161otq.6.1622274311804;
        Sat, 29 May 2021 00:45:11 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f2sm1627868otp.77.2021.05.29.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/15] push: get rid of all the setup_push_* functions
Date:   Sat, 29 May 2021 02:44:51 -0500
Message-Id: <20210529074458.1916817-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Their code is much simpler now and can move into the parent function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 21968abf6e..dbb4f78e61 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -202,30 +202,6 @@ static const char *get_upstream_ref(struct branch *branch, const char *remote_na
 	return branch->merge[0]->src;
 }
 
-static const char *setup_push_upstream(struct remote *remote, struct branch *branch,
-	int triangular)
-{
-	if (triangular)
-		die(_("You are pushing to remote '%s', which is not the upstream of\n"
-		      "your current branch '%s', without telling me what to push\n"
-		      "to update which remote branch."),
-		    remote->name, branch->name);
-	return get_upstream_ref(branch, remote->name);
-}
-
-static const char *setup_push_current(struct remote *remote, struct branch *branch)
-{
-	return branch->refname;
-}
-
-static const char *setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
-{
-	if (!triangular)
-		if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
-			die_push_simple(branch, remote);
-	return branch->refname;
-}
-
 static int is_workflow_triangular(struct remote *remote)
 {
 	struct remote *fetch_remote = remote_get(NULL);
@@ -258,15 +234,23 @@ static void setup_default_push_refspecs(struct remote *remote)
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
-		dst = setup_push_simple(remote, branch, triangular);
+		if (!triangular)
+			if (strcmp(branch->refname, get_upstream_ref(branch, remote->name)))
+				die_push_simple(branch, remote);
+		dst = branch->refname;
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		dst = setup_push_upstream(remote, branch, triangular);
+		if (triangular)
+			die(_("You are pushing to remote '%s', which is not the upstream of\n"
+			      "your current branch '%s', without telling me what to push\n"
+			      "to update which remote branch."),
+			    remote->name, branch->name);
+		dst = get_upstream_ref(branch, remote->name);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		dst = setup_push_current(remote, branch);
+		dst = branch->refname;
 		break;
 	}
 
-- 
2.32.0.rc0

