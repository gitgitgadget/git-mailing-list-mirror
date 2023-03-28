Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5393C761AF
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC1Rjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjC1Rjo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:39:44 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370B7AF09
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:43 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id y184so9556426oiy.8
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5G2N1remCHj5KibBcy3jcwP9yYLNU2WQLl5EGi31pk=;
        b=fv3X6Ju/LYxVq1OSF+THwFEvyNfaphL20ftjM1MQGrYpPJDpbhFsAkkihlgBuwL0Jq
         fTSwRA8V6SKb2j2AwVGzBD/eCBTu5RcqbVtGVYzZ5rP8AV5v15WeYKJMvanHK0mshAIt
         RbzaOB9dYTu7RUH3F5sdS2qnbuNlX4uii0Sk6I05bl+FhRFdFD5Srxc2zvOC27GYvHEE
         SymEYqi/3VUkFUwK5hqplayTviw70vgemJNxB0N8uJKzFKBuxwAWbvfpp2lpo/I0UJUq
         HuJ52fBfoLl1JZBrt8KNZ07vlEopMOnHeeE/BGXpFpxZsah6HDvi2JUW/5PUbJ1A064C
         cd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5G2N1remCHj5KibBcy3jcwP9yYLNU2WQLl5EGi31pk=;
        b=T/XFMscyFJobyrQCiAIAZo6acEe0xj1SZKtoihC98PsWBlTaUTa+YHFAuqicOWulsE
         6xrGZ6yavJV5IYnQGhmdwb3+Ws2qlLwWXvCO12J2rIIy4xdZha25V97iJzCqdk7yVdMh
         onXtCYThfsO8J7+4Ixs2uQWUHgfTsTKfDXa23FaCLXWQpXKskRuY28k5NxRBMltl8QaE
         SBAxPdlIYHBoRLMIwUcWx4CIejVLa/jOtlSsb1jsAs92iYlZb8rXUtyJYXrzbSQwKj+D
         7N7DFJAWDTkU5iq8ipXdhDr5DUE2vp7Ox46GQEvap6e0O9YNQwJ0i6BeJGqgivtIcpms
         iTkA==
X-Gm-Message-State: AAQBX9dWDGWRaCJw5/PF+BXX3uPRpDBVgDrw9heM57bIoDIAbWzQsV2Y
        EXhOHDLXqQKAM4xVbldAvvAgCXBmnew=
X-Google-Smtp-Source: AKy350Z8/QqKPXuYXr2xz6trvSmvhDqYWVKVP0tC2ykIEluxFp+NOozImTS+aPEBJUBBSp3CjouwfQ==
X-Received: by 2002:a54:4d04:0:b0:389:4b35:431e with SMTP id v4-20020a544d04000000b003894b35431emr2622843oix.29.1680025182198;
        Tue, 28 Mar 2023 10:39:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id t129-20020a4a5487000000b0049fd5c02d25sm12834106ooa.12.2023.03.28.10.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:39:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/6] test: avoid `path` variable
Date:   Tue, 28 Mar 2023 11:39:30 -0600
Message-Id: <20230328173932.3614601-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230328173932.3614601-1-felipe.contreras@gmail.com>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In zsh it's linked to `PATH`.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t0003-attributes.sh         | 16 ++++++------
 t/t1450-fsck.sh               | 16 ++++++------
 t/t3305-notes-fanout.sh       | 12 ++++-----
 t/t4046-diff-unmerged.sh      | 48 +++++++++++++++++------------------
 t/t5329-pack-objects-cruft.sh |  8 +++---
 5 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 89b306cb11..b956b2fc29 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -7,10 +7,10 @@ TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 attr_check_basic () {
-	path="$1" expect="$2" git_opts="$3" &&
+	fpath="$1" expect="$2" git_opts="$3" &&
 
-	git $git_opts check-attr test -- "$path" >actual 2>err &&
-	echo "$path: test: $expect" >expect &&
+	git $git_opts check-attr test -- "$fpath" >actual 2>err &&
+	echo "$fpath: test: $expect" >expect &&
 	test_cmp expect actual
 }
 
