Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ADB01FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 13:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbdFJNky (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 09:40:54 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32883 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdFJNkt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 09:40:49 -0400
Received: by mail-qt0-f193.google.com with SMTP id w1so19546266qtg.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=96uhVSLXUpGNLPcIpwD6QYfz3BBpNCL9GcewAtqZhls=;
        b=b+4ZwCm8zSc/7hy8wWErAjOhRbAUFTOAx4MlPsVdP4PPx8GQnae37B2HG9O7Iabnvi
         SsVN7imCnmfNSRnn9HrOt4c7ngtEWubiXGA1K5vEQh/v6sbInl8e9bRAug5FPdPsPjRV
         DLTePLuQC+yWkqgPID9JLq6mhb4vksDeqWhHhglc8VjnakDP4HN7lLLFTa/8n4BUNya9
         FYi7QWLp85al/4dZed90LM/yLn4TTYrZutr/BQtd18PY6iRg6BNndcFISQNTmZAt/dvH
         EW9MLtTmDAH7s/YXGHrpJVrO5eAIjXIuDJ32vtxyRroht9SBP47PnFd0XDDlNLqJT9mL
         D8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=96uhVSLXUpGNLPcIpwD6QYfz3BBpNCL9GcewAtqZhls=;
        b=Wbm6OmHTBv1r7xoXS6LZcgnJg61VjV9ySW/2XIcks6CTbWTjysP17Y9AnP7ymaGSLY
         lIeRX+GnaDbq2i8wIFlLoPXSICmjmgfeKgW+muA60Z4VNvprIAV5Bv+UpTXmOFnic5ai
         elgTCzfMzc6mOssKWl4b8KmTatwmoxtT2+vTu0cTr9qx//r7Fbm7I5KikkZa5sIIyELF
         6OjOwc72tF+Rsrq35Y4gmTZFDE2WpXaR4umN6jFGY1AxHJXmscVJ1SosqyDGusl4LUwM
         of0F7iip+K1r73rY5upOPjQW7mXIvEgJsXOvwc5poq1PzXroDzU+HtrPPrzP/f9njvZo
         NxXQ==
X-Gm-Message-State: AODbwcAuATYq2WAvnvu5UE8Tar9CEwVH36iofcu5b8+5HlCz4YleFJ4m
        9HvxRhHPelcMIWYVVEI=
X-Received: by 10.200.48.57 with SMTP id f54mr42503921qte.88.1497102048096;
        Sat, 10 Jun 2017 06:40:48 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f94sm2707503qtb.16.2017.06.10.06.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 06:40:47 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v5 4/7] fsmonitor: add test cases for fsmonitor extension
Date:   Sat, 10 Jun 2017 09:40:23 -0400
Message-Id: <20170610134026.104552-5-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170610134026.104552-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test cases that ensure status results are correct when using the new
fsmonitor extension.  Test untracked, modified, and new files by
ensuring the results are identical to when not using the extension.

Add a test to ensure updates to the index properly mark corresponding
entries in the index extension as dirty so that the status is correct
after commands that modify the index but don't trigger changes in the
working directory.

Add a test that verifies that if the fsmonitor extension doesn't tell
git about a change, it doesn't discover it on its own.  This ensures
git is honoring the extension and that we get the performance benefits
desired.

