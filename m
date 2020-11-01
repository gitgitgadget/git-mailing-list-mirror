Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B159BC4742C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A63208B6
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iua2Gt+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgKATeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgKATeM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:12 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A763C061A47
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:12 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so14659251lfc.7
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1F97epblfnDEQmCCs3FCvmUL1lsWDWBZOptv0P/Sm44=;
        b=Iua2Gt+DsbwmpeevJUeau47Wzjp8qDst3OjfwAI5n6pDd8pucby5GDLwn4zZl1kxKX
         9sXunCNpV6lV3yzq0a6vdGOnuKZsIEhQSPFecAbiuJeXUX+gPgfrz+iDzFEuZHvXjYmX
         Lv0CSZh4CbI9alK049KQiusj33JjsKn9rmoAovcUp09binOADEmflFq4FRLFbqF2Bj22
         rLi5vw/IkR0kuN1/7JPuS4ib4lUFgqh40IyFnxvEqy4PTedlzrllxO1nN83alOPlOGH7
         ztmNy6pHjjeHCCxHHcZk/JNDTtIY1ZQrAIFyh5S8pRI7z4/GrR+rtfSluZAl32hdTqxG
         eHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1F97epblfnDEQmCCs3FCvmUL1lsWDWBZOptv0P/Sm44=;
        b=Tuoo3uB0t63kVp3F6ygPgxJjsq3QxVPVdEgwRzmGTQqjILvmWWH9cWwLy9vFWm6Dmv
         EPiDjQXmTHf5+Vnd3eMJq95+qy5BjHHURYD9Dq79zXxjy9Gn0CcTNA0gi4Ld2FHjYjoP
         N+awkEbErW9U2yenXdYvx4qiJKBSUt4n+NpMX4iTZ09FH3TjVnFK1KeigB9EStxHuLJe
         DfyZh7ySmF2l9rAD41OJgfrkXix6UPNuOicIV659qXdk1VTDHAnjzQ8zdjsqptuXfbSv
         sRPmlu7rQw0dzoqtzF/P0Sl46wK/6jU/9JJpjV4+7Spk5LUPY5FMm+DIGFAehbt3UU+e
         z6Dw==
X-Gm-Message-State: AOAM530z6uUjQo7nutxuwNTkrhMamaQV85aPBz3extrvjTXVZ7o461VK
        RKHcPnIy1zHL1fClcRTlSwppO6HxGag=
X-Google-Smtp-Source: ABdhPJwoJ8XWakpHuAZ2kiyXX1T4m8iJInRZa6X8dSQ2DZbiDGFjHkwr8lELuBp8NrbIlqAsE9mi0Q==
X-Received: by 2002:ac2:5486:: with SMTP id t6mr3872943lfk.43.1604259250869;
        Sun, 01 Nov 2020 11:34:10 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:10 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 08/26] diff-merges: rename diff_merges_default_to_enable() to match semantics
Date:   Sun,  1 Nov 2020 22:33:12 +0300
Message-Id: <20201101193330.24775-9-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
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
index 9dd472803d15..bb08a92e3b36 100644
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
index cf411414898d..20b727bd734f 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -11,7 +11,7 @@ void diff_merges_setup_revs(struct rev_info *revs);
 
 void diff_merges_default_to_dense_combined(struct rev_info *revs);
 
-void diff_merges_default_to_enable(struct rev_info *revs);
+void diff_merges_default_to_first_parent(struct rev_info *revs);
 
 
 #endif
-- 
2.25.1

