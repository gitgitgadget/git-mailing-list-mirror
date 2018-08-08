Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53700208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeHHRnb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39685 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHHRnb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so1449085edi.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4xdcvI5xtnhECtN87XCKWXfyy/2G59NgwB3rC36YpGk=;
        b=VM+8jCqdwOEn+sp3OZmRZKIcraqDUiREcDvDaRDO21Gfa9NCpMyeDgiZBbNi9IK0n3
         2IBJIIteb3/jC0zAnsqrWF+VMWsKegXTvHUcOydfiYoXfvDX7zqmfOKMZCk3rKBsTBBu
         c1wyg0DNIVZ19ewFiKIHgdSvjay5cC4oyaDTlZh70ePo2ZMDu9ar5ol9UROUeISJpdyI
         zhGawe9UUA2gm3kJqjjeqn7R+0vudhASlgNwjzoTIvrrKO3d91aQZX/VW+i/FHdHprU7
         peP6hiizV2FF2r05IX/TeXRX+BbypqMlQJIFytUWp8WnJytp8Xx3SlRlhu/UdhHrHwfo
         eaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4xdcvI5xtnhECtN87XCKWXfyy/2G59NgwB3rC36YpGk=;
        b=X/f9AgBO1YvdihfsYODWc+56VJkLdOePSdq9yzF6+fVPLNL+C9GYzpIxgASDk03OA4
         QwafvlhWFOCdnATBPbM2hGl4jCMCfdQNz7GSeqHIFsQ5VKq+jrRJAtRB16wtTNDh8r8n
         gCtjWVUyNvgupMFyWX9uyUxqKpsz78VzRG72J1BFpJiFhGWNbiJIUs5qKPem7BrpkK3u
         27fAlmu3w00RgSQ33eXCgmF/YD/VVof83RXoO8pMjiYwHcKznG5APacBhAjMJmgs6BZ2
         l9QWqoAfLVxjnQhB0q6fQiSx+wkHvjRgszuDm72h1hmqgW60xSfI4dGAtxuHl8Rcvgwz
         lKww==
X-Gm-Message-State: AOUpUlG/Dz9537Ev5890FbQ8Dt8xJ7RvXT6dgH0UVosFmLZ+vNewdtIf
        1MIb2JoCxVNR0XmRWuP8ZjQa8o5c
X-Google-Smtp-Source: AA+uWPxtJuOA/Z4knS6HMj6fV10tG2tR6A8oD2I6F54m8OZpqiWmmWgcMkCZxxvrN9ewDApFwZ2ChA==
X-Received: by 2002:a50:a2a6:: with SMTP id 35-v6mr3921780edm.276.1533741801911;
        Wed, 08 Aug 2018 08:23:21 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:21 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 12/18] builtin rebase: support `--exec`
Date:   Wed,  8 Aug 2018 21:06:34 +0545
Message-Id: <20180808152140.14585-13-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds support for the `--exec` option which takes a shell
command-line as argument. This argument will be appended as an `exec
<cmd>` command after each line in the todo list that creates a commit in
the final history.  commands.

Note: while the shell script version of `git rebase` assigned the empty
string to `cmd` by default, we *unset* it here because the code looks
nicer and it does not change the behavior.

The `--exec` option requires `--interactive` machinery.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a6bfa73915..c9e992b526 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -93,6 +93,7 @@ struct rebase_options {
 	int autosquash;
 	char *gpg_sign_opt;
 	int autostash;
+	char *cmd;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -346,6 +347,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
+	add_var(&script_snippet, "cmd", opts->cmd);
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -619,6 +621,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	const char *gpg_sign = NULL;
 	int opt_c = -1;
 	struct string_list whitespace = STRING_LIST_INIT_NODUP;
+	struct string_list exec = STRING_LIST_INIT_NODUP;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -691,6 +694,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    REBASE_AM),
 		OPT_BOOL(0, "autostash", &options.autostash,
 			 N_("automatically stash/stash pop before and after")),
+		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
+				N_("add exec lines after each commit of the "
+				   "editable list")),
 		OPT_END(),
 	};
 
@@ -915,6 +921,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (exec.nr) {
+		int i;
+
+		imply_interactive(&options, "--exec");
+
+		strbuf_reset(&buf);
+		for (i = 0; i < exec.nr; i++)
+			strbuf_addf(&buf, "exec %s\n", exec.items[i].string);
+		options.cmd = xstrdup(buf.buf);
+	}
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_INTERACTIVE:
@@ -1197,5 +1214,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_release(&revisions);
 	free(options.head_name);
 	free(options.gpg_sign_opt);
+	free(options.cmd);
 	return ret;
 }
-- 
2.18.0

