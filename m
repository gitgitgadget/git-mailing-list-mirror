Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B6ECDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 12:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbjJLMim (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 08:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjJLMik (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 08:38:40 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7E8B8
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 05:38:38 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99c3c8adb27so144860866b.1
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 05:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697114317; x=1697719117;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8e8+RYCDE4nOGPRhOJh2lHdSTDX3dr1t93PxjN1T1Q=;
        b=n39VWlxih1KmhxMfstGelziVJIqof1JniR4PLFZiwgoiOqcmNn4JjfV58XxtKIQyqb
         rirD8xZZbsRjMTrNk1Md+f6VCkVagT8p4WWWeRkUtRFk6Owr3iR5QJnL8BRAZ4oBfFMO
         2Dz5kBcjmou1cYpun0tQ0p0x6DdMGaAl+Odh385f4nkrHAwOTKUd/qh7iRjlXlO2ZUN7
         uQBeZqu/3477x7zxUjv9FS1vuma6KS65TD98D7j9lKdVuWgmDZjj3r5orp2XUngoEJ9m
         J+WBpqZOjF1IVHTxJJop2JB6al52T3zfp5WnyHBmITfCbKsMNSvw22/3bG2u5eOQLvsb
         dzzQ==
X-Gm-Message-State: AOJu0YwylLfuWSzc9JuiZiyt/b2VMPgGKy0rJodc0tBuODkSkePpaYPz
        S+EL7+dGTWVkSAA1NzfXA+BRmL7gJKYHCRnI5u6N37N1K8Q=
X-Google-Smtp-Source: AGHT+IFCE6UKSh+VHBBOx5HfKxZOkGbHj5UVwV6nubXy15Utx8DVPuHEzMwNEbWYK8yamV5XsJVkfTiedXfNfxiRJQQ=
X-Received: by 2002:a17:906:220f:b0:9ba:fb9:d334 with SMTP id
 s15-20020a170906220f00b009ba0fb9d334mr13484093ejs.13.1697114316805; Thu, 12
 Oct 2023 05:38:36 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 12 Oct 2023 14:38:00 +0200
Message-ID: <CA+JQ7M_htKUv5=GRQEUqWmJrQmFQNfZkPjr8n12CU6x0Khr4dw@mail.gmail.com>
Subject: Bug: Git grep -f reads the filename relative to the repository root
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

In the Git repository, I ran

    echo tig > pattern-file &&
        echo git > xdiff/pattern-file &&
        cd xdfiff &&
        git grep -f pattern-file

What did you expect to happen? (Expected behavior)

Git grep -f to read the pattern-file, in the xdiff directory and
search for lines matching `git` in the xdiff directory.

What happened instead? (Actual behavior)

Git grep -f reads the filename, relative to the Git root and searches
for lines matching `tig` in the xdiff directory.

What's different between what you expected and what actually happened?

The file that Git grep uses for patterns is read relative to the root
of the Git repository, and not the current directory.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.90.1-microsoft-standard-WSL2 #1 SMP Fri Jan 27
02:56:13 UTC 2023 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash
