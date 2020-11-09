Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DB0C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A03206D8
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 21:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzzir7zP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgKIVwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIVwx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 16:52:53 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D0DC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 13:52:51 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id c80so11924336oib.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 13:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6or4u/aolmsaEa1CUlXkkwo1BMm73snu+alUvr6E2pk=;
        b=Qzzir7zPYF2yCbQG4Rn7coPTE7/+IxTkifNhWhN3IU3roUc8IRdVYQeAWyaH4FzWvR
         Tez3XFkJpBFCB8tV/7uD8aL4chPfgot5qJHkCjV4CFTAGo3lB6T152T8CVSHuK+Ck1yC
         /kx9dCady+akc0L1LqpDhMSJuZ6qqVBePi74791h4Ej+FIc2uNmu2WL85ln00oO2pPST
         04lAfOZ1l8eSpPUy8Nj1i1dQzzFqwMtlST5r4fR3Qv9GP66W/OSF65X8LAQMKIq5TIzS
         bIyNw4UrukEkJJk2pur62bgV/jwJxAXQeq1vpglWBUO3Z15UwvgpOTd4u+Is9TdEa0ZN
         2DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6or4u/aolmsaEa1CUlXkkwo1BMm73snu+alUvr6E2pk=;
        b=DB1CXz9wR5mjnmSBXEwSIh4C3NEx7LILQ6Ls3rcXiEg6Y9w5UwXnXtmtDBY5abcf8a
         JCB1mYZ3lVd3q4SkF7AFFWqgBabfyVu3sS0/umR2gZSfFDJwaGv30GtA08hQWnED3Knz
         0+wZCIKidVIpUKwfOlSVkeGQ42TFOegPPkb9KFKp53sWeieJ2O0Xoto7385qVjy6j7Dh
         j4Nzm13UeDP8cDWpd5dSPJyNHMyWmDTejp4peILMuPsSVN2zYqvG75CkMbDnmYA+YWu9
         5cjR54/Ezn79RqF6jJ62x7srEviRLcN6ytLcjwVSQFLWiXH1fYf40Rwr7J6HCsB1xxMz
         WQMg==
X-Gm-Message-State: AOAM530YTvr5mHtWpSu1Blms8TbzcluE+3JeDUG3NZHm9ku86FWdiPx4
        zEL7930gSFpXR/cCUVqIH9sTUDgU+a4YGg==
X-Google-Smtp-Source: ABdhPJy03DLp0824+1F1MDD8LhJHmi5s2GfvJnohJNwbdwCWD+1LRlto2kz4V8WiFdRUo3e9lv9C4Q==
X-Received: by 2002:aca:5558:: with SMTP id j85mr835479oib.175.1604958770746;
        Mon, 09 Nov 2020 13:52:50 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b123sm2611323oii.47.2020.11.09.13.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:52:50 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: bash: support recursive aliases
Date:   Mon,  9 Nov 2020 15:52:48 -0600
Message-Id: <20201109215248.461167-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to have a recursive aliases like:

  l = log --oneline
  lg = l --graph

So the completion should detect such aliases as well.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++++++++++-----
 t/t9902-completion.sh                  | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 36f5a91c7a..2053e4442d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1121,12 +1121,12 @@ __git_pretty_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local word cmdline=$(__git config --get "alias.$1")
+	local word cmdline=$(__git config --get "alias.$1") found
 	for word in $cmdline; do
 		case "$word" in
 		\!gitk|gitk)
-			echo "gitk"
-			return
+			found="gitk"
+			break
 			;;
 		\!*)	: shell command alias ;;
 		-*)	: option ;;
@@ -1137,10 +1137,15 @@ __git_aliased_command ()
 		:)	: skip null command ;;
 		\'*)	: skip opening quote after sh -c ;;
 		*)
-			echo "$word"
-			return
+			found="$word"
+			break
 		esac
 	done
+
+	if [[ -n "$found" ]]; then
+		local expansion=$(__git_aliased_command "$found")
+		echo "${expansion:-$found}"
+	fi
 }
 
 # Check whether one of the given words is present on the command line,
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4e943393cf..0e2db6e7fa 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2195,6 +2195,25 @@ test_expect_success 'complete files' '
 	test_completion "git add mom" "momified"
 '
 
+test_expect_success "simple alias" '
+	test_config alias.co checkout &&
+	test_completion "git co m" <<-\EOF
+	master Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+
+test_expect_success "recursive alias" '
+	test_config alias.co checkout &&
+	test_config alias.cod "co --detached" &&
+	test_completion "git cod m" <<-\EOF
+	master Z
+	mybranch Z
+	mytag Z
+	EOF
+'
+
 test_expect_success "completion uses <cmd> completion for alias: !sh -c 'git <cmd> ...'" '
 	test_config alias.co "!sh -c '"'"'git checkout ...'"'"'" &&
 	test_completion "git co m" <<-\EOF
-- 
2.29.2

