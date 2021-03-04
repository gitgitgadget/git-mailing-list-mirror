Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56260C433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6E064F69
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhCDUSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbhCDUSK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 15:18:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B5C061756
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 12:17:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id h7so1604283wmf.3
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 12:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PF0sZM+u5taw1HF/ZCBbVIDiIKrwmOa4VSxF1iZTzHo=;
        b=KMcXosTv6Sqwi8kTiXowMLpP9B3J8tAChv+nOkSfZN0YOFMettrVcKDyorzdUAeypr
         +GIYcXyDZ095d3wBJ7v7tdkteTqaVPJj0OLLKClnfuX65fQtG5p9+4noojb92zhTXGqh
         QUZprBbX89MunDHmtj76HtV3k6/NJvaHQcVwS4xZiJQXVoSFjb8KCctX7D61pAFjVy2z
         AxdfBdMhQJ/Kl2iTOjouhhTkSr0krSo668NLHcvIkRJdDsb544XIt80DgVZE9fY8e0PE
         oXL9H8OHHHymQrza9K6C2MmkR6zsSn+1upj05Vn1XCdBB3/IwR4LtA0miJa/6t5Jvk+u
         eeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PF0sZM+u5taw1HF/ZCBbVIDiIKrwmOa4VSxF1iZTzHo=;
        b=KyixVx+lOOUguj0RMHgQoACDkBWLBQs85eJQcVarl1JXehM+cd8D3cjdg6/0LTi4y8
         xAADULy1s/fuWXgV2xjCNOUT+JFHXSzXt3ByDQrE5PeNuVm2OpnqIOP8HaRyHdaS0vvA
         rgRldp67YLOX3rPj+Dv27/g+h1s00/m49EF/lEyjVjIjr5jcU7rKXkbgtV+1IAMLr4A/
         mEgnF2keT06EXwwXo2ul423FWcAL9djrK/axFG8UfqbEJ/d/krwE7iLyjazyWp5xWRiA
         YSQXgXSoDlL1UD+ltnW1p2ys6HWyLvV3QBUDoJ570FLFwntWlu5BhDbjOLs7EXBgzwto
         loCg==
X-Gm-Message-State: AOAM532lImbrTPFahxOd1PMTKHitZMBYlBNosqd8bs21cfIRMtEtH7rW
        VZx9chcYgSm+j9MVPKRl/sD5OC0WDek=
X-Google-Smtp-Source: ABdhPJw15lyg///s/XHuvkqUh03GgnJa1NTZ8nkshKJaSuahBTogHLkvMKZXfrkeDzgytbVqFKAPlw==
X-Received: by 2002:a1c:8041:: with SMTP id b62mr5794897wmd.0.1614889048808;
        Thu, 04 Mar 2021 12:17:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm889232wmj.2.2021.03.04.12.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:17:28 -0800 (PST)
Message-Id: <pull.893.git.1614889047.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Mar 2021 20:17:19 +0000
Subject: [PATCH 0/8] Simple IPC Cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds a few final cleanup and refactoring commits onto the
jh/simple-ipc branch. These are in response to mailing list comments that I
received on my V4 version after it was queued into next.

https://lore.kernel.org/git/pull.766.v4.git.1613598529.gitgitgadget@gmail.com/T/#mbd1da5ff93ef273049090f697aeab68c74f698f1

There are a couple of large changes that I'll call out here.

In the third commit, I moved the new lock-aware code out of unix-socket.c
and into its own source file. This creates a slightly misleading diff at
times (in gitk) where it looks like 51% copy of unix-socket.c rather than a
new file. On the command line and on GitHub it looks better.

In the commits prefixed with test-simple-ipc: ... I refactored the options
parsing to allow the name of the socket/named-pipe to be passed on the
command line so that the Windows version could do so (since it needs to exec
a child rather than fork). This turned into a larger cleanup/refactoring
than I had expected, but I think the result is much better. I unified all of
the option parsing into the main cmd__simple_ipc() function and got rid of
the smaller parsers inside of each subcommand. With this, all of the
subcommands now allow an alternate socket path to be used. (Just fixing the
unused arg on the Windows side would allow us to spawn a background daemon
on a different socket, but none of the client subcommands would be able to
talk to it.)

Jeff Hostetler (8):
  pkt-line: remove buffer arg from write_packetized_from_fd_no_flush()
  unix-socket: simplify initialization of unix_stream_listen_opts
  unix-stream-server: create unix-stream-server.c
  simple-ipc: move error handling up a level
  unix-stream-server: add st_dev and st_mode to socket stolen checks
  test-simple-ipc: refactor command line option processing in helper
  test-simple-ipc: add --token=<token> string option
  simple-ipc: update design documentation with more details

 Documentation/technical/api-simple-ipc.txt | 131 +++++++--
 Makefile                                   |   1 +
 compat/simple-ipc/ipc-unix-socket.c        |  49 ++--
 compat/simple-ipc/ipc-win32.c              |  14 +-
 contrib/buildsystems/CMakeLists.txt        |   2 +-
 convert.c                                  |   7 +-
 pkt-line.c                                 |  19 +-
 pkt-line.h                                 |   6 +-
 simple-ipc.h                               |   4 +
 t/helper/test-simple-ipc.c                 | 326 +++++++++++----------
 t/t0052-simple-ipc.sh                      |  10 +-
 unix-socket.c                              | 117 +-------
 unix-socket.h                              |  33 +--
 unix-stream-server.c                       | 130 ++++++++
 unix-stream-server.h                       |  35 +++
 15 files changed, 502 insertions(+), 382 deletions(-)
 create mode 100644 unix-stream-server.c
 create mode 100644 unix-stream-server.h


base-commit: edce16a37ab87513a3f0bc805e9bf372bdd02961
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-893%2Fjeffhostetler%2Fnext-simple-ipc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-893/jeffhostetler/next-simple-ipc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/893
-- 
gitgitgadget
