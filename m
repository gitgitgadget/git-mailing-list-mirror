Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AB0C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883C861476
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbhGAKyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbhGAKyH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 06:54:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30F0C0617A8
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 03:51:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a13so7585304wrf.10
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWQ5jZWLEVfefRz+/qF73AjlxA+QRJVIgn/xB/cxI08=;
        b=UXHfD6EtkZcDUdOtnB0LXUJ/45HakeSYrWtw31TjQbgNBfSmR8AtHycilEWX/wS22x
         IrjK15Bp7x0A3RIKT7KaILQV7wWBVJcQ652mTYMTql8Vm/162Ss3a1XXQkkA3Yh5heka
         KaepG7OTlFLqk1oAQ41DDacSnhRgPT1BFKoQ5i14jSHSLikIbTvAKRyD1cUNFSHk7Ljw
         63HfVAcSIXHy8sLVg6ys+HNB1qrxSOIfsFIW1eA1cwRiMyh9X7PjIVrIoRgSQHJ+o8rd
         6/6GqQWzJb4N1UAIjKdDn5a3MWXX2nebvJB/MujfGvit/n1zW0vsB5QRXSJ9dKUI+/vw
         aK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWQ5jZWLEVfefRz+/qF73AjlxA+QRJVIgn/xB/cxI08=;
        b=gsnDKKEpo4R6SRyUJfYh9O34LjX/mKzWMmqSsnPUULjw9UKelCVCIxI57pNoueR8bU
         pKK9sE7uL9lCAdKeD5m4ZqrFyE8CaMk20zdEw+Cul4kwn74UgvLPSwi8Fgtx7+A0Y9fn
         ERfQ4IgJApYJnHZW3oklkNaCnMjOVU11BtkCeSdv91egtXo3M9k30QosgmzaE7yhlTXL
         77cF6396E/wFoBC18ju2F8j7eZpgJFc3xSbrR2pjvq3NmbwsTIujlO0wXexo0Hf8T5xx
         zVzf5sVhnYyA8sJIwpXj1Mpak+1kHSEMxH34PNYXAvMBbPpWplPE+a4dtLj3opcPGmKa
         uang==
X-Gm-Message-State: AOAM530qJ9lOK/ZH1SuYJfB5OXvGEq3bdPZRqLqau2JTSSQM55bl3vtr
        WjzZa7sl6GmIxojFP014MbK57XkdhEKzZQ==
X-Google-Smtp-Source: ABdhPJz9HcwE9sx4pGZU0azRk54QByGcgJRbPeRG1jc78YpzctHPyq/6seZWgdAwyERKTP8u5nU/Hw==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr18010537wrs.257.1625136695171;
        Thu, 01 Jul 2021 03:51:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9sm8015699wmm.17.2021.07.01.03.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:51:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] *.c *_init(): define in terms of corresponding *_INIT macro
Date:   Thu,  1 Jul 2021 12:51:26 +0200
Message-Id: <patch-2.5-955dbd1693d-20210701T104855Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g11c1df94a06
In-Reply-To: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the common patter in the codebase of duplicating the
initialization logic between an *_INIT macro and a
corresponding *_init() function to use the macro as the canonical
source of truth.

Now we no longer need to keep the function up-to-date with the macro
version. This implements a suggestion by Jeff King who found that
under -O2 [1] modern compilers will init new version in place without
the extra copy[1]. The performance of a single *_init() won't matter
in most cases, but even if it does we're going to be producing
efficient machine code to perform these operations.

1. https://lore.kernel.org/git/YNyrDxUO1PlGJvCn@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 credential.c  | 4 ++--
 json-writer.c | 6 ++----
 run-command.c | 5 ++---
 strbuf.c      | 4 ++--
 strmap.c      | 3 ++-
 strvec.c      | 5 ++---
 6 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/credential.c b/credential.c
index e5202fbef26..3c05c7c6691 100644
--- a/credential.c
+++ b/credential.c
@@ -10,8 +10,8 @@
 
 void credential_init(struct credential *c)
 {
-	memset(c, 0, sizeof(*c));
-	c->helpers.strdup_strings = 1;
+	struct credential blank = CREDENTIAL_INIT;
+	memcpy(c, &blank, sizeof(*c));
 }
 
 void credential_clear(struct credential *c)
diff --git a/json-writer.c b/json-writer.c
index aadb9dbddc3..f1cfd8fa8c6 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -3,10 +3,8 @@
 
 void jw_init(struct json_writer *jw)
 {
-	strbuf_init(&jw->json, 0);
-	strbuf_init(&jw->open_stack, 0);
-	jw->need_comma = 0;
-	jw->pretty = 0;
+	struct json_writer blank = JSON_WRITER_INIT;
+	memcpy(jw, &blank, sizeof(*jw));;
 }
 
 void jw_release(struct json_writer *jw)
diff --git a/run-command.c b/run-command.c
index be6bc128cd9..8750df16d89 100644
--- a/run-command.c
+++ b/run-command.c
@@ -11,9 +11,8 @@
 
 void child_process_init(struct child_process *child)
 {
-	memset(child, 0, sizeof(*child));
-	strvec_init(&child->args);
-	strvec_init(&child->env_array);
+	struct child_process blank = CHILD_PROCESS_INIT;
+	memcpy(child, &blank, sizeof(*child));
 }
 
 void child_process_clear(struct child_process *child)
diff --git a/strbuf.c b/strbuf.c
index 4df30b45494..c8a5789694c 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -52,8 +52,8 @@ char strbuf_slopbuf[1];
 
 void strbuf_init(struct strbuf *sb, size_t hint)
 {
-	sb->alloc = sb->len = 0;
-	sb->buf = strbuf_slopbuf;
+	struct strbuf blank = STRBUF_INIT;
+	memcpy(sb, &blank, sizeof(*sb));
 	if (hint)
 		strbuf_grow(sb, hint);
 }
diff --git a/strmap.c b/strmap.c
index 4fb9f6100ec..ee486357082 100644
--- a/strmap.c
+++ b/strmap.c
@@ -25,7 +25,8 @@ static struct strmap_entry *find_strmap_entry(struct strmap *map,
 
 void strmap_init(struct strmap *map)
 {
-	strmap_init_with_options(map, NULL, 1);
+	struct strmap blank = STRMAP_INIT;
+	memcpy(map, &blank, sizeof(*map));
 }
 
 void strmap_init_with_options(struct strmap *map,
diff --git a/strvec.c b/strvec.c
index 21dce0a7a4d..61a76ce6cb9 100644
--- a/strvec.c
+++ b/strvec.c
@@ -6,9 +6,8 @@ const char *empty_strvec[] = { NULL };
 
 void strvec_init(struct strvec *array)
 {
-	array->v = empty_strvec;
-	array->nr = 0;
-	array->alloc = 0;
+	struct strvec blank = STRVEC_INIT;
+	memcpy(array, &blank, sizeof(*array));
 }
 
 static void strvec_push_nodup(struct strvec *array, const char *value)
-- 
2.32.0.623.ge833f40cd87

