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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA68C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432A4613F9
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFITbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFITbN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 15:31:13 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D058C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 12:29:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso2043542otj.4
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dur5G+hLZo+ar4ECS1kdwGrRIjsqjsURTMLNP5itG/c=;
        b=FrjMGKmuVBB19bVRoX98jvvnVygishV5VCGghPG6b6gsnNaEDEA8wNBXAwhIq2jgDT
         t9TKnq9fVj/UPbur6QLCPTD/kb/Q4D2B/V7nlF+4KJxODwIVor1quQvdOmAvt+QanG9M
         P+odyES+5xq+R/Shnqc5mjd4NZkbWEdEYkNaZ+M57taCjIjj9B1jIGqOQ4TnT5CRqo93
         6nZ6dPmwXQTfp0cDn+PsD69NKKUFVxotwg+hKzrGxEXn0TgeTDiWRNeA9zwyBdlYXBld
         UwMshUWHAZw0OF79yElP7OBaa5hWuzElX8aLhZY0UbVOsXUpi+X9CGbX/HvcXXowLqn9
         kfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dur5G+hLZo+ar4ECS1kdwGrRIjsqjsURTMLNP5itG/c=;
        b=skBoyJrd3oVzwaSuov4p0uV00kfq2NeA/JHkkjeX0LVNNv/FjyfcGVNMTN4B5KJ7kM
         QaRBfs1kwe1XtEGDpCQfFpqA5xmnbq4cqsXo6dmnqj1hZTaQEEwsuBlFFgOXmVNFHUxJ
         HDavCU1CIJaZ591+TzlEaBd1AyOt+GYj0jbjx65y71UzW08TzaJkl6TgxMJ5Fb//pVOu
         JeBQbZFqlbM8/aNbZlyFvHUc2tElneTwU65D7XwvoNrjinivurvY8VgWC5VjXyGYrMiW
         nqenb3q3zGRBY230agUlG5XewYanIYCGHIOUUVncTl+s67TcjoB1DFoEutNo2oLIpMxM
         y62Q==
X-Gm-Message-State: AOAM531iJ4UahfbGzPIiORbEcRX0k5HLg1K3hS4vsYCP1qLJQdiKNb+s
        XhF8kvK8u+jyWn4Wlcy/ecXiD0SlCa0NpA==
X-Google-Smtp-Source: ABdhPJwuVbkoQclPfRu8VeUM5nCvgcCJ9Niocp+wEKnnSRncQphm3aw5X6puRN84U37kjMhAWPytow==
X-Received: by 2002:a05:6830:11c8:: with SMTP id v8mr831886otq.152.1623266942765;
        Wed, 09 Jun 2021 12:29:02 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p5sm135333oip.35.2021.06.09.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 12:29:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/7] xdiff: rename XDL_MERGE_STYLE_DIFF3
Date:   Wed,  9 Jun 2021 14:28:40 -0500
Message-Id: <20210609192842.696646-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210609192842.696646-1-felipe.contreras@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we don't specify we are talking about a style, XDL_MERGE_MINIMAL
could be confused with a valid value instead of XDL_MERGE_DIFF3, which
it isn't.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge-file.c | 2 +-
 xdiff-interface.c    | 2 +-
 xdiff/xdiff.h        | 2 +-
 xdiff/xmerge.c       | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 06a2f90c48..a4097a596f 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -33,7 +33,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	struct option options[] = {
 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
-		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_DIFF3),
+		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_STYLE_DIFF3),
 		OPT_SET_INT(0, "ours", &xmp.favor, N_("for conflicts, use our version"),
 			    XDL_MERGE_FAVOR_OURS),
 		OPT_SET_INT(0, "theirs", &xmp.favor, N_("for conflicts, use their version"),
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 609615db2c..64e2c4e301 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -307,7 +307,7 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 		if (!value)
 			die("'%s' is not a boolean", var);
 		if (!strcmp(value, "diff3"))
-			git_xmerge_style = XDL_MERGE_DIFF3;
+			git_xmerge_style = XDL_MERGE_STYLE_DIFF3;
 		else if (!strcmp(value, "merge"))
 			git_xmerge_style = 0;
 		/*
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 7a04605146..45883f5eb3 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -64,7 +64,7 @@ extern "C" {
 #define XDL_MERGE_FAVOR_UNION 3
 
 /* merge output styles */
-#define XDL_MERGE_DIFF3 1
+#define XDL_MERGE_STYLE_DIFF3 1
 
 typedef struct s_mmfile {
 	char *ptr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1659edb453..f6916a4ba4 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -230,7 +230,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 	size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, 1,
 			      dest ? dest + size : NULL);
 
-	if (style == XDL_MERGE_DIFF3) {
+	if (style == XDL_MERGE_STYLE_DIFF3) {
 		/* Shared preimage */
 		if (!dest) {
 			size += marker_size + 1 + needs_cr + marker3_size;
@@ -482,7 +482,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	int style = xmp->style;
 	int favor = xmp->favor;
 
-	if (style == XDL_MERGE_DIFF3) {
+	if (style == XDL_MERGE_STYLE_DIFF3) {
 		/*
 		 * "diff3 -m" output does not make sense for anything
 		 * more aggressive than XDL_MERGE_EAGER.
-- 
2.32.0.2.g41be0a4e50

