Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7087D20323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935475AbdCVRDD (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:03:03 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35166 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935566AbdCVRC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:02:26 -0400
Received: by mail-qk0-f196.google.com with SMTP id o135so26887785qke.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 10:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwunFvRb1lfXhGpHJVlnvO5CoWMVWzXsshKeMZwZZVM=;
        b=mBlMGigsB6OQprklcaMO2waBTZW/af2+gM8plFcJMW4uS7qP4pWx3ovjItBX9Fe+pT
         kWTDLeonoW1FRsu2C1pvch0W4ZKjVYUyluRp+1w8OZw4a0BfptFSMe9kgdRQZ+3Q2N62
         qVbJxe/BrdyYp23JXsBYoemQMYU7xO19JywswwdLhK1l5ar6ElQEIk3FI8OUxQ09qYMZ
         awWgBRUeKpdBiP4ELV2t86oLsiav+gbkmxAz0ghbmn84v1bjXdovJa/4o1vr/Ppb5Awd
         O/TJltI9e1JfmLXDlIlmsfT3j/tmDExEmtcFLuBS3/HHIZ2trulrx3w9+0nUX7wNH6ut
         FBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwunFvRb1lfXhGpHJVlnvO5CoWMVWzXsshKeMZwZZVM=;
        b=HoDYl/Jb8tM8kzgt/D8/nnb+IjRupchB1qf09GSoWqfOgmzuzSg1FMahH9N3VM7XLJ
         nhTDEK9cpRkiY4cNhhsdFPmYVEflpy7CHf78kmAG2dCGXTTuStOer2EkamN9xmw9NXD/
         nqNjSO7QKaRjktJtPy1bi7npN9GWvWLGLkjfbBPY35YWC6vkBqUJ6XzEyS+sGdnrpZt3
         CQ3X56X7W1Q0KUP6YpNHUVwDxWoYSlVr7wJhvm0XNvbcSbmby+qXdxBH64INWuIHvWc9
         ETY7zUX1P7vdobKCdprGEzy6lN6DA5JkgI8duOvk55T/+0KbFYvk9PUM2R3bAJxfftfS
         2xFA==
X-Gm-Message-State: AFeK/H3NJcpoqqCJ4rEi55Zg/aa7iDgJ4MeadvEmXYU7U+nejzn8mGfu8KjIOIywn5bs7Q==
X-Received: by 10.55.170.68 with SMTP id t65mr35556552qke.303.1490201588477;
        Wed, 22 Mar 2017 09:53:08 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t47sm1334588qte.45.2017.03.22.09.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 09:53:07 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
Subject: [PATCH v1 0/3] Add support for downloading blobs on demand
Date:   Wed, 22 Mar 2017 12:52:17 -0400
Message-Id: <20170322165220.5660-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.0.gvfs.1.42.g0b7328eac2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a couple of patch series we’re working on (ObjectDB/Read-Object,
Watchman integration) where we could use the ability to have a
background process running that can accept multiple commands thus
avoiding the overhead of spawning a new process for every command.

The ability to do this was added in:

	Commit edcc85814c ("convert: add filter.<driver>.process option", 2016-10-16)
	keeps the external process running and processes all commands

but it is integrated into the convert code.  This patch series takes the
code from convert.c and refactors it into a separate “sub-process”
module so that we can centralize and reuse this logic in other areas.
Once the code was refactored into sub-process, convert.c was updated to
use the new module.

Ben Peart (3):
  pkt-line: add packet_write_list_gently()
  sub-process: refactor the filter process code into a reusable module
  convert: use new sub-process module for filter processes

 Documentation/technical/api-sub-process.txt |  55 ++++++++++
 Makefile                                    |   1 +
 convert.c                                   | 154 +++++-----------------------
 pkt-line.c                                  |  19 ++++
 pkt-line.h                                  |   1 +
 sub-process.c                               | 113 ++++++++++++++++++++
 sub-process.h                               |  46 +++++++++
 7 files changed, 259 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/technical/api-sub-process.txt
 create mode 100644 sub-process.c
 create mode 100644 sub-process.h

-- 
2.12.0.gvfs.1.42.g0b7328eac2

