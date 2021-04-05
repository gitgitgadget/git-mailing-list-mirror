Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55691C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0122C613DA
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 22:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhDEWTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 18:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbhDEWTO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 18:19:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B01DC061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 15:19:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p12so4974953pgj.10
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLlEPpB+pcEnhr4BXZrEn6fE5p+6CIcYg3YMusJDrKs=;
        b=rclsTLnfzGwQ4jk/a6uZqR2s2bePUI1luze+DyAFOrFGguwCqKLDdxJC0vI/ar7HJN
         FfA//eZ30QQUlAVEDXTLh6fzxwuTDc/uY9rZZWGbwHZHqQexCgvdIVSIqQXQxdRW+YQV
         7O/bKs1DFHSZUqcYSvxP5qUTCZV3TKAsZQachkkC1FDJYBoMgtx/M/jujzYxha5FMaJl
         gfSGs7e49g56fb4HXg8ukcr1HZ+vZRol+cD26UORS4JxxMVOHpE57JSeFibocRtNbceQ
         X4k4WJgOwwzi0gHOnH3FRj0F0uQ6E7Ia/5OqfeGaBZyGvayGEMnEiCx4JV7PSCna5I0S
         +z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLlEPpB+pcEnhr4BXZrEn6fE5p+6CIcYg3YMusJDrKs=;
        b=ieAvYwCyKlZ4+q6mS1Ls0eYzcSma4eJabJpCMUH+Pz/pTzDsHvW7V4lS7EHSVFQFfs
         cGEUd+YSK62L5CZUPAy0LYIExJOncdVhQ4yl2+PBUnOryR1eOa4pGeUuOijU34s3q4a3
         pKaCRAqzgfzqywNHT8OBS+JJVin7Zk0PW+mAJMRBdRUA5nJM0f6WgsWYxEnoa9ZcIQUr
         thA/a+dyF8+hG/9p55beR7LjDCzsly8qjo9Cy5Zs+I0qGuqK4yUbLd4csgEr7BNHAvUT
         IMjxlIzoc++nyd+vsWwJcwxAxOHUtx8WTC5q3mRf2clcqWNC09ERI25DxGUoXSvdDbwX
         CqIg==
X-Gm-Message-State: AOAM532h+v8KNqbkBedXHjR0csiYSDYLlpIeIvYpImh1ffTLR63xqf61
        TbjweyqaVTOaG4nFLcPsQ+nWStO5BmIiVZH5
X-Google-Smtp-Source: ABdhPJwKy2WeqJitx2HFkdIQEMPTycmnQzET9xFBUZ1o10uuKDtauPWF8jjXUfHK1/tN3SqO3ba9Dg==
X-Received: by 2002:aa7:9299:0:b029:21d:7ad1:2320 with SMTP id j25-20020aa792990000b029021d7ad12320mr25414344pfa.22.1617661145726;
        Mon, 05 Apr 2021 15:19:05 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id x25sm17044785pfn.81.2021.04.05.15.19.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Apr 2021 15:19:05 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>
Subject: [PATCH V2] git-apply: Allow simultaneous --cached and --3way options
Date:   Mon,  5 Apr 2021 15:19:02 -0700
Message-Id: <20210405221902.27998-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.164.g61adc3a729
In-Reply-To: <20210403013410.32064-2-jerry@skydio.com>
References: <20210403013410.32064-2-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, --cached and --3way were not
allowed to be used together, since --3way
wrote conflict markers into the working tree.

These changes change semantics so that if
these flags are given together and there is
a conflict, the conflicting objects are left
at a higher order in the cache, and the command
will return non-zero. If there is no conflict,
the patch is applied directly to cache as
expected and the command will return 0.

The user can use `git diff` to view the contents
of the conflict, or `git checkout -m -- .` to
regenerate the conflict markers in the working
directory.

With the combined --3way and --cached flags,
The conflict markers won't be written to the
working directory, so there is no point in
attempting rerere.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
Signed-off-by: Jerry Zhang <jerryxzha@googlemail.com>
---
 Documentation/git-apply.txt | 3 ++-
 apply.c                     | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 91d9a8601c..392882d9a5 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -89,7 +89,8 @@ OPTIONS
 	and we have those blobs available locally, possibly leaving the
 	conflict markers in the files in the working tree for the user to
 	resolve.  This option implies the `--index` option, and is incompatible
-	with the `--reject` and the `--cached` options.
+	with the `--reject` option. When used with the --cached option, any conflicts
+    are left at higher stages in the cache.
 
 --build-fake-ancestor=<file>::
 	Newer 'git diff' output has embedded 'index information'
diff --git a/apply.c b/apply.c
index 6695a931e9..e59c77a1b7 100644
--- a/apply.c
+++ b/apply.c
@@ -133,8 +133,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
 
 	if (state->apply_with_reject && state->threeway)
 		return error(_("--reject and --3way cannot be used together."));
-	if (state->cached && state->threeway)
-		return error(_("--cached and --3way cannot be used together."));
 	if (state->threeway) {
 		if (is_not_gitdir)
 			return error(_("--3way outside a repository"));
@@ -4646,7 +4644,8 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		}
 		string_list_clear(&cpath, 0);
 
-		repo_rerere(state->repo, 0);
+		if (!state->cached)
+			repo_rerere(state->repo, 0);
 	}
 
 	return errs;
-- 
2.29.0

