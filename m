Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606E8C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 12:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiGWMkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 08:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGWMkc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 08:40:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A0AE0A1
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 05:40:31 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q16so6484442pgq.6
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=m9BOwjf/Z4xaaAgq+HZBEqEdcCk0VHJjisnywtnuvVc=;
        b=Kw+1e+0A+SfbP6jNdFY6CGxxBV2xbzi/Bh6LExvX6lekCJJU69UzQCUKvHY3zUns6H
         tgknbK2bVLLQPVAUFryyxKIyfBy43klzl03ngpyN4gFTlzynrzjgmjzzrSWWaaj9Q998
         +GU6myDYy+UETtNZiqmWpFMTiAYxmLSU0fV7h15b7tA01Er0GBwtQ0QnXrRKo9R1QVU5
         Stkrq+esTyivsNKBaWW9xMo408W4sZvgGtgZlOF6dBfrNuAFGdG2mGLRLUuJj5RFP/E9
         AJSFC9m9rFe9Fa5L/gPso0vvM3N5tC69aWzet9BZIsduGt1sNvfZyA6noN1iBZdOq3UT
         /6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=m9BOwjf/Z4xaaAgq+HZBEqEdcCk0VHJjisnywtnuvVc=;
        b=ltAipaYLKNBSTjh86plBXVz2d+AbxuKArCBzWT0FiH0q/Kx/wGVvr/G2W8S3tC+RPh
         DEJz7JFTmfZjHYiQe3FlLBt3kYApyex0eg4ScSZvSv+OAVvKpfX3F3nqY2NrDeuhuXje
         UpaxU+HGNIZnhDm+gEYfe961iXaL7hR6S5kh8hCSUQRBKS8wqoq8qooL4ZgewP3l72pH
         jzjGolAc663xnw4rxMKUiLyyPWN8QbG2JKmqKh3YOqFPJ2AkIpwu+GSsKlXAxTIyNPHy
         nkCxKxgGCpv/cRBa4Qby+hEs5el4D42tGvmves30S3loGdMghE7/gRDRhYBaNZBaJHnd
         +yaQ==
X-Gm-Message-State: AJIora9anhPMWMoPaRihsIpdp/sqAQTwf1KmKdh++SQBxN7Q5El1SifC
        Kg4qqVJ+jJo9NKLHpzB09ZXVYfUIA8eDhKxTR586mLnQHV0v
X-Google-Smtp-Source: AGRyM1uh0167dyQrIshsDj8jsJAXqyyCIe3rtNgW+g/8tJhAjE4AC9fGFsdUhLwDHWYDVmz8mtwvDNf47aP4ZVVEOQw=
X-Received: by 2002:a05:6a00:1915:b0:52b:17fa:6f33 with SMTP id
 y21-20020a056a00191500b0052b17fa6f33mr4461089pfi.54.1658580030953; Sat, 23
 Jul 2022 05:40:30 -0700 (PDT)
MIME-Version: 1.0
From:   Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Date:   Sat, 23 Jul 2022 15:40:20 +0300
Message-ID: <CAMhVC3acU06uBDAjd5LEiCvuf8=XW_1RYVVt7CdKr-JqB7cRFA@mail.gmail.com>
Subject: Dropbox and "Your local changes to the following files would be
 overwritten by merge"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've started to run into issues with git relatively recently. Let's
take the issue I'm experiencing at the moment. I'm trying to rewrite a
history (git rebase -i some-hash, move 4 commits up, rename the last 2
of them), and it fails to apply the next commit on the todo list after
these 4 (I've redacted the message):

[detached HEAD 1888888] name-3
 Date: Mon May 9 22:41:03 2022 +0300
 1 file changed, 1 insertion(+)
[detached HEAD 00b5555] name-4
 Date: Sat Jul 23 13:19:42 2022 +0300
 1 file changed, 1 insertion(+)
error: Your local changes to the following files would be overwritten by merge:
        some paths
Please commit your changes or stash them before you merge.
Aborting
hint: Could not execute the todo command
hint:
hint:     pick 8222222222222222222222222222222222222222 name-5
hint:
hint: It has been rescheduled; To edit the command before continuing, please
hint: edit the todo list first:
hint:
hint:     git rebase --edit-todo
hint:     git rebase --continue
Could not apply 8222222... name-5

The files it complains about, they're versioned, and they're not
changed when it stops. If I copy the repository (cp -r), and repeat
the steps, it sometimes succeeds, sometimes not. If I were to split it
into smaller steps I believe it would succeed. In other words I got
this message occasionally for no apparent reason. Usually it succeeds
if I simply repeat the steps. Sometimes I need to do it in smaller
steps.

First I thought it's an issue with vim-fugitive, but I can reproduce
it with git alone. The other culprits I can think of are magit (I
believe I used it with this repository), vim, and now that I think
about it... Dropbox? The repository is in a dropbox directory. I
understand that this is uncommon, but a couple of my repositories are
in a dropbox directory and I'd like to put the reasons aside. Can you
suggest what I can do to find the reason it fails? Do you know what
exactly triggers this message (the content changed, modification time,
ctime)?

I'm running Alpine Linux and git-2.36.1.

Regards,
Yuri
