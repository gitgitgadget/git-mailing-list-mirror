Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E938C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhLLUO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:59 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33323 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhLLUOo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:44 -0500
Received: by mail-wr1-f45.google.com with SMTP id d24so23983924wra.0
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5VciY6HitHWLQ8tqHmGM8k1JHQcu0ADZwp75LTXwFys=;
        b=nZl/Lz8q+1WKGh8u6QWMi6BmlQH3Se/a03xjft1f5UFeOTamu03w4PZGmTjGSidID6
         TMyX4V1QJv8gru0d3ybtwwEuN9NC9a3kiLag1b8VgS7LeMcDE6UISEl6eFdsPjDobpY+
         C1BuReXFlVNuI2Kqr7VkzsHFTDT27M7AMRZ9/tDiPsBwVPMutD/9OMrvZJaXtelivUIx
         D4OE/D7v3lmEk16qS3JHmnXkltwmK13FYJxPYNw3EblVfPiN18W6GeXiU2F05q0uR3X4
         HkhB+dsZZF1OdQod5DD4LCUHSquUpwXdS44Whe8v6Gop4zb9tPoJccv1pGHtLMH2N3UZ
         fkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5VciY6HitHWLQ8tqHmGM8k1JHQcu0ADZwp75LTXwFys=;
        b=f+15CYezeK/NpIIQq+glv6mF+Cy2nUE69xq+GrZPhPpaZLTBcmtRDTNeGf/yhVSGH/
         V5kbmJfQUfu8mE/rwVJV1WwUS8Lb10ioH/+V4YrpsyH79AfUBdCziWNjZRHMYXnIRPgo
         SREGLhEQ0cuPthH3QDdO/Snm86XSz637w7CTl9zcm8Cr5WOzu6yMcTlCWOdcNNpy495X
         tuhDQ0ndgAWteV97emi/W7EX72Sd8uFYN7lRerR6mckIJ8NJynZhY2OlJe2Pdb833mRl
         01sSPPn01NIWqun7n+oTJGxZKXvHOmLbuaLX5yvGScZiNwpJSXtLdo4bzEkiGUxwyJK1
         GWOQ==
X-Gm-Message-State: AOAM530b+24bELxgHzSD0JaSWeYPP6/i0Ve+iA3JlXxm3+qLdAZwQMTA
        kqDJC7CcOw7g5k5mgEN1p7ETwmg40Lnl3A==
X-Google-Smtp-Source: ABdhPJyAobZHdSG1JDUi68XFDrQqF9xNX7c0eGi2SzQo3vwIItOYBf5VsYi9VB75QTXdniobPL5DsQ==
X-Received: by 2002:a05:6000:120d:: with SMTP id e13mr12197831wrx.657.1639340022692;
        Sun, 12 Dec 2021 12:13:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/13] test-lib-functions: add and use a "write_hook" wrapper
Date:   Sun, 12 Dec 2021 21:13:20 +0100
Message-Id: <patch-10.13-ca55471d134-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "write_hook" wrapper for the common case of "write_script
.git/hooks/<NAME>". This also accepts a "-C" option like
"test_commit". Let's convert various trivial cases of "write_script"
over to it.

For now this doesn't have much of an advantage, but in a subsequent
commit we'll implicitly create the leading "hooks" directory. This
will help us get rid of our --template dependency for "hooks".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1416-ref-transaction-hooks.sh    | 14 +++++++-------
 t/t5406-remote-rejects.sh           |  2 +-
 t/t5409-colorize-remote-messages.sh |  2 +-
 t/t5411-proc-receive-hook.sh        |  4 ++--
 t/t5510-fetch.sh                    |  6 +++---
 t/t5516-fetch-push.sh               |  4 ++--
 t/t5521-pull-options.sh             |  4 ++--
 t/t5547-push-quarantine.sh          |  4 ++--
 t/t5548-push-porcelain.sh           |  2 +-
 t/t6500-gc.sh                       |  4 ++--
 t/test-lib-functions.sh             | 26 ++++++++++++++++++++++++++
 11 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 6c941027a81..4532c90274b 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 test_expect_success 'hook allows updating ref if successful' '
 	test_when_finished "rm .git/hooks/reference-transaction" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	write_hook reference-transaction <<-\EOF &&
 		echo "$*" >>actual
 	EOF
 	cat >expect <<-EOF &&
