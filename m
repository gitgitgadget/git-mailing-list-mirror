Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8573F20958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965104AbdCWP3x (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34459 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964888AbdCWP3s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id u132so17261707wmg.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKqnt9UoiqoUp3ougpIG2YnKHdJkCVa+AGB4aPy5tqE=;
        b=utGCDSSz/C4l+z1ygrVVhV2bNGJRma3G1A9o03B8zwugzyZUxlAeK+DNgikiAM+jDO
         VdH+dechiqMRCKh53F65VPSrPVEm6g7aW66xPESd61RXd43No4qxyDOZn4sxZjqu4quU
         D108sum+h+fRb5+06TXiMm4sMObcNFvZZ5ji171+r5itmhjdEFx2P9eIHOmvufqeSVnA
         7QWexHxQDgcsloKdTjRsKPRHSOdQKhrKklNoXml9L5tyWt0AownAukejgRBgpdrVqB64
         6nU5gaTH/7j9lEs2Ocv4uXtrSv2iuBZzPsZ/mar9S4t4Fl5YxQ/6sntV3PHdfLvG6w5f
         1U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKqnt9UoiqoUp3ougpIG2YnKHdJkCVa+AGB4aPy5tqE=;
        b=g6IhTuBtxzH6ZyRB1UYqjP2sA2YBjhJPOPQbkCGVaozzJhIcKoF46Y9+jqGreSKLFk
         qaq+n+m+5GvLCWOkkJQvgrvPeCnpdPeIv7Dso2ODsBX+KMUMVvcvBpzFfh+TjEmOtChV
         SVa9HmTha6QJb4pbnEyyWPw9gPUFn1OkCsKh8V8rVf8ahaKCQ8F7fli4z96yj/dXHr5y
         ZhNKThazlaZe2vt7Aj8qzd9qTZKiawSuS3Xmos5Yijbu6SmI88EV7YlYvm6euljkaDEG
         cCPzAcZZ9wWagV6AEUhncWBsz9lcstyfuWdtrozMyXUTA0ge+2uVkRX0a7yeHwHNAFbI
         ULvw==
X-Gm-Message-State: AFeK/H3S68ZOx4wQWUC9bYnUdfEGhh+AFh3wbYachmoOZw/jMCRdyZ29iyE3vSuIHVCGTQ==
X-Received: by 10.28.8.147 with SMTP id 141mr14028954wmi.43.1490282986411;
        Thu, 23 Mar 2017 08:29:46 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 12/14] completion: fill COMPREPLY directly when completing refs
Date:   Thu, 23 Mar 2017 16:29:22 +0100
Message-Id: <20170323152924.23944-13-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
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
    for-each-ref' format containing said prefix and suffix.  Care
    should be taken, though, because that prefix might contain
    'for-each-ref' format specifiers as part of the left hand side of
    a '..' range or '...' symmetric difference notation or
    fetch/push/etc. refspec, e.g. 'git log "evil-%(refname)..br<TAB>'.
    Doubling every '%' in the prefix will prevent 'git for-each-ref'
    from interpolating any of those contained specifiers.
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
parameters and add them to each and every listed ref as described
above.  Modify __git_complete_refs() to pass the prefix and suffix
parameters to __git_refs() and to feed __git_refs()'s output to
__gitcomp_direct() instead of __gitcomp_nl().

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
 contrib/completion/git-completion.bash | 54 +++++++++++++++++++++++++---------
 contrib/completion/git-completion.zsh  |  9 ++++++
 t/t9902-completion.sh                  | 27 +++++++++++++++++
 3 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d26312899..41e658931 100644
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
@@ -354,18 +368,21 @@ __git_tags ()
 #    Can be the name of a configured remote, a path, or a URL.
 # 2: In addition to local refs, list unique branches from refs/remotes/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
-# 3: Currently ignored.
+# 3: A prefix to be added to each listed ref (optional).
 # 4: List only refs matching this word (optional; list all refs if unset or
 #    empty).
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
 	local match="${4-}"
+	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
 
 	__git_find_repo_path
 	dir="$__git_repo_path"
@@ -390,7 +407,8 @@ __git_refs ()
 
 	if [ "$list_refs_from" = path ]; then
 		if [[ "$cur_" == ^* ]]; then
-			pfx="^"
+			pfx="$pfx^"
+			fer_pfx="$fer_pfx^"
 			cur_=${cur_#^}
 			match=${match#^}
 		fi
@@ -405,7 +423,7 @@ __git_refs ()
 				case "$i" in
 				$match*)
 					if [ -e "$dir/$i" ]; then
-						echo $pfx$i
+						echo "$pfx$i$sfx"
 					fi
 					;;
 				esac
@@ -416,13 +434,13 @@ __git_refs ()
 				"refs/remotes/$match*" "refs/remotes/$match*/**")
 			;;
 		esac
-		__git_dir="$dir" __git for-each-ref --format="$pfx%($format)" \
+		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
 			"${refs[@]}"
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
-			__git for-each-ref --format="%(refname:strip=3)" \
+			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
 				--sort="refname:strip=3" \
 				"refs/remotes/*/$match*" "refs/remotes/*/$match*/**" | \
 			uniq -u
@@ -435,16 +453,16 @@ __git_refs ()
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
-			$match*)	echo "HEAD" ;;
+			$match*)	echo "${pfx}HEAD$sfx" ;;
 			esac
-			__git for-each-ref --format="%(refname:strip=3)" \
+			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
 				"refs/remotes/$remote/$match*" \
 				"refs/remotes/$remote/$match*/**"
 		else
@@ -458,8 +476,8 @@ __git_refs ()
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
@@ -494,8 +512,7 @@ __git_complete_refs ()
 		shift
 	done
 
-	__gitcomp_nl "$(__git_refs "$remote" "$track" "" "$cur_")" \
-		"$pfx" "$cur_" "$sfx"
+	__gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" "$sfx")"
 }
 
 # __git_refs2 requires 1 argument (to pass to __git_refs)
@@ -2997,6 +3014,15 @@ if [[ -n ${ZSH_VERSION-} ]]; then
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
index cc9e741f9..5ed28135b 100755
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
@@ -961,6 +977,17 @@ test_expect_success 'teardown after filtering matching refs' '
 	git -C otherrepo branch -D matching/branch-in-other
 '
 
+test_expect_success '__git_refs - for-each-ref format specifiers in prefix' '
+	cat >expected <<-EOF &&
+	evil-%%-%42-%(refname)..master
+	EOF
+	(
+		cur="evil-%%-%42-%(refname)..mas" &&
+		__git_refs "" "" "evil-%%-%42-%(refname).." mas >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success '__git_complete_refs - simple' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
-- 
2.12.1.485.g1616aa492

