Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221EDC433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353322AbhLXRh4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhLXRh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:37:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B8C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e5so5486267wmq.1
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FbwgZaiMNk25VMPP1HAQMqUeoTm1heo4WrjFzUsAF0=;
        b=IJ/yu00TxTqMa4KdE+dpXFZoEBjrQOIOw9O5fjfXkh0bY24SSzKCoR4qcFxIz54mq7
         i238+80RK7CvOLplRPr01YAi6L/x7ji4mBvizOup+yfMX6vJYAlzOpbwFd3bgZNlDGqf
         DK1RGSOTsk7RPAv7tjZ+kRzUl5IVQ4rK1RHqc/V+qgfJ0z8COWDjomPN8I85BzDcAcTF
         gy4eL3Z+Ts1OyjIOf0DkTNd5TDyZS00PkTnkuV4hX2d3MKbfCeGlIbSDIBeoyW1L6Cdx
         m0j+tqVaVzxGvIlVkyjouHjXIuEPCHuHSebxxKQPbaph5aVFMaMKtoAqJZtGOtUDt2oN
         F8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3FbwgZaiMNk25VMPP1HAQMqUeoTm1heo4WrjFzUsAF0=;
        b=MebEcmyJpePLfVlT2X7ECLTCwdRwNx382SFgR5Cp90OFxqjmUL5Zh3oSiDT+ucQN9v
         kbXAnE7uDPLZcMXAlRofd6CcWFEK+pLfW7PM0i5S0Y14HfKkXuAzb9JzbOm1XfRLIW5E
         Kfzc52z9YncBOvGwbpLgD8EtUzw84/w0z6ulj7QxgQwf8BhOZqtcoyleMLkjn1ns9fIH
         08CPSPRdjHJb30MSm6MeI1WmwBHNUAt3CZ4bcNzcNqvXPcCnaGtHUidgqHzV1VpCKX2t
         Qme5Uk7wDDTnPygGmS+1N1zLGBJlR1sQhwDC9JlzF/Vqj4SkYN12foX3QjSly8BzORYb
         ktGA==
X-Gm-Message-State: AOAM530q+FIR0EeO4TLEx7C1uQBWTq9S7Nn7Y/kThUnfGQ2IYJWX/ZZH
        I9J9hV74Fvt5OJrViqMXa0WgP+0MDGVCOQ==
X-Google-Smtp-Source: ABdhPJwdjfVPzzMN9aq1bTytI8Tj26LWWc9uR+ToIjwIqtH5ReWzOTSccmri7egKtTl+Orh0Ex3Ncg==
X-Received: by 2002:a1c:4b01:: with SMTP id y1mr4270948wma.75.1640367474198;
        Fri, 24 Dec 2021 09:37:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3sm8033518wro.22.2021.12.24.09.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:37:53 -0800 (PST)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] Makefile: optimize noop runs, add shared.mak
Date:   Fri, 24 Dec 2021 18:37:39 +0100
Message-Id: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1215.g6e154b84c77
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the v1 notes (among other things):
https://lore.kernel.org/git/cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com/

    This speeds up noop runs of "make" by a lot. After a "make" running a
    "make -j1" with this is ~1.5 faster than on "master"[2], and around 3x
    as fast with "make -j1 NO_TCLTK=Y" (the TCL part takes a lot of time,
    but that's another matter).

This v2 re-roll addresses trivial commit message/comment grammar/typo
issues pointed out by Eric Sunshine, thanks Eric!

Ævar Arnfjörð Bjarmason (8):
  Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
  Makefile: disable GNU make built-in wildcard rules
  Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
  Makefile: move ".SUFFIXES" rule to shared.mak
  Makefile: move $(comma), $(empty) and $(space) to shared.mak
  Makefile: add "$(QUIET)" boilerplate to shared.mak
  Makefile: use $(wspfx) for $(QUIET...) in shared.mak
  Makefiles: add and use wildcard "mkdir -p" template

 Documentation/Makefile |  63 +++-------------------
 Makefile               | 118 +++++++++++++----------------------------
 config.mak.uname       |   1 -
 shared.mak             | 109 +++++++++++++++++++++++++++++++++++++
 t/Makefile             |   3 ++
 t/interop/Makefile     |   3 ++
 templates/Makefile     |   8 ++-
 7 files changed, 160 insertions(+), 145 deletions(-)
 create mode 100644 shared.mak

Range-diff against v1:
1:  f74b47662b7 = 1:  b652fc78fda Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
2:  b0c63abe091 = 2:  b0c9be581a6 Makefile: disable GNU make built-in wildcard rules
3:  c6c6f7cf8d8 = 3:  ed6fd1c0bd1 Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
4:  ed64cd1bd4a = 4:  4c6d8089fff Makefile: move ".SUFFIXES" rule to shared.mak
5:  1749085b929 = 5:  f1f02c71dbc Makefile: move $(comma), $(empty) and $(space) to shared.mak
6:  c25284b24cf = 6:  fb877060d6b Makefile: add "$(QUIET)" boilerplate to shared.mak
7:  3daef7672be = 7:  90d804ea9a0 Makefile: use $(wspfx) for $(QUIET...) in shared.mak
8:  aca560ca410 ! 8:  59c1b7032db Makefiles: add and use wildcard "mkdir -p" template
    @@ Commit message
     
         But as it turns out we can use this neat trick of only doing a "mkdir
         -p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
    -    of a performance test similar to thatnoted downthread of [1] in [2]
    +    of a performance test similar to that noted downthread of [1] in [2]
         shows that this is faster, in addition to being less verbose and more
         reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):
     
    @@ shared.mak: ifndef V
     +## needed.
     +##
     +## Is racy, but in a good way; we might redundantly (and safely)
    -+## "mkdir -p" when running in parallel, but won't need to exhaustively
    ++## "mkdir -p" when running in parallel, but won't need to exhaustively create
     +## individual rules for "a" -> "prefix" -> "dir" -> "file" if given a
     +## "a/prefix/dir/file". This can instead be inserted at the start of
     +## the "a/prefix/dir/file" rule.
-- 
2.34.1.1215.g6e154b84c77

