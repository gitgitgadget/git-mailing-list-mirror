Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADF2C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 06:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiEWGMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 02:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiEWGMr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 02:12:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B343CA74
        for <git@vger.kernel.org>; Sun, 22 May 2022 23:12:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h5so18610952wrb.11
        for <git@vger.kernel.org>; Sun, 22 May 2022 23:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3UcEGHIPtAv+QKsS1Iv/Pid2bq4nRvTzdf15Lhpz05Q=;
        b=YfRhpBnILA5JNzXamVrJ1p924vmwnkgMljP+o5yAebBu5ZnSOw41Vw6qwmAxj31tmD
         C234Ky3OJPfAwo7R2muql0PUKRM6+ec+V6YhbI20ePCR1IBcQ0b8SFrOvUGBfKEezhl9
         nFqoUEX7PAa22+T72V06KYaqVJdiuSfG7IRjFYKHOGO7KJlPci/oZ6DuB2BMpGdJVuAp
         YzL//aIYer9w0cb8VctHYNXQYNA+fscJSw4Xl56/shNuiXY7cMfF16i0OuBZIrqQ0VHJ
         BIyOOcN15VrnDH/SJdw/rr9lM+h6OPFE6JDn2Yq4obfvermjgdWCygiMSgShfjN5oeMj
         WAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3UcEGHIPtAv+QKsS1Iv/Pid2bq4nRvTzdf15Lhpz05Q=;
        b=lO3UeKIVc8hXJcaZPDHi7ah52RDzhvAPGEYqxkQeZ022y/Zj0To+YgcjPDkA8LCIgk
         fXwzDux90wJ91rQowH4ueG04VdU1TsOJVxrauXJamrIcZ9gBy81XmFK90wEruVUbDG/B
         +/0X4wrv8W/NggWIugVzWKP61NI4B3o7ag9J/kxCmsVmcV41BMY6Tav1jMg17Av/j0Vk
         wlNYaO5Bfnz/+8GLPZz3ZvxRG2d921Oz+8KeHVLlH2LIg435v6EZ/4bbzFgpwf0mspPz
         7XBoMIXPzR4tw23RDhI9gVKJpad6COsmOl4GVjptfF/A9xDTuJKxZTdtFYcgAsulLGNl
         DXXg==
X-Gm-Message-State: AOAM531H+qAw+XRv7YDr3jUsXFYzvdfSg0ziLmDF7OubI6XJA9rMfD2c
        P2KMS5XBqIbir1IpaZspUL8a5M57rUA=
X-Google-Smtp-Source: ABdhPJy+X7qwrX8xWe5SEtma6cVQ9dxUjDkNApKcqhaGrS5EkEUf+ESqxQzBW5BE4ZR05jUbI6923g==
X-Received: by 2002:adf:fb0d:0:b0:20d:97e:17ce with SMTP id c13-20020adffb0d000000b0020d097e17cemr17971893wrr.585.1653286346819;
        Sun, 22 May 2022 23:12:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d10-20020adfc80a000000b0020fded972c0sm2374384wrh.45.2022.05.22.23.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:12:26 -0700 (PDT)
Message-Id: <pull.1232.v2.git.1653286345.gitgitgadget@gmail.com>
In-Reply-To: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
References: <pull.1232.git.1652649537647.gitgitgadget@gmail.com>
From:   "Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 06:12:23 +0000
Subject: [PATCH v2 0/2] stash clear: added safety flag for stash clear subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nadav Goldstein <nadav.goldstein96@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PLAN: Add a flag to git stash clear (-i|--interactive), which prompts the
user to confirm he indeed wants to clear the stash, otherwise it will abort.

I found it useful as a frequent stash clear user which means my terminal
always have it in recent commands, which could mean accidental erase of
work. This flag ensures accidental fires won't clear hard work :)

I also thought it would be better to do it opt in, to not change the way the
command works in prod, only add to it.

Changes since v1:

Removed temporarily the interactive flag from stash. introduced add-menu lib
to the project, which is simply the extracted code that responsible for
presenting the menu in the clean command, and made the clean command use it.

This change was made to allow stash to use interactive as well, with the
same style as git clean.

Before I continue the development, I would like to know what the community
think about this refactor.

Thanks!

Nadav Goldstein (2):
  add-menu: added add-menu to lib objects
  clean: refector to the interactive part of clean

 Makefile        |   1 +
 add-menu.c      | 353 +++++++++++++++++++++++++++++++++++++++++
 add-menu.h      |  55 +++++++
 builtin/clean.c | 413 ++----------------------------------------------
 4 files changed, 425 insertions(+), 397 deletions(-)
 create mode 100644 add-menu.c
 create mode 100644 add-menu.h


base-commit: e8005e4871f130c4e402ddca2032c111252f070a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1232%2Fnadav96%2Fclear-stash-prompt-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1232/nadav96/clear-stash-prompt-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1232

Range-diff vs v1:

 1:  5396a67b0ff < -:  ----------- stash: added safety flag for stash clear subcommand
 -:  ----------- > 1:  13bc75a2b05 add-menu: added add-menu to lib objects
 -:  ----------- > 2:  7271a285d18 clean: refector to the interactive part of clean

-- 
gitgitgadget
