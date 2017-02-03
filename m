Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47DEE1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbdBCCyg (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:36 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36281 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbdBCCy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so1190384wmd.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBqLaGWQIAFSWI5MjRk7dihtjWIQwpNUq0JMGI5Uc14=;
        b=M4NLk/zAnynjUOGLvriAdRc7scKFqqNm9UG1oMEcEGXDWXAkEfczYVyNkwoALGZniS
         /0gaoq1q04L83sQswfwVfgTtdnEKasCd69jqoKZmhb5YNzMBkgNTh2p4xQZnWtVRHhJd
         EZWCpjj0RyaxbbqBYOR6sG9ncx2PPPU7G4R0X+VaA53K2U4Uw5dDIvqLQXHX8tujSRNn
         5BWEO9e/MbgXxYy+6/FJZfCA4HM9UrUMQQDoO7l2H61LlxgB2m8isRw/Cw04ubufmiSU
         6y1wtuwe4FkLhREiBha6pP80mUxqcZeNkDsaLDqley6xATDDvnCjjGsi2/TBTq6v8DS6
         YoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBqLaGWQIAFSWI5MjRk7dihtjWIQwpNUq0JMGI5Uc14=;
        b=U8yO8cJWEsaZ7IecG3Ljfy8YAOTvC+jHnNxWVtXfyn6BJPFtrxTZAv8wuxLimFeA9y
         ismRYifJl/PDgRbQKry9z7iVBmz5srLas0CXzkkTxD451j1DsbRHYJN0qhXpFs0yXaxH
         d0XPMiaZ79zHmeCneiiqqp/A8wJoAGzhieeRGalRhJuodpuCB3tPR/DurrrIFHgUDbft
         xAJh9A57lYwAqpkp8dIWDNB92FLUt0LIBKI00MY/UDRva+UWRZKYIF5u1FdC+G0jxQR5
         n5EY1VDP/ZwDhNiDEB9roqRuyj44f34YFJUuhjDh9y7Y/nM6nNsJiO0iwzNGc7252icA
         TADw==
X-Gm-Message-State: AIkVDXJNZsTLlBpRc7AkJXSKSVqO/FB0ITvGkgTeSXXR0yx+TQqdxbAPMbe9uRWyHFRCgA==
X-Received: by 10.223.136.16 with SMTP id d16mr10983473wrd.117.1486090467304;
        Thu, 02 Feb 2017 18:54:27 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:26 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 03/12] completion: support completing full refs after '--option=refs/<TAB>'
Date:   Fri,  3 Feb 2017 03:53:56 +0100
Message-Id: <20170203025405.8242-4-szeder.dev@gmail.com>
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
index 7f19e2a4f..67a03cfd4 100644
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
index 50c534072..8fe748839 100755
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
 	sed -e "s/Z$//g" >expected <<-EOF &&
 	HEAD Z
-- 
2.11.0.555.g967c1bcb3

