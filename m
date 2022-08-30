Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66728ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiH3JeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiH3Jcx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:53 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869CE0FC8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:32 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11ee4649dfcso8939948fac.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=c1wJDXoelCxDFmK2xhU6H5bL2Z4njTSgXtQ9jmesGwo=;
        b=WYs0viWY/6+jt6ZUAictWUxZs7Wo5iDxzWEiBXMtsc1AHjs7SIluj1VKpqh2NqST2A
         37zedxonsLJ+W72QqfsqPvUuMhSlJTqo9iyaCGIv49AeZwhIgwtMYOn57qqvF+47gk3B
         w1OCbXkX+XOJfYskCqTED8NDc+yFgIW4ygp4TA3V249A7U6A5WUKBcpKME4CLS3W1Emh
         SN5LhHEPpCCHCH+AMbK+HhxDNg5X/1KU/JbQGiBWYfQ/BAjoE4AF+k4B29su/P7lltSh
         KfutaN8Ar1gYsogEUGwIHGMznLWfLdplN8AfbArFYrlwh2jS2A7mAK0nv1KGP3b2loq7
         E7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=c1wJDXoelCxDFmK2xhU6H5bL2Z4njTSgXtQ9jmesGwo=;
        b=uylVc4uOqDUXC9fV4qKtaR8Fc2t4m1rM5CKibrVK8cnUDrSv4eu2kKxrXYiTuirqXD
         PWyi09iIyP91UOLpOM2ymU619W0WbemapEccspz3sogRl6jHGySg82FZeE0T4c7CVg/I
         xTq0zmWr0659cMomtVeoaRIYmJQWN+g4PS+W8CURQgDaijeLyuuiGgt9zNYyu8MAdOwA
         aaJbldn8x9JpWFqmBzcF+lWYzc0CL2LWEhdOpoqIKar3EYu5dN5fifGCHxfLRcJ1O9Rn
         5StV6w/1gaXMByH8krVlMGUjN1BfdCey3jySCMuvQZDRM8xWkl7AILZOlG2O1pYux59m
         Y6Mg==
X-Gm-Message-State: ACgBeo1/SqLq3b/d3gtfbbN3layle4orpdK39x6Ev7BPG+6RXhocgvcO
        yEndOdGgvKvi9pKi/yTPTFoM2DFTmTs=
X-Google-Smtp-Source: AA6agR4uIAB+T7sMXFZTJxKfJhnXple9hjh0AJ/S7rikNzpLRZiLyUrYwO4fgfxCiIjCgYTrGkueuw==
X-Received: by 2002:a05:6870:fb90:b0:11d:23bd:9266 with SMTP id kv16-20020a056870fb9000b0011d23bd9266mr9960633oab.177.1661851949780;
        Tue, 30 Aug 2022 02:32:29 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r8-20020a056830236800b0063922f00ee2sm7101366oth.39.2022.08.30.02.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 29/51] completion: refactor __gitcomp
Date:   Tue, 30 Aug 2022 04:31:16 -0500
Message-Id: <20220830093138.1581538-30-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have two chunks of code doing exactly the same, there's no need for
that.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 52 +++++++++-----------------
 contrib/completion/git-completion.zsh  | 52 ++++++++------------------
 2 files changed, 34 insertions(+), 70 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2a5e32e457..54b2c4e589 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -339,44 +339,28 @@ __gitcomp ()
 		return
 	fi
 
-	case "$cur_" in
-	--no-*)
-		local c i=0 IFS=$' \t\n'
-		for c in $1; do
-			if [[ $c == "--" ]]; then
+	local c i=0 IFS=$' \t\n'
+	for c in $1; do
+		if [[ $c == "--" ]]; then
+			if [[ "$cur_" == --no-* ]]; then
 				continue
 			fi
-			c="$c${4-}"
-			if [[ $c == "$cur_"* ]]; then
-				case $c in
-				*=|*.) ;;
-				*) c="$c " ;;
-				esac
-				COMPREPLY[i++]="${2-}$c"
-			fi
-		done
-		;;
-	*)
-		local c i=0 IFS=$' \t\n'
-		for c in $1; do
-			if [[ $c == "--" ]]; then
-				c="--no-...${4-}"
-				if [[ $c == "$cur_"* ]]; then
-					COMPREPLY[i++]="${2-}$c "
-				fi
-				break
-			fi
-			c="$c${4-}"
+
+			c="--no-...${4-}"
 			if [[ $c == "$cur_"* ]]; then
-				case $c in
-				*=|*.) ;;
-				*) c="$c " ;;
-				esac
-				COMPREPLY[i++]="${2-}$c"
+				COMPREPLY[i++]="${2-}$c "
 			fi
-		done
-		;;
-	esac
+			break
+		fi
+		c="$c${4-}"
+		if [[ $c == "$cur_"* ]]; then
+			case $c in
+			*=|*.) ;;
+			*) c="$c " ;;
+			esac
+			COMPREPLY[i++]="${2-}$c"
+		fi
+	done
 }
 
 # Clear the variables caching builtins' options when (re-)sourcing
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index a8ff9c089a..7616f87fa2 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -58,42 +58,22 @@ __gitcomp ()
 
 	[[ "$cur_" == *= ]] && return
 
-	case "$cur_" in
-	--no-*)
-		local c IFS=$' \t\n'
-		local -a array
-		for c in ${=1}; do
-			if [[ $c == "--" ]]; then
-				continue
-			fi
-			c="$c${4-}"
-			case $c in
-			*=|*.) ;;
-			*) c="$c " ;;
-			esac
-			array+=("$c")
-		done
-		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-		;;
-	*)
-		local c IFS=$' \t\n'
-		local -a array
-		for c in ${=1}; do
-			if [[ $c == "--" ]]; then
-				c="--no-...${4-}"
-				array+=("$c ")
-				break
-			fi
-			c="$c${4-}"
-			case $c in
-			*=|*.) ;;
-			*) c="$c " ;;
-			esac
-			array+=("$c")
-		done
-		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-		;;
-	esac
+	local c IFS=$' \t\n'
+	local -a array
+	for c in ${=1}; do
+		if [[ $c == "--" ]]; then
+			[[ "$cur_" == --no-* ]] && continue
+			array+=("--no-...${4-} ")
+			break
+		fi
+		c="$c${4-}"
+		case $c in
+		*=|*.) ;;
+		*) c="$c " ;;
+		esac
+		array+=("$c")
+	done
+	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_direct ()
-- 
2.37.2.351.g9bf691b78c.dirty

