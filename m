Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3DFC433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5798A61A7C
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347544AbhKOXTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345268AbhKOXQd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:16:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5850C0613B9
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso892831wme.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzfAecmLl1wRsdG6QFkxp8s6cCre8ZjbssK0lFwQ8no=;
        b=IZzhOGPBwjA5+MIGm2kRFv7+NpkQE4mVLE7yBZEdl9UbPLNot+RHblLBJw13SDVWd7
         gbuXuKfEVa1h1A8LQB2PWUatMuAnl3CAkgwLEfqzvHXFLmGboelvtmde6WLUFdcjl2PK
         05p7pHkRKr73B6GSC1DtkvlS1qpumU2lkNuZcGz4wiSNwpP1Sz7HMTp7dx4KcpGqso3O
         mggV2YDENGFDxvubYmEWKj4WlVJUOQ3qQGEn9KSvRbQDyJqEH7C2RAp1Vmrlqfyq7iOC
         aqgIN7TpOZhhyPlrN9DkwbbfHsTlTM2vuoUHmyYOwnX07XPJaODFiJMnZn79ZRdp3H+v
         byzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XzfAecmLl1wRsdG6QFkxp8s6cCre8ZjbssK0lFwQ8no=;
        b=ApgT2OTeKxNv2ms31Z63XcnHK01txG7qSvzqk51URBsqFoKNiDA94QQv2dkZnRWquw
         oN5miDH0IODZNFR7k0vNhmv95rRdGT8U3wSgOaIgihpf1ZhA6Rzl/z17Mgwbixlm4e84
         CMW4YUpnosKfB4euwAuUhXC2NXaLNNoPjrXOl4N84whWCP5MA3NNptmwpiIZhCkgRMBm
         acIZGu01DOGi5XSgn2lFAA6iB0X+wMtd5AHBIftAblbybWFcfLI+tZZqYUTMNAHhFkpY
         XWnAV7U6W4E1tEIyIuQyUDFgaLeVMvwloBIe3kzuM1odf7q2g18JJ5LxCvRkn35w3JZT
         8SDQ==
X-Gm-Message-State: AOAM53075lgge87ygHrzPiWWaANh9Czozj1LP2bdd+F4OSCC7SMhgm5T
        iAj18czefhVhK4Saz2YTot7vkRyapL++1w==
X-Google-Smtp-Source: ABdhPJy2dmS2gBce/t288kucgIZQWMg3JZnE4Ixe89UvUWEofa9n2Dk6kk6mYQhuKgA8d91sdwmUwQ==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr2176982wmi.46.1637014714178;
        Mon, 15 Nov 2021 14:18:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n184sm526812wme.2.2021.11.15.14.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:18:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 00/21] C99: show meaningful <file>:<line> in trace2 via macros
Date:   Mon, 15 Nov 2021 23:18:10 +0100
Message-Id: <RFC-cover-00.21-00000000000-20211115T220831Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.809.g11e21d44b24
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since everyone's getting in on the C99 fun.

Well, $subject and a bit more. This RFC series has bits and pieces
from thing I've submitted before. I'd proposed to make variadic macros
a hard dependency before in [1] because I wanted to get to the goal in
$subject, perhaps the whole thing will be more convincing.

This also includes the die_message() in a recent series of mine[2]
that I abandoned.

At the end of this series we expose a config variable to have
usage/die/warning emit line numbers. I.e. going from:

    $ git -c core.usageAddSource=false -c core.x=y config --get --bool core.x
    fatal: bad boolean config value 'y' for 'core.x'

To:

    $ git -c core.usageAddSource=false -c core.x=y config --get --bool core.x
    fatal: config.c:1241: bad boolean config value 'y' for 'core.x'

I find that to make tracing down errors in the test suite, and 21/21
has a GIT_TEST_* mode to turn it on there (which fails a lot now, but
I'm hoping I'll eventually get passing).

But most importantly we've now got meaningful file/line numbers in
trace2 error events. I.e. from all of them being some line in usage.c:
    
    $ GIT_TRACE2_EVENT=/dev/stdout ~/g/git/git -c core.usageAddSource=false -c core.x=y config --get --bool core.x 2>&1 2>/dev/null|grep error | jq -r .
    {
      "event": "error",
      "sid": "20211115T221343.534151Z-Hc2f5b994-P003f3980",
      "thread": "main",
      "time": "2021-11-15T22:13:43.537981Z",
      "file": "usage.c",
      "line": 65,
      "msg": "bad boolean config value 'y' for 'core.x'",
      "fmt": "bad boolean config value '%s' for '%s'"
    }

