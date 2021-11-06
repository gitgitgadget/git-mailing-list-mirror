Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F59C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B55760F5A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhKFVGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbhKFVGD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95B0C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n29so7785368wra.11
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1CJOi9/SrjPrUlKgZb7qQzU8sTOMeF7SKZjf1QNo7Y=;
        b=PJzDtN+eC0jn+zzmxK2vmyWibIZRl3NSf44e/m7S/FBV9BDuiKgRp5fkcIZaHOuyvW
         qLXw+KoprFzohE3jRZsPQcTqslSZFju9oWk/WQZFY4GrXtDgl7yp9fh+5OR0M73oKssC
         /D1PhMdbc0ho0TXifUzXUrLAyP9ZBmhCuPLUHz2etQBI/WOW4vUpZ6BR7Bvyrllxe2gD
         LNF5l290YwuAucrOwuCbqqtKXK0qiq1ek62d1Okt3SBi4MZOiKqfwlpOAjMGLWX+4PbA
         jTVHB//gA+Yak2NrWmU8Oork9xqHWwDOPd7J3GLy6SFPTxsa1DcHzSftNBDD35Fj6FkC
         O/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1CJOi9/SrjPrUlKgZb7qQzU8sTOMeF7SKZjf1QNo7Y=;
        b=AZ3MgGC/DqNyTDhg2wCDk82b3exb9knEcglAhyrRHpTyDPICh2ZE5KUsEjn1VwL+ih
         ROTyy/+DuSNcEUhojZ0WpmS12mR9ZyGsenHEtZm/nWL0pqqqct1uzFG6ey/muGRFlyaj
         /ncPJIaUszA59FSze5CTUf3ChV6oMlIKev0cMOzLXLjSH5u6BSHAQ/kTCgcOW/ug5V71
         ylUNUZo5YHycebsiyAxV84s48fuvvAehbLirJJhOpQ+8hS/jG/T8ujbJ/6q7UZ6o+L2I
         +xrwTvkLTqQvOmi0nZMkAeYReLn50/hbFX/J1ruqJEHgCZF5Emggx1S8tSaz2wPOtA8Y
         PG3A==
X-Gm-Message-State: AOAM531iBtF5nyCrcuLRfC6CMOh5zeXZPWKBgzYIum5vs20WdXh78oPr
        Ay7HXTd+C0h/w9HJJj36tYkWemHgCCPBow==
X-Google-Smtp-Source: ABdhPJx+psg4RHtba6p+s2U7SDwXt4QsZ+cjEzVHhIPHfeRsQjlcFKTsNeaxhx6kvIWf66Z9hnNKBw==
X-Received: by 2002:adf:cf0a:: with SMTP id o10mr64492693wrj.84.1636232600144;
        Sat, 06 Nov 2021 14:03:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/16] Makefiles: dependency correctness & speedup
Date:   Sat,  6 Nov 2021 22:03:01 +0100
Message-Id: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series to correct various issues in the Makefile. This goes
on top of my ab/sh-retire-helper-functions sitting in "next".

Let's drop the other outstanding Makefile[1] series I have for now
(not picked up anyway). Unlike that one this is purely Makefile fixes,
and no breakage or change in CMake behavior etc.

Inline comments below:

Ævar Arnfjörð Bjarmason (16):
  Makefile: don't set up "perl/build" rules under NO_PERL=Y
  Makefile: clean perl/build/ even with NO_PERL=Y
  Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
  Makefile: move Perl-only variable assignments under !NO_PERL
  Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
  Makefile: don't have Perl over-depend on GIT-BUILD-OPTIONS
  Makefile: create a GIT-PYTHON-DEFINES, like "PERL"

Various fixes for Perl dependency issues, and eventual alignment of
how we generrate the "DEFINES" file for Perl and Python. These are
straightforward follow-ups to the Makefile parts of
ab/sh-retire-helper-functions, just for *.perl and *.py instead of
*.sh.

  Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts

By not substituting @@GIT_VERSION@@ in the *.perl scripts we don't
need to re-build them every time HEAD changes.

  Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it

Create a shared.mak, to be used by all in-tree Makefiles, to define
common utilities etc.

  Makefile: move $(comma), $(empty) and $(space) to shared.mak
  Makefile: re-add and use the "shellquote" macros

Our quoting is really ugly in Makefiles. This resurrects a 2005-era
commit from Junio to make it better, then it relied on GNU make
features that were too new, but we already hard depend on versions
older than that now, so...

  Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}

Since we can use $(call) let's use it to get rid of this particularly
egregious case of copy/pasting...

  Makefile: add "$(QUIET)" boilerplate to shared.mak
  Makefile: use $(wspfx) for $(QUIET...) in shared.mak

...and the $(QUIET) copy/pasting...

  Makefiles: add and use wildcard "mkdir -p" template

Optimizes a recent "mkdir -p" pattern I added for speed and
readability.

  Makefile: don't invoke msgfmt with --statistics

Miscellaneous small output fix tacked at the end.

1. https://lore.kernel.org/git/xmqqtugr3l4r.fsf@gitster.g/T/#m1ab315e3dbb323427d373d1fcee4534b67d6a6dd

 .gitignore             |   2 +-
 Documentation/Makefile |  71 ++----------
 Makefile               | 238 +++++++++++++----------------------------
 config.mak.uname       |   1 -
 git-cvsserver.perl     |   6 +-
 git-send-email.perl    |   7 +-
 git-svn.perl           |   2 +-
 shared.mak             | 113 +++++++++++++++++++
 t/Makefile             |  34 +++---
 templates/Makefile     |  19 +---
 10 files changed, 222 insertions(+), 271 deletions(-)
 create mode 100644 shared.mak

-- 
2.34.0.rc1.741.gab7bfd97031

