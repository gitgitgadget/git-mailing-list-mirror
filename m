Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A810CC43217
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 08:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJLIaF convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 12 Oct 2022 04:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJLI37 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 04:29:59 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CC420353
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 01:29:58 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id z3so22479641edc.10
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 01:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSNRRZdjFukZBnWocSphjMmnHupHEg/pry6Bm6Q9T6g=;
        b=n2te5r5wOkPCjro1lcqIx7dVDkjxcsZqdZbSB92cvClDGkwBm5/sna9cJ6VXM/BQDP
         cYEcTd6l9MR4fW0Zb9HRqhmHyB8jaD1hKCUEmFI5cgH7H+82bUBS1lsweIxim82Tl+j6
         LABmwLJCJ+nYdh4ubNYDL7hGDPanGtXO0wlPryTdxyiRhLkHI+epIk5pLHkAPjiIcvB0
         tNw7ScBWld+zi7AnRh0gu7HgNpamkavbu5cWX4TngVRZbIIthGnu2pQDc2yGkpe1m2RL
         yHqkUKp9xEKZLV5pZnX1xqa5YHPNrpWgE0+kkV9JFqklHx3sUMQreleq0UKhBDH+XkpI
         Rmsw==
X-Gm-Message-State: ACrzQf2Z6sH8wHsmce8XUjgwMrf5QmpCWrQ3Mpd07U2M/RBp450yyfu0
        TcoWUwAogD1vnoBBgGo4jdp+ddCRCDUbWnls3lQwM7JHwkI=
X-Google-Smtp-Source: AMsMyM7TCE5h7TF4l6DDx30FQmKEdZ0ENp2uFioj5unJ5wfNstTEup+GNzAGspEQU3KV8Lkjh9U1teMIfbzHon+T08o=
X-Received: by 2002:a05:6402:42c3:b0:459:cebb:8d3a with SMTP id
 i3-20020a05640242c300b00459cebb8d3amr26974874edc.421.1665563396748; Wed, 12
 Oct 2022 01:29:56 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 12 Oct 2022 10:29:20 +0200
Message-ID: <CA+JQ7M-CN0UnHQDDDVz0kPcU1AcoL9+WFOeR8eiw_B=Yiyc-CA@mail.gmail.com>
Subject: [BUG] git fetch fetches tags matching negative refspec
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Delete all v2.9.* tags
  git tag | grep ^v2.9.* | xargs git tag -d

Change standard the standard fetch configuration
[remote "origin"]
    url = git@github.com:git/git.git
    fetch = +refs/heads/*:refs/remotes/origin/*

By adding a negative respec for tags matching v2.9.*
[remote "origin"]
    url = git@github.com:git/git.git
    fetch = +refs/heads/*:refs/remotes/origin/*
    fetch = ^refs/tags/v2.9.*

run
  git fetch

What did you expect to happen? (Expected behavior)

To exclude tags matchings v2.9*, just like when running git fetch --tags

What happened instead? (Actual behavior)

Without specifying git fetch --tags, tags matching the negative
refspec are still fetched

What's different between what you expected and what actually happened?

The negative refspec appears to be ignored or overruled when running
git fetch without the --tags flag

Anything else you want to add:
I love git, thank you! ♥

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.38.0.windows.1
cpu: x86_64
built from commit: 0355083fbe5582f6d3f819afc130ed2f2375e0bd
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Users\erik\Git\usr\bin\bash.exe


[Enabled Hooks]
