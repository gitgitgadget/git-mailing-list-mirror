Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07226C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKHSmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiKHSmY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:42:24 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051045985F
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:42:24 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l63-20020a639142000000b0046f5bbb7372so8314696pge.23
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NY3XPH0EpuzSaGwctQvhV14t2wGRIiH6gSU5FViSu9I=;
        b=ZolB8mRJBHzfB+y4w6Mm3kuak7qg3CrRz/XovYezAtY9+eYY/yqm6+7MNw1rDX5J9A
         gspskSaKBXGzK5i94AMycD4reBS5/dzeX6EqjCl+T+bpx+BgUUdLagW7FTtTBq62ansG
         9V7Omd1KmIQIaQvOncqFuBwb9IeXh7ZG/nkCELuBQzAs5IsUE9qvNct8mefZXsjXv3F7
         rjy+O/qd/fbJDr8KvsJXh/HVHMn7ZTd9vj4LaJWQC41WRP7J1+H8SIQqEeK8eIHuiCYc
         O2r3vC9Fkk84xCYF4NetnzRMgZiW29UcxJiY5DdqQMOLhyV41Ij7GH51JqFNuB0dnDBh
         dxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NY3XPH0EpuzSaGwctQvhV14t2wGRIiH6gSU5FViSu9I=;
        b=QdxIPSFEa4pLy8wzTQlEer3DRVRhnWpcSS3/vh7iN6bblWpjYlB2S/NSj+SLyFCPO0
         WJcWvMi3DyYT2kVBZPVOBciBCEEUXKXCjfBwikpmroWMHpFA6DPktAjIMIC73X6/f4/B
         Gu4tClHej59rhjFDsYqfdpo+EtNfmY1iFkc8pDSFQmB55RtQepgQQ+xbG1/HJ+30+h95
         cZsixXwFPQizXfWPHTO2rUMEmyEhR7D893VOG2YL2s+e/iSYbB9w/atZIZ2u53764CMi
         4jy9U8FT9rF+9CGZQAPAVVe59Tp/Tl22pFB0YtHdZZ4bpLAbQiOwzavixKoGsZa+jI0d
         YR5g==
X-Gm-Message-State: ACrzQf16kbTZUwlrSbyQJ1+hw0X3HE6X6fiV5/ddQrivXApwIFLs2M40
        Js6954FyMtwepoIAIjID60nK4X4CfQjrPj6uE/vkbzJ82iyzth52QZgUo5cehlHfbh490bK+7ec
        HrOpTLjmMVs2Si6FDj7HsDRFyhwrn+FHs/STyM/kKsklYYLVPhmSZEvoX+K7v3QFXaQ==
X-Google-Smtp-Source: AMsMyM7CQK3cU0j5r5pLFlApeRvetYJP7O33u8qZQ78vcgBqsQ5U8hafwmdnBxXJEMPqKkRhJZiJNkiiwJY74Xc=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a62:3281:0:b0:56d:385:149b with SMTP id
 y123-20020a623281000000b0056d0385149bmr57246455pfy.29.1667932943463; Tue, 08
 Nov 2022 10:42:23 -0800 (PST)
Date:   Tue,  8 Nov 2022 18:41:59 +0000
In-Reply-To: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108184200.2813458-5-calvinwan@google.com>
Subject: [PATCH v4 4/5] diff-lib: refactor match_stat_with_submodule
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, myriamanis@google.com
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
 diff-lib.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 2edea41a23..f5257c0c71 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -73,18 +73,25 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
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
+		goto ret;
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
+ret:
 	return changed;
 }
 
-- 
2.38.1.431.g37b22c650d-goog