All test hooks output a marker file that is used to ensure the hook
was actually used to generate the test results.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 173 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100755 t/t7519-status-fsmonitor.sh

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
new file mode 100755
index 0000000000..458eabe6dc
--- /dev/null
+++ b/t/t7519-status-fsmonitor.sh
@@ -0,0 +1,173 @@
+#!/bin/sh
+
+test_description='git status with file system watcher'
+
+. ./test-lib.sh
+
+clean_repo () {
+	git reset --hard HEAD &&
+	git clean -fd &&
+	rm -f marker
+}
+
+dirty_repo () {
+	: >untracked &&
+	: >dir1/untracked &&
+	: >dir2/untracked &&
+	echo 1 >modified &&
+	echo 2 >dir1/modified &&
+	echo 3 >dir2/modified &&
+	echo 4 >new &&
+	echo 5 >dir1/new &&
+	echo 6 >dir2/new &&
+	git add new &&
+	git add dir1/new &&
+	git add dir2/new
+}
+
+# The test query-fsmonitor hook proc will output a marker file we can use to
+# ensure the hook was actually used to generate the correct results.
+
+# fsmonitor works correctly with or without the untracked cache
+# but if it is available, we'll turn it on to ensure we test that
+# codepath as well.
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+if test_have_prereq UNTRACKED_CACHE; then
+	git config core.untrackedcache true
+else
+	git config core.untrackedcache false
+fi
+
+test_expect_success 'setup' '
+	mkdir -p .git/hooks &&
+	: >tracked &&
+	: >modified &&
+	mkdir dir1 &&
+	: >dir1/tracked &&
+	: >dir1/modified &&
+	mkdir dir2 &&
+	: >dir2/tracked &&
+	: >dir2/modified &&
+	git add . &&
+	test_tick &&
+	git commit -m initial &&
+	git config core.fsmonitor true &&
+	cat >.gitignore <<-\EOF
+	.gitignore
+	expect*
+	output*
+	marker*
+	EOF
+'
+
+# Ensure commands that call refresh_index() to move the index back in time
+# properly invalidate the fsmonitor cache
+
+test_expect_success 'refresh_index() invalidates fsmonitor cache' '
+	git status &&
+	test_path_is_missing marker &&
+	dirty_repo &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	:>marker
+	EOF
+	git add . &&
+	git commit -m "to reset" &&
+	git status &&
+	test_path_is_file marker &&
+	git reset HEAD~1 &&
+	rm -f marker &&
+	git status >output &&
+	test_path_is_file marker &&
+	git -c core.fsmonitor=false status >expect &&
+	test_i18ncmp expect output
+'
+
+# Now make sure it's actually skipping the check for modified and untracked
+# files unless it is told about them.  Note, after "git reset --hard HEAD" no
+# extensions exist other than 'TREE' so do a "git status" to get the extension
+# written before testing the results.
+
+test_expect_success "status doesn't detect unreported modifications" '
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	:>marker
+	EOF
+	clean_repo &&
+	git status &&
+	test_path_is_missing marker &&
+	: >untracked &&
+	echo 2 >dir1/modified &&
+	git status >output &&
+	test_path_is_file marker &&
+	test_i18ngrep ! "Changes not staged for commit:" output &&
+	test_i18ngrep ! "Untracked files:" output &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	:>marker
+	printf "untracked\0"
+	printf "dir1/modified\0"
+	EOF
+	rm -f marker &&
+	git status >output &&
+	test_path_is_file marker &&
+	test_i18ngrep "Changes not staged for commit:" output &&
+	test_i18ngrep "Untracked files:" output
+'
+
+# Status is well tested elsewhere so we'll just ensure that the results are
+# the same when using core.fsmonitor. First call after turning on the option
+# does a complete scan so we need to do two calls to ensure we test the new
+# codepath.
+
+test_expect_success 'status with core.untrackedcache false' '
+	git config core.untrackedcache false &&
+	write_script .git/hooks/query-fsmonitor<<-\EOF &&
+	if [ $1 -ne 1 ]
+	then
+		echo -e "Unsupported query-fsmonitor hook version.\n" >&2
+		exit 1;
+	fi
+	: >marker
+	printf "untracked\0"
+	printf "dir1/untracked\0"
+	printf "dir2/untracked\0"
+	printf "modified\0"
+	printf "dir1/modified\0"
+	printf "dir2/modified\0"
+	printf "new\0""
+	printf "dir1/new\0"
+	printf "dir2/new\0"
+	EOF
+	clean_repo &&
+	dirty_repo &&
+	git -c core.fsmonitor=false status >expect &&
+	clean_repo &&
+	git status &&
+	test_path_is_missing marker &&
+	dirty_repo &&
+	git status >output &&
+	test_path_is_file marker &&
+	test_i18ncmp expect output
+'
+
+if ! test_have_prereq UNTRACKED_CACHE; then
+	skip_all='This system does not support untracked cache'
+	test_done
+fi
+
+test_expect_success 'status with core.untrackedcache true' '
+	git config core.untrackedcache true &&
+	git -c core.fsmonitor=false status >expect &&
+	clean_repo &&
+	git status &&
+	test_path_is_missing marker &&
+	dirty_repo &&
+	git status >output &&
+	test_path_is_file marker &&
+	test_i18ncmp expect output
+'
+
+test_done
-- 
2.13.0

