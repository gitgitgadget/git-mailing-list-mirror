Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8581F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbdBCCuC (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:50:02 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35131 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbdBCCt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:28 -0500
Received: by mail-wm0-f68.google.com with SMTP id u63so1170419wmu.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BESaxLk/ad1WXiAMLAsZe4hrS8aMuQfBA2tKtgPX+2I=;
        b=WOUbW9YvKd5dH/AN0oL9fjmDgfZOK9uplXRe/r7CAsQJ4yO9hb3tgpdxsWL8nhj9m1
         So/5j+LbgxH3zT01E5MmTQYC550M8csIYRdKEWeRgEN6UqnTOW9PvqyxL0vjbS9iD+md
         y8p0qwIGuaedKV9i3R2qJxBd1HCftxTiYd/h1mncVqaQjMgAxAwVUb92Q33Wj3EKARP3
         ZNL59FQn0wvRj9ceAgaw2Uf2a9s9oXtbG5THfR68ra2Zub6C+vZx+aQeG8x2xeRujszn
         lDSqsQuc/N6ley1GLMOdeFZTLHlXW5ksEAaMjooqHb5Vo0s20T1agFbZvP6WTnb2JcZ0
         P7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BESaxLk/ad1WXiAMLAsZe4hrS8aMuQfBA2tKtgPX+2I=;
        b=YGGNgpIE6VsfJQLrAtxkVce3ZEoIh4baQ4Av82OV2CoXhHsEaQPYhS9yfTu5tLxaY+
         Ew29eFMvO0P6ToNQ4vlVfLVwlOpgQO1sYIdtXj2XinfQQyARy1yBKNPy/ug4pJbozMlQ
         WP4UlVzDqY+BjyAN4yfRuMxuwtPXP5ng2LjpM8V8rogOvCzf/DyoMuJ7tyEW8nYpU2kN
         HMSzjqmhT3UldF6ooEzAZuIlDA+jrzIEBjQUA/82OX8VNZIbPQkCn+VLkdK/vfM9TmJK
         Gof0xNq4dY036qbyH1KFKDaxEYjyf8W5A9704D/rh355AHFyUr91/qXF/o4txj5vSr8C
         6jrA==
X-Gm-Message-State: AIkVDXL62ybkcb8tr2L1Gl4DDqdjB7l7wGFKlO1kENRbqa5bRONmB96YHacqBwPE/QY+Vw==
X-Received: by 10.223.161.158 with SMTP id u30mr9798278wru.152.1486090161697;
        Thu, 02 Feb 2017 18:49:21 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:20 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 09/21] completion: respect 'git --git-dir=<path>' when listing remote refs
Date:   Fri,  3 Feb 2017 03:48:17 +0100
Message-Id: <20170203024829.8071-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In __git_refs() the git commands listing refs, both short and full,
from a given remote repository are run without giving them the path to
the git repository which might have been specified on the command line
via 'git --git-dir=<path>'.  This is bad, those git commands should
access the 'refs/remotes/<remote>/' hierarchy or the remote and
credentials configuration in that specified repository.

Use the __gitdir() helper only to find the path to the .git directory
and pass the resulting path to the 'git ls-remote' and 'for-each-ref'
executions that list remote refs.  While modifying that 'for-each-ref'
line, remove the superfluous disambiguating doubledash.

Don't use __gitdir() to check that the given remote is on the file
system: basically it performs only a single if statement for us at the
considerable cost of fork()ing a subshell for a command substitution.
We are better off to perform all the necessary checks of the remote in
__git_refs().

Though __git_refs() was the last remaining callsite that passed a
remote to __gitdir(), don't delete __gitdir()'s remote-handling part
yet, just in case some users' custom completion scriptlets depend on
it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 22 +++++++++++++++++-----
 t/t9902-completion.sh                  |  4 ++--
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 295f6de24..7d7e8b9d9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -342,9 +342,21 @@ __git_tags ()
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
 __git_refs ()
 {
-	local i hash dir="$(__gitdir "${1-}")" track="${2-}"
+	local i hash dir="$(__gitdir)" track="${2-}"
+	local list_refs_from=path remote="${1-}"
 	local format refs pfx
-	if [ -d "$dir" ]; then
+
+	if [ -n "$remote" ]; then
+		if [ -d "$remote/.git" ]; then
+			dir="$remote/.git"
+		elif [ -d "$remote" ]; then
+			dir="$remote"
+		else
+			list_refs_from=remote
+		fi
+	fi
+
+	if [ "$list_refs_from" = path ] && [ -d "$dir" ]; then
 		case "$cur" in
 		refs|refs/*)
 			format="refname"
@@ -381,7 +393,7 @@ __git_refs ()
 	fi
 	case "$cur" in
 	refs|refs/*)
-		git ls-remote "$dir" "$cur*" 2>/dev/null | \
+		git --git-dir="$dir" ls-remote "$remote" "$cur*" 2>/dev/null | \
 		while read -r hash i; do
 			case "$i" in
 			*^{}) ;;
@@ -391,8 +403,8 @@ __git_refs ()
 		;;
 	*)
 		echo "HEAD"
-		git for-each-ref --format="%(refname:short)" -- \
-			"refs/remotes/$dir/" 2>/dev/null | sed -e "s#^$dir/##"
+		git --git-dir="$dir" for-each-ref --format="%(refname:short)" \
+			"refs/remotes/$remote/" 2>/dev/null | sed -e "s#^$remote/##"
 		;;
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7667baabf..6e64cd6ba 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -486,7 +486,7 @@ test_expect_success '__git_refs - configured remote - full refs' '
 	test_cmp expected "$actual"
 '
 
-test_expect_failure '__git_refs - configured remote - repo given on the command line' '
+test_expect_success '__git_refs - configured remote - repo given on the command line' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch-in-other
@@ -501,7 +501,7 @@ test_expect_failure '__git_refs - configured remote - repo given on the command
 	test_cmp expected "$actual"
 '
 
-test_expect_failure '__git_refs - configured remote - full refs - repo given on the command line' '
+test_expect_success '__git_refs - configured remote - full refs - repo given on the command line' '
 	cat >expected <<-EOF &&
 	refs/heads/branch-in-other
 	refs/heads/master-in-other
-- 
2.11.0.555.g967c1bcb3

