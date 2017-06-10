Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6CD61FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 13:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbdFJNlB (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 09:41:01 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35196 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbdFJNkx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 09:40:53 -0400
Received: by mail-qt0-f195.google.com with SMTP id x58so19592684qtc.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 06:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ESs9lpEtzl0U9rN/Jhv05/YF/8yu/4nazKswK2+IbK8=;
        b=X109WDtWEbKK04X4yuspSX7glkYJQXNDhsfFeqlBBcGw8Od9Sd7ES7154vwoZqILnd
         tyuoAe55lsr5AB5UMddZ1nOdzNsySeednqBxZn1ZU0G3ktXEFu5LixN4DgcPyBOEH+ke
         P5iWkm1cqozf1atcpCqj5thkIPLIb8Ja1OOavAhtF5R33tObZckyaog3bESNPZ9RckzK
         ib40Un28wafWYqVqyFJ+7sMDKQvLaGK/wJ+JZQ6WaHQASxLZCmore0hrJ8hDh3wfxnTY
         XdxmvkrHHV2kbecHbTkXEpEbddwKsbldPwZGVrakMquTt/A7qUzFQgIE7IoMFyNvu2aG
         5bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESs9lpEtzl0U9rN/Jhv05/YF/8yu/4nazKswK2+IbK8=;
        b=o7jldvnTpiFa/gGFGq4fSj+XDCEgs8OVmmsS9wvPwmMcyn/UukF0vE+hkxtYPOWcmU
         T9n2cLO1NWF9iskWZVi3cVWSmz5qakr0z666BALo94EtESdM1mMr1vEtCbDeO8mLtVRl
         tMu2AWMN8wwYwfbMSAo237fCTgy/DR6cIiyq6echvDv65aR9VSw3jN+9ZEOCJLsu0c2O
         xLlCXgaDnnOvY+G506AkEnsNp7TTirUFU9M5Qa1HmqK9OIM1tgDAFwQ1IMN4fLqumtZm
         zzsuZsUw5j0hcmm5uXjskJDSyP6dbFtYCZEamOjWEJ6BzB3NPH6TADKf9BZOnZSve5jQ
         MvJQ==
X-Gm-Message-State: AODbwcCWZLG62PMIpl/lveTwTAMnWN+Rsa4Pm6d9/MKLcuOiOtPKif9u
        P4y087KOQPyLz5SfLHI=
X-Received: by 10.237.49.166 with SMTP id 35mr49597550qth.53.1497102051941;
        Sat, 10 Jun 2017 06:40:51 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f94sm2707503qtb.16.2017.06.10.06.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 06:40:51 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v5 7/7] fsmonitor: add a performance test
Date:   Sat, 10 Jun 2017 09:40:26 -0400
Message-Id: <20170610134026.104552-8-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170610134026.104552-1-benpeart@microsoft.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test utility (test-drop-caches) that enables dropping the file
system cache on Windows.

Add a perf test (p7519-fsmonitor.sh) for fsmonitor.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                    |   1 +
 t/helper/test-drop-caches.c | 107 +++++++++++++++++++++++++++++
 t/perf/p7519-fsmonitor.sh   | 161 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 t/helper/test-drop-caches.c
 create mode 100755 t/perf/p7519-fsmonitor.sh

diff --git a/Makefile b/Makefile
index 992dd58801..893947839f 100644
--- a/Makefile
+++ b/Makefile
@@ -648,6 +648,7 @@ TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-urlmatch-normalization
 TEST_PROGRAMS_NEED_X += test-wildmatch
