Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA31C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhLIFM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhLIFMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:19 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E10C061D7E
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o13so7608949wrs.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DIXcxvOsSPQwJa3JlO0jZxditj3ZFxZEiOlRaDgKVvw=;
        b=JGAVK3COZZDXitK2Yj+jOmGPoQ6CYzdoEvP/sxW4ARcdrFM85k3m9IV5WEvxsXr7QE
         e4Rz48I5S/0D9nWjTDI1kr1z2w3zFVXQGFgUVTU9yAJdEMRgNXyEDQN77+ILdPIc98cs
         KbVkf9A0g0sWzzIM9mWm4FoVK5w71upJ5/Qq1w9zZJEyO7ISJFxRiUv1ePhj+Hk5b69G
         MMtsEEngjJp7IwrBsN/9TkLtfwsA2shkdF9g9xUkEV10IF2rbcKLKUN7uzG1hQDnr6cU
         75aTBiU1qFLtL/N9mtmwUeGxpOJ9lJHWsVQvtqRPAkoByJkAs9EjcU+l7yJX2bbrLh7f
         oypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DIXcxvOsSPQwJa3JlO0jZxditj3ZFxZEiOlRaDgKVvw=;
        b=fPWeqNbSbwFRRK6/IsC0pLCSXpL/XjJ5zU0cq6FA4sc+IN93B0EOJ72hOkbF8xw5ja
         xqTvFLo6heWXcq93qSQkTBEfWQWhG7fY36Na+CRsZrhpobyD8TsuJHb6VRYjfG+aHozC
         9s8DCmBbSpb3+8QdxDnle324M8R2RkjWLEvjBWbygCgeXzXTacXAnxvB7f+5wjUfZyUL
         TcqzP//swgdmk4IAeivXRps58PhXddu8nArHa/3l8gexFjfaafGv+QZU+WrP2+Il0AB/
         iOIjLQx9sOW+57Aby3tbAcIWF0SiJejzo74jN/Kr0iV53c8OlFShxulM5Z+YBFPi9GG0
         VbIA==
X-Gm-Message-State: AOAM530oIlTgk2ypGAOciik08RbrjhvzbOiOgbggvlBIPNCsh+DCBYIx
        db1zOZl7Iikjq0OoNNek9HbUcw7Jhtk=
X-Google-Smtp-Source: ABdhPJwpBd4yaf7HT4JdHbt2WZZW7OBF+ywGF3hkNxfATfm4Md0qJzfuT6aSvr3igE9jY66aPzN/0g==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr3711956wrj.478.1639026524298;
        Wed, 08 Dec 2021 21:08:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm4685305wro.68.2021.12.08.21.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:43 -0800 (PST)
Message-Id: <6f3c4fd49b9e816ff45971f26330ab4fba959b80.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:32 +0000
Subject: [PATCH v6 08/11] stash: do not attempt to remove
 startup_info->original_cwd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since stash spawns a `clean` subprocess, make sure we run that from the
startup_info->original_cwd directory, so that the `clean` processs knows
to protect that directory.  Also, since the `clean` command might no
longer run from the toplevel, pass the ':/' magic pathspec to ensure we
still clean from the toplevel.

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c      | 4 +++-
 t/t2501-cwd-empty.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654df..de0e432a4ff 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1485,8 +1485,10 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
+			if (startup_info->original_cwd)
+				cp.dir = startup_info->original_cwd;
 			strvec_pushl(&cp.args, "clean", "--force",
-				     "--quiet", "-d", NULL);
+				     "--quiet", "-d", ":/", NULL);
 			if (include_untracked == INCLUDE_ALL_FILES)
 				strvec_push(&cp.args, "-x");
 			if (run_command(&cp)) {
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 52335a8afe9..be9ef903bd4 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -236,7 +236,7 @@ test_expect_success 'clean does not remove cwd incidentally' '
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal failure \
+	test_incidental_untracked_dir_removal success \
 		git stash --include-untracked
 '
 
-- 
gitgitgadget

