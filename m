Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACA6C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC26661057
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbhIGNiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243642AbhIGNiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:38:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96ACC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:36:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so1901482wmi.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yTex/uN01jFfTNtZtCCmfB+c28nuWNYj2f6J1XEjXiw=;
        b=ons2G2gcUiVkG7VP8n6kQXneq18o7nZDoOZvXHiFpUOvuRMiNVCis5jtUQKzpbCBcV
         vqWGTZTd2QZ2xW+zKKjNdkLpsHEX76cvyKjE4IJfwppZKPH3RdfkuFQaEf7X9b6SMxpi
         rTIYcb49TzbkYZz/yCZJkLgc9bD1jKBWsT0ZAUtrXjXlcasySXPk/A+JYFjWvL4c4A7R
         PLNH77L06MNlkZ3zuUC80nZVEY6ukvTwHQ9fHnntgy4ZnusIBc6LYmHWSj1wBl6GLGP8
         au7O8/7eyuI7CYI5Q0XYwsAmI284k5JmiDqWjNiHsjWGPjyV7iN+JSYE7c+w60kt+dQQ
         gMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yTex/uN01jFfTNtZtCCmfB+c28nuWNYj2f6J1XEjXiw=;
        b=kMuPfjal0vq4wkMq8YMwLmbCGGnFeCt1UMZoLojdx0zdWyxCOJ3srL5yWoxOBgppzD
         O/8i688YIfl9iV1CWKfMTRONlvBVcayS+cznCsy1AFXpwt7guXbvLyc2js1CF4obfsPL
         IgHrJZVXi/bj3c6OjvBlO4hK8vADmUwa5xz7ycJhS0Nw8inNnDFPsCSCISm1mq/0JltJ
         hKAD6gPawuMPH1qsZnmHh7idA3rOLk09HpVxWM3FnqgaMPnGGW2ltJMljIeyuo6ZPsxu
         S3BmPHHRtfpj1G+PEufyy8J1Y1zr+wxgR2bF72+1oyKuYdS5ChCvnqHos+xmOd1ckwKs
         uUXw==
X-Gm-Message-State: AOAM5319tWFX8X3kJTt1s+qOQ5ToFOKx9klhl6ofT8AkffKXlNKxqQ85
        J14W3wH5CbNuGUXy0TU4bqGfTJCKSKQ=
X-Google-Smtp-Source: ABdhPJwU+3AjD6uRwjIL8Uz6tj6BfoeMCM2IJ8MeemPFn8TUfTan6nQqZedktjkWvo6qFovdteGlww==
X-Received: by 2002:a05:600c:b46:: with SMTP id k6mr4055723wmr.35.1631021809567;
        Tue, 07 Sep 2021 06:36:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2sm11116724wra.40.2021.09.07.06.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:36:49 -0700 (PDT)
Message-Id: <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 13:36:41 +0000
Subject: [PATCH v3 0/7] Gets rid of "if reflog exists, append to it regardless of config settings"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<As discussed in
CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com

v3:

 * fix show-branch
 * add some more context to commit messages
 * change calling convention for log_ref_setup; could fold into predecessor
   if needed too.

Han-Wen Nienhuys (7):
  show-branch: show reflog message
  refs: trim newline from reflog message
  test-ref-store: tweaks to for-each-reflog-ent format
  t1400: use test-helper ref-store to inspect reflog contents
  refs: drop force_create argument of create_reflog API
  RFC: refs: reflog entries aren't written based on reflog existence.
  refs: change log_ref_setup calling convention

 builtin/checkout.c             |   2 +-
 builtin/show-branch.c          |   7 +-
 reflog-walk.c                  |   6 +-
 refs.c                         |   9 ++-
 refs.h                         |   4 +-
 refs/debug.c                   |   5 +-
 refs/files-backend.c           | 128 +++++++++++++--------------------
 refs/packed-backend.c          |   3 +-
 refs/refs-internal.h           |   2 +-
 t/helper/test-ref-store.c      |   8 +--
 t/t1400-update-ref.sh          |  21 +++---
 t/t1405-main-ref-store.sh      |   6 +-
 t/t1406-submodule-ref-store.sh |   6 +-
 t/t3202-show-branch.sh         |  15 ++++
 14 files changed, 101 insertions(+), 121 deletions(-)


