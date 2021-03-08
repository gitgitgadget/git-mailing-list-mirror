Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A22C4332B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31F76520C
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCHSg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCHSgW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:36:22 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72777C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 10:36:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo4411833wmq.4
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 10:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=/Q77lp/ov3oo4heLK9b7CgfsYKZjRW0s4eD1rr6y9XY=;
        b=gtF2UhOdObFUqE+btK46ozzaRlbNHH1jauSwSl8znPReDclV30nay6maCKm9szXOQJ
         1Dp8QUWTkrjJWGOUTMCB38lqpmVjrTkkY7bei3iBNhML4pN7zMkg3V2ExQBccGKEcB6l
         IvmriZONLILDWM7y7WaEg66x64z/E9QCwJnCW0REro8UiSqNanb7YB5eEZ2OmRQBvsXv
         cCTDfgkengyA393L1cQkLw3gmeN17CtZC3GCxlJyvvynfEsskBAPcXrJ16uV4E576bhg
         RsW7KASGPxbEwWeCkkHSUChihJDsU4dT7yXEVi2IWCC6oQRew8QWfvBh6JoJ1qfzVAVs
         /uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/Q77lp/ov3oo4heLK9b7CgfsYKZjRW0s4eD1rr6y9XY=;
        b=dsCGMcaU+qexdE8V+edUz3GmbhL3xGcYiLniFVzLuDVScaO2pM2N4e9KcdJlzfRzxA
         AuoPk4iFSn5Y4TeIoet0UN2oaZtLlxkfrLN20cWCylSNnxbrgrtYudZXcRyuODLi/9N1
         UWGe0oj5JB7jmvsGd/qDQ0Xa8Si3kSKDFOlPcYwak4ONozMu6HcT9IZDOjNRl6KagBFx
         jujZ8w0beRHh76IYCJtKHQIv7qZaRkRq2eCwP2Qh2G6ID/EQQ1tctRomfpLayp/lgWn3
         BNli0Xybb1KDBHcNbjZ2NvGeE4KGHgtjCZq2pZj9RwlUmTL8bZMCqAtkz3ifXv95WkEm
         LyDg==
X-Gm-Message-State: AOAM530y4Gqk07tNFdWRfZGlvm8dlRNx6kshaTWkUVAoz8tcxM9K6czC
        9nQWLosxwwRAbaEpmYI+WSNpAx2fAVw=
X-Google-Smtp-Source: ABdhPJzS2IiDabER+86gkXb6KrQrzv2vxuf8VomykJ6No0Yr/C6sRaQd2j9clTQuPb1QMVZRNdgRDw==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr114342wmc.185.1615228581204;
        Mon, 08 Mar 2021 10:36:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 21sm270547wme.6.2021.03.08.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:36:20 -0800 (PST)
Message-Id: <pull.899.git.1615228580.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 18:36:13 +0000
Subject: [PATCH 0/7] Fix all leaks in t0001
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes (or annotates) all the memory leaks that can cause t0001
to fail when run with LeakSanitizer (t0000 already passes without failures).

I suspect that none of these leaks had any user impact, and I'm aware that
every change does cause some noise - I would have no objections to
abandoning this series if it's not deemed valuable enough. On the other
hand: fixing or suppressing these leaks should make it easier to spot leaks
that have more significant user impact (it's entirely plausible that no real
impactful leaks exist).

Note: this series does not guarantee that there are no leaks within
t0000-t0001, it only fixes those leaks which cause test failures. There is
at least one test case in t0000 where git is invoked in a subshell, and the
return value is ignored - meaning that a memory leak that is occuring during
that invocation does not cause tests to fail (I'm still trying to figure out
if that's something that's worth fixing - but that's probably a topic for a
separate thread):
https://git.kernel.org/pub/scm/git/git.git/tree/t/t0000-basic.sh#n1285

In case anyone is interested: I have been using the following workflow to
find leaks and verify fixes - I'm running into crashes when using LSAN
standalone, therefore I'm using full ASAN instead (I'm not particularly
concerned about this: LSAN standalone mode is known to be less-well tested
than leak-checking within ASAN [1], and the crashes are occurring within the
leak-checker itself):

make GIT_TEST_OPTS="-i -v" DEFAULT_TEST_TARGET="t0000-basic.sh"
ASAN_OPTIONS="detect_leaks=1:abort_on_error=1" SANITIZE=address DEVELOPER=1
CFLAGS="-DSUPPRESS_ANNOTATED_LEAKS -g -fno-optimize-sibling-calls -O1
-fno-omit-frame-pointer" test

(I then rerun the entire test suite with ASAN but with leak-checking
disabled in order to gain some confidence that my fixes aren't inadvertently
introducing memory safety issues.)

[1]
https://github.com/google/sanitizers/wiki/AddressSanitizerLeakSanitizer#stand-alone-mode

Andrzej Hunt (7):
  symbolic-ref: don't leak shortened refname in check_symref()
  reset: free instead of leaking unneeded ref
  clone: free or UNLEAK further pointers when finished
  worktree: fix leak in dwim_branch()
  init: remove git_init_db_config() while fixing leaks
  init-db: silence template_dir leak when converting to absolute path
  parse-options: don't leak alias help messages

 builtin/clone.c        | 13 ++++++++++---
 builtin/init-db.c      | 32 ++++++++++----------------------
 builtin/reset.c        |  2 +-
 builtin/symbolic-ref.c | 12 +++++++++---
 builtin/worktree.c     | 12 ++++++------
 parse-options.c        | 29 ++++++++++++++++++++++++-----
 6 files changed, 60 insertions(+), 40 deletions(-)


base-commit: be7935ed8bff19f481b033d0d242c5d5f239ed50
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-899%2Fahunt%2Fleaksan-t0001-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-899/ahunt/leaksan-t0001-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/899
-- 
gitgitgadget
