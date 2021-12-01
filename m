Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B65C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 03:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbhLADlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 22:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346473AbhLADkw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 22:40:52 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67252C061746
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 19:37:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p18so19158438wmq.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 19:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jUtRc9y60noRP3Sh1lpsBU9XvDFY8mWzxjGl9byUcRk=;
        b=hVCjQTF1+I6tUhKCYeFWxdKbhPJF/KaBRfTTeDkCim49H1TmqR7s7nWRDwFoPV7PYj
         DqLHR25m/0IylTAsqcpk9nVniFa6gTHoabEzmer03m8OnysI7hjUyKUNcnq3Bf/YJKzC
         Nc2tK8mIsz+Qj4/1u7+fzqReK3an31OZ4k/zvTjvP67QlvpXf/TMYH0tLb3JFnBhQeOW
         XjAvNucpXFLl9tCTrwhbJhMhx3LYKMVScoP5nlgjEpVMULEcCvpXUeMSeZ/hwa70hqhz
         Gg3RigK9kkSq7WLGV/3ha6enuzpu5hazorPAFOwz0k+tbLFy3s3EqshAt/vFLqU9+2j/
         v5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=jUtRc9y60noRP3Sh1lpsBU9XvDFY8mWzxjGl9byUcRk=;
        b=TtYzk7tnLCKk+s3rmnGJ514yLtqwLuKJBTxftuMw/5I+bd+UGepXOh9z3U76JjNeNO
         tr5HL8JWY/lzwWR4GMbvtJJsyX125/uqCl7FpKtg90/50bN0OiEXbd8Y8pt393/9vQi1
         1wOK3PHUpQdZxgJwqeT6znDQF30w6LXn1CWQlJ6uEAvj7Oq71BaXV/LVMjKS5F2jPLse
         S8EirbbM7L22e0SpeM73+r/A0yJcYWGAY66yHa394mOUb/VHtnaTIS9DDFvIf+0lujaZ
         8FB2unAIOpzLc+LjlAsYnhaafTGEiqHkkfJaqJ2dFx8m4HXyl2Zo89Y8JfMX/9cjyVNs
         /qmw==
X-Gm-Message-State: AOAM530w+fqRuw+zrqJwTSX7yx4m+q7z2Vtv5fU4J+76l4ABfxEhHSTm
        dUjLeHnFnG/KuOkEAzJItolgboWb+6w=
X-Google-Smtp-Source: ABdhPJx0Cwe8H6dOy4Rph6jAlUnggJv4LREzLnF1sobAoOxXDTsTZaCdKRUcTcQnIsEKwm+wBmbSyQ==
X-Received: by 2002:a05:600c:190b:: with SMTP id j11mr3686574wmq.112.1638329850708;
        Tue, 30 Nov 2021 19:37:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm4290923wmi.36.2021.11.30.19.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 19:37:30 -0800 (PST)
Message-Id: <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
References: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 03:37:25 +0000
Subject: [PATCH v14 0/3] am: support --empty=(die|drop|keep) option and --allow-empty option to
 handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Changes since v6:

 1. add i18n resources.

----------------------------------------------------------------------------

Changes since v7:

 1. update code according to the seen branch.
 2. fix the wrong document of git-am.
 3. sign off commits by a real name.

----------------------------------------------------------------------------

Changes since v8:

 1. update the committer's name with my real name to fix DCO of GGG.

----------------------------------------------------------------------------

Changes since v9:

 1. imitate the signed name format of
    https://lore.kernel.org/git/pull.1143.git.git.1637347813367.gitgitgadget@gmail.com
    .

----------------------------------------------------------------------------

Changes since v11:

 1. introduce an interactive option --allow-empty for git-am to record empty
    patches in the middle of an am session.

----------------------------------------------------------------------------

Changes since v12:

 1. record the empty patch as an empty commit only when there are no
    changes.
 2. fix indentation problems.
 3. simplify "to keep recording" to "to record".
 4. add a test case for skipping empty patches via the --skip option.

----------------------------------------------------------------------------

Changes since v13:

 1. add an additional description about the 'die' value.

徐沛文 (Aleen) (3):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches
  am: support --allow-empty to record specific empty patches

 Documentation/git-am.txt           | 16 +++++-
 Documentation/git-format-patch.txt |  6 ++-
 builtin/am.c                       | 82 +++++++++++++++++++++++++-----
 t/t4150-am.sh                      | 73 ++++++++++++++++++++++++++
 t/t7512-status-help.sh             |  1 +
 wt-status.c                        |  3 ++
 6 files changed, 166 insertions(+), 15 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v14
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v13:

 1:  a524ca6adfa = 1:  a524ca6adfa doc: git-format-patch: describe the option --always
 2:  a3e850bab7d ! 2:  b6a04fc12df am: support --empty=<option> to handle empty patches
     @@ Documentation/git-am.txt: OPTIONS
       
      +--empty=(die|drop|keep)::
      +	By default, or when the option is set to 'die', the command
     -+	errors out on an input e-mail message that lacks a patch. When
     -+	this option is set to 'drop', skip such an e-mail message instead.
     ++	errors out on an input e-mail message lacking a patch
     ++	and stops into the middle of the current am session. When this
     ++	option is set to 'drop', skip such an e-mail message instead.
      +	When this option is set to 'keep', create an empty commit,
      +	recording the contents of the e-mail message as its log.
      +
 3:  08bd397ae7a ! 3:  cbd822d4340 am: support --allow-empty to record specific empty patches
     @@ Documentation/git-am.txt: default.   You can use `--no-utf8` to override this.
       	Defaults to `raw`.
       
      +--allow-empty::
     -+	Record the empty patch as an empty commit with
     ++	After a patch failure on an input e-mail message lacking a patch,
     ++	the user can still record the empty patch as an empty commit with
      +	the contents of the e-mail message as its log.
      +
       DISCUSSION

-- 
gitgitgadget
