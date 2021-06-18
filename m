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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F29C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6AD613D1
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhFRS20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbhFRS2U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:20 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ADAC061767
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:09 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso10578346otj.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zg2t0XPVdQ3UugjMMaP236645ooApa0EF7cqzJTIyCw=;
        b=jLOkafwQ/MP6TAC8YQ92cUEHMqUgnACRmhW2xQy4kPt3+hSxPsND2AjTDxTZVdqGDU
         bM8V95ep/vNR3CnKReje7tkMiRLpTfOfkeKMTf97wbUfETSYJLWPQ6tZzZsfzgJKJ4au
         HKFU6liuF35AsuBHBkIfZ9hW1jf5UoYqYSENl5mo4TytV8owivrxM6hsmKcwXlUm0d/2
         cHPvi0NuYMXXYdWsrkVMUrVSTMONR5PWtj5r2d6UEmqWDtqJ6lxQ4p5pBR9KrfhBj+0G
         eQk3q/Whx8iTFSKOlUc3167wVRxD8kSfN7Ti0Z9bfF1mQXXruh/m29gaaRCXYp1bKJxu
         S0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zg2t0XPVdQ3UugjMMaP236645ooApa0EF7cqzJTIyCw=;
        b=Xu2F3LxjZY7VLysamhw4WB3Oy+5JstJYdkw35OVelKu/HPsLpWekkObjRP7VgXS8Pu
         nfMHrX3EdI3kZM3o1fmV5d0pVtws+SlceETaAcVh/JCieSXnnMMg9WrAy4hguqrtUHnA
         8jAP1NNOxG49hKOEw7jRANEAMQUVFpVRBdhmOaccmXl+FqZJA14zpstGFcBuaPq8tr+R
         PxZLGGhPJR4BT0WQKBjBrSXI4emAC1uVacgeto1uDAp5yExufcNF/vxeV9NyOR/5BBU7
         DHMeXU40EgvIpkR0cRHsx6+2rl27AUwzHDDK6I9ax2TaQKEZWSDUy4q5o3cfvBTB8C+5
         G/kw==
X-Gm-Message-State: AOAM533PXpBo9auIxgfACIEETY4Ek+aEQ/BQrcdkG2udmbz/ZoxWV2L+
        shVr7IUS7mIfqhy5UAOJUumi8fu8l4U33Q==
X-Google-Smtp-Source: ABdhPJxTNZC+Y4hnEDjRg7Zr3goZkEsUm7b4RjYdcgk5a0/qzWWjG1oX7ej8LMqVmxJiJp0XQpZkxQ==
X-Received: by 2002:a9d:6f93:: with SMTP id h19mr10315217otq.100.1624040768943;
        Fri, 18 Jun 2021 11:26:08 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v42sm2126382ott.70.2021.06.18.11.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:08 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 25/45] completion: refactor __gitcomp
Date:   Fri, 18 Jun 2021 13:24:58 -0500
Message-Id: <20210618182518.697912-26-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
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
index d0df695b52..b4b778da0b 100644
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
index 1fff8437d5..c7e4de15c6 100644
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
2.32.0

