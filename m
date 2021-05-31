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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65106C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A97261057
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhEaTxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhEaTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:53:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A22DC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:47 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v22so13271143oic.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hhxrYUF9xXALnAcO6sx0a9D+jTam16Q7fRpD20psQI=;
        b=YpwPS9MNpcDc+Rjry165KwXh8+jcF0jtyp/2zYD2L7x798Fe7RieroRBmpoxGpXB9O
         DbS+QFk7hD2IieCQ1grR3xWfaBmL2CvwoI+ZQHWnjLqGCG4x2d1HtsZt81lUdUpV1geh
         +GAkSha6YWhpsCy8lr2xNTRewbkinVRUnbYZPzP5e7p231eegTVvvJRfVJLmcOSHDcfl
         JHWaYSqhRmiwgKV7dBAJRz2tsctkgATieIDXiKVUmy4cmW/XwMZtpLcTGcl2W40ovtOT
         qNMB6L68uHuQdUVIr9GbdCKjQmH54RPeLh9s9ZHo6UOiJ/lY8wN6qX735p8w51PJn4gZ
         o6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hhxrYUF9xXALnAcO6sx0a9D+jTam16Q7fRpD20psQI=;
        b=SFBckXftvCrVnTagqcGunx0h0LP5Ya2y/NdWFxpgy4gOThSkkAvdCu28R8N3vTmSvi
         TPrOLnuEzXkXh2oK0+U3eNGCqZgBaSeBY0awqHgPXz+tjQLFYRDV+SHZR73QCiQoWDCA
         CKTxg8LazDkOAej8cgrLl5tgSFJqBulhTfT8Oje/oLYdfcfoqEeNJ8xouy4v0PPPsS6S
         t0W6ss6KSoyjzT9MKhhWPV6L0KjCdPSdn73gNulQPEoEXSMaoy6q4Xn5VqJ/KUbci3ye
         GCvDJ7gUGKDTEvIhChUURm35xDU41qwDW6LBycTPs7qOS698DlOgKBMq2bhjTnbEl3vi
         ihjA==
X-Gm-Message-State: AOAM533Lje3Cxcy3ml5zInOLdzjyeafUwLhJTLHCvkShHnkt2DmI8IQn
        Y6PW19U10xiNdPdcCm8Mt9dX4HWCDWAz9Q==
X-Google-Smtp-Source: ABdhPJwxPm6o9qm8OPEJKXSsplcthegwFOHm/SlL9zr4TmjbgD86BiUR/kG3h/EhluWFgFA6c3z7bw==
X-Received: by 2002:aca:ac13:: with SMTP id v19mr5358346oie.128.1622490706778;
        Mon, 31 May 2021 12:51:46 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e22sm3223137otl.74.2021.05.31.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:51:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/13] push: don't get a full remote object
Date:   Mon, 31 May 2021 14:51:24 -0500
Message-Id: <20210531195124.218325-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531195124.218325-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
 <20210531195124.218325-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All we need to know is that their names are the same.

Additionally this might be easier to parse for some since
remote_for_branch is more descriptive than remote_get(NULL).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index f3916c66d1..e8b10a9b7e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -226,7 +226,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 		die(_(message_detached_head_die), remote->name);
 
 	dst = branch->refname;
-	same_remote = remote == remote_get(NULL);
+	same_remote = !strcmp(remote->name, remote_for_branch(branch, NULL));
 
 	switch (push_default) {
 	default:
-- 
2.32.0.rc0

