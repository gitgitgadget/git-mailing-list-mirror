Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD3CC4708F
	for <git@archiver.kernel.org>; Sun, 30 May 2021 02:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F98261104
	for <git@archiver.kernel.org>; Sun, 30 May 2021 02:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhE3CRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 22:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhE3CRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 22:17:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F6C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 19:15:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g18so6300047pfr.2
        for <git@vger.kernel.org>; Sat, 29 May 2021 19:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13MlnAc4R1AVvz++f8kl9UOSaVXVjP5PV9Ktmh5CKMQ=;
        b=QClIF0/r+q379WC/X/zrFpkzztPd/Qhu0aTXphumfI+BJ+aoBM2Wl/e3Gs8lVn7XZN
         DrsbTF0mdMQ8NlzpPtP+Uzs27Tl9nwkFN0ORD2bQjRM9ojA9so3bZPwaL75TSoOOooMv
         1aY6GHzvxE4tta79AQ4EX9S3IpOtLeAGrb8ZR56FNkbG3fH0ZR1n7MISDGIBq82Mg5Wq
         Wi90tlpG9c0dOYV+fCRuMTcFDIeUNcOPp6Gz0nA4SwYrOAuknVLYFrVv3nlPzG/7BTpk
         WZfaQQonr583FiwxCFTWk3wGRuBwpv7JtMciyLhM7idnTXmLK8drT4u0jP2fY2YZBQ5E
         Nm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=13MlnAc4R1AVvz++f8kl9UOSaVXVjP5PV9Ktmh5CKMQ=;
        b=oMH+t6ElhB2mbTPTToofizUfqJzyEsfsVqewJF4FTMcm9wFsP5qJTI/kmj1iu/S0fZ
         vQRSiZR+zlwyN89PCrP3afKv9gmjIXCegThaNfvyVW+cIt0OQN078z1uFIfxXMpLU/e4
         gB75gN/od/jAhHfGBqYUPRORQvggI92HDud5C7nZ7YdTPHC6D/xui/7mS46oIGeu4Dwf
         46KwrrA2GPO1cus7Ce8NCV+gUylRJGWYQLHmdK79ZIUFvflYH59e2CThl/T0Q2Q/MGy4
         P2VLskdbhQIfU4nJsLwmuZHITflu2OOmADZDGAOrJ9GNxiv1kcjLa+oH4ZSkl6g7/BZl
         N9MQ==
X-Gm-Message-State: AOAM532gI0ztzoqX8CX267RujGbYQEPiQCcPQA8r/UFJmQ7mHZ4pEvVv
        WygzqFAFfBgBj3TRyrxUwBU=
X-Google-Smtp-Source: ABdhPJxB5VVkCk2wl4Bk3ZKRofkI8iWsjHh5s7O3XEvya/0+UoaGfyYw5wNFj1NjM3LBEA7pLAELIw==
X-Received: by 2002:a05:6a00:d41:b029:2da:b8ea:df35 with SMTP id n1-20020a056a000d41b02902dab8eadf35mr10889390pfv.3.1622340930827;
        Sat, 29 May 2021 19:15:30 -0700 (PDT)
Received: from sarawiggum.attlocal.net (99-121-213-74.lightspeed.irvnca.sbcglobal.net. [99.121.213.74])
        by smtp.gmail.com with ESMTPSA id w74sm7479603pfd.209.2021.05.29.19.15.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 May 2021 19:15:30 -0700 (PDT)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] contrib/completion: avoid empty arithemetic expressions
Date:   Sat, 29 May 2021 19:15:28 -0700
Message-Id: <20210530021528.21287-1-davvid@gmail.com>
X-Mailer: git-send-email 2.32.0.rc2.1.g6e92745b1d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$__git_cmd_idx can be empty in some situations, which leads to
errors when using "git add <tab>", "git mv <tab>",
"git tag <tab>" and "git branch <tab>".

"git mv <tab>" prints this error:

	__git_count_arguments:5:
	bad math expression: operand expected at `""'

	_git_mv:[:9: unknown condition: -gt

"git branch <tab>" prints this error:

	_git_branch:[:4: unknown condition: -lt

"git tag <tab>" prints this error:

	_git_tag:[:3: unknown condition: -lt

"git add <tab>" prints this error:

	__git_find_on_cmdline:[:13: unknown condition: -lt

Fix _git_branch, __git_find_on_cmdline and _git_tag by
initializing the local "c" variable to 1 when empty.

Fix __git_count_arguments by initializing "__git_cmd_idx" to 1.

Adjust the for loop in __git_count_arguments to avoid quoting
the numeric argument to avoid the following error:

	__git_count_arguments:8:
	bad math expression: operand expected at `"1"'

This was tested on zsh 5.7.1 (x86_64-apple-darwin19.0).

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3c5739b905..d51ff5302d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1177,6 +1177,9 @@ __git_aliased_command ()
 __git_find_on_cmdline ()
 {
 	local word c="$__git_cmd_idx" show_idx
+	if [ -z "$c" ]; then
+		c=1
+	fi
 
 	while test $# -gt 1; do
 		case "$1" in
@@ -1304,9 +1307,12 @@ __git_has_doubledash ()
 __git_count_arguments ()
 {
 	local word i c=0
+	if [ -z "$__git_cmd_idx" ]; then
+		__git_cmd_idx=1
+	fi
 
 	# Skip "git" (first argument)
-	for ((i="$__git_cmd_idx"; i < ${#words[@]}; i++)); do
+	for ((i=$__git_cmd_idx; i < ${#words[@]}; i++)); do
 		word="${words[i]}"
 
 		case "$word" in
@@ -1448,6 +1454,9 @@ __git_ref_fieldlist="refname objecttype objectsize objectname upstream push HEAD
 _git_branch ()
 {
 	local i c="$__git_cmd_idx" only_local_ref="n" has_r="n"
+	if [ -z "$c" ]; then
+		c=1
+	fi
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
@@ -3213,6 +3222,10 @@ _git_svn ()
 _git_tag ()
 {
 	local i c="$__git_cmd_idx" f=0
+	if [ -z "$c" ]; then
+		c=1
+	fi
+
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
-- 
2.32.0.rc2.1.g6e92745b1d

