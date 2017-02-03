Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11731F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbdBCCyk (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36375 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbdBCCyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:37 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so1191046wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Job0YZNP9QD8obQHJ+arAADXKG70Q/SEd4Fg/7lfQQ8=;
        b=MCyWLU7/rOwysKRUACzbvD9uVc0aQUl9dyXYTiZFPk2xEZFJV7Y9IdD1Vlj5UjQ6ab
         TGRCLUeP+/w5RWw4hJUBdLLPavAaRMucWygj9Jay0JmfkZKUfjXKr8c6frs8mO0GOLIX
         3oJBQ81sWRL+CZsT2byP2W9DECHdwr7Rc21glrfmIeN8wpXT6wv2a//3WsnKgtrQuXaP
         zphEfuYLB71NXpjVba+1ZaWn0PKKmPjo7iSkHiVkju50uoRzCnEketOeac+pXG2guSIm
         BHv8FCiaVFTC4Mr69I0QGQc4mpo3sMio/qCTYcASu5aqF1v0sNCR2ZYtrE7YZvjtxFjW
         4BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Job0YZNP9QD8obQHJ+arAADXKG70Q/SEd4Fg/7lfQQ8=;
        b=VLsgx4nhjZU4sWDGOoFW+9g8Qw05ipVoCXOyV1QoEuKYc+T9tqxem/RKueSmrQ5Kgj
         JHtvRJU3k/HKO+tyqUHJe9eaaiuH5iUWXbGZpWqPiH4l4xvq87TPKFZU0IF3dOCdMoRQ
         LTzW4tSAxxpyBifrhWc57CIFOa4TbFEJKTFjvbO0Bpvf9Tn3/LdQQop/whsMkY+T3AKx
         4UuZPcUclTECkXso7H0MRB8sGEieYFlL+ar1jXZrIb8jHWkfpQfciNdp/f3bQkEsl7BH
         kTWfNK5x5pUbgb8lsDJtoIanpN2NI8wIb67ZTXJfvabiD0RDsZYlFGkZLfQJJBKT3Ziy
         i3kg==
X-Gm-Message-State: AMke39mdbKcLwvE2YiwKpEpWJ0RA8wXx68BfWLBqqURGg3Zta+s8Ca8seqIWl3peHu90xA==
X-Received: by 10.28.61.84 with SMTP id k81mr420004wma.27.1486090475894;
        Thu, 02 Feb 2017 18:54:35 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:35 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 12/12] completion: fill COMPREPLY directly when completing refs
Date:   Fri,  3 Feb 2017 03:54:05 +0100
Message-Id: <20170203025405.8242-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__gitcomp_nl() iterates over all the possible completion words it gets
as argument

  - filtering matching words,
  - appending a trailing space to each matching word (in all but two
    cases),
  - prepending a prefix to each matching word (when completing words
    after e.g. '--option=<TAB>' or 'master..<TAB>'), and
  - adding each matching word to the COMPREPLY array.

This takes a while when a lot of refs are passed to __gitcomp_nl().

The previous changes in this series ensure that __git_refs() lists
only refs matching the current word to be completed, making a second
filtering in __gitcomp_nl() redundant.

Adding the necessary prefix and suffix could be done in __git_refs()
as well:

  - When refs come from 'git for-each-ref', then that prefix and
    suffix could be added much more efficiently using a 'git
    for-each-ref' format containing said prefix and suffix.
  - When refs come from 'git ls-remote', then that prefix and suffix
    can be added in the shell loop that has to process 'git
    ls-remote's output anyway.
  - Finally, the prefix and suffix can be added to that handful of
    potentially matching symbolic and pseudo refs right away in the
    shell loop listing them.

And then all what is still left to do is to assign a bunch of
newline-separated words to a shell array, which can be done without a
shell loop iterating over each word, basically making all of
__gitcomp_nl() unnecessary for refs completion.

Add the helper function __gitcomp_direct() to fill the COMPREPLY array
with prefiltered and preprocessed words without any additional
processing, without a shell loop, with just one single compound
assignment.  Modify __git_refs() to accept prefix and suffix
parameters and add them to each and every listed ref.  Modify
__git_complete_refs() to pass the prefix and suffix parameters to
__git_refs() and to feed __git_refs()'s output to __gitcomp_direct()
instead of __gitcomp_nl().

This speeds up refs completion when there are a lot of refs matching
the current word to be completed.  Listing all branches for completion
in a repo with 100k local branches, all packed, best of five:

  On Linux, near the beginning of this series, for reference:

    $ time __git_complete_refs

    real    0m2.028s
    user    0m1.692s
    sys     0m0.344s

  Before this patch:

    real    0m1.135s
    user    0m1.112s
    sys     0m0.024s

  After:

    real    0m0.367s
    user    0m0.352s
    sys     0m0.020s

  On Windows, near the beginning:

    real    0m13.078s
    user    0m1.609s
    sys     0m0.060s

  Before this patch:

    real    0m2.093s
    user    0m1.641s
    sys     0m0.060s

  After:

    real    0m0.683s
    user    0m0.203s
    sys     0m0.076s

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 54 ++++++++++++++++++++++++----------
 contrib/completion/git-completion.zsh  |  9 ++++++
 t/t9902-completion.sh                  | 16 ++++++++++
 3 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0ad02cec6..dbbb62f5f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -213,6 +213,20 @@ _get_comp_words_by_ref ()
 }
 fi
 
