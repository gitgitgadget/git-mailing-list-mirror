Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7B720248
	for <e@80x24.org>; Sat,  9 Mar 2019 19:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfCIT75 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 14:59:57 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:34100 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfCIT75 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 14:59:57 -0500
Received: by mail-it1-f178.google.com with SMTP id d125so13290069ith.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q5EKZ/W48C17S68bBLKQ3EWkXyia2Ha4l2rFkvvq4eU=;
        b=Jx6tM5Rc1U9fOW9g6vw8z2v53547UcSechadqpNkDTc+R3YEskVYvLt17LV2pLZJ1O
         O84P4BkExXk50AO2pDFfDnkCQBiF2IeZaDmDP+Rss0UrWgg8kUejpxzCKXmH01/gKUuA
         lK34+xlMltmOEbvG9o45rPZ7dUXQgkZUmI4bU9J3sAxW/XbsVJIJNjrWaXxVuuyzCa5f
         wiZwtC9Ogqm+HbM66AFvfaJ7zcwZpBdnoLWG6kDWeTQOOcEszHLBOjPjeSs1nz/RpwZt
         SVGEvxUOL99H2Z+9b9ag1VJ7iWeWJBanulb53Uk6Z2IJBEkE6Cp1u2sZ7pytcJwijZon
         MUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Q5EKZ/W48C17S68bBLKQ3EWkXyia2Ha4l2rFkvvq4eU=;
        b=EosP726xEit5EMYEWHaoWBn7tvQl9x6bpzDWVOb15U8pKgtwBEGTZk0RvSUVpeSH5I
         jsr2WlZr8oCzUPbgtnB5kI2u4YxnX4tcPeFXtO9hIlybJNsG5qK6gnEpn5Xb9XcCHfiT
         ORIiaBMONTIsrRrhsz9kfvhuNkWa8dBEHm7VUSDetHBBgC9BHSlbfryvrFsXZBv1vb3V
         FqEr0giOREjpSemixe0puYjmCLYpDivhV4xiGz1dRnGNJsb+J7F4FDeJ9Z1rh1TPZ3al
         e8woVcqyVheeMlo8ZDwClptOoSlNaWPpIVaz4x4N5w2QREGzMt3C5PQOTM4zYo5hLrVJ
         8y1w==
X-Gm-Message-State: APjAAAXKIK6c3uSdL9yAUHijL3eNBEjNTwlc2f72+m7IUNrXP6H34D7L
        Yo4jmBptkAAn3HaRAKAe6fT0rnYfvoiLPcEofmw1MhFB
X-Google-Smtp-Source: APXvYqw5H1vp+W6XHuszUpCnl+KEUh2wOeBJ3SzDYKEYB/5BZGEztL8r/WQ6wVrO1222TsRv1ATq3kzzR96Tcw2FWf8=
X-Received: by 2002:a05:6638:398:: with SMTP id y24mr14310659jap.33.1552161595994;
 Sat, 09 Mar 2019 11:59:55 -0800 (PST)
MIME-Version: 1.0
From:   Roman Perepelitsa <roman.perepelitsa@gmail.com>
Date:   Sat, 9 Mar 2019 20:59:45 +0100
Message-ID: <CAN=4vMp1+=hmdRiuC1Y-4w2iKbSuwgAi54ozDzK2dGwn7J=QUQ@mail.gmail.com>
Subject: Refresh index without discard_index + repo_read_index
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I=E2=80=99m writing a program that reads stdin in a loop and prints the
equivalent of `git status` whenever it reads a character. It always
prints its results for the same repository, the same pathspec, etc.
The input characters have no effect on the output, only the sate of
the repository does.
I=E2=80=99m hoping that I can make it produce results faster than a bash
script that literally calls `git status` in a loop. I=E2=80=99m thinking th=
at
maybe I can keep some caches around so that I don=E2=80=99t have to redo al=
l
the work on every iteration that git status does.

What I cannot figure out is how to refresh the index so that it picks
up all the changes that might have happened to the repository and
workdir since the last iteration. Here=E2=80=99s what I have:

```c
#include <stdio.h>
#include <string.h>

#define USE_THE_INDEX_COMPATIBILITY_MACROS
#include "cache.h"
#include "wt-status.h"
#include "pathspec.h"
#include "repository.h"

int cmd_multi_status(int argc, const char** argv, const char* prefix) {
  struct pathspec pathspec;
  memset(&pathspec, 0, sizeof(pathspec));
  repo_read_index(the_repository);
  while (getchar() !=3D EOF) {
    refresh_index(&the_index,
                  REFRESH_QUIET | REFRESH_UNMERGED | REFRESH_REALLY,
                  &pathspec, NULL, NULL);
    int uncommitted =3D has_uncommitted_changes(the_repository, 1);
    int unstaged =3D has_unstaged_changes(the_repository, 1);
    int untracked =3D has_untracked(the_repository);  // I added this to
wt-status.h
    printf("%d %d %d\n", uncommitted, unstaged, untracked);
  }
  return 0;
}
```

This produces correct results on the first iteration but then it
doesn=E2=80=99t pick up all changes. I=E2=80=99ve hacked some code in prelo=
ad-index.c
and cache.c so that it picks up more changes but I still cannot detect
when an unstaged file becomes uncommitted or the other way around.

Any pointers would be greatly appreciated.

Roman.

P.S.

I have working code that uses libgit2. Updating the index with
`git_index_read(index, 0)` works as expected and is indeed faster than
discarding the index and starting from scratch. But it's still slower
than `git status` on large repositories, especially with many ignored
files.
