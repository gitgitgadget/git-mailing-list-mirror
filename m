Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA88320A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbdJAO47 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:56:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50216 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdJAO46 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:56:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id u138so6389513wmu.5
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXoq3qn1jD5YH8CT7iiU870cOJ57eOQvM2SSUgpUjWQ=;
        b=JOLhzGqRDCkNRqgRazxOjRXHeiW/XQPIAKmUGoo+zieZ21CFWYqEoC3zB093f9zQzm
         0sCtKv6zB/t/kziSATqlGDgTvVlthsbCZUNPdc6DGoI6mmy+/vrC75+wtmHpPdZzlUdM
         Meoz5/d8JyaFqNoLjmwAI9qRF4h4aeD91l5im+Z7bONp9yGHe2HafwBZOENN4rF5Dw/U
         gs2wuIMCyMWR9LN9I3hPh3e6lzpds4x5+Tm0Qj+qinOzrCSa6J3I+xAAKVRpTiiy6EWu
         IC2bSXFuRkBzSmuHU/nFRdKrqhE3i9pkWDAq/NzRxFB5L9B4zGJr8DdFLFI1T6bqHsds
         QVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXoq3qn1jD5YH8CT7iiU870cOJ57eOQvM2SSUgpUjWQ=;
        b=OCQNQt6+d13ugs3GTSTDQiDu2ULzbHeCxr0mBHB6ldrI1MzHvTUvlb+pP7o9PxiAti
         n+dEC7Bgvnr7315hKtnu7HNeerr5tmup24cWlV1tLa6M3swaynhS0pBIvkxa1WGPDXbn
         Nxo+3d0Y5ch54LFDyHhBxSz/Oo95pYGneesbDzl124tYYEIIKF7RtIR4UkYr9GZ0oClz
         0eiM7fz45IZOV7qNB/uPAr1R87e3J9X0o30Yn9N6xKLFx8gY+PJ534QUMRFkRlkOWNWC
         TP4fgtcbXGxYVhm+5GAQaU11B9QSeC9eCVtux2JvA9KBWr4ZH8UmyiJxXnqROa6G81Yd
         adWQ==
X-Gm-Message-State: AMCzsaVcJSQ9hkwYTesc05mxZ+2hEOVzupdb4LvnQByevvHjmMH6m7GT
        l1GGbIxRE+A87fYrlG5BG6YAzQ==
X-Google-Smtp-Source: AOwi7QCr83W50dhvLGdm7PKq9Y6Hk9fp42TWr87sIYGzFuPGqbqPsHV2qQkFlss2nM2imuUw3rq7gg==
X-Received: by 10.28.5.193 with SMTP id 184mr8535645wmf.142.1506869816553;
        Sun, 01 Oct 2017 07:56:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:56:55 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 07/11] apply: remove `newfd` from `struct apply_state`
Date:   Sun,  1 Oct 2017 16:56:08 +0200
Message-Id: <cede314e90ece6e4168634f5469f6c6f9883e375.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com>
References: <cover.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to a previous patch, we do not need to use `newfd` to signal
that we have a lockfile to clean up. We can just unconditionally call
`rollback_lock_file`. If we do not hold the lock, it will be a no-op.

Where we check `newfd` to decide whether we need to take the lock, we
can instead use `is_lock_file_locked()`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 apply.c | 17 ++++++-----------
 apply.h |  3 +--
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/apply.c b/apply.c
index 5a6ca10a7..d676debd5 100644
--- a/apply.c
+++ b/apply.c
@@ -79,7 +79,6 @@ int init_apply_state(struct apply_state *state,
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
-	state->newfd = -1;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
@@ -4705,13 +4704,13 @@ static int apply_patch(struct apply_state *state,
 		state->apply = 0;
 
 	state->update_index = state->check_index && state->apply;
-	if (state->update_index && state->newfd < 0) {
+	if (state->update_index && !is_lock_file_locked(&state->lock_file)) {
 		if (state->index_file)
-			state->newfd = hold_lock_file_for_update(&state->lock_file,
-								 state->index_file,
-								 LOCK_DIE_ON_ERROR);
+			hold_lock_file_for_update(&state->lock_file,
+						  state->index_file,
+						  LOCK_DIE_ON_ERROR);
 		else
-			state->newfd = hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
+			hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
 	}
 
 	if (state->check_index && read_apply_cache(state) < 0) {
@@ -4913,16 +4912,12 @@ int apply_all_patches(struct apply_state *state,
 			res = -128;
 			goto end;
 		}
-		state->newfd = -1;
 	}
 
 	res = !!errs;
 
 end:
-	if (state->newfd >= 0) {
-		rollback_lock_file(&state->lock_file);
-		state->newfd = -1;
-	}
+	rollback_lock_file(&state->lock_file);
 
 	if (state->apply_verbosity <= verbosity_silent) {
 		set_error_routine(state->saved_error_routine);
diff --git a/apply.h b/apply.h
index cf00cda17..dc4a01905 100644
--- a/apply.h
+++ b/apply.h
@@ -36,9 +36,8 @@ enum apply_verbosity {
 struct apply_state {
 	const char *prefix;
 
-	/* These are lock_file related */
+	/* Lock file */
 	struct lock_file lock_file;
-	int newfd;
 
 	/* These control what gets looked at and modified */
 	int apply; /* this is not a dry-run */
-- 
2.14.1.727.g9ddaf86

