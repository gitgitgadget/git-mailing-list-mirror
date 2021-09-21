Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E27DC433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4774D61183
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 15:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhIUPyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 11:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbhIUPyC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 11:54:02 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45790C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:52:34 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f22so56285508qkm.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=Wm7kDfvleJGW/l2leShKavXX9fsJep/3lbXmcnm6dkE6jWfLB/YNWg9gSbW5YcjTlE
         DBT/iASh+Ph0CFpthDqiiSq7gOiU3I/S3qcjgsOLgnM0bzm8sI8k0RH81/3mWlz81Gu9
         oaP/OW/k1J0vYlTAgdrfZz5nBdeeO2YPSPGlYxkCAHdJxRjX5Vby8w/l5llHARAv1MQi
         EmahIjM5HQofCV0sI1Sh95Sa7ZBboJmPE6NI6/m1pvBLwCR1SI6NP0K5657P8nXn786Z
         Dtt64bzG2mogbfZGhZRnlY/bL4JlCrgQT5JGVlniZs2wP4npFKrgtiR7DlBDp2V1WjKS
         Hk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=SaUQgMtCdCfLha7YCnFMeBmmDf/ZREVyJCyrlpySOaFc6L8/6rDKowezdXpP9VEC6R
         OgdJRMSHiHV99mfWmuqpl8GYAG8Qp0x9ArEAl1sEjHzUx/WnNlpXAKp/KFdLcFYOwYRH
         Bver7/h0C1VOtj4OkZn80thZFZOK6ZMOJEK1SmBZroa+ajLYikFWFxBJ8ghrrOxZWAZw
         2mPqQpk+7Mplicw9lEyNuwRnvKhoZccca/3IpUznBOWk4jIsKNQsEuz6LhoKQUWmMjc8
         A7fhElN+kcpB02tZYU8VRzSzk1TqovUxXFVQRAiTvFXYHeIQ36nF2qZRFm2nfa/5Rjrf
         z5zw==
X-Gm-Message-State: AOAM530iXSgmwu+1IWRIvEOS7IjS7W23utO9aQTbM0XYFEZMyZ60zlm9
        Yci5fSMDoKOlVimCj7Odd0DbbXvAqrw=
X-Google-Smtp-Source: ABdhPJyP6ZKEECWD04FWCmPsCDZIAA9MRchgb0M4zDtJ6yRe4V/ARMa9tNSW3txaurs7mBGS8Ktt+w==
X-Received: by 2002:a05:620a:530:: with SMTP id h16mr15777553qkh.230.1632239553430;
        Tue, 21 Sep 2021 08:52:33 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id z9sm4956124qtf.95.2021.09.21.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:52:33 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v4 1/3] send-email: terminate --git-completion-helper with LF
Date:   Tue, 21 Sep 2021 11:51:50 -0400
Message-Id: <20210921155152.4215-2-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921155152.4215-1-tbperrotta@gmail.com>
References: <CAPUEsphn15H9HbHKHRk+GFMvjq5O=8NL0Vo4L8NoUwiRrQUJJA@mail.gmail.com>
 <20210921155152.4215-1-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike other Git subcommands, "git send-email" leaves its output an
incomplete line when "--git-completion-helper" is asked.  Be consistent
by terminating the message with LF here.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e65d969d0b..d1731c1755 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -114,7 +114,7 @@ sub usage {
 }
 
 sub completion_helper {
-    print Git::command('format-patch', '--git-completion-helper');
+    print Git::command('format-patch', '--git-completion-helper'), "\n";
     exit(0);
 }
 
-- 
2.33.0

