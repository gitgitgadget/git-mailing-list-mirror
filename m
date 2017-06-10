Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30811FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 13:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbdFJNkp (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 09:40:45 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32858 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdFJNko (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 09:40:44 -0400
Received: by mail-qt0-f194.google.com with SMTP id w1so19546065qtg.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 06:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dlm6VmRHe3s69XDv8gLysCRcSMQ9A+rUS2c/9lRUOJg=;
        b=hl6R1m//RQ28MOiAze/VHgViqzDhRdGWIX7TeyNF90gsG9p1HIKbfjT/HJVq6Ct3bZ
         yD7GWXhga6FSFewYkEVsm21elchB87r7AYRQgeOMREBLOW3eYXG7N67uxLcLSaMgX67g
         4eY9mr1AL6IagWtR/CrGmuN5bUTc0YU7LlZ4+y/N2WxHXinhb/K9I1txXLKSM5dotwT4
         rZ8zMmWAKF5LN4JNxFhcA94M/6RUWqwG+1PWIvocbT9/fXQAz3LAyYrLiZozkfTTeojF
         bKWnQdpiWIzazxoO0W623EtCe9BH/czmaDUtr6tPILOoiEjFK6EnD3tx04cIYYJZyvc+
         mpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dlm6VmRHe3s69XDv8gLysCRcSMQ9A+rUS2c/9lRUOJg=;
        b=Rc0QyJaJKRWPeDHT0mynRSlCsr6M747iW/d8A90mL6qvCwGjEZfSzaHsvpdMRYo7cR
         s90SqrJ6vmBOQllwLrt/iCcyMhKk4TxYpqNg21iHbS1lOuKDBTPRA+Ek8nxkQxhWi8UT
         Ifg2+xqQxlfgi9Uzf5wSuj6odoG0exY+ol69czjm2BUKjCQOX2m4R8Me606p3qtyq7Zq
         JAH0fDY5mGv8WNLdrGXCCLfXFXZFs4kN/SSHJbGPmV9saa/fJCaHDm6Yb7PgQ3SxLpw1
         rTGTn3h047QZPhJD8/Ts6TtX9Endb2VRC6ljMVpxRuDdL39Pmd2jO6OYoaW0hFg+Fxq/
         8SCQ==
X-Gm-Message-State: AODbwcB2Qc3LXpCF5zUZ/goDpwUyyCLGIS2RLtVZJO31uh250onYKIx/
        oTU7ENXbLW4xcK3Sq98=
X-Received: by 10.200.35.122 with SMTP id b55mr26379133qtb.24.1497102043440;
        Sat, 10 Jun 2017 06:40:43 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f94sm2707503qtb.16.2017.06.10.06.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 06:40:42 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v5 0/7] Fast git status via a file system watcher
Date:   Sat, 10 Jun 2017 09:40:19 -0400
Message-Id: <20170610134026.104552-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V4 include:

fsmonitor.c:
	Only flag index dirty if fsmonitor extension is added or removed
	or if new cache or untracked cache entries are marked dirty

dir.c:
	If an untracked cache entry is flagged as fsmonitor_dirty,
	fall back to existing logic to stat the file and check for
	changes instead of assuming it is dirty.

hooks--query-fsmonitor.sample: 
	Optimize query to exclude transitory files (files that were
	created and deleted since the last call).
	
	Update path mangling on Windows to match Watchman beta.

test-drop-caches.c:
	Add perf helper to drop the disk cache on Windows.

p7519-fsmonitor.sh:
	Add perf test for fsmonitor changes

Ben Peart (7):
  bswap: add 64 bit endianness helper get_be64
  dir: make lookup_untracked() available outside of dir.c
  fsmonitor: teach git to optionally utilize a file system monitor to
    speed up detecting new or changed files.
  fsmonitor: add test cases for fsmonitor extension
  fsmonitor: add documentation for the fsmonitor extension.
  fsmonitor: add a sample query-fsmonitor hook script for Watchman
  fsmonitor: add a performance test

 Documentation/config.txt                 |   7 +
 Documentation/githooks.txt               |  23 +++
 Documentation/technical/index-format.txt |  19 +++
 Makefile                                 |   2 +
 builtin/update-index.c                   |   1 +
 cache.h                                  |   5 +
 compat/bswap.h                           |   4 +
 config.c                                 |   4 +
 dir.c                                    |  29 ++--
 dir.h                                    |   5 +
 entry.c                                  |   1 +
 environment.c                            |   1 +
 fsmonitor.c                              | 261 +++++++++++++++++++++++++++++++
 fsmonitor.h                              |   9 ++
 read-cache.c                             |  28 +++-
 t/helper/test-drop-caches.c              | 107 +++++++++++++
 t/perf/p7519-fsmonitor.sh                | 161 +++++++++++++++++++
 t/t7519-status-fsmonitor.sh              | 173 ++++++++++++++++++++
 templates/hooks--query-fsmonitor.sample  |  76 +++++++++
 unpack-trees.c                           |   1 +
 20 files changed, 904 insertions(+), 13 deletions(-)
 create mode 100644 fsmonitor.c
 create mode 100644 fsmonitor.h
 create mode 100644 t/helper/test-drop-caches.c
 create mode 100755 t/perf/p7519-fsmonitor.sh
 create mode 100755 t/t7519-status-fsmonitor.sh
 create mode 100755 templates/hooks--query-fsmonitor.sample

-- 
2.13.0

