Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227AC43460
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C6561462
	for <git@archiver.kernel.org>; Sun,  2 May 2021 05:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhEBFQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 01:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhEBFQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 01:16:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147ABC06138B
        for <git@vger.kernel.org>; Sat,  1 May 2021 22:15:33 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v123so1582369ioe.10
        for <git@vger.kernel.org>; Sat, 01 May 2021 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drczb8hSseX7y98s7yfMjaqdMrqXYPEZ+xOYPE6IG80=;
        b=taEQNqUngICDCtMR3Ybbe33tMXVn5ad1GPV/rCJMdX7kWjF+3YySLlyJrnRl1ExrhI
         SNpRBkwFtl/5t5pAzRhZMcb97MGiRXK8SfCitKqURjGmdNoOIielRRu14Tl7dfpN3E5K
         9pUI7bH4EuatvxHYZZlBYlOk9n6KOFmT99p1GajoNyufPxhUCG7/RzO8E+ZSZnaks9eH
         p83OVuBfZ1nwEL0VwvuTzh+aHVjR1RUNB5FpN3TW4Qq2P10WcAAjnNjcjTXquymW4mxZ
         ywnm+UwWa0+JflM/4Zie8GMOIgJYRF1NwdycNVhm4HY/WgunJrpRk10uYytfqnnA74Dv
         yMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=drczb8hSseX7y98s7yfMjaqdMrqXYPEZ+xOYPE6IG80=;
        b=jNdqb/Cu1yHFkXfkjN7eV2141dEh7L/Hj7peZ3VWcnepi3mKoW0VGHs6riKWeCB6gP
         Acm/SxFxbOxcyD3f24I3pkMcADMH/z8DGqowIQ3HBs9LnfcvszvUoEs8QpQ8kLm3NKqa
         O6kQwmtEVNZ2icCdlPRFGRg4Gzfl1/je64fKXAkbcmKTeHSCNXre6gCnQ6NbBwROZREA
         xiuKNWYp6Ev+ZPPDf/fL3T4a1tF/kHtvwkcSjn00zeAkCcsNCgguuqxcdb/ZhyhS62wy
         cwZ/PKsN7Lsmlw+MDNNNGnpnTvaBjGYM7J+2oGGo2Qed7y9659/Y1vA51i7sjOmPozeJ
         6jvg==
X-Gm-Message-State: AOAM532vgdvlLmL7qLp3kC7ohGeOYNvzZMgFIuQdxsRTqMk0S3Azk0Gt
        VEhIm1TPkpbYLSApmY9CdOQ8a+D7iB263A==
X-Google-Smtp-Source: ABdhPJxoGWEfWM9amHlkJkL4IaQG6EN5Kf+nKz/s+KLVQUt5/4AyyzEuvYkBwYdkadi7R4jZZsU28A==
X-Received: by 2002:a05:6602:140c:: with SMTP id t12mr9297020iov.169.1619932532221;
        Sat, 01 May 2021 22:15:32 -0700 (PDT)
Received: from localhost.localdomain (097-070-162-226.res.spectrum.com. [97.70.162.226])
        by smtp.gmail.com with ESMTPSA id e12sm2134049ilu.75.2021.05.01.22.15.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 May 2021 22:15:31 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Josh Soref <jsoref@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 1/2] merge(s): apply consistent punctuation to "up to date" messages
Date:   Sun,  2 May 2021 01:14:22 -0400
Message-Id: <20210502051423.48123-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459
In-Reply-To: <20210502051423.48123-1-sunshine@sunshineco.com>
References: <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
 <20210502051423.48123-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although the various "Already up to date" messages resulting from merge
attempts share identical phrasing, they use a mix of punctuation ranging
from "." to "!" and even "Yeeah!", which leads to extra work for
translators. Ease the job of translators by settling upon "." as
punctuation for all such messages.

While at it, take advantage of printf_ln() to further ease the
translation task so translators need not worry about line termination,
and fix a case of missing line termination in the (unused)
merge_ort_nonrecursive() function.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/merge.c      | 2 +-
 merge-ort-wrappers.c | 2 +-
 merge-recursive.c    | 2 +-
 notes-merge.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 388619536a..3472a0ce3b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1610,7 +1610,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			}
 		}
 		if (up_to_date) {
-			finish_up_to_date(_("Already up to date. Yeeah!"));
+			finish_up_to_date(_("Already up to date."));
 			goto done;
 		}
 	}
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index 7eec25f93a..ad04106169 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -30,7 +30,7 @@ int merge_ort_nonrecursive(struct merge_options *opt,
 		return -1;
 
 	if (oideq(&merge_base->object.oid, &merge->object.oid)) {
-		printf(_("Already up to date!"));
+		printf_ln(_("Already up to date."));
 		return 1;
 	}
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 27b222ae49..8ca5e3142d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3462,7 +3462,7 @@ static int merge_trees_internal(struct merge_options *opt,
 	}
 
 	if (oideq(&merge_base->object.oid, &merge->object.oid)) {
-		output(opt, 0, _("Already up to date!"));
+		output(opt, 0, _("Already up to date."));
 		*result = head;
 		return 1;
 	}
diff --git a/notes-merge.c b/notes-merge.c
index d2771fa3d4..321155fc87 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -628,7 +628,7 @@ int notes_merge(struct notes_merge_options *o,
 	if (oideq(&remote->object.oid, base_oid)) {
 		/* Already merged; result == local commit */
 		if (o->verbosity >= 2)
-			printf("Already up to date!\n");
+			printf_ln("Already up to date.");
 		oidcpy(result_oid, &local->object.oid);
 		goto found_result;
 	}
-- 
2.31.1.607.g51e8a6a459

