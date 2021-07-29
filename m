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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8695AC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6111B6103A
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 03:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhG2D6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhG2D6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 23:58:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1249CC0613C1
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so5033321wrr.2
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 20:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bPoGvgzNHnwIoYKZFwK9gY3Qw9uYbqiv4AXiUcoo0q4=;
        b=ahOXiYeC1YdYL2eFsuRLmZUoBEfEM5utBJ3i6bfOoZSydAn7BxRUoyWW4/8ypv3iB4
         jA2g61k4JMp4pKI0510zTjYGPrsltXHNMuRfIU7RIXr7KU21CTKjG1dycu8r0rBjjg2v
         YnMUOtwGwr+BZK0RUUol5XWzaN26zYLr27INTC7DfC9UihluElCecqIBUoUeQPI2r+qV
         8dbd/II8X60b9Ki9UCC6KxLDLN7LASpZCkPyspskc7rWjcYAD5CXAiy54/FLzaCT7Wez
         YBewXHk+bvGxtyNwO/+IiCwRGh9Y/yNhnpuySU0u7KmS25nRd4AEifjFDVZMcPH4iKYf
         4/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bPoGvgzNHnwIoYKZFwK9gY3Qw9uYbqiv4AXiUcoo0q4=;
        b=XuwpBqk/WooUe4W425Z2O4aQ17S6c59bcnPm9Nq0uIo/SP9eJdw+jaEE/ByBio9UZI
         gj90ghf4HP0xHm6CsAmSCeqtsopvQ1sPYlfNSvqDD/kskAIPbwW+Cd2WbqM3LByVvpj7
         JgrbiUx02/4c4thUx5aMwodBb/IBup4eAXRlrOtAt3gxGcMtsLtpMlFzSWK8TZFw9+lQ
         TZgLsBIcPgdUSFNZ/xLxGBOEfO09XLCK2R6FZ2U5867lRc+UGlmDs+VgB5h2WI8zmZBZ
         cvW3Fg54Q4tkQ2cWuWpoWEShxct6Rqn9w+d0YMBjIJDi6vywPMxvi1vG7iXW+XeF0eiG
         2+2g==
X-Gm-Message-State: AOAM530bbOFAQURNu0vRDQGkc+BYA6EZVYAeHkN/Kp5yNy+NSlRAkpGn
        WJT2GLmqtbQ413UaBPaMwtQ8OkOpwqE=
X-Google-Smtp-Source: ABdhPJxCHev6cu8YROeCDqp0q1BvoIxe8LYQPkZpwgfQ/ome/hTaipZT6bpOTnPZJ6j/PUIHMwhrVg==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr2378447wrr.64.1627531123740;
        Wed, 28 Jul 2021 20:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm1714665wrs.8.2021.07.28.20.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:58:43 -0700 (PDT)
Message-Id: <fdfc2b93ba4b8b0c8c6c51a28c07932ec8f7f59a.1627531121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
        <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 03:58:36 +0000
Subject: [PATCH v2 2/7] merge-ort: add pool_alloc, pool_calloc, and
 pool_strndup wrappers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We need functions which will either call
    xmalloc, xcalloc, xstrndup
or
    mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
depending on whether we have a non-NULL memory pool.  Add these
functions; a subsequent commit will make use of these.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index e361443087a..39ddc9b9f2f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -664,6 +664,30 @@ static void path_msg(struct merge_options *opt,
 	strbuf_addch(sb, '\n');
 }
 
+MAYBE_UNUSED
+static void *pool_calloc(struct mem_pool *pool, size_t count, size_t size)
+{
+	if (!pool)
+		return xcalloc(count, size);
+	return mem_pool_calloc(pool, count, size);
+}
+
+MAYBE_UNUSED
+static void *pool_alloc(struct mem_pool *pool, size_t size)
+{
+	if (!pool)
+		return xmalloc(size);
+	return mem_pool_alloc(pool, size);
+}
+
+MAYBE_UNUSED
+static void *pool_strndup(struct mem_pool *pool, const char *str, size_t len)
+{
+	if (!pool)
+		return xstrndup(str, len);
+	return mem_pool_strndup(pool, str, len);
+}
+
 /* add a string to a strbuf, but converting "/" to "_" */
 static void add_flattened_path(struct strbuf *out, const char *s)
 {
-- 
gitgitgadget

