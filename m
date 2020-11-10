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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B01C4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E051206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 02:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rao1mCHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgKJCDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 21:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgKJCDs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 21:03:48 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E0C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 18:03:48 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id w145so12554333oie.9
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 18:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hbyaxypz5/T+FswMAvSi67mEBbfBQWW09yqRkYIAl3U=;
        b=rao1mCHlVJqsO3l0z2SuRjcpeXFMZT0yeBwG7abFCEjaKDZnHHGuhnNtcAqFMy/QnE
         K/TWi7PQbqYdj0opljPxqvzGREvtg51YOwLW9QGf5yZ24eeHgosBujlzWdn3wxA2alIr
         Q6am4qEhbetzX2JaGpB2qlws4X5UVKeZfOLrbGuXQMSXZdLgGzR0YEXpkvWxn78JYFQt
         TRhsJJMQtJd0VjOJzfapy9FegrPkeG7lcQRr5b2Y2DQLLMwfjXAYaMi6k+SUfDmvvbCD
         a9+Z9nQbPzi263LGuvGPnG7cL35dkcVmL2ELhOTRVdARJmiAnp58FSb3w609wiOYOMVC
         cyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hbyaxypz5/T+FswMAvSi67mEBbfBQWW09yqRkYIAl3U=;
        b=FigIC7bAVnHiypV3HQ7s6U0PoYVAqa/cWOuN0Oy+Xsijous5Ox2oMjjx7/GsKFBm/H
         Z0q3GEtjVWSwZADbDvxl6rn+YqxfeulOaGAnUEsH7zpJgWui6+fQrZihvYZHHP2qSuHI
         9X34gnIDPr5rErIPDf3sU0CN/VclsiHIjyXtkfJ1BQUD1YxIx0zFJLCMZKTTjmRs1T1i
         MT68R3WH5u6wrGEdHemsNKavst48WvDWsGe5jMFLWZOrOil9fbs0ULkI38RfKQmhzEnD
         iQDijy8pIQCRnIZlCBxV9re+k5ADtILSJHj57s7Nu3HLX4VNsv40j1zqFfe7pflzneJV
         li+w==
X-Gm-Message-State: AOAM532EGXzuh/xh2DTduIrkMrEivyXY9nsgK63ZZ5MivlwsNmxVaxNJ
        sf5Dc/kbBhNdYjiTePzRRwY7oyfOLGESVw==
X-Google-Smtp-Source: ABdhPJx84Uvw9ialG1i8IsiieeFao8smLkbwxRc4lvmHPuTPP1xGGcT9VPB57ZXvNOs9xHZOs6KjaQ==
X-Received: by 2002:aca:f4cf:: with SMTP id s198mr1369930oih.53.1604973827831;
        Mon, 09 Nov 2020 18:03:47 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p126sm2766143oia.24.2020.11.09.18.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 18:03:47 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/2] completion: bash: support recursive aliases
Date:   Mon,  9 Nov 2020 20:03:42 -0600
Message-Id: <20201110020343.548848-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110020343.548848-1-felipe.contreras@gmail.com>
References: <20201110020343.548848-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to have recursive aliases like:

  l = log --oneline
  lg = l --graph

So the completion should detect such aliases as well.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 50 ++++++++++++++++----------
 t/t9902-completion.sh                  | 19 ++++++++++
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 36f5a91c7a..eb00d9ba22 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1121,26 +1121,38 @@ __git_pretty_aliases ()
 # __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
-	local word cmdline=$(__git config --get "alias.$1")
-	for word in $cmdline; do
-		case "$word" in
-		\!gitk|gitk)
-			echo "gitk"
-			return
-			;;
-		\!*)	: shell command alias ;;
-		-*)	: option ;;
-		*=*)	: setting env ;;
-		git)	: git itself ;;
-		\(\))   : skip parens of shell function definition ;;
-		{)	: skip start of shell helper function ;;
-		:)	: skip null command ;;
-		\'*)	: skip opening quote after sh -c ;;
-		*)
-			echo "$word"
-			return
-		esac
+	local cur=$1 last word cmdline
+
+	while [[ -n "$cur" ]]; do
+		cmdline=$(__git config --get "alias.$cur")
+		last=$cur
+		cur=
+
+		for word in $cmdline; do
+			case "$word" in
+			\!gitk|gitk)
+				cur="gitk"
+				break
+				;;
+			\!*)	: shell command alias ;;
+			-*)	: option ;;
+			*=*)	: setting env ;;
+			git)	: git itself ;;
+			\(\))   : skip parens of shell function definition ;;
+			{)	: skip start of shell helper function ;;
+			:)	: skip null command ;;
+			\'*)	: skip opening quote after sh -c ;;
+			*)
+				cur="$word"
+				break
+			esac
+		done
 	done
+
+	cur=$last
+	if [[ "$cur" != "$1" ]]; then
+		echo "$cur"
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

