Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21074C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67C82070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA7C/Q5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgCUJWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:40 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:40700 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgCUJWj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:39 -0400
Received: by mail-qk1-f171.google.com with SMTP id l25so4930155qki.7
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zd+xNZq96Ta0A7aeOjKKd7jSrggp1/DrPjRs3WY3wic=;
        b=NA7C/Q5W8YV+PvnSR60HKVWpFBX09oo9IfMXEcGKOqAKe8zmxarXDV0bRFF9vBx603
         GI52GcWSveRS4MiUU9cQZzTt2eAD1ID6ijsVbA3+33IBMlEhEBFgm67fKQXPRQGMrPPb
         7E910NBhmkDTlLHZrnneTuSOPVmGJeYRcgAzYOCBdMIdRGO4RBy16cCVpwX5OhK2vF/A
         +k4eQp1EP6SzLGqw4WDGM+QKwFaHfxp0n3wtyaBUGJ4eji1GzT73qFb9wZ259V5dQzov
         wnBgkhudjxanP23aoKXwBhbt/jC0T4kv1IIZJ+4cq7MIFhbI0/faYqGW9/Z1LvMVgM7X
         uAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zd+xNZq96Ta0A7aeOjKKd7jSrggp1/DrPjRs3WY3wic=;
        b=q/PKPp633ydRHuYifItxY1eSr7/pNf1NiboGS1CFrrqB18ZjXQjephu7TdEjjHejAd
         buKm5BCINCEebQMbqRjgH/wNPgDYb+QwylP9QSA4HzyCwtToe1I4IPcNxJzJ4OlnQqjM
         DsF4jt8FuZz1dk305bHNGiHA1vshh1ZM2j9Yf5zag82YArueYFUZ0dPEY2fC2rxtJoic
         LKqGDEkAeVK8GODRTVgDD3ZcpkFDDXq9PxxreZyA8CQwjRBJu6BevRfzyGYojAAVaSah
         eZvhUvSi8/eiC+DdnPHoHduPe+MsPPcNuNKVepVFK7JASilKlvLUW1fl9AOJOt4SCnqO
         iFEg==
X-Gm-Message-State: ANhLgQ20EFYyzplzULvMajjM3GEIdcDSV/slNFtreBKoIr3MwppCoALt
        9WCmcdkXpCijC0Oe92FGV1KVzTLU
X-Google-Smtp-Source: ADFU+vuCyEFG3c4zcOFuUe2reF0+oNQa9M98pNLFr2UJn+kcXvhPQ/xsdGeZ6QimIjztTrI2uV0lcw==
X-Received: by 2002:a37:4ec1:: with SMTP id c184mr11928287qkb.0.1584782557931;
        Sat, 21 Mar 2020 02:22:37 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:37 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 16/19] sequencer: implement save_autostash()
Date:   Sat, 21 Mar 2020 05:21:35 -0400
Message-Id: <e21e2c6416766234114ba94cbaf5b47f0595ee69.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract common functionality of apply_autostash() into
apply_save_autostash() and use it to implement save_autostash(). This
function will be used in a future commit.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 37 +++++++++++++++++++++++++++----------
 sequencer.h |  1 +
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 81b6c700d1..d67d47b332 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3705,7 +3705,7 @@ void create_autostash(struct repository *r, const char *path,
 	strbuf_release(&buf);
 }
 
-int apply_autostash(const char *path)
+static int apply_save_autostash(const char *path, int attempt_apply)
 {
 	struct strbuf stash_sha1 = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -3718,13 +3718,17 @@ int apply_autostash(const char *path)
 	}
 	strbuf_trim(&stash_sha1);
 
-	child.git_cmd = 1;
-	child.no_stdout = 1;
-	child.no_stderr = 1;
-	argv_array_push(&child.args, "stash");
-	argv_array_push(&child.args, "apply");
-	argv_array_push(&child.args, stash_sha1.buf);
-	if (!run_command(&child))
+	if (attempt_apply) {
+		child.git_cmd = 1;
+		child.no_stdout = 1;
+		child.no_stderr = 1;
+		argv_array_push(&child.args, "stash");
+		argv_array_push(&child.args, "apply");
+		argv_array_push(&child.args, stash_sha1.buf);
+		ret = run_command(&child);
+	}
+
+	if (attempt_apply && !ret)
 		fprintf(stderr, _("Applied autostash.\n"));
 	else {
 		struct child_process store = CHILD_PROCESS_INIT;
@@ -3740,10 +3744,13 @@ int apply_autostash(const char *path)
 			ret = error(_("cannot store %s"), stash_sha1.buf);
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
@@ -3751,6 +3758,16 @@ int apply_autostash(const char *path)
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
index 44ecfee7f3..1cb0e4e4b7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -193,6 +193,7 @@ void commit_post_rewrite(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path,
 		      const char *default_reflog_action);
+int save_autostash(const char *path);
 int apply_autostash(const char *path);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
-- 
2.25.0.114.g5b0ca878e0

