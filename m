Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4165C433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 07:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377685AbiEMHKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377683AbiEMHKg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 03:10:36 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4207F2A8042
        for <git@vger.kernel.org>; Fri, 13 May 2022 00:10:34 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i22so5148061ila.1
        for <git@vger.kernel.org>; Fri, 13 May 2022 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=7xtJ+kzQm8yx/VCkuyiQ19ODDpWz7aayUrhjAyW/72Q=;
        b=q3yV/bcDEARuDPTvqygykNNVE9P6kOmdrzCi8WkprXoW1oLH1H3hTV8Rdxa3/hY7Vo
         13QFqmWywFemiAH0X/3EA7NHkjOHzhDBjIRnmMts4flMFWU0tAiNjkjhdIHjilPZfvIc
         kS7IrGt5eou3+qdK4J6mkt69KynA21fVaPa+OUFWVzvE9aue9oDeCe/cvnGvoe+emyos
         FdqKWO2mtOuGXY1HEAzVN2wR+lM7fxa4zgxzHExZEJAtmVJ92R4Mh0C0p6ATj9pKsZ5f
         A6CeEgqe7LW8bQItZ2pTzowkndWX0OOTZAqsVcu6KyR5ziHsHP/T3D10C4p8uWFj4iJq
         HohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7xtJ+kzQm8yx/VCkuyiQ19ODDpWz7aayUrhjAyW/72Q=;
        b=v6u6ODo5qH9QDLMDVY6B4nh5fAI/quc5Mj8UZWWmTxVqHJYsb2kMS9xI1LzjMeRK6L
         n8HPOZX+iden4+zZsAAsGTRcwHzf87SbpT3CDXtTnw0HRksH36cctf9ymiqCoWIRqpEp
         mTzG7e4xI4ZfPPTyANmRu7WADils0SRV8Zyje9TQTlUsM6EDOJv/BzIazylPODdtJevG
         TjyxPQtbmB1TuvqjtMkAIn6jQZmyUJnodXn6nOkUNwYa6JAOFxGHcjIwgbnpYWDv/vyw
         ZgaThBtQ2RjfughOVWv2pOjmBx+SFg1EkEkbkN7E30+ZlLji2txY7dFdMfdg7h8YkOpc
         XEJg==
X-Gm-Message-State: AOAM533pQIdswu5b2P+0jh7prSyPcKQ/3rzUsykKtO0MIdxbR80TsRjt
        ERvDdY2yqbrAhZuKJ7Z0h8CPXZnw8n6xP4iEgGIo2oFzLdM=
X-Google-Smtp-Source: ABdhPJwdNmjaOpGFsl4GxCY3VJNFk73lbpGRqyJKf2gkjQr6I2NCxJBwNmQypiAaYqn/VXLBqLQ2a6T3rP+NXjzuwII=
X-Received: by 2002:a92:cac3:0:b0:2c9:a265:4cab with SMTP id
 m3-20020a92cac3000000b002c9a2654cabmr1797902ilq.241.1652425833410; Fri, 13
 May 2022 00:10:33 -0700 (PDT)
MIME-Version: 1.0
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Fri, 13 May 2022 10:10:22 +0300
Message-ID: <CAGHpTBJDb4rv1EVvR7J9MNEgf0QnFscaf6rWG4_nOW-JnuO9FQ@mail.gmail.com>
Subject: Failure when adding a tracked file in an ignored directory
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have an untracked directory, but inside this directory I have some
files that I do want to track. I added these particular files with git
add -f, and committed them successfully.

The problem is that every time I update any of these files, I must use
git add -f, although the files are already tracked.

Example:
$ git init
$ mkdir foo
$ touch foo/bar
$ git add foo/bar
$ echo /foo > .gitignore
$ git add foo/bar
The following paths are ignored by one of your .gitignore files:
foo
hint: Use -f if you really want to add them.
hint: Turn this message off by running
hint: "git config advice.addIgnoredFile false"

Is this intentional? I think it should only warn and fail for *newly
added* files, but succeed silently for tracked files.

- Orgad
