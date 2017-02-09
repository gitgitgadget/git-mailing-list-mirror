Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5291C1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbdBIWYC (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:24:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:50313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbdBIWXy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:23:54 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0bo2-1cHOGd0WLu-00uoey; Thu, 09
 Feb 2017 23:23:13 +0100
Date:   Thu, 9 Feb 2017 23:23:11 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] rebase -i: use the rebase--helper builtin
In-Reply-To: <cover.1486678952.git.johannes.schindelin@gmx.de>
Message-ID: <384482cff8b2ffca7a29919e621f277a0eaea3c1.1486678952.git.johannes.schindelin@gmx.de>
References: <cover.1472805251.git.johannes.schindelin@gmx.de> <cover.1486678952.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3bmscytu0TdCZK9fNJUviRwnOw6HbXMvlJhUa0aEIi7ITqCQj5Y
 rsFc3Hzq6FF/BUYHd7r91yyINe4jVjkKFDnxMGXhpqJepAe0Zdb84GXLmKzRGK0TsY1xobH
 tdVgBCIv0q3+ksBh44CE6+/UiSXDU+aqDKuVFTZ4bmi17c+RxkSvdw5IvclxftOLLhoG8AQ
 L/vqsoorOtgz2clooT9Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Os0vHwoqNtY=:n7sOFrOFlE2sepbtWhSxB2
 cJgOco50ocWv6mBXA0bJqFxuJd7ZBx0Sm3nJPp1/sOwWJTAaBvqTNDcEU9XXUgkZye54t3QzC
 sVShC0Q5aX+xqBn2sP/WsniAaJNdzFmscCkUafiD0a16gEgK4VmAdGh4/5aZT9WP6EA0oIlsD
 GgGVANod5ItZwHh40bcbO6yeVfue64n1OyaKlTEn9SpmFjbspOorSrsC8dkqvUsD+fHNWl9Wz
 5hZ8+utbrxkloVuKk1Ftu0OnKvVFllcARO82FjW5fMVHwf6hP4L+HdKlvJuW1hq76+Aq0O57M
 4PqvUjw4oXwJYqVnD+e/1rthOllIGQkhXW5W0QmIendlTpXMNr2+hDxRZny2BqorZCJyFJhB7
 LCt8uQiaxKLc2jXLeM0tyUbMitzx/S1CbH61ff2ioF10UyZ8qFeQb5G9KcaucwAwZcHEnlCzr
 kxFakP9rpb3mOQrf/eONTWx74xQDgJoF8pJjAkRKak1oZkmXlyh0DNG214SMr6hJqQML424WL
 8HXckc7qNAfVA/odmnr9b64fCYL7RoQQBqXkrK4VqVX+QOMPTVPYAmWGOCCDKIFWS27KZSZCJ
 OenRpBQuPYi4AKcl9ecPqbvUDM0qjrGVGj7Wodv2hdSjYNl3u1xif3ZphUhBQ++FVolj2WrXD
 k1BamP11Dyb2pIA+rZdmpeo1El6Dy2wWTdVasGthJTVNvfC8f8jIYv682mc40CsJrNdG82caa
 uj0TpFbobh+aoPrzfmyOoMeEXnI18NHCL1fJoBTfmv6b6ovSnGvplv9qyH9OS0/EIyyGX4ptK
 x1hcYy/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the sequencer learned to process a "normal" interactive rebase,
we use it. The original shell script is still used for "non-normal"
interactive rebases, i.e. when --root or --preserve-merges was passed.

Please note that the --root option (via the $squash_onto variable) needs
special handling only for the very first command, hence it is still okay
to use the helper upon continue/skip.

Also please note that the --no-ff setting is volatile, i.e. when the
interactive rebase is interrupted at any stage, there is no record of
it. Therefore, we have to pass it from the shell script to the
rebase--helper.

Note: the test t3404 had to be adjusted because the the error messages
produced by the sequencer comply with our current convention to start with
a lower-case letter.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    | 13 +++++++++++++
 t/t3404-rebase-interactive.sh |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4734094a3f..2c9c0165b5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1069,6 +1069,10 @@ git_rebase__interactive () {
 
 case "$action" in
 continue)
+	if test ! -d "$rewritten"
+	then
+		exec git rebase--helper ${force_rebase:+--no-ff} --continue
+	fi
 	# do we have anything to commit?
 	if git diff-index --cached --quiet HEAD --
 	then
@@ -1128,6 +1132,10 @@ first and then run 'git rebase --continue' again.")"
 skip)
 	git rerere clear
 
+	if test ! -d "$rewritten"
+	then
+		exec git rebase--helper ${force_rebase:+--no-ff} --continue
+	fi
 	do_rest
 	return 0
 	;;
@@ -1314,6 +1322,11 @@ expand_todo_ids
 test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
 
 checkout_onto
+if test -z "$rebase_root" && test ! -d "$rewritten"
+then
+	require_clean_work_tree "rebase"
+	exec git rebase--helper ${force_rebase:+--no-ff} --continue
+fi
 do_rest
 
 }
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e2f18d11f6..33d392ba11 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -556,7 +556,7 @@ test_expect_success 'clean error after failed "exec"' '
 	echo "edited again" > file7 &&
 	git add file7 &&
 	test_must_fail git rebase --continue 2>error &&
-	test_i18ngrep "You have staged changes in your working tree." error
+	test_i18ngrep "you have staged changes in your working tree" error
 '
 
 test_expect_success 'rebase a detached HEAD' '
-- 
2.11.1.windows.1
