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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3576DC4332F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11606610FF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244992AbhIGMBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhIGMBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEFAC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 04:59:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f129so9710678pgc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 04:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXSL82aCOfWFDo8QlCHs4cmaqZAKDIm4P2Zs9Y2HLJw=;
        b=DqMYedQT8IbbLBaGTJBdh9uP+gpER3Z5wCaljgpUWM67HFG3Nd9/r1QNtgqrSFgqAo
         KLHN1KmczVN1+QFPJU4/GL5zWG1cD8mQeIBd/yIac2YX3doKuQdP+bP0SzCQK3rxJ3K+
         c1821SAl7h7dvuVDjGwXDlDOCW+MFSMLFuQ9ep2YNtz8bH0+MxMdC6UqUC4Xt7/u3j15
         HmNWxw/Qou91qAkn1fudwiyQfH+XcJbwr1C7xONQaCozTAtU/GsLZb5q7Mor6PUJ0yf/
         UfGTs4GvHM9uFRAVKCNf26Syu9udm6IGiRvAmoVZRak+swXYKPmnoBXemzpBwHxsTN2u
         DpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXSL82aCOfWFDo8QlCHs4cmaqZAKDIm4P2Zs9Y2HLJw=;
        b=Qtxyqftu2Be3rUS9q8ucpOMmjg4eNP9XEsUhRnCVIsagK+3q28IB4MwGpYqB2EMX3l
         Vnc9qE7IZtHpivTYDrht7JQ/2sQ7VNvTLJ4/JSk0NLianVMENF6OMSKFOtwYxQehIU/K
         vmDXBI74e+BST2IpfTrH0noqhsH5/0McuFQ9CS3PqS+VtsIhV5wFStuPDL/iC3GamPQg
         l1LSo/uwXIhN/ojO4Xo4GxiO5P4GrvfLA0K0enMwPZfAFgXORtWI7uBU/ouUjacrUmoa
         XgVX9A2E3HY6nQEa1a42nrfeF5lRNePayFNVLp247sSCoNoSnifnjx6sY6ZQGaj3HpR9
         vMpg==
X-Gm-Message-State: AOAM531/VhHLIv+GEf0rYj7uQHTynW94z2LF0i8TDz3LhvJbHJdqEVZb
        3t/SkWK+XjjPZYGMf4upab6/63NQNIU=
X-Google-Smtp-Source: ABdhPJy8FFJ0+pVQ20V9dqd2WHTlFWedjihxJaOWV+Ponu+jMgj8HlRAj5M/9VutGrxqMhnYXNxLTQ==
X-Received: by 2002:a63:6d09:: with SMTP id i9mr16506344pgc.480.1631015998695;
        Tue, 07 Sep 2021 04:59:58 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.04.59.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 04:59:58 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 02/13] submodule--helper: get remote names from any repository
Date:   Tue,  7 Sep 2021 17:29:21 +0530
Message-Id: <20210907115932.36068-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`get_default_remote()` retrieves the name of a remote by resolving the
refs from of the current repository's ref store.

Thus in order to use it for retrieving the remote name of a submodule,
we have to start a new subprocess which runs from the submodule
directory.

Let's instead introduce a function called `repo_get_default_remote()`
which takes any repository object and retrieves the remote accordingly.

`get_default_remote()` is then defined as a call to
`repo_get_default_remote()` with 'the_repository' passed to it.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 97512ccf0b..1a65de4fa4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -29,11 +29,10 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static char *get_default_remote(void)
+static char *repo_get_default_remote(struct repository *repo, const char *refname)
 {
 	char *dest = NULL, *ret;
 	struct strbuf sb = STRBUF_INIT;
-	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -46,7 +45,7 @@ static char *get_default_remote(void)
 		die(_("Expecting a full ref name, got %s"), refname);
 
 	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
+	if (repo_config_get_string(repo, sb.buf, &dest))
 		ret = xstrdup("origin");
 	else
 		ret = dest;
@@ -55,6 +54,12 @@ static char *get_default_remote(void)
 	return ret;
 }
 
+static char *get_default_remote(void)
+{
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	return repo_get_default_remote(the_repository, refname);
+}
+
 static int print_default_remote(int argc, const char **argv, const char *prefix)
 {
 	char *remote;
-- 
2.32.0

