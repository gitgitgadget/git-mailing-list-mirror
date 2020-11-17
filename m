Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB54C56202
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 15:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0CB24199
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 15:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXRa80Af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgKQPCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 10:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgKQPCq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 10:02:46 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA44DC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 07:02:45 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so23467694wrc.8
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Ncyt0PAQdIYYTONtjDq/iMcu3UaDcUzLFyY0IoW9gmE=;
        b=pXRa80AfEWT3GVxmdjuYedp4UPt2ysMpyBiVOlJyE/I6cqzBJjSch2BZfueSJze5UF
         3sM0Pt4R92Nc6EWxOFkfTM/cBiP7dJOqj9JG8TBsr1JGg4zFHZVMw3lgktFYvyfz7BSq
         jWK7fe37nMW7NoEhxVucTRb3avG98KpcmKZQnTtft/9Mes6CkS73Pq8WdQParBs5nCs2
         Df7D28aMK3mAacigh+fMt/h0mDDI9ZWfU4o5yq1utonOi+K4+zRVp81J8s5vEMp02xRv
         M/n7VPvqUL+khZO3SjwvjkohhTDdeYuNLBM523aMWKgLKK8rsnfFbrju317rjjY7i0dp
         9dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ncyt0PAQdIYYTONtjDq/iMcu3UaDcUzLFyY0IoW9gmE=;
        b=J09eszvKmosa4/aNx11Nz3/GTk1H0vKIoGXFsFaa7zKSapxke7+z97pxcqY/Z6riWG
         yjwOaml2iReSGYebxDRe5rovcYdVTk1Y2nxeM5bPp+8dcmbGzuyZMMRBMlIOLOTs5aqD
         JiQcFd6z+inE0PZv/TaxwkWOIWlYGJfiZUCjbWwW9VLj+CCDcRtrRyymRXzgIuj6uuWZ
         +pM/tRJJyY5afsxhgKaGctzc6bCWIsVuiTsk4ksmIGtf/ch2nONtsEN6qxZhKY8rOYW5
         KCmwJka55SEHdBe/uqnfysLOqWQ/mRhXRqXX0McOe5kHVmlm6rOxastauf2L7gki88bk
         R/Dw==
X-Gm-Message-State: AOAM530pSYNBjyCnsowBg/JzwJGf87H2mgsB1+BK3RDT2kF/+qKlh3Nz
        Qi4CyrbnKU1h6C8pt/CcPcHM0qcRrxM=
X-Google-Smtp-Source: ABdhPJybE3DzJ7wu7250NwuscBJ8G0Gmj2OsGeFZY3h8X23Rx6yRJmGezE8wRvdroNyz5oxUVr/7MA==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr25904282wrw.67.1605625364500;
        Tue, 17 Nov 2020 07:02:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 71sm29164820wrm.20.2020.11.17.07.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 07:02:44 -0800 (PST)
Message-Id: <pull.790.git.1605625363309.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 15:02:43 +0000
Subject: [PATCH] hooks: allow input from stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

Let hooks receive user input if applicable.

Closing stdin originates in f5bbc3225 (Port git commit to C,
2007). Looks like the original shell implementation did have
stdin open. Not clear why the author chose to close it on
the C port (maybe copy&paste).

The only hook that passes internal information to the hook
via stdin is pre-push, which has its own logic.

Some references of users requesting this feature. Some of
them use acrobatics to gain access to stdin:
[1] https://stackoverflow.com/q/1067874/764870
[2] https://stackoverflow.com/q/47477766/764870
[3] https://stackoverflow.com/q/3417896/764870
[4] https://github.com/FriendsOfPHP/PHP-CS-Fixer/issues/3165
[5] https://github.com/typicode/husky/issues/442

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    hooks: allow input from stdin
    
    Let hooks receive user input if applicable.
    
    Closing stdin originates in f5bbc3225 (Port git commit to C, 2007).
    Looks like the original shell implementation did have stdin open. Not
    clear why the author chose to close it on the C port (maybe copy&paste).
    
    The only hook that passes internal information to the hook via stdin is
    pre-push, which has its own logic.
    
    Some references of users requesting this feature. Some of them use
    acrobatics to gain access to stdin: [1] 
    https://stackoverflow.com/q/1067874/764870[2] 
    https://stackoverflow.com/q/47477766/764870[3] 
    https://stackoverflow.com/q/3417896/764870[4] 
    https://github.com/FriendsOfPHP/PHP-CS-Fixer/issues/3165[5] 
    https://github.com/typicode/husky/issues/442

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-790%2Forgads%2Fhooks-stdin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-790/orgads/hooks-stdin-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/790

 run-command.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 2ee59acdc8..a17b613216 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1356,7 +1356,6 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
 	while ((p = va_arg(args, const char *)))
 		strvec_push(&hook.args, p);
 	hook.env = env;
-	hook.no_stdin = 1;
 	hook.stdout_to_stderr = 1;
 	hook.trace2_hook_name = name;
 

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
