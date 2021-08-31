Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFC5C4320E
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F16661090
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 17:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbhHaRQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 13:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhHaRQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 13:16:25 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362D6C061760
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 10:15:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s32so91852qtc.12
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mRWcUKqj+2xQZ95+uenAYh1mQndUxWEfmnQ/zsMsP3E=;
        b=EKpPevfTUcfAgNkoa2wXpJ4tiChd1qPkonZMfGAlMTR5veetOVKhYJR6r4ElL3FDcz
         4Bkydf5nDV7xF5iRi3g5mRsXeh46qtUijvPgBeFcH/N6zcaSDLAeGbm7S6edDospef+m
         X9hqnNNkTHbzrgNRMJMI3susu1/bA+8XrJdes7xhk9lT5yRrzjbNm8ShcXiQNMJ27tIz
         6s6ers4HDdQGnWPI3xJDqFns5XduoYuZRVIYbdmlwqVmtmiBd8f2cHgffRJoRzlK3jkh
         lDnqTikkX+CJUwkq4s1FEveUqbQoQXM8WqMC0z/W3OgBlbX2te72gXofcZp2ETxE6gEg
         yh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mRWcUKqj+2xQZ95+uenAYh1mQndUxWEfmnQ/zsMsP3E=;
        b=qsJ7rBnTn+rcs7bfpdUOCZ7/o+CvvKMtUtwvUenvQ2AwSwHhzaokaEETD+psZ0nhWD
         rBua/Wec1HSPA3ETvMCJip08Egobxlia8t0oxvFuwmLtvN2rNOujX5dOzGMcQACMo1VI
         YcmybK+HMpO4oWZyuLQznXI9H6nma7b8pXXOqyvzScVKBsCj26uYaOTQm6l9o/jDVOCB
         2nuVtGTPa4fCTgzaYfmY65ah0NQHrF2d5PNrSgEU7CJiwtdBwUzxMcXGCgR1RO4f3n/P
         6/glLs96cQHL/TFExM1CCIcumeGpdVPn0rlMKsPbyFZgysq/u6o+gbHedeA6ZfXUEl/p
         2l1g==
X-Gm-Message-State: AOAM532tMVwi7IEa9QCasqwepP88uLqgRuSkW816WAsw88FymDDdwy8O
        06Ih4V9CNgA3zYI01MNvOBdROhJ04Sb0+bc3eP5OqDB3U0M=
X-Google-Smtp-Source: ABdhPJwVOYD1p37iXMJIOo4GD0yzQTqGGhJUJ4Nr8DMOUxjQTVHVAVcgrsd9FMaEUBUFprdMwcQC1WLAWRqOIMJHWiE=
X-Received: by 2002:ac8:729a:: with SMTP id v26mr3800211qto.79.1630430129280;
 Tue, 31 Aug 2021 10:15:29 -0700 (PDT)
MIME-Version: 1.0
From:   Andrew Thorp <andrew.thorp.dev@gmail.com>
Date:   Tue, 31 Aug 2021 13:15:18 -0400
Message-ID: <CAHBARKezrkKAs0ACbJ_fnxR-qWacQ5KKuVLwn0WyT7aR+4++pQ@mail.gmail.com>
Subject: BUG: `git commit` adding unstaged chunks of files to commits on 2.33.0
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

As described in the subject line, it seems like git commit is
committing entire files when chunks of the files are staged using `git
add -p`, in spite of leaving chunks out of the stage. See below for
the bug-report template questionnaire. Please let me know if there is
anything I can do to help resolve this issue or if there is anything
needed.

Thanks,

Andrew Thorp


> What did you do before the bug happened? (Steps to reproduce your issue)

Edit a checked-in file, adding multiple chunks of lines to the file.
Using `git add -p <file>`, stage one of the chunks, leave some chunks unstaged.
After running `git status` the file should both in the section
`Changes to be committed:` and `Changes not staged for commit`.
Commit the changes.

> What did you expect to happen? (Expected behavior)

I expected all staged changes to be committed and unstaged changes to
remain unstaged.

> What happened instead? (Actual behavior)

The entire file was committed, including the unstaged chunks of changes.

> What's different between what you expected and what actually happened?

It appears as though the remaining file lines were both checked in and
committed, when only the later should have happened.

[System Info]
git version:
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Darwin 20.4.0 Darwin Kernel Version 20.4.0: Thu Apr 22 21:46:47
PDT 2021; root:xnu-7195.101.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 12.0.5 (clang-1205.0.22.9)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh
