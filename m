Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36349C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C6CB61B31
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhKPMFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbhKPMEd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:04:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B756EC06120E
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t30so36990963wra.10
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePI42E3chv16CDtxIk0yqPsj1sLvkQUxbMhc14jiLu0=;
        b=e36QKSSxZ3ZX9FD5axqa4YeGhtWOtl5nNkXQ9PEuXFAzy/Ssv66bMoNjjhx9jSKC7g
         f+UG98eCv7t6Spb3WIj9mlozN0gC6ZfTaIIEZBDvmCybb7VwL+8Q6XPtlhp7l/YrIZop
         lyLDVIykn2GNWhbtV99FtS+OsOvxxJdhTwxJpGWl/llCEzcIPoTgYKlhG/WRdCk+Bssr
         GcKp1aGhSfrDu7GS72IIVxhEhgkh7TVRX4DjiTTQBOSwvQgx51tEeZ5z2c6kOtU7wfTU
         ms2PKDc5k+8F7eFEqKSJW27rnUcg9Pqv1LFWenDVGqpsR9h5TbhHu1+MhQHJs0Yuu+Tk
         2T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePI42E3chv16CDtxIk0yqPsj1sLvkQUxbMhc14jiLu0=;
        b=xo6j1usV5HCYVegVC4MdGEFUVGlEUd+yBHuf6bewrYquK/dEOwqf2ALdpasA7HHsYI
         HdaFyHoKCT42++sRk/3sD+E5XAIoJHGiF0fRjH5Z+Yqu5uZKkPZQylIl44vKz39nvlwf
         d5+pigaqCVPzx3YnBDp0KtZwDthuqFrXBaEda/ikXxSY7bti+E0yhN2S0fSxNVQNqwNC
         yvSxXvsrrdSipx22KnzvezY15gAY4nO/XntRqXUXLjR1D3p1FNIIysU9P3KkIara+mou
         XmRaVgzny+pfqrrLEjl603mFTXhCdZcGtboR7NXYJZEmjimptvJa8p0VoF6wyQNqIVzL
         yCrw==
X-Gm-Message-State: AOAM533UM+sEQDR9pJ8uttvooAxupCk1h7k2zQ/P5No0i20YbDrwZzF2
        j9KDeEFESaxd2GWExoglC8iCmKDziUuRJw==
X-Google-Smtp-Source: ABdhPJzmgXO7z2v7KTTwaKIcMZoECjnCYVZK9bhiakHACClfViF9txeXsKamRplwLwiM4XPeD0KbZA==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr8614876wrv.120.1637064034873;
        Tue, 16 Nov 2021 04:00:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/23] Makefile: dependency fixes, make noop runtime ~1.4x faster
Date:   Tue, 16 Nov 2021 13:00:00 +0100
Message-Id: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in v2[1] this series fixes various dependency issues in the
Makfile.

New in v3 is a fix for the dependency issue Mike Hommey reported[2]
with hook-list.h, and 3x new and big optimizations that I'd planned to
submit later on-top, but I figured would be better to consider as part
of these general dependency improvements.

With those new changes on top we run ~1.4x faster on no-op runs (under
NO_TCLTK=Y, since that would otherwise eat most of our runtime either
way):
    
    $ git hyperfine -L rev origin/next,HEAD~0 -s 'make -j8 all NO_TCLTK=Y' 'make NO_TCLTK=Y' --warmup 10 -r 10
    Benchmark 1: make NO_TCLTK=Y' in 'origin/next
      Time (mean ± σ):     187.4 ms ±   2.4 ms    [User: 146.5 ms, System: 57.1 ms]
      Range (min … max):   184.7 ms … 192.8 ms    10 runs
     
    Benchmark 2: make NO_TCLTK=Y' in 'HEAD~0
      Time (mean ± σ):     136.1 ms ±   0.9 ms    [User: 103.0 ms, System: 47.6 ms]
      Range (min … max):   135.4 ms … 138.2 ms    10 runs
     
    Summary
      'make NO_TCLTK=Y' in 'HEAD~0' ran
        1.38 ± 0.02 times faster than 'make NO_TCLTK=Y' in 'origin/next'

Which, as noted before is working nicely towards making executing
"make" in a loop faster, such as under "git rebase --exec".

