Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F463C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 17:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiBGRps (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356035AbiBGRcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 12:32:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A562C0401DC
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 09:31:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h6so7430355wrb.9
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 09:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=omt8JnpozvPIujQIzL2htQ5+QzI2TZKOqNiLhOJ7DZ8=;
        b=We+8TjERv1HzXKEHit7ga7uLzL4IDyW8w3KUrK7SZ5No/1PpEkZewP8xw0BUwJM7N5
         ifQ38Y+DVRqq9FgDOYfFGN+3Lpcx6SfQPHAw8gfUwzj8sEVTUOmzNmqgkCu008hdWlEa
         RUJeu154/zETun3Tb67+KgoM3qJUf1eJsjS3EVVFalrtUtaip2JxgVkEVHVqR0Wix5yi
         mREk8g+xBvXZk834zw4XgVO21V3NntJTO8iCfPlYmcaYhxLecAevxqcPqroVlops1w/P
         gNsp9/JdHnzNDCMTncXIJ53uOsTfAPd8vBPAPCwbKAUuEOTmr5g/BplQUa3WnKh0HPY/
         gOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=omt8JnpozvPIujQIzL2htQ5+QzI2TZKOqNiLhOJ7DZ8=;
        b=1dqoJL1wotO36+BUc2qXGILay1js7ZgEDlVfBEOV1EAvbxv4Tzz6qPE5mKNG00aHns
         4CTGDux5VipIHuVEpnFPXO2Sy10QQ5JG0mr1QsgIqaw8YR65rQUimfk92ylLIJd8+e4k
         3eKSasNJjcEvZIRE4XFxG4OEZ3fvbIRfODWmFC/Rt/RxdOoTVpu6hkWIcctWvwoIfrZq
         hw56xjgTqxAMyig9xT6pTcjq49RQ+gafQPraP2zSANvHkZIqSyZInjeinMr7PFhzc8Vj
         ulQNYg7NI8109tfW6Z90DT/tKKuobPc8ouxR0OMomeaYfWvsiT+Zlykoum4sDEDrk+Ep
         yGTw==
X-Gm-Message-State: AOAM532goDa3CdEinmgicamiJ7on/ct0ADaPAaz1NpPMP+yYMobrw7wD
        QwrZKUoCzvicrV237w/BqAK7Xu3tGAU=
X-Google-Smtp-Source: ABdhPJwtyUl01FzxXB/88Te6arUExpfP0yCWs6ZmLF4SrOq4RhtQiUERJX/e1PvRRcR4D6fj8bWdAA==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr408271wrq.534.1644255109076;
        Mon, 07 Feb 2022 09:31:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm11535205wri.19.2022.02.07.09.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:31:48 -0800 (PST)
Message-Id: <2c20830b4ce0da0b559f645ba1bf211702cf97c6.1644255105.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
References: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
        <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 17:31:44 +0000
Subject: [PATCH v7 2/3] completion: improve sparse-checkout cone mode
 directory completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Use new __gitcomp_directories method to complete directory names in cone
mode sparse-checkouts. This method addresses the caveat of poor
performance in monorepos from the previous commit (by completing only one
level of directories).

The unusual character caveat from the previous commit will be fixed by the
final commit in this series.

Co-authored-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 32 +++++++++++++++++++++-
 t/t9902-completion.sh                  | 38 +++++++++++++++-----------
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7f6c86dc6c0..eeb80fdc6e4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2986,6 +2986,36 @@ _git_show_branch ()
 	__git_complete_revlist
 }
 
+__gitcomp_directories ()
+{
+	local _tmp_dir _tmp_completions
+
+	# Get the directory of the current token; this differs from dirname
+	# in that it keeps up to the final trailing slash.  If no slash found
+	# that's fine too.
+	[[ "$cur" =~ .*/ ]]
+	_tmp_dir=$BASH_REMATCH
+
+	# Find possible directory completions, adding trailing '/' characters
+	_tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
+		sed -e s%$%/%)"
+
+	if [[ -n "$_tmp_completions" ]]; then
+		# There were some directory completions, so find ones that
+		# start with "$cur", the current token, and put those in COMPREPLY
+		local i=0 c IFS=$' \t\n'
+		for c in $_tmp_completions; do
+		if [[ $c == "$cur"* ]]; then
+			COMPREPLY+=("$c")
+		fi
+		done
+	elif [[ "$cur" =~ /$ ]]; then
+		# No possible further completions any deeper, so assume we're at
+		# a leaf directory and just consider it complete
+		__gitcomp_direct_append "$cur "
+	fi
+}
+
 _git_sparse_checkout ()
 {
 	local subcommands="list init set disable add reapply"
@@ -3002,7 +3032,7 @@ _git_sparse_checkout ()
 	set,*|add,*)
 		if [ "$(__git config core.sparseCheckoutCone)" == "true" ] ||
 		[ -n "$(__git_find_on_cmdline --cone)" ]; then
-			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
+			__gitcomp_directories
 		fi
 	esac
 }
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f6eeb9aa035..b38a7302249 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1480,21 +1480,30 @@ test_expect_success 'cone mode sparse-checkout completes directory names' '
 	(
 		cd sparse-checkout &&
 		test_completion "git sparse-checkout set f" <<-\EOF
-		folder1 Z
-		folder1/0 Z
-		folder1/0/1 Z
-		folder2 Z
-		folder2/0 Z
-		folder3 Z
+		folder1/
+		folder2/
+		folder3/
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set folder1/" <<-\EOF
+		folder1/0/
+		EOF
+	) &&
+
+	(
+		cd sparse-checkout &&
+		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
+		folder1/0/1/
 		EOF
 	) &&
 
 	(
 		cd sparse-checkout/folder1 &&
-		test_completion "git sparse-checkout add " <<-\EOF
-		./ Z
-		0 Z
-		0/1 Z
+		test_completion "git sparse-checkout add 0" <<-\EOF
+		0/
 		EOF
 	)
 '
@@ -1520,12 +1529,9 @@ test_expect_success 'git sparse-checkout set --cone completes directory names' '
 	(
 		cd sparse-checkout &&
 		test_completion "git sparse-checkout set --cone f" <<-\EOF
-		folder1 Z
-		folder1/0 Z
-		folder1/0/1 Z
-		folder2 Z
-		folder2/0 Z
-		folder3 Z
+		folder1/
+		folder2/
+		folder3/
 		EOF
 	)
 '
-- 
gitgitgadget