@@ -32,7 +32,7 @@ test_expect_success 'hook allows updating ref if successful' '
 test_expect_success 'hook aborts updating ref in prepared state' '
 	test_when_finished "rm .git/hooks/reference-transaction" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	write_hook reference-transaction <<-\EOF &&
 		if test "$1" = prepared
 		then
 			exit 1
@@ -45,7 +45,7 @@ test_expect_success 'hook aborts updating ref in prepared state' '
 test_expect_success 'hook gets all queued updates in prepared state' '
 	test_when_finished "rm .git/hooks/reference-transaction actual" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	write_hook reference-transaction <<-\EOF &&
 		if test "$1" = prepared
 		then
 			while read -r line
@@ -68,7 +68,7 @@ test_expect_success 'hook gets all queued updates in prepared state' '
 test_expect_success 'hook gets all queued updates in committed state' '
 	test_when_finished "rm .git/hooks/reference-transaction actual" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	write_hook reference-transaction <<-\EOF &&
 		if test "$1" = committed
 		then
 			while read -r line
@@ -88,7 +88,7 @@ test_expect_success 'hook gets all queued updates in committed state' '
 test_expect_success 'hook gets all queued updates in aborted state' '
 	test_when_finished "rm .git/hooks/reference-transaction actual" &&
 	git reset --hard PRE &&
-	write_script .git/hooks/reference-transaction <<-\EOF &&
+	write_hook reference-transaction <<-\EOF &&
 		if test "$1" = aborted
 		then
 			while read -r line
@@ -115,11 +115,11 @@ test_expect_success 'interleaving hook calls succeed' '
 
 	git init --bare target-repo.git &&
 
-	write_script target-repo.git/hooks/reference-transaction <<-\EOF &&
+	write_hook -C target-repo.git reference-transaction <<-\EOF &&
 		echo $0 "$@" >>actual
 	EOF
 
