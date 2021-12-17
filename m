Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE9C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhLQANG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhLQANF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:13:05 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E31C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:13:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j9so1019343wrc.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCvdPqXjZ7cCfiWyBeffyaqaUJu4hPFntT+Kl3fRtVw=;
        b=dV85FeX91TAYq2IWWQOQ2Sc2SAv38XseWaw0cLu0cna63tLtPN819n1to0qbMDx5Sx
         g9MN/NW696aNlJ/SBn8I/Csy/26ah9T8Vc4Nsx3PAYPSFkeUvwk7DNEEAhGV5zcXKuND
         uz0kWwqyvzusgR1UA4hIbGSjGl3RdjnmIkkQtKd3Sze9mgFnx9qVRJqlv4oi5cCK2wa1
         d5gLtgd3LjtHDEQA4rCTtpqIlKJrDQAcP8jKCOALLwE/+jaarUDhvW4W6IKQK6IFIp3O
         PBFvS2FBT/kyqIwX1mUSSIj+VqBf9ic8bW1e7dZDjr83clFn/bBBEIHTumdDsSP7qEKz
         O5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCvdPqXjZ7cCfiWyBeffyaqaUJu4hPFntT+Kl3fRtVw=;
        b=In8ikN6cXYJILyn/zXggFNwBALE5FGUEGn1BFMK4DOJgJUzPZ1zvfm2lRnMf/SVmXp
         VpEHHNbve/rkGrG63TU1L7yP2YnFf1O0AkwIXRjXOWGQdO5DeRqxGHFOVVSLVXiinETJ
         thuqXJOZ5lExitQONMY0kHypL/mR4igauPc+ZXgPiGAtYI2/mfwlB39xyipAFi3Tf27t
         2SKWMlonDk7EAi9xdLUoJNNcexmIbMUI7DpB9BYBaVuQj80svP8ASgN/uivQ8EH94SIl
         T7YwJkpUfzHnDrQ0D+p6vXohsjSWP6twDfWGl8hFecpXHNnTpe5CgeseMekgnu7JOlRW
         bVYw==
X-Gm-Message-State: AOAM532AdZsN5hZuipqnRqYJUH5nYuSr+2YB9VwdMDMLxpVkHwyU+h3D
        slxS8mAW6bg11+BxpEpKUhzWqu8N4a9ajw==
X-Google-Smtp-Source: ABdhPJzXKHC/JoDgR1ASOdd3l4Iei6ss3RPLGqFOxhBIaHbOEho0mCvQ5rk5CVynFQtEVruuyTjr+A==
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr298532wri.461.1639699983598;
        Thu, 16 Dec 2021 16:13:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5737794wrr.37.2021.12.16.16.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:13:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: correct the dependency graph of hook-list.h
Date:   Fri, 17 Dec 2021 01:13:01 +0100
Message-Id: <patch-1.1-1fafa6c643b-20211217T001137Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue in my cfe853e66be (hook-list.h: add a generated list of
hooks, like config-list.h, 2021-09-26), the builtin/help.c was
inadvertently made to depend on hook-list.h, but it's used by
builtin/bugreport.c.

The hook.c also does not depend on hook-list.h. It did in an earlier
version of the greater series cfe853e66be was extracted from, but not
anymore. We might end up needing that line again, but let's remove it
for now.

Reported-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

As noted in [1] this is the first of smaller topics that split-up and
replace the ab/make-dependency topic. Range-to the previous start of
the series below. The v4 of the old series is at [2].

For this commit there were no changes or outstanding comments, except
that in [3] it was suggested that this more isolated fix by split-up
from the rest.

1. https://lore.kernel.org/git/211217.86a6h09km9.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com/
3. https://lore.kernel.org/git/0e3e3a4f-f6af-d8df-8973-255ed7b1b7ef@github.com/

Range-diff:
 1:  1621ca72c1d <  -:  ----------- Makefile: don't invoke msgfmt with --statistics
 2:  b7c36c9fea0 <  -:  ----------- Makefile: don't set up "perl/build" rules under NO_PERL=Y
 3:  29b000eb0f1 <  -:  ----------- Makefile: use "=" not ":=" for po/* and perl/*
 4:  daead5ec293 <  -:  ----------- Makefile: clean perl/build/ even with NO_PERL=Y
 5:  3c987590740 <  -:  ----------- Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
 6:  b57f582ccd3 <  -:  ----------- Makefile: guard Perl-only variable assignments
 7:  fcdee92f64c <  -:  ----------- Makefile: change "ifndef NO_PERL" to "ifdef NO_PERL"
 8:  1e25b532ca2 <  -:  ----------- Makefile: adjust Perl-related comments & whitespace
 9:  77d9855bfcf <  -:  ----------- Makefile: correct "GIT-PERL-{DEFINES,HEADER}" dependency graph
10:  6004cdcd8d9 <  -:  ----------- Makefile: create a GIT-PYTHON-DEFINES, like "PERL"
11:  17b30e96057 <  -:  ----------- Makefile: stop needing @@GIT_VERSION@@ in *.perl scripts
12:  30ddf7da2c8 <  -:  ----------- Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
13:  f378a7dc35e <  -:  ----------- Makefile: move $(comma), $(empty) and $(space) to shared.mak
14:  13cbb851d32 <  -:  ----------- Makefile: re-add and use the "shellquote" macros
15:  337953e4994 <  -:  ----------- Makefile: add a "TRACK_template" for GIT-*{FLAGS,DEFINES,...}
16:  5bb597c1993 <  -:  ----------- Makefile: add "$(QUIET)" boilerplate to shared.mak
17:  3c4d0589667 <  -:  ----------- Makefile: use $(wspfx) for $(QUIET...) in shared.mak
18:  be5882b2c99 <  -:  ----------- Makefiles: add and use wildcard "mkdir -p" template
19:  2710f8af6cd =  1:  1fafa6c643b Makefile: correct the dependency graph of hook-list.h
20:  59f22a0269a <  -:  ----------- Makefile: use $(file) I/O instead of "FORCE" when possible
21:  dd569a59c74 <  -:  ----------- Makefile: disable GNU make built-in wildcard rules
22:  4168a7e3b30 <  -:  ----------- Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
23:  48a3927d972 <  -:  ----------- Makefile: move ".SUFFIXES" rule to shared.mak

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9c00a793e47..710e7db89bf 100644
--- a/Makefile
+++ b/Makefile
@@ -2222,9 +2222,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 		$(filter %.o,$^) $(LIBS)
 
 help.sp help.s help.o: command-list.h
-hook.sp hook.s hook.o: hook-list.h
+builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
-- 
2.34.1.1119.g7a3fc8778ee

