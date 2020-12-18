Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E6C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A036C23A57
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 05:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgLRFwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 00:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgLRFwN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 00:52:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CD6C06138C
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id x22so1082581wmc.5
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 21:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wbFxwuR0mJ88lBfOYEZRwFLji0FcvED1IaVK6/E3Gjs=;
        b=q91GU3KtVtIsPBrszLW9l8P6DmjNXlVZbYe7ydGyhiEDANrhs2IuSvjGUiAzH4sYoi
         kgYm5FiHxWl7xw2TQeqnkkWAFqT/pstt8ePIDSXr4vQ0VKH5cyHPr1kNzYGecicE6UUe
         AboZF5ZxET9WLMpMxusInrhHtY9S6A9idj6PoN2L7cZjjqIYmySkxsFXCJ/Yo0GVx4sg
         BE14opsjC6SsVgAOjLC0291vcc+AdOPqFJdUJGNgVx4ThrmCMlLRb3ADMgn4jGAPVILO
         31lkCFEUY3b+b5C9+ZkyBvBy6JoW9ySaawYxB95f/D9PTpi0ZGTM7J1nmXJX0Krw/bIf
         ffAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wbFxwuR0mJ88lBfOYEZRwFLji0FcvED1IaVK6/E3Gjs=;
        b=ueqtbNYKWDfQ0zE+PGGVWogvJNVMb2yTQYPB7sP4GjFt7QWzS1A1/0tOkYZmEe1I4+
         17rgt592PXA+XxyBOG80S5jGNNZ3j8WWlkvpTuQJMecP/Y5ckkDtNGaA36UGRK6wytcU
         JjYw9PZfyyPjB6MjgtMpCI/SRqjjl0Gz8L1jX5BVShhOx27OTIqmfVpoxjYUIJQkDfK7
         cnar6HBWu9itW9fbtkYC/82R1K6bNVv9ZNX42PtxdFlKIdu8FdN84I700GWkcTFwbv1w
         ACFpfmiU+rEgG7zJxZ4WEXGq+VACE6QmsV1/CiNmAX8DPRx7OcwgfRz+IzY1Ca/j/cyc
         OC/g==
X-Gm-Message-State: AOAM530DthfrPtvTniEvn7JSfhLsskIvgucHxA9q19jMnUPvNT8p9L7W
        FZnZM/GFAblWqqykqC32JrNbSrRXhmI=
X-Google-Smtp-Source: ABdhPJzv/yQ6V+e8gtL2B9AApg9hlcbq7o7Rp8XadxZyqRkp1WuSVXqupaGD+tgPJ9+uj+oAcLCwZQ==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr2555370wmi.115.1608270691547;
        Thu, 17 Dec 2020 21:51:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm10916759wrw.75.2020.12.17.21.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 21:51:31 -0800 (PST)
Message-Id: <6ac555b3c0fe605fbbe6e304482c2e3aef321865.1608270687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.git.1608270687.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 18 Dec 2020 05:51:20 +0000
Subject: [PATCH 03/10] merge-ort: implement unique_path() helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement unique_path(), based on the one from merge-recursive.c.  It is
simplified, however, due to: (1) using strmaps, and (2) the fact that
merge-ort lets the checkout codepath handle possible collisions with the
working tree means that other code locations don't have to.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index d300a02810e..1adc27a11bc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -343,11 +343,34 @@ static void path_msg(struct merge_options *opt,
 	strbuf_addch(sb, '\n');
 }
 
+/* add a string to a strbuf, but converting "/" to "_" */
+static void add_flattened_path(struct strbuf *out, const char *s)
+{
+	size_t i = out->len;
+	strbuf_addstr(out, s);
+	for (; i < out->len; i++)
+		if (out->buf[i] == '/')
+			out->buf[i] = '_';
+}
+
 static char *unique_path(struct strmap *existing_paths,
 			 const char *path,
 			 const char *branch)
 {
-	die("Not yet implemented.");
+	struct strbuf newpath = STRBUF_INIT;
+	int suffix = 0;
+	size_t base_len;
+
+	strbuf_addf(&newpath, "%s~", path);
+	add_flattened_path(&newpath, branch);
+
+	base_len = newpath.len;
+	while (strmap_contains(existing_paths, newpath.buf)) {
+		strbuf_setlen(&newpath, base_len);
+		strbuf_addf(&newpath, "_%d", suffix++);
+	}
+
+	return strbuf_detach(&newpath, NULL);
 }
 
 /*** Function Grouping: functions related to collect_merge_info() ***/
-- 
gitgitgadget

