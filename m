Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7796A1F62D
	for <e@80x24.org>; Mon,  9 Jul 2018 03:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbeGIDaP (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 23:30:15 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:37428 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932656AbeGIDaO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 23:30:14 -0400
Received: by mail-oi0-f41.google.com with SMTP id k81-v6so33251420oib.4
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 20:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7w0pgjruIhLWoRlPP04a7e3VZLJ/z9JyAc5+NeQovCs=;
        b=EV0JrpK7x2xqTw9Xe7bKflmuHzY9ZCmUG5hL3AAB+hoKwdpBZ0d7KAN7KdATE0wdT9
         TtEgzYLsMgIBkLMpLve/78IuSuPIPXYDazOYB/oGMDILhgAmZnNwdJVKmRlxpPmCTdCI
         cNcdzQ53POvu6XyvEQDo4ajpAWecljWu+Gle90hD9InVlmbD1aIyb1uOXy3ASXrrD30P
         ZVEWHjglGDNlC2Om0NDRvbhfmY46++mVWsltStv54UXcsMMm7Cuv9Uh1oRqKg51lMKkl
         jVle0xtaImpYT9hLi/NEHhbdgrQxAErLH4pvT7oEfqSyHaWxuYSKuMjM4imnNKy05cMF
         bcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7w0pgjruIhLWoRlPP04a7e3VZLJ/z9JyAc5+NeQovCs=;
        b=XT3LpEl/OkW6XnllrQlO+76qqvY/2I1QFJIkdpltVOIu+v6iDBydSdyV6VV3oFRxCu
         FhFmNUAR64VWSCS6I2qRnLoER/PQhMV7OAg37sq7zKRq04hPFesrnULE5y2vi3uOTtxt
         5bz4/x3kZFgxJrDW8Vq95sX4yc1Rw9p5DU4sxdtO6ABxn6YpkvQCYGLQXh8iE4Sruqs9
         48yAr4q6rNgocNOMhKokplFhqzIt2lsj9SyDFJqtV0Gxq1IfEr/KmZGcYFIWkVIGhnDy
         iNo2lTHp/f9Zc36QNcyBEQYYOka+gntkYxmrVfiMoGWLKciAvHVef8CkVkdmOAQaD5vF
         /8xQ==
X-Gm-Message-State: APt69E2HrknQTxGQpSfzrczPTRx3dGOc5zaZPAu2Rpn63C+wpdNzo26H
        cEyvbc02aYHgWWUTVU0ioL7oX0ACK1CAYrGHIx+4bw==
X-Google-Smtp-Source: AAOMgpd0yRcDBhCfCklwvKriihCWC48ZHMfN7bwrXtjcxHvaBdG8YCO8oywYJy/WQ7UmNjhHs/uKkZA4zyGltgkbSr8=
X-Received: by 2002:aca:c0d5:: with SMTP id q204-v6mr19760636oif.77.1531107013622;
 Sun, 08 Jul 2018 20:30:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:74c3:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 20:29:53 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
Date:   Sun, 8 Jul 2018 20:29:53 -0700
Message-ID: <CAFW+GMBLeLyJjJPaEXkyQ5fJ=L4q4vQ=26wjZ+n07ZvSaTaCUg@mail.gmail.com>
Subject: Unexpected behavior with :/<text> references
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm experiencing strange behavior with :/<text> references, which seems
to be inconsistent with the explanation in the docs on two counts.
First, sometimes the matched commit is not the youngest. Second, some
commits cannot be found at all, even if they are reachable from HEAD.

Here is a script to reproduce the behavior (Git built from current pu):

    #!/bin/sh
    export GIT_CONFIG_NOSYSTEM=1
    export GIT_ATTR_NOSYSTEM=1
    cd "$(mktemp -d --suffix .gitrepro)"

    git --version
    git init

    git commit -q --allow-empty -m initial
    git commit -q --allow-empty -m foo
    git checkout -q -b early-branch
    git commit -q --allow-empty -m foobar
    git checkout -q --detach
    git commit -q --allow-empty -m foobarbaz

    echo
    echo "The following should all print 'foobarbaz':"
    git show --format=%s ':/foo' --
    git show --format=%s ':/foobar' --
    git show --format=%s ':/foobarbaz' --

    echo
    echo "With an explicit branch:"
    git branch late-branch
    git show --format=%s ':/foo' --
    git show --format=%s ':/foobar' --
    git show --format=%s ':/foobarbaz' --

Here is the output on my machine:

    git version 2.18.0.516.g6fb7f6652
    Initialized empty Git repository in /tmp/tmp.WeCD0QZPIf.gitrepro/.git/

    The following should all print 'foobarbaz':
    foo
    foobar
    fatal: bad revision ':/foobarbaz'

    With an explicit branch:
    foo
    foobarbaz
    foobarbaz

First, the commit with message "foobar" clearly matches the regular
expression /foo/ as well as /foobar/, but ":/foo" resolves to an older
commit. However, Documentation/revisions.txt indicates that a :/<text>
reference should resolve to the _youngest_ matching commit.

Second, the commit with message "foobarbaz" is reachable from HEAD, and
yet the regular expression /foobarbaz/ fails to match it. The same
documentation indicates that :/<text> references find commits reachable
from any ref, and the glossary entry for "ref" states that HEAD is a
"special-purpose ref" even though it does not begin with "refs/".

It looks to me like references reachable from `master` are always picked
over other references, and that references reachable only from HEAD are
not matched at all.

Is the observed behavior intentional? If so, what am I misunderstanding?

Thanks!
WC

(for searchability: colon slash text references)
