Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BCDC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412CA61052
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbhI0M41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhI0M4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 08:56:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD289C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:47 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v127so414458wme.5
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMl2rNRqmIceoX6PQudPvEO4FdVe1Vkf7tXGThl6Aa4=;
        b=YojSAqJfrUHbkYglpjtByz7QyuB1BwjuAC26k/gXfWWtPtuUjlz6PxfYrkOX7QT5UX
         Zk5Nrg/wSiUBjPkH/PBPFTyHtOf/vxaNQdGYUTO1zv0W90EAGGS0vOvK0fO4jXp/CNAD
         sqsntnjazon7+8kyLuHgCW5mIJPF3PgVlYzYyAOFyTk6wvpeeew0Gz0ZQPrR5SNOWiG2
         pUniyZLM6vYUMXhkS2DmEAzuxgrifUQjiISkyMY6Kwph52EVvExOurlm+lCwsCoW/54E
         il11VQC404X7OJco9BSl6xUAOMcYywhUAt41ArGm/jSCypPdciF6/4souLyxHdD8HTVU
         fdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMl2rNRqmIceoX6PQudPvEO4FdVe1Vkf7tXGThl6Aa4=;
        b=F8DwfYQXmxdwGZguTha1Ty3MKb/1xCoZkqnrfO7bgvGEdW4ZT/xN84GkR+KXdBteus
         Xf5F2sk/waCRxeg9V9Pnq1WxqAknfDgwggjLvfepT//SBO7f9uiqJtBfJVgRszDQsDQU
         k0KCeNrv2sOmOoXEHgJJl44y+GmCICI1jPQwLMnQu7SZPJCSzFVzLP68YuxPnsf8CFaJ
         psEO/SFImaCq1sG+ZFe9Klm8sCovXfHOLOyLaoN+2r0bqdPN5N9tAB+i9zK7iRnZh9s6
         7xyKCNqmT0DyC4cJXcDzcYUdHempGc3OPZe1RFhKNrO+ra7bkUGyTbQqFfN/DmgBS0Zp
         CuQA==
X-Gm-Message-State: AOAM53369cFmPIf3TFtx/fVxiHHjSaPZRmsEboP1b1ic92P1ew3mR0ae
        EkfRZztnB1mzFxPTs9zSAHhUJKGwB7Os5w==
X-Google-Smtp-Source: ABdhPJw1dNkVvlNPkcLu7mbfFWL7yjeL9DBLQ6gSJwURA3WarESeuu81lHz2oYaTTDGzIfjjttn4kg==
X-Received: by 2002:a1c:4e11:: with SMTP id g17mr15138361wmh.130.1632747286079;
        Mon, 27 Sep 2021 05:54:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w14sm16460434wro.8.2021.09.27.05.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:54:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] *.h _INIT macros: don't specify fields equal to 0
Date:   Mon, 27 Sep 2021 14:54:26 +0200
Message-Id: <patch-v2-3.5-590220bbdcc-20210927T124407Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
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

Do the same for a few other initializers, e.g. STRVEC_INIT and
CACHE_DEF_INIT.

Finally, start incrementally changing the same pattern in
"t/helper/test-run-command.c". This change was part of an earlier
on-list version[1] of c90be786da9 (test-tool run-command: fix
flip-flop init pattern, 2021-09-11).

1. https://lore.kernel.org/git/patch-1.1-0aa4523ab6e-20210909T130849Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h                     | 2 +-
 simple-ipc.h                | 6 +-----
 strbuf.h                    | 2 +-
 strvec.h                    | 2 +-
 submodule.h                 | 2 +-
 t/helper/test-run-command.c | 2 +-
 trace.h                     | 2 +-
 7 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index f6295f3b048..25c6b0b1200 100644
--- a/cache.h
+++ b/cache.h
@@ -1668,7 +1668,7 @@ struct cache_def {
 	int track_flags;
 	int prefix_len_stat_func;
 };
-#define CACHE_DEF_INIT { STRBUF_INIT, 0, 0, 0 }
+#define CACHE_DEF_INIT { STRBUF_INIT }
 static inline void cache_def_clear(struct cache_def *cache)
 {
 	strbuf_release(&cache->path);
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
diff --git a/strvec.h b/strvec.h
index 6b3cbd67589..a10aad5f645 100644
--- a/strvec.h
+++ b/strvec.h
@@ -33,7 +33,7 @@ struct strvec {
 	size_t alloc;
 };
 
-#define STRVEC_INIT { empty_strvec, 0, 0 }
+#define STRVEC_INIT { empty_strvec }
 
 /**
  * Initialize an array. This is no different than assigning from
diff --git a/submodule.h b/submodule.h
index 4578e501b86..35d18c7868a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,7 +37,7 @@ struct submodule_update_strategy {
 	enum submodule_update_type type;
 	const char *command;
 };
-#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
+#define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED}
 
 int is_gitmodules_unmerged(struct index_state *istate);
 int is_writing_gitmodules_ok(void);
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
diff --git a/trace.h b/trace.h
index 0dbbad0e41c..74f62919c57 100644
--- a/trace.h
+++ b/trace.h
@@ -89,7 +89,7 @@ struct trace_key {
 
 extern struct trace_key trace_default_key;
 
-#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
+#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name }
 extern struct trace_key trace_perf_key;
 extern struct trace_key trace_setup_key;
 
-- 
2.33.0.1316.gb2e9b3ba3ae

