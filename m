Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F6C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 21:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjASVUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 16:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjASVUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 16:20:03 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07A4DBC9
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:13:53 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id h15so1536822ilh.4
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7p4EWJbUcRIqDy7m8qi+9GuV6oEfzh17YKypXupMATE=;
        b=lxcAcqOv0HBohx7VBWVrCWpa65qAB6A17qUFlg36Wf5MQZYWlU4qLqV9UjTqYJI9js
         VUMw83mWVNniMvIxcaifGHVFOSRte52XS9YdwU9y6HR9iKEf4/EV/itVHNGc/1AlMk6L
         9wiJaqBbDu08lXSb7GtJv7K4I34q6vuW9nfJKFxn1XZYbP2y8TofWJjfhL7eo1pimZCq
         BoNlJM6DXzWrpwK0C0C8NoN6VwCHI6QsH+X+PZBeWSgSs2pm6jlMP6iGvFjxoG/YSqD/
         kW0OluSYCyKja8rVwuhg/DorrjTH04WyxnSNP7BUVRpGipQWqXUJUgkVe1J/kIlo9URC
         BWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7p4EWJbUcRIqDy7m8qi+9GuV6oEfzh17YKypXupMATE=;
        b=SWqsdZzHjDV8jTIfn56hqS9EukoLUpMVTPW40IiV/F8r4arKtbjuZXOl7fX/t20etJ
         VAowRdOn3NtywLMsNEefchi8LFZd6BqM+LER7ThuA7Qte1iImTpBnNNRtkXLz15mvXT1
         +cnjH22Az67x8KZ6peASq6iCi3K+VtnaHjgp1Xj+B6Zmq9mGu9JdIWRUax7qtcUakmcc
         ckT9aKOtAqt92F5gLBTEwTGztypKBTWd20pEci3ILi7VpVMMT9fsU33CYY9SobvREV5f
         pmHY7yjq40xFEFO16yXx5yuHA1yfp1OLBqviM64iFSisA+S/AiUMG7xlDUwnz6FSI2CM
         mj+w==
X-Gm-Message-State: AFqh2ko5ba0+t4iCdfybq1vkmpaj/ui3FxnzaakN9w/fbBvD9uARvh1U
        LLDXnDWmz5WQ/JxK5K2eQhSITBP5rsf7Oa39q8H/BrUMSi4=
X-Google-Smtp-Source: AMrXdXuQNPAkuEIql/eN3er3z0ShlqgjsoKVlX++F1H4HK/qjeGTLvhMU7ckNYLgNQpb33W2J/b+sFCd9jdmheHX0oA=
X-Received: by 2002:a05:6e02:4d2:b0:304:ae0d:f3e3 with SMTP id
 f18-20020a056e0204d200b00304ae0df3e3mr1283100ils.269.1674162825745; Thu, 19
 Jan 2023 13:13:45 -0800 (PST)
MIME-Version: 1.0
From:   Arthur Milchior <arthur.milchior@gmail.com>
Date:   Thu, 19 Jan 2023 22:13:35 +0100
Message-ID: <CAEcbrFdE6X6=ppBWmFZrm0Z2RqGqFatjNHdZbGb_RMteCk6P6g@mail.gmail.com>
Subject: Race condition on `git checkout -c`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I was working on code as usual. I should note that the repo is big, so
it=E2=80=99s not unusual for some git operations to take half a minute.

Here is a simpler reproduction that worked on my machine.

```
mkdir g
cd g
git init
git touch a
git add a
git commit -am "a"
git checkout -b b
```

While the last command is being run, in a different terminal, run `git
checkout -b B`

I realized that I can do it manually, by just using cmd-tab, then enter.

Finally, type `git branch`


What did you expect to happen? (Expected behavior)

I expect either:
* to see an error message stating that `b` already exists
* to see `b` and `B` in the list of branch.

In any case, when both branches exists, which will be the case on
system which were started with this "bug", I expect to see both
branches listed.

What happened instead? (Actual behavior)

I was able to successively create both branches.
The branch `b` is not listed. If I check it out, then `git branch`
does not list a single branch as the current branch.

What's different between what you expected and what actually happened?

I expect that `git branch` always list me on a branch, and let me know
of all existing branch.

Anything else you want to add:

First: I can=E2=80=99t reproduce with `git branch b` and `git branch B`, so=
 I
guess either `branch` is faster than `checkout -c`, or something else
is done right there.

I know that this race condition seems very contrived. In real life,
the names were `bookmarkShome` and `bookmarksHome`. Obviously, both
were supposed to be `bookmarksHome`, in camlCase. The first one was a
typo. But that was the one git show, which was confusing.
However, even if the repo is big and checking out a branch can easily
take 30 seconds, I=E2=80=99m still not sure when I=E2=80=99d have two termi=
nals
creating branchs at the same time.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.0.246.g2a6d74b583-goog
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:03:51
PST 2022; root:xnu-8792.61.2~4/RELEASE_ARM64_T6000 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
