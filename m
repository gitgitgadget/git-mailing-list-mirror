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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39DCC2D0C0
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BDA206EC
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 15:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW5mz0Mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfLSPJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:09:45 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:36097 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSPJo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 10:09:44 -0500
Received: by mail-ed1-f48.google.com with SMTP id j17so5199202edp.3
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ds+1FMLpsWgxiLO82c8N3i31zzTWGCJpAyzgzqrvajo=;
        b=lW5mz0Mn8PCWVsvRQ8F1uMzx+z9hZJ9GNk1FJlp5awIdYduNdfAAe9Hc0UmklAx849
         aoJfcwUqnoUAuT+AIIM+Jgh51f9niFyqN4aKIyyuyE1DSKEiDAdRmiUTLxNQdwEK0E22
         Jye4s+pHj5r6EPk8dyZUrSNxgimjXHcrA/UK1ugXg/YNGK04M8HiIrcB0YTeJVPxpi04
         lJk32Kof5pANLd2ihXYa9RqgkBJxGJhCEmVBiF0QLuTFN2K6QCTiEtmuB29oa2YcQXp0
         iZbTSsE86sI8YE8zU4Exm7GDx5POTFUg/8t+4h1U2h40GRP301FuQoOKVE6F+NOkyn33
         4Duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ds+1FMLpsWgxiLO82c8N3i31zzTWGCJpAyzgzqrvajo=;
        b=nKNvLy66hYnWJbge21R3A/6L9yRIzlXo7B5i0ReEjJGk23dfvxKD2ma53StBUPQF8/
         DwJZ8xT8TJYa4B5xAVqd6VFaIOZSo3G6ajC4snDBLD20aK5E6VVNDHfkKYDhBeesthO4
         /lkAf/dZS6BpwlZyL6nbhxPFJAi8L1n3zvWdqw0iQqm2XcRqvVSb7Ry8vrIf7kftR5Ff
         IKnx7/lffVbOrcytRBcucGGqOZLR+/1eF55jadQqk6CKhMLCpfDNSVLfXNLrgedRyz5r
         +c8za8/tqQF65Twu8grCcCVK+KSLMalH/ET2Drmy0h98VZHnZQ+801PBk/t7LR8CdH4q
         aM8w==
X-Gm-Message-State: APjAAAUKKdfnFe3waZE/9bbSbz2fYcI25qFMlL/aT8AvGYKV6ksERoUc
        ML+rcFSRVCWdvv4PtekEJ4E=
X-Google-Smtp-Source: APXvYqxeWklzBh45cmhf+HIYycFDHEUVT+buqmiS7UxBHziTmU7AJKuM123lducKLzP61rGiC6yDtA==
X-Received: by 2002:a05:6402:1547:: with SMTP id p7mr9717047edx.73.1576768182573;
        Thu, 19 Dec 2019 07:09:42 -0800 (PST)
Received: from localhost.localdomain (x4db583fb.dyn.telefonica.de. [77.181.131.251])
        by smtp.gmail.com with ESMTPSA id b27sm546584ejg.40.2019.12.19.07.09.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 07:09:41 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 6/6] completion: list paths and refs for 'git worktree add'
Date:   Thu, 19 Dec 2019 16:09:21 +0100
Message-Id: <20191219150921.5889-7-szeder.dev@gmail.com>
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
index 5eae0bfd18..0b163e2c59 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3006,6 +3006,42 @@ _git_worktree ()
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
2.24.1.982.ga4d4aba446

