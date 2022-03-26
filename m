Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BDCC433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 09:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiCZJ1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiCZJ1T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 05:27:19 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5F04B841
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 02:25:41 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id b130so6915567pga.13
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 02:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=nd1JXNuNyecBOqzLWt7HGmVGYqNh6XgRz+i/2OjmJe0=;
        b=Y6qo7jWMPLgcYKojKPGGxGG8dlp4xTz0DDEhAY+A4MmKe5CeEhsD6NW1OMUghlx1h8
         rAnoJPflIpJ9Uk3Lug6j8NjQwtnaaQi2kwILEx1/aIbsZcVAvO6BLqNng0MX22GtjEB/
         0LFwWtBoemp+WtlH0/CkZcuoAA7ZL0By85hCsl5w5JEw3go/xvj4vguNFvIxX2k8issY
         4KxgjRFKngtaX+PZ3iBWFkEbtRncdZgJ/txUvldXpp6mrfs/3dLmBXO5Wz6+4Y1AGeSG
         nXjXHI6t0CZbZTY6mxCeGg2suLNxpu71qgBuFnBu0mCJNwy//MLZsJz25jPdg/4d+UeL
         NVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nd1JXNuNyecBOqzLWt7HGmVGYqNh6XgRz+i/2OjmJe0=;
        b=wdEDvR56HztGWPGkmi6Ep+yZwJTf5e/OFDmwSDWHwR3wCPY+5p2qRLdBlLM5snQyLO
         oip6uk+anPLNo1rTcSK23FqxTfmqSZNUP8ezCJUsnONC3t3Ui2eYfm979UVgw5j2arAB
         Kji9BEkA8+XBjzA7KZEaYPhgV/efwY2lwWoYVU1ESgBTBRiKo48HeFcsUO0h+dhTGIBw
         NIBGZ9HZXp/ymGwauA4VqnkLrtPK1Rlel8ELTPEfKwxtM4XJIbObnbkxdd55P+wgeqTp
         Slq8W/M8m8S9UiIVZ0Bre8O5OmANA3TTOiClYfmdrPXJ1t8vVoqL0CiD8ocRvAWHfk/x
         dSvw==
X-Gm-Message-State: AOAM531S/OZWjGWftWNhaNFW0NXXssdp0oOq5SiG8N2AdcEeWpj1l9aH
        q7T+k4OCOJGb7SPetlFRU5A5N3rwq1QroP4xt2JT4LtjtRA=
X-Google-Smtp-Source: ABdhPJyGrv+YTxnBO1EqXUV4J6lz2EGIQr6QRxG3411NHpNfRVYWGsFG95ZWB/1Bx+STLXhJ0CT6nGFv9zWuUb2ib1k=
X-Received: by 2002:a63:e70f:0:b0:380:d919:beb with SMTP id
 b15-20020a63e70f000000b00380d9190bebmr2822754pgi.58.1648286741038; Sat, 26
 Mar 2022 02:25:41 -0700 (PDT)
MIME-Version: 1.0
From:   Tone Kastlunger <users.giulietta@gmail.com>
Date:   Sat, 26 Mar 2022 11:25:30 +0200
Message-ID: <CAHCc5YXmegAV-sSpLLpY19rXhnxYEgM+RzZHJ=saG8nD5HsGKg@mail.gmail.com>
Subject: Path differences between git status & git status --porcelain
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello;
we have noticed that the results displayed by git status & git status
--porcelain differ
in the path information shown. For instance, in one of our test repos:

"git status" output from a "<gitreporoot>/test" folder:

  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directory)

  modified:   ../src/api/db.py  <---- Notice the ".." correctly
displaying the relative path
       to the (modified) file

"git status --porcelain"  output from the same location:

    ....cutted stuff to keep things clean...
       M src/api/db.py   <---- Notice the missing ".." in front of the
(modified) file path.

Is this intentional/expected behaviour; and if not, we were wondering
if this is a known issue?

Best,
Tone Kastlunger
Giulietta SW
