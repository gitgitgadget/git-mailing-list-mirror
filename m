Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71127C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52987613B3
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbhEESlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbhEESlW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:41:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E7EC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 11:40:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y124-20020a1c32820000b029010c93864955so3970018wmy.5
        for <git@vger.kernel.org>; Wed, 05 May 2021 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=9UiN5CWdvDQO3ae4OwJnUOyHTKVvsIxh2E9iVTfAu0I=;
        b=QY8+B9IvsNLjFR8lDnI6RbMjFe0Q71qsS5pIT6GKKW4L1vLtF3Tmo7tkassDM1mZBJ
         LEjzxa05ta01Ot1quzq1x2CkXf5zC5ePObADrKURZPHCuyAnPqoivNlv8M0LpAoz/SWv
         GYRYfrzegJ0DuVWiWD5S/qn6HrDH94jdgx5WKrMbwOw4OJZEsufq1lgA8JqEt+7QBTPv
         7qUs7YFdMjAuV84TNrJyw9VgkrCUIp4dSLMI+YvsAhCPWwDfIPUrg9G9aGeSDZEd/gmJ
         pG8gJtKdrQfeSLzOeyMe0ezwr5r1fm2pXgnPqCYnHdo/fJp16+q3q5YpmNqtHmsT6qRd
         rUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9UiN5CWdvDQO3ae4OwJnUOyHTKVvsIxh2E9iVTfAu0I=;
        b=iACvNwhd2YjZe8y/PWN9oI7lSjMevXKfYqQljPVwmdNjPhnA0BXXXUpWDu81zjbdzh
         oQbnW2PF7WtkMViMmbSff7+OI55sFFDyiX9pHrAWK9b4w7C8p7+xdwE2NK17umQSl9Ta
         HdHj0SWsKe8NTs/WEA7iscmx4k5Rv5OYNUyL+Mxxv108vqhu7Qmg8KtRisxFgVQRZcxA
         iW2aSGpUfVT006k7/IOoNcGMIiGxlq2uh2FQnkpWrqPoIpJiF9l4ggl6OwRB4c9rvqyb
         kQ6daoDTxLVjkbBC0WglH2r/bEt8NVm+wVnKsPuZF7rQLdsEKOZPg1o7FHM1O9rFsaDh
         oTxg==
X-Gm-Message-State: AOAM533vSb+pVjB8fgqHLPHLDegzPyhc/G9QzFGo8cXmWvVclRt38du+
        o/iHwFnm937m6lNCbGu5yWi7d4S29w0=
X-Google-Smtp-Source: ABdhPJyTW+OOj+w2D2NCMnTiiapEo1J7WGlqQLacee6g7chf4F/bid/EsJU4qZ6f/ZCVsNpjp6FNIA==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr11514852wmi.105.1620240023807;
        Wed, 05 May 2021 11:40:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n123sm2546612wme.24.2021.05.05.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 11:40:23 -0700 (PDT)
Message-Id: <pull.1018.git.git.1620240022594.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 May 2021 18:40:22 +0000
Subject: [PATCH] builtin/init-db: preemptively clear repo_fmt to avoid leaks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

init_db() could populate various fields on repo_fmt, we add a
clear_repo_fmt() call to guarantee that we won't leak any of repo_fmt's
members.

At this time, we do not allocate any new data into repo_fmt, but that
changes in the following patch that is currently in seen:
  https://lore.kernel.org/git/2fd7cb8c0983501e2af2f195aec81d7c17fb80e1.1618832277.git.gitgitgadget@gmail.com/
Because it adds the following allocation in init_db():
  repo_fmt.ref_storage = xstrdup(ref_storage_format);

The patch linked to above is only exposing a preexisting problem - we
can add clear_repository_format() independently to preemptively avoid
this class of leak entirely.

Leaks in init_db() are of little significance as this function is called
immediately at the end of cmd_init_db(). However a leak in init_db()
will cause all known leak-free tests (t0000+1+5) to start failing when
run with LSAN - preemptively plugging such leaks is therefore helpful to
avoid regressing on those tests, and more significantly helps the ongoing
efforts to get all of t0000-t0099 to run leak-free.

LSAN output from t0000 on seen:

Direct leak of 6 byte(s) in 1 object(s) allocated from:
    #0 0x4868b4 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0xaa1218 in xstrdup wrapper.c:29:14
    #2 0x5a4b0a in init_db builtin/init-db.c:442:25
    #3 0x5a7a17 in cmd_init_db builtin/init-db.c:742:9
    #4 0x4ce8fe in run_builtin git.c:461:11
    #5 0x4ccbc8 in handle_builtin git.c:718:3
    #6 0x4cb0cc in run_argv git.c:785:4
    #7 0x4cb0cc in cmd_main git.c:916:19
    #8 0x6bf63d in main common-main.c:52:11
    #9 0x7f3222f5f349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 6 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
    builtin/init-db: preemptively plug repo_fmt leak
    
    This patch preemptively plugs a leak which is currently only occuring in
    seen in hn/reftable.
    
    This patch is orthogonal to that series (that series starts allocating
    new memory into an already existing struct - and my patch only adds a
    clear call for that struct - in other words my patch is safe to use
    independent of hn/reftable). But there's also no good reason to use this
    patch independently of that series since we're not leaking prior to that
    series. I'm not sure what the optimal logistics with my patch are, feel
    free to integrate it into that series and/or to fold my change into the
    relevant commit if that's easiest!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1018%2Fahunt%2Finit_db_leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1018/ahunt/init_db_leak-v1
Pull-Request: https://github.com/git/git/pull/1018

 builtin/init-db.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 31b718259a64..b25147ebaf59 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -512,6 +512,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
 	}
 
+	clear_repository_format(&repo_fmt);
 	free(original_git_dir);
 	return 0;
 }

base-commit: c3901c8daf043cdc16ffb20d3a410f3a2d5494fd
-- 
gitgitgadget
