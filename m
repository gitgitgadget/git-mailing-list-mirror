Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B1520D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 15:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdFAPvV (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 11:51:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35131 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdFAPvT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 11:51:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id r58so6183658qtb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vfgFXYF0HDCDOupwY//FMUvj8kvYHbhAEAse1zanz8c=;
        b=Tj+T930SBJtd6NCfeYlSvTRRLQCPAynCBIXagBHSjc7hTcX0Q8hDQ95yRJAj76OSAL
         EM+HVBKPpG+P+ln1Z+TPabHbYsAkWORP2axS3RERUEvnZtutyZsxa/wFK930sAScjYWT
         ugLNUSpTpnS3g/W9TJx/I9iFbyfBA1TFmBxamSpQ1874+x4cZgtoMeZFJbYBk0Vgg486
         yr8wzeBRUKBR+6D3+4RMTMiASr7LtYja7WXLDQsPymB4ze08+u0JYYa1JmI3brUE7vI1
         9eN3YGSt2Oat9OBZGkcuheFl7I1lg+Dt7km5g0PBv2yJs0mDdFDT+3EbYwBGc/Q9uf4f
         6heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vfgFXYF0HDCDOupwY//FMUvj8kvYHbhAEAse1zanz8c=;
        b=cpqibnUoU9i4/dRrCVIRReXdyqCn3a8vW1juIhugkA6QlR/+XGyZD1NqjuOG5haqhL
         ZPiXe3pjnrjmrtM9LdRIoLsn8k5yGRD98rf8VxzM7IVOm9NUWXxb+dj9uY0q+EFXk0eP
         2656PA0fkqAmRQvDnVcaeiXef+UQTVjzslzt9/gKkOvfhHWZGrNImUSiHzJgvzLY8R2H
         fWbdYlHjRiDfrtCxfJfbTxKzf7UFcYPdzS/zv1LNbK32j/4oX58MwX4ZMQXnR1JKtgPW
         4HT7aOHdK3B+BBLwx8O2AwFOUJgLBUPEIst3cqSGTv70EcCHcE0y6SOW6Z+K+iXcV5qJ
         W7jA==
X-Gm-Message-State: AODbwcBnOt5BXpckuUwncxs8XBYhlrelHg+u8Nzq/I8RuLwKWfCKkIGr
        j+khp3SThgMADECVTJk=
X-Received: by 10.200.44.41 with SMTP id d38mr2793367qta.182.1496332277829;
        Thu, 01 Jun 2017 08:51:17 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w41sm12715524qtg.34.2017.06.01.08.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 08:51:16 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v4 0/6] Fast git status via a file system watcher
Date:   Thu,  1 Jun 2017 11:50:59 -0400
Message-Id: <20170601155105.28356-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V3 include:
 - update test script based on feedback
 - update template hook proc with better post-processing code and make
   it executable

Ben Peart (6):
  bswap: add 64 bit endianness helper get_be64
  dir: make lookup_untracked() available outside of dir.c
  fsmonitor: teach git to optionally utilize a file system monitor to
    speed up detecting new or changed files.
  fsmonitor: add test cases for fsmonitor extension
  fsmonitor: add documentation for the fsmonitor extension.
  fsmonitor: add a sample query-fsmonitor hook script for Watchman

 Documentation/config.txt                 |   7 +
 Documentation/githooks.txt               |  23 +++
 Documentation/technical/index-format.txt |  19 +++
 Makefile                                 |   1 +
 builtin/update-index.c                   |   1 +
 cache.h                                  |   5 +
 compat/bswap.h                           |   4 +
 config.c                                 |   5 +
 dir.c                                    |  16 ++-
 dir.h                                    |   5 +
 entry.c                                  |   1 +
 environment.c                            |   1 +
 fsmonitor.c                              | 238 +++++++++++++++++++++++++++++++
 fsmonitor.h                              |   9 ++
 read-cache.c                             |  28 +++-
 t/t7519-status-fsmonitor.sh              | 173 ++++++++++++++++++++++
 templates/hooks--query-fsmonitor.sample  |  60 ++++++++
 unpack-trees.c                           |   1 +
 18 files changed, 594 insertions(+), 3 deletions(-)
 create mode 100644 fsmonitor.c
 create mode 100644 fsmonitor.h
 create mode 100755 t/t7519-status-fsmonitor.sh
 create mode 100755 templates/hooks--query-fsmonitor.sample

Interdiff (v3..v4):

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 395db46d55..458eabe6dc 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -5,48 +5,46 @@ test_description='git status with file system watcher'
 . ./test-lib.sh
 
 clean_repo () {
-	git reset --hard HEAD
-	git clean -fd
+	git reset --hard HEAD &&
+	git clean -fd &&
 	rm -f marker
 }
 
 dirty_repo () {
-	: >untracked
-	: >dir1/untracked
-	: >dir2/untracked
-	echo 1 >modified
-	echo 2 >dir1/modified
-	echo 3 >dir2/modified
-	echo 4 >new
-	echo 5 >dir1/new
-	echo 6 >dir2/new
-	git add new
-	git add dir1/new
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
 	git add dir2/new
 }
 
 # The test query-fsmonitor hook proc will output a marker file we can use to
 # ensure the hook was actually used to generate the correct results.
 
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
 test_expect_success 'setup' '
 	mkdir -p .git/hooks &&
-	write_script .git/hooks/query-fsmonitor<<-\EOF &&
-	if [ $1 -ne 1 ]
-	then
-		echo -e "Unsupported query-fsmonitor hook version.\n" >&2
-		exit 1;
-	fi
-	: >marker
-	printf "untracked\0"
-	printf "dir1/untracked\0"
-	printf "dir2/untracked\0"
-	printf "modified\0"
-	printf "dir1/modified\0"
-	printf "dir2/modified\0"
-	printf "new\0""
-	printf "dir1/new\0"
-	printf "dir2/new\0"
-	EOF
 	: >tracked &&
 	: >modified &&
 	mkdir dir1 &&
