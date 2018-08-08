Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 201A4208EC
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeHHRnU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34996 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeHHRnU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id e6-v6so1463337edr.2
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9cHugPZ8b1c0v2E4fnhSTXr1rEWrpBj1tQY4AaO0w6c=;
        b=FDouO3YmlYH26xOTIvcTT1oTl2r0KVnUvnjZ1PnR238BqJ4Uf9VrOMKSnq0CuI1VzG
         37KsiposiPJgBXpbvC3J3pxS37Ldpyh/d6EH0gHKxmdVPLeSK8tIWO+e7hLQPi/pnAtW
         zpVO40xC7fYmHFIiYFqTTJ3kWtw02G5PnH5O+SW/BTz3/v7+MpX0jRnAPV/ym5pbXGZn
         NruVgUtslK10IeEoOWedh/1EZt4wILqjj6tI+6Kov9/igspM0zCs9jXG3MeqGDd3WKFo
         VhSJRQGw4euauWoXT0hKB+UUOmS2E4LA4CnEhgte0hfrMdcA8S+TCDRB4fIxG40RrUPW
         Uw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9cHugPZ8b1c0v2E4fnhSTXr1rEWrpBj1tQY4AaO0w6c=;
        b=ppyIGKtmJDAqa8mSnZzXrTnGAf70hNZWHoznVgmafG77P+VLxgzXxVoIiE8xpuHNJJ
         8a4iaq3SQSEybuUTS1uTNtVaqQo5ZJPud6nAzN/w7ygThhaerp4ePwOeRnRRZm5sFdaf
         XewbRWJRwT+6+LCv8qgs25ac44cA8FjX7g3J8peqDVJxf7wHrHA45TKdHY/zaBLP6YF2
         8Xd5UPO0mJ3zAMbAX9O51Y5MwVdr6OwRTtiGttlcJRe5yHI0glQlQquASz3iI1/cK5Ld
         eMiIIjL7nLP6ecaoHbef4MYH+8OW1gGB6PhrG4jvPakZ70pZuScg0RTs1NhGptdbFC9N
         Xccg==
X-Gm-Message-State: AOUpUlE/NnMeSiCmpYPK2RZCrWDoRYiSNwN4VCEBBKW/d2GpCvECNTry
        335FNaIkkzs/jLrsY9eTpurVSLFB
X-Google-Smtp-Source: AA+uWPzb3Kl9rV+T3rHw91u8mPBRz/7JoJb5EzxpnJA0pOYUD+C0K3rj+61dy2uiyiDf7Dkc45cTEg==
X-Received: by 2002:a50:83e6:: with SMTP id 93-v6mr3745431edi.164.1533741790775;
        Wed, 08 Aug 2018 08:23:10 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:10 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 09/18] builtin rebase: support `--gpg-sign` option
Date:   Wed,  8 Aug 2018 21:06:31 +0545
Message-Id: <20180808152140.14585-10-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit introduces support for `--gpg-sign` option which is used
to GPG-sign commits.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 79ba65fd75..cd9caf4841 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -97,6 +97,7 @@ struct rebase_options {
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
+	char *gpg_sign_opt;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -209,6 +210,15 @@ static int read_basic_state(struct rebase_options *opts)
 	} else
 		opts->allow_rerere_autoupdate = -1;
 
+	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
+		strbuf_reset(&buf);
+		if (read_one(state_dir_path("gpg_sign_opt", opts),
+			    &buf))
+			return -1;
+		free(opts->gpg_sign_opt);
+		opts->gpg_sign_opt = xstrdup(buf.buf);
+	}
+
 	strbuf_release(&buf);
 
 	return 0;
@@ -297,6 +307,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 		"--rerere-autoupdate" : "--no-rerere-autoupdate");
 	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
+	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -462,6 +473,13 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "commit.gpgsign")) {
+		free(opts->gpg_sign_opt);
+		opts->gpg_sign_opt = git_config_bool(var, value) ?
+			xstrdup("-S") : NULL;
+		return 0;
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -555,6 +573,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int committer_date_is_author_date = 0;
 	int ignore_date = 0;
 	int ignore_whitespace = 0;
+	const char *gpg_sign = NULL;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -619,6 +638,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
+		OPT_STRING('S', "gpg-sign", &gpg_sign,
+			   N_("gpg-sign?"), N_("GPG-sign commits")),
 		OPT_END(),
 	};
 
@@ -821,6 +842,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.keep_empty)
 		imply_interactive(&options, "--keep-empty");
 
+	if (gpg_sign) {
+		free(options.gpg_sign_opt);
+		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1046,5 +1072,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 cleanup:
 	strbuf_release(&revisions);
 	free(options.head_name);
+	free(options.gpg_sign_opt);
 	return ret;
 }
-- 
2.18.0

