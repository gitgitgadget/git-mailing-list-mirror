Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FD2C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D1A60FED
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhI0Ali (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhI0Alf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:41:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3442C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v17so3761074wrv.9
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0qjZkl4wtiy7CddcaIfyCLaqwyu+OzpMk8WorwEtHY=;
        b=Rt1FFQUgpByq0CLPB8Fr2UAO2bDvZKXvLWZdbYQNQdwntOOg2i1qtwjpx9Rz/kHBE9
         1FimPKy5vJiBWYb9Q7x2tw85o0XpqvdFWXm6XMyAyLOo+B3GyaMXyv0ixFl8u2eSprXc
         0T1mf6vYI1y6RE8Z8lypv4mnm3jX20VxdW3T6ANBzCTgxCL7izCcG6xQRI+mdzADTj6w
         n4ZzbiivSzSeyPsGMFOgxcECjRbMpBKpFgOe6zMz2Vj0+5+LsdnxU3UuoDbuCN4WpBoQ
         weY69lSq5dJ1auYOi0e9dEgBR1gv77JsnicmW9C6OeGd01M0VKeI3cwcmQyy1rBZXDM/
         aUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0qjZkl4wtiy7CddcaIfyCLaqwyu+OzpMk8WorwEtHY=;
        b=cSt15gkieXs4RdZckTPWJmviX3Kq4nY7T1OMaISXn05w5mMZQLfir1ikFN0y0HVXst
         vDGlutfTEaAhtdtM/6cSvnPXYniGycB308NhrS7rQ5QhrVv3emmFrYmVqVTg2vIpZ8ok
         NFx2vwhSRSfmHDT5QijA87oTaU8gzisahj6v5psnKCf2dq1V6lq87ePc1jHvLy+VBjAO
         JQ9LXb+kGu/wIHUQwkMKC+5lDUm8J4PMJ0ERMeB0gd1I585g9UW/OxwmsTqem+8R/XQP
         DSyiK/huFrgnhPdyVuac6zsNQq/JkUMA5B7fOagM0+3/bwVMBLJFZspOzx0cl67gBxyh
         8+gA==
X-Gm-Message-State: AOAM531w9KU2k6zWTRXfVYGMjhyxJmviPOp5SASq6BLHBBmGHusG3Lgs
        MwfhEPKsEsoxKdLBLQFE4IY/RIS14CV4hA==
X-Google-Smtp-Source: ABdhPJw0q5s99oq+i9By7tl4rdz21XTLJp0VVmidQzaebQGEQJuRONlR6QR6WymRXv+lumFq8PnfDg==
X-Received: by 2002:a5d:4d91:: with SMTP id b17mr24861975wru.321.1632703197129;
        Sun, 26 Sep 2021 17:39:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l26sm19070162wmi.25.2021.09.26.17.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:39:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] *.h _INIT macros: don't specify fields equal to 0
Date:   Mon, 27 Sep 2021 02:39:50 +0200
Message-Id: <patch-3.5-9e45d2e7bb3-20210927T003330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the initialization of "struct strbuf" changed in
cbc0f81d96f (strbuf: use designated initializers in STRBUF_INIT,
2017-07-10) to omit specifying "alloc" and "len", as we do with other
"alloc" and "len" (or "nr") in similar structs.

Let's likewise omit the explicit initialization of all fields in the
"struct ipc_client_connect_option" struct added in
59c7b88198a (simple-ipc: add win32 implementation, 2021-03-15).

Finally, start incrementally changing the same pattern in
"t/helper/test-run-command.c". This change was part of an earlier
on-list version[1] of c90be786da9 (test-tool run-command: fix
flip-flop init pattern, 2021-09-11).

1. https://lore.kernel.org/git/patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 simple-ipc.h                | 6 +-----
 strbuf.h                    | 2 +-
 t/helper/test-run-command.c | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/simple-ipc.h b/simple-ipc.h
index 2c48a5ee004..08b2908d5f8 100644
--- a/simple-ipc.h
+++ b/simple-ipc.h
@@ -65,11 +65,7 @@ struct ipc_client_connect_options {
 	unsigned int uds_disallow_chdir:1;
 };
 
-#define IPC_CLIENT_CONNECT_OPTIONS_INIT { \
-	.wait_if_busy = 0, \
-	.wait_if_not_found = 0, \
-	.uds_disallow_chdir = 0, \
-}
+#define IPC_CLIENT_CONNECT_OPTIONS_INIT { 0 }
 
 /*
  * Determine if a server is listening on this named pipe or socket using
diff --git a/strbuf.h b/strbuf.h
index 5b1113abf8f..3b36bbc49f0 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -70,7 +70,7 @@ struct strbuf {
 };
 
 extern char strbuf_slopbuf[];
-#define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
+#define STRBUF_INIT  { .buf = strbuf_slopbuf }
 
 /*
  * Predeclare this here, since cache.h includes this file before it defines the
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 14c57365e76..50bb98b7e04 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -61,7 +61,7 @@ struct testsuite {
 	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
 };
 #define TESTSUITE_INIT \
-	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, 0, 0, 0, 0, 0, 0, 0 }
+	{ STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP }
 
 static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
 		     void **task_cb)
-- 
2.33.0.1294.g2bdf2798764

