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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC39AC433E9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C9922CF8
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbhAET0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbhAET0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:26:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D97BC061795
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:24:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o19so1140846lfo.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ayM9kLV7lJvZ+kQc7BAf+3o6iyHcSb3H+W8asukRojQ=;
        b=sPT8hKUYnFyAqlfSrAjHfThpaAEE8DfusaBwvX5hbZvmzE6VmBKzdX/lIG7o9Z+Gjo
         6oaq7uCs953YiGsR+4hYOB4U967ADcNVNu9navUIz3XmAjPllcxT+mLL2S/2T9LmZet3
         s2wGCCL5dofrmhpLBW5XxtlCUBNEOXq68TbFDPXdAiUq4M4ztojHh4XvR5hAZbvPwXGv
         UvPjQr3IPH2LhVUlJsZ2KEozn2yG672F0qHkx+gW6xreQFNIRTJ7DljsffwbpKOYZbdT
         pLojGgIGGFxL0T3mzie2reaUr7qkGhzht5mXDkaQats7KdumVBxY0v8DcJ2pQRZwpz9+
         IE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ayM9kLV7lJvZ+kQc7BAf+3o6iyHcSb3H+W8asukRojQ=;
        b=EvgJ5pqRLGHvs5KAHKgtft6gx4IlJCs/CsxR47/mRdBRV0XNpF0uIOjv34NbHR1K3C
         I5/H00U8hbcjqs1EvEwmgsEBEB74b3o6LND11QI1To5do0Vv8+KQAmlz0+QS5txGy1VV
         /nFGHpc0n6Tb07PTyw/VSAY5ZDL5vu9gCJN6RZ3N61jVjC6+av76qkCNk4pSLrfI+qRl
         3s5cjpl+/x/4N12zpfFbEUc8+8v6iUmo+DJwSYnYkXDEEClYnn0cw/C3vjPvlvtKnSjh
         VQf5S6vOtSMCa/LCzf7IWqYP/TOlWgQZkh4vpBhfdlvfc9SLQdGkjuctbvAGW4M/yaJi
         muVw==
X-Gm-Message-State: AOAM530xqmbBSl7cnXgwl+Lb2EJbFbxmC8wg/xisfgtz8M2TSJtkaRBk
        iZfj8fXCDuEPOQpoVKK0HwWxPBGE9Go=
X-Google-Smtp-Source: ABdhPJxgKryPv6w0ljhYvCm1H6u8Qk5R8TsgjCwG7xrZG3ogXGIawofbSC4cR1GqNPVK/oKXgflfKQ==
X-Received: by 2002:ac2:446d:: with SMTP id y13mr294357lfl.615.1609874677563;
        Tue, 05 Jan 2021 11:24:37 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id h1sm9116lfc.121.2021.01.05.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:24:37 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 1/5] builtin/gc: don't peek into `struct lock_file`
Date:   Tue,  5 Jan 2021 20:23:46 +0100
Message-Id: <bbf24f7677eed41b80562d153b35be314cfb2750.1609874026.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609874026.git.martin.agren@gmail.com>
References: <cover.1609874026.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A `struct lock_file` is pretty much just a wrapper around a tempfile.
But it's easy enough to avoid relying on this. Use the wrappers that the
lock file API provides rather than peeking at the temp file or even into
*its* internals.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4c24f41852..64f2b52d6e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -92,7 +92,7 @@ static void process_log_file(void)
 		 */
 		int saved_errno = errno;
 		fprintf(stderr, _("Failed to fstat %s: %s"),
-			get_tempfile_path(log_lock.tempfile),
+			get_lock_file_path(&log_lock),
 			strerror(saved_errno));
 		fflush(stderr);
 		commit_lock_file(&log_lock);
@@ -1518,7 +1518,7 @@ static int update_background_schedule(int run_maintenance)
 	strvec_split(&crontab_list.args, crontab_name);
 	strvec_push(&crontab_list.args, "-l");
 	crontab_list.in = -1;
-	crontab_list.out = dup(lk.tempfile->fd);
+	crontab_list.out = dup(get_lock_file_fd(&lk));
 	crontab_list.git_cmd = 0;
 
 	if (start_command(&crontab_list)) {
@@ -1533,7 +1533,7 @@ static int update_background_schedule(int run_maintenance)
 	 * Read from the .lock file, filtering out the old
 	 * schedule while appending the new schedule.
 	 */
-	cron_list = fdopen(lk.tempfile->fd, "r");
+	cron_list = fdopen(get_lock_file_fd(&lk), "r");
 	rewind(cron_list);
 
 	strvec_split(&crontab_edit.args, crontab_name);
-- 
2.30.0

