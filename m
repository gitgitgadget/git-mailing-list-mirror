Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F6C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344757AbiF1KGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344752AbiF1KG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B83E2F00A
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so7454071wma.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgP7+fSKm9lVlQHw/B6sEH49pbaJKzMrWPmZobYbrJo=;
        b=C8UkH69dgoda81nlqvpxBgACoK7l880aNSgym758D/Prz2DLrzzocLbRjmVjE2tSFD
         z/uxovx55jwM0QUxczqi6AHQmTJ80ElORTvpagTJCpOnX3w4xjZGrAjQHTb8EWKZQMeu
         GptFaZC+6cYqjkajHsVTT8sCA4Rtbq7LHDoFt7EmbG2e9OFkK+Ckj9o25CUG0gSLhXhK
         NlWYs7v5gqpOl9JhCzJDrSQf3VggqYHW8Mo3VOEuifbZ800N0z4ntkuvT/DMfnHdywSz
         osH3c+2Mm5tJnU4ULhhbeQHe2E0xGnTJ3Y7nUAxwJB7SxiKBZgJUVvBm2JhF8eDtfm62
         S0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgP7+fSKm9lVlQHw/B6sEH49pbaJKzMrWPmZobYbrJo=;
        b=ReSAm1AC7yHlxQs0rYnLtgz3JwkOKmR5CrSKy5E0T12urlNzPQNPqeHwbG0UlOc0D8
         yTAxjzmg/zF71gKByzC3jEQVYMn3MIB40nqme4Cg18XYUvSqLU+gtrBH+wmO37UDwXUt
         SQjURlZywHZtGN+OQfbTdBtgg4VYkP5eLVu3oUVIV5F+L/9Qg1nuY+i+r+/sEkBO2+M7
         heR+gUJmKhWscRro/9um0/Itw6fHJUIC0dqL/x9MVa7UMB0oUzPRH76p1Yjyqn4+g6W9
         roglBP7Gk+vWnQamdD3rHpl5vNQZhi05NxGVK9D2QpwEsYpHEijSDzUuAyIcDce7Oki9
         9ACw==
X-Gm-Message-State: AJIora86ez/4UGY0en5zv5sdz5NS1h7mtws6WwXnSyVM20FL5Ibza9YW
        CL61OGXWkKxP5H1CgkSNy5rZMYhSbYx9oQ==
X-Google-Smtp-Source: AGRyM1sbVpjkGHJnektRwxfBVhy4Qf++l0kedt4yjXfWjbezc6PAPJNUB0nYQ6lt9pKdSqA7HT9gog==
X-Received: by 2002:a05:600c:2051:b0:3a0:3c58:6ff6 with SMTP id p17-20020a05600c205100b003a03c586ff6mr23734967wmg.98.1656410779694;
        Tue, 28 Jun 2022 03:06:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/12] git-submodule.sh: use "$quiet", not "$GIT_QUIET"
Date:   Tue, 28 Jun 2022 12:05:33 +0200
Message-Id: <patch-v4-11.12-c7eac40a0f2-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the use of the "$GIT_QUIET" variable in favor of our own
"$quiet", ever since b3c5f5cb048 (submodule: move core cmd_update()
logic to C, 2022-03-15) we have not used the "say" function in
git-sh-setup.sh, which is the only thing that's affected by using
"GIT_QUIET".

We still want to support --quiet for our own use though, but let's use
our own variable for that. Now it's obvious that we only care about
passing "--quiet" to "git submodule--helper", and not to change the
output of any "say" invocation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7fc7119fb21..5e5d21c010f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,6 +30,7 @@ GIT_PROTOCOL_FROM_USER=0
 export GIT_PROTOCOL_FROM_USER
 
 command=
+quiet=
 branch=
 force=
 reference=
@@ -80,7 +81,7 @@ cmd_add()
 			force=$1
 			;;
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--progress)
 			progress=1
@@ -128,7 +129,7 @@ cmd_add()
 		usage
 	fi
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${quiet:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
@@ -144,7 +145,7 @@ cmd_foreach()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--recursive)
 			recursive=1
@@ -159,7 +160,7 @@ cmd_foreach()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 #
@@ -174,7 +175,7 @@ cmd_init()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--)
 			shift
@@ -190,7 +191,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${quiet:+--quiet} -- "$@"
 }
 
 #
@@ -207,7 +208,7 @@ cmd_deinit()
 			force=$1
 			;;
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--all)
 			deinit_all=t
@@ -226,7 +227,7 @@ cmd_deinit()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${quiet:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
 #
@@ -241,7 +242,7 @@ cmd_update()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--progress)
 			progress=1
@@ -335,7 +336,7 @@ cmd_update()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
-		${GIT_QUIET:+--quiet} \
+		${quiet:+--quiet} \
 		${force:+--force} \
 		${progress:+"--progress"} \
 		${remote:+--remote} \
@@ -396,7 +397,7 @@ cmd_set_branch() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${quiet:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
 }
 
 #
@@ -409,7 +410,7 @@ cmd_set_url() {
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--)
 			shift
@@ -425,7 +426,7 @@ cmd_set_url() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${quiet:+--quiet} -- "$@"
 }
 
 #
@@ -496,7 +497,7 @@ cmd_status()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--cached)
 			cached=1
@@ -518,7 +519,7 @@ cmd_status()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${quiet:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
 }
 #
 # Sync remote urls for submodules
@@ -531,7 +532,7 @@ cmd_sync()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			shift
 			;;
 		--recursive)
@@ -551,7 +552,7 @@ cmd_sync()
 		esac
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 cmd_absorbgitdirs()
@@ -572,7 +573,7 @@ do
 		command=$1
 		;;
 	-q|--quiet)
-		GIT_QUIET=1
+		quiet=1
 		;;
 	--cached)
 		cached=1
-- 
2.37.0.880.gf07d56b18ba

