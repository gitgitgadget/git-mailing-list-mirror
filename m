Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A09920248
	for <e@80x24.org>; Wed, 13 Mar 2019 10:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfCMKQd (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 06:16:33 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:33211 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMKQd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 06:16:33 -0400
Received: by mail-ed1-f53.google.com with SMTP id d12so1000149edp.0
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=at+NeVEzLL1hb7I/Q75xVLKRvjUELBugYyKPacSsWLQ=;
        b=FkdQahCOM/yk68vKE8WUiu2HrntfkfCCDVIcSZObGr05iPzTt38Chlc4tfsOH3E7zv
         WsUdkKABihvW+lugNbkXLLl3ZkuksW/LvwXHL7Bqe90Wl3Ukm5egaIufdB9tnYcsMw1t
         6d0adM5PYXGuX8/2wHKYxzWKHbVRDCYX4JzV8PiaVZAceNXkbGei/M0nTQcRb1M404wF
         AH2yjyery54bbHDgnWGLtLRlgJi7a4gh+Ou2agscsLC+Rcw6IcTPEq9kTBXK14RWOT/f
         2Tgt41TrbDEl87tUE1g5tMnCuc85iTqNhbdU1yFSx10c9aCjABW0ZOqmVsBXsC6+AI6N
         e1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=at+NeVEzLL1hb7I/Q75xVLKRvjUELBugYyKPacSsWLQ=;
        b=PoRRlOpgcd1q9wfJIB2a7ZyhWM7h7RHnKReDbhT4jyE2fJde+7pq+J8UWIWXy8CAsV
         a6ghWyOI79N5bJA++5o5v7zuoAudmO6CoEUNbdjovMbSAt0B48c25ZzfbV7xLWbecFMS
         3e8FkTShEfb80X+Ja92YFebpzNogLfh/nkeu2vSJAnE+UCQfbIBw+ZTZnPWNQ4mQUTQq
         F4zNSbARnI98GV9uff/jydflpQrJE4lFXDKGh1KYyo6p1LnAl4E3IbPM+B2FPes2vvIJ
         ExXiJljFj7X0r2gRhv20KckJpTiOxGWU93ogJVrsk6MfG12JB1LoZEuphwEo6pILGVzR
         NFDA==
X-Gm-Message-State: APjAAAXZnJKWmFaMBWztwU0JXTkyUlMSFuwDW7LEsb/w7oT8FicCLOKb
        bazl7sX+GbXGTsZRFJ5MbS6cWBEf
X-Google-Smtp-Source: APXvYqxYGAnN2zhqZEgh3xD9zgUUkVXuL5h4jqqfx6qAfVolPpdzaUCA0b9O1ub++5jQV3YDOlfMOQ==
X-Received: by 2002:a17:906:69c8:: with SMTP id g8mr28844541ejs.75.1552472191161;
        Wed, 13 Mar 2019 03:16:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm346984eje.34.2019.03.13.03.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 03:16:30 -0700 (PDT)
Date:   Wed, 13 Mar 2019 03:16:30 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 10:16:25 GMT
Message-Id: <pull.161.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/4] get_oid: cope with a possibly stale loose object cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Being rather a power user of the interactive rebase, I discovered recently
that one of my scripts ran into an odd problem where an interactive rebase
appended new commands to the todo list, and the interactive rebase failed to
validate the (short) OIDs. But when I tried to fix things via git rebase
--edit-todo, the interactive rebase had no longer any problem to validate
them.

Turns out that I generated the objects during the interactive rebase (yes, I
implemented a 2-phase rebase
[https://github.com/git-for-windows/build-extra/blob/master/ever-green.sh]),
and that their hashes happened to share the first two hex digits with some
loose object that had already been read in the same interactive rebase run,
causing a now-stale loose object cache to be initialized for that 
.git/objects/?? subdirectory.

It was quite the, let's say, adventure, to track that one down.

Over at the companion PR for Git for Windows
[https://github.com/git-for-windows/git/pull/2121], I discussed this with
Peff (who introduced the loose object cache), and he pointed out that my
original solution was a bit too specific for the interactive rebase. He
suggested the current method of re-reading upon a missing object instead,
and explained patiently that this does not affect the code path for which
the loose object cache was introduced originally: to help with performance
issues on NFS when Git tries to find the same missing objects over and over
again.

The regression test still reflects what I need this fix for, and I would
rather keep it as-is (even if the fix is not about the interactive rebase
per se), as it really tests for the functionality that I really need to
continue to work.

My only concern is that this might cause some performance regressions that
neither Peff nor I could think of, where get_oid() may run repeatedly into
missing objects by design, and where we should not blow away and recreate
the loose object cache all the time.

Does anybody share this concern? Or even better: can anybody think of such a
scenario?

Johannes Schindelin (4):
  rebase -i: demonstrate obscure loose object cache bug
  sequencer: improve error message when an OID could not be parsed
  sequencer: move stale comment into correct location
  get_oid(): when an object was not found, try harder

 sequencer.c                 |  5 +++--
 sha1-name.c                 | 12 ++++++++++++
 t/t3429-rebase-edit-todo.sh | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-161%2Fdscho%2Frereading-todo-list-and-loose-object-cache-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-161/dscho/rereading-todo-list-and-loose-object-cache-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/161
-- 
gitgitgadget
