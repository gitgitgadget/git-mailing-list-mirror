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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335B4C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20109613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhGEMfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhGEMfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:30 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC56C061762
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:53 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s17so20658107oij.0
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlSBBpeyaba2XyM+CDEBgPK8YEt+XD//eJWCQdAasCo=;
        b=HYl8DQNT1jiJif4Bn4zY7wh0bhgqr1iVA2V3i4MZ20vbEFdrxIgitemGDuhz5bYvX0
         uPSRbTJ0XkSq4SjIB7LIvMfKvTmVwrhDgoK0etDpT4QqNLjHzPBKa4aybUN/SP/ByvKo
         JONkZx+Gakrao2VYyHgHCChQct2r7Jnf6OIF5psZ0fOwwyCr7Np89yv617aXhf9JDorz
         vsyQ8hWjL4QWnY2rXUJBvz1z8bYzrdS7zhveaBvqwNZocninqCMut21CIsTQYxQaPGbf
         KBcgWBwY18PwzMxeIHtQbC82FYPM5NWLqyO1wQhvJPAT7Hm9QxmX4m7mUSyaBiVkOHk8
         7IqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlSBBpeyaba2XyM+CDEBgPK8YEt+XD//eJWCQdAasCo=;
        b=shcE2sy4bzSvOwE7JJcen67xQHT/bKIjdOCZSXWNfV0UdCOaPvpPogqFzOCnnGBtaF
         9OMQ1hZMyBvlng5QSxNok6eZA563kHgXhhap0KDToN5wFViDz6DgjKH0CFAroCh4KMyq
         dYRXfO4EOpB4/g7nJ8qnGXqfViv8qcSdq7C14/4PY7bYuOUYAUlIHy1OJ3drIWE/PYDl
         eoaK6MrtS8B57yBA7iTkOzHdmcd/phH42stQmTRb/nVE9Og+jcsQfk8CAiMOHDdOnDi3
         XccCg/0NjViNGit8nnjqZd+n8FCHst4WQeyl1gaq4Wfj81SYHDoUJhuZjowAhPDIL8jA
         RVNA==
X-Gm-Message-State: AOAM530ivF61XF+YpTkGhR7wuAaStpUaCuX6+/Vf8wYRulG2EQXNApYs
        svkFTbU8cwrPHiWPzOs0PrtZ8JZlvG5+/A==
X-Google-Smtp-Source: ABdhPJz/gE0i00dvmn50CX6WBN7V0kjvUVASIbm4+e3FxkdK9RQiSgYHX0VBEVhNLSvoiUJA1moSqQ==
X-Received: by 2002:aca:618a:: with SMTP id v132mr10070031oib.144.1625488372536;
        Mon, 05 Jul 2021 05:32:52 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l7sm2619325otn.80.2021.07.05.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 24/35] pull: move configuration fetches
Date:   Mon,  5 Jul 2021 07:31:58 -0500
Message-Id: <20210705123209.1808663-25-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have REBASE_DEFAULT we can fetch the configuration before
parsing the argument options.

The options will override the configuration, and if they don't;
opt_rebase will remain being REBASE_DEFAULT.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 94fc8b0739..61af8ea2cb 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -949,6 +949,9 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	struct object_id rebase_fork_point;
 	int can_ff;
 
+	opt_ff = xstrdup_or_null(config_get_ff());
+	opt_rebase = config_get_rebase();
+
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
 
@@ -965,12 +968,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff)
-		opt_ff = xstrdup_or_null(config_get_ff());
-
-	if (!opt_rebase)
-		opt_rebase = config_get_rebase();
-
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
-- 
2.32.0.36.g70aac2b1aa

