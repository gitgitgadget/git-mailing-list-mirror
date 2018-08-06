Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1640208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbeHFRU6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:20:58 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:38726 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeHFRU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:20:58 -0400
Received: by mail-lj1-f180.google.com with SMTP id p6-v6so10928380ljc.5
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wlClsdf97RF4nTh30I6TeDNYV8IBVMQ31KzRAxacAfk=;
        b=DI1jZXNGCYw9WBHpxZFroVWlLzwziQVN1gPdAvhPaKrPExfHmE/4cm59J7Wx+yD5Gy
         RK/3zHTyjRYdCdhjwb5nuiqKs1D0QN1pSNIHV7Qn7mk4sp7YenlkccAqhOkHYZ206TcD
         A7o+NivOrMCb6fhqGsJF9JCsbnSA0c6ezgKyu4dxsbrc9fKwDLN+Ql1EjMQ6ShgsBdSH
         Q/NIBoknn5IAUdUk0creUc4zKL/PXrTBRTXPbj0szaBUwfpTI6O4EG5WYFGQfku/zB3w
         wt8KR19fQE/BjhCbr27rtpjfrrCdt4LpFIFoeZFIdJ1IDEqP8vk3LsLrgrbx9s405Cpd
         ML2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wlClsdf97RF4nTh30I6TeDNYV8IBVMQ31KzRAxacAfk=;
        b=jdbiuZ1sRz4F1CARPWhMr7Al+v/Xn3MSqNrPuInQWvjmUYCgb3FrO6Ff2g3Nty1Ush
         Ol/l1EZQcVQBAwuIoTEwxKQYiumYU3Nhe+lv0RIpqtmBZB4pOs7dj8VrqBcWFLb9iom/
         9jveCAS4/8TXBh7In5dAu+LttbTCpml2Bto9/EsXd+al9IaFQOQC+736SWp3jae/a8cm
         jRO0IFo59/WV5XsmgfA9uv1CrdGCyAJR7x2s+SqDZIQyFa8ZZQcG5JajL1pEeZKOVOBX
         GI7GPKKVhlAql17ryXQFPZzvZlII0ZKzKtBrwa5kalzVnU67W0Un9cf3hILkesRDIY1K
         8rCQ==
X-Gm-Message-State: AOUpUlHSzjPkv4yyVqq672j03BXm3B8GRdBF5n/PHtFumQIfX47g6WS/
        lIr63zle8s1ucHTkH/0GcDFXv372aI1PQ1bcjLfbmttq
X-Google-Smtp-Source: AAOMgpcwW0m1DuqEb84GFRB26gIISX/e+89ruGHc0P6wEs30+2GKlAQJrQbImPeO1ID3URxfkvRySBK7cO63VYx9LWM=
X-Received: by 2002:a2e:8617:: with SMTP id a23-v6mr13780830lji.43.1533568284758;
 Mon, 06 Aug 2018 08:11:24 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 6 Aug 2018 17:11:13 +0200
Message-ID: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com>
Subject: t5570-git-daemon fails with SIGPIPE on OSX
To:     Git mailing list <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI changed its default OSX image to use XCode 9.4 on 2018-07-31
[1].  Since then OSX build jobs fail rather frequently because of a
SIGPIPE in the tests 'fetch notices corrupt pack' or 'fetch notices
corrupt idx' in 't5570-git-daemon.sh' [2].  I think this is a symptom
a real bug in Git affecting other platforms as well, but these tests
are too lax to catch it.

What it boils down to is this sequence:

  - The test first prepares a repository containing a corrupt pack,
    ready to be server via 'git daemon'.

  - Then the test runs 'test_must_fail git fetch ....', which connects
    to 'git daemon', which forks 'git upload-pack', which then
    advertises refs (only HEAD) and capabilities.  So far so good.

  - 'git fetch' eventually calls fetch-pack.c:find_common().  The
    first half of this function assembles a request consisting of a
    want and a flush pkt-line, and sends it via a send_request() call.

    At this point the scheduling becomes important: let's suppose that
    fetch is slow and upload-pack is fast.

  - 'git upload-pack' receives the request, parses the want line,
    notices the corrupt pack, responds with an 'ERR upload-pack: not
    our ref' pkt-line, and die()s right away.

  - 'git fetch' finally approaches the end of the function, where it
    attempts to send a done pkt-line via another send_request() call
    through the now closing TCP socket.

  - What happens now seems to depend on the platform:

    - On Linux, both on my machine and on Travis CI, it shows textbook
      example behaviour: write() returns with error and sets errno to
      ECONNRESET.  Since it happens in write_or_die(), 'git fetch'
      die()s with 'fatal: write error: Connection reset by peer', and
      doesn't show the error send by 'git upload-pack'; how could it,
      it doesn't even get as far to receive upload-pack's ERR
      pkt-line.

      The test only checks that 'git fetch' fails, but it doesn't
      check whether it failed with the right error message, so the
      test still succeeds.  Had it checked the error message as well,
      we most likely had noticed this issue already, it doesn't happen
      all that rarely.

    - On the new OSX images with XCode 9.4 on Travis CI the write()
      triggers SIGPIPE right away, and 'test_must_fail' notices it and
      fails the test.  I couldn't see any sign of an ECONNRESET or any
      other error that we could act upon to avoid the SIGPIPE.

    - On OSX with XCode 9.2 on Travis CI there is neither SIGPIPE, nor
      ECONNRESET, but sending the request actually succeeds even
      though there is no process on the other end of the socket
      anymore.  'git fetch' then simply continues execution, reads and
      parses the ERR pkt-line, and then dies()s with 'fatal: remote
      error: upload-pack: not our ref'.  So, on the face of it, it
      shows the desired behaviour, but I have no idea how that write()
      could succeed instead of returning error.

I don't know what happens on a real Mac as I don't have access to one;
I figured out all the above by enabling packet tracing, adding a
couple of well placed tracing printf() and sleep() calls, running a
bunch of builds on Travis CI, and looking through their logs.  But
without access to a debugger and netstat and what not I can't really
go any further.  So I would now happily pass the baton to those who
have a Mac and know a thing or two about its porting issues to first
check whether OSX on a real Mac shows the same behaviour as it does in
Travis CI's virtualized(?) environment.  And then they can pass the
baton to those who know all the intricacies of the pack protocol and
its implementation to decide what to do with this issue.

For a mostly reliable reproduction recipe you might want to fetch this
branch:

  https://github.com/szeder/git t5570-git-daemon-sigpipe

and then run 'make && cd t && ./t5570-git-daemon.sh -v -x'


Have fun! ;)


1 - https://blog.travis-ci.com/2018-07-19-xcode9-4-default-announce

2 - On git.git's master:
    https://travis-ci.org/git/git/jobs/411517552#L2717
