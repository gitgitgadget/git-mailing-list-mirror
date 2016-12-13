Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A069B2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 13:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbcLMN11 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 08:27:27 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35068 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbcLMN10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 08:27:26 -0500
Received: by mail-wj0-f194.google.com with SMTP id he10so16538753wjc.2
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=p+hy1Zd9V8vH0Uv/jhJAnpsiaqB8VtrNqK6BqvCsPUY=;
        b=gTxwB3gg6dqyh6gdL2tQCktfOVNDKoL4A6EES7hGIlwIJ/jLgwpNexK+oRFA40zHjR
         1MOvmmuliC8HTGWIQ5MTmuaz05tSsHVnnaqY9MvGVwJfp1xgNCtnI42YLJZ3cK8j9vjB
         UPrO+yFE9wIupAm4tj5fzUG2qeU5W3mko6jZldjJ7eaOv0LMY6fgM2VyWzKnwVnwwUgm
         OdLLHHjHR0ycBeVtyWo57M1AqL5KEtZkH6AoTKjdv4ZgXFViqa1nPRhDIIjXlhLYt4q5
         FtxCgBNDUTkCzLdNcTcFFIhUJcqNvQMj0Q9qMHgC3JvLH2k5Ryf5Nuuy1aoZ80WygvTu
         sJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p+hy1Zd9V8vH0Uv/jhJAnpsiaqB8VtrNqK6BqvCsPUY=;
        b=M4VqiVC8WIPG2qndyhXOLw4knt9Ybfsciq8EV+loCBtRmJiwCODWqVukCL8+K/alWu
         C599pbbGFofmznWDKhxIhzX1TYG9C5q6HNZ812+rt6hYlSy/pSE4kZPV3bWOgEPRtRw1
         WRUsYXXr9FkBZvsjfR/A0kIV+RYBF75prpPLDJKJB48VfKfXQd7KG95yWE7kk2+38Zp3
         OANJgOsZVQ2X/xikNMNeoTmcW98KfRYA8jN9/B43IyAyRAXH8+/hzLTlBDUEJhNQvzhw
         b4EW4bhbqDh5wV84F5xrDE6MziSZCO0m4kA+o5/Rp0v8bzgWKxNOmR4p9I4UUszQfN0L
         RxtA==
X-Gm-Message-State: AKaTC00qkIW6royPK25bCayGJg/PrPtkIYHaBTrtSwY2IUPuXAzm5YxC4/aaLnQV7QAmJw==
X-Received: by 10.194.125.43 with SMTP id mn11mr49771851wjb.14.1481635644905;
        Tue, 13 Dec 2016 05:27:24 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([13.94.233.52])
        by smtp.gmail.com with ESMTPSA id d10sm62162092wja.20.2016.12.13.05.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 05:27:24 -0800 (PST)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] builtin/commit.c: convert trivial snprintf calls to xsnprintf
Date:   Tue, 13 Dec 2016 13:27:17 +0000
Message-Id: <20161213132717.42965-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.11.0.153.gacc9cba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the commits f2f02675 and 5096d490 we have been converted in some files the call from snprintf/sprintf/strcpy to xsnprintf.  This patch supersedes the
snprintf with several calls that make use of the heap rather than fixed
length buffers (eg. PATH_MAX) that may be incorrect on some systems.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/commit.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0ed634b26..37228330c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -960,15 +960,16 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 
 	if (use_editor) {
-		char index[PATH_MAX];
-		const char *env[2] = { NULL };
-		env[0] =  index;
-		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path_commit_editmsg(), NULL, env)) {
+		struct argv_array env = ARGV_ARRAY_INIT;
+
+		argv_array_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
+		if (launch_editor(git_path_commit_editmsg(), NULL, env.argv)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
+			argv_array_clear(&env);
 			exit(1);
 		}
+		argv_array_clear(&env);
 	}
 
 	if (!no_verify &&
@@ -1525,12 +1526,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 static int run_rewrite_hook(const unsigned char *oldsha1,
 			    const unsigned char *newsha1)
 {
-	/* oldsha1 SP newsha1 LF NUL */
-	static char buf[2*40 + 3];
+	char *buf;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *argv[3];
 	int code;
-	size_t n;
 
 	argv[0] = find_hook("post-rewrite");
 	if (!argv[0])
@@ -1546,34 +1545,33 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	code = start_command(&proc);
 	if (code)
 		return code;
-	n = snprintf(buf, sizeof(buf), "%s %s\n",
-		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
+	buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
 	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, buf, n);
+	write_in_full(proc.in, buf, strlen(buf));
 	close(proc.in);
+	free(buf);
 	sigchain_pop(SIGPIPE);
 	return finish_command(&proc);
 }
 
 int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...)
 {
-	const char *hook_env[3] =  { NULL };
-	char index[PATH_MAX];
+	struct argv_array hook_env = ARGV_ARRAY_INIT;
 	va_list args;
 	int ret;
 
-	snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-	hook_env[0] = index;
+	argv_array_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
 
 	/*
 	 * Let the hook know that no editor will be launched.
 	 */
 	if (!editor_is_used)
-		hook_env[1] = "GIT_EDITOR=:";
+		argv_array_push(&hook_env, "GIT_EDITOR=:");
 
 	va_start(args, name);
-	ret = run_hook_ve(hook_env, name, args);
+	ret = run_hook_ve(hook_env.argv,name, args);
 	va_end(args);
+	argv_array_clear(&hook_env);
 
 	return ret;
 }
-- 
2.11.0.153.gacc9cba

