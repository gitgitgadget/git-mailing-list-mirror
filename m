Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1CAC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5174E218AC
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSS/Gw6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLSPJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:09:44 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:35683 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfLSPJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 10:09:43 -0500
Received: by mail-ed1-f45.google.com with SMTP id f8so5204892edv.2
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 07:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDtZGmI4Qf9UqtN7O7P8VR69iBRvDrbUTxutBCjNSxc=;
        b=PSS/Gw6bYjREimcMOyaCaS9gZ8M+h1ggxLdzDnSyLvo1bQGRfeJrUkt2AHCyOtS+nO
         1XiTj+j4dlN8StS8ES+HvluuA4u/futStCj3fQFqHeZZshfP6gtQA7Gaan9hqJpmL3n3
         c82xqOzDT7HBKSKs3idvcIo+vPPS2Slv0utBulFLsqAsFb0wDFkXVN4ocmm+zu+Am8iN
         I0Z47NEz6Gu3yBady4CRbSRKKS8nkYokMFsU3kXSYnNdoiMbGonkzXrb/l355bCkKu5a
         DEgsAmseYGCVzkUegbaA5SAtejl6i6pgfMx8RgmxEyih6hNXbrxjckG4gcFGvprIHMmc
         /FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDtZGmI4Qf9UqtN7O7P8VR69iBRvDrbUTxutBCjNSxc=;
        b=FwtcbVK3jV7x9JgluN0owzujeQjyBdJ0zPBcwCa7HU8yxcP8vNt9y7wEZriHTRdjTo
         E67qLpJT/rIMbEFlADBFBxMFDVb7o1lBiy3pV6U/9GrNUdm43/sOQd61NMsIZ5UVwGx3
         zgflbtL+rX9hP82ugnUefgXwkraC+RO5OSdjz2vDutVJMF0Qq1FOARiC9ieALAC24dWg
         IrrDhKT6Mo6plOuhscE2qbb07vHNBsQmtvYSoRJX/KoulxoOlFkKYZA4nph70oreiOhw
         WpieBHcmg4gpa+87SvGQIONsbnw6mo2tYVL90Wyg5moUX20oVHxD9vu6Y6nQG1jDq7wy
         /weA==
X-Gm-Message-State: APjAAAWnMpElmeClcsFpcmkw3WSKB8mhW2VdfdANFb5TNmzsvotJhafi
        GTKl8uHStNmFlJAZj/wynIA7LsME
X-Google-Smtp-Source: APXvYqy8kV6pYEEMjReqW4EqPZ1KSsVq96qJK3PqXLzZpNLAbnfen5TTMP1h1RnObiCwBCCgcxLPQg==
X-Received: by 2002:a50:d5c9:: with SMTP id g9mr9609194edj.131.1576768181391;
        Thu, 19 Dec 2019 07:09:41 -0800 (PST)
Received: from localhost.localdomain (x4db583fb.dyn.telefonica.de. [77.181.131.251])
        by smtp.gmail.com with ESMTPSA id b27sm546584ejg.40.2019.12.19.07.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 07:09:40 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 5/6] completion: list existing working trees for 'git worktree' subcommands
Date:   Thu, 19 Dec 2019 16:09:20 +0100
Message-Id: <20191219150921.5889-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.1.982.ga4d4aba446
In-Reply-To: <20191219150921.5889-1-szeder.dev@gmail.com>
References: <20191017173501.3198-1-szeder.dev@gmail.com>
 <20191219150921.5889-1-szeder.dev@gmail.com>
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

Ideally we would only list unlocked working trees for the 'move',
'remove', and 'lock' subcommands, and only locked ones for 'unlock'.
Alas, 'git worktree list --porcelain' doesn't indicate which working
trees are locked, so for now we'll complete the paths of all existing
working trees.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 30 +++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 643272eb2f..5eae0bfd18 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2981,10 +2981,23 @@ _git_whatchanged ()
 	_git_log
 }
 
+__git_complete_worktree_paths ()
+{
+	local IFS=$'\n'
+	__gitcomp_nl "$(git worktree list --porcelain |
+		# Skip the first entry: it's the path of the main worktree,
+		# which can't be moved, removed, locked, etc.
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
@@ -2993,6 +3006,21 @@ _git_worktree ()
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
2.24.1.982.ga4d4aba446

