Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BBFC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjAQVG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjAQVFR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:05:17 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28884743A
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:26 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id fy20-20020a17090b021400b00226f0026263so12968382pjb.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUdisve4gZWbsO7A2yUrvfD/yW1XxoGAj1HL6Sg3nEw=;
        b=O4MbBtgL1aSQEUd2CD1k44siqGq/db7mEB1Ail8I2Dldr3pS1n0Rh/QVeohMEYnHkv
         zwFHUks0R0MqtCn7qIsi890BfDI6fjhzwCHWVIu4gu1gQL3juHaVN/B9PSyfwTasfUvK
         bjkfH/O6ReSZqi/i/3QmLWxwjmBPr3M+JsBB0AJhZWiVBVXg635tzp8Tr/UDjY+cpgzQ
         R2Rna57Ah49aONBTANLaSdL2yyhLDL8Zt4tGzSXVjINj5+AutJmuHQ9uP3QsRvgyVc7n
         N/Q3mjHoV2ob9RDSjWZU+dug7+uOnRW66t13j6jTbrywRIuwBZzSu8uU4/uhXQk5r3uh
         IU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUdisve4gZWbsO7A2yUrvfD/yW1XxoGAj1HL6Sg3nEw=;
        b=xmEMfahF3HerDQ3WFR5sXkCFYopBGkfFRzGS6fwHNrDww5nluaskRXOuJnSBOm06+M
         Hj7Hlco8dh7x7tVpX0FYejmW0iiara1jKZNACCW0JOejd+Nyo2FflWx4KRvmxUEDbZcj
         OVUUqFOLBPimgOTWrkGCt5aZ4k/6OTebV6zdIZOtBzmxGgKKcFbpFHODUKYrwAQvXg9V
         /v6FdrVrbmKf1fRC5kNK8irlfEU9pFSNqiLgPjbjZtOGURWhPN/L9S0oxlzPvjvnQs1B
         UlKJre+NYHU6oy+zKnYlWAuQU15C0BwCC3CvXgFgChh9benfvFdnjc5t8wOfw9Ev5kcc
         ovxw==
X-Gm-Message-State: AFqh2kqhtDoFrDPBURTQlmGKMlNUZ1I0NbDZ6Lzc6HsAyy+0h2GmvcXg
        sX8sAxwhEP1NdjUfQR9JfIHC6hPJotA+g9m/Q5e1F4GOnB3hamsKtZZbAWLgQLj/xaUv25ur6KV
        0Q0WOG0HxbbLZZNjBqZ+VEYzBCmsFdVkg3+LWQTP2vISa1K8vpsGtKantaAVHclN/0w==
X-Google-Smtp-Source: AMrXdXsoRVR7Eqq/bcT/8K1QWFrSFIb5S/id/9V7oZTS82HkrbZee/uizKji4O/iHzOPJq3QA2E1qo1e8NQBLRQ=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:2a4a:b0:220:1f03:129b with SMTP
 id d10-20020a17090a2a4a00b002201f03129bmr387149pjg.0.1673983884969; Tue, 17
 Jan 2023 11:31:24 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:30:39 +0000
In-Reply-To: <20230104215415.1083526-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230117193041.708692-5-calvinwan@google.com>
Subject: [PATCH v6 4/6] diff-lib: refactor match_stat_with_submodule
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Flatten out the if statements in match_stat_with_submodule so the
logic is more readable and easier for future patches to add to.
orig_flags didn't need to be set if the cache entry wasn't a
GITLINK so defer setting it.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 diff-lib.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index dec040c366..64583fded0 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,18 +73,24 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 				     unsigned *dirty_submodule)
 {
 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
-	if (S_ISGITLINK(ce->ce_mode)) {
-		struct diff_flags orig_flags = diffopt->flags;
-		if (!diffopt->flags.override_submodule_config)
-			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (diffopt->flags.ignore_submodules)
-			changed = 0;
-		else if (!diffopt->flags.ignore_dirty_submodules &&
-			 (!changed || diffopt->flags.dirty_submodules))
-			*dirty_submodule = is_submodule_modified(ce->name,
-								 diffopt->flags.ignore_untracked_in_submodules);
-		diffopt->flags = orig_flags;
+	struct diff_flags orig_flags;
+
+	if (!S_ISGITLINK(ce->ce_mode))
+		return changed;
+
+	orig_flags = diffopt->flags;
+	if (!diffopt->flags.override_submodule_config)
+		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
+	if (diffopt->flags.ignore_submodules) {
+		changed = 0;
+		goto cleanup;
 	}
+	if (!diffopt->flags.ignore_dirty_submodules &&
+	    (!changed || diffopt->flags.dirty_submodules))
+		*dirty_submodule = is_submodule_modified(ce->name,
+					 diffopt->flags.ignore_untracked_in_submodules);
+cleanup:
+	diffopt->flags = orig_flags;
 	return changed;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

