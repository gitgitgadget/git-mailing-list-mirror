Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF8AEB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjGURcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjGURcH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:32:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D0719AD
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:32:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so2967159a12.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689960724; x=1690565524;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2YUj4xbLyZPWpEEdOClM5A07wH0jdNC8XxD6nWIfu8=;
        b=GFzyZ0k2UCLeukwjE7/roYberoq7DpW6Ln8puFUvolZgZXjkVNoWqw36svvBggjuvQ
         KxuxQEje+Im0ejcFTog9kYTyRETMZRj10XCkHd6MDIgY1fAI8PlGF0bmtf/aY2y6+wS9
         AZNkClnm9cZT/7XAF6LxtzjK4IEAIYrNgr7G6dYLq1PPgd97ohBTPW1T1Hobauuz3uUz
         VwmZevfQ98LJBskhGdM8NnwdFk/8n8Tf6YZhcTvwsOnHTFlt515qDCUbWTXZJphZ14kv
         K8YpPNr7rjCyNCnMZvlmJUcETNrFg6LbP27RLtVLKXgLUYZI3jhQtwjq/S67AAmLoPj1
         P76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960724; x=1690565524;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2YUj4xbLyZPWpEEdOClM5A07wH0jdNC8XxD6nWIfu8=;
        b=edNKg1/eAMeEtt3zgWlPF2em7WUOWSHPBYz24yT+AFRIwAZJD2KPz1Mp7K7rbyzZDx
         6aZNZgOwNse/C7JKXrQgSp1gkH5lyqoBjdFwD1YTf5ShzuCXyBjljy7Ljx7YgqDbnRoQ
         zW4pEUKVt4+B/C6YWumA3+B8N+Ew1qKEfwpmgjJIyfn1FnGqYN95Vzj1BPrmyriH4tle
         sNjEWsOeFGeElk5tpCwCLQkgYP0jt2p0NcO845axRHT4Nelxm4c/BX0tBYwfLYsOP341
         m0J4q7BLtZndAvb4EBGMu19hHhpt9WayPiXtCUvCfBkTM/xNuglYjDvbzxmpemn385or
         3afQ==
X-Gm-Message-State: ABy/qLZK7WJKAzPlKi+MdYSmnZabNIAhBoojPuqm676SUPyRQEq4vheR
        wSYD0fjGl4HHId2Cr+Hl7HvyZ1iks/gwxA==
X-Google-Smtp-Source: APBJJlHlHGYmXXOu67AYcsj0bZlspnu2aB4V+9bGUc7xbGobaeIhmWSBYqA9p+Qne5TYluH3QP/NKQ==
X-Received: by 2002:a50:ee97:0:b0:51e:5dbe:db88 with SMTP id f23-20020a50ee97000000b0051e5dbedb88mr1990521edr.13.1689960724396;
        Fri, 21 Jul 2023 10:32:04 -0700 (PDT)
Received: from smtpclient.apple (ip4d17765b.dynamic.kabel-deutschland.de. [77.23.118.91])
        by smtp.gmail.com with ESMTPSA id i11-20020aa7c70b000000b0051bfc7763c2sm2340767edq.25.2023.07.21.10.32.03
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 10:32:04 -0700 (PDT)
From:   Till Friebe <friebetill@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Lost files after git stash && git stash pop
Message-Id: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
Date:   Fri, 21 Jul 2023 19:31:53 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.600.7)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
```
git init
mkdir README
touch README/README
git add .
git commit -m "Init project"
echo "Test" > README/README
mv README/README README2
rmdir README
mv README2 README
git stash=20
git stash pop
```

What did you expect to happen? (Expected behavior)
I expected that after the `git stash pop` the README file would be back.

What happened instead? (Actual behavior)
This README with "Test" file was deleted and I lost 5 hours of work.

What's different between what you expected and what actually happened?
The file doesn't exist anymore and I can't recover it.

Anything else you want to add:
This is just a reproducible example.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.2 (Apple Git-143)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.5.0 Darwin Kernel Version 22.5.0: Thu Jun  8 22:22:20 =
PDT 2023; root:xnu-8796.121.3~7/RELEASE_ARM64_T6000 arm64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

