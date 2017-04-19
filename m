Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71EE21FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 23:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940287AbdDSXNl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 19:13:41 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:33093 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939282AbdDSXNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 19:13:38 -0400
Received: by mail-io0-f174.google.com with SMTP id k87so42187371ioi.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iuMI66o9r3+mPTF1MrHf12niIDl1U22cb/pbU2T4bG8=;
        b=N1jtY2gk2Gqdg8N/SgCpT6Kb2aXY3Y/sbSFb1UILKm5i/6ZInXfYbK7frikoHqVpoV
         /StLby5uuJbqSpc44LdoigMfCn4uhJnYbRb0J6xhyCqVItF+UndgwakvVzFNmTME+70e
         4PqRinSzyUqC7OkLhz8Oj6AsHB+Z0se3U31sv9nwoLAxRYGxvHuJuj/3SXMcf6de6+uP
         3rOhJNs0ZEcbJ+ZV12IE4YBHib2T+FTIrJQqArrYF5gbj8Sy1fJFYCdwkDxFyXYG6N3a
         0rgftQk9FOi7Slkww6Wbfyv5VlbzkVo1x6Q7/fNJpxJCrUNyW4xT/momwYedXPMI5KdY
         uFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iuMI66o9r3+mPTF1MrHf12niIDl1U22cb/pbU2T4bG8=;
        b=RvJ62m569kZTVkDmWnUuT/j85byF5LfchzjH+dxHZExaYck8hrqNMV77iWDTonlBtK
         2pf8E2S6q2+tvP/81iXeDN7ebgGXl6fDBNuQ1uMO8mueT6hRuY2E+BMO7hQjV6l7y2Sz
         fPPJ9jUsaGNhr7VQg2cru+x9+aN+YvzUMVKLtAsP0B2hJsQAP5hgvi4gwivLVJ2NTmgW
         3ZE8vdkvlkoV9iul7T3/478oiNC0bWXz5rxePnJr7rw0SfTXzysB/0KmfG1bPBepgNOK
         i1U9IdRxSdHl3AAsMnLiZGVswfdi7D83cLrqcRjhc2QatTRdvzidjwT+Vmcsq1dx1Big
         9aNg==
X-Gm-Message-State: AN3rC/4IB/DjY/qLPPuSB8iL/FIUtF/xFKKiedP/xOEdFxTFEWe70XIW
        Hpo/uTUvNY7T2gSX
X-Received: by 10.98.36.154 with SMTP id k26mr2539977pfk.174.1492643614925;
        Wed, 19 Apr 2017 16:13:34 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s10sm6433798pfe.28.2017.04.19.16.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 16:13:33 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, j6t@kdbg.org,
        sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: [PATCH v6 00/11] forking and threading
Date:   Wed, 19 Apr 2017 16:13:16 -0700
Message-Id: <20170419231327.49895-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.816.g2cccc81164-goog
In-Reply-To: <20170418231805.61835-1-bmwill@google.com>
References: <20170418231805.61835-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v6:
* fix some windows compat issues
* better comment on the string_list_remove function (also marked extern)

Brandon Williams (10):
  t5550: use write_script to generate post-update hook
  t0061: run_command executes scripts without a #! line
  run-command: prepare command before forking
  run-command: use the async-signal-safe execv instead of execvp
  string-list: add string_list_remove function
  run-command: prepare child environment before forking
  run-command: don't die in child when duping /dev/null
  run-command: eliminate calls to error handling functions in child
  run-command: handle dup2 and close errors in child
  run-command: add note about forking and threading

Eric Wong (1):
  run-command: block signals between fork and execve

 run-command.c              | 404 +++++++++++++++++++++++++++++++++++----------
 string-list.c              |  18 ++
 string-list.h              |   7 +
 t/t0061-run-command.sh     |  11 ++
 t/t5550-http-fetch-dumb.sh |   5 +-
 5 files changed, 360 insertions(+), 85 deletions(-)

--- interdiff with 'origin/bw/forking-and-threading'

diff --git a/run-command.c b/run-command.c
index 1f3c38e43..a97d7bf9f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -402,7 +402,6 @@ static char **prep_childenv(const char *const *deltaenv)
 	strbuf_release(&key);
 	return childenv;
 }
-#endif
 
 struct atfork_state {
 #ifndef NO_PTHREADS
@@ -450,6 +449,7 @@ static void atfork_parent(struct atfork_state *as)
 		"restoring signal mask");
 #endif
 }
+#endif /* GIT_WINDOWS_NATIVE */
 
 static inline void set_cloexec(int fd)
 {
diff --git a/string-list.h b/string-list.h
index 18520dbc8..29bfb7ae4 100644
--- a/string-list.h
+++ b/string-list.h
@@ -64,8 +64,10 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
 
 /*
  * Removes the given string from the sorted list.
+ * If the string doesn't exist, the list is not altered.
  */
-void string_list_remove(struct string_list *list, const char *string, int free_util);
+extern void string_list_remove(struct string_list *list, const char *string,
+			       int free_util);
 
 /*
  * Checks if the given string is part of a sorted list. If it is part of the list,
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 1a7490e29..98c09dd98 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -26,7 +26,7 @@ test_expect_success 'run_command can run a command' '
 	test_cmp empty err
 '
 
-test_expect_success 'run_command can run a script without a #! line' '
+test_expect_success !MINGW 'run_command can run a script without a #! line' '
 	cat >hello <<-\EOF &&
 	cat hello-script
 	EOF

-- 
2.12.2.816.g2cccc81164-goog

