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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0008AC47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE9A61222
	for <git@archiver.kernel.org>; Sat, 29 May 2021 07:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhE2Hqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhE2Hql (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 03:46:41 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD30C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:05 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so5780549otg.2
        for <git@vger.kernel.org>; Sat, 29 May 2021 00:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=piglmFcV0XEcRErKuJHsM4ZPjFzpow631R50OxUQWMY=;
        b=eRqbamLwz4UUl9ichT3KiFNMASgsGASWsi897FZmPORC2EBZ+es/JLKY4iD/oIIyfJ
         UKxxXyyBTAqjYyOuH/p65FCOomG2D6xrwMZa1yS+HfkkdWdEvmyPhcvTqEoDxGZ6z96F
         qKFsHrP8n2YwiVPIsBMf66Sp4rtS6+80CBH1XsQA2V51cxvVZBgXo3EDAEdkn7BG+6SF
         xhXNyILf07cwkW2v+5cgtHEtAOF5G5N5TG8otfPJ/6yXWT1jkaqyCdLWuDOvwXuJi3nL
         ZjmnpAUB61+q4nfxO3KWzcaFeuptRl7M/Z2/w2E9ua2d6G8iPKToR+aMBeA0tHlFY6rT
         O3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=piglmFcV0XEcRErKuJHsM4ZPjFzpow631R50OxUQWMY=;
        b=G1AgB4rCcx/gul39DFyESLQiuk34BB79NWHumcYTEzFMkwRRKGCqKeRK7g+f8ekhz7
         ZIAbEqfADGX9edafRQMbo8Ru5Aie1a1H8e+t65DopQxe991VnzEgRtQ1TjsBTzXUtnT4
         v7fv0cUkb1oi3pcb5qIOyKOMFIAmZCKUHHxkIjR8bvH8Qrj9kpi928KyW5Y1eYMW+Fgq
         kBH+tz3zgkxEW08sqGGEqn83MhVxgEcL5VjbgelFE++/HsbNI/O4g77w5PJX7LvmqHzb
         804pnzNsf8+j7GIRXAYkLRqXOxj3cP9o0cGoiKh8LFnamaL+OLjBcGI/csitef4aDCnG
         kLsw==
X-Gm-Message-State: AOAM532kKVZwUUNq6VbiHU1DhGB1DWesD1FF4huP7vcNdeUcMcAA6mHL
        Dzw2966XRmdPEHLqUUnvoqVAtYCiidxoqA==
X-Google-Smtp-Source: ABdhPJzP01L7PzGvz2uF2BKy8KQ0FsyuEKnU60FUkop8TrxBkzTXKeE+zZn5bu0xCtj1E14VlKS3pw==
X-Received: by 2002:a05:6830:15c2:: with SMTP id j2mr9635634otr.367.1622274304502;
        Sat, 29 May 2021 00:45:04 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id d65sm1649450otb.78.2021.05.29.00.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 00:45:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/15] push: reorder switch cases
Date:   Sat, 29 May 2021 02:44:46 -0500
Message-Id: <20210529074458.1916817-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210529071115.1908310-1-felipe.contreras@gmail.com>
References: <20210529071115.1908310-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want all the cases that don't do anything with a branch first, and
then the rest.

Will help further patches.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index f4e919450d..c19321bb9d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -254,11 +254,19 @@ static void setup_default_push_refspecs(struct remote *remote)
 	int triangular = is_workflow_triangular(remote);
 
 	switch (push_default) {
-	default:
 	case PUSH_DEFAULT_MATCHING:
 		refspec_append(&rs, ":");
 		return;
 
+	case PUSH_DEFAULT_NOTHING:
+		die(_("You didn't specify any refspecs to push, and "
+		    "push.default is \"nothing\"."));
+		return;
+	default:
+	}
+
+	switch (push_default) {
+	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_SIMPLE:
 		setup_push_simple(remote, branch, triangular);
@@ -271,11 +279,6 @@ static void setup_default_push_refspecs(struct remote *remote)
 	case PUSH_DEFAULT_CURRENT:
 		setup_push_current(remote, branch);
 		return;
-
-	case PUSH_DEFAULT_NOTHING:
-		die(_("You didn't specify any refspecs to push, and "
-		    "push.default is \"nothing\"."));
-		return;
 	}
 }
 
-- 
2.32.0.rc0