@@ -20,18 +20,18 @@ attr_check () {
 }
 
 attr_check_quote () {
-	path="$1" quoted_path="$2" expect="$3" &&
+	fpath="$1" quoted_path="$2" expect="$3" &&
 
-	git check-attr test -- "$path" >actual &&
+	git check-attr test -- "$fpath" >actual &&
 	echo "\"$quoted_path\": test: $expect" >expect &&
 	test_cmp expect actual
 }
 
 attr_check_source () {
-	path="$1" expect="$2" source="$3" git_opts="$4" &&
+	fpath="$1" expect="$2" source="$3" git_opts="$4" &&
 
-	git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
-	echo "$path: test: $expect" >expect &&
+	git $git_opts check-attr --source $source test -- "$fpath" >actual 2>err &&
+	echo "$fpath: test: $expect" >expect &&
 	test_cmp expect actual &&
 	test_must_be_empty err
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index bca46378b2..489e03865c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -589,9 +589,9 @@ test_expect_success 'fsck notices submodule entry pointing to null sha1' '
 	)
 '
 
-while read name path pretty; do
+while read name fpath pretty; do
 	while read mode type; do
-		: ${pretty:=$path}
+		: ${pretty:=$fpath}
 		test_expect_success "fsck notices $pretty as $type" '
 		(
 			git init $name-$type &&
@@ -603,7 +603,7 @@ while read name path pretty; do
 			blob=$(git rev-parse :file) &&
 			tree=$(git rev-parse HEAD^{tree}) &&
 			value=$(eval "echo \$$type") &&
-			printf "$mode $type %s\t%s" "$value" "$path" >bad &&
+			printf "$mode $type %s\t%s" "$value" "$fpath" >bad &&
 			bad_tree=$(git mktree <bad) &&
 			git fsck 2>out &&
 			test_i18ngrep "warning.*tree $bad_tree" out
@@ -674,8 +674,8 @@ create_repo_missing () {
 		unrelated=$(echo unrelated | git hash-object --stdin -w) &&
 		git tag -m foo tag $unrelated &&
 		sha1=$(git rev-parse --verify "$1") &&
-		path=$(echo $sha1 | sed 's|..|&/|') &&
-		rm .git/objects/$path
+		fpath=$(echo $sha1 | sed 's|..|&/|') &&
+		rm .git/objects/$fpath
 	)
 }
 
@@ -781,11 +781,11 @@ test_expect_success 'fsck --name-objects' '
 test_expect_success 'alternate objects are correctly blamed' '
 	test_when_finished "rm -rf alt.git .git/objects/info/alternates" &&
 	name=$(test_oid numeric) &&
-	path=$(test_oid_to_path "$name") &&
+	fpath=$(test_oid_to_path "$name") &&
 	git init --bare alt.git &&
 	echo "../../alt.git/objects" >.git/objects/info/alternates &&
-	mkdir alt.git/objects/$(dirname $path) &&
-	>alt.git/objects/$(dirname $path)/$(basename $path) &&
+	mkdir alt.git/objects/$(dirname $fpath) &&
+	>alt.git/objects/$(dirname $fpath)/$(basename $fpath) &&
 	test_must_fail git fsck >out 2>&1 &&
 	test_i18ngrep alt.git out
 '
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 1ec1fb6715..a0d8ec85a1 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -6,10 +6,10 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 path_has_fanout() {
-	path=$1 &&
+	fpath=$1 &&
 	fanout=$2 &&
 	after_last_slash=$(($(test_oid hexsz) - $fanout * 2)) &&
-	echo $path | grep -q -E "^([0-9a-f]{2}/){$fanout}[0-9a-f]{$after_last_slash}$"
+	echo $fpath | grep -q -E "^([0-9a-f]{2}/){$fanout}[0-9a-f]{$after_last_slash}$"
 }
 
 touched_one_note_with_fanout() {
@@ -17,17 +17,17 @@ touched_one_note_with_fanout() {
 	modification=$2 &&  # 'A' for addition, 'D' for deletion
 	fanout=$3 &&
 	diff=$(git diff-tree --no-commit-id --name-status --root -r $notes_commit) &&
-	path=$(echo $diff | sed -e "s/^$modification[\t ]//") &&
-	path_has_fanout "$path" $fanout;
+	fpath=$(echo $diff | sed -e "s/^$modification[\t ]//") &&
+	path_has_fanout "$fpath" $fanout;
 }
 
 all_notes_have_fanout() {
 	notes_commit=$1 &&
 	fanout=$2 &&
 	git ls-tree -r --name-only $notes_commit |
-	while read path
+	while read fpath
 	do
-		path_has_fanout $path $fanout || return 1
+		path_has_fanout $fpath $fanout || return 1
 	done
 }
 
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index ffaf69335f..4998a1ce27 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -19,10 +19,10 @@ test_expect_success setup '
 		do
 			for t in o x
 			do
-				path="$b$o$t" &&
-				case "$path" in ooo) continue ;; esac &&
-				paths="$paths$path " &&
-				p="	$path" &&
+				fpath="$b$o$t" &&
+				case "$fpath" in ooo) continue ;; esac &&
+				paths="$paths$fpath " &&
+				p="	$fpath" &&
 				case "$b" in x) echo "$m1$p" ;; esac &&
 				case "$o" in x) echo "$m2$p" ;; esac &&
 				case "$t" in x) echo "$m3$p" ;; esac ||
