Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E623DC32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4B622522
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="T5i+87yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgAPClN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:41:13 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42391 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgAPClM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:41:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so17674152qtq.9
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoUs2sDzjtIGCpXESopkf1HrrSi3pqdiwKh2HJQgjCQ=;
        b=T5i+87yIOJ26Y/kcRU+w1Rhc1zrlnjm5FPGGG9tGbwzkhusvzlIH4BFKkawB2GF/Y6
         QT1zc4F7XhbkI3DrD4XWmzpP2PeP4ZPTu7BBWuCVpngM7zpZRPh244FuVLj0sZJBYS5b
         +PZuNihwSq86F4KbnvMjvgqroGBejA+qDevRPTnLk0mK+KhWzrDvO3VXU2WFFk1qVHcW
         p5ThXlabknTUgDHnQqA39lBX0vZ3DRvGQZF0sqHeczV+zx0sQrmiTCD/DuJbLyeFfrrX
         H71ypvFAMrFezgks+dvD5eRusPs2x5ji8ls31YY01LNqzAL15G7wh1VkZztZv0kZuk+o
         jkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoUs2sDzjtIGCpXESopkf1HrrSi3pqdiwKh2HJQgjCQ=;
        b=bx9fqBSxt/Af7tVVCef9ccegyi9cR0gwhGKAZHxRAb0SSve/toCbYiEhdp0RwjKhGw
         xmV2tusNRoqzv8zgeH5m/hreQ50NwTuwENV2GCNJuyV7bwNJ4khD1VswTTkuraKx1vY6
         SCIHAKEM1uXEgaAfVvFPT0HV448fv0CLlaskQItxPCzd9HnQ5pMrxgKjlVB806rDo2KV
         A/h3bGeppU/8unE5Yr6z7MG4buu5RSTWwTI8GcbVblvk6AJQ2ZmZ57Jo0OpVys2b3NkL
         A0XFM5Ntm9DRBmb4YNYFlSr47ibxYPUlWb5jgRHDjnJ6a/2ZvvCWtqJ4xMNNlRL8YgJQ
         UUzw==
X-Gm-Message-State: APjAAAUZ4pLq8b3QrEjBachP74bwG5wAZXZE8p+KSTL6Uj3PhDkNqcMB
        P2dokPUdLqXeEUOA+KAOWFX+vBLY1O4=
X-Google-Smtp-Source: APXvYqwEyqZWmYyJGURbH19vZZPI6bGS2DEIFqS6NOZieCl0RPzwvAMNK+xm1x7MbaqtC5PP3RTshA==
X-Received: by 2002:ac8:3496:: with SMTP id w22mr343306qtb.47.1579142471018;
        Wed, 15 Jan 2020 18:41:11 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:41:10 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Subject: [PATCH v3 09/12] grep: protect packed_git [re-]initialization
Date:   Wed, 15 Jan 2020 23:39:57 -0300
Message-Id: <0ccf79ba863a1a512506cc3aae4cc523d64ab8ae.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some fields in struct raw_object_store are lazy initialized by the
thread-unsafe packfile.c:prepare_packed_git(). Although this function is
present in the call stack of git-grep threads, all paths to it are
currently protected by obj_read_lock() (and the main thread usually
indirectly calls it before firing the worker threads, anyway). However,
it's possible that future modifications add new unprotected paths to it,
introducing a race condition. Because errors derived from it wouldn't
happen often, it could be hard to detect. So to prevent future
headaches, let's force eager initialization of packed_git when setting
git-grep up. There'll be a small overhead in the cases where we didn't
really need to prepare packed_git during execution but this shouldn't be
very noticeable.

Also, packed_git may be re-initialized by
packfile.c:reprepare_packed_git(). Again, all paths to it in git-grep
are already protected by obj_read_lock() but it may suffer from the same
problem in the future. So let's also internally protect it with
obj_read_lock() (which is a recursive mutex).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 8 ++++++--
 packfile.c     | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index ac3d86c2e5..1535fd50f8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -24,6 +24,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "object-store.h"
+#include "packfile.h"
 
 static char const * const grep_usage[] = {
 	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
@@ -1074,11 +1075,14 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			skip_first_line = 1;
 
 		/*
-		 * Pre-read gitmodules (if not read already) to prevent racy
-		 * lazy reading in worker threads.
+		 * Pre-read gitmodules (if not read already) and force eager
+		 * initialization of packed_git to prevent racy lazy
+		 * reading/initialization once worker threads are started.
 		 */
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
+		if (startup_info->have_repository)
+			(void)get_packed_git(the_repository);
 
 		start_threads(&opt);
 	} else {
diff --git a/packfile.c b/packfile.c
index 24a73fc33a..946ca83e7a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1004,12 +1004,14 @@ void reprepare_packed_git(struct repository *r)
 {
 	struct object_directory *odb;
 
+	obj_read_lock();
 	for (odb = r->objects->odb; odb; odb = odb->next)
 		odb_clear_loose_cache(odb);
 
 	r->objects->approximate_object_count_valid = 0;
 	r->objects->packed_git_initialized = 0;
 	prepare_packed_git(r);
+	obj_read_unlock();
 }
 
 struct packed_git *get_packed_git(struct repository *r)
-- 
2.24.1

