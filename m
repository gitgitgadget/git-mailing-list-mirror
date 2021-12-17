Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FBAC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhLQATU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhLQATT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:19:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70275C06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:19:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s1so982158wrg.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8n4uyFXNxG5+N1SkVBgQuq2lgsQ6qHajLiT48+FGN8=;
        b=EnizcpS8SLq0BBfI2JhT0IZpvzy4zXvYv7uOOLXBZbCIuMbwCL8URMs3qeec22jIIp
         MKMzNNgMsTNCGBNTTo4Bu8y84lYaLZ7w8TMNOPy7Scnddeb4KDF7BUAj6gANpc7Bu7Q2
         4CgLy6SBbwfyPDcs6B2dyPrA1zswO+A6w6JY7Agv/TG5GRyQR/f7YeH7zgp79Jr6Fdck
         tPwULBDsy5SiekbWgTYdFNQpQKomjFuSxwrRdiUTN5AxECiKmgQOAZz3eXyu4GNvquIu
         Erd6ai4MQWpvgSnPhoDPKLEH/JugxC23/HufHq0sxUdQ/dmGh9AvtcBA+u0XZoxWIl7e
         d+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8n4uyFXNxG5+N1SkVBgQuq2lgsQ6qHajLiT48+FGN8=;
        b=BB4IDreezKW+sCFge+LJOJovGCfz4zMs2Npbnw+3lXFh4FL6QWQ6Mh0LKDu8clKup5
         O9A0zAMtdyRhJdm3nSi6+eHWTQC6Hpi7q3qJ3qQjK+CIBWQwHyrlNJDjin6BpLpuXocp
         naluk0p4kUZ9Kp2JBHWYvGY4N020338c7Np7OCJUt2bvi7lko+Kk2EtIL+fdyOIPOXyn
         Nx1JQkoz6mGQ9/eJTYAu3qiLdlrbH3Oq7TTPMuVkdb85qAzSJbeNBjgngUl0gX0fpGU8
         xfzdVDXNpo9gmx7AYa2Wo0sOrb7+zuX16yYfrAMFMLp9g33UfFO0DSorjjKAaa00ry97
         RH/A==
X-Gm-Message-State: AOAM533l+oA0gWIq+4y8WNR+XAiPnscBo0IYJbSvsbweBInig9f4oQ6y
        qeh7rCCXK/Tn4r9jjkTQwPS3WnQPAWAv1A==
X-Google-Smtp-Source: ABdhPJxBv3M85X28+VZKy25l/M13/J+wRixIk8npKoyTQnuUJFWQ2GcK5Y1h2CzfWEvjSXk2ye2+0A==
X-Received: by 2002:a5d:47aa:: with SMTP id 10mr340230wrb.50.1639700357680;
        Thu, 16 Dec 2021 16:19:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g11sm41892wri.73.2021.12.16.16.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:19:17 -0800 (PST)
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
Subject: [PATCH] Makefile: remove -DPAGER_ENV from BASIC_CFLAGS
Date:   Fri, 17 Dec 2021 01:19:15 +0100
Message-Id: <patch-1.1-90d1e77ad5e-20211217T001628Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove -DPAGER_ENV from the BASIC_CFLAGS and instead have it passed
via the EXTRA_CPPFLAGS passed when compiling pager.c.

This doesn't change anything except to make it clear that only pager.c
needs this, as it's the only user of this define. See
995bc22d7f8 (pager: move pager-specific setup into the build,
2016-08-04) for the commit that originally added this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
A new trivial fix that wasn't in the ab/make-dependency topic.

This one doesn't really matter for now, before we over-provided
pager_env, now we don't. We can know we this change is OK because if
we get it wrong we'd get a compile error.

But in general these -D variables are broken in various ways, either
through bad escaping, or us not re-building things when they
change. I've got some later fixes to address those, and having a
starting point where variables map to they files they're needed in
will help make those changes smaller and easier to review.

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
19:  2710f8af6cd <  -:  ----------- Makefile: correct the dependency graph of hook-list.h
20:  59f22a0269a <  -:  ----------- Makefile: use $(file) I/O instead of "FORCE" when possible
21:  dd569a59c74 <  -:  ----------- Makefile: disable GNU make built-in wildcard rules
22:  4168a7e3b30 <  -:  ----------- Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
23:  48a3927d972 <  -:  ----------- Makefile: move ".SUFFIXES" rule to shared.mak
 -:  ----------- >  1:  90d1e77ad5e Makefile: remove -DPAGER_ENV from BASIC_CFLAGS

 Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 9c00a793e47..af0bbfb5d2f 100644
--- a/Makefile
+++ b/Makefile
@@ -2111,11 +2111,6 @@ ifdef DEFAULT_HELP_FORMAT
 BASIC_CFLAGS += -DDEFAULT_HELP_FORMAT='"$(DEFAULT_HELP_FORMAT)"'
 endif
 
-PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
-PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
-PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
-BASIC_CFLAGS += -DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
-
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
@@ -2230,6 +2225,12 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
+PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
+PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
+PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
+pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
+	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
+
 version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
 version.sp version.s version.o: EXTRA_CPPFLAGS = \
 	'-DGIT_VERSION="$(GIT_VERSION)"' \
-- 
2.34.1.1119.g7a3fc8778ee

