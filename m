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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0829DC2BA19
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04F92074B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo5qrNJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgDDBMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43103 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgDDBMX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id o10so10136489qki.10
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3sXBy9fKrkislpfYTekmI52GIt5QopTZkA0tIscZsE=;
        b=Lo5qrNJVCWPtU65fCq/vPu3Fg123lVduVv1JBG7+s6k0zNVXyQNFDDf9V79A7OvWx8
         y1TGrdd4nWsOiOJAnI+FxQR9wDgBOIvvDNv96HgiPO08erOcxFqJouqSLoqk8kxhrxR3
         Ag3qnXSFi3uJQL6NHJQH+Dg+WMS9c4gtHFvQVlx+HW4Cha2qF5sWtB0xiMJKMyhJEaPb
         tXzUdPMVzWxPviIw4NbIl4lJ7h5oapiMotiG48O5oQrEtpWwUtKZZRF1NGWWQ0Tp+sD3
         +b3mGCzPmYWSAAPcmE4i/SXRSg/uwPM3s94poYGX7XL00okD/2S6sV8WNPlTXp6oAHY0
         jfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3sXBy9fKrkislpfYTekmI52GIt5QopTZkA0tIscZsE=;
        b=Un8I7brSuKK8JEuWzcvYkMBYm3PftCUE5KVFmA7if7I/MEqYgfJAAcwtPOHL2iQrra
         BJdk4+FmOhLykWsDkTxQV6PLYHSOMundHmgq2YJ+B14sT+mcysJ4SL/Yp7lMlBSyxLiK
         PWKSxP3nemjRLIzA6sxBhWuMa0RH/qGTB6KJKVJ8aoFx9HK3LkyyNqvwCA8custSbP0g
         Vc8ZCcYdc56DrepqwsPWT/3LL5gMpEYvZ3hEiTLM0SU1BJTRvA1uPyYuhAuvT0IjaQSS
         GXbQ7hXB0oPhMgGBvYyZImjigjlmmD+Zrq7mfMWkJdEPuCMZuIAPOuBPwizqtbivdeLn
         hwsA==
X-Gm-Message-State: AGi0PuY96JPAp7+4FA5whH0if2fXj/9m1uovvimopDFoYNSXfa40nUkV
        ++wGnnbE4KyahRpoiJRjJRxcdbaI
X-Google-Smtp-Source: APiQypKUq+++CSoLm2P5pFAY9sZRkDhUpRdAgCYZ9VXilOwW3CjieFeF6gK+kuM/9SwipOjV1av13Q==
X-Received: by 2002:a05:620a:9cd:: with SMTP id y13mr10952166qky.488.1585962739361;
        Fri, 03 Apr 2020 18:12:19 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:18 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 19/23] sequencer: implement save_autostash()
Date:   Fri,  3 Apr 2020 21:11:32 -0400
Message-Id: <75dc3f10a1aac24007b660a02ce829c8702ffd0e.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract common functionality of apply_autostash() into
apply_save_autostash() and use it to implement save_autostash(). This
function will be used in a future commit.

The difference between save_autostash() and apply_autostash() is that
the latter does not try to apply the stash. It skips that step and
just stores the created entry in the stash reflog.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 37 +++++++++++++++++++++++++++----------
 sequencer.h |  1 +
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5dd1c2438e..fb52583bc2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3699,7 +3699,7 @@ void create_autostash(struct repository *r, const char *path,
 	strbuf_release(&buf);
 }
 
-int apply_autostash(const char *path)
+static int apply_save_autostash(const char *path, int attempt_apply)
 {
 	struct strbuf stash_oid = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -3712,13 +3712,17 @@ int apply_autostash(const char *path)
 	}
 	strbuf_trim(&stash_oid);
 
-	child.git_cmd = 1;
-	child.no_stdout = 1;
-	child.no_stderr = 1;
-	argv_array_push(&child.args, "stash");
-	argv_array_push(&child.args, "apply");
-	argv_array_push(&child.args, stash_oid.buf);
-	if (!run_command(&child))
+	if (attempt_apply) {
+		child.git_cmd = 1;
+		child.no_stdout = 1;
+		child.no_stderr = 1;
+		argv_array_push(&child.args, "stash");
+		argv_array_push(&child.args, "apply");
+		argv_array_push(&child.args, stash_oid.buf);
+		ret = run_command(&child);
+	}
+
+	if (attempt_apply && !ret)
 		fprintf(stderr, _("Applied autostash.\n"));
 	else {
 		struct child_process store = CHILD_PROCESS_INIT;
@@ -3734,10 +3738,13 @@ int apply_autostash(const char *path)
 			ret = error(_("cannot store %s"), stash_oid.buf);
 		else
 			fprintf(stderr,
-				_("Applying autostash resulted in conflicts.\n"
+				_("%s\n"
 				  "Your changes are safe in the stash.\n"
 				  "You can run \"git stash pop\" or"
-				  " \"git stash drop\" at any time.\n"));
+				  " \"git stash drop\" at any time.\n"),
+				attempt_apply ?
+				_("Applying autostash resulted in conflicts.") :
+				_("Autostash exists; creating a new stash entry."));
 	}
 
 	unlink(path);
@@ -3745,6 +3752,16 @@ int apply_autostash(const char *path)
 	return ret;
 }
 
+int save_autostash(const char *path)
+{
+	return apply_save_autostash(path, 0);
+}
+
+int apply_autostash(const char *path)
+{
+	return apply_save_autostash(path, 1);
+}
+
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
diff --git a/sequencer.h b/sequencer.h
index cf1284f9ed..2d09c1ac0b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -193,6 +193,7 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path,
 		      const char *default_reflog_action);
+int save_autostash(const char *path);
 int apply_autostash(const char *path);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
-- 
2.26.0.159.g23e2136ad0

