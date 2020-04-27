Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E22C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971AB206BF
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrTfA7DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgD0QVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726229AbgD0QVp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 12:21:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A660AC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:21:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so300446wmg.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=QMH6MCZnTjU0u2cPoaSFW3lUE1FSUvECpjLPJlSBc9A=;
        b=PrTfA7DIZVvF01rqYnmmo9gfWDmA2smidRuGuWPiJt6i6oLDr+H2lVdJ0l3JX7bSwg
         vfoznkHWZZ6ZBx0OFHWQapEJa/H0NQkrj5tgloaMi4QfoTQVl26Jc3BRkCHnhA+1se9C
         c+yWVxN/NwUDMzgyMcEOGNK0rJTUuFS6p4POTnrzo7yRRj1E/Wq+oaVHXcanCTzrG6MT
         qG9eVt0gGUosBMsHSxtUv55RqRbohrhM06aBsyBGDNFdJ++BVrzp5GWZxMxV8a0lWh+f
         l3et8OT5ltGbRxseTueT/eBIGpNHs9G86mMjeDJm+RmidZCIy6V7a8zsltL4r6zup7iA
         x2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QMH6MCZnTjU0u2cPoaSFW3lUE1FSUvECpjLPJlSBc9A=;
        b=InykVzpO59ozgwOP+SZj1cmswDdLpVkNX66iQ1JxhwDfzzZMod2+OUMhYg2aeSQ7ko
         WdC8P4lXkr/8E3utkqaKa21VynWdxbkxOSOPVvVbj2OXzwxkHeweF/NhfCpnRlWiM7wi
         WVChbmaIIjry6DchE5M8Lg96qlgthmCu5ljX0uY/eYVOzXqhHC4s6OHhuj0YP/zRwsEJ
         kcijEEAI+eVObcJZUOwNnTPXlP1Rq2HAf6KH07x5UAeVRMjFXm4KGmiUH+6P/x54ExIT
         mSkx/izTLUqVNlmzIAl3Wfk2DZSXJCguERyX30imT1y8ITjI9maSyt/SVWNzPk9bXSje
         JJIw==
X-Gm-Message-State: AGi0PuYcxZiya23PVwzEzCSUV0J5ZK6/f2UHHPEGDX7OAa5IXwhT4NQK
        nMRiwLjGno6EGqh2eEtsO/pCsCoa
X-Google-Smtp-Source: APiQypIHvBj47L4qr6KHQliayoqfHN2KpeeAXeYHUFJKJZ1leAu1vnjB/ikK6HthHOT4Z1y+Hum+uQ==
X-Received: by 2002:a1c:9ad4:: with SMTP id c203mr277199wme.126.1588004502167;
        Mon, 27 Apr 2020 09:21:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c83sm17777573wmd.23.2020.04.27.09.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:21:41 -0700 (PDT)
Message-Id: <pull.771.git.git.1588004500766.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 16:21:39 +0000
Subject: [PATCH] rebase: display an error if --root and --fork-point are both
 provided
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--root implies we want to rebase all commits since the beginning of
history.  --fork-point means we want to use the reflog of the specified
upstream to find the best common ancestor between <upstream> and
<branch> and only rebase commits since that common ancestor.  These
options are clearly contradictory, so throw an error (instead of
segfaulting on a NULL pointer) if both are specified.

Reported-by: Alexander Berg <alexander.berg@atos.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    rebase: display an error if --root and --fork-point are both provided
    
    --root implies we want to rebase all commits since the beginning of
    history. --fork-point means we want to use the reflog of the specified
    upstream to find the best common ancestor between and and only rebase
    commits since that common ancestor. These options are clearly
    contradictory, so throw an error (instead of segfaulting on a NULL
    pointer) if both are specified.
    
    Reported-by: Alexander Berg alexander.berg@atos.net
    [alexander.berg@atos.net]Signed-off-by: Elijah Newren newren@gmail.com
    [newren@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-771%2Fnewren%2Frebase-fork-point-root-error-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-771/newren/rebase-fork-point-root-error-v1
Pull-Request: https://github.com/git/git/pull/771

 builtin/rebase.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index bff53d5d167..287ac1aa21b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1652,6 +1652,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("cannot combine '--keep-base' with '--root'"));
 	}
 
+	if (options.root && fork_point > 0)
+		die(_("cannot combine '--root' with '--fork-point'"));
+
 	if (action != ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);

base-commit: af6b65d45ef179ed52087e80cb089f6b2349f4ec
-- 
gitgitgadget
