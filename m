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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290C7C4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20E4206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1UFy1dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgKJAxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJAxf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:53:35 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541BC0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 16:53:35 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n15so10906861otl.8
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 16:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHtBQiElb8uwJLsStgjBXSH3jF/e3Y/zT6sg0rhdmPY=;
        b=V1UFy1dMgjE5JZZE8/WjXXStv9HKWbkPrXR/piHlGz+Za5PlqwVNy6sIi45hhNVvwD
         qChcVEGJROrVYkZQxqGnDdcb+oeU6OkZpcNo0hgkCW82GaGKEtgxzVMI6AUHRmj4xX5I
         0fH3QQLYsE1o5NpEMwJvdHWrefuCSnWV9uExKNeKzsytfULXjyp5nhQl6juoWlUYL6Ny
         HNL5lhkbX25O3QllMbEK02LqvLXJfsZiwlxbZjQrEfTAMh/CAkifwIFY286BRLPbqAmg
         on57ObsI4NwCmgOtjkSzvs2DI16x9xyi7LuXwj/Ffs/N589h1jN66LsYvibVetx5fEn5
         lP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHtBQiElb8uwJLsStgjBXSH3jF/e3Y/zT6sg0rhdmPY=;
        b=rv3d4iBXI9dzOpJpRhxVprftkuKCWYK2OiQ0r2lfmNNXQwocSKMZ7ui+jQbFRc6b1x
         LV9LSibr/GqUh5BKZsPUkByqpaUCRT6aziq+od4bM6DYUFM9RKgfGDYsPCfdGJGNkxXW
         2R/AeC/ooHlquI8b7R5aTqhZX9NTXzMEzTLBuJArvQYckCRMSxsKK+LIcLf61lrGgmoq
         XVHRRQaYxwj7mBpZKCdIuF1DyPpQLgQwqQZX2lxw2pVsNCOunrPh9GwOTX8LTYYJWsUk
         SmXu408ppZIwsCIYcHqZe3t/8UWoa7mS49RqCEa30BvMWacIVfvi4a4BlslinXItdQNN
         3gAQ==
X-Gm-Message-State: AOAM533hRgk2EqhG8xK6XLKNNzcSI95j6sB92pHpxIqyllIWPp+JxNnO
        XdElAltjQ0uGxUoUN6EJNDPprm+5i8uyFw==
X-Google-Smtp-Source: ABdhPJwI7rHBD4QorOQ3H6gf8JwTMl2ZQQGK1X3g2Cuseb8p9ej5Kj2m7AtvtYW/GwAwlQ9XbHBNLw==
X-Received: by 2002:a9d:781:: with SMTP id 1mr12512447oto.350.1604969614987;
        Mon, 09 Nov 2020 16:53:34 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id n62sm2912923ota.74.2020.11.09.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 16:53:34 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/3] completion: bash: support recursive aliases
Date:   Mon,  9 Nov 2020 18:53:29 -0600
Message-Id: <20201110005331.532678-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110005331.532678-1-felipe.contreras@gmail.com>
References: <20201110005331.532678-1-felipe.contreras@gmail.com>
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
 contrib/completion/git-completion.bash | 48 ++++++++++++++++----------
 t/t9902-completion.sh                  | 19 ++++++++++
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 36f5a91c7a..59ced25641 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1121,26 +1121,36 @@ __git_pretty_aliases ()
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
+	while [[ "$cur" != "$last" ]]; do
+		cmdline=$(__git config --get "alias.$cur")
+		last=$cur
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

