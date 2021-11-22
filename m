Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A337DC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 16:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbhKVQHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhKVQHU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 11:07:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34322C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d24so33710125wra.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 08:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/W9hoKSKrTYE+r+ypumuz7WhsYffKPuNDgtRvu5MhY=;
        b=ifY3T9bzLiX3JGBQ/l/Sc8Vg0ftL/hoIuyi8XbLvzLobVykvoWagMremUd9HI7IxsX
         n66NejQB/5p3e9A+EVjiTTCYU/NVDp8cV8YrLSoRISmF45sM48+pBZeyvRAVacirjrN6
         jSyOpgsumVUPLz1zljkCaXijyQKxmwDq7AHudUlLJ4u4JtzCA6378uDCUHiP78qjsOLS
         OmfdMBOyMR9Pal14CsFvtOnO9vDNoYesJZuK97q38+VAdPO3fRyQJsWtWHWZTcglPO4b
         db0cEz7zKfpD6y0f3rkceDyE9I+N57QMsqWfjP6IEotUP4PhJB9lPoLEMvNHHLMSU1pC
         pGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/W9hoKSKrTYE+r+ypumuz7WhsYffKPuNDgtRvu5MhY=;
        b=RYMBEWblxb1uUP+te/JNvVIx3uEFWGp7aAu2dlM7Qs0H01dZnBcNGkai0bqV5T0bwH
         NkIF+u+IR8X3QEC9D0uShS5qRVVzfYoY0n2A/TC0d8yHF5zK0K6Y7xskFMdDGIyBgN8N
         3obsreDyrdoxr+nfnt+/IL7TynshJdc8mopLnkGxXxxk2IfuUHXDNr9rvMQUkyC6K2ZL
         sJ9/dnsXnuu1Z/RTQ2M5UaqyqHuwWGy/PCB+odfQcSFMY/I5Q+kdSkkHVxK/1uthy72Y
         qsXShLzRTyI/lPU38kEjHPPCV4/FUk2JzI3w/SQahUQwc7p1SvrZtM9w9S2je/vIgfL1
         gH/Q==
X-Gm-Message-State: AOAM532ond+VaQ6fLMIwYaXCp5b7thT95QsAK4g9lwzG0GRoGwYjDk7W
        CWUYRtl+/0QI+55qx6YUtmeLG8W0iRIm2g==
X-Google-Smtp-Source: ABdhPJwu/6KWEYofpsod8pjeSEu5Ju51ZCfMvnOgWx0kgAhbK0K/qDTeyYjT8VS0LC24/Wyfl1LzRQ==
X-Received: by 2002:adf:f209:: with SMTP id p9mr38601719wro.191.1637597052205;
        Mon, 22 Nov 2021 08:04:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm24005953wmc.43.2021.11.22.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 08:04:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] run-command API: get rid of "argv"
Date:   Mon, 22 Nov 2021 17:04:02 +0100
Message-Id: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gf3f912c366d
In-Reply-To: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is an alternate but more thorough way to solve the pager
segfault reported by Enzo Matsumiya[1], and more generally avoids
similar issues in the future.

That the run-command API exposed two subtly different ways of doing
the same thing wouldn't only lead to the sort of bug reported in [1],
but also made memory management around it rather painful. As noted by
Jeff King in[2]:

    I'd like to eventually get rid of the argv interface entirely
    because it has memory-ownership semantics that are easy to get
    wrong.

There's probably never going to be a perfect time to do this as a
change to this widely used API will probably impact things
in-flight.

Now seems to be a particularly good time though, merging this to
"seen" only conflicts with my ab/config-based-hooks-2 in
builtin/worktree.c. The resolution is trivial (just use the new hook
API added in that topic).

Since this series removes the "argv" member we're not going to have
any semantic conflicts that aren't obvious as a compile-time error
(and merging with seen both compiles & passes all tests).

As noted in 5/5 we've still got a similar issue with "env" and
"env_array". I've got a follow-up series that similarly removes "env"
which we can do at some point (it's much smaller than this one), but
for now let's focus on "argv".

1. https://lore.kernel.org/git/20211120194048.12125-1-ematsumiya@suse.de/
2. https://lore.kernel.org/git/YT6BnnXeAWn8BycF@coredump.intra.peff.net/

Ævar Arnfjörð Bjarmason (5):
  archive-tar: use our own cmd.buf in error message
  upload-archive: use regular "struct child_process" pattern
  run-command API users: use strvec_pushv(), not argv assignment
  run-command API users: use strvec_pushl(), not argv construction
  run-command API: remove "argv" member, always use "args"

 add-patch.c                 |  4 +--
 archive-tar.c               |  9 +++----
 builtin/add.c               |  6 +----
 builtin/fsck.c              | 12 +++------
 builtin/help.c              |  3 +--
 builtin/merge.c             |  3 +--
 builtin/notes.c             |  2 +-
 builtin/receive-pack.c      | 16 +++++------
 builtin/replace.c           |  3 +--
 builtin/upload-archive.c    |  5 +++-
 builtin/worktree.c          |  2 --
 daemon.c                    | 17 +++---------
 diff.c                      |  7 +----
 editor.c                    |  2 +-
 http-backend.c              |  2 +-
 http.c                      |  5 ++--
 prompt.c                    |  7 +----
 remote-curl.c               |  2 +-
 run-command.c               | 53 ++++++++++++++++++++-----------------
 run-command.h               | 20 ++++++--------
 sequencer.c                 |  2 +-
 sub-process.c               |  2 +-
 t/helper/test-run-command.c | 10 ++++---
 t/helper/test-subprocess.c  |  2 +-
 t/t7006-pager.sh            |  4 +++
 trace2/tr2_tgt_event.c      |  2 +-
 trace2/tr2_tgt_normal.c     |  2 +-
 trace2/tr2_tgt_perf.c       |  4 +--
 transport.c                 |  2 +-
 upload-pack.c               |  5 +---
 30 files changed, 94 insertions(+), 121 deletions(-)

-- 
2.34.0.822.gb876f875f1b