@@ -58,55 +56,19 @@ test_expect_success 'setup' '
 	git add . &&
 	test_tick &&
 	git commit -m initial &&
-	dirty_repo
-'
-
-cat >.gitignore <<\EOF
-.gitignore
-expect*
-output*
-marker*
-EOF
-
-# Status is well tested elsewhere so we'll just ensure that the results are
-# the same when using core.fsmonitor. First call after turning on the option
-# does a complete scan so need to do two calls to ensure we test the new
-# codepath.
-
-test_expect_success 'status with core.untrackedcache true' '
-	git config core.fsmonitor true  &&
-	git config core.untrackedcache true &&
-	git -c core.fsmonitor=false -c core.untrackedcache=true status >expect &&
-	clean_repo &&
-	git status &&
-	test_path_is_missing marker &&
-	dirty_repo &&
-	git status >output &&
-	test_path_is_file marker &&
-	test_i18ncmp expect output
-'
-
-
-test_expect_success 'status with core.untrackedcache false' '
 	git config core.fsmonitor true &&
-	git config core.untrackedcache false &&
-	git -c core.fsmonitor=false -c core.untrackedcache=false status >expect &&
-	clean_repo &&
-	git status &&
-	test_path_is_missing marker &&
-	dirty_repo &&
-	git status >output &&
-	test_path_is_file marker &&
-	test_i18ncmp expect output
+	cat >.gitignore <<-\EOF
+	.gitignore
+	expect*
+	output*
+	marker*
+	EOF
 '
 
 # Ensure commands that call refresh_index() to move the index back in time
 # properly invalidate the fsmonitor cache
 
 test_expect_success 'refresh_index() invalidates fsmonitor cache' '
-	git config core.fsmonitor true &&
-	git config core.untrackedcache true &&
-	clean_repo &&
 	git status &&
 	test_path_is_missing marker &&
 	dirty_repo &&
@@ -118,6 +80,7 @@ test_expect_success 'refresh_index() invalidates fsmonitor cache' '
 	git status &&
 	test_path_is_file marker &&
 	git reset HEAD~1 &&
+	rm -f marker &&
 	git status >output &&
 	test_path_is_file marker &&
 	git -c core.fsmonitor=false status >expect &&
@@ -129,9 +92,7 @@ test_expect_success 'refresh_index() invalidates fsmonitor cache' '
 # extensions exist other than 'TREE' so do a "git status" to get the extension
 # written before testing the results.
 
-test_expect_success 'status doesnt detect unreported modifications' '
-	git config core.fsmonitor true &&
-	git config core.untrackedcache true &&
+test_expect_success "status doesn't detect unreported modifications" '
 	write_script .git/hooks/query-fsmonitor<<-\EOF &&
 	:>marker
 	EOF
@@ -146,13 +107,67 @@ test_expect_success 'status doesnt detect unreported modifications' '
 	test_i18ngrep ! "Untracked files:" output &&
 	write_script .git/hooks/query-fsmonitor<<-\EOF &&
 	:>marker
-	printf "untracked%s\0"
+	printf "untracked\0"
 	printf "dir1/modified\0"
 	EOF
+	rm -f marker &&
 	git status >output &&
 	test_path_is_file marker &&
 	test_i18ngrep "Changes not staged for commit:" output &&
 	test_i18ngrep "Untracked files:" output
 '
 
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
 test_done
diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
old mode 100644
new mode 100755
index 615f3332fa..941c4c5b57
--- a/templates/hooks--query-fsmonitor.sample
+++ b/templates/hooks--query-fsmonitor.sample
@@ -4,10 +4,10 @@
 # (https://facebook.github.io/watchman/) with git to provide fast
 # git status.
 #
-# The hook is passed a time in nanoseconds formatted as a string and
-# outputs to stdout all files that have been modified since the given
-# time. Paths must be relative to the root of the working tree and
-# separated by a single NUL.
+# The hook is passed a version (currently 1) and a time in nanoseconds
+# formatted as a string and outputs to stdout all files that have been
+# modified since the given time. Paths must be relative to the root of
+# the working tree and separated by a single NUL.
 #
 # To enable this hook, rename this file to "query-fsmonitor"
 
@@ -33,5 +33,28 @@ esac
 
 # Query Watchman for all the changes since the requested time
 echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $time_t, \"fields\":[\"name\"]}]" | \
-watchman -j | \
-perl -e 'use JSON::PP; my $o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o->{'error'}.\nFalling back to scanning...\n" if defined($o->{"error"}); print(join("\0", @{$o->{"files"}}));'
+	watchman -j |
+	perl -0666 -e '
+		use strict;
+		use warnings;
+
+		my $stdin = <>;
+		die "Watchman: command returned no output.\nFalling back to scanning...\n" if $stdin eq "";
+		die "Watchman: command returned invalid output: $stdin\nFalling back to scanning...\n" unless $stdin =~ /^\{/;
+
+		my $json_pkg;
+		eval {
+			require JSON::XS;
+			$json_pkg = "JSON::XS";
+			1;
+		} or do {
+			require JSON::PP;
+			$json_pkg = "JSON::PP";
+		};
+
+		my $o = $json_pkg->new->utf8->decode($stdin);
+		die "Watchman: $o->{error}.\nFalling back to scanning...\n" if $o->{error};
+
+		local $, = "\0";
+		print @{$o->{files}};
+	'

-- 
2.13.0.windows.1.9.gc201c67b71

