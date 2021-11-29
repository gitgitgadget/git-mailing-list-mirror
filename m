Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266D3C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhK2XN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35321C041F52
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s13so40136992wrb.3
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+OWv3HbFUJfLc0lMMsDg+bs2a64j4UTU2nJXjKaPpeY=;
        b=TvcE7fl40JVWhS7QV9J5AC5C/6S8Jms4qExY2+uJB5LCmTBiY0L2WyUUDUHwgW8yIC
         /ki/lfiSF9XFIRJuhC12uycO+IJYUY5I2O5OE4ExM22wh9sUAE1pbNcTzIP+irxKq1TY
         7dSwpQ430HRXvvHMbd6poNvU3+L/VMQOB3zdgg+3V4kh/4PUixZMWP0rW9Mn8MCJF4bv
         zigMfESyjbRShcLE91gWri3brSowX0WRZfr2f34DnOMiPRi0QS2qLhrgmt5jB/luQlPi
         N3Rx59cUObQJimJyfYuhlE2AQScVsZP8+tgcYwrKdeqWzTaH0Hf2W2K23kr4CJAfWrgi
         teTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+OWv3HbFUJfLc0lMMsDg+bs2a64j4UTU2nJXjKaPpeY=;
        b=8RyYRPYBv63AconAl8JL+ZQeOlM0Vw5c5XV6wdzVEwT0f3zKFDC31ByIBIYdu4RpUX
         SsTF3R0t+iffgqu6KDFx029fGmlfD4e8PDDVfDE9au2f5maSpN5PfdPMKfYyO3u0J3UA
         IG/hQkg9ktkPeyyqP1I2UjkoLvgLwAFNrM+R2v7LAdrIWNaiTeSYlKQGaGpoiKmEaIPB
         heWH3GuCPwLU250Hb43iYA6JYL5Ep9ZHeb5AySxebM0YliaxNE30YMZqX4YzT/58qQO9
         C1oFiCRjZ0+7SGqRqPZoDf0Dfal7wKJVPSfbSFoYqHnQD0oZVSkSKbEjL0cwXFsi8a3W
         IgHA==
X-Gm-Message-State: AOAM532V8jsVXeYHYXmFnNxS8IjSHBq801D0g3NX7zFHCWdehp2FbC/g
        fJLdgpaqLy6Rk2EHE8IxIOXIP3waTu8=
X-Google-Smtp-Source: ABdhPJwhw/gdbotOtgpyy3BtC3L6BSA3691TyeZmFt7JO002SrsKXieI6YtK3fScfN7JnbSSMKS8pA==
X-Received: by 2002:a05:6000:82:: with SMTP id m2mr35711089wrx.202.1638225441722;
        Mon, 29 Nov 2021 14:37:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm517671wme.47.2021.11.29.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:21 -0800 (PST)
Message-Id: <a2be40a22d1cab518fd006c2646ba8ada29b8716.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:11 +0000
Subject: [PATCH v4 08/11] stash: do not attempt to remove
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
index 4f7dba9ab3d..e2586a63eca 100755
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

