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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B17C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AA7610A6
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhEaTel (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhEaTec (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:34:32 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D01C061760
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:50 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so11956268otc.12
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpAYWAyESuumExWro3QllGRKGVHZdpREMB1qPvfcFB0=;
        b=r19pGc5PpT+p6X6Ks8HwtNwKFWGjzHGi8b2xneTDwaNqG8gua4YGFW4kH+VE+srR9w
         /j7bTAVw+mtUd1dbdBi/N5Hzsx9saLIcmEh7zZU0lIHPkSM7Pv9hA7cVc0neAKK7nQ4V
         B5qTBDPWEZ17BemWU6ljHgZtFNK5A4GiY8YAFEtKxH6QkTcQRrrNKWL0uWArqDWLuYPc
         AnVsjcqoWnYJc4kBZeeYWzPNQUD8iQSFrN96QPq6Drpqah/3CAC6EkwFRmlVAqPA+KN8
         q1M7C9edObIkhdlJJKRW5mdyunK5FSyT4bSA4zyw9MfPXcFeVktntk8uH+Mo35VrTVrB
         gUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpAYWAyESuumExWro3QllGRKGVHZdpREMB1qPvfcFB0=;
        b=ILYAlGqSCpoVVJSptZ10ZKHWWFsfzROj1cS2Okxw6n20yX9ctS+gpLxTPR4VSrz89T
         g84Mwz5tvCr5M0e0hJBC/3s85yrEfOEXMPfG5OFtaV/15a/ivf6ZO073fFp9p+7MzIXx
         MGR6pCMdBNhmjs5S6LApkc2tkHU3a3kzDh+PtjKCCktz/fkduNZPD/rnLwQYQW0TenBd
         5058PS3/sIUzgbIZhLhlgPU0X2TynvGUffZ2MxRWE3OYSqdd8hVyUuN4Q1dDY6FKh7eF
         kIzD79RX1WPfJAz7el1pMXi3wsmn4htOrQlluR6DA9lBXTqs69GmjycoDKIEPuLQkjSC
         6E2A==
X-Gm-Message-State: AOAM530hPj/5unGyWHVEfGgo5C5Kj8tJuy/28QZjDDcPlqXmtv9qBSMb
        Bi9naQiZkWgkb8sKcxf0liimKDFgHanYMA==
X-Google-Smtp-Source: ABdhPJzenE+tv4pj7b3f1VdLLblVBoxTLy5PJtFPDP2JbGjQucVFpRbmmWSFn6/xPgJROIRzcagqng==
X-Received: by 2002:a05:6830:2412:: with SMTP id j18mr9588646ots.65.1622489569336;
        Mon, 31 May 2021 12:32:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x31sm3262561ota.24.2021.05.31.12.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:32:48 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/7] push: simplify setup_push_simple()
Date:   Mon, 31 May 2021 14:32:35 -0500
Message-Id: <20210531193237.216726-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531193237.216726-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a safety check to make sure branch->refname isn't different
from branch->merge[0]->src, otherwise we die().

Therefore we always push to branch->refname.

Suggestions-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 972d8e1cfd..e37c751268 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -225,14 +225,10 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
 {
-	const char *dst;
-
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
 
-	if (!same_remote) {
-		dst = branch->refname;
-	} else {
+	if (same_remote) {
 		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 			die(_("The current branch %s has no upstream branch.\n"
 			    "To push the current branch and set the remote as upstream, use\n"
@@ -248,10 +244,8 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 		/* Additional safety */
 		if (strcmp(branch->refname, branch->merge[0]->src))
 			die_push_simple(branch, remote);
-
-		dst = branch->merge[0]->src;
 	}
-	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
+	refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
 }
 
 static int is_same_remote(struct remote *remote)
-- 
2.32.0.rc0