Those optimizations are a mixture of clever and "dumb but
works". E.g. around 10% of the runtime was spent by the Makefile
looking for git's sources in the RCS and SCCS source control
management systems, before giving up and considering the relevant file
on disk.

1. https://lore.kernel.org/git/cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com
2. https://lore.kernel.org/git/20211115230032.3or3qqlsdnxjtrol@glandium.org/

Ævar Arnfjörð Bjarmason (23):
  Makefile: don't invoke msgfmt with --statistics
  Makefile: don't set up "perl/build" rules under NO_PERL=Y
  Makefile: use "=" not ":=" for po/* and perl/*
  Makefile: clean perl/build/ even with NO_PERL=Y
  Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
  Makefile: guard Perl-only variable assignments
  Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
  Makefile: adjust Perl-related comments & whitespace
  Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
  Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
  Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
  Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
  Makefile: move $(comma), $(empty) and $(space) to shared.mak
  Makefile: re-add and use the "shellquote" macros
  Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
  Makefile: add "$(QUIET)" boilerplate to shared.mak
  Makefile: use $(wspfx) for $(QUIET...) in shared.mak
  Makefiles: add and use wildcard "mkdir -p" template
  Makefile: correct the dependency graph of hook-list.h
  Makefile: use $(file) I/O instead of "FORCE" when possible
  Makefile: disable GNU make built-in wildcard rules
  Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
  Makefile: move ".SUFFIXES" rule to shared.mak

 .gitignore             |   2 +-
 Documentation/Makefile |  71 +---------
 Makefile               | 313 +++++++++++++++--------------------------
 config.mak.uname       |   1 -
 git-cvsserver.perl     |   6 +-
 git-send-email.perl    |   7 +-
 git-svn.perl           |   2 +-
 shared.mak             | 187 ++++++++++++++++++++++++
 t/Makefile             |  34 ++---
 templates/Makefile     |  19 +--
 10 files changed, 337 insertions(+), 305 deletions(-)
 create mode 100644 shared.mak

Range-diff against v2:
 1:  75ebf7b04e5 =  1:  1621ca72c1d Makefile: don't invoke msgfmt with --statistics
 2:  138f60ba37b =  2:  b7c36c9fea0 Makefile: don't set up "perl/build" rules under NO_PERL=Y
 3:  472e1eb74bd =  3:  510499d18ba Makefile: use "=" not ":=" for po/* and perl/*
 4:  a5ce2dce164 =  4:  37f3591bcca Makefile: clean perl/build/ even with NO_PERL=Y
 5:  04dbc1d2809 =  5:  e38c90ad0b6 Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
 6:  eea89794493 =  6:  98e14c7eba9 Makefile: guard Perl-only variable assignments
 7:  e06732d4639 =  7:  047a42b01cf Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
 8:  a9502a23989 =  8:  0c0a3de390e Makefile: adjust Perl-related comments & whitespace
 9:  c1336fc0a56 =  9:  1ece3160915 Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
10:  41f65a12205 = 10:  e9b61cd0ba5 Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
11:  bfa15059d60 = 11:  b020f8e3257 Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
12:  656d02ab641 = 12:  19539ce7d2d Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
13:  6e25ac71cbc = 13:  6c9291c2c9f Makefile: move $(comma), $(empty) and $(space) to shared.mak
14:  64296e6e8e5 = 14:  e811a907b08 Makefile: re-add and use the "shellquote" macros
15:  5654d7f7f29 = 15:  fac30fe8b56 Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
16:  0a348b54491 = 16:  a3e3acea82d Makefile: add "$(QUIET)" boilerplate to shared.mak
17:  34f692144d1 = 17:  22264f431c8 Makefile: use $(wspfx) for $(QUIET...) in shared.mak
18:  5b3986bc4a8 = 18:  d61e2b44f68 Makefiles: add and use wildcard "mkdir -p" template
 -:  ----------- > 19:  234b4eb613c Makefile: correct the dependency graph of hook-list.h
 -:  ----------- > 20:  567ad5c3ebc Makefile: use $(file) I/O instead of "FORCE" when possible
 -:  ----------- > 21:  cb3ae5ce00b Makefile: disable GNU make built-in wildcard rules
 -:  ----------- > 22:  88cfc946b37 Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
 -:  ----------- > 23:  276e226f0a8 Makefile: move ".SUFFIXES" rule to shared.mak
-- 
2.34.0.795.g1e9501ab396

