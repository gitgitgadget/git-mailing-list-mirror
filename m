Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBBD1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 19:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbdKHTzg (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 14:55:36 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:54198 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbdKHTz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 14:55:27 -0500
Received: by mail-it0-f68.google.com with SMTP id 143so4566404itf.2
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 11:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=782SClWZtXRp4+WDKKWrwFrcFwYX7OevribTwH6xZuk=;
        b=OUvUe4Z42WYdfPOs8TPvEwqF9nPoUEWoXf0RvFAMRN9oJ/gOjcsN3Lgzdh0YM5EAhw
         /4pt/oOF64chMlRQSRogFU8btc/oxMLT1HnL8LqxoU3Y0o3jFByXvEuZ7BjGg9Dq6sjf
         RG1WxC5KrK5Zem7XwMlwjf7Z7afKwR6iCLluxwEzbqgBPrBZdF/bpV6KedsP+H/mb5md
         ucYubFFfsvxzOKVb1LMYO0+z6EUJ+Ryq80Vkak3d4WlvbgiWDzYAitSmp5WJOs5RUoGR
         fcCiP9XePt91UjHyDMdk8XrUULgM3H1L9+HlBQD/unCgP4Byyp8I5SARzrbIGjzzKOVi
         Q8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=782SClWZtXRp4+WDKKWrwFrcFwYX7OevribTwH6xZuk=;
        b=KWKgw0EYRFX/S5Iw4TuKkNI+vsm+eIyAizGEuQn3dKnndi/XwwpuTo3vbbd6Y4TXhW
         8IL3zqzz/bORHivHie2XCUs5/y5l9tzjU4B3Zjh1BFk9vM98Id1o2oj9wpnnawhm66fM
         1gnoVYiwFKal3rorFp8RLqzGBxururkbm9lWkuqbnzx8snzYg9bE1v9B1FJUx+UgClnB
         6jsPkRMJQpv7u/QYbJWYa4F6PeMlVhJXITOTMMfDmhDKXuUS+TUbZITCjeBYk6FheWIE
         QsryXDob7muLTS3NZamTz75LbfddQnGCpDF2JXcBtzY+ZTs1i/L0bLFi/F5GIbuTXszQ
         qeeA==
X-Gm-Message-State: AJaThX4LkbXjkIQq0CmG+JyzplAE2TV+ds3fIIAFktPW8+yqiY0XUf4w
        O6Z5tWJWO7rOBUTQR3Bk04x5imllyfA=
X-Google-Smtp-Source: ABhQp+S+oEJGAnD2h2b5gA9QT5OeET4DeOHuAHev1I8N6FVP2D/n1yRAlvs9TSB9jfLbN9C1YX5QsQ==
X-Received: by 10.36.131.203 with SMTP id d194mr2382649ite.5.1510170926249;
        Wed, 08 Nov 2017 11:55:26 -0800 (PST)
Received: from localhost ([2620:0:100e:422:c178:b390:b6a8:a0e2])
        by smtp.gmail.com with ESMTPSA id 5sm2214685ion.46.2017.11.08.11.55.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Nov 2017 11:55:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] submodule.c: factor start_ls_files_dot_dot out of get_superproject_working_tree
Date:   Wed,  8 Nov 2017 11:55:07 -0800
Message-Id: <20171108195509.7839-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171108195509.7839-1-sbeller@google.com>
References: <20171108195509.7839-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'll reuse the code of the factored out function shortly, when exploring
the superproject for another aspect. Instead of knowing the root of the
superproject we'll find out about the gitlink value.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 53 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/submodule.c b/submodule.c
index 239d94d539..4fcb64469e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1977,15 +1977,13 @@ void absorb_git_dir_into_superproject(const char *prefix,
 	}
 }
 
-const char *get_superproject_working_tree(void)
+/* Starts a child process `ls-files` one directory above the root of the repo. */
+static int start_ls_files_dot_dot(struct child_process *cp, struct strbuf *out)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct strbuf sb = STRBUF_INIT;
 	const char *one_up = real_path_if_valid("../");
-	const char *cwd = xgetcwd();
-	const char *ret = NULL;
 	const char *subpath;
-	int code;
+	char *cwd = xgetcwd();
+	struct strbuf sb = STRBUF_INIT;
 	ssize_t len;
 
 	if (!is_inside_work_tree())
@@ -1994,31 +1992,48 @@ const char *get_superproject_working_tree(void)
 		 * We might have a superproject, but it is harder
 		 * to determine.
 		 */
-		return NULL;
+		return -1;
 
 	if (!one_up)
-		return NULL;
+		return -1;
 
 	subpath = relative_path(cwd, one_up, &sb);
 
-	prepare_submodule_repo_env(&cp.env_array);
-	argv_array_pop(&cp.env_array);
+	prepare_submodule_repo_env(&cp->env_array);
+	argv_array_pop(&cp->env_array);
 
-	argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
+	argv_array_pushl(&cp->args, "--literal-pathspecs", "-C", "..",
 			"ls-files", "-z", "--stage", "--full-name", "--",
 			subpath, NULL);
-	strbuf_reset(&sb);
 
-	cp.no_stdin = 1;
-	cp.no_stderr = 1;
-	cp.out = -1;
-	cp.git_cmd = 1;
+	cp->no_stdin = 1;
+	cp->no_stderr = 1;
+	cp->out = -1;
+	cp->git_cmd = 1;
 
-	if (start_command(&cp))
+	if (start_command(cp))
 		die(_("could not start ls-files in .."));
 
-	len = strbuf_read(&sb, cp.out, PATH_MAX);
-	close(cp.out);
+	len = strbuf_read(out, cp->out, PATH_MAX);
+	close(cp->out);
+
+	strbuf_release(&sb);
+	free(cwd);
+	return len;
+}
+
+const char *get_superproject_working_tree(void)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	const char *cwd = xgetcwd();
+	const char *ret = NULL;
+	int code;
+	ssize_t len;
+
+	len = start_ls_files_dot_dot(&cp, &sb);
+	if (len < 0)
+		return NULL;
 
 	if (starts_with(sb.buf, "160000")) {
 		int super_sub_len;
-- 
2.15.0.128.g40905b34bf.dirty

