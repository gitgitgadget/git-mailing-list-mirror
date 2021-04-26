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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8676C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB62761158
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhDZQTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhDZQS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:18:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB46C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:14 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so47506420otf.12
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GRwlvvsPZHYd1Dt472oV/8cSH1PkrSf+r/I7eRUzh5E=;
        b=qRt8S1BkcH6j0C7lW83VekX0LIyPUOjd5cx0Vd5sQ7RiUrmYVlTsLLh+/6DiCPZLkZ
         NYJT7BSuWcG79BPerwxx44jbIDDzSctweZPRqs42kHjfklRqRZAwFtxLUawdRI/HHJHU
         UxWlpZ00qE8051fwk4ZzaWwjmez59G2I38pIu8LxlC0rc3Fwm/u9R5xpKsepyFG07Zf+
         iAEYsJ8uVjCnfgYgsSvsgp1NnK6PJGpEhFH6KCUP/SXIXcpXPyO7/rTGqBxvimWmP6l5
         ZcgVCwjQyi3RP2PhsI3Zb3muOT/yoejJbzYDCiQWdbwNAr0h/qF09fSKf9HkIIuK38gP
         FoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GRwlvvsPZHYd1Dt472oV/8cSH1PkrSf+r/I7eRUzh5E=;
        b=askzLy/xZIrStp8xVS3PZmJlFkdnOwVDVo44YUIJ833iIMPpT5LU42Wmo0rBs35A3s
         mk1cn6Ed+moZ3Bzx4uSE+Y/TRjHpM9/Q+lRy7NvYoc+i/d+hMIisTP6FCQBtDJKzgNVs
         JNQ+4oXXAAre+EUOS8pKcI42f+6/Y2QLs0337PjDNhT+3NdHmouBMHHxxKwcjriCiUn6
         H04Mwug6CdAcFO4zC3T/C7wIhi10Fa+6NjOq5htnCaQarKzSS+YyyTmaplDcxAh+yzlo
         WTp9OX0E1yp+CcbIrg2+lB60IvKQ4qZhLbV+rRcED7LxLU2u+Udc+rnTQGetoBwf7hED
         dKdg==
X-Gm-Message-State: AOAM530kdV+w+z3hGlCnk1wzfzLtrLF+xjL3mY52WX3wd9ayMLjnZeOp
        dTS4SEShSn9zgiRYjhwXs5tSKQ/Gc/t8CQ==
X-Google-Smtp-Source: ABdhPJz/h+Lnq8E+SKqSJxJ9n5IL4sxF/6m9mJ6j+Uj8AIM4qN92LMY8CLrausPmjzRhSA40YnP//Q==
X-Received: by 2002:a05:6830:19dd:: with SMTP id p29mr14812668otp.368.1619453893743;
        Mon, 26 Apr 2021 09:18:13 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id b2sm3622714otq.80.2021.04.26.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:18:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 22/43] completion: refactor __gitcomp
Date:   Mon, 26 Apr 2021 11:14:37 -0500
Message-Id: <20210426161458.49860-23-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
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
index cd1e0ba704..6c8a8f6f5f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -334,44 +334,28 @@ __gitcomp ()
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
2.31.0

