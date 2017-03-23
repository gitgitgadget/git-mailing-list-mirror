Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AC320958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965106AbdCWPan (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:30:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33200 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756023AbdCWP3k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so17293331wma.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOU7sQoIariv7I+C7NIdhQRDLnJ4Q921OmHz+kR6b8k=;
        b=uCuGGiO+3FnSDruA6io5S3YCqSH3oBr5/KOxbTo50BoDGawMbferYAQ2CXNwwFaa9p
         auvQiEnMo81qufWwg1UpzPVcYQchjvIIKV/iqIa3OW7lvLciks1RtPAtCL2leZjtlcTy
         PPuXlrf2TRBkNwFbasAlavneaRiaeCg4VU8+VwcPfLmt7kKLSYiAQnxRE4yIHMMG3mLD
         Eaj+I1C4WJINflBPzf5btRQ04Es++P+IZYMlV1K5AiSqCHYgBNjLW9lXDE3sB40eMJyp
         rLf6qGOG9ckovYpsV8Zmb15PoZfsaqsq6gGaDfqf7FTRZvl/MHaOqGsQz8Ztm5dvXRJB
         TuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOU7sQoIariv7I+C7NIdhQRDLnJ4Q921OmHz+kR6b8k=;
        b=BwepPG5dcTMp1/H9aGQJ5EzQpuJ4FAFL1Bc4TaNq22UmhNjGaZKB8BSe2Wk9md269U
         j0ZJ72JP1lRQxIqzvQ4hPUCgLXIa8RLAPrYTOWhlyUfJKYJu4dFHLGok73CYKRiQcgIr
         KjxfoDhh9rpslRWPV5YVE3KXL2O14zTpOuF+i1lNmFqyV7v12IIqiJtSytwWkmbEUEtP
         XMRm2tgxcLF0k5hyh1ote19LuoKxjhaVxbSJC5yb7w/L6s5QVkU+kVQRix7iExdXt3VJ
         WFzjx5SVIM7nzMug8TBpp3rEvxPE52qurYdE4c/o/83XOvEiyXQGtoOjCv0ZgcZc2Edj
         +vMA==
X-Gm-Message-State: AFeK/H3UmAM9hmCVSVLUr3gG1QJzu/CniVWokoB4NENuu1Whg25f7cAWnwrTatYFm4/mPw==
X-Received: by 10.28.128.147 with SMTP id b141mr13308466wmd.45.1490282978698;
        Thu, 23 Mar 2017 08:29:38 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:38 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 03/14] completion: support completing full refs after '--option=refs/<TAB>'
Date:   Thu, 23 Mar 2017 16:29:13 +0100
Message-Id: <20170323152924.23944-4-szeder.dev@gmail.com>
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

Completing full refs currently only works when the full ref stands on
in its own on the command line, but doesn't work when the current word
to be completed contains a prefix before the full ref, e.g.
'--option=refs/<TAB>' or 'master..refs/bis<TAB>'.

The reason is that __git_refs() looks at the current word to be
completed ($cur) as a whole to decide whether it has to list full (if
it starts with 'refs/') or short refs (otherwise).  However, $cur also
holds said '--option=' or 'master..' prefixes, which of course throw
off this decision.  Luckily, the default action is to list short refs,
that's why completing short refs happens to work even after a
'master..<TAB>' prefix and similar cases.

Pass only the ref part of the current word to be completed to
__git_refs() as a new positional parameter, so it can make the right
decision even if the whole current word contains some kind of a
prefix.

Make this new parameter the 4. positional parameter and leave the 3.
as an ignored placeholder for now (it will be used later in this patch
series).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 21 ++++++++++++++-------
 t/t9902-completion.sh                  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b90cfa54..b897cba4b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -354,6 +354,8 @@ __git_tags ()
 #    Can be the name of a configured remote, a path, or a URL.
 # 2: In addition to local refs, list unique branches from refs/remotes/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
+# 3: Currently ignored.
+# 4: The current ref to be completed (optional).
 #
 # Use __git_complete_refs() instead.
 __git_refs ()
@@ -361,6 +363,7 @@ __git_refs ()
 	local i hash dir track="${2-}"
 	local list_refs_from=path remote="${1-}"
 	local format refs pfx
+	local cur_="${4-$cur}"
 
 	__git_find_repo_path
 	dir="$__git_repo_path"
@@ -384,14 +387,17 @@ __git_refs ()
 	fi
 
 	if [ "$list_refs_from" = path ]; then
-		case "$cur" in
+		case "$cur_" in
 		refs|refs/*)
 			format="refname"
-			refs="${cur%/*}"
+			refs="${cur_%/*}"
 			track=""
 			;;
 		*)
-			[[ "$cur" == ^* ]] && pfx="^"
+			if [[ "$cur_" == ^* ]]; then
+				pfx="^"
+				cur_=${cur_#^}
+			fi
 			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
 				if [ -e "$dir/$i" ]; then echo $pfx$i; fi
 			done
@@ -411,16 +417,16 @@ __git_refs ()
 			while read -r entry; do
 				eval "$entry"
 				ref="${ref#*/}"
-				if [[ "$ref" == "$cur"* ]]; then
+				if [[ "$ref" == "$cur_"* ]]; then
 					echo "$ref"
 				fi
 			done | sort | uniq -u
 		fi
 		return
 	fi
-	case "$cur" in
+	case "$cur_" in
 	refs|refs/*)
-		__git ls-remote "$remote" "$cur*" | \
+		__git ls-remote "$remote" "$cur_*" | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -475,7 +481,8 @@ __git_complete_refs ()
 		shift
 	done
 
-	__gitcomp_nl "$(__git_refs "$remote" "$track")" "$pfx" "$cur_" "$sfx"
+	__gitcomp_nl "$(__git_refs "$remote" "$track" "" "$cur_")" \
+		"$pfx" "$cur_" "$sfx"
 }
 
 # __git_refs2 requires 1 argument (to pass to __git_refs)
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4e7f3076f..0a41ee1ea 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -775,6 +775,37 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
 	test_cmp expected "$actual"
 '
 
+test_expect_success '__git_refs - after --opt=' '
+	cat >expected <<-EOF &&
+	HEAD
+	master
+	matching-branch
+	other/branch-in-other
+	other/master-in-other
+	matching-tag
+	EOF
+	(
+		cur="--opt=" &&
+		__git_refs "" "" "" "" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - after --opt= - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/master
+	refs/heads/matching-branch
+	refs/remotes/other/branch-in-other
+	refs/remotes/other/master-in-other
+	refs/tags/matching-tag
+	EOF
+	(
+		cur="--opt=refs/" &&
+		__git_refs "" "" "" refs/ >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
 test_expect_success '__git_complete_refs - simple' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
-- 
2.12.1.485.g1616aa492

