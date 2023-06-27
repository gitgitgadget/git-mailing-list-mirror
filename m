Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD56EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjF0OmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjF0Ol7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:41:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D5273C
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fba9daf043so4078505e9.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876887; x=1690468887;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MlGAnZFKlXplxdIydgbw+70z5rmMP1rd1NLGnlx7/5U=;
        b=T07U9NARLlRV3lzrMN35El+m7KSueI60YwWE5MvEoLRVyRIMTRyoRl6vutoXG2Y0It
         s2btQBcN4bWj2Y0AhlggwFNhM9kjouTEMuEhP8lj1T6BAELOIoFceMm0AvhhuXR+61Wb
         VlOGeKI9mf+P5iwe4V+lZPbTeZNKL4zINQ70de8Bnxte/80Y8vKJd6aNxmCGzCO5pusV
         tYKyQbTCvz0dCY1T6fSvWuLMRPh8DGMFx3m1IjFIQ7XtStlQuO1BawNycsBw+QVGV5dN
         54MsigHtYJjgvD0mIbMjrdZ7DMVPANBgBkwwiXCvpfK22v0Ch7T0scHHDeYRY9rXgiOA
         h/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876887; x=1690468887;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlGAnZFKlXplxdIydgbw+70z5rmMP1rd1NLGnlx7/5U=;
        b=Fxab8yxlvImysFo6/hlcOXBn12QKsu1DwtkSXsL25Afh57JC63Yed1V/a2+no5pPgd
         dNz51lCSH/5nOZba2d9Nnyr7MoYrsMjbejwwtTm3yLu5S3ezSuVl8mQrmKfQC9z1oIj/
         nn/HPGrzncVfmVXtfGP1duaZdSZC6JhhKXh2skxK76xOnFA4Ywzu5UWfN3tE6iyHckDb
         0SKswcttEB/7as0MZrWg+E8inUYc+XS7wmnAl0mNSvwV77uUvWHTQ0cA7slD9nPE+TaK
         DqEY5fVGU9fHM6qqlfKh+xdI6DZDQJzykyvfLU6q3MlOk112O6XOa5ASoU2KmQSHCWQq
         9qfQ==
X-Gm-Message-State: AC+VfDwREFiOBA0GXsqNr/+q8enmnhq06btDpliLbMGpVlf6fr0gYYDl
        g/mAWxLG3PYEj+RWjwqsoiSBsXoflkw=
X-Google-Smtp-Source: ACHHUZ5i/c977Kz2V8KCnI2aoaMj3B2ARLL60EMIogbEsZvc85lbOnWMu0Eu6liesu/94TG0/fTZ0g==
X-Received: by 2002:a7b:c045:0:b0:3f7:948f:5f17 with SMTP id u5-20020a7bc045000000b003f7948f5f17mr26720828wmc.7.1687876886972;
        Tue, 27 Jun 2023 07:41:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12-20020a7bc3cc000000b003f604793989sm13631276wmj.18.2023.06.27.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:26 -0700 (PDT)
Message-Id: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:15 +0000
Subject: [PATCH 0/9] gitk: improve keyboard support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is often convenient to use the keyboard to navigate the gitk GUI and
there are keyboard shortcut bindings for many operations such as searching
and scrolling. There is however no keyboard binding for the most common
operations on branches and commits: Check out, reset, cherry-pick, create
and delete branches.

This PR adds keyboard bindings for these 5 commands. It also adjusts some
GUI focus defaults to simplify keyboard navigation.

Some refactoring of the command implementation has been necessary.
Originally the commands was using the mouse context menu to get info about
the head and commit to act on. When using keyboard binds this information
isn't available so instead the row that is selected in the GUI is used. By
adding procedures for doing this the PR lays the groundwork for more similar
keyboard binds in the future.

I'm including Paul Mackerras because he seems to be the maintainer of gitk.
Can you review, Paul?

Jens Lidestrom (9):
  gitk: add procedures to get commit info from selected row
  gitk: use term "current branch" in gui
  gitk: add keyboard bind for reset
  gitk: show branch name in reset dialog
  gitk: add keyboard bind for checkout
  gitk: add keyboard bind for create and remove branch
  gitk: add keyboard bind to cherry-pick
  gitk: focus ok button in reset dialog
  gitk: default select reset hard in dialog

 gitk-git/gitk | 132 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 96 insertions(+), 36 deletions(-)


base-commit: 94486b6763c29144c60932829a65fec0597e17b3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1551%2Fjensli%2Fkeyboard-for-gitk-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1551/jensli/keyboard-for-gitk-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1551
-- 
gitgitgadget
