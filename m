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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1644B1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 17:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502198AbfJQRfT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 13:35:19 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43772 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436664AbfJQRfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 13:35:18 -0400
Received: by mail-wr1-f53.google.com with SMTP id j18so3301212wrq.10
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xxe3LUFwmb7+rSoRXj3v6F4s5SbQDOMZCFUiP2GnYd4=;
        b=QI39phfJUDjR+1xlKiLqEwuudICWZQrSKH2Gdj2MYJMJv6WBkgzkxIpPuDUL1ATkuU
         sE7EARbFkTUgsLEk5uvL/hX8JfXI85oQN8VrxDdtpkpN+3cziHBl4pMq7QjVCQmVvk5L
         fN7Kszkzy5/simO7JmcsAas18HTmKtxZAOA1x/TkA6IB05iSIxHytcsucbqEdWeBb0lk
         CQlMncBb111mvFAt7bV7/NE/QJu5V+dRanXZZ3U/phMpN8qgRKqndpcD0+t8+qLfNDbS
         tj/R3888+pOtKi0uJLNSZX4tPCNAqjSXUTXcffaMMz5jad7tf9dZQxbWpEHfSv4zSr6D
         2ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xxe3LUFwmb7+rSoRXj3v6F4s5SbQDOMZCFUiP2GnYd4=;
        b=gXHWZ+q8+MGtju04B2N21hjq3FB7SPIMNgfA5f4vDAzQqGgdi+xm54IfJqzU3FNqHX
         33LunJ4FcGTIdaBmFIHppwnVgEAQmFSeliKweYgF8uIdTvQQvZp2SE3COTHMTZObMHH/
         Ox90IkP4xvAO0QuFwEVwbjkfm1RUxxPxsAIIha4jP4v/yzQ/U8/ART8lFl0ZDgC/+wvC
         10XqOlA+M3JxlSz2IrWpYdK9fbsoDfBe192R7xLpuc3VaZKPBGN461uwQmYc0dt0+3Nu
         cxIusfuWhoGIF1/x0SfQP/WGvsCYdFadfoZKY/pcqZeqezEVL8LHhJnRApQXfN8t96QM
         UqwQ==
X-Gm-Message-State: APjAAAUyZDLt04MwmKVSsV2Xg0QeABFFG0QE81NFXWz53SVv0cv/KP3i
        zERmIUCN+4rrjKfpRQLkj0vHMg3/
X-Google-Smtp-Source: APXvYqzwCSrsAZSmo28oCR4rIrPUm3H/Q9lQbzgDqR11C+wppbd6AGdhYUnC5mril9C4l4pFAzJDFQ==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr4094460wrc.201.1571333716854;
        Thu, 17 Oct 2019 10:35:16 -0700 (PDT)
Received: from localhost.localdomain (x4db41bda.dyn.telefonica.de. [77.180.27.218])
        by smtp.gmail.com with ESMTPSA id f20sm2599876wmb.6.2019.10.17.10.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Oct 2019 10:35:16 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 6/6] completion: list paths and refs for 'git worktree add'
Date:   Thu, 17 Oct 2019 19:35:01 +0200
Message-Id: <20191017173501.3198-7-szeder.dev@gmail.com>
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

Complete paths after 'git worktree add <TAB>' and refs after 'git
worktree add -b <TAB>' and 'git worktree add some/dir <TAB>'.

Uncharacteristically for a Git command, 'git worktree add' takes a
mandatory path parameter before a commit-ish as its optional last
parameter.  In addition, it has both standalone --options and options
with a mandatory unstuck parameter ('-b <new-branch>').  Consequently,
trying to complete refs for that last optional commit-ish parameter
resulted in a more convoluted than usual completion function, but
hopefully all the included comments will make it not too hard to
digest.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4eb13b06d6..4e5cad4966 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3004,6 +3004,42 @@ _git_worktree ()
 	*,--*)
 		__gitcomp_builtin worktree_$subcommand
 		;;
+	add,*)	# usage: git worktree add [<options>] <path> [<commit-ish>]
+		# Here we are not completing an --option, it's either the
+		# path or a ref.
+		case "$prev" in
+		-b|-B)	# Complete refs for branch to be created/reseted.
+			__git_complete_refs
+			;;
+		-*)	# The previous word is an -o|--option without an
+			# unstuck argument: have to complete the path for
+			# the new worktree, so don't list anything, but let
+			# Bash fall back to filename completion.
+			;;
+		*)	# The previous word is not an --option, so it must
+			# be either the 'add' subcommand, the unstuck
+			# argument of an option (e.g. branch for -b|-B), or
+			# the path for the new worktree.
+			if [ $cword -eq $((subcommand_idx+1)) ]; then
+				# Right after the 'add' subcommand: have to
+				# complete the path, so fall back to Bash
+				# filename completion.
+				:
+			else
+				case "${words[cword-2]}" in
+				-b|-B)	# After '-b <branch>': have to
+					# complete the path, so fall back
+					# to Bash filename completion.
+					;;
+				*)	# After the path: have to complete
+					# the ref to be checked out.
+					__git_complete_refs
+					;;
+				esac
+			fi
+			;;
+		esac
+		;;
 	lock,*|remove,*|unlock,*)
 		__git_complete_worktree_paths
 		;;
-- 
2.23.0.1084.gae250eaa40