base-commit: e0a2f5cbc585657e757385ad918f167f519cfb96
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1067%2Fhanwen%2Freflog-touch-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1067/hanwen/reflog-touch-v3
Pull-Request: https://github.com/git/git/pull/1067

Range-diff vs v2:

 -:  ----------- > 1:  e158882812f show-branch: show reflog message
 1:  995d450da42 ! 2:  d16d94164c1 refs: trim newline from reflog message
     @@ Commit message
      
       ## builtin/show-branch.c ##
      @@ builtin/show-branch.c: int cmd_show_branch(int ac, const char **av, const char *prefix)
     - 				show_one_commit(rev[i], 1);
     + 			char *logmsg;
     + 			char *nth_desc;
     + 			const char *msg;
     +-			char *end;
     + 			timestamp_t timestamp;
     + 			int tz;
     + 
     +@@ builtin/show-branch.c: int cmd_show_branch(int ac, const char **av, const char *prefix)
     + 				break;
       			}
     - 			else
     --				puts(reflog_msg[i]);
     -+				puts(reflog_msg[i]); /* XXX - this puts a
     -+							newline. Did we put two
     -+							newlines beforehand? */
       
     - 			if (is_head)
     - 				head_at = i;
     +-			end = strchr(logmsg, '\n');
     +-			if (end)
     +-				*end = '\0';
     +-
     + 			msg = (*logmsg == '\0') ? "(none)" : logmsg;
     + 			reflog_msg[i] = xstrfmt("(%s) %s",
     + 						show_date(timestamp, tz,
      
       ## reflog-walk.c ##
      @@ reflog-walk.c: void get_reflog_message(struct strbuf *sb,
 2:  11b296a55e9 = 3:  e273963216c test-ref-store: tweaks to for-each-reflog-ent format
 3:  9ec09cc64cd = 4:  52093fce57c t1400: use test-helper ref-store to inspect reflog contents
 4:  aa25fd9b7de ! 5:  ce0047028dd refs: drop force_create argument of create_reflog API
     @@ Commit message
          There is only one caller, builtin/checkout.c, and it hardcodes
          force_create=1.
      
     +    This argument was introduced in abd0cd3a301 (refs: new public ref function:
     +    safe_create_reflog, 2015-07-21), which promised to immediately use it in a
     +    follow-on commit, but that never happened.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## builtin/checkout.c ##
     @@ refs/files-backend.c: error:
       	int fd;
       
      -	if (log_ref_setup(refs, refname, force_create, &fd, err))
     -+	if (log_ref_setup(refs, refname, /*force_create=*/1, &fd, err))
     ++	if (log_ref_setup(refs, refname, 1, &fd, err))
       		return -1;
       
       	if (fd >= 0)
 5:  f6a7c5ad56e ! 6:  7a030cfd3e2 RFC: refs: reflog entries aren't written based on reflog existence.
     @@ Commit message
          The reftable storage backend cannot distinguish between a non-existing
          reflog, and an empty one. Therefore it cannot mimick this functionality.
      
     -    In CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com,
     -    we came to the conclusion that this feature is probably a remnant from
     -    the time that reflogs weren't enabled by default, and it does not need
     -    to be kept.
     +    With this feature, it is possible to mark only specific branches as subject to
     +    reflog updates. When introduced, it presumably served as a cheap substitute for
     +    introducing branch.$NAME.logRefUpdate configuration setting.
     +
     +    Reflogs are small and don't impact the runtime of normal operations, so this
     +    flexibility is not very useful. Since it incurs complexity for alternate ref
     +    backends, we remove it.
     +
     +    Further background to this change is in
     +    <CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
 -:  ----------- > 7:  1124dbad594 refs: change log_ref_setup calling convention

-- 
gitgitgadget
