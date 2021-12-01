Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D46C433FE
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347017AbhLAGob (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346990AbhLAGoY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CFBC061756
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:03 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso21380142wmr.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7R2EQFqsUM7X/3/gdMASKmmYTQNOreF0Dm7yEPOfIbE=;
        b=UpfDrVava+93/NBQ2s2ghV7PYdSajlEnWOwTuPBQd+RDM+oel7GFzDatBNMvWzEdsY
         X+PMSM9VEtgDVWn+pa5sSsl+9ZdTLS5ETKlGmgyrRtXDVB/PGAu1XyY0ee88gpIk5jr5
         cXt76zvKob0lroczdWCBJsKaKmzAarBo5t1GSX1oGK5CBwJ4Iu3apV0dn+YK+plVtyES
         1cged5tTQ1J/VwDhJk4KrudB+hyMWqt4VHhX+Vev8P5IoI9uqc0s0IFmjBYWfExbv+hq
         WrLPt3LXos6imlUYQ70zAwX7nse6iAggX/2d/plzVVDNj7R7CLbxYYRJZ+zhzm8umO49
         /w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7R2EQFqsUM7X/3/gdMASKmmYTQNOreF0Dm7yEPOfIbE=;
        b=2o592Tj6LidlxlY7NUCj6ObjxA7ZVKKORyeIh0I5BjifbyNh71RcVm3o39PXIG7oHI
         udxPya+P+ljE7c+U7xwWr31DwyB6C5pfBC+kj4QKbjqJ5d+hNiTjauCjocWUGJ02MJKB
         gHWwH8SEItIfaEwXKsezEXSf32hEoXi/fZy3qJwudRCBShGFEggtAYtrJtQeoZEsVx3i
         s9W/sTM9YEzDjXVeKkYo4EfY+ri7g3eS5aApIb7nEFl6H0Qzp3gMUiUYNzh7d9mGeYPN
         yeycpEkQwQH8hQ/a9Gq622UwGd1vi74xpjIqTcCe7coxUrS8TPJi2qQnAaGz54pYYGfX
         DlDA==
X-Gm-Message-State: AOAM533PRDcn0XYGfYxmxtqSSTjX/zifwiZTBA5R6As57lYYv6309m4R
        qWSMXD97c3g5iZ/JJUWZJQwxw7pm40c=
X-Google-Smtp-Source: ABdhPJwG4l3589k8vgeDXnJ8ZRbUgU8cvwCny1idOAsZF7yXr660Uz1H30jNx+AZeNmczqgRuQlglw==
X-Received: by 2002:a05:600c:4e45:: with SMTP id e5mr4648925wmq.43.1638340862064;
        Tue, 30 Nov 2021 22:41:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm19006074wrd.13.2021.11.30.22.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:41:01 -0800 (PST)
Message-Id: <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:50 +0000
Subject: [PATCH v5 07/11] rebase: do not attempt to remove
 startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Since rebase spawns a `checkout` subprocess, make sure we run that from
the startup_info->original_cwd directory, so that the checkout process
knows to protect that directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c          | 2 ++
 t/t2501-cwd-empty.sh | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..83f257e7fa4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4228,6 +4228,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 
 	cmd.git_cmd = 1;
 
+	if (startup_info->original_cwd)
+		cmd.dir = startup_info->original_cwd;
 	strvec_push(&cmd.args, "checkout");
 	strvec_push(&cmd.args, commit);
 	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index b1182390ba3..52335a8afe9 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -166,11 +166,11 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
 '
 
 test_expect_success 'rebase does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git rebase reverted
+	test_incidental_dir_removal success git rebase reverted
 '
 
 test_expect_success 'rebase fails if cwd needs to be removed' '
-	test_required_dir_removal failure git rebase fd_conflict
+	test_required_dir_removal success git rebase fd_conflict
 '
 
 test_expect_success 'revert does not clean cwd incidentally' '
-- 
gitgitgadget