+TEST_PROGRAMS_NEED_X += test-drop-caches
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
new file mode 100644
index 0000000000..80830d920b
--- /dev/null
+++ b/t/helper/test-drop-caches.c
@@ -0,0 +1,107 @@
+#include "git-compat-util.h"
+#include <stdio.h>
+
+typedef DWORD NTSTATUS;
+
+#ifdef GIT_WINDOWS_NATIVE
+#include <tchar.h>
+
+#define STATUS_SUCCESS			(0x00000000L)
+#define STATUS_PRIVILEGE_NOT_HELD	(0xC0000061L)
+
+typedef enum _SYSTEM_INFORMATION_CLASS {
+	SystemMemoryListInformation = 80, // 80, q: SYSTEM_MEMORY_LIST_INFORMATION; s: SYSTEM_MEMORY_LIST_COMMAND (requires SeProfileSingleProcessPrivilege)
+} SYSTEM_INFORMATION_CLASS;
+
+// private
+typedef enum _SYSTEM_MEMORY_LIST_COMMAND
+{
+	MemoryCaptureAccessedBits,
+	MemoryCaptureAndResetAccessedBits,
+	MemoryEmptyWorkingSets,
+	MemoryFlushModifiedList,
+	MemoryPurgeStandbyList,
+	MemoryPurgeLowPriorityStandbyList,
+	MemoryCommandMax
+} SYSTEM_MEMORY_LIST_COMMAND;
+
+BOOL GetPrivilege(HANDLE TokenHandle, LPCSTR lpName, int flags)
+{
+	BOOL bResult;
+	DWORD dwBufferLength;
+	LUID luid;
+	TOKEN_PRIVILEGES tpPreviousState;
+	TOKEN_PRIVILEGES tpNewState;
+
+	dwBufferLength = 16;
+	bResult = LookupPrivilegeValueA(0, lpName, &luid);
+	if (bResult)
+	{
+		tpNewState.PrivilegeCount = 1;
+		tpNewState.Privileges[0].Luid = luid;
+		tpNewState.Privileges[0].Attributes = 0;
+		bResult = AdjustTokenPrivileges(TokenHandle, 0, &tpNewState, (DWORD)((LPBYTE)&(tpNewState.Privileges[1]) - (LPBYTE)&tpNewState), &tpPreviousState, &dwBufferLength);
+		if (bResult)
+		{
+			tpPreviousState.PrivilegeCount = 1;
+			tpPreviousState.Privileges[0].Luid = luid;
+			tpPreviousState.Privileges[0].Attributes = flags != 0 ? 2 : 0;
+			bResult = AdjustTokenPrivileges(TokenHandle, 0, &tpPreviousState, dwBufferLength, 0, 0);
+		}
+	}
+	return bResult;
+}
+#endif
+
+int cmd_main(int argc, const char **argv)
+{
+	NTSTATUS status = 1;
+#ifdef GIT_WINDOWS_NATIVE
+	HANDLE hProcess = GetCurrentProcess();
+	HANDLE hToken;
+	if (!OpenProcessToken(hProcess, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES, &hToken))
+	{
+		_ftprintf(stderr, _T("Can't open current process token\n"));
+		return 1;
+	}
+
+	if (!GetPrivilege(hToken, "SeProfileSingleProcessPrivilege", 1))
+	{
+		_ftprintf(stderr, _T("Can't get SeProfileSingleProcessPrivilege\n"));
+		return 1;
+	}
+
+	CloseHandle(hToken);
+
+	HMODULE ntdll = LoadLibrary(_T("ntdll.dll"));
+	if (!ntdll)
+	{
+		_ftprintf(stderr, _T("Can't load ntdll.dll, wrong Windows version?\n"));
+		return 1;
+	}
+
+	NTSTATUS(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG) = (NTSTATUS(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
+	if (!NtSetSystemInformation)
+	{
+		_ftprintf(stderr, _T("Can't get function addresses, wrong Windows version?\n"));
+		return 1;
+	}
+
+	SYSTEM_MEMORY_LIST_COMMAND command = MemoryPurgeStandbyList;
+	status = NtSetSystemInformation(
+		SystemMemoryListInformation,
+		&command,
+		sizeof(SYSTEM_MEMORY_LIST_COMMAND)
+	);
+	if (status == STATUS_PRIVILEGE_NOT_HELD)
+	{
+		_ftprintf(stderr, _T("Insufficient privileges to execute the memory list command"));
+	}
+	else if (status != STATUS_SUCCESS)
+	{
+		_ftprintf(stderr, _T("Unable to execute the memory list command %lX"), status);
+	}
+#endif
+
+	return status;
+}
diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
new file mode 100755
index 0000000000..e41905cb9b
--- /dev/null
+++ b/t/perf/p7519-fsmonitor.sh
@@ -0,0 +1,161 @@
+#!/bin/sh
+
+test_description="Test core.fsmonitor"
+
+. ./perf-lib.sh
+
+# This has to be run with GIT_PERF_REPEAT_COUNT=1 to generate valid results.
+# Otherwise the caching that happens for the nth run will negate the validity
+# of the comparisons.
+if [ "$GIT_PERF_REPEAT_COUNT" -ne 1 ]
+then
+	echo "warning: This test must be run with GIT_PERF_REPEAT_COUNT=1 to generate valid results." >&2
+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+	GIT_PERF_REPEAT_COUNT=1
+fi
+
+test_perf_large_repo
+test_checkout_worktree
+
+# Convert unix style paths to what Watchman expects
+case "$(uname -s)" in
+MINGW*|MSYS_NT*)
+  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,/,g')"
+  ;;
+*)
+  GIT_WORK_TREE="$PWD"
+  ;;
+esac
+
+# The big win for using fsmonitor is the elimination of the need to scan
+# the working directory looking for changed files and untracked files. If
+# the file information is all cached in RAM, the benefits are reduced.
+
+flush_disk_cache () {
+	case "$(uname -s)" in
+	MINGW*|MSYS_NT*)
+	  sync && test-drop-caches
+	  ;;
+	*)
+	  sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
+	  ;;
+	esac
+
+}
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+test_expect_success "setup" '
+	# Maybe set untrackedCache & splitIndex depending on the environment
+	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
+	then
+		git config core.untrackedCache "$GIT_PERF_7519_UNTRACKED_CACHE"
+	else
+		if test_have_prereq UNTRACKED_CACHE
+		then
+			git config core.untrackedCache true
+		else
+			git config core.untrackedCache false
+		fi
+	fi &&
+
+	if test -n "$GIT_PERF_7519_SPLIT_INDEX"
+	then
+		git config core.splitIndex "$GIT_PERF_7519_SPLIT_INDEX"
+	fi &&
+
+	# Hook scaffolding
+	mkdir .git/hooks &&
+	cp ../../../templates/hooks--query-fsmonitor.sample .git/hooks/query-fsmonitor &&
+
+	# have Watchman monitor the test folder
+	watchman watch "$GIT_WORK_TREE" &&
+	watchman watch-list | grep -q -F "$GIT_WORK_TREE"
+'
+
+# Worst case without fsmonitor
+test_expect_success "clear fs cache" '
+	git config core.fsmonitor false &&
+	flush_disk_cache
+'
+test_perf "status (fsmonitor=false, cold fs cache)" '
+	git status
+'
+
+# Best case without fsmonitor
+test_perf "status (fsmonitor=false, warm fs cache)" '
+	git status
+'
+
+# Let's see if -uno & -uall make any difference
+test_expect_success "clear fs cache" '
+	flush_disk_cache
+'
+test_perf "status -uno (fsmonitor=false, cold fs cache)" '
+	git status -uno
+'
+
+test_expect_success "clear fs cache" '
+	flush_disk_cache
+'
+test_perf "status -uall (fsmonitor=false, cold fs cache)" '
+	git status -uall
+'
+
+# The first run with core.fsmonitor=true has to do a normal scan and write
+# out the index extension.
+test_expect_success "populate extension" '
+	# core.preloadIndex defeats the benefits of core.fsMonitor as it
+	# calls lstat for the index entries. Turn it off as _not_ doing
+	# the work is faster than doing the work across multiple threads.
+	git config core.fsmonitor true &&
+	git config core.preloadIndex false &&
+	git status
+'
+
+# Worst case with fsmonitor
+test_expect_success "shutdown fsmonitor, clear fs cache" '
+	watchman shutdown-server &&
+	flush_disk_cache
+'
+test_perf "status (fsmonitor=true, cold fs cache, cold fsmonitor)" '
+	git status
+'
+
+# Best case with fsmonitor
+test_perf "status (fsmonitor=true, warm fs cache, warm fsmonitor)" '
+	git status
+'
+
+# Best improved with fsmonitor (compare to worst case without fsmonitor)
+test_expect_success "clear fs cache" '
+	flush_disk_cache
+'
+test_perf "status (fsmonitor=true, cold fs cache, warm fsmonitor)" '
+	git status
+'
+
+# Let's see if -uno & -uall make any difference
+test_expect_success "clear fs cache" '
+	flush_disk_cache
+'
+test_perf "status -uno (fsmonitor=true, cold fs cache)" '
+	git status -uno
+'
+
+test_expect_success "clear fs cache" '
+	flush_disk_cache
+'
+test_perf "status -uall (fsmonitor=true, cold fs cache)" '
+	git status -uall
+'
+
+test_expect_success "cleanup" '
+	watchman watch-del "$GIT_WORK_TREE" &&
+	watchman shutdown-server
+'
+
+test_done
-- 
2.13.0

