Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C3C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357424AbiFVO3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358345AbiFVO20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E559F63
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z17so9354339wmi.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8tvUWhT7SDlLvc7lsHTRNuBDDU9s1cEpyjyLgt9lWg=;
        b=BWrClh2MKBwkvfWIEfpYWYtASufeCDQGiZmailBdwlJhHzyqIfw+Ek8wYv6aJpI2pQ
         mafoLf9mSNQBc1Sc4CL/c7lSv+hnsKxTXSTlzDDVtiOpffZJzxNnK+4JEyvqiAyLU+uJ
         sJCAFehQIv0iBswdiDpuaKhqvc3NG29j9pyNxOXX+itMJ+sErCYrliID3bGHTX9xVEzj
         dBoCILncQN3nJ18S0GmunDqBdu53/BgvNH1UafqE/D5rl5mDWaE+74x/NGkeN848xXzJ
         QOnaNaeJr8OL5usFRu9nv3d9WEE459y2ypB+QBcESyMVACM2wpML4vjmt/Xc6cKpKrMb
         RnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8tvUWhT7SDlLvc7lsHTRNuBDDU9s1cEpyjyLgt9lWg=;
        b=ER0r2QKhW/JKArp5N0+uxv8dbDxY6p7iais/OzME7UTofsBv90OFhvypJaXk4QkP8q
         lHI1ucHq5ehWty1GumIvPZYn9ulk/1ZcxftlG/bgDV00yz3OVfOIcSaSxS6cwrpnfVv0
         pRvqD0CA8ZJsp+geTkiIDkBvTTlw9XZ2bJ2jW5c40r2k6w5nIwX7rxD3evwRNHq5QUtB
         AU+TJzPyxkoETz5bStKUAp9Vq25XIHebJ4vJMe9JkoKxQLIIgR5sE5jwdZ35OfixXam+
         8IQewhaOcCtKRSabJvV/T8HHJR2ha3kmdTi3iJZb4YM91YHjB9nT+/5v2fTgKNXidyUF
         vpWQ==
X-Gm-Message-State: AJIora9xSqzsr8c581mBunbDTRjGG9/jZVVwDjIyMwHORK8B8IxdM2VQ
        167fOaW9WD7LyTI8SaGLJ1aUAa1a2KAKGw==
X-Google-Smtp-Source: AGRyM1tSY6U2kI13sbu2H9CxLvsWD5KQ4msOSGCqO7kFrVC2BBQja8KHPhkZ2UsXkDRuFPLLLnfuZQ==
X-Received: by 2002:a05:600c:3b04:b0:39c:951e:6813 with SMTP id m4-20020a05600c3b0400b0039c951e6813mr4202293wms.193.1655908102280;
        Wed, 22 Jun 2022 07:28:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/12] git-submodule.sh: use "$quiet", not "$GIT_QUIET"
Date:   Wed, 22 Jun 2022 16:28:06 +0200
Message-Id: <patch-v3-11.12-f8219cd461d-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
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
2.36.1.1239.gfba91521d90