+# Fills the COMPREPLY array with prefiltered words without any additional
+# processing.
+# Callers must take care of providing only words that match the current word
+# to be completed and adding any prefix and/or suffix (trailing space!), if
+# necessary.
+# 1: List of newline-separated matching completion words, complete with
+#    prefix and suffix.
+__gitcomp_direct ()
+{
+	local IFS=$'\n'
+
+	COMPREPLY=($1)
+}
+
 __gitcompappend ()
 {
 	local x i=${#COMPREPLY[@]}
@@ -354,17 +368,19 @@ __git_tags ()
 #    Can be the name of a configured remote, a path, or a URL.
 # 2: In addition to local refs, list unique branches from refs/remotes/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
-# 3: Currently ignored.
+# 3: A prefix to be added to each listed ref (optional).
 # 4: List only refs matching this word instead of the current word being
-#    completed (optional).
+#    completed (optional; NOT ignored, if empty, but lists all refs).
+# 5: A suffix to be appended to each listed ref (optional; ignored, if set
+#    but empty).
 #
 # Use __git_complete_refs() instead.
 __git_refs ()
 {
 	local i hash dir track="${2-}"
 	local list_refs_from=path remote="${1-}"
-	local format refs pfx
-	local cur_="${4-$cur}"
+	local format refs
+	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
 
 	__git_find_repo_path
 	dir="$__git_repo_path"
@@ -389,7 +405,7 @@ __git_refs ()
 
 	if [ "$list_refs_from" = path ]; then
 		if [[ "$cur_" == ^* ]]; then
-			pfx="^"
+			pfx="$pfx^"
 			cur_=${cur_#^}
 		fi
 		case "$cur_" in
@@ -402,7 +418,7 @@ __git_refs ()
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
 				case "$i" in
 				$cur_*)	if [ -e "$dir/$i" ]; then
-						echo $pfx$i
+						echo "$pfx$i$sfx"
 					fi
 					;;
 				esac
@@ -413,13 +429,13 @@ __git_refs ()
 				"refs/remotes/$cur_*" "refs/remotes/$cur_*/**")
 			;;
 		esac
-		__git_dir="$dir" __git for-each-ref --format="$pfx%($format)" \
+		__git_dir="$dir" __git for-each-ref --format="$pfx%($format)$sfx" \
 			"${refs[@]}"
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
-			__git for-each-ref --format="%(refname:strip=3)" \
+			__git for-each-ref --format="$pfx%(refname:strip=3)$sfx" \
 				--sort="refname:strip=3" \
 				"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
 			uniq -u
@@ -432,16 +448,16 @@ __git_refs ()
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
-			*) echo "$i" ;;
+			*) echo "$pfx$i$sfx" ;;
 			esac
 		done
 		;;
 	*)
 		if [ "$list_refs_from" = remote ]; then
 			case "HEAD" in
-			$cur_*)	echo "HEAD" ;;
+			$cur_*)	echo "${pfx}HEAD$sfx" ;;
 			esac
-			__git for-each-ref --format="%(refname:strip=3)" \
+			__git for-each-ref --format="$pfx%(refname:strip=3)$sfx" \
 				"refs/remotes/$remote/$cur_*" \
 				"refs/remotes/$remote/$cur_*/**"
 		else
@@ -455,8 +471,8 @@ __git_refs ()
 			while read -r hash i; do
 				case "$i" in
 				*^{})	;;
-				refs/*)	echo "${i#refs/*/}" ;;
-				*)	echo "$i" ;;  # symbolic refs
+				refs/*)	echo "$pfx${i#refs/*/}$sfx" ;;
+				*)	echo "$pfx$i$sfx" ;;  # symbolic refs
 				esac
 			done
 		fi
@@ -491,8 +507,7 @@ __git_complete_refs ()
 		shift
 	done
 
-	__gitcomp_nl "$(__git_refs "$remote" "$track" "" "$cur_")" \
-		"$pfx" "$cur_" "$sfx"
+	__gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" "$sfx")"
 }
 
 # __git_refs2 requires 1 argument (to pass to __git_refs)
@@ -2975,6 +2990,15 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 		esac
 	}
 
+	__gitcomp_direct ()
+	{
+		emulate -L zsh
+
+		local IFS=$'\n'
+		compset -P '*[=:]'
+		compadd -Q -- ${=1} && _ret=0
+	}
+
 	__gitcomp_nl ()
 	{
 		emulate -L zsh
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e25541308..c3521fbfc 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -67,6 +67,15 @@ __gitcomp ()
 	esac
 }
 
+__gitcomp_direct ()
+{
+	emulate -L zsh
+
+	local IFS=$'\n'
+	compset -P '*[=:]'
+	compadd -Q -- ${=1} && _ret=0
+}
+
 __gitcomp_nl ()
 {
 	emulate -L zsh
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5e06acc17..1206a38ed 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -400,6 +400,22 @@ test_expect_success '__gitdir - remote as argument' '
 	test_cmp expected "$actual"
 '
 
+test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
+	sed -e "s/Z$//g" >expected <<-EOF &&
+	with-trailing-space Z
+	without-trailing-spaceZ
+	--option Z
+	--option=Z
+	$invalid_variable_name Z
+	EOF
+	(
+		cur=should_be_ignored &&
+		__gitcomp_direct "$(cat expected)" &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success '__gitcomp - trailing space - options' '
 	test_gitcomp "--re" "--dry-run --reuse-message= --reedit-message=
 		--reset-author" <<-EOF
-- 
2.11.0.555.g967c1bcb3

