Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977CCC2BA80
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E830207FF
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugznGEkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgDGO2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42486 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgDGO2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id b10so2760937qtt.9
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgPcTgpTgIyew8hRZr8Ws7nuOduXFE7R9jvKARasCX8=;
        b=ugznGEkPf9qXlYhtfTAdc1oESfmK3PN4tjh+zNa74rhTkCxI9eKGRALJOTc1ddwAMH
         VpDegveIAAvC77hIzIBbqebyVvNGdg1bdDCjofwKaMFhEsP5gbgHLdPg848pcTdLfUNS
         8OHg7a5GA8m+iyzG9OCl6x5c0IRxDhljO6RsgvMN9Kd/uT+/SGa/ovz7iVNknP4mzyIs
         FPxxptGc9rPNAq5vy0wIjMfxRiz9mRGk07PcJMb/i7V5L6uBPoknEaSP6Lsj3DH7Fl7R
         OjaXGmgXSqan6jlXQI+Mm1Uk90x7pAfhWWtR/gsR38hdqfMXRPu7c13yOpxuYWdVn5N7
         ridA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgPcTgpTgIyew8hRZr8Ws7nuOduXFE7R9jvKARasCX8=;
        b=rRZfPjJPfd825CJ23vBz9KsGd3JQhug66zX5rqKYohWV3VBvFdvnRO657tgDjx69qs
         ESQNo8xGhncA5E59jKoXBLFASaV3MdbqwMoyNh97Bwt9O1JEbkrumHsZVJL+vdgJJdLd
         wDRZrPhSqCp/7o0xtONRE/Xft0M6DpygQLa8o9QgKMb3fJp8SOZ7kXK2D50bqvDyY3BO
         7Z9xjMxf73fuX7eUF6WIg00jFQiXr8olJebtPo84QAUVOIRFwCgRWAoYXw/O3sskn0jT
         1ged9WKe0ol6LX4+OsRViSVEQzuo5iVY53crKc+Oc2IsxPMbf2U0faM4Ms1X09R0UO6P
         5PFw==
X-Gm-Message-State: AGi0PuZhVv17gDfS33AbvLs0khlSth4calL9Vr7qMBzLkWP6e/5cpr0h
        7hFe5kkaj3hbxUIA4UabPB6Wt+gm
X-Google-Smtp-Source: APiQypJr/D2ww1k+jm7LFRAOHAE4F1Qs3PLVxLx2gI5iXi8Cp3eqw+ql9+U+TN6di8jL9WXpsRtDCw==
X-Received: by 2002:ac8:1901:: with SMTP id t1mr2484739qtj.269.1586269722843;
        Tue, 07 Apr 2020 07:28:42 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:41 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 19/22] sequencer: implement apply_autostash_oid()
Date:   Tue,  7 Apr 2020 10:28:06 -0400
Message-Id: <732b3f99455066ae780dd8a0e662173f1bd02e60.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
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
index 084ea4117e..f1eba4cb1f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3707,26 +3707,18 @@ void create_autostash(struct repository *r, const char *path,
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
 
@@ -3741,9 +3733,9 @@ static int apply_save_autostash(const char *path, int attempt_apply)
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
@@ -3755,6 +3747,23 @@ static int apply_save_autostash(const char *path, int attempt_apply)
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
@@ -3770,6 +3779,11 @@ int apply_autostash(const char *path)
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
index 306d4cecfb..5a85eeef92 100644
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

