Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB55C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E76C20833
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvlO3ZaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLBGUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 01:20:03 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:43296 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLBGUD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 01:20:03 -0500
Received: by mail-lj1-f175.google.com with SMTP id a13so15416123ljm.10
        for <git@vger.kernel.org>; Sun, 01 Dec 2019 22:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PaPNe35BbRSV/EQYuDgiK9+N8uq50vRuh/I+FZxAq9c=;
        b=AvlO3ZaSrGDF9rICuG7MWm95HqRfCHxOlH4piGAR5sJrORYGBRJ/P0DmZ+TMqirhnR
         DNZVp+X931LmCiEPFRUcGWjWICtYqUA/XHhiKN4x684WbpmL8H0F/l2NN9da+pBY2gBg
         hL3BuIrCCmSq5BfKG9WqcHBo/jX1z9f+9O8tlEKircluU97H476qdMA1oD0hvbOTdQ7U
         WLsFOYuWsYTyrIServ7O9G/gre1YJtRAfgohl4erEhIDJrtoyEVaexis8w6jBkObgdh+
         3tp33C4tGpjwTa0nEcbqjFb8Ra0KAEUYHNR7roOWruxPrrViaLG4MDZML/vi+KLF4A80
         2P6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PaPNe35BbRSV/EQYuDgiK9+N8uq50vRuh/I+FZxAq9c=;
        b=DY/IofD8eJlhjjPgj5ugf2yUlXPOXi7272MA2RXq7fyi8RXt9VUzvPzUdv4gkEsF5k
         h6pJMa4JDmw/fNLDPIhcp8gb9CvRxwxMkUc+GTtsV1Oekun6bmEYVg6ePvJJBXtR4MnG
         R/NTsnow5tN5AfZmb1Ur5tDRhyrrqWA3xB9aeefvpHOaUEcSSjeRHbcX1mSqxGREs/Pw
         beWV84wbfLsG2gfvvey/YIBbBInGVyuFk4DpAARnrRDlcibR/ivZfaJh2CSjr/aXi25c
         AQwTg662BShH8nk6/VFlLQ6WHMZ7Wm8XBjjKvcpSldHyXca6+5g87m41t3m8C3nUFheg
         Eu+A==
X-Gm-Message-State: APjAAAWQOrnTdSmOYU5vPEMQb9rJFSYJH5ClIJYQO6XZJ/iZ7zMlMH0l
        3WVuTXEdz25LwVBRXEkgokNeiKZAQjrQ9YfAd/gJwmEr6MA=
X-Google-Smtp-Source: APXvYqylXSY0DDtxxrGsE6lEVZZgULe3bco7cYXwp56z2ZeBjn+bV+wiJ3JDhnFBYuJGxSzHjMEpCHDxsyXgc74xLYE=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr31653907ljh.17.1575267600820;
 Sun, 01 Dec 2019 22:20:00 -0800 (PST)
MIME-Version: 1.0
From:   "D. Ben Knoble" <ben.knoble@gmail.com>
Date:   Mon, 2 Dec 2019 01:19:49 -0500
Message-ID: <CALnO6CCoXOZTsfag6yN_Ffn+H7KE-KTzm+P-GqLKnDMg8j_Qmg@mail.gmail.com>
Subject: git-status performance with submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[If this has already gone through multiple times, I apologize for the
repetition; I have had a hard time getting GMail to send this. Past
versions had attachments, which I believe contributed to failures.
This one has none, but has links to all the content.]

Hello all,

I have a concern about the performance of git-status with many (~38)
submodules. As part of a (large-scale) system dynamics class, I was tasked
with identifying a performance problem, tracing it using KUTrace(2)[3], and
subsequently investigating it. I ended up with some unique observations about
git-status and submodules[2].

The interactive HTML traces are available on Google Drive[4][5].

I won't recreate all the details here, but I would encourage you to play with
the traces, or at least go through the slides.

### The short-version

Git status is slow(3).

### Baseline

- time git-status, with many submodules, and --ignore-submodules=none
    0.497s
- time git-status in non-submodule heavy repos
    0.014s

### What I consider a temporary fix

- time git-status, with many submodules, and --ignore-submodules=all
    0.026s

### What I would like to see

I would like to improve the git-status performance with this many submodules,
so that I can remove diff.ignoreSubmodules=none from my config (it is useful
information, and the flag affects many commands). I would be willing to work
on a discussed and designed fix.

### What I am curious about

From the traces (attached), it appears that git-status suffers from a lack of
(possibly embarrassing) parallelism: I would expect each submodule to be
independently check-able, but the process section of the trace has them
executing serially (for reasons unknown to me). The apparent need to fork/exec
many processes in this way appears to also be a source of latency, along with
the very large number of filesystem-related syscalls (if my understanding is
correct).

What can we do to fix this? Is there a reason for this (really terribly slow)
serial execution? Is this something developers haven't bothered to optimize
("unexpected use case")? If so, I would like to discuss taking a crack at it,
because I do have at least one repository with this many submodules, and I
care about its performance.

---

Notes

1) All timings were taken with the https://github.com/benknoble/Dotfiles repo
from around commit da194a8f4104a9fc74e8895ebc8512434f07d393

2) KUTrace is a set of kernel patches and userspace programs that provide
low-overhead tracing, as well as post-processing those traces

3) Timings taken on my machine (2012 macbook pro; can provide more details if
requested)

---

Links

[1]: https://docs.google.com/presentation/d/1z-6ffE9KY-Jswl2BiWzYV2DG6fOutgWSi_aZ5uql__s/edit?usp=sharing
[2]: https://benknoble.github.io/blog/2019/11/07/git-stat/
[3]: https://github.com/dicksites/KUtrace
[4]: https://drive.google.com/file/d/1JyYO420yWp7XvNJJ8HLOPU0o6mesSKZf/view?usp=sharing
[5]: https://drive.google.com/file/d/1BqqxH0PRCYz_vvYkBBFpbL5dkFTLPyuK/view?usp=sharing
