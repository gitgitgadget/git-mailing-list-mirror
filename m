Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3951F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 21:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbcIIVjE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 17:39:04 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35171 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbcIIVjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 17:39:03 -0400
Received: by mail-oi0-f49.google.com with SMTP id c192so6943172oih.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sofi.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SbEwMC2XfuRg2ztQO+8F106CI+hyaiNxzsYq732rhgc=;
        b=INl5dqLxhJLmXdrkD8/69LlFxKzj+hxQYoSvUjQDf3xxeZv4prL7yIKxuGxgVOVAIz
         L3ZYuE8AwnAs5UlTWkxokeeUY7XoqQfZHstf0JCDfkDVrgH/QnWKT3p3gunfAv17R9eN
         Ccexr62eqJOSjYLzCiWwBYYUi+beJh6r+/2qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SbEwMC2XfuRg2ztQO+8F106CI+hyaiNxzsYq732rhgc=;
        b=Gr2OtEhuBgvw4BhMKMv9yRieTttgjXmIS8+z9aqtocnhgheqUOI002+1Pfcbdo7NCE
         zpF3zTibWzOubThsoE6mJo8lTnv0DeFaR3IERbQ7ENZ7y7EIaeXLcbdphcpSb5Y9g/sw
         EvM25YZ17J4CftIrcSUDUrjnFkBknEoYrHmmQmiar8a3jkSM95s5cM7lT48XFAD5Cd9f
         tUsjGbywIDRz7/V09Y4+r/UFd/UXJ975ZQWCUrufHqLkroNrcdmIKgNruiicnmE3wYou
         FVIXVTE2OzN1uper5WFkz5LpBxpNWNIJG+BLxS6H8TgXU0qgKhgYIliPMfkojok/FNKs
         mnTw==
X-Gm-Message-State: AE9vXwN2k4SEyEJzFht3tYwR6m3tIXYX0A1OO4u4nIUdoAtAA1RgsgdMM/c4uBkRpS8RAgmrHZ89ogWoqeG+JLe/
X-Received: by 10.157.9.221 with SMTP id 29mr7473866otz.85.1473457142749; Fri,
 09 Sep 2016 14:39:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.107.129 with HTTP; Fri, 9 Sep 2016 14:39:02 -0700 (PDT)
From:   Nathan Williams <nwilliams@sofi.org>
Date:   Fri, 9 Sep 2016 15:39:02 -0600
Message-ID: <CAC5iUd2mS1n1=sRB=Bs6tn3L3raAXrZaEcs765UFtQZB9XZuYg@mail.gmail.com>
Subject: Git Ignore Exception bug
To:     git@vger.kernel.org
Cc:     Eric Severtson <esevertson@sofi.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

it ignore doesn't seem to be working properly when adding exceptions.

Environment:

Mac, running latest El Capitan (10.11.6)

% git --version
git version 2.9.0

-----------cut here-------------
#!/bin/sh
TEMP=mktemp

# Create a temporary repo
mkdir repo
cd repo

git init

echo "foo/*" >> .gitignore
echo "!foo/bar" >> .gitignore
git add .gitignore
git commit -m "Ignore file with exceptions"

# Create the directory structure
mkdir foo
mkdir foo/bar

# Create files to be ignored
touch foo/1
touch foo/2

# Create files that should be identified
touch foo/bar/a
touch foo/bar/b

# Should ignore foo and indicate that all the files in foo/bar are un-committed
git status

# Move back to the regular directory
cd ..
-----------cut here-------------

Expected results
% git st
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        foo/bar/


Nate
