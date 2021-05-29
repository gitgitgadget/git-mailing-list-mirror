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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFA4C4708E
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B220E61222
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhE2Hqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2Hqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:43 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5424C06174A
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:06 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso5780190ote.1
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ziLbiLnU21FpGhprFKwH7Xx9L/wyE5phuY/7FCO0pFk=;
        b=JKWiN+tMlUzygbiyLVTFujBEcJGLxwjoFZM0CxFl0cByun39LeVinqBj6Dzw9rMrau
         TkogLHC2h2M1C0JVIDNH0okTdPSkFo8AdxA3il4/qCDmYXdmyWediSzheYjJ7r4ixBV+
         USEDxRFVLOyG4b7FN6gGd96RH7bAGe11IyrOBGw5UtogAntIq7jWZ5vRpokhmARgQR+9
         YRCkzalaa8eFWYGv9Yh/CrOhDPfylpj7Z1ls2u4ILR+mMpnTCkMlSFwPB8KZ4BqnM4dZ
         vlYZOVw3Ldmkkw7QRJiqppBGbi0wdDkHyvc6GzRVq22BFsz7zK1nm7h4FPa+LBKw5m+L
         EPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziLbiLnU21FpGhprFKwH7Xx9L/wyE5phuY/7FCO0pFk=;
        b=foFjk5O/GhC7vvDFr04nsVFTP0my4LcqEPQPdeTqqzzTT4hnESUViJfEGqXtb89hMS
         OaQSl3w0J/aTCKEtgbg2uSyXU5j5KRnmyw6rK9sCMRurwD271virbFfuAXgfUIb4uLlV
         lq63LsmBhQab2VRsr/QCBfW2SLv3xVbrP+RBPwzWuRrrbSdV2X4dWc2VgG7gYQaL9etY
         HcUQ7kC3z9rxmIq+RB80g9oii8IgcWexlroHecQ9cyyALtk15mYO/+BzAkU/pBai4OEc
         wWVLdnWSPUthngOgm7Rk7gxNq+dBJ9AWbc/pj/W4sPx1vmF5ZZXpCUWR2wwA8LRDP/rL
         4VhQ==
X-Gm-Message-State: AOAM531wsBVRBaCwbw3Quls37EqZ11Cf1PqGQIm+K/Vmh425GKfS/Q9T
        H9xwat350hTJV/QVRNxeA7jjb4zMyc6XhA==
X-Google-Smtp-Source: ABdhPJyBdY68ogGskn1wVZyAljEiN+25ZwRXlKVajgUhS24SpHoGAAXEC36BBvgDF3O/Gk865zO/hg==
X-Received: by 2002:a9d:4584:: with SMTP id x4mr9571405ote.85.1622274306006;
        Sat, 29 May 2021 00:45:06 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x3sm170296oov.7.2021.05.29.00.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:05 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/15] push: factor out null branch check
Date:   Sat, 29 May 2021 02:44:47 -0500
Message-Id: <20210529074458.1916817-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No need to do it in every single function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index c19321bb9d..a2abacf64d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -206,8 +206,6 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 				int triangular)
 {
 	const char *upstream_ref;
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	upstream_ref = get_upstream_ref(branch, remote->name);
 	if (triangular)
 		die(_("You are pushing to remote '%s', which is not the upstream of\n"
@@ -220,16 +218,11 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
 {
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int triangular)
 {
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
-
 	if (!triangular) {
 		const char *upstream_ref;
 
@@ -265,6 +258,9 @@ static void setup_default_push_refspecs(struct remote *remote)
 	default:
 	}
 
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
-- 
2.32.0.rc0

