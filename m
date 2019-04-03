Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A8A20248
	for <e@80x24.org>; Wed,  3 Apr 2019 16:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDCQCR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 12:02:17 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:43591 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCQCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 12:02:16 -0400
Received: by mail-qt1-f201.google.com with SMTP id q21so17104659qtf.10
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MmsxYSTvGX0745drk7i5zY4omjc26GTBQvXkq9Xps6U=;
        b=PxTsou+uFK2AJ8k+zWMpWE0Ug/5rYyUSz5cFZgu7BYD029sahfNCdbj678MK9snBiW
         yLUEK9c/lnUCUe9QRfuit+m5K9DGztAoVVk2bYqc/XloS79Y/P8YWE9sF9gestUogd96
         knVwQUGQOg2yD4C+yUJd26/17HaaCdPyHTwOuL/+KXCPuHLuyfY3jBfniiSY3u94/l6j
         Th4/RgtWaW0jy10ErZxAYaQRKC1HFcLlEmbJeqOF3kfEOx6bQ+1pm1mOLNDPy4NFYLOy
         Wpjl3+0FyDZ1EjFJUhzWjeIQYw9GbnhWH5dW+KIL00R/0nvHSPrqn65bpTNT195jsNiR
         BBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MmsxYSTvGX0745drk7i5zY4omjc26GTBQvXkq9Xps6U=;
        b=O3+ed1NiY9mm2SHxHPgbpeGU3ph6nP1NqC3BsGGKwlXt4LzJwg79lBC3wXgdzZ9UAR
         Ih3Riq0TFS070Ti9ZTVvTLAJwBibDT5RZs+NLqmOrhqC5zORFEbMgqb8r3/j3WP/32nL
         0tFmeGP6wCqnP5wBVauAQUZgnqA8yzkGEemB0TCjT7ybjyxf/efomqXIF9uQ8M2maLhV
         9e6UFAUUsodqdJoUNRNwTDyGspWwF24GNWQLVTbgFjzj9bRzvdRjMcevGhyGxA+4fmmf
         HLxR8M/SMfdohYXgBW6CKJltRJmd5pxn/uVqAd45VB0+BmGBOJYzGBihG3sYOWnr3Rmr
         q75A==
X-Gm-Message-State: APjAAAVpiGs6aAGsInghNpaqF8JVd5FkHKq9G1pF7J95nSjTmbC8LoVi
        awleZKKco8NFetBdia6HDcfloiwQ5exvcZQMkm1jKMbc1X6W9SkCgxuDtVr5xN5XyUNbde23Fzf
        wvaCekq6Fai7WLJAYwxvYl6KoGGoS2qCMQbrxWJKUzD7Ok/bIcTK1
X-Google-Smtp-Source: APXvYqwhIWRuCALlMCR9j4OTKsw3tctvk489WvDtemD2ys86vW3hYTTVogYUOMQBjeo1Z4IkyoZgmpx5
X-Received: by 2002:a37:4a54:: with SMTP id x81mr81642qka.36.1554307335715;
 Wed, 03 Apr 2019 09:02:15 -0700 (PDT)
Date:   Wed,  3 Apr 2019 12:02:01 -0400
Message-Id: <20190403160207.149174-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v5 0/6] blame: add the ability to ignore commits
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set adds the ability to ignore a set of commits and their
changes when blaming.  This can be used to ignore a commit deemed 'not
interesting,' such as reformatting.

The last patch in the series is an RFC, and the others could be merged
without it.  That last patch changes the heuristic by which ignored
lines are attributed to specific lines in the parent commit.  This
increases the likelihood of blaming the 'right' commit, where 'right' is
subjective.

The last patch needs a little work still - there's a TODO section in
its commit message.  It includes some of Michael's code, so if we are
going to keep it, I'd like to sort out authorship correctly.

v4 -> v5
v4: https://public-inbox.org/git/20190226170648.211847-1-brho@google.com/
- Changed the handling of blame_entries from ignored commits so that you
  can use any algorithm you want to map lines from the diff chunk to
  different parts of the parent commit.
- fill_origin_blob() optionally can track the offsets of the start of
  every line, similar to what we do in the scoreboard for the final
  file.  This can be used by the matching algorithm.  It has no effect
  if you are not ignoring commits.
- RFC of a fuzzy/fingerprinting heuristic, based on Michael Platings RFC
  at https://public-inbox.org/git/20190324235020.49706-2-michael@platin.gs/
- Made the tests that detect unblamable entries more resilient to
  different heuristics.
- Fixed a few bugs:
	- tests were not grepping the line number from --line-porcelain
	  correctly.
	- In the old version, when I passed the "upper" part of the
	  blame entry to the target and marked unblamable, the suspect
	  was incorrectly marked as the parent.  The s_lno was also in
	  the parent's address space.

v3 -> v4
v3: https://public-inbox.org/git/20190212222722.240676-1-brho@google.com/
- Cleaned up the tests, especially removing usage of sed -i.
- Squashed the 'tests' commit into the other blame commits.  Let me know
  if you'd like further squashing.

v2 -> v3
v2: https://public-inbox.org/git/20190117202919.157326-1-brho@google.com/
- SHA-1 -> "object name", and fixed other comments
- Changed error string for oidset_parse_file()
- Adjusted existing fsck tests to handle those string changes
- Return hash of all zeros for lines we know we cannot identify
- Allow repeated options for blame.ignoreRevsFile and
  --ignore-revs-file.  An empty file name resets the list.  Config
  options are parsed before the command line options.
- Rebased to master
- Added regression tests

v1 -> v2
v1: https://public-inbox.org/git/20190107213013.231514-1-brho@google.com/
- extracted the skiplist from fsck to avoid duplicating code
- overhauled the interface and options
- split out markIgnoredFiles
- handled merges

Barret Rhoden (6):
  Move init_skiplist() outside of fsck
  blame: use a helper function in blame_chunk()
  blame: optionally track the line starts during fill_blame_origin()
  blame: add the ability to ignore commits and their changes
  blame: add a config option to mark ignored lines
  RFC blame: use a fingerprint heuristic to match ignored lines

 Documentation/blame-options.txt |  16 ++
 Documentation/config/blame.txt  |  11 +
 Documentation/git-blame.txt     |   1 +
 blame.c                         | 384 +++++++++++++++++++++++++++-----
 blame.h                         |   6 +
 builtin/blame.c                 |  51 +++++
 fsck.c                          |  37 +--
 oidset.c                        |  35 +++
 oidset.h                        |   8 +
 t/t5504-fetch-receive-strict.sh |  14 +-
 t/t8013-blame-ignore-revs.sh    | 201 +++++++++++++++++
 11 files changed, 665 insertions(+), 99 deletions(-)
 create mode 100755 t/t8013-blame-ignore-revs.sh

-- 
2.21.0.392.gf8f6787159e-goog

