Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AACC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbiFMWj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241722AbiFMWjf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EFC26AFB
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o16so8842199wra.4
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I79DrcLvwdlMAtbLG57y1xHOmg0j3Qt2YUhPNzf3+rY=;
        b=GU4Un4SLfutjruPQFobNf8hBChF0Z3obQ/PIE48uierg4DemeP5p2kjoXLPq/7p0KP
         WXL1ouwpjQK1enqJO5o4yDjT1AtSsKqod2XKQY/s25b9e1FLJH9RyEb/PbblqGdp/Nv+
         CrZ/gZSt0Sz2FtMpAy8WN7WsjopZySiGhBJcrgIzNxGwLeOq8MEksKkNmplrtFs40fAJ
         UYBezmvXzt8UNy7N13Hszd6xld3oyUDk5vQF5V3flk44AaAh3TzywOj4IbTQ6RVM+KnE
         a/rBuQdTyRY+er9K/Ji+WimIp1YRuoG0DQdszo29FHRCt0bY4Bs4aSYw2/dIJk7murUa
         TzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I79DrcLvwdlMAtbLG57y1xHOmg0j3Qt2YUhPNzf3+rY=;
        b=isD7VMwWprCEjH3SYKBYlRItyNPfk2JB66KHKzuf6Z14Dz3lCGp98dQ3uICBWg3eGq
         RCc3EwOwxnoF5boYl43ugnuYn18lk+yDSWbzLPAtZgavqdehrXs9cdWFjQht4Pq49QM6
         RyKSprSfKBw7UrXPygsCNXEVrR2Tv3Awscf3HsM0LKreM5z2Jif44HqN+EOG2Vt+M6zI
         L+l3+P7Mqe0lmFvW1cIabPTHCpbGoIuLaTM7+B1rxQkQHR8fUwMafLHjaV2+pufQpY4a
         47BAt2IzWRnCt9DcqZuKiBEPx1w/6EZJPST77cpS7fqDbfiJEBE+Pf6UPIng5L8HSXbr
         bpdg==
X-Gm-Message-State: AJIora+YC2YP8pF0I+GXxOrGE78N7kcLTRU9rQVUFmQxIgaow/6Zmma/
        ht//Pb8j1zMyYGm0H1xIKR5r8dZ5yXMNdQ==
X-Google-Smtp-Source: AGRyM1uw9VXLwD73O8oJ5Zv7VuNxyB904xynEyHEsIH9J0uxb/8RvCjBik1Syb5KFSiUHjV8OErukA==
X-Received: by 2002:a5d:4c86:0:b0:210:2e6e:3a93 with SMTP id z6-20020a5d4c86000000b002102e6e3a93mr1812326wrs.185.1655159959486;
        Mon, 13 Jun 2022 15:39:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/12] git-sh-setup.sh: remove "say" function, change last users
Date:   Tue, 14 Jun 2022 00:39:03 +0200
Message-Id: <patch-v2-12.12-31517345ae8-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "say" function, with various rewrites of the remaining
git-*.sh code to C and the preceding change to have git-submodule.sh
stop using the GIT_QUIET variable there were only four uses in
git-subtree.sh. Let's have it use an "arg_quiet" variable instead, and
move the "say" function over to it.

The only other use was a trivial message in git-instaweb.sh, since it
has never supported the --quiet option (or similar) that code added in
0b624b4ceee (instaweb: restart server if already running, 2009-11-22)
can simply use "echo" instead.

The remaining in-tree hits from "say" are all for the sibling function
defined in t/test-lib.sh. It's safe to remove this function since it
has never been documented in Documentation/git-sh-setup.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/subtree/git-subtree.sh | 15 ++++++++++++---
 git-instaweb.sh                |  2 +-
 git-sh-setup.sh                |  9 ---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 1af1d9653e9..7562a395c24 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -50,6 +50,14 @@ m,message=    use the given message as the commit message for the merge commit
 
 indent=0
 
+# Usage: say [MSG...]
+say () {
+	if test -z "$arg_quiet"
+	then
+		printf '%s\n' "$*"
+	fi
+}
+
 # Usage: debug [MSG...]
 debug () {
 	if test -n "$arg_debug"
@@ -60,7 +68,7 @@ debug () {
 
 # Usage: progress [MSG...]
 progress () {
-	if test -z "$GIT_QUIET"
+	if test -z "$arg_quiet"
 	then
 		if test -z "$arg_debug"
 		then
@@ -146,6 +154,7 @@ main () {
 	eval "$set_args"
 
 	# Begin "real" flag parsing.
+	arg_quiet=
 	arg_debug=
 	arg_prefix=
 	arg_split_branch=
@@ -161,7 +170,7 @@ main () {
 
 		case "$opt" in
 		-q)
-			GIT_QUIET=1
+			arg_quiet=1
 			;;
 		-d)
 			arg_debug=1
@@ -252,7 +261,7 @@ main () {
 	dir="$(dirname "$arg_prefix/.")"
 
 	debug "command: {$arg_command}"
-	debug "quiet: {$GIT_QUIET}"
+	debug "quiet: {$arg_quiet}"
 	debug "dir: {$dir}"
 	debug "opts: {$*}"
 	debug
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 4349566c891..c68f49454cd 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -102,7 +102,7 @@ resolve_full_httpd () {
 
 start_httpd () {
 	if test -f "$fqgitdir/pid"; then
-		say "Instance already running. Restarting..."
+		echo "Instance already running. Restarting..."
 		stop_httpd
 	fi
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ecb60d9e3cb..ce273fe0e48 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -57,15 +57,6 @@ die_with_status () {
 	exit "$status"
 }
 
-GIT_QUIET=
-
-say () {
-	if test -z "$GIT_QUIET"
-	then
-		printf '%s\n' "$*"
-	fi
-}
-
 if test -n "$OPTIONS_SPEC"; then
 	usage() {
 		"$0" -h
-- 
2.36.1.1239.gfba91521d90

