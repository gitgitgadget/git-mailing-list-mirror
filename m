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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B729DC4332D
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E7822DCC
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbhAETp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbhAETp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91445C0617B0
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d13so302067wrc.13
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kb74uT4iBhesBQhjLaQ7t4/yZcNCQYxHO6w0RWtzxOA=;
        b=InhAeZIFaon2MSSA+MAVmxs9+DfXcRQM/CHV65R7sXdErLqrsMaI5S9DEcEP76IVlZ
         8/XaHtauPKSd7yNWFfWMJefVudiM+28G8p8a2T0U1+xLjvvuZiLKo+xVbOqsvR+pRaBU
         0fgGIDK4X8XUw+3IhJoPvE+iScmHjAKB1r6eNPzqoWuCSoJM7HWDXBEjQZnlbY+POCyg
         q/tduGhwbNuiuePxA2eTCi/bWmGzTFuGsf0lMJCfZmJaqJJ9HEXNuxJDcqNxB/NIlVmt
         F9kZZNcsydSLqvvDQBStalgWMSdYMmzf7sgTGWDlpw+PEwduyZXxaiIAO8vjzUfmsUo6
         qRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kb74uT4iBhesBQhjLaQ7t4/yZcNCQYxHO6w0RWtzxOA=;
        b=UGlXAAwOS/b9I/Oio7VUH/E0wcueM8pf/eAxnluDN6X0NOmgVK0v5mB6FXKk70/X3I
         mMgHv+ETpTfPVkqkGWk6CdNGz3xlZxJz+lXw/H4KhkFJLVCoCfEK3bS1boNGk5GerOHV
         HlKT3lif200nuERXvrYGllOU/UohYLzHXcWgcgq/ApGpzy1EN0X8pW4RqHueDfxursQU
         TkFYAT5elx+nHMZNXeTRXy1EDLjvw/yYb2m9ve3+GdTCSE1VC8/U8hhSLR/YN+PhKfJe
         wCT7g02bzFLTlri+zL1cw7N3sMm6W21IuTGrXi9ECaVFP8AgfdgpxC3JRrNyVzoSt241
         Zpug==
X-Gm-Message-State: AOAM533pL3zOEs9x5y6/5ZeH7G1AG6ZFgQA4/dSE/3Qj3PwQOn9QnEWR
        ABOyMW4J5v1Y2ZYY7sYsQZ5FuBVYJAeldQ==
X-Google-Smtp-Source: ABdhPJzPgdKwM/tqN98wf8Z2T8ajpH/UTiYk4YvxHpPeXlUAw2n9RVEuW80fAdDskwLbXQKKS/rXvw==
X-Received: by 2002:a05:6000:1d0:: with SMTP id t16mr1052000wrx.203.1609875826040;
        Tue, 05 Jan 2021 11:43:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 18/23] fsck: make fsck_config() re-usable
Date:   Tue,  5 Jan 2021 20:42:47 +0100
Message-Id: <20210105194252.627-19-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the fsck_config() function from builtin/fsck.c to fsck.[ch]. This
allows for re-using it in other tools that expose fsck logic and want
to support its configuration variables.

A logical continuation of this change would be to use a common
function for all of {fetch,receive}.fsck.* and fsck.*. See
5d477a334a6 (fsck (receive-pack): allow demoting errors to warnings,
2015-06-22) and my own 1362df0d413 (fetch: implement fetch.fsck.*,
2018-07-27) for the relevant code.

However, those routines want to not parse the fsck.skipList into OIDs,
but rather pass them along with the --strict option to another
process. It would be possible to refactor that whole thing so we
support e.g. a "fetch." prefix, then just keep track of the skiplist
as a filename instead of parsing it, and learn to spew that all out
from our internal structures into something we can append to the
--strict option.

But instead I'm planning to re-use this in "mktag", which'll just
re-use these "fsck.*" variables as-is.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fsck.c | 20 +-------------------
 fsck.c         | 25 +++++++++++++++++++++++++
 fsck.h         |  7 +++++++
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index fbf26cafcfd..821e7798c70 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -73,25 +73,7 @@ static const char *printable_type(const struct object_id *oid,
 
 static int fsck_config(const char *var, const char *value, void *cb)
 {
-	if (strcmp(var, "fsck.skiplist") == 0) {
-		const char *path;
-		struct strbuf sb = STRBUF_INIT;
-
-		if (git_config_pathname(&path, var, value))
-			return 1;
-		strbuf_addf(&sb, "skiplist=%s", path);
-		free((char *)path);
-		fsck_set_msg_types(&fsck_obj_options, sb.buf);
-		strbuf_release(&sb);
-		return 0;
-	}
-
-	if (skip_prefix(var, "fsck.", &var)) {
-		fsck_set_msg_type(&fsck_obj_options, var, value);
-		return 0;
-	}
-
-	return git_default_config(var, value, cb);
+	return fsck_config_internal(var, value, cb, &fsck_obj_options);
 }
 
 static int objerror(struct object *obj, const char *err)
diff --git a/fsck.c b/fsck.c
index bed5e20e03b..9067a290a2e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1310,3 +1310,28 @@ int fsck_finish(struct fsck_options *options)
 	oidset_clear(&gitmodules_done);
 	return ret;
 }
+
+int fsck_config_internal(const char *var, const char *value, void *cb,
+			 struct fsck_options *options)
+{
+	if (strcmp(var, "fsck.skiplist") == 0) {
+		const char *path;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (git_config_pathname(&path, var, value))
+			return 1;
+		strbuf_addf(&sb, "skiplist=%s", path);
+		free((char *)path);
+		fsck_set_msg_types(options, sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
+	if (skip_prefix(var, "fsck.", &var)) {
+		fsck_set_msg_type(options, var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
diff --git a/fsck.h b/fsck.h
index 29ee4c45e87..423c467feb7 100644
--- a/fsck.h
+++ b/fsck.h
@@ -103,4 +103,11 @@ void fsck_put_object_name(struct fsck_options *options,
 const char *fsck_describe_object(struct fsck_options *options,
 				 const struct object_id *oid);
 
+/*
+ * git_config() callback for use by fsck-y tools that want to support
+ * fsck.<msg> fsck.skipList etc.
+ */
+int fsck_config_internal(const char *var, const char *value, void *cb,
+			 struct fsck_options *options);
+
 #endif
-- 
2.29.2.222.g5d2a92d10f8