@@ -36,22 +36,22 @@ test_expect_success setup '
 '
 
 test_expect_success 'diff-files -0' '
-	for path in $paths
+	for fpath in $paths
 	do
-		>"$path" &&
-		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" || return 1
+		>"$fpath" &&
+		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$fpath" || return 1
 	done >diff-files-0.expect &&
 	git diff-files -0 >diff-files-0.actual &&
 	test_cmp diff-files-0.expect diff-files-0.actual
 '
 
 test_expect_success 'diff-files -1' '
-	for path in $paths
+	for fpath in $paths
 	do
-		>"$path" &&
-		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" &&
-		case "$path" in
-		x??) echo ":100644 100644 $blob1 $ZERO_OID M	$path"
+		>"$fpath" &&
+		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$fpath" &&
+		case "$fpath" in
+		x??) echo ":100644 100644 $blob1 $ZERO_OID M	$fpath"
 		esac || return 1
 	done >diff-files-1.expect &&
 	git diff-files -1 >diff-files-1.actual &&
@@ -59,12 +59,12 @@ test_expect_success 'diff-files -1' '
 '
 
 test_expect_success 'diff-files -2' '
-	for path in $paths
+	for fpath in $paths
 	do
-		>"$path" &&
-		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" &&
-		case "$path" in
-		?x?) echo ":100644 100644 $blob2 $ZERO_OID M	$path"
+		>"$fpath" &&
+		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$fpath" &&
+		case "$fpath" in
+		?x?) echo ":100644 100644 $blob2 $ZERO_OID M	$fpath"
 		esac || return 1
 	done >diff-files-2.expect &&
 	git diff-files -2 >diff-files-2.actual &&
@@ -74,12 +74,12 @@ test_expect_success 'diff-files -2' '
 '
 
 test_expect_success 'diff-files -3' '
-	for path in $paths
+	for fpath in $paths
 	do
-		>"$path" &&
-		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$path" &&
-		case "$path" in
-		??x) echo ":100644 100644 $blob3 $ZERO_OID M	$path"
+		>"$fpath" &&
+		echo ":000000 100644 $ZERO_OID $ZERO_OID U	$fpath" &&
+		case "$fpath" in
+		??x) echo ":100644 100644 $blob3 $ZERO_OID M	$fpath"
 		esac || return 1
 	done >diff-files-3.expect &&
 	git diff-files -3 >diff-files-3.actual &&
@@ -87,9 +87,9 @@ test_expect_success 'diff-files -3' '
 '
 
 test_expect_success 'diff --stat' '
-	for path in $paths
+	for fpath in $paths
 	do
-		echo " $path | Unmerged" || return 1
+		echo " $fpath | Unmerged" || return 1
 	done >diff-stat.expect &&
 	echo " 0 files changed" >>diff-stat.expect &&
 	git diff --cached --stat >diff-stat.actual &&
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 303f7a5d84..86838d2b0f 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -28,8 +28,8 @@ basic_cruft_pack_tests () {
 				git rev-list --objects --no-object-names base..loose |
 				while read oid
 				do
-					path="$objdir/$(test_oid_to_path "$oid")" &&
-					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$path")" ||
+					fpath="$objdir/$(test_oid_to_path "$oid")" &&
+					printf "%s %d\n" "$oid" "$(test-tool chmtime --get "$fpath")" ||
 					echo "object list generation failed for $oid"
 				done |
 				sort -k1
@@ -413,8 +413,8 @@ test_expect_success 'loose objects mtimes upsert others' '
 		git repack &&
 
 		tip="$(git rev-parse cruft)" &&
-		path="$objdir/$(test_oid_to_path "$tip")" &&
-		test-tool chmtime --get +1000 "$path" >expect &&
+		fpath="$objdir/$(test_oid_to_path "$tip")" &&
+		test-tool chmtime --get +1000 "$fpath" >expect &&
 
 		git checkout main &&
 		git branch -D other &&
-- 
2.39.2.13.g1fb56cf030

