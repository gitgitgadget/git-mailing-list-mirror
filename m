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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA4C433E9
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA60D207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbhAACR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbhAACRY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:24 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B69C0617BA
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:04 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d20so19317777otl.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MARhEVFanEP+cKNIyheJe3uUGCPBuNTq9SFyR+/EZ6o=;
        b=dKzg40GN21CXYOo9MSUjU6/mJMJG5omnNRHr3xmTvyCjsDUfS0VFeTG2KH8t8P1uzn
         gqe4kEVlilmffv7b0DisGohca/XoUS+i6r6ConX+SPG8/1d+KLXwaOIfEs8LAm//Xpr3
         uvOnT4yzz767Bkdi8U0Cl9DimYancM+912W9GJhri0yCEb+9sNNHLbKDrGnbdrRjhv0w
         GMV+y/5FfB5fxDkmP1rC77McPiRHIjncbe6PqWNWKdHOz0pyp87cHlQaIi6tyt99lNLe
         6Ym0I6oUtmt0fu4s9E/iN/5rmfNeOlOqTewOyrkHI0u/c14SZjcR91V8fwYvzpuDDu6H
         33pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MARhEVFanEP+cKNIyheJe3uUGCPBuNTq9SFyR+/EZ6o=;
        b=jiaFKyMPUrBISO7IWrkBRJBphPFBRQigMPe904zXSxIxwTLa9mRLqQ+iFhyK6CP8+z
         WZkQt1XZ9CoR3kQX3hyV7E8ydBsaDpi985+ywtvONxOgEISagQy0sWNr+hP6l6JY24Mf
         y2kbAY+eXixrTI1DTt5NE4lSz9WtnAW2k4yWn9Cz2UmN/CVDVMIh30zJU43OioK4aKpo
         S4Ewvw4iKyN+xUwPzOtQ573dPmpeiUaKiBCRwn9yXT3Q/pGjk60lAXeMIHJ41W4lCtP1
         ouOnQPlOFSFbom1WpZ53OcOK0FDMK38dGjKk7Tt2d7eCaB9dkmzF69CZHk0cXGXYZdff
         ZXBQ==
X-Gm-Message-State: AOAM532gcsx9z6P+gDtyRTAzDwKbRIVWykRE5iYie/fCrFChXCg/fWyd
        rt8cr0r8QjfjsJv11j1CgAEdS/z4aKMhlA==
X-Google-Smtp-Source: ABdhPJw5YqGKHjvyZhDKgn5yZcOTqVdhT6xsyjFGjwCZtt9uyqPyNR6/dfAKMO9cPkvDmsubI5KVig==
X-Received: by 2002:a9d:2a86:: with SMTP id e6mr43636572otb.313.1609467424099;
        Thu, 31 Dec 2020 18:17:04 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e1sm11446771oib.11.2020.12.31.18.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:03 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 25/47] completion: improve __gitcomp suffix code
Date:   Thu, 31 Dec 2020 20:16:00 -0600
Message-Id: <20210101021622.798041-26-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in adding a suffix after a suffix.

If a suffix is provided, we add it, if not, then the default heuristic
is used.

There's no functional change since most callers don't specify a suffix,
and the ones that do use an =, which by default doesn't add an
additional suffix.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 17 ++++++++++-------
 contrib/completion/git-completion.zsh  | 18 +++++++++++-------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1f0728ae52..4eea322366 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -325,7 +325,7 @@ __gitcomp ()
 		return
 	fi
 
-	local c i=0 IFS=$' \t\n'
+	local c i=0 IFS=$' \t\n' sfx
 	for c in $1; do
 		if [[ $c == "--" ]]; then
 			if [[ "$cur_" == --no-* ]]; then
@@ -338,12 +338,15 @@ __gitcomp ()
 			break
 		fi
 		if [[ $c == "$cur_"* ]]; then
-			c="$c${4-}"
-			case $c in
-			*=|*.) ;;
-			*) c="$c " ;;
-			esac
-			COMPREPLY[i++]="${2-}$c"
+			if [[ -z "${4+set}" ]]; then
+				case $c in
+				*=|*.) sfx="" ;;
+				*) sfx=" " ;;
+				esac
+			else
+				sfx="$4"
+			fi
+			COMPREPLY[i++]="${2-}$c$sfx"
 		fi
 	done
 }
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4eef9c5199..0ef15ff643 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -57,7 +57,7 @@ __gitcomp ()
 
 	[[ "$cur_" == *= ]] && return
 
-	local c IFS=$' \t\n'
+	local c IFS=$' \t\n' sfx
 	local -a array
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
@@ -65,12 +65,16 @@ __gitcomp ()
 			array+=("--no-... ")
 			break
 		fi
-		c="$c${4-}"
-		case $c in
-		*=|*.) ;;
-		*) c="$c " ;;
-		esac
-		array+=("$c")
+
+		if [[ -z "${4+set}" ]]; then
+			case $c in
+			*=|*.) sfx="" ;;
+			*) sfx=" " ;;
+			esac
+		else
+			sfx="$4"
+		fi
+		array+=("$c$sfx")
 	done
 	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 }
-- 
2.30.0

