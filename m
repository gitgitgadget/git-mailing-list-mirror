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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADA1C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610A8613ED
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhFRS2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhFRS2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:25 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBDFC0617A6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:14 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id q5-20020a9d4b050000b029044ecc922d44so328188otf.7
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4KCGaVavbYXhHWlt2+XttNVGAlx0V3Dfsx+2+lv5Z0=;
        b=C2fbKUrlADZovlHgMNgrGKooonjhpX8eMM+nqP+cXX8kH7JiO/Twj/auRbgPCb436C
         MuzZh58mHvoENVxVhaZL4puw/kJaXCdC/w+6tf5GoKxSOMIuKdho2P24hrxSJNvbUtWy
         qvHjqTe+2fY24viPydijDN1um5dRyDfcx6pAdDvM3a04vLOI2D7ZYsyJmm2gK8Ff/fZ3
         Hd4dfrMKfK7GTKBpPfdP3NIgraR3hUnMYHi4JLgCCB5oIDjoUNLrkBv4ECratkaemziR
         aSb9qRpRt43QnkkZkKnzL3awEcWdtYSjqjv9vP/vM8K+xcwEHvTyilNzK/c3vLTfb1jB
         q2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4KCGaVavbYXhHWlt2+XttNVGAlx0V3Dfsx+2+lv5Z0=;
        b=aIWfnB2gBTEypGCfG/rCY+vizlYURfJKluS/ZXTpeUfj2AaJp5AQvnjEn7P5YIQQVr
         jFbQAFwHeMXh30IdTxi9GloM+DOVx9kIb0zVEkFs8solSnt37xfIT9ZRPFTFRrAaHlEy
         6EtzekiCaylBMZ3DiYgnEWTXxQzhlkdZ8xq9I1pXkweYVt621RXIEbrlpGEq+VLHv2un
         Z/aCFVsEhKoDCYkDdf8axeD/V3JO6rBGLeqyO9HoYjExaWurD5kVdjegKCHUHCMgjorE
         AtcNeKNVaYVxCPLORzOr7iMFBfqBkK6nuUbJsgkvfZ0xCUt6A7ZNkNT46Jy1OrzDdURB
         W9PQ==
X-Gm-Message-State: AOAM531uGXxsYAa0jBprAin7E7GFO6Pl3POrcsLoiAJijfCPhiLw2h/d
        myfjTZ68u1AeT1AV0pb8bGRp9oRq4KsVHw==
X-Google-Smtp-Source: ABdhPJygiX8zLw/ctwl1o7OdWLULpi6f0HeHWTXlN5Demx8GvYwwKqQknWgV1Ncad68lLCt2dLbceg==
X-Received: by 2002:a9d:e8f:: with SMTP id 15mr10349542otj.334.1624040774056;
        Fri, 18 Jun 2021 11:26:14 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q1sm1909155oos.32.2021.06.18.11.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 28/45] completion: improve __gitcomp suffix code
Date:   Fri, 18 Jun 2021 13:25:01 -0500
Message-Id: <20210618182518.697912-29-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
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
index e7308b212f..c246d664c3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -334,7 +334,7 @@ __gitcomp ()
 		return
 	fi
 
-	local c i=0 IFS=$' \t\n'
+	local c i=0 IFS=$' \t\n' sfx
 	for c in $1; do
 		if [[ $c == "--" ]]; then
 			if [[ "$cur_" == --no-* ]]; then
@@ -347,12 +347,15 @@ __gitcomp ()
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
index 6008a73816..b81479c814 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -58,7 +58,7 @@ __gitcomp ()
 
 	[[ "$cur_" == *= ]] && return
 
-	local c IFS=$' \t\n'
+	local c IFS=$' \t\n' sfx
 	local -a array
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
@@ -66,12 +66,16 @@ __gitcomp ()
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
2.32.0

