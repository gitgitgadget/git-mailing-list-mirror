Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50302C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEBE6120D
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhEJPgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhEJPgC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:36:02 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8DBC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v5so21322445ljg.12
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmDePphqS4bI1x9Scxn8yj2ZgNti6mWWhWF260/tRG0=;
        b=E9HitAjNv3pQcXoiUDw540bOyyh1UhC4yNUcvJxHvXP49ujJB+qIJS62H2z2NbCuI1
         QultRgXOAzngqO3+Ad7qOFigKTSD8fg8DrKO3J28o/x+PUQstpiC7T8jRPdAY9TEGRfz
         myxF7TBSyP6oZVPH0AIcgCXSyYxHEitWN6c8AY+HlrYxp7dv7vCcBAcY+y4OeeDnRmGT
         RH7tgzPeeWuPYD3S+cquOzOlg5lP+f5hPspIsdj9HxbXqHUStdPHZj1g4SPNtRtxzyUF
         E/utVfClxlLRcYFYupDI3sM071+UDvO63Ju3HQ1OxKxxKJup3QNvnawknf02DSVhgpTT
         Wf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmDePphqS4bI1x9Scxn8yj2ZgNti6mWWhWF260/tRG0=;
        b=YJ8wUEYBpahTwyTOwohlBD3StECRvGnIlnFwdx5rhINqIKsOHTBvcX4uT8SH4XpmrH
         aez8v//LaH9mBCpbB97Th6FSTrASEd0FI5hnwdCfgQeXzITrbpmexEmb4yVnAp+imVkn
         JMLnozmmAs+MaN9ogpZH+UPg6uuigFIa0MDyjdvy+IZQJFJD6d4lSwEmoY153vlEOa04
         7EJulw2GC1NxRMTOOAlW1WoxWxZFjP8eDQEabt/Iubgm5jeEZ7fAb1kED5wAXRYjmeob
         2Bz33lRbMoZRdpc3uoIWtk4Y1gJ4RUllHlJQH5OhlGJgd+16p2H/yRKOKeYARf3YUdvW
         hgsw==
X-Gm-Message-State: AOAM531kAyaO3KTVgjxy6zp6BJ36RsO5iDG5oV9hKOopB/EJpRNrGnB/
        QuupPJYj7vb1vKROcnuxzYs=
X-Google-Smtp-Source: ABdhPJwDjw4NznsjPADJt3w/kZZ+xUGW/wp3y4IV0/r1c9eGbOicIjs+y27bi929UxKHPbKP+nRVbw==
X-Received: by 2002:a05:651c:487:: with SMTP id s7mr15648853ljc.351.1620660894652;
        Mon, 10 May 2021 08:34:54 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p8sm1525840lfe.224.2021.05.10.08.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:34:54 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 0/6] diff-merges: let -m imply -p
Date:   Mon, 10 May 2021 18:34:45 +0300
Message-Id: <20210510153451.15090-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix long standing inconsistency between -c/--cc that do imply -p, on
one side, and -m that did not imply -p, on the other side.

After these patches

  git log -m

will start to produce diffs without need to provide -p as well, that
improves both consistency and usability. It gets even more useful if
one sets "log.diffMerges" configuration variable to "first-parent" to
force -m produce usual diff with respect to first parent only.

Previous semantics of -m could still be accessed using
--diff-merges=separate option.

First 5 patches in the series are refactoring that is not expected to
change existing behavior, and the last one is the actual functional
change.

Sergey Organov (6):
  t4013: add test for "git diff-index -m"
  diff-merges: move specific diff-index "-m" handling to diff-index
  git-svn: stop passing "-m" to "git rev-list"
  stash list: stop passing "-m" to "git list"
  diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
  diff-merges: let -m imply -p

 Documentation/diff-options.txt |  8 +++---
 builtin/diff-index.c           | 45 ++++++++++++++++++++++++++--------
 builtin/stash.c                |  2 +-
 diff-merges.c                  | 24 ++++++------------
 perl/Git/SVN.pm                |  2 +-
 revision.h                     |  2 +-
 t/t3903-stash.sh               |  2 +-
 t/t4013-diff-various.sh        | 13 ++++++++++
 8 files changed, 63 insertions(+), 35 deletions(-)

-- 
2.25.1

