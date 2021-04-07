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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381C1C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15AF36121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDGW4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhDGW4f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:56:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E311C061761
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 15:56:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n8so756610lfh.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 15:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yeb4z2Gh+0XMtgEW0OXcqKq8tQUnuhNarRigoMl7YzA=;
        b=Jb336jeNUzkbiHdSYFrEzDUXSs/TYn+7hB3CyGqgyL6O+eZ5jx9UeOSkBGD7uem/lQ
         7mMHXTZd9aBMpxq0nFF9LFoyFU9p3Wb2r7oZ9m2d3FEYY6yUQeA2qgA5ItPY/cKljvaj
         vMiNgEAGpaK59+RA58ISj/O74N5NxTvl56SYx6syu4l8v9V1N6kYV+2U0DfWwJUoGofN
         0wrWpbsh344vDM9Ym0icCSM1CkZt4irGPUPNBAzxVCzPjkhKP/cxqpShAPAdnW4dijKS
         2E0U8AhqC4BWbfkFLZEn7TIQqvIPimp82NucF7+DmQWKN1+ZbgiFWm10RvErhikeQhYj
         8Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yeb4z2Gh+0XMtgEW0OXcqKq8tQUnuhNarRigoMl7YzA=;
        b=T5MZvWi3k34BMMWHuGA9CajMP1ogAzcN7mKuRlm1xugxd8eoSxLFUjvctkAkAtKMBW
         ACq1527XPveLt3GDK9nVy22VtkqkCajeHfZjbi4UyOTXNhLhZTd//b4uzlv7mvdxCYez
         2HVd7pYzzW3tHF3O20Fca0zA86ftSYkDqPBBtQBT6ClA8oz/p2XgokjWVbaQ0DlOqyp7
         yWl0knRNLTInf6wz3fBDiMepq/EZrMtXbAxjS/5LrlBMXq2thsdNSzUYqA7huxzhK2+f
         0RTPw/XrRzm/PxycLRnNU9Cc2EDBd4Wg5gtvtS6YwO9nd7vNji/EGA/FW1+IjhoG+qGI
         UMnQ==
X-Gm-Message-State: AOAM532Tonfp2zDXNWdEce0LTDAuTjaotChqVR25KdOJrVYpQCWH+CID
        pDHyo/KpAY0bY0DdGfPIrEM/6qfHBAo=
X-Google-Smtp-Source: ABdhPJyE26AjdPGY9UxjjurlR9WXk93Sm+sRWO7RfOCSqXqHBLTdbGX/jWjb84pSUson2rbVfUZ+qw==
X-Received: by 2002:ac2:46d5:: with SMTP id p21mr4276007lfo.295.1617836183877;
        Wed, 07 Apr 2021 15:56:23 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t25sm2580101ljo.102.2021.04.07.15.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:56:23 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 3/9] diff-merges: introduce log.diffMerges config variable
Date:   Thu,  8 Apr 2021 01:56:02 +0300
Message-Id: <20210407225608.14611-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407225608.14611-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New log.diffMerges configuration variable sets the format that
--diff-merges=def will be using. The default is "separate".

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 builtin/log.c |  2 ++
 diff-merges.c | 11 +++++++++++
 diff-merges.h |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 8acd285dafd8..6102893fccb9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -481,6 +481,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 			decoration_style = 0; /* maybe warn? */
 		return 0;
 	}
+	if (!strcmp(var, "log.diffmerges"))
+		return diff_merges_config(value);
 	if (!strcmp(var, "log.showroot")) {
 		default_show_root = git_config_bool(var, value);
 		return 0;
diff --git a/diff-merges.c b/diff-merges.c
index 93ede09fb36f..ca4d94a9039d 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -90,6 +90,17 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
  * Public functions. They are in the order they are called.
  */
 
+int diff_merges_config(const char *value)
+{
+	diff_merges_setup_func_t func = func_by_opt(value);
+
+	if (!func)
+		return -1;
+
+	set_to_default = func;
+	return 0;
+}
+
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 {
 	int argcount = 1;
diff --git a/diff-merges.h b/diff-merges.h
index 659467c99a4f..09d9a6c9a4fb 100644
--- a/diff-merges.h
+++ b/diff-merges.h
@@ -9,6 +9,8 @@
 
 struct rev_info;
 
+int diff_merges_config(const char *value);
+
 int diff_merges_parse_opts(struct rev_info *revs, const char **argv);
 
 void diff_merges_suppress(struct rev_info *revs);
-- 
2.25.1

