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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475BDC433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2391A207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbhAACRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbhAACRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:46 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F17EC0617B0
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:00 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 9so23450463oiq.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPbCrGKI7TIxwA0MuGI3dX7hQcaFg5zaZOeQgm7lc3g=;
        b=OW0stit6YZ3X7qOy93MQIhjoHxdIJoBkffTqxA817FVZ3Hv1gPJZ1F1t0UlIpD08YY
         WnxZvKg73ELqSC74CTcvVpjvT+BVUV36BxhRxDASZQFLvnBGrrEyA64rHO0akxKeh7DL
         zuk6ew5P6XFKPMg8RzyLF+VjW5UrCFL51WTkr+5tO49ibfbGq4ruRjBeQTWCE9beQM4t
         CBKtwnQOKJBqh3xVtg3Ei2CakCmn3BcUOKp8ZqubGwogxV9UnrPHzVj40MyQiqjNrPPO
         RZH32Wuqlt+AdCDfMW0XRHpWyfr1a5Nw33/YzQZ/t03Nm5XbIJahxCi7sYIkxlehJ4BW
         upLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPbCrGKI7TIxwA0MuGI3dX7hQcaFg5zaZOeQgm7lc3g=;
        b=NEu+GIAf8OdJEmQGpNPAM9/lip8jwOPuxEUtQPWdCdm4CsLTbOLaMw2bnGA8egVlS3
         UF7WTJrLCC4yjFzMbcwI9NpJiocTBjd3RdJTBoLYRQ2r7RuY8oUlWPD8As70P3tqP7l8
         eST96VBzP90rh6E5dvjnzlvvze1WpW6k6hrCh1pygVxVbjJiyrHyuya7fkyCGkURfW2e
         /g8LE5php8H0HX+HUBYUmbl0Vk4+Xu8xWLUF8Fy3USWF7HcgSdc1LyRC1ayYD5f9VSLx
         H9buD7Qk4tf4RgMjxMkTq+/qTgszwG2lnmfO103mMCEH+8eigIAr4szVDVXR/yudSxQ5
         gcnQ==
X-Gm-Message-State: AOAM530cAjKijebvCaDqSSH7N6x0eW4YuhEMyguAFt8x/pzdZiBPfvWY
        +2UjUmLopp9CGM06XtVCgVzNYJD9zCptow==
X-Google-Smtp-Source: ABdhPJzHgPf8hfoUmSC4unNtPme+qDjqsUujszxn7OGqqWt/2tE5XQIYQRt28hfeGC1M9J0/I4gx3g==
X-Received: by 2002:aca:4b16:: with SMTP id y22mr9540623oia.148.1609467419576;
        Thu, 31 Dec 2020 18:16:59 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j15sm11513591ota.39.2020.12.31.18.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:59 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 22/47] completion: refactor __gitcomp
Date:   Thu, 31 Dec 2020 20:15:57 -0600
Message-Id: <20210101021622.798041-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to chunks of code doing exactly the same. There's no need for
that.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 52 +++++++++-----------------
 contrib/completion/git-completion.zsh  | 52 ++++++++------------------
 2 files changed, 34 insertions(+), 70 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0522750b9f..b356e3c86f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -325,44 +325,28 @@ __gitcomp ()
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
index 8db7d0693d..fbd03a0180 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -57,42 +57,22 @@ __gitcomp ()
 
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
2.30.0

