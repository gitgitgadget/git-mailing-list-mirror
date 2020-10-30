Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B64DC4742C
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04FEA20738
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 03:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR/2QlOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgJ3Dmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 23:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgJ3Dme (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 23:42:34 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E8C0613D5
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:47 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n11so4473674ota.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 20:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yK+JG9hRuWwbWaDVifd7XcrTPIdCvS6YG9pr3fsEa0g=;
        b=BR/2QlOnHF9nre+tlaMxpg2z/DjmRS9McQkYexbFmVQCNUC2EYUIwzphX0E6hrN0ry
         z+iz1K9Pfku+IF83+sCZjUCZVmh2W1Oy/EHqgqPgaTaGn2qlGr33L+a4v9SvBTzVVSYJ
         3U4/0Zvuc9gVaAdfaTH67/rx8QOHt37Ra10ad5/NfYNNau7RIEKhl1A9ei5nr20kWx+W
         3JSCBIsRmxZLO2pGaVVvsDymVQsWMvP6aJQeNmnnVarlY/IYeRUEKXLPRZJIHa+pC+Dj
         RDFYof7DSmdzrMmWuusC5wlH2ucP0AVOPCl28zsyZbYz3kMB53LvTlhAGEVFGxLG+UJ4
         grKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yK+JG9hRuWwbWaDVifd7XcrTPIdCvS6YG9pr3fsEa0g=;
        b=dMfzeJEKMyW5ZCTqEbq/MG/BWTcSxadPd0NSQNtRS+b/Xowl4UBxr/aaTrRZ8SYEKn
         Hm35/itIfp6KNCX6g7jCr+a4NbjiPpQ4EDm67NS4lhBYcDrAA6QlK0x8kj4Pd5k2efw/
         FwIJf8YqTmgCk23f4yle5Nx+H7PS3bpjEKdIDovBppgpCHCp5RTCqwNdf35HmQuX4WUd
         0yEEI2Oa/kvVgBsRIhZKwf+SS8v/cWy3xUYr3lRK8g2UcVNwErZSYMTYhlcDYcSpsL4n
         10mAGP/0R3JKkFEOoqC3O51vzqgBDkapG0frn6JEfpDnmSATA6zrNq13zxbfxGRlX2nK
         sG+A==
X-Gm-Message-State: AOAM530JWu6GN8jXbwf09wl5NEt2fqKghHtfBlAAglgQlO7DKl3PqitI
        y+7uZwIv2UWCAw9EaBos0JpXvWX5OikOCA==
X-Google-Smtp-Source: ABdhPJyVh/BZVYaLmxYk5eEd5NPVlfjk87U5unF13344xOH8dcSetOuaePcJWgpWxegcLdLkOGDeGQ==
X-Received: by 2002:a9d:7848:: with SMTP id c8mr214937otm.120.1604029306631;
        Thu, 29 Oct 2020 20:41:46 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id x13sm1047063otg.66.2020.10.29.20.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:41:46 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 04/20] merge-ort: use histogram diff
Date:   Thu, 29 Oct 2020 20:41:15 -0700
Message-Id: <20201030034131.1479968-5-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.56.ga287c268e6.dirty
In-Reply-To: <20201030034131.1479968-1-newren@gmail.com>
References: <20201030034131.1479968-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some ideas for using a histogram diff to improve content merges,
which fundamentally relies on the idea of a histogram.  Since the diffs
are never displayed to the user but just used internally for merging,
the typical user preference shouldn't matter anyway, and I want to make
sure that all my testing works with this algorithm.

Granted, I don't yet know if those ideas will pan out and I haven't even
tried any of them out yet, but it's easy to change the diff algorithm in
the future if needed or wanted.  For now, just set it to histogram.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index bee9507319..e629d7b62c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -21,6 +21,7 @@
 #include "diffcore.h"
 #include "strmap.h"
 #include "tree.h"
+#include "xdiff-interface.h"
 
 struct merge_options_internal {
 	struct strmap paths;    /* maps path -> (merged|conflict)_info */
@@ -137,6 +138,9 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	assert(opt->priv == NULL);
 
+	/* Default to histogram diff.  Actually, just hardcode it...for now. */
+	opt->xdl_opts = DIFF_WITH_ALG(opt, HISTOGRAM_DIFF);
+
 	/* Initialization of opt->priv, our internal merge data */
 	opt->priv = xcalloc(1, sizeof(*opt->priv));
 	/*
-- 
2.29.1.56.ga287c268e6.dirty

