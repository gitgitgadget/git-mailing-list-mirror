Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6970A1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDXWrE (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:47:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46460 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfDXWrD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 18:47:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id o7so7792856pll.13
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XIJbIHQzfHdxfZeP/nTLP6jFXfooj4YrKcl6/kwN2fs=;
        b=nhLj74srvsxZy4ifiDpUUvo7HVL/yl9amIw0+2rK6wqBC7XDo48lIKVBEfds1OR6l9
         HKzLCasoln8/YBk1gmcLcMftpA6+e694JG7qqAebJkBQpLVUG3ey+mXxI36JnYelotIU
         oKG/TK4Ij1oG61QOzNxSg4KE09TO+oD6ucA6qDyOVdREYhCpPIUn36bhWqlkL4qkFQKu
         eLx0y/AMdDL+Qt2HB0kH+a2aYOimsufnCb12tyAU3mnI9bWDAMFfKBPCRAg+PfXGo4uC
         dtksqXbJa2dPGjH5QurclU42+71k7hSltB5++loqg6lCSl5OjWVKddSoyYcns5uWMOHL
         kbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XIJbIHQzfHdxfZeP/nTLP6jFXfooj4YrKcl6/kwN2fs=;
        b=TqasAYqXq9Dn36pc+PRNpvRaWQXRD5WyfCsnRacqU2GIIEAKOK5YFH5I5QreapTf/t
         cIRSPdw7/f0jTGPYlEseB6Pd3JJ70Sz3zAeQW+iruePmSeca+JpYVlH1tGYTdhizijx8
         jCfDzKpQIeSSTPK+ZmhATfKDVWVml5NTYNRsCDhiv2+Ub1d1Pi4vKoHDQXcJikESvVm6
         RHgOPplU3trt8Vv92DZSsRSOFcI989Ig3CYdNSJUtXk5FFT/t5Tn0ZqwHjvNhkCjqJ/q
         HzAgrgxR89tYUzEwCWFMxH5OIByCtyXmqnw0ZNOCaJbp5oLCr70iPQBGF+NODS37e7jc
         O0+A==
X-Gm-Message-State: APjAAAW7nON+dqeHS4bVVlKu2WaNYmVcwsiH395sk5H/cZgkbEmALz5V
        1t/li9afw8ixoD4l7+nqYQzFMgvC
X-Google-Smtp-Source: APXvYqx+17mYspqg5cKrpeyk8MvJNpVmEkhIW/7GOvTAipiv9TeKK7+Cexysx3Niwium9gG5CXmpbw==
X-Received: by 2002:a17:902:5a8f:: with SMTP id r15mr1440324pli.196.1556146021786;
        Wed, 24 Apr 2019 15:47:01 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id x8sm22707432pgp.48.2019.04.24.15.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:47:01 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:47:00 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/6] mergetool: use get_merge_tool function
Message-ID: <ff83d25ff2d0b9585b52c7e28cd7b93292b5304d.1556142510.git.liu.denton@gmail.com>
References: <cover.1556009181.git.liu.denton@gmail.com>
 <cover.1556142510.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556142510.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-mergetool, the logic for getting which merge tool to use is
duplicated in git-mergetool--lib, except for the fact that it needs to
know whether the tool was guessed or not.

Rewrite `get_merge_tool` to return whether or not the tool was guessed
through the return code and make git-mergetool call this function
instead of duplicating the logic. Note that 1 was chosen to be the
return code of when a tool is guessed because it seems like a slightly
more abnormal condition than getting a tool that's explicitly specified
but this is completely arbitrary.

Also, let `$GIT_MERGETOOL_GUI` be set to determine whether or not the
guitool will be selected.

This change is not completely backwards compatible as there may be
external users of git-mergetool--lib. However, only one user,
git-diffall[1], was found from searching GitHub and Google. It seems
very unlikely that there exists an external caller that would take into
account the return code of `get_merge_tool` as it would always return 0
before this change so this change probably does not affect any external
users.

[1]: https://github.com/thenigan/git-diffall

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-mergetool--lib.txt |  4 +++-
 git-difftool--helper.sh              |  2 +-
 git-mergetool--lib.sh                |  5 ++++-
 git-mergetool.sh                     | 12 ++++--------
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 055550b2bc..4da9d24096 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -28,7 +28,9 @@ to define the operation mode for the functions listed below.
 FUNCTIONS
 ---------
 get_merge_tool::
-	returns a merge tool.
+	returns a merge tool. the return code is 1 if we returned a guessed
+	merge tool, else 0. '$GIT_MERGETOOL_GUI' may be set to 'true' to
+	search for the appropriate guitool.
 
 get_merge_tool_cmd::
 	returns the custom command for a merge tool.
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 7bfb6737df..46af3e60b7 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -71,7 +71,7 @@ then
 	then
 		merge_tool="$GIT_DIFF_TOOL"
 	else
-		merge_tool="$(get_merge_tool)" || exit
+		merge_tool="$(get_merge_tool)"
 	fi
 fi
 
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 83bf52494c..68ff26a0f7 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -403,14 +403,17 @@ get_merge_tool_path () {
 }
 
 get_merge_tool () {
+	not_guessed=true
 	# Check if a merge tool has been configured
-	merge_tool=$(get_configured_merge_tool)
+	merge_tool=$(get_configured_merge_tool $GIT_MERGETOOL_GUI)
 	# Try to guess an appropriate merge tool if no tool has been set.
 	if test -z "$merge_tool"
 	then
 		merge_tool=$(guess_merge_tool) || exit
+		not_guessed=false
 	fi
 	echo "$merge_tool"
+	test "$not_guessed" = true
 }
 
 mergetool_find_win32_cmd () {
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 01b9ad59b2..88fa6a914a 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -389,7 +389,7 @@ print_noop_and_exit () {
 
 main () {
 	prompt=$(git config --bool mergetool.prompt)
-	gui_tool=false
+	GIT_MERGETOOL_GUI=false
 	guessed_merge_tool=false
 	orderfile=
 
@@ -416,10 +416,10 @@ main () {
 			esac
 			;;
 		--no-gui)
-			gui_tool=false
+			GIT_MERGETOOL_GUI=false
 			;;
 		-g|--gui)
-			gui_tool=true
+			GIT_MERGETOOL_GUI=true
 			;;
 		-y|--no-prompt)
 			prompt=false
@@ -449,12 +449,8 @@ main () {
 
 	if test -z "$merge_tool"
 	then
-		# Check if a merge tool has been configured
-		merge_tool=$(get_configured_merge_tool $gui_tool)
-		# Try to guess an appropriate merge tool if no tool has been set.
-		if test -z "$merge_tool"
+		if ! merge_tool=$(get_merge_tool)
 		then
-			merge_tool=$(guess_merge_tool) || exit
 			guessed_merge_tool=true
 		fi
 	fi
-- 
2.21.0.1000.g7817e26e80

