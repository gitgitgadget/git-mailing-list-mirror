Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AA2C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA60661363
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 09:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhDTJUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 05:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhDTJUh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 05:20:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B8C06138E
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s14so14664814pjl.5
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XEXzjTAV9dXOUikle5rOylao5pimN+EO1ck4FrWSz3c=;
        b=n33ZyWtLzRZ9P3EHBFBWuR4l17ZxTdiI3stfzsXJHmPnY8fxH5M+dvSD89ifcB+GUr
         cAnfBuuGsq5TC7C8KFN9T2QliOoOGNTh/2n1gG2e9rTthfhayWiakJ6apz5VWn0umyX9
         3R8tIccfzMJMV0KKBCgI3D0zVmM2/zm82bZlzgBKhotywf9/56CBVbELPouJD63Avapv
         RbiSwoI19R4fnpvEOpAwB3+7M9mTR3wFaK3+n3WQSr7eDIO1WL5SUhrfI7wjcN7J2sha
         m+YUhMCA6Omb6PpuiT5b4zMjinR3WlI3RikQBKZsUg4OjteG40O2JN++qCdhN2/5dMGv
         RhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XEXzjTAV9dXOUikle5rOylao5pimN+EO1ck4FrWSz3c=;
        b=kxbKGzwVBTZDcLA4kqK3U0ht9ytD3k5v/Z8g2i9Ueu0dLl/3Kqb5vMea7kuYwPhThu
         zk9W0rTExOHKl1JnlXoclQGDLfaBSRnEwJymPriERFp8WjWZpSpLGbqrfhbl7Vmvz+SU
         iHwPLYqqY/Rltol+o1Oa3lijGPeaL6VkT+Nl4zYIr2p+z4HjiTgmP5RRF5jF9nXwHmKW
         Iz0uM91k1ykXNdmDaGBSWZfsVCSFyloqQ2BYuSO+tkHWP2v9/kD8hc2yWNQsif99r7L8
         tzRRPD4fAFMJU1fZVcsiNx/uKqWhOueUIQpKRcL+umAaagod7UWv99NdMgl2r8QpaFc6
         DYhw==
X-Gm-Message-State: AOAM533caC+noIfS8eY0twbayJG68ZZqNUYcWK126H7o+iRL1IE6/Rdm
        8AA2wLjEOX3LYgAz55f+8P+wNfWfKFI=
X-Google-Smtp-Source: ABdhPJzuY8K5aSAN9gpP74D6gjWVNV9DPioExvmMGwljiPq0+M78ZyPJe3ZNbHcDwgTFbsPVZibnKw==
X-Received: by 2002:a17:90a:5885:: with SMTP id j5mr3941298pji.102.1618910404671;
        Tue, 20 Apr 2021 02:20:04 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id k15sm15247630pfi.0.2021.04.20.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 02:20:04 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] git-completion.bash: consolidate no-subcommand case for _git_stash()
Date:   Tue, 20 Apr 2021 02:19:51 -0700
Message-Id: <b4a9b0afa7ab28b701499982f5a8fc66eb7e19e8.1618910364.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.1.424.g95a8dafae5
In-Reply-To: <cover.1618910364.git.liu.denton@gmail.com>
References: <cover.1618910364.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a separate if case for when no subcommand is given. It is
simpler to just consolidate this logic into the case statement below.

It would be nice to complete remove the magic that deals with indices
and replace it with what was originally there,

	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
	        subcommand="push"
	fi

but this gives a slightly incorrect completion. In the case where we're
attempting to complete `git stash -a <TAB>` we will get the subcommands
back as a respose instead of the completions for `git stash push`, which
is what we'd expect. We could potentially hardcode all of the short
options but that would be too much work to maintain so we stick with the
index solution.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/completion/git-completion.bash | 30 +++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7bce9a0112..060adc0ed7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3016,22 +3016,22 @@ _git_stash ()
 	local subcommands='push list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
 
-	if [ -z "$subcommand" ]; then
-		case "$((cword - __git_cmd_idx)),$cur" in
-		*,--*)
-			__gitcomp_builtin stash_push
-			;;
-		1,sa*)
-			__gitcomp "save"
-			;;
-		1,*)
-			__gitcomp "$subcommands"
-			;;
-		esac
-		return
-	fi
-
 	case "$subcommand,$cur" in
+	,--*)
+		__gitcomp_builtin stash_save
+		;;
+	,sa*)
+		__git_init_builtin_opts stash_save
+		if ((cword - __git_cmd_idx == 1)); then
+			__gitcomp "save"
+		fi
+		;;
+	,*)
+		__git_init_builtin_opts stash_save
+		if ((cword - __git_cmd_idx == 1)); then
+			__gitcomp "$subcommands"
+		fi
+		;;
 	list,--*)
 		# NEEDSWORK: can we somehow unify this with the options in _git_log() and _git_show()
 		__gitcomp_builtin stash_list "$__git_log_common_options $__git_diff_common_options"
-- 
2.31.1.424.g95a8dafae5

