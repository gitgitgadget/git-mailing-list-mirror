Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9417BC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BEA86508A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhCPQSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbhCPQRz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:17:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6E8C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4098611wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AjQgJNWXfvobbj9iddcML7RrOX4HBJC1ewfMcW4b7ok=;
        b=UV7vAFEv5CyNwDiRPr8q5BrflQaWeO+SSFWl6wyfaedmgPmQLp7vH572Ehjd7S6A29
         zMQ7f0x8NJBrwfXZazKHPQn4WHrrsKLwTIZbWCGvKcE7oRky7q2IF94sjhHSsQc6cr87
         AqK34Sb9H2jjOkA0tjZd2wKvCgsQKKPEag5L2EjQCHkjMa9eFOa2A0dc3n0SKNjL5G8A
         E8NhICSmguvXYYUtNDAj/SAvlJ9O3IJYAmE0oHxrNcWUG1hackP6btSjz0qClaLYsjeR
         dO2QnVezX7GC64yjFiWe25wlonARVrPjdyfDyBWFyJKPOASKqUrEut/+qKugcTOeFYkh
         oZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjQgJNWXfvobbj9iddcML7RrOX4HBJC1ewfMcW4b7ok=;
        b=Y6+kj7dqty6uLmVxKs5uY85B2a+DDRTQ3z5E8asMxbW9rG7YBlEcUJ0sqxtXYwNxnu
         OCGciP4f6FFMr/jQTE0XNvZrHt+WpjZISZAO2oaRACEstzgE2YyStE0BeNojLpeP42uq
         yrjYnZJjxVE8pRTNRJTowRdbWhm52Pq1asO1M4fAPFMKOKu5CdU86IdL30Ej2+aT+n+3
         D8+fHSZh+07VdMYYNQKZ17Ezg+RpnR4+XcjbXx1hnym07awdtaxqunFP3wsk5adh/lSe
         3L9tIGQQShGpBPS8DO2mxthwAEbEGPQ1C1ZWOC107kuyRN9kCh+2mZ3H+UmkPu+L5XVH
         8G/A==
X-Gm-Message-State: AOAM532kzH3ZzhsSsS51VHdphZ5kKDWxStM95zwU/VlJnph0UbpuJT/z
        d3z0Fkr1A6DSsY4rIOW6bcQH4djnJ9nmPA==
X-Google-Smtp-Source: ABdhPJyHZ4DNH8Z3SFq5v8pt0hbh33aHD9yGHxHNf/Kc1SVYZqtZClACv5XzYCQKSL0sW1CXtYeV1Q==
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr374026wmm.149.1615911473239;
        Tue, 16 Mar 2021 09:17:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:17:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/22] fsck: API improvements
Date:   Tue, 16 Mar 2021 17:17:16 +0100
Message-Id: <20210316161738.30254-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-send of a rebased v3, which I sent at:
http://lore.kernel.org/git/20210306110439.27694-1-avarab@gmail.com as
seen in the range-diff there are no changes since v3. I'm just sending
this as a post-release bump of this, per
https://lore.kernel.org/git/xmqqy2etczqi.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (22):
  fsck.h: update FSCK_OPTIONS_* for object_name
  fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
  fsck.h: reduce duplication between FSCK_OPTIONS_{DEFAULT,STRICT}
  fsck.h: add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro
  fsck.h: indent arguments to of fsck_set_msg_type
  fsck.h: use "enum object_type" instead of "int"
  fsck.c: rename variables in fsck_set_msg_type() for less confusion
  fsck.c: move definition of msg_id into append_msg_id()
  fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
  fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
  fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
  fsck.h: re-order and re-assign "enum fsck_msg_type"
  fsck.c: call parse_msg_type() early in fsck_set_msg_type()
  fsck.c: undefine temporary STR macro after use
  fsck.c: give "FOREACH_MSG_ID" a more specific name
  fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
  fsck.c: pass along the fsck_msg_id in the fsck_error callback
  fsck.c: add an fsck_set_msg_type() API that takes enums
  fsck.c: move gitmodules_{found,done} into fsck_options
  fetch-pack: don't needlessly copy fsck_options
  fetch-pack: use file-scope static struct for fsck_options
  fetch-pack: use new fsck API to printing dangling submodules

 Makefile                 |   1 +
 builtin/fsck.c           |   7 +-
 builtin/index-pack.c     |  30 ++-----
 builtin/mktag.c          |   7 +-
 builtin/unpack-objects.c |   3 +-
 fetch-pack.c             |   6 +-
 fsck-cb.c                |  16 ++++
 fsck.c                   | 175 ++++++++++++---------------------------
 fsck.h                   | 132 ++++++++++++++++++++++++++---
 9 files changed, 211 insertions(+), 166 deletions(-)
 create mode 100644 fsck-cb.c

Range-diff:
 1:  9d809466bd =  1:  9cd942b526 fsck.h: update FSCK_OPTIONS_* for object_name
 2:  33e8b6d654 =  2:  d67966b838 fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
 3:  c23f7ce9e4 =  3:  211472e0c5 fsck.h: reduce duplication between FSCK_OPTIONS_{DEFAULT,STRICT}
 4:  5dde68df6c =  4:  70afee988d fsck.h: add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro
 5:  7ae35a6e9d =  5:  1337d53352 fsck.h: indent arguments to of fsck_set_msg_type
 6:  dfb5f754b3 =  6:  e4ef107bb4 fsck.h: use "enum object_type" instead of "int"
 7:  fd58ec73c6 =  7:  20bac3207e fsck.c: rename variables in fsck_set_msg_type() for less confusion
 8:  48cb4d3bb7 =  8:  09c3bba9e9 fsck.c: move definition of msg_id into append_msg_id()
 9:  2c80ad3203 =  9:  8067df53a2 fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
10:  92dfbdfb62 = 10:  bdf5e13f3d fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
11:  c1c476af69 = 11:  b03caa237f fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
12:  d55587719a = 12:  7b1d13b4cc fsck.h: re-order and re-assign "enum fsck_msg_type"
13:  32828d1c78 = 13:  a8e4ca7b19 fsck.c: call parse_msg_type() early in fsck_set_msg_type()
14:  5c62066235 = 14:  214c375a20 fsck.c: undefine temporary STR macro after use
15:  f8e50fbf7d = 15:  19a2499a80 fsck.c: give "FOREACH_MSG_ID" a more specific name
16:  cd74dee876 = 16:  6e1a7b6274 fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
17:  234e287d08 = 17:  42af4e164c fsck.c: pass along the fsck_msg_id in the fsck_error callback
18:  8049dc0739 = 18:  fa47f473a8 fsck.c: add an fsck_set_msg_type() API that takes enums
19:  4224a29d15 = 19:  4cc3880cc4 fsck.c: move gitmodules_{found,done} into fsck_options
20:  40b1346812 = 20:  fd219d318a fetch-pack: don't needlessly copy fsck_options
21:  8e418abfbd = 21:  e4cd8c250e fetch-pack: use file-scope static struct for fsck_options
22:  113de190f7 = 22:  fdbc3c304c fetch-pack: use new fsck API to printing dangling submodules
-- 
2.31.0.260.g719c683c1d

