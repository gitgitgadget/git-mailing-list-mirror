Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECD1C433DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E162D206B2
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 02:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg1CF5q6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHICTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 22:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHICTd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 22:19:33 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FB4C061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 19:19:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 2so2939253pjx.5
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 19:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CxgPpPjNuZ14/rGw6+8yffC55Ttv/ZwEMVYE0Qo9yP4=;
        b=kg1CF5q6TDOh2RKoDVtp/QCnylOzaIXsA9tjOpSa9XUvDncXdaFMrN+rTK4D0e4xoH
         iWlKUwzf/S9SDmBZEwdr+4psRSbJBA+38zA9g2JbMir1soNyG9heZpFkchqlpA6mvEMm
         KDq9OZTy7QymJRXCEEBFk9YLGLyls9+5cgukQ4HPfk3Lz3VFqI27SMzgCaO6hL3YqpUu
         AriyMakOLy5ehbefbcEB4HacDUoSpf9X/8rjwwN/VwqsronhHM3NIOURa60hTLPOcuWK
         JkimMM51VX54rGUs3kPjXc7ZJCMNd5txiEcPTxn+9Cf4eo9DwN0R/Zgrk2W9Z+CQFwJk
         NUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CxgPpPjNuZ14/rGw6+8yffC55Ttv/ZwEMVYE0Qo9yP4=;
        b=DhgiMHZvC0uHwhnh7n8sChGkt2a26Z3R78Q3W66UZVcA598j6JjVOOtyiBvrtu8Oaj
         9ssNs9G+eMKtXrptH86HO6dpunjjNPi0Oy0pFHBnoEyXcfzgJffkMPkUa4AZIyl6he47
         gNhnwufAhdOKbDTxWYMLco3lbREtpfrzAiXWgXZ7FjgWdNNbCnnvmx6vDxP4uodC3/aL
         6JnLFbNR7uGWF7ijx/uhMpi8LxwmKmPKnunAPp8nJIR1c8Ak4nDK5RLEV7kJVcJc0ItZ
         rWLM4RLVXtXEOANW/8cHfNC6vY1RvTK/tlUImSPekX3fMSOrrHc9uGyn7VNNLUI4/+Oq
         EeNw==
X-Gm-Message-State: AOAM530fzWwHVUnJImvLxtH+bv+HXlyPjFate6lWPTcW0xxuIMhalxxq
        1F9XJYz36ffRncOrgFnvyWW2ZdeJ
X-Google-Smtp-Source: ABdhPJzsAdbAX75fS/1gQcG3B3vqw72INd7dxog3HWouhhrwJlXYVZgKtsCYntP28kPm4a3WRxvrug==
X-Received: by 2002:a17:902:fe10:: with SMTP id g16mr18960170plj.43.1596939572904;
        Sat, 08 Aug 2020 19:19:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id g129sm17631235pfb.33.2020.08.08.19.19.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 19:19:32 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [RFC PATCH 1/2] revision: differentiate if --no-abbrev asked explicitly
Date:   Sun,  9 Aug 2020 09:19:04 +0700
Message-Id: <33c02761534f4e0a272f7bc9c7c9ac0218724ace.1596887883.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.215.g32ffa52ee0
In-Reply-To: <cover.1596887883.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we see `--no-abbrev' in command's arguments, we reset `abbrev' of
`diff_options` to 0, thus, on a later stage, the object id won't
be shortened (by not set object_id[abbrev] to '\0').

While not doing anything is very effective way to show full object id,
we couldn't differentiate if --no-abbrev or not.

In a later change, we want to extend --abbrev support to diff-patch
format.

Let's ask for full object id if we see --no-abbrev instead.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 6de29cdf7a..69cc834662 100644
--- a/revision.c
+++ b/revision.c
@@ -2432,7 +2432,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--always")) {
 		revs->always_show_header = 1;
 	} else if (!strcmp(arg, "--no-abbrev")) {
-		revs->abbrev = 0;
+		revs->abbrev = hexsz;
 	} else if (!strcmp(arg, "--abbrev")) {
 		revs->abbrev = DEFAULT_ABBREV;
 	} else if (skip_prefix(arg, "--abbrev=", &optarg)) {
-- 
2.28.0.215.g32ffa52ee0

