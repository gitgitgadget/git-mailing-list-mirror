Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D04DC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8F1208D6
	for <git@archiver.kernel.org>; Thu,  7 May 2020 21:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN/vqdlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgEGV3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 17:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGV3n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 17:29:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC245C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 14:29:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z8so8203666wrw.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+vYu52kC2LTJI4mr5HsJUpVzjppouJn2WDVf5qmvgt4=;
        b=RN/vqdljsqEU1Vr+2BFBa6Yuh83mEtc98101bMaRv5L0WvfWLgapLHENtt25LS03O2
         lgpN9BtBdZfz78HplsqqV8c5ZK7pPQE/QGrQepfIzvAPA+LZXqfNXOZ+dRb8uXqH0Jji
         MRHEF2qonQQ6Dn6twrZwhI4+ybiHyuLL2hgmSRwPGbQf4avL1dpkoXFZ3Eyuj0zOpuG0
         meb/safx1AMsThVGZd6UH+GjS2AQjH4SUvL1y8AaAm3FiryDkQfECHUWTc6V/QLc58ry
         W+43bFFSL1M6jvHZKNymh3NiNoQmy5FgkpxmG0pGzs/ZBkqX+sL0Z3a1iYrOTJB2OvWp
         PT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+vYu52kC2LTJI4mr5HsJUpVzjppouJn2WDVf5qmvgt4=;
        b=BHHb644HAV3VgwmBGWo2vzaEDmgTSxkgDsVZDT+YsRHBkPb6qjNHU/An5FU31lMfsw
         N8XtonD9O7ELvBzHobNW75tGab8KP+uTNqZAzimK+fL3DCWfcAp3oxtSZs6/TuJ49KTJ
         XxzD5ST/GDjx9lOCXaMDa3TiZZDihIOuFdCqHf7Wajcvo69KXyxay+4SELL0APwcHHo1
         fY1ajTHNe+lzoGA/o0UzQtVDrnUrcS8SFrRmn/kUHMj03YC6U5avA9rfWQeMpXtYsVxa
         JdwLTw1nAhWRezy1oYuxDa1gF19JsRKBYaEdSWi4bAIiVjBI3wN1A5/pkNHvBCyd+vPY
         Lbdg==
X-Gm-Message-State: AGi0PubysBAzYwlLzOXWD15UrpEa+LT2W65HSE5GtCLAlRIuWIE2RfZR
        XW3vuN1iARpjaoViNPsA9aL3ILFf
X-Google-Smtp-Source: APiQypIgU7b626uoujYhXzlLj/DzNSmBFaHUscxQyVjZigK2yx5B8sSkhnRTyYy8/d7gxlg4vtYK6w==
X-Received: by 2002:adf:fad0:: with SMTP id a16mr19556380wrs.149.1588886981285;
        Thu, 07 May 2020 14:29:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm3088594wmc.21.2020.05.07.14.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:29:40 -0700 (PDT)
Message-Id: <pull.629.git.1588886980377.gitgitgadget@gmail.com>
From:   "Christopher Warrington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 21:29:40 +0000
Subject: [PATCH] bisect: fix replay of CRLF logs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christopher Warrington <chwarr@microsoft.com>,
        Christopher Warrington <chwarr@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christopher Warrington <chwarr@microsoft.com>

Sometimes bisect logs have CRLF newlines. (E.g., if they've been edited
on a Windows machine and their LF-only nature wasn't preserved.)
Previously, such log files would cause odd failures deep in the guts of
git bisect, like "?? what are you talking about?" or "couldn't get the
oid of the rev '...?'" (notice the trailing ?) as each line's CR ends up
part of the final value read from the log.

This commit fixes that by stripping CRs from the log before further
processing.

A regression test that fails without the git-bisect.sh change, "bisect
replay with CRLF log" has been added as well.

Were anyone to intentionally be using terms/revs with embedded CRs,
replaying such bisects will no longer work with this change. I suspect
that this is incredibly rare.

Signed-off-by: Christopher Warrington <chwarr@microsoft.com>
---
    [RFC] bisect: fix replay of CRLF logs
    
    I recently ran into a problem replaying a bisect log that was created
    and edited on a Windows machine. During the editing process, the log's
    LFs were converted to CRLFs, which caused git bisect replay to fail. In
    my particular case, the error from git version 2.26.2.windows.1 was
    "couldn't get the oid of the rev '...?'" (notice the trailing ?).
    
    I was able to reproduce this problem in the current maint branch,
    af6b65d45e (Git 2.26.2, 2020-04-19) on Ubuntu 18.04 as well.
    
    This patch strips any CRs from the log during git bisect replay to avoid
    these issues.
    
    Is this change something that makes sense to add to Git itself?
    
    I've opted to use tr -d '\r' to remove all CRs from the bisect log for
    simplicity, but if there's a need to preserve CRs in the middle of log
    lines, something like this will only remove a CR at the end of the line:
    
    sed $(printf 's/^\\(.*\\)\r$/\\1/') "$file" | while read ...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-629%2Fchwarr%2Fbisect-replay-crlf-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-629/chwarr/bisect-replay-crlf-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/629

 git-bisect.sh               | 10 ++++++++--
 t/t6030-bisect-porcelain.sh |  7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index efee12b8b1e..8406a9adc36 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -209,7 +209,11 @@ bisect_replay () {
 	test "$#" -eq 1 || die "$(gettext "No logfile given")"
 	test -r "$file" || die "$(eval_gettext "cannot read \$file for replaying")"
 	git bisect--helper --bisect-reset || exit
-	while read git bisect command rev
+
+	# We remove any CR in the input to handle bisect log files that have
+	# CRLF line endings. The assumption is that CR within bisect
+	# commands also don't matter.
+	tr -d '\r' <"$file" | while read git bisect command rev
 	do
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
 		if test "$git" = "git-bisect"
@@ -231,7 +235,9 @@ bisect_replay () {
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
-	done <"$file"
+	done
+
+	get_terms
 	bisect_auto_next
 }
 
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 821a0c88cf0..72c5dbab278 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -792,6 +792,13 @@ test_expect_success 'bisect replay with old and new' '
 	git bisect reset
 '
 
+test_expect_success 'bisect replay with CRLF log' '
+	awk 1 "ORS=\\r\\n" <log_to_replay.txt >log_to_replay_crlf.txt &&
+	git bisect replay log_to_replay_crlf.txt >bisect_result_crlf &&
+	grep "$HASH2 is the first new commit" bisect_result_crlf &&
+	git bisect reset
+'
+
 test_expect_success 'bisect cannot mix old/new and good/bad' '
 	git bisect start &&
 	git bisect bad $HASH4 &&

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
gitgitgadget
