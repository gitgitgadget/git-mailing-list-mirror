Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6F4C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BC861158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhDZQTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhDZQTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:19:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C20C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso30116399otl.0
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AxXYflkxK6oOIVPavnjj/0TF6aV/yoobhFYoeo1WMvQ=;
        b=cX2Twyp76sSXbFe/pxxBxUG6TFHHvaC6shKOuI24i2NJoxRCmjpixm7+cwDLgcKKkH
         aQpTSZjblOpIQdh7JZZm6BJ98Z/+bGf3nYCjDdu+h/wrG3D3tFWQmoth1ys0qiPkWY6u
         xUxw70qIMB9dnwsgHoqv3hMUhvWjlK3Aa9fmF+CNJhJEEWFP9xak+SdGtAmOnXOaxORA
         oJxLqMoZkw7tqciu+T9mBGqcXLUMwQcpM4czMPbj7R+FXW42f99hgmfTbfivU1xmTmOP
         k8h4s3XJaLescZclV/xO3tsBZv3rUFw890dpujUA/X0najfHCULmf5s2MU9OM8tObmne
         HLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AxXYflkxK6oOIVPavnjj/0TF6aV/yoobhFYoeo1WMvQ=;
        b=RP18h6vitHYDkm2x1VZUo7rJMJXZw41LYiz/NiqQ6x3uCyne31nsiyjmWT7FL3pkWp
         vqF1ymsNlPzSovEkXaQGiNw2lLD1Lub7agUDnoxiu55wgCfoy5m5cf2ybVXOBXendrVA
         Uc0/K0QkxI434zfqMEZIqFXVzHZaZDmi4jnbgiem4NMlD3iORfrR/bwMzePcRFZKWqJ3
         Zt9epvLGhBTGZSa8v8mjPpDKLqamCIPA0rD9hbSBOK+LL3vljO3F4580wHthOGI408Uy
         gph6MHd6i+3XsDcYhVq1/JZmWd/e9P12FnWvCgF3u+083rXsyddexaMcWKJk6mr+emOh
         Wvhg==
X-Gm-Message-State: AOAM533yhBaodoLo22twjayZzRNLRtwZF3l8Nl2+K0ZIZGRSAmvCC2tk
        d5/mB28HuzxpR+REs3Lq0yfLTNi3liWjOw==
X-Google-Smtp-Source: ABdhPJy+tatkZZMM7yc5gHaGo7trkEg7nsRNIjRw2sYB+TUgjDolB+6rVAhnGlDNF068uekMkik9HQ==
X-Received: by 2002:a05:6830:1450:: with SMTP id w16mr7941251otp.305.1619453907053;
        Mon, 26 Apr 2021 09:18:27 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x45sm3623250otr.35.2021.04.26.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:18:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 25/43] completion: improve __gitcomp suffix code
Date:   Mon, 26 Apr 2021 11:14:40 -0500
Message-Id: <20210426161458.49860-26-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index 82ef19097d..096aa7b6e9 100644
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
2.31.0

