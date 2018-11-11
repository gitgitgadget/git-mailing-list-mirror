Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04DF51F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 13:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeKKXGg (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 18:06:36 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41350 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeKKXGg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 18:06:36 -0500
Received: by mail-vs1-f68.google.com with SMTP id t17so3616486vsc.8
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 05:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6gUpwQgPo73C4z0d8zDQczCQbbR6aTClZ0T7I6rz1Jg=;
        b=YiauiVyfBNSnAKXdDg2a4svbaC3+yTJD2LX3+CYTwrPsRSUV+LZmhq4Y4s3xST563D
         80fdSb6ltQxtJyD2jb21yCCLiaN9uQzbYIrMmDrn2N6CfUFsJ/AuVeX2jGntmsCouWvb
         azGYydsBGlYa9xI51TuNg3mEZQBDjr+pGEhs8PQ3nCciPlHwJWcZedIQ3PjgmkfZrBUu
         dKHRuOmmTnY25r8OUjBC4qj+DZ7hC0FTdADpOVCMl403ecQYfLSX4lCeLMd7XFXC+imx
         OE8cms5Fq9s93BBs3O10WS/lM8iYJf5QYQEKn5ARk1jiVkmI3CxHwOq8tzrTotLzkK9C
         HcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6gUpwQgPo73C4z0d8zDQczCQbbR6aTClZ0T7I6rz1Jg=;
        b=sFSv3KWJ0dDw5t9DW70zfkhwO3SE4gZ2Bw2CFtgnVa4cLje0VquEABsT6nqK/MnMBQ
         Cmbf9Vu2zZe80e2KZUDa7tVI7/fukXPgLJ+x/ouqY5A9SAhLX9SFyG8+rM89HvQYi/A3
         9E8iUNlM1o1OtmbyNg10RPWytwsxjzppJRd/I/onsWMwLpnKyOYlpayjBeWKLcol800P
         Pdj6qEvDGKs5bHdxS682ZAC+LyyzOa9nBxfXcNwbevO6N39qPeVtRRHOQ+ymlChWLgSm
         S95UAKlnTMsZD5QGBKFM0oN/bpXZTjwa0vv9u/ChPJbAa2d7wL9O9ISJj8akCxVBgaBu
         H+6g==
X-Gm-Message-State: AGRZ1gK+SdzJnmu4uPrJBLWaLhuEe3yo4u5ZV+OZ/LMriZmKCWoytSlw
        0UrWAW0iKSFIT5EbjRophddxPRuZin9sDAak94imGMvX
X-Google-Smtp-Source: AJdET5cBHk+V7nZzqhjIB+efm1sazAW28oKLrkWtV0BTfpGjh9+ElTRVEauzbxCwzZwaO5ND1p7QOnNaElnH8d2FbDY=
X-Received: by 2002:a67:8d08:: with SMTP id p8mr3291217vsd.147.1541942281830;
 Sun, 11 Nov 2018 05:18:01 -0800 (PST)
MIME-Version: 1.0
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sun, 11 Nov 2018 15:17:50 +0200
Message-ID: <CAGHpTB+fQccqR8SF2_dS3itboKd79238KCFRe4-3PZz6bpr3iQ@mail.gmail.com>
Subject: grep issues
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I found 2 bugs in grep, using Git for Windows 2.19.1 (but noticed
these several versions ago):

1. git grep --recursive on a worktree (without rev) always matches
against the submodule's HEAD, not its worktree, as it should.
2. When core.autocrlf (or eol=crlf) is used, and a file in the
worktree has CRLF, git grep fails to match $ against EOL.

For example:
git init
echo 'file eol=crlf' > .gitattributes
echo ABCD > file
git add file
git commit -m 'CRLF'
rm file
git checkout -f file
git grep 'D$' file # Nothing
git grep 'D$' HEAD -- file # Found!

- Orgad
