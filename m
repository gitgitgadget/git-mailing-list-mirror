Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29297C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DA02072F
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 06:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECgJXNKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFKG7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 02:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgFKG7l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 02:59:41 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682BAC08C5C3
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so4919794wrw.8
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xROFT2e5aVDwZO7Wu0WjJ07qYlY5Khd4BZpkxVRpZHw=;
        b=ECgJXNKV96f7bn+4x/8g+y49gvwQqtWQ8VAuOW5MfxgQI+UylS2kuC+pUMRogA1nQb
         hMrQXCViuIAD7IyB54DWTfaCWpbsC0GS1m/dT5ST03xxsqoaygR9DBujOkLf6sXqpF/W
         qtWJ3FYcVfKnNI9/Krba1vLEiU8vH4vw5q26sZSQI1ldj0VDD1buxvqbmXMspne/MePi
         ICiEskMphQAGTprp3Q/YWrRG8HYQRZCsJUn0l13vsxbxeCV+n1RT/meyjB13cPupqX59
         eWn1kSleg1rX7gxTZXom+NPUYwrmLmgPNa6fD+y5zvhCySiim6RN65vNlD4/N82sTqXl
         keJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xROFT2e5aVDwZO7Wu0WjJ07qYlY5Khd4BZpkxVRpZHw=;
        b=Ar8n3r9gkfrMDVPyURl7dkoIucaeOMaYPrQWFKES2lTTy6UOEhSsf9PmBKTigMksTx
         OL8j/mBU1lRJV+egJ2k838ArQgKcSy2ZXUMqwBb/EAs9HvIFh4rMN187tXtxvqFU5EOJ
         Ub1PCnK2h2Jt6Z/eaNPQhz2HQ2H9h2joNVe770PBaxb+dh/QBeszPJyQMlK2AucNMPIj
         v7xtenuQ0Cph8JfBiS45f5n98Ni/bZGppu/2NlYnU4vzHKXRa5Cc2TIPDKW3OrEtUyT5
         G44bVU490S2DU9832JWNnXYQ/BxOwRmri5ft7mdmApmVWRsSy0ejp3yv6k3/ROFZANi+
         ovAw==
X-Gm-Message-State: AOAM531H5Ka3Nlqswj9Bz9IhiegBFOnUdzB3h1WNqkWSJrYRohgf3t2P
        BDuLgNeE0UsKPf3/l+undU30SSNO
X-Google-Smtp-Source: ABdhPJwlR4TYZVwELeSs5ZIrymGdHVd+e3KlQZiwGvPc0Pr2dFdJTQ2SPcVlK4/cFWYIvTdJUpJURA==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr8248481wrn.16.1591858778910;
        Wed, 10 Jun 2020 23:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y25sm8664238wmi.2.2020.06.10.23.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 23:59:38 -0700 (PDT)
Message-Id: <b4cb448e8d76ae16f6fa38a773244bb4a8499938.1591858774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
References: <pull.806.git.git.1591858774.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 06:59:33 +0000
Subject: [PATCH 4/4] clean: optimize and document cases where we recurse into
 subdirectories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     bmalehorn@gmail.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 6b1db43109 ("clean: teach clean -d to preserve ignored paths",
2017-05-23) added the following code block (among others) to git-clean:
    if (remove_directories)
        dir.flags |= DIR_SHOW_IGNORED_TOO | DIR_KEEP_UNTRACKED_CONTENTS;
The reason for these flags is well documented in the commit message, but
isn't obvious just from looking at the code.  Add some explanations to
the code to make it clearer.

Further, it appears git-2.26 did not correctly handle this combination
of flags from git-clean.  With both these flags and without
DIR_SHOW_IGNORED_TOO_MODE_MATCHING set, git is supposed to recurse into
all untracked AND ignored directories.  git-2.26.0 clearly was not doing
that.  I don't know the full reasons for that or whether git < 2.27.0
had additional unknown bugs because of that misbehavior, because I don't
feel it's worth digging into.  As per the huge changes and craziness
documented in commit 8d92fb2927 ("dir: replace exponential algorithm
with a linear one", 2020-04-01), the old algorithm was a mess and was
thrown out.  What I can say is that git-2.27.0 correctly recurses into
untracked AND ignored directories with that combination.

However, in clean's case we don't need to recurse into ignored
directories; that is just a waste of time.  Thus, when git-2.27.0
started correctly handling those flags, we got a performance regression
report.  Rather than relying on other bugs in fill_directory()'s former
logic to provide the behavior of skipping ignored directories, make use
of the DIR_SHOW_IGNORED_TOO_MODE_MATCHING value specifically added in
commit eec0f7f2b7 ("status: add option to show ignored files
differently", 2017-10-30) for this purpose.

Reported-by: Brian Malehorn <bmalehorn@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 1be437bd5a3..5a9c29a558b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -955,8 +955,37 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		remove_directories = 1;
 	}
 
-	if (remove_directories && !ignored_only)
-		dir.flags |= DIR_SHOW_IGNORED_TOO | DIR_KEEP_UNTRACKED_CONTENTS;
+	if (remove_directories && !ignored_only) {
+		/*
+		 * We need to know about ignored files too:
+		 *
+		 * If (ignored), then we will delete ignored files as well.
+		 *
+		 * If (!ignored), then even though we not are doing
+		 * anything with ignored files, we need to know about them
+		 * so that we can avoid deleting a directory of untracked
+		 * files that also contains an ignored file within it.
+		 *
+		 * For the (!ignored) case, since we only need to avoid
+		 * deleting ignored files, we can set
+		 * DIR_SHOW_IGNORED_TOO_MODE_MATCHING in order to avoid
+		 * recursing into a directory which is itself ignored.
+		 */
+		dir.flags |= DIR_SHOW_IGNORED_TOO;
+		if (!ignored)
+			dir.flags |= DIR_SHOW_IGNORED_TOO_MODE_MATCHING;
+
+		/*
+		 * Let the fill_directory() machinery know that we aren't
+		 * just recursing to collect the ignored files; we want all
+		 * the untracked ones so that we can delete them.  (Note:
+		 * we could also set DIR_KEEP_UNTRACKED_CONTENTS when
+		 * ignored_only is true, since DIR_KEEP_UNTRACKED_CONTENTS
+		 * only has effect in combination with DIR_SHOW_IGNORED_TOO.  It makes
+		 * the code clearer to exclude it, though.
+		 */
+		dir.flags |= DIR_KEEP_UNTRACKED_CONTENTS;
+	}
 
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
-- 
gitgitgadget
