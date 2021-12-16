Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5248FC433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 19:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhLPTKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 14:10:00 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:35378 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhLPTKA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 14:10:00 -0500
Received: by mail-io1-f41.google.com with SMTP id 14so36417352ioe.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 11:10:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xex0e40866xLB4e/U1qL+wL0h959smpAtRggJRdxTxo=;
        b=fmJvwRclbjSHubnVgTvjGenmC13pltHVzLwJQ5wMhY707RF+/obnfQxQjt3NiE8cob
         NZ1isL8VYKRF2krhWVv0eWrx6vrcWUDqExWe/WX8O1Gm2gBcIDCy8as3zWQBa59Fqw8z
         IfM4+Xj9C1QvM7AH77nHrcB37ANB/ZwKozUjJG2zSQRujpGMt9n4VGD9IzZwGwT9bBsC
         2YouVDoEpoPtTig6gRXxdsSUimm4tSSnZoW0YIJizCkecSzI8hittYRn+15BP25A2v7V
         YEqBJ8I4tS8iCt8c1GdOibMU0/nEhm9fZpxmdU2oUuK75PfGKJP72YPmTXQ12C8teneK
         IN4w==
X-Gm-Message-State: AOAM533tSeCoSXmOwm+9neUYQPOCAGH5ZgLYglfk8aimphw6MfkO1RwQ
        fEEUkBnwAVBCcmsC4cVLP267S7zUHzcy+5q8wb1FqOh4GhM=
X-Google-Smtp-Source: ABdhPJyzo1R+USzn3X4HkN5la+hL+NgUxrLZ0hVNQvRzK+V3FxvjhFmRFl4VFeBQti4N0sm7aefZ2xjor9xdpcBzKO0=
X-Received: by 2002:a05:6638:381b:: with SMTP id i27mr10818721jav.138.1639681799729;
 Thu, 16 Dec 2021 11:09:59 -0800 (PST)
MIME-Version: 1.0
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 16 Dec 2021 20:09:24 +0100
Message-ID: <CA+JQ7M_Q2bgHWt_SFWdMCHkqqJr2K2VEqDfK4en_eXhs0o5JgQ@mail.gmail.com>
Subject: bug: git-add --patch any negative pathspec fails
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce:
git-add -p -- ':!foo'

Expected:
Add everything that doesn't match the pathspec.

Actual:
fatal: empty string is not a valid pathspec. please use . instead if
you meant to match all paths
Cannot close git diff-index --cached --numstat --summary HEAD --
:(exclude,prefix:0)bar  () at C:/Program
Files/Git/mingw64/libexec/git-core\git-add--interactive line 242.

Relevant trace:
19:44:00.359141 run-command.c:667       trace: run_command: git
add--interactive --patch -- ':(exclude,prefix:0)bar' ''
Note the added empty string pathspec

Affects:
git version 2.31.1.windows.1
