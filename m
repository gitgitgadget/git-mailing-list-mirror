Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE9C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 11:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347506AbiBULV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:21:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356230AbiBULUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 06:20:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FACDE93
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:10:58 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so13282268wme.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uMp87Jqr9jdETqR6KHqdKgyX/oAA9i5SfRxts8jQ3oc=;
        b=mA3uc5ycsDqV/vTefiPI3Vu5ANLYhnSN3FVNKcOwRyagN6duQ7xNGZRicsNFBD8QLV
         hhVO3hNqpqwhOveowYr8Ba+eKcn8mUSYfD4bFdsNHFxOFxBc49BgSugVw0gGaSjjfgWr
         X/p9CtwNVuzCyhTz8CrDT7CDDshVDMYUl1wDzpWeni2W9ryXxoGtgMPMW/zS9sdPB46w
         zashRAe2yV+cZG3iGYr/CT3CmLHzlWJaCakhDIuBHWm1gPFasfLOjxVUWg1qJ3omQ1Jm
         23hZV1coNevNMGEH1ApVwLrGlHFiBdBO73bi0T7NfV3C8xyNvE6/egJGAHFwUmMMZ/49
         q+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uMp87Jqr9jdETqR6KHqdKgyX/oAA9i5SfRxts8jQ3oc=;
        b=o5fDWqSuK5z0I5bfif9LUkg7sww2Qvc0+nRmFYh0CpAk+OFA7D2iFvESyO09BHFKMS
         Vu7TcBvLfwEZIJzb6nDpT1hof5wZTf7aO42T6ctVNxO5YKL27jzWJaFNq/iFxVhpGWoW
         GUkYl49s+Mzj0pq9KqcZmXxFjqSQqbRrlqjsOaXZry635gUKDRGjNWN9ds2w27kiykmY
         EAqDREtSXnCAUIur0dIKdoEmOIMPUPG/LFWtF+aFEruDOiG6o2V2affdBnFDwPooGSVJ
         gnwsaP/IHRnmXtvc7ezlJCkOS9qNy6j+g1Y3ox2va7JxbWdi1gLzosvyyFIWT9RldPrP
         Evkw==
X-Gm-Message-State: AOAM532zEMHh6yLb/gPjkTgIKqWvJxDNZYO84j+Ix2LqKTeiuiTFX3x+
        nniy8KfYwHLZ/AtS88IDtKN54ex3ZRo=
X-Google-Smtp-Source: ABdhPJxMLI8tqEHTbNZsd06BQg+3zHWnuYRgcRzccfnL7jTdlMuaUlG/1xBTTbSUcrt9HCjrK/oxzA==
X-Received: by 2002:a05:600c:190d:b0:351:4a49:4bda with SMTP id j13-20020a05600c190d00b003514a494bdamr17103804wmq.194.1645441856617;
        Mon, 21 Feb 2022 03:10:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q76sm7889092wme.1.2022.02.21.03.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:10:56 -0800 (PST)
Message-Id: <243e7b0c372c15cc907c838ee74794433aa79858.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 11:10:48 +0000
Subject: [PATCH 1/7] rebase --apply: remove duplicated code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When we are reattaching HEAD after a fast-forward we can use
move_to_original_branch() rather than open coding a copy of that
code. The old code appears to handle the case where the rebase is
started from a detached HEAD but in fact in that case there is nothing
to do as we have already updated HEAD.

Note that the removal of "strbuf_release(&msg)" is safe as there is an
identical call just above this hunk.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e942c300f8c..4832f16e675 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1782,19 +1782,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * If the onto is a proper descendant of the tip of the branch, then
 	 * we just fast-forwarded.
 	 */
-	strbuf_reset(&msg);
 	if (oideq(&merge_base, &options.orig_head)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
-		strbuf_addf(&msg, "rebase finished: %s onto %s",
-			options.head_name ? options.head_name : "detached HEAD",
-			oid_to_hex(&options.onto->object.oid));
-		memset(&ropts, 0, sizeof(ropts));
-		ropts.branch = options.head_name;
-		ropts.flags = RESET_HEAD_REFS_ONLY;
-		ropts.head_msg = msg.buf;
-		reset_head(the_repository, &ropts);
-		strbuf_release(&msg);
+		move_to_original_branch(&options);
 		ret = finish_rebase(&options);
 		goto cleanup;
 	}
-- 
gitgitgadget

