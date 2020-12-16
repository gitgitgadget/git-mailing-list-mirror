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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA6C2BBCD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3D72342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgLPSvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbgLPSvq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:51:46 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0F4C061248
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:34 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h205so7472520lfd.5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fur7RkFndXBjA/PkzpUSRAEcczQ+IhQLDUUVysKJ1oA=;
        b=RGHwXQ0IWxCp6HR7I1xaUzsBUpMkA7iw18PZlRPLzhPTn/kLd2ALptCswGJE9M0N34
         0/GYfO3hminrg7t5WCVB1zG9lDgAVJI0N6kt8UNHx9aasmd1nYLr9c+OeCAmd6zh86bS
         rwjgh50WZyz9r+5No62TbbDbsbLsKKFN8KFuOmWZMWDZD9AkfjC/rpYmpqTK/AywcqN1
         544uW47+ioxKwyCbhjt8as3/HvyJAo5cGqWJcOXMs1dPKAcUvCm7WO6Ms9kYyD9fcEBl
         2/O1c8YlB+RIvzqv7VGHfybjz6Hj9aLYb9WfsX4ILd/dtKHqLnveJ0/l4PgwfzvaxAlM
         Ty9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fur7RkFndXBjA/PkzpUSRAEcczQ+IhQLDUUVysKJ1oA=;
        b=eTcBkdlCY2WjsyZnf1JxrZeWuqcL5oUf+W7muRbzhwQFuXdrN99Uueyjtmi2WMnqyD
         ZnGHwAa8Z92i0rp/g3YA3HtBBO7p8wD8qbiDNnRM33IM60lzCQWfEybHgSqEgA1p0nmP
         3qLvEY/HGL0PqwkY5/wlkKkMi3vHPprF+o6rphYifsBwLnxmKigRvity2VLBYhe7LGcO
         eyGqOFA57SGu1tydYcN2aZHHUXu1aWojkzItd7DGjS6rWs7C+IFnWWtvmuBVG39c8n4P
         oWJ8wvZVP/Y4icNUaR2yzgt9sUnY2mq1M/a8kpuVGD6AijAQIcHNUOmywcwzQ+f7Cmpo
         TFVg==
X-Gm-Message-State: AOAM532WzuaIFD3+XpeAcl1eip5vrXX0XLOJmBDaxnqjLwvH01psQ0oY
        jZ9W37ele7QJ9F7SgqLiGViflRaOImg=
X-Google-Smtp-Source: ABdhPJztfdNZUBsAGcgmAORhrxvqiUO0ofkCMosbavf/S6GIkG1GkPItg+A28jAVWqohW006Y9ZHFA==
X-Received: by 2002:a05:651c:509:: with SMTP id o9mr14630837ljp.212.1608144632584;
        Wed, 16 Dec 2020 10:50:32 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 197sm313871lfe.158.2020.12.16.10.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:50:31 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 08/33] diff-merges: rename diff_merges_default_to_enable() to match semantics
Date:   Wed, 16 Dec 2020 21:49:04 +0300
Message-Id: <20201216184929.3924-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201216184929.3924-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename diff_merges_default_to_enable() to
diff_merges_default_to_first_parent() to match its semantics.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c | 4 ++--
 diff-merges.c | 2 +-
 diff-merges.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index a7791c003c91..63875c3aeec9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -600,7 +600,7 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
 				       struct setup_revision_opt *opt)
 {
 	if (rev->first_parent_only)
-		diff_merges_default_to_enable(rev);
+		diff_merges_default_to_first_parent(rev);
 	else
 		diff_merges_default_to_dense_combined(rev);
 	if (!rev->diffopt.output_format)
@@ -728,7 +728,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 
 	if (rev->first_parent_only)
-		diff_merges_default_to_enable(rev);
+		diff_merges_default_to_first_parent(rev);
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
diff --git a/diff-merges.c b/diff-merges.c
index f0d0ae208213..19b85bfdba6f 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -54,7 +54,7 @@ void diff_merges_setup_revs(struct rev_info *revs)
 		die("--combined-all-paths makes no sense without -c or --cc");
 }
 
-void diff_merges_default_to_enable(struct rev_info *revs) {
+void diff_merges_default_to_first_parent(struct rev_info *revs) {
 	if (revs->ignore_merges < 0)		/* No -m */
 		revs->ignore_merges = 0;
 }
diff --git a/diff-merges.h b/diff-merges.h
index 6937d46219f1..18861dc5480e 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -17,7 +17,7 @@ void diff_merges_setup_revs(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
 
-void diff_merges_default_to_enable(struct rev_info *revs);
+void diff_merges_default_to_first_parent(struct rev_info *revs);
 
 
 #endif
-- 
2.25.1

