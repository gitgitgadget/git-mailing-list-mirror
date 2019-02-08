Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FA511F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBHTva (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:51:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35962 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfBHTv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:51:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id r9so5356823qtt.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 11:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzW0qUiS+IuRJ8NEqrVplIXCViBHT85dZ4B7a41JnW8=;
        b=a/DK+Hebpj+YAexGT/cVCrPPtPOWG4jUIZWRdhXOWOOqOBRJvHCLwhBNEH31C2CcVS
         WRlpIj+9ceKzYmkzTbh8e4vAk666G4CW0JghrHvTquIKA3tmymvxmBS4iQMzjnwH0qlB
         AgHrNx1HCQs9HPt1+pPHuAac67JPw6WdBGJE603opA3AG1i44n5M1n2topgTELSpeu9t
         SvYGAe1bbvFHMZ8qGs5izz4yF7WRHezn/dLw7CMGHKRSj11HwAP9rLq3VQ8QyCvhnWwc
         7B66E3TRoakQFIPOC3nOrziXybM9TqCwFqMuOwfVZKunlBN2Gg24isebBIR4GGSxhW7S
         ceAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzW0qUiS+IuRJ8NEqrVplIXCViBHT85dZ4B7a41JnW8=;
        b=FE/LmA3wumIEeXIuhlLYysazvVg/VCrq1rCwKFyGukXn+pVpUe47NcwUwxkfMkIK8c
         9sH+NEJ7U9NhpBYqUMuN163AvBKEOM/X/8NaCtwtPmPfFeMlH7MUv6jGCq4naWffFhHG
         +TVllB/IvgFmw7y4XEWQAdVyvef3Clc6PVGB9U3Hz869kh3YmxufvUvJSRIYDpRISdY6
         asmSNg3/rx0VDshKa9aCjmAea1r5UylxwqG8z1xIVkmoBzeonPhEHUEF3AY2N8xre8J8
         f9pWwlkhv8S97wwogzcruhQn2n05LrEUBLVo2zvHbMpVm7P99Y4XGTU7gd+R5OdMo8bU
         YBHw==
X-Gm-Message-State: AHQUAuZHmf1EXfCKF21oitNhk3n8n8SWqgGQSt02DhAw9jM615dX2QoC
        64CHwmBCYSUKLzu0riqdbhVc5QTDbu4=
X-Google-Smtp-Source: AHgI3IaVhNGsFPVqRuY47r1Z6tTQs/kjeZaVzBG1iwote6p0ODyhSmIRq+6aRQ8V7lQu5/TT90dNSw==
X-Received: by 2002:a0c:98fa:: with SMTP id g55mr6284218qvd.211.1549655487206;
        Fri, 08 Feb 2019 11:51:27 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 12sm8253054qka.83.2019.02.08.11.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:51:26 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, kewillf@microsoft.com
Subject: [PATCH v1 2/3] read-cache: add test for post-indexchanged hook
Date:   Fri,  8 Feb 2019 14:51:14 -0500
Message-Id: <20190208195115.12156-3-peartben@gmail.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190208195115.12156-1-peartben@gmail.com>
References: <20190208195115.12156-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Test the new post-indexchanged hook and ensure it is triggered and passes
the correct flags for various git commands.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 t/t7113-post-index-changed-hook.sh | 144 +++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100755 t/t7113-post-index-changed-hook.sh

diff --git a/t/t7113-post-index-changed-hook.sh b/t/t7113-post-index-changed-hook.sh
new file mode 100755
index 0000000000..5aeb726e37
--- /dev/null
+++ b/t/t7113-post-index-changed-hook.sh
@@ -0,0 +1,144 @@
+#!/bin/sh
+
+test_description='post index changed hook'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p dir1 &&
+	touch dir1/file1.txt &&
+	echo testing >dir1/file2.txt &&
+	git add . &&
+	git commit -m "initial"
+'
+
+test_expect_success 'test status, add, commit, others trigger hook without flags set' '
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-indexchanged <<-\EOF &&
+		if test "$1" -eq 1; then
+			echo "Invalid combination of flags passed to hook; updated_workdir is set." >testfailure
+			exit 1
+		fi
+		if test "$2" -eq 1; then
+			echo "Invalid combination of flags passed to hook; updated_skipworktree is set." >testfailure
+			exit 1
+		fi
+		if test -f ".git/index.lock"; then
+			echo ".git/index.lock exists" >testfailure
+			exit 3
+		fi
+		if ! test -f ".git/index"; then
+			echo ".git/index does not exist" >testfailure
+			exit 3
+		fi
+		echo "success" >testsuccess
+	EOF
+	mkdir -p dir2 &&
+	touch dir2/file1.txt &&
+	touch dir2/file2.txt &&
+	: force index to be dirty &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git status &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git add . &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git commit -m "second" &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git checkout -- dir1/file1.txt &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git update-index &&
+	test_path_is_missing testsuccess &&
+	test_path_is_missing testfailure &&
+	git reset --soft &&
+	test_path_is_missing testsuccess &&
+	test_path_is_missing testfailure
+'
+
+test_expect_success 'test checkout and reset trigger the hook' '
+	write_script .git/hooks/post-indexchanged <<-\EOF &&
+		if test "$1" -eq 1 && test "$2" -eq 1; then
+			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
+			exit 1
+		fi
+		if test "$1" -eq 0 && test "$2" -eq 0; then
+			echo "Invalid combination of flags passed to hook; neither updated_workdir or updated_skipworktree are set." >testfailure
+			exit 2
+		fi
+		if test "$1" -eq 1; then
+			if test -f ".git/index.lock"; then
+				echo "updated_workdir set but .git/index.lock exists" >testfailure
+				exit 3
+			fi
+			if ! test -f ".git/index"; then
+				echo "updated_workdir set but .git/index does not exist" >testfailure
+				exit 3
+			fi
+		else
+			echo "update_workdir should be set for checkout" >testfailure
+			exit 4
+		fi
+		echo "success" >testsuccess
+	EOF
+	: force index to be dirty &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git checkout master &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git checkout HEAD &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git reset --hard &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git checkout -B test &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure
+'
+
+test_expect_success 'test reset --mixed and update-index triggers the hook' '
+	write_script .git/hooks/post-indexchanged <<-\EOF &&
+		if test "$1" -eq 1 && test "$2" -eq 1; then
+			echo "Invalid combination of flags passed to hook; updated_workdir and updated_skipworktree are both set." >testfailure
+			exit 1
+		fi
+		if test "$1" -eq 0 && test "$2" -eq 0; then
+			echo "Invalid combination of flags passed to hook; neither updated_workdir or updated_skipworktree are set." >testfailure
+			exit 2
+		fi
+		if test "$2" -eq 1; then
+			if test -f ".git/index.lock"; then
+				echo "updated_skipworktree set but .git/index.lock exists" >testfailure
+				exit 3
+			fi
+			if ! test -f ".git/index"; then
+				echo "updated_skipworktree set but .git/index does not exist" >testfailure
+				exit 3
+			fi
+		else
+			echo "updated_skipworktree should be set for reset --mixed and update-index" >testfailure
+			exit 4
+		fi
+		echo "success" >testsuccess
+	EOF
+	: force index to be dirty &&
+	test-tool chmtime +60 dir1/file1.txt &&
+	git reset --mixed --quiet HEAD~1 &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git hash-object -w --stdin <dir1/file2.txt >expect &&
+	git update-index --cacheinfo 100644 "$(cat expect)" dir1/file1.txt &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure &&
+	git update-index --skip-worktree dir1/file2.txt &&
+	git update-index --remove dir1/file2.txt &&
+	test_path_is_file testsuccess && rm -f testsuccess &&
+	test_path_is_missing testfailure
+'
+
+test_done
-- 
2.20.1.windows.1

