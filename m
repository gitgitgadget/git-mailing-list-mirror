Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC6BC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357515AbiFVO2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358368AbiFVO22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F01BE8C
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j24so2970046wrb.11
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I79DrcLvwdlMAtbLG57y1xHOmg0j3Qt2YUhPNzf3+rY=;
        b=KLARUimfls+7Tp2fUosv0EIfrMy8VE1nfmCn6dQy9nNVQis7MMDQlcSQNtOBVYOu+M
         MZDYuNSjoUxmK9YLQK9OLsE+lJ5aaRAMFagtBW8WPVDbYQsVZ0R0hGWs/OZO/J2IuNTy
         zytB6pfhr367YHLrufP+B8FFtX6Z/Uby3lIXaSoPx/Npf2A4WMrEChUQbjK5SgmeQ9Yq
         yDRibHToKkk1dVd5AMEfHkFj2aZAu8aXpMSz6OgIzkzoy/Tfjxxa2OrXHN/BhImjYrjX
         4dUinULpuFdxlfVpGzHNdgnAbObVL4xC3dbtIgd5kl2dL2nmFtfOyMfjyVEg9lnvYtEo
         aDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I79DrcLvwdlMAtbLG57y1xHOmg0j3Qt2YUhPNzf3+rY=;
        b=FpbX73cfsxauS5eU1x+Vq7B5Y/wkOOSPRbRFDnlh+F8kymToclvb9cIdNz6zyCVRo4
         JjB77KQSGgxL2+FK/ln3i0sUAK8PPB9Kj+UBDG7JRluzmrvMOXqDbZCuMgwYOHbhtqts
         fozFpKhlfObEdI3IVyiYlbU0BE97hq507Jzv1sV8BxMCJ8YTMCL+ITrUXm0IqkHj8gGj
         Fc8kLo8xuv6WzrrA5uUl/vM9n4in0C2wYpLM1VWRSvgwT6k72DT/GNOaLSsTlyoUPfYD
         /6BdrwaSwAFuStj9GjVDSH9Rtl5Fh9HFoJHIn0eoSj4bco4TGKkSbYkXjha2WNpUyBrI
         Px9A==
X-Gm-Message-State: AJIora/TSZLB/OCyErgNkIVNvOwEtocuXg/4CGsM60GnC8frZdwkz7qi
        zpp4dsE40bn1wFQ6WVk/VEDWaQd7xgMRog==
X-Google-Smtp-Source: AGRyM1syzNVP0mNzERDD/e/Ox2vt4QOf9lEUELvsUVQxIFHhT2EaL5rrPpLeToLTcdyN7wZKUVTv2A==
X-Received: by 2002:adf:d1c6:0:b0:218:4fc3:a805 with SMTP id b6-20020adfd1c6000000b002184fc3a805mr3502306wrd.228.1655908103294;
        Wed, 22 Jun 2022 07:28:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/12] git-sh-setup.sh: remove "say" function, change last users
Date:   Wed, 22 Jun 2022 16:28:07 +0200
Message-Id: <patch-v3-12.12-ecdd8c6ed28-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
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

