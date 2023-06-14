Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A7EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjFNTgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFNTgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:36:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24E11C
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:36:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f78a32266bso11814895e9.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686771360; x=1689363360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FxqZvruQc3EEsniovDdwYAVxBtrg7EkeAHH5opFwkuk=;
        b=NvnYnYZK9R/zo6GLq37EPpB64c9toyNPTBhJbTX9OYnWAzMDyQHWeZFVq0acVYNLMI
         HEIHdwStHsbw8uzgH3hTqcQYcb1bAwf+aL+xI5pBIIWy13bfUcvA4OY0vO8pvZ1B94P5
         DmvnOanx9gBZ/T2ATNWOA86sbHEZJ/qM3Ybf25yL8j6Iih5SpXdQtcRZwoyXyEm/6uPZ
         hO9goJR3MAdQVQH+0gb9QcyKRqh78829gO480vunzbu150Nkt6xTzb2z1OmCdhFOFYqa
         aRBiem4gF8rGTwCklPadR2FW1vA5UuOdGeZVo1P9lwrgEGwNzV7cCY7+9jeV7oszX8nh
         XI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686771360; x=1689363360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxqZvruQc3EEsniovDdwYAVxBtrg7EkeAHH5opFwkuk=;
        b=ZgMueGi1IldHoZo8a0QvzHJN6iDlKy0FcnkLc7o/XXnM1c9Od7AyxaomHQK1kUBrtf
         GEvf+9Y5WU9DIBPhAPMhZZ8BWxIjgpMqFsQx3TXJj3xUKjvniRcPGSg3doUjHDrs+Kbq
         Ew+Qsdr+P1yx6gd4qgqg/2/bwj6T1cqlBxp0xEagDPU6DqQBTlVI4DzXKsxR5jvmbjll
         5BxxVyAc2YVYlNomOxlm1PW1OIWE1+1AsJQ7uzRK67+2WwqsXm9AQum7L8SbknY/vLNo
         XAd/2sO3d2lPnMs9bYdW1Z6CdAVn/CFIRl4nsxal5wYAKaMh2oVSNOtKJXqVM6H9Zpcd
         8mAg==
X-Gm-Message-State: AC+VfDwqJ3Za2JGgzPj2zQzX4YaIYEv44VzL9JWFFN+NmTgmtrMLh7pb
        MHNGF/lG4mOYYoQGBnCslzeOj+didbA=
X-Google-Smtp-Source: ACHHUZ4ndlJjcGPpGHyA6vHkqqzP3MtX8FT1bUl9oq5YX9fMpwiimAgN4VW1vhFvBUMuyGFwrlmndA==
X-Received: by 2002:a1c:7906:0:b0:3f7:e48b:974d with SMTP id l6-20020a1c7906000000b003f7e48b974dmr13892727wme.27.1686771359676;
        Wed, 14 Jun 2023 12:35:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2-20020a5d5042000000b0030fd03e3d25sm4913577wrt.75.2023.06.14.12.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:35:59 -0700 (PDT)
Message-Id: <pull.1526.git.git.1686771358484.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jun 2023 19:35:58 +0000
Subject: [PATCH] setup.c: don't setup in discover_git_directory()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

discover_git_directory() started modifying the_repository in ebaf3bcf1ae
(repository: move global r_f_p_c to repo struct, 2021-06-17), when, in
the repository setup process, we started copying members from the
"struct repository_format" we're inspecting to the appropriate "struct
repository". However, discover_git_directory() isn't actually used in
the setup process (its only caller in the Git binary is
read_early_config()), so it shouldn't be doing this setup at all!

As explained by 16ac8b8db6 (setup: introduce the
discover_git_directory() function, 2017-03-13) and the comment on its
declaration, discover_git_directory() is intended to be an entrypoint
into setup.c machinery that allows the Git directory to be discovered
without side effects, e.g. so that read_early_config() can read
".git/config" before the_repository has been set up.

Fortunately, we didn't start to rely on this unintended behavior between
then and now, so we let's just remove it. It isn't harming anyone, but
it's confusing.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    setup.c: don't setup in discover_git_directory()
    
    This is the scissors patch I sent on Victoria's series [1], but rebased
    onto "master" since that series hasn't been merged yet. The merge
    conflict resolution is to delete all of the conflicting lines:
    
    -	the_repository->repository_format_worktree_config =
    -		candidate.worktree_config;
    -
    
    
    IOW it's the original scissors patch if queued on top of Victoria's
    series, but it might be cleaner to invert that, i.e. if we pretended
    that this was in "master" already, there wouldn't be reason to add those
    lines to begin with.
    
    [1]
    https://lore.kernel.org/git/kl6llegnfccw.fsf@chooglen-macbookpro.roam.corp.google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1526%2Fchooglen%2Fpush-nknkwmnkxolv-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1526/chooglen/push-nknkwmnkxolv-v1
Pull-Request: https://github.com/git/git/pull/1526

 setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/setup.c b/setup.c
index 458582207ea..bbd95f52c0f 100644
--- a/setup.c
+++ b/setup.c
@@ -1423,11 +1423,6 @@ int discover_git_directory(struct strbuf *commondir,
 		return -1;
 	}
 
-	/* take ownership of candidate.partial_clone */
-	the_repository->repository_format_partial_clone =
-		candidate.partial_clone;
-	candidate.partial_clone = NULL;
-
 	clear_repository_format(&candidate);
 	return 0;
 }

base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
-- 
gitgitgadget
