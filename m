Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD9C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 13:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDLN61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLN60 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 09:58:26 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272CF49C2
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 06:58:25 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id cd20so1356519oib.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681307904;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kBsHVRcuEd65XkhRi7fxwm6w4oXGH9IILGv1y9u3I4c=;
        b=ZyQds2EGcDARTw6eX6ypfoJojLhUAxaIWhyCAu/YfqfdoNXoaMgVVQbcF4LWPQJ2Tm
         dlPx6lP5xLheUblXqF5tLygfoh/hzow7jiqhuS3k5Hz0Yei026DotxhBxxk9sUM1/i2S
         lbruu0OnoZT4BBVIRoAgXEvAXRNXFrx5/uyBuKrXa4MVjQGCmr2BH0ExIHTaRXs153Mr
         6eMrrkT484IiKElQHqstPVZud5TXvzHhXeFehjqJr/FrYaJ7+PDe7krnAbaThjU52D81
         6M6rJZDAXLY6+ASSiFO1TwQc2gLXW8GXWTsHwSexs5K4XoDpMZyLvGbw1jtjoJNc2Iwn
         RLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307904;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBsHVRcuEd65XkhRi7fxwm6w4oXGH9IILGv1y9u3I4c=;
        b=O5zMBl8nStvEtWx994Qfd01g6XCR86TOfk/KpiwoA+UgT3ukLe4nSrF6cTPov21LDU
         4ExxgeSQAafCZpXs25/XZ0rwb+tsJ0RFktxZry2WJdEd6eBYQHWj0Frn3zlNatJAviUV
         w8JhHgaqM2xR/snzucj2sK7b+JUJX0Yw+/3apYs+FLXtSnudVaz3l54RuKNaIeWJm62Q
         0t0TZzylWxYvlDc6Y+OdbMIV4mE3WSbdkKNu1crkH67Gk79qUgOaxjtOqvvYP0xoN5JB
         nAOMj6+LqjZktRheyv7zaPl6JARvPNhEd/OgZwG+R5EspOgeN9jJxCNTkA3nqszJZsvM
         uwkg==
X-Gm-Message-State: AAQBX9eY/92xk03xyk8bmN9+Q3Pzz4G3or0b9T5DM/eH5D8fmkRGtiCF
        k/JH5dNRnR0iTfbt5OoL/EejdLuDMQ9N+UCAhZpRd7WikVw=
X-Google-Smtp-Source: AKy350aPxuJjUta/UMf5UqCbT8bf/rfVloZnaTqECJRyLWmI6zPxe02exZvp/rXxiXuS7AJImy5n6I/PvFaV874JV3c=
X-Received: by 2002:a05:6808:2129:b0:37f:a2ad:6718 with SMTP id
 r41-20020a056808212900b0037fa2ad6718mr1097012oiw.3.1681307904378; Wed, 12 Apr
 2023 06:58:24 -0700 (PDT)
MIME-Version: 1.0
From:   Sam Darwin <samuel.d.darwin@gmail.com>
Date:   Wed, 12 Apr 2023 07:58:13 -0600
Message-ID: <CANEqPjHpaYvBWUy-pMi6ikhE6BeVooEBPK+O=cRzafD7o0UwaA@mail.gmail.com>
Subject: upload-pack not our ref
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've just run into something which really looks like a bug in git.
But I expect you will explain the reasoning that it's not a bug.  Let's see.
There is a superproject with submodules. Check it out locally. Update
a few of the submodules: "git submodule update"
Then, wait a few weeks.
Upstream, commits change on both the superproject and submodules.
Refresh the local copy:
git pull
It gives an error about one of the submodules:
fatal: remote error: upload-pack: not our ref
19127b75621f423b572281f27b92ce4c7e50f1b5
The submodule that triggers the error already happens to be
up-to-date, so it won't actually be updated or changed during "git
pull".
Nothing changed on that submodule, and it hadn't been force-pushed, as
far as I can tell.  No commits were made in the intervening time
period on that specific submodule.  (maybe tags were
changed/updated...)
On the superproject and some other modules, yes there were modifications.
"19127b75621f423b572281f27b92ce4c7e50f1b5" is a mystery, and isn't the
main commit sha (either before or after).
Changing the command from "git pull" to "git pull
--no-recurse-submodules ;  git submodule update" fixes things.
So, switching to a two-step process somehow avoids the error.
What is the difference between  "git pull" and the combination of "git
pull --no-recurse-submodules ;  git submodule update" ?  ( that seems
like the crux of the matter ).
The error appears with git versions 2.36 and 2.40.  Not git version
2.17.1.  ( also interesting.. )

Thanks,
Sam
