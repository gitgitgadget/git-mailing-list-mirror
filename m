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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D5C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27958610FF
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245759AbhHFMC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHFMC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:02:28 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB2AC061798
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:02:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so22469223pjs.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FUGNEGv5b7iiJ5jGiHKZnJPiC1v9derrDbJFJLo+EPU=;
        b=C/2WsDJJQHd/F24q3HqtbGljfat5jHNDZgeZWFt+SL39D6jzekUYaQysZNTaqqiova
         LueY/FmUlfif2cCGOq8aHnTuMq20VNew+MBN3HJmBtzpTWQLoJ36Bg80KSWktQ/9rQpJ
         vRQ6HEDQQXzve4BM/peRf93BKS5a6Vo6JJH651emlm78VafvmprRzoqcKZumbZ80NRXs
         cD6uQdbkZ06i7KALubP0ft/eYUeakWKE5ub/u36DDEG8RcdBqBUGZSw5NvOLSxzlSbZI
         /Ycy4yqEyt2zVCg7jwOFOBu9UYEtKHjaXx4ICl4P9g1b7JdcQXfWIIfK3x/t8BqnBt7K
         IrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUGNEGv5b7iiJ5jGiHKZnJPiC1v9derrDbJFJLo+EPU=;
        b=Rlcf3SiOkqd2cC6ZvnKpkB6gkbs3yenrDt1a6p5IDk+6LDy8+96SVR+WGX34kOgmJS
         U7oroLrNuPShdaRc294Vxcdldrp6N6vkNjPEGvR9+IaZtShzdRwt/PiMm2bzXEnW5kfY
         1cxgYpjJ2Cru+pbcAOjWclJIQmpT8/14niVJ2eP+zE50GavLIw/Bvrcc92WyxuRZr87v
         u0nrYdk8QB8Bn2JSJbm2YcqKpStoVp9ATPD0dS0plVADnAVrojjwa1CEkNL81Pt2GCTa
         7OCpJx6qgSFtt+UfDe+GN66ifb23Hr4vUx1GhHPVSimNp3C0yY/1+3jYMyhnFbWE8VLU
         md7Q==
X-Gm-Message-State: AOAM530FC6KTp5YEuNacx29LEF2iC1Vptktcl2HW/JnwD2WEbGWl9NLg
        wW+BacqfngwjMAQH1/OSTYA=
X-Google-Smtp-Source: ABdhPJxmD32BAwzARy+HEJnVG1FaPCJRH6fprODQ75CcF9OAuyDCCd2y8aiKYDsEkOhiQPh74Mrc9A==
X-Received: by 2002:a65:6287:: with SMTP id f7mr27740pgv.444.1628251332100;
        Fri, 06 Aug 2021 05:02:12 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z8sm10338162pfa.113.2021.08.06.05.02.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:02:11 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v3 1/8] submodule--helper: add options for compute_submodule_clone_url()
Date:   Fri,  6 Aug 2021 17:31:40 +0530
Message-Id: <20210806120147.73349-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806120147.73349-1-raykar.ath@gmail.com>
References: <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210806120147.73349-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's modify the interface to `compute_submodule_clone_url()` function
by adding two more arguments, so that we can reuse this in various parts
of `submodule--helper.c` that follow a common pattern, which is--read
the remote url configuration of the superproject and then call
`relative_url()`.

This function is nearly identical to `resolve_relative_url()`, the only
difference being the extra warning message. We can add a quiet flag to
it, to suppress that warning when not needed, and then refactor
`resolve_relative_url()` by using this function, something we will do in
the next patch.

Having this functionality factored out will be useful for converting the
rest of `submodule add` in subsequent patches.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6891480013..2d2d8ac637 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -590,7 +590,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static char *compute_submodule_clone_url(const char *rel_url)
+static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
 {
 	char *remoteurl, *relurl;
 	char *remote = get_default_remote();
@@ -598,10 +598,14 @@ static char *compute_submodule_clone_url(const char *rel_url)
 
 	strbuf_addf(&remotesb, "remote.%s.url", remote);
 	if (git_config_get_string(remotesb.buf, &remoteurl)) {
-		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
+		if (!quiet)
+			warning(_("could not look up configuration '%s'. "
+				  "Assuming this repository is its own "
+				  "authoritative upstream."),
+				remotesb.buf);
 		remoteurl = xgetcwd();
 	}
-	relurl = relative_url(remoteurl, rel_url, NULL);
+	relurl = relative_url(remoteurl, rel_url, up_path);
 
 	free(remote);
 	free(remoteurl);
@@ -660,7 +664,7 @@ static void init_submodule(const char *path, const char *prefix,
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
 			char *oldurl = url;
-			url = compute_submodule_clone_url(oldurl);
+			url = compute_submodule_clone_url(oldurl, NULL, 0);
 			free(oldurl);
 		}
 
@@ -2134,7 +2138,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
 		if (starts_with_dot_slash(sub->url) ||
 		    starts_with_dot_dot_slash(sub->url)) {
-			url = compute_submodule_clone_url(sub->url);
+			url = compute_submodule_clone_url(sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
 			url = sub->url;
-- 
2.32.0

