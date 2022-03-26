Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DC9C433F5
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 17:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiCZRQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 13:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiCZRQP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 13:16:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DEE3524D
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so13561685wrc.0
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fx7mvYY650ic7EUc/Vbj5qeuJT73d8MUrpi/ypj/+pk=;
        b=H9xweYcDUofvUhmTPeHU7e6mUu/s+JzDXPTwQpRy3i/JDwbAtfSRrlu7jqDuNL4yPi
         51y65dBhA37zbrKXvdM3K5svAldqKWTsvpXSpb2Bg4wIBDcMo5uXmmYY4lQyslpW5FKg
         rCQUctEFxRwMggiax8+0ek/B3S5CmJgMrx+S6Xy7J9gBSVBJr9G9okaRPWgq4fX7bOth
         tk/4Qv7H4CPTBQtDfg8KSFKNR7GUp/6WN6rEQIknW31968QdTv7rDW/+Wty7ViR6nZIH
         xwRneg6MpK4tfl9OPntzbMyBJxLq+gOlhtE7yju7VjDYoYnMKD8lZ8RDkkGDfUTWSQcy
         cCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fx7mvYY650ic7EUc/Vbj5qeuJT73d8MUrpi/ypj/+pk=;
        b=bLqkSkMeNJ5cVAt1NAFdWk07CHACNgfqXrnPtOwbpwVmsSrB+47kulF5HamLH6tOHS
         +mTB3jgwNSZa7dWU+byU008TATmRm2t5rvbwG/8u7p5fgFBplYILfvOcq1hKWPUkExLW
         psa/BgW/dOHckenXbw3zVKzA/o7d9tM6v8yjrCRbpam8hLtShx0ReYhB6KC0tpyFSFlB
         9UW8nGlEODVLahLQHZVkzBqiweLlU9DOoIwtVD3mtFsnHlQH7PidsWlaa6DjA3v/oFwf
         2yQuWWTehRH8NGIy2gCDHKtGj8YT8QUnt5UQ3XNfCcM21q3PgNr+2zzKGQSPJmusQFRx
         zmZA==
X-Gm-Message-State: AOAM5308+TLPalkO1ArkLzDBiS2ObumnEJqlZewflkhK7eYr5XU0BwHb
        0jIBnwNlrO3qFedh/DCY/MimutkfieeGFw==
X-Google-Smtp-Source: ABdhPJzfHgxPCydLNQcmj4pBHG86/p+mxCMkpMAfyOa8syvAxne33XSx9b24fmOFAe4YBBHE2UnoxA==
X-Received: by 2002:a5d:404c:0:b0:203:ea4e:3c07 with SMTP id w12-20020a5d404c000000b00203ea4e3c07mr14040994wrp.597.1648314876202;
        Sat, 26 Mar 2022 10:14:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0038cb924c3d7sm7805913wmq.45.2022.03.26.10.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 10:14:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/7] git-sh-setup: don't mark trees not used in-tree for i18n
Date:   Sat, 26 Mar 2022 18:14:19 +0100
Message-Id: <patch-v3-7.7-7a82b1fd005-20220326T171200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1535.gf8d72b9da1e
In-Reply-To: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Partially revert d323c6b6410 (i18n: git-sh-setup.sh: mark strings for
translation, 2016-06-17).

These strings are no longer used in-tree, and we shouldn't be wasting
translator time on them for the benefit of a hypothetical out-of-tree
user of git-sh-setup.sh.

Since d03ebd411c6 (rebase: remove the rebase.useBuiltin setting,
2019-03-18) we've had no in-tree user of require_work_tree_exists(),
and since the more recent c1e10b2dce2 (git-sh-setup: remove messaging
supporting --preserve-merges, 2021-10-21) the only in-tree user of
require_clean_work_tree() is git-filter-branch.sh. Let's only
translate the message it uses, and revert the others to the pre-image
of d323c6b6410.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-sh-setup.sh | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d92df37e992..1abceaac8d3 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -187,8 +187,7 @@ cd_to_toplevel () {
 require_work_tree_exists () {
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
-		program_name=$0
-		die "$(eval_gettext "fatal: \$program_name cannot be used without a working tree.")"
+		die "fatal: $0 cannot be used without a working tree."
 	fi
 }
 
@@ -206,13 +205,13 @@ require_clean_work_tree () {
 
 	if ! git diff-files --quiet --ignore-submodules
 	then
-		action=$1
-		case "$action" in
+		case "$1" in
 		"rewrite branches")
 			gettextln "Cannot rewrite branches: You have unstaged changes." >&2
 			;;
 		*)
-			eval_gettextln "Cannot \$action: You have unstaged changes." >&2
+			# Some out-of-tree user of require_clean_work_tree()
+			echo "Cannot $1: You have unstaged changes." >&2
 			;;
 		esac
 		err=1
@@ -222,8 +221,15 @@ require_clean_work_tree () {
 	then
 		if test $err = 0
 		then
-			action=$1
-			eval_gettextln "Cannot \$action: Your index contains uncommitted changes." >&2
+			case "$1" in
+			"rewrite branches")
+				gettextln "Cannot rewrite branches: You have unstaged changes." >&2
+				;;
+			*)
+				# Some out-of-tree user of require_clean_work_tree()
+				echo "Cannot $1: Your index contains uncommitted changes." >&2
+				;;
+			esac
 		else
 		    gettextln "Additionally, your index contains uncommitted changes." >&2
 		fi
-- 
2.35.1.1535.gf8d72b9da1e