To:
    
    $ GIT_TRACE2_EVENT=/dev/stdout ~/g/git/git -c core.usageAddSource=false -c core.x=y config --get --bool core.x 2>&1 2>/dev/null|grep error | jq -r .
    {
      "event": "error",
      "sid": "20211115T221357.083824Z-Hc2f5b994-P003f4a82",
      "thread": "main",
      "time": "2021-11-15T22:13:57.087596Z",
      "file": "config.c",
      "line": 1241,
      "msg": "bad boolean config value 'y' for 'core.x'",
      "fmt": "bad boolean config value '%s' for '%s'"
    }

I've got some speculation in 19/21 that this may make the "fmt" part
redundant, i.e. did we only add that because we couldn't group these
by file/line, but as noted there there's still some use-cases for
"fmt" even with this series. In any case, this series doesn't touch
that "fmt" key at all.

This is "RFC" mainly because there's a CI failure in 0061.2 with this,
I still can't figure out what that's about (or if it's some fluke
unrelated to this topic), but that has to be investigated.

But I wanted to see if people found the general idea interesting
too. I picked the CC list mainly from paging through "--grep=trace2",
and people who'd modified the tricker bits of usage.c code being
modified here.

1. https://lore.kernel.org/git/cover-0.2-00000000000-20210412T105422Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com/
3. https://github.com/avar/git/runs/4216916706?check_suite_focus=true

Ævar Arnfjörð Bjarmason (21):
  git-compat-util.h: clarify GCC v.s. C99-specific in comment
  C99 support: hard-depend on C99 variadic macros
  usage.c: add a die_message() routine
  usage.c API users: use die_message() where appropriate
  usage.c + gc: add and use a die_message_errno()
  config API: don't use vreportf(), make it static in usage.c
  common-main.c: call exit(), don't return
  usage.c: add a non-fatal bug() function to go with BUG()
  parse-options.[ch] API: use bug() to improve error output
  receive-pack: use bug() and BUG_if_bug()
  cache-tree.c: use bug() and BUG_if_bug()
  pack-objects: use BUG(...) not die("BUG: ...")
  strbuf.h: use BUG(...) not die("BUG: ...")
  usage API: create a new usage.h, move API docs there
  usage.[ch] API users: use report_fn, not hardcoded prototype
  usage.[ch] API: rename "warn" vars functions to "warning"
  usage.c: move usage routines around
  usage.c: move rename variables in usage routines around
  usage API: use C99 macros for {usage,usagef,die,error,warning,die}*()
  usage API: make the "{usage,fatal,error,warning,BUG}: " translatable
  usage API: add "core.usageAddSource" config to add <file>:<line>

 Documentation/CodingGuidelines                |   3 +
 Documentation/config/core.txt                 |   7 +
 .../technical/api-error-handling.txt          |  81 ------
 Documentation/technical/api-trace2.txt        |   4 +-
 apply.c                                       |   8 +-
 apply.h                                       |   6 +-
 banned.h                                      |   5 -
 builtin/fast-import.c                         |  22 +-
 builtin/gc.c                                  |  21 +-
 builtin/notes.c                               |  15 +-
 builtin/pack-objects.c                        |   2 +-
 builtin/receive-pack.c                        |  16 +-
 cache-tree.c                                  |   7 +-
 common-main.c                                 |   9 +-
 config.c                                      |  22 +-
 config.h                                      |  10 +-
 daemon.c                                      |   3 +-
 git-compat-util.h                             |  59 +---
 http-backend.c                                |   6 +-
 imap-send.c                                   |   3 +-
 parse-options.c                               |  56 ++--
 repo-settings.c                               |  11 +
 repository.h                                  |   2 +
 run-command.c                                 |  32 +--
 strbuf.h                                      |   2 +-
 t/helper/test-trace2.c                        |  27 +-
 t/t0210-trace2-normal.sh                      |  52 ++++
 trace.c                                       |  80 +-----
 trace.h                                       | 133 ++++-----
 trace2.c                                      |  45 +--
 trace2.h                                      |  28 --
 usage.c                                       | 270 +++++++++++-------
 usage.h                                       | 180 ++++++++++++
 33 files changed, 636 insertions(+), 591 deletions(-)
 delete mode 100644 Documentation/technical/api-error-handling.txt
 create mode 100644 usage.h

-- 
2.34.0.rc2.809.g11e21d44b24

