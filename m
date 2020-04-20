Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3391C3A5A0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF0D206D5
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2pZt9vZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDTIDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgDTIDP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 04:03:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D55CC061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:03:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z26so8832541ljz.11
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SLFfPdflAytxUsI05PxWBsHiOGKm9zvh7T8+9FPXMnQ=;
        b=N2pZt9vZYXbWwk8X8R1qpYOkBAw9Blr2ifvVrd4z30BtjNsSWSQu3DwW9YDQmSDLKS
         7tyaTb3t0BDk8xp4Oj5zSfLbYFt9hXjE6I4xLVt8xDbVLiQGUX46zCnen2l3Ut+cKMvl
         DN1HlhXb9DoxBZAZJ6FLoF0vFcKq+CsPxCFxHoRiw77mir5q8RlDvza6BG+YLg9Iuc1k
         HuStW1CbLe4WdZpa0noWQeP6DWe4pBP7KWourHMC0+MTJnHR45qu6pOjubQF0Ge74+wN
         Vr+E0jHqMgZOLPExL+LwyF+KPWJkwan4mwwP9Iddo1sPcePk8YLaHwSkmhOGfnDJPwOF
         Bnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SLFfPdflAytxUsI05PxWBsHiOGKm9zvh7T8+9FPXMnQ=;
        b=ifyB6OlfJqDO8z/c0wFFihLEWEYXoQW7E6+/QIj2J1F8p3XpjLldq76WnjiNAk0nDJ
         47zczS0YfrVPfgW8RW39OZMDqLlk0SOqBiFszQjl3sc/snkD+UjInUtdDo1eAii/ZU72
         dPQNKgSNm6AlK6CygTbv0paAkr7vZ1HKJRmIu0//ZjgaiEcxzdeNJTyTUpZO9DIehJiu
         X0ppV2cBb9LGCF7nrVYreeGxPtfeqkOJx3pTZ+jbbUSE474vjIfEFR1O8C+KIt+f8pqO
         B16ItRHWYScVaZR2SyPyZlhzE2LPhERBz6DRSzb19KaiYlj6Kf6A0A+Gna5DHE1pZYlw
         JudA==
X-Gm-Message-State: AGi0PuaVoXTVa0YYXeu0fs26s7OEPVQoEkFheKrSPeL8+RvMJd6aHSbR
        gcJ3alksHvyDpadVudWujqnI+Xi69cVv+QDhEeN94HyN
X-Google-Smtp-Source: APiQypJX3q3a43ddxyOLoU6ncv0KCG1PXBEM28Dmm0weR1YgtVym+nzc8qgPN33RPDRnSK4vtOGtm0CC+XIsajIIAqY=
X-Received: by 2002:a2e:9186:: with SMTP id f6mr8477797ljg.85.1587369791647;
 Mon, 20 Apr 2020 01:03:11 -0700 (PDT)
MIME-Version: 1.0
From:   Jakub Horodecki <jakub.horodecki@gmail.com>
Date:   Mon, 20 Apr 2020 10:03:00 +0200
Message-ID: <CAGdVfV2JhBp1_3iBWg_3gm5zDPwGizQxiK5QXJSRbDkN4Si4Lw@mail.gmail.com>
Subject: ls-files -o -i --directory omits files/directories
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I found a case for git ls-files I suspect might be a bug. For the
following example repository structure:

.
|--   InnerDir
|     |--   excluded.txt
|--   file1.txt
|--   .gitignore

and the .gitignore content:
InnerDir/*

the command

git ls-files -oi --exclude-standard --directory

returns no results, that is neither "InnerDir/" directory nor
"InnerDir/excluded.txt" file. I would expect one of the entries since
at the moment information about the file is missing completely in the
listing. Both executing the command without --directory flag and
adding "InnerDir" to .gitignore produce some output from the command.

So the command returns no results for --others excluded files if
--directory flag is specified and all files in a directory are ignored
(but directory itself is not). Is this actually a bug or I
misunderstood something?

I tested it on latest release of Git for Windows (2.26.1.windows.1, x64).

Best Regards
Jakub Horodecki
