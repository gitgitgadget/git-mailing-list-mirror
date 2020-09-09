Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9218C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 13:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1332087C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 13:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxO76aYI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgIINRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbgIINQr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 09:16:47 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9627C061755
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 06:16:11 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j10so1426727qvk.11
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIzLEhXAt3+nKIfEm64Saz47n3J63AjGwQzsI/jmy8U=;
        b=BxO76aYI7t5jebXffq41wNF5FNk/e9rwT9yuMs2j8qcz8QMes7pDlALEjCVJWzL56f
         3VBOC2ktqxXUzcfDeJHW8vQvdDswFiQQyO3xbl5sp/TkRj1h78rNe9HiQoz1nAj5n7t2
         tynNBbYz9PE9Wt5gcN8uzJKeM2gtSo4tqAoRKTWnZn3dlYhQaOupwrZxec+nnuuCRSm8
         CxCCgkbIzzc2ezliv+PT3bGRqZIKXZSUcmDUPX2FXXhg+3dHd34DCUBylqBMpAPT+s8k
         9+xB8bYF0OZL85lfGODExtDnCZPe7+Ub7WNqseuekUdCy7wo/PiFc/pFbuW+AnyLPHAO
         Pafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIzLEhXAt3+nKIfEm64Saz47n3J63AjGwQzsI/jmy8U=;
        b=VYS8wxrnw1+DAMf8+OAngM/YnaHMy395t6G09jNLmmSAI3nmsYCIDHy6p0oT8hrrC3
         N5KFVswV9eYcX+DiZenCpldFpIGLseoZYqqBiAukuftFTc+aOyzAwi5HWQg63iPNgGHv
         nIXkgPqI11MqfUcGxWQzI3lzmhHlrFVz7HMYXbSuv3fH14G9hWyYfu+9BzK3R6++yDL6
         B6sgf314VXkR/ktLfPajWKgw2zCsI64UoHHVxGG7KZdUoWKwn9q7zEhEgiBdAe7m4xPx
         dIcA3R4yydm8zcNPAoWrdAq8nPQ1Do//zQxmKuzLKHlCu1mfK6S/5OmMKZB/pEVGQeUm
         m//Q==
X-Gm-Message-State: AOAM532P6eRj1j2wrJkt/7ky3eUkTjZZF077S+JO9cuo4906Tjp3Ie1o
        8D/hDpgLdbMzrqw3ZiISQCY=
X-Google-Smtp-Source: ABdhPJw+ntJEs/umSOofpivi1mHUr44QRVzTOTj/0+QTcqhP61UsBdV+gd17UiqOy/2dEiZjPFPCEw==
X-Received: by 2002:a0c:a3e5:: with SMTP id v92mr3992301qvv.4.1599657370950;
        Wed, 09 Sep 2020 06:16:10 -0700 (PDT)
Received: from linuxerio.localdomain ([186.32.194.42])
        by smtp.gmail.com with ESMTPSA id z74sm2606373qkb.11.2020.09.09.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:16:10 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     dstolee@microsoft.com, git@vger.kernel.org, peff@peff.net
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v3] blame.c: replace instance of !oidcmp for oideq
Date:   Wed,  9 Sep 2020 07:15:50 -0600
Message-Id: <20200909131550.826462-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

0906ac2b (blame: use changed-path Bloom filters, 2020-04-16)
introduced a call to oidcmp() that should be replaced with oideq()
defined in 14438c4 (introduce hasheq() and oideq(), 2018-08-28)

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 blame.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blame.c b/blame.c
index da7e28800e..a8abe86ae4 100644
--- a/blame.c
+++ b/blame.c
@@ -1352,8 +1352,8 @@ static struct blame_origin *find_origin(struct repository *r,
 	else {
 		int compute_diff = 1;
 		if (origin->commit->parents &&
-		    !oidcmp(&parent->object.oid,
-			    &origin->commit->parents->item->object.oid))
+		    oideq(&parent->object.oid,
+			  &origin->commit->parents->item->object.oid))
 			compute_diff = maybe_changed_path(r, origin, bd);
 
 		if (compute_diff)
-- 
2.28.0

