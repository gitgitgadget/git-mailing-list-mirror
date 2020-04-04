Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB10C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955DC2074B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvCGWO/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgDDBMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33399 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgDDBMV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id c14so8197400qtp.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kadXDH/XBsH/eMWSUaU7o3uCzdU2sPSmcuHCC3zx7aI=;
        b=kvCGWO/Bn4KJLHPVW2HRd50qA0IyhqciVPEgKyfw0MBPUxTsliDigZ9bXXD8oHYXXN
         ZczhNXOt1AyjAXx4lR9sgCebUkbBtd2l5Q4svf8MzACzQw11OqnrZ9niIUhLUABtsLuo
         fGTU4zGK564aqsfCAIlnneL1U0HDvXFMjSJi16u/GuTeY596BQsvX1pF6IY/eN/raIQ2
         G2jle3+m1Tj4yZpiQQKY/3ECSH68xVkDJ/IRVwPMYe/zWIxJF/tqhTRRnaMMSfWUqjVy
         YrQJcm0kI7ExSmmEyiL+7Mr2wwPTb1oqDzURWJdP831Scnc/fvmtP5akCWAMnT9Ujuhd
         FaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kadXDH/XBsH/eMWSUaU7o3uCzdU2sPSmcuHCC3zx7aI=;
        b=mdzRT1T6TVsbcT4tdBa/5jGD4VTWDS6fmjHi+yvD+IpeWHhsIUSlXzryPRtDx7Zhs/
         Aa6MqJZKA/sqqVpZV2zt6MIaQwKMZZnE2MW6r1C8GdpdLnWhDnIofq6e6ucerHMF+Byw
         BqknkfRFKOmsNQ6xSH5WFps6twfp51I8F9hE53dveoRo4f2jY09Tqpud0el9SstZdpCq
         uahhyISp+Drihq7iyyivEMlFLen105HYEO8V0XWsmKg8MT+AnG9C0znqMcosEhOP7tku
         rUXjykCZQbjo+R8+B063BQ+rK/tmorqF2DsVC8YBw+44U1PdfAeabjrz91tKvNeOrnLC
         JxzA==
X-Gm-Message-State: AGi0PuZ0SMnkfMP67KhlEkpMvZ7aKuqz0FmWN8gNzLtOgBHYbyCw6MWn
        OvlLmr9s+2ghuwhK46MU2rsWrxgE
X-Google-Smtp-Source: APiQypIci/Sia14yVgOjnlcdccCNTD9FOccDGIU3RgtmD+8nriRcSZj9nQc6C3u7Kurjh16aR5LTfQ==
X-Received: by 2002:ac8:4e0e:: with SMTP id c14mr10409018qtw.312.1585962740261;
        Fri, 03 Apr 2020 18:12:20 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:19 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 20/23] sequencer: implement apply_autostash_oid()
Date:   Fri,  3 Apr 2020 21:11:33 -0400
Message-Id: <598ddea6c1187d78f876136974822e65bbec146b.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split apply_save_autostash() into apply_autostash_oid() and
apply_save_autostash() where the former operates on an OID string and
the latter reads the OID from a file before passing it into
apply_save_autostash_oid().

This function is required for a future commmit which will rely on being
able to apply an autostash whose OID is stored as a string.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 38 ++++++++++++++++++++++++++------------
 sequencer.h |  1 +
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fb52583bc2..b4cab9632a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3699,26 +3699,18 @@ void create_autostash(struct repository *r, const char *path,
 	strbuf_release(&buf);
 }
 
-static int apply_save_autostash(const char *path, int attempt_apply)
+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
 {
-	struct strbuf stash_oid = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_oid, path,
-			   READ_ONELINER_SKIP_IF_EMPTY)) {
-		strbuf_release(&stash_oid);
-		return 0;
-	}
-	strbuf_trim(&stash_oid);
-
 	if (attempt_apply) {
 		child.git_cmd = 1;
 		child.no_stdout = 1;
 		child.no_stderr = 1;
 		argv_array_push(&child.args, "stash");
 		argv_array_push(&child.args, "apply");
-		argv_array_push(&child.args, stash_oid.buf);
+		argv_array_push(&child.args, stash_oid);
 		ret = run_command(&child);
 	}
 
@@ -3733,9 +3725,9 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 		argv_array_push(&store.args, "-m");
 		argv_array_push(&store.args, "autostash");
 		argv_array_push(&store.args, "-q");
-		argv_array_push(&store.args, stash_oid.buf);
+		argv_array_push(&store.args, stash_oid);
 		if (run_command(&store))
-			ret = error(_("cannot store %s"), stash_oid.buf);
+			ret = error(_("cannot store %s"), stash_oid);
 		else
 			fprintf(stderr,
 				_("%s\n"
@@ -3747,6 +3739,23 @@ static int apply_save_autostash(const char *path, int attempt_apply)
 				_("Autostash exists; creating a new stash entry."));
 	}
 
+	return ret;
+}
+
+static int apply_save_autostash(const char *path, int attempt_apply)
+{
+	struct strbuf stash_oid = STRBUF_INIT;
+	int ret = 0;
+
+	if (!read_oneliner(&stash_oid, path,
+			   READ_ONELINER_SKIP_IF_EMPTY)) {
+		strbuf_release(&stash_oid);
+		return 0;
+	}
+	strbuf_trim(&stash_oid);
+
+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
+
 	unlink(path);
 	strbuf_release(&stash_oid);
 	return ret;
@@ -3762,6 +3771,11 @@ int apply_autostash(const char *path)
 	return apply_save_autostash(path, 1);
 }
 
+int apply_autostash_oid(const char *stash_oid)
+{
+	return apply_save_autostash_oid(stash_oid, 1);
+}
+
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
diff --git a/sequencer.h b/sequencer.h
index 2d09c1ac0b..a90b768b74 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -195,6 +195,7 @@ void create_autostash(struct repository *r, const char *path,
 		      const char *default_reflog_action);
 int save_autostash(const char *path);
 int apply_autostash(const char *path);
+int apply_autostash_oid(const char *stash_oid);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.26.0.159.g23e2136ad0

