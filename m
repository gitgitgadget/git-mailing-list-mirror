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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7CDC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DDF61476
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhGAKyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGAKyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 06:54:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA18C061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 03:51:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j1so7588013wrn.9
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWftUBBJ66R1Hq1bO/mpPUIrO5CfdUF6nTp6uUnBzaE=;
        b=Ks0v6bidWvVlHc5MZiWbC7Qh2NzDFBILR/lhb4kYuvNmaDnYwtKiZW0AvLsOeNq503
         Ld0ORpcTYwjq8dnOumZbxF2JrTtn9IoVXg4Z891nf0qb9CFAirV85IoOPR0JlviJR28W
         x8ih+0c/Hro4485No5A2JdH/GzE9qm13R5FD1kv19qGRhX8DcfC51HkiWDHyOamyFAzp
         B/hOSXJJR407+abddFRISmtVsOguXXX+ccm9pcBr3k9dObwuDN1fmTa8ydWOXC2ofY6O
         WYer3UcniguwSEEYUdJs2mLj+v4Glumb6KQ5WH3QYiVkvUIDuMMXy0ZEv/2uYKEbGqCG
         gJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWftUBBJ66R1Hq1bO/mpPUIrO5CfdUF6nTp6uUnBzaE=;
        b=gy0053gIVta66jpvSnECcB4Z//1As6fYzjyFbbz24psI0rDq7/yWYfKJHSyTq4T6cA
         x1Ymb+Mk/MwYf8RP4EbLO92VOgDtfrSxnJ2XAN/3VmfQRMbhW950ptkKXsskBVFh6lP0
         iNmxitrvsttbhRn4yaSFr0Z+IbVIVQHg/S6fM2F+a6ugQ5N7DNVic+8tVzqXt0AOylHH
         /gAgKq6gzJi4a8mdpVlCbzURQnVW3C5m4KHCkOcmMU3tKwJd5lembH12HfACHE9lWFdP
         MY7EZ9hhONZB1xu93O7w7LeH/KTlCMlXz6f4BnYDvZN0C+wDBfHOywcShP5/GecDgskF
         XoCg==
X-Gm-Message-State: AOAM530x3Jg9QJRVjjdRKKS1afhUcggUkAgxRzg38vReozk0FZFjMuSz
        bS8LywN4HGjRbXr9XZ514Td6E1HRQYQ+Mg==
X-Google-Smtp-Source: ABdhPJwfl+toyVTP7StIJf1kaU9xIi43QDrb5wttQ3xjqRqyy3VlUjbX8wPGRyT49yQVsUDEfxaP8w==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr44241478wru.318.1625136694440;
        Thu, 01 Jul 2021 03:51:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9sm8015699wmm.17.2021.07.01.03.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:51:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] *.h: move some *_INIT to designated initializers
Date:   Thu,  1 Jul 2021 12:51:25 +0200
Message-Id: <patch-1.5-9a92e7c216f-20210701T104855Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.632.g11c1df94a06
In-Reply-To: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210701T104855Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move *_INIT macros I'll use in a subsequent commits to designated
initializers. This isn't required for those follow-up changes, but
since I'm changing things in this are let's use the modern pattern
over the old one while we're at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 credential.h  | 4 +++-
 json-writer.h | 5 ++++-
 run-command.h | 5 ++++-
 string-list.h | 4 ++--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/credential.h b/credential.h
index c0e17e3554f..f430e77fea4 100644
--- a/credential.h
+++ b/credential.h
@@ -128,7 +128,9 @@ struct credential {
 	char *path;
 };
 
-#define CREDENTIAL_INIT { STRING_LIST_INIT_DUP }
+#define CREDENTIAL_INIT { \
+	.helpers = STRING_LIST_INIT_DUP, \
+}
 
 /* Initialize a credential structure, setting all fields to empty. */
 void credential_init(struct credential *);
diff --git a/json-writer.h b/json-writer.h
index 83906b09c17..209355e0f12 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -64,7 +64,10 @@ struct json_writer
 	unsigned int pretty:1;
 };
 
-#define JSON_WRITER_INIT { STRBUF_INIT, STRBUF_INIT, 0, 0 }
+#define JSON_WRITER_INIT { \
+	.json = STRBUF_INIT, \
+	.open_stack = STRBUF_INIT, \
+}
 
 void jw_init(struct json_writer *jw);
 void jw_release(struct json_writer *jw);
diff --git a/run-command.h b/run-command.h
index d08414a92e7..62a922d23fb 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,7 +141,10 @@ struct child_process {
 	void *clean_on_exit_handler_cbdata;
 };
 
-#define CHILD_PROCESS_INIT { NULL, STRVEC_INIT, STRVEC_INIT }
+#define CHILD_PROCESS_INIT { \
+	.args = STRVEC_INIT, \
+	.env_array = STRVEC_INIT, \
+}
 
 /**
  * The functions: child_process_init, start_command, finish_command,
diff --git a/string-list.h b/string-list.h
index 6c5d274126a..521b9c0748d 100644
--- a/string-list.h
+++ b/string-list.h
@@ -91,8 +91,8 @@ struct string_list {
 	compare_strings_fn cmp; /* NULL uses strcmp() */
 };
 
-#define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0, NULL }
-#define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
+#define STRING_LIST_INIT_NODUP { 0 }
+#define STRING_LIST_INIT_DUP   { .strdup_strings = 1 }
 
 /* General functions which work with both sorted and unsorted lists. */
 
-- 
2.32.0.623.ge833f40cd87

