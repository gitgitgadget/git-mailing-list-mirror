Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA4AC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 03:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356806AbiBDD0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 22:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiBDD0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 22:26:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0CAC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 19:26:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso3006830wms.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 19:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=07qEgVwnKNrFRxr6VZXLOR75NgdjtGL3g2GYFe13tA0=;
        b=D2VisI0v9Ns8S9a+HIGggJINdzX1j6+kvM35d4d5Q7SqdrDHFC4XiHQdzIbbILugn9
         PwWvAOskc+Wx2eqrAU7YKreDqE35B5gkJpp6FvAHU9uYWqu+e56FqkT8mPsfwzYSoeXe
         K0pFP/yKbiPrzRzKoeiHCFMC6WmPHHjiXN3Y+brXGSGn7rpSnqBeT77bearYtLxfhjb+
         byPwE4RfX3xPVwPdKIZY6Vd8bfThCdoGAqoeQFjYaJcVDJAVldrv5ZbUxzSPxY1uLng4
         AyCx4E+qptxgFZMErR8CWO4BUIRzOupt8enn2GaTVaZfaluG2Nk5VUajXdeex/lWIv23
         vLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=07qEgVwnKNrFRxr6VZXLOR75NgdjtGL3g2GYFe13tA0=;
        b=uNatBa83kcpXLT/dv/+oseQm5xAXYJdTDEtj1DVjTXfKHH6bFoTjvuRqmj0qSC11eh
         Fcqn7SPiJT7vpj8ZlX3ZMeecDHcDgXeGKTn989Y7F50kVrnTNWdj4eXMq6EMJtk4Ny8K
         G+um/PQIa8ByX9aDq51uCUbr9/WZf1GoNS1iMMJTP9kE+M7FpOSC4PE5VSzieIw3QoAF
         mf9olsbAZuj09K+ULtJULTS+gDmYXfbIZminL9KvPb3l7c0jL2kceEtJjueqf33UUS7O
         42MMLrOLoinQZBhqI1Kqm1gnpJ2uc5ZapMxOD2aepJh9xt4qp2L3Xbgav0P/syu7SPR9
         1YFw==
X-Gm-Message-State: AOAM533vizOLFWR29YpnoAFcqcSklX4xddVMR0tl0akFGadN3g0r8702
        oXsRNYmZffNE+/EYcrRLrs00hQer1Mw=
X-Google-Smtp-Source: ABdhPJxQS713fWJsKIAnYud72orEJftThw/ohNQpb8A1k4By6p3wwlCdI6Q4o8PRCY2p8ylMFrTQtg==
X-Received: by 2002:a05:600c:4282:: with SMTP id v2mr551217wmc.78.1643945200779;
        Thu, 03 Feb 2022 19:26:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5sm574705wrb.113.2022.02.03.19.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 19:26:40 -0800 (PST)
Message-Id: <10a190ce6a19978c69a831736ca2e2bf7f0cb493.1643945198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
References: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
        <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Feb 2022 03:26:37 +0000
Subject: [PATCH v6 2/3] completion: improve sparse-checkout cone mode
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