-	write_script target-repo.git/hooks/update <<-\EOF &&
+	write_hook -C target-repo.git update <<-\EOF &&
 		echo $0 "$@" >>actual
 	EOF
 
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index 5c509db6fc3..c49aeea272c 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -5,7 +5,7 @@ test_description='remote push rejects are reported by client'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	write_script .git/hooks/update <<-\EOF &&
+	write_hook update <<-\EOF &&
 	exit 1
 	EOF
 	echo 1 >file &&
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 9f1a483f426..1f7cad31442 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -5,7 +5,7 @@ test_description='remote messages are colorized on the client'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	write_script .git/hooks/update <<-\EOF &&
+	write_hook update <<-\EOF &&
 	echo error: error
 	echo ERROR: also highlighted
 	echo hint: hint
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 98b0e812082..054f4b2efb3 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -36,7 +36,7 @@ setup_upstream_and_workbench () {
 		TAG=$(git -C workbench rev-parse v123) &&
 
 		# setup pre-receive hook
-		write_script upstream.git/hooks/pre-receive <<-\EOF &&
+		write_hook -C upstream.git pre-receive <<-\EOF &&
 		exec >&2
 		echo "# pre-receive hook"
 		while read old new ref
@@ -46,7 +46,7 @@ setup_upstream_and_workbench () {
 		EOF
 
 		# setup post-receive hook
-		write_script upstream.git/hooks/post-receive <<-\EOF &&
+		write_hook -C upstream.git post-receive <<-\EOF &&
 		exec >&2
 		echo "# post-receive hook"
 		while read old new ref
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a0faf0dd949..cdce39e6c76 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -265,7 +265,7 @@ test_expect_success 'fetch --atomic executes a single reference transaction only
 	EOF
 
 	rm -f atomic/actual &&
-	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+	write_hook -C atomic reference-transaction <<-\EOF &&
 		( echo "$*" && cat ) >>actual
 	EOF
 
@@ -298,7 +298,7 @@ test_expect_success 'fetch --atomic aborts all reference updates if hook aborts'
 	EOF
 
 	rm -f atomic/actual &&
-	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+	write_hook -C atomic/.git reference-transaction <<-\EOF &&
 		( echo "$*" && cat ) >>actual
 		exit 1
 	EOF
@@ -326,7 +326,7 @@ test_expect_success 'fetch --atomic --append appends to FETCH_HEAD' '
 	test_line_count = 2 atomic/.git/FETCH_HEAD &&
 	cp atomic/.git/FETCH_HEAD expected &&
 
-	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+	write_hook -C atomic reference-transaction <<-\EOF &&
 		exit 1
 	EOF
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index eea191d042f..11458052cb4 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1680,7 +1680,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 		git reset --hard HEAD^^ &&
 		git tag initial &&
 		git config receive.denyCurrentBranch updateInstead &&
-		write_script .git/hooks/push-to-checkout <<-\EOF
+		write_hook push-to-checkout <<-\EOF
 		echo >&2 updating from $(git rev-parse HEAD)
 		echo >&2 updating to "$1"
 
@@ -1739,7 +1739,7 @@ test_expect_success 'updateInstead with push-to-checkout hook' '
 	(
 		cd void &&
 		git config receive.denyCurrentBranch updateInstead &&
-		write_script .git/hooks/push-to-checkout <<-\EOF
+		write_hook push-to-checkout <<-\EOF
 		if git rev-parse --quiet --verify HEAD
 		then
 			has_head=yes
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 66cfcb09c55..9b30e90383c 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -233,7 +233,7 @@ test_expect_success 'git pull --no-verify flag passed to merge' '
 	git init src &&
 	test_commit -C src one &&
 	git clone src dst &&
-	write_script dst/.git/hooks/commit-msg <<-\EOF &&
+	write_hook -C dst commit-msg <<-\EOF &&
 	false
 	EOF
 	test_commit -C src two &&
@@ -245,7 +245,7 @@ test_expect_success 'git pull --no-verify --verify passed to merge' '
 	git init src &&
 	test_commit -C src one &&
 	git clone src dst &&
-	write_script dst/.git/hooks/commit-msg <<-\EOF &&
+	write_hook -C dst commit-msg <<-\EOF &&
 	false
 	EOF
 	test_commit -C src two &&
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index faaa51ccc56..e0bd469b110 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -5,7 +5,7 @@ test_description='check quarantine of objects during push'
 
 test_expect_success 'create picky dest repo' '
 	git init --bare dest.git &&
-	write_script dest.git/hooks/pre-receive <<-\EOF
+	write_hook -C dest.git pre-receive <<-\EOF
 	while read old new ref; do
 		test "$(git log -1 --format=%s $new)" = reject && exit 1
 	done
@@ -60,7 +60,7 @@ test_expect_success 'push to repo path with path separator (colon)' '
 
 test_expect_success 'updating a ref from quarantine is forbidden' '
 	git init --bare update.git &&
-	write_script update.git/hooks/pre-receive <<-\EOF &&
+	write_hook -C update.git pre-receive <<-\EOF &&
 	read old new refname
 	git update-ref refs/heads/unrelated $new
 	exit 1
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index f11ff57e549..8997433a992 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -168,7 +168,7 @@ run_git_push_porcelain_output_test() {
 	'
 
 	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
-		write_script "$upstream/hooks/pre-receive" <<-EOF
+		write_hook -C "$upstream" pre-receive <<-EOF
 		exit 1
 		EOF
 	'
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index c2021267f2c..98cf395806b 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -103,7 +103,7 @@ test_expect_success 'pre-auto-gc hook can stop auto gc' '
 	git init pre-auto-gc-hook &&
 	(
 		cd pre-auto-gc-hook &&
-		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
+		write_hook pre-auto-gc <<-\EOF &&
 		echo >&2 no gc for you &&
 		exit 1
 		EOF
@@ -130,7 +130,7 @@ test_expect_success 'pre-auto-gc hook can stop auto gc' '
 
 	(
 		cd pre-auto-gc-hook &&
-		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
+		write_hook pre-auto-gc <<-\EOF &&
 		echo >&2 will gc for you &&
 		exit 0
 		EOF
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index eef2262a360..3786d39ccab 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -551,6 +551,32 @@ write_script () {
 	chmod +x "$1"
 }
 
+## Usage: write-hook pre-receive
+## Usage: write-hook -C some-dir pre-receive
+write_hook () {
+	indir= &&
+	while test $# != 0
+	do
+		case "$1" in
+		-C)
+			indir="$2"
+			shift
+			;;
+		-*)
+			BUG "invalid write_hook: $1"
+			;;
+		*)
+			break
+			;;
+		esac &&
+		shift
+	done &&
+	git_dir=$(git -C "$indir" rev-parse --absolute-git-dir) &&
+	hook_dir="$git_dir/hooks" &&
+	hook_file="$hook_dir/$1"
+	write_script "$hook_file"
+}
+
 # Use test_set_prereq to tell that a particular prerequisite is available.
 # The prerequisite can later be checked for in two ways:
 #
-- 
2.34.1.1020.gb1392dd1877

