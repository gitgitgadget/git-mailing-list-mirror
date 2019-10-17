Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB501F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501889AbfJQRfT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:35:19 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:40373 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440519AbfJQRfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:35:18 -0400
Received: by mail-wr1-f42.google.com with SMTP id o28so3304979wro.7
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNKQAD6lVONHqTdNeIZ358rgpJfZiqf26WcGV85uSsg=;
        b=kN2Oo3D3k1QDv1NUU7wYzakzNnYxnbMrv81UtbIGmS2LKN+4ZTydAUipXbuQQg/5vk
         Gnrsoa8hm+wlfI9Nfv19sRqz3kn6PD7C9SfoLjI2hYHoJKOW3ng1okwYEf2RxAa6EMsI
         btyU73m6p+4/B2HkRN72XVh9miluAz6dUpJB2uFde/+i5Jz2K1Rn0yFq+IkUdj8l8hED
         XwqCYiVo2IIGpXSZgQqftpZQLh0J+wqlWBhBD/e4sXtmVrU9UZVuSCoS+j/Rj2a+1bg5
         b919ZmGik/cN0TkpWzesfP5H4EIzJgC/Cd/9IWuexdIQbdDQteA6NgHLSRd66hutOZ3Z
         HnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNKQAD6lVONHqTdNeIZ358rgpJfZiqf26WcGV85uSsg=;
        b=aZJo7/j7mbBmuAB9GdukyoIkSAXOR2hA2bgeU8K/jMcww97DUxqjz4KvSWeHsjXu6U
         dJrdhmmXCuGwTqg1hVBAEe2IgN7Qqe39RRMyNg3o8Xu17g4apzKlfDnq6hFeIVwd3DLO
         2kW10akdHUA4IAL54vgDrwszMdFsYpmuMSRRzOCni2kwbYzYM0n53Jx1K4Du4iYmfo0f
         UMhCgN90/kb8OrgtK1kapdFgGANLMeJEfvAqZspru9Ke+yyvvPZTTkUR2sQSZlqPe740
         Z2UaBBGsJ191zX937/GAmS7EdsUS0/yA08zV06EB4i/8023UKdwrO2ctTt2cLVlEjyry
         S/Tg==
X-Gm-Message-State: APjAAAWn5gcEg5+XcDcD+b95ILbuLdJU+A1Dm3nkbjYbBHY9KwBQT1IT
        ABTGDuZPsGJ4qeDpGOsrI33IOvdA
X-Google-Smtp-Source: APXvYqyK8wXmBbLaTFwAiG76SfGOU6EJC7u425e0ypZeS9Xehyv2ImYIArq6ybmtDeWbVkbX+u1o2g==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr3954528wrr.313.1571333715757;
        Thu, 17 Oct 2019 10:35:15 -0700 (PDT)
Received: from localhost.localdomain (x4db41bda.dyn.telefonica.de. [77.180.27.218])
        by smtp.gmail.com with ESMTPSA id f20sm2599876wmb.6.2019.10.17.10.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 10:35:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/6] completion: list existing working trees for 'git worktree' subcommands
Date:   Thu, 17 Oct 2019 19:35:00 +0200
Message-Id: <20191017173501.3198-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.1084.gae250eaa40
In-Reply-To: <20191017173501.3198-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Complete the paths of existing working trees for 'git worktree's
'move', 'remove', 'lock', and 'unlock' subcommands.

Note that 'git worktree list --porcelain' shows absolute paths, so for
simplicity's sake we'll complete full absolute paths as well (as
opposed to turning them into relative paths by finding common leading
directories between $PWD and the working tree's path and removing
them, risking trouble with symbolic links or Windows drive letters; or
completing them one path component at a time).

Never list the path of the main working tree, as it cannot be moved,
removed, locked, or unlocked.

Arguably 'git worktree unlock <TAB>' should only complete locked
working trees, but 'git worktree list --porcelain' doesn't indicate
which working trees are locked.  So for now it will complete the paths
of all existing working trees, including non-locked ones as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 28 +++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 643272eb2f..4eb13b06d6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2981,10 +2981,21 @@ _git_whatchanged ()
 	_git_log
 }
 
+__git_complete_worktree_paths ()
+{
+	local IFS=$'\n'
+	__gitcomp_nl "$(git worktree list --porcelain |
+		sed -n -e '2,$ s/^worktree //p')"
+}
+
 _git_worktree ()
 {
 	local subcommands="add list lock move prune remove unlock"
-	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	local subcommand subcommand_idx
+
+	subcommand="$(__git_find_on_cmdline --show-idx "$subcommands")"
+	subcommand_idx="${subcommand% *}"
+	subcommand="${subcommand#* }"
 
 	case "$subcommand,$cur" in
 	,*)
@@ -2993,6 +3004,21 @@ _git_worktree ()
 	*,--*)
 		__gitcomp_builtin worktree_$subcommand
 		;;
+	lock,*|remove,*|unlock,*)
+		__git_complete_worktree_paths
+		;;
+	move,*)
+		if [ $cword -eq $((subcommand_idx+1)) ]; then
+			# The first parameter must be an existing working
+			# tree to be moved.
+			__git_complete_worktree_paths
+		else
+			# The second parameter is the destination: it could
+			# be any path, so don't list anything, but let Bash
+			# fall back to filename completion.
+			:
+		fi
+		;;
 	esac
 }
 
-- 
2.23.0.1084.gae250eaa40

