Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1049C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjBGSSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjBGSRs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:48 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BB33FF18
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:17:27 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p15-20020a170902a40f00b00192b2bbb7f8so8534031plq.14
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UGKOv7lTtPMgeVgfzyGwAjJPuXhc/OIK+sP+8kf5fMw=;
        b=isfw44oQ6V9MiymwI3aX6sowOFoRuP+jyVkQji2I4P7ZX6J1rrMVnt8hfkzTTxrIGa
         bgWg6EJfj2CTg2jiPTwmW0jnoAbsBkT++/8l/PlRDkUhlDOcrjolUXEcseH0WOQfzL/l
         Ksnn6fU1eIHStZFHEWL4kDqJaG1lYpa2yUUMW/5gs1GC0eI+JMUSn3Ewuw25LJ/sEksg
         SSMkcJATH4RCxGuH8Yaf1cu2AtPH27HIaKbqBJWfgai12jJvq0p6Z6YetuxXT5eftjf3
         RK66sLDuoUl4S5LBoK4U7T+UFITzCxgCTqIEFvLdZ05inVHWM6rJvlVSk0J/XlJI3K0R
         onSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGKOv7lTtPMgeVgfzyGwAjJPuXhc/OIK+sP+8kf5fMw=;
        b=h3PA23vQpVUxTDd46lmxu1wej+gF/69+5iStpXw4qKZFaw9Kb25ufGtWyskq7wrf1k
         8riKqoKGdwZ/HEmqhOWcUdued5IjTFZSP7M6hhsgDTewvFPJycakmIdDhVslPhKZlVDB
         diTTB5GW1Pex4I8ZLLd+BBWJa3qHy6m+wPus5gu7oRwlfDM/fBzpJOBYSTvLrzy+Id3k
         MuZO+05GdWaQ/9RZOsXA6f7xo8bMHN0nLUxFJijE2JdGhYCHekyme6OnGJLDOsBoG1oX
         UeiFI5m3CA/jM7h9OfcbkfZ7ThCrc4/MgLE6jcMiQAn5Ky0TJojh629Ga95gQ1P93qIh
         FMcg==
X-Gm-Message-State: AO0yUKX+ReoHLZs0NiDRS4PTxmvqejCeGXInfMK1jtuy2ys+8yw+xUox
        bz5DM29eW3vR/E76Zh9aONgfdfinft/nxm7YJkA9JTyUbQifxtbSmGg1VOhuhBwsJ8jVgqzoa6G
        ZbmiNg5oWWihmEKIv9NSB9lC0QfWlYdKh4ue0QT2Cak5LGdsMhw2OrzExNw1b1UEHvg==
X-Google-Smtp-Source: AK7set9tQYBVk1sh84lpoqvzWCF8seOVHBm6/RVPRmLKBMKHVpWl7rXGOj1FrwECdEOnsksPXofzTYO2QFsWrGs=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:234e:b0:196:8445:56d5 with SMTP
 id c14-20020a170903234e00b00196844556d5mr1048546plh.13.1675793845478; Tue, 07
 Feb 2023 10:17:25 -0800 (PST)
Date:   Tue,  7 Feb 2023 18:17:05 +0000
In-Reply-To: <20230117193041.708692-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207181706.363453-7-calvinwan@google.com>
Subject: [PATCH v7 6/7] diff-lib: refactor match_stat_with_submodule
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com
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
index 7101cfda3f..e18c886a80 100644
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
2.39.1.519.gcb327c4b5f-goog

