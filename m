Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8161F453
	for <e@80x24.org>; Thu, 21 Feb 2019 22:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfBUWiF (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 17:38:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45105 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUWiF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 17:38:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so216225wrn.12
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 14:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuGPdWJ32PjFlO5fS6vQnMQ6W862mY1gUj5TTFGqfRo=;
        b=MO55TERkScl5XGRlFLjm/8AuTyDLy0CcET0a9iCkwZ1hXK5mSg0WDyBgWTwFjnSiQB
         i14z+Exk9E8cxge/E9QYx9i9QFT9cN0VWr8poBdpsFTdSyrZ3lXQxm/7egtPh8WlsLom
         Vh8OURiIm8Ftw+96Bp4QCMbEQwzW3AGBlq4+F9Ha5EecOGz/hJl8rVsrzE6VZ9YGNtnP
         4LwZCBCSpyqZEemcwtTzHAdbCbeXGZK7tUwFkWXFlcBJfF98wmCbckMrrUztExo/oY6s
         8lf69mo1POO5eqb5lbilrlEG6gMj68WhL4npGfkjgrvrDesAYbBwDoKTsXtwhl7Jpnzq
         yzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuGPdWJ32PjFlO5fS6vQnMQ6W862mY1gUj5TTFGqfRo=;
        b=QBC+HTJLeFwVFhdM/O7U+zCQSCEf2ADA32Y8Qck+r2e9CJnoEL345sFk27RS+UvvRt
         0LGvdckkNuSdtBbgGuYKT4rqe/60EjTwoDJ0/d2v9aTzr3A5G/Ebt5N7SLpYLA/JnMBf
         UJp8qS77fT0wl9NIWxUCeC/yYuGD01EWiVpKJJazyneAiAbe916s1DB+OBwtuNGQyewW
         EEHErgKc8yuB2lKepLKtdIX8Ob2wrA3bHUMt9NS5g3RlnsTLDYXGJ2Swtee4cU+8c+T6
         rbGNmjb4wM8BvrBp2wNaTBtxeL3S6+jr9Eh2LUGU5FKRhiqLBKh8QyQdjnevB0lGhPgK
         sN5Q==
X-Gm-Message-State: AHQUAuZ1Q+vCZbN0+6f2Uz2cKLPY2ISEaDAEdHpjZXZVMnMhcuegV1SH
        N5Gaz9tfmRhkhHCzaUPUTn4fa/DDZy8=
X-Google-Smtp-Source: AHgI3Ia4vxE4tqEegAgTjXnPOxG4JekBea0iraOPZ+vJAHDihiYzELqAu78adBwLFfU6/+jdE/cijQ==
X-Received: by 2002:a5d:428b:: with SMTP id k11mr574181wrq.17.1550788682925;
        Thu, 21 Feb 2019 14:38:02 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v196sm110803wmf.15.2019.02.21.14.38.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 14:38:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] commit-graph: segfault & other fixes for broken graphs
Date:   Thu, 21 Feb 2019 23:37:45 +0100
Message-Id: <20190221223753.20070-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This one isn't for 2.21.0, these issues are already in v2.20.0, I just
spotted them when looking at & fixing the commit-graph test broken on
NetBSD[1].

This series touches (among other things) some of the same test code,
but merges cleanly with that "dd" fix, and it's not required for
testing it (unless you're on NetBSD).

Instrumenting the commit-graph tests reveals that if you have a broken
commit-graph git will either segfault or abort early with cryptic
errors on such basic commands as "status".

Furthemore, if our graph is corrupt and we've set
core.commitGraph=true we can't even write a new commit-graph, because
writing a new one has grown to implicitly depend on reading the old
one!

This series fixes all of that.

1. https://public-inbox.org/git/20190221192849.6581-3-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (8):
  commit-graph tests: split up corrupt_graph_and_verify()
  commit-graph tests: test a graph that's too small
  commit-graph: fix segfault on e.g. "git status"
  commit-graph: don't early exit(1) on e.g. "git status"
  commit-graph: don't pass filename to load_commit_graph_one_fd_st()
  commit-graph verify: detect inability to read the graph
  commit-graph write: don't die if the existing graph is corrupt
  commit-graph: improve & i18n error messages

 builtin/commit-graph.c  |  23 +++++--
 commit-graph.c          | 132 +++++++++++++++++++++++++++-------------
 commit-graph.h          |   4 ++
 commit.h                |   6 ++
 t/t5318-commit-graph.sh |  48 +++++++++++++--
 5 files changed, 160 insertions(+), 53 deletions(-)

-- 
2.21.0.rc0.258.g878e2cd30e

