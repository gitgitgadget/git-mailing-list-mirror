Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D3C0502C
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiH3Jdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiH3Jcx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:53 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF33E0FF7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:35 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11dca1c9c01so15401030fac.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JCh1ivWBDv+L39NAu03mlj3UkKBLCyhrCVizbIhoLbs=;
        b=qzoiTv4pzX3n9T0buxFg9DEZPeqJoPlAf15QPZIl4qtbpp3pODOadZHfZOrR7stbg5
         FYr1AUz+PKhQHiSRWcbfqad2nLsFepnAmqcA2rOI3vYIrH/nCuIj9j2crLokG+DNOte/
         USHihQoye2EN20u5fhIvOyX9M/NxT8EiEBzRbCn4kpACk1+MNvFCcokXZPsP++3oB+bu
         bceWkVsZ8c2uMtOXe7vXHqisl+H5O/F6NetEZTrYJwHzIeYNMisyN14nrJk7/4DKhHmg
         vzF3wUprfYlRpsJ7AVMhaBwI6cOXN5sjlnnyyQt5ZjScxYL+sQAavhe9bZ9Vq7TeLAlr
         ZAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JCh1ivWBDv+L39NAu03mlj3UkKBLCyhrCVizbIhoLbs=;
        b=eLgKXlkj5QP/klx3ebG7Gf+EXgjTUhoqqmnYX0KK47cn5jKxOudf0m/x9ijMVi/0Pd
         se8bfkewP83hRUg9DzpEEDUuimnveFM0mCaZyNiaykcS2CE75RQeukAfUCIjB+uGvJCy
         qPCfUpxWki3TEN2CSdk8KceZvc3YgIf/48cs/t+Z27Hq+6CerrZdVNiVUEOInAAZ8aRL
         HNH+rv0Gzq+h3bCPyUP2tXmTistj9S9r4VRYHmvOubs72xOr81zuYSBWEWUfLWfa0nZO
         tmnueVb0HIBzF1m810D75rVgQkqyaTWIh3+BtSEid1BI7UhHrEchzFNGBtpwXqjnQyts
         bIdw==
X-Gm-Message-State: ACgBeo3WaO/gkI45Rttfj1fmdPFTSC/AondgyRE8bGWrVBgwEFH4At4h
        b3Tm5e+BtbklCx04YCFKRok7hmY0WZo=
X-Google-Smtp-Source: AA6agR52PgFMuRoL4l+kMoSI+8wfy3BnIrUCkKnGNW1ZYAAqFNLLKWIJOMJ9NS/GTLU1DHsq209EYg==
X-Received: by 2002:a05:6870:b021:b0:11f:479d:fe28 with SMTP id y33-20020a056870b02100b0011f479dfe28mr622452oae.23.1661851954922;
        Tue, 30 Aug 2022 02:32:34 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id m6-20020a9d7ac6000000b00638a1c49383sm7000519otn.78.2022.08.30.02.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 32/51] completion: improve __gitcomp suffix code
Date:   Tue, 30 Aug 2022 04:31:19 -0500
Message-Id: <20220830093138.1581538-33-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in adding a suffix after a suffix.

If a suffix is provided: we add it, if not: then the default heuristic
is used.

There's no functional change since most callers don't specify a suffix,
and the ones that do, use an =, which by default doesn't add an
additional suffix.

The only exception is __git_complete_config_variable_name, so make sure
we pass the correct suffix.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 19 +++++++++++--------
 contrib/completion/git-completion.zsh  | 18 +++++++++++-------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2ff7de1274..d43ec03c12 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -339,7 +339,7 @@ __gitcomp ()
 		return
 	fi
 
-	local c i=0 IFS=$' \t\n'
+	local c i=0 IFS=$' \t\n' sfx
 	for c in $1; do
 		if [[ $c == "--" ]]; then
 			if [[ "$cur_" == --no-* ]]; then
@@ -352,12 +352,15 @@ __gitcomp ()
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
@@ -2586,7 +2589,7 @@ __git_complete_config_variable_value ()
 #                 subsections) instead of the default space.
 __git_complete_config_variable_name ()
 {
-	local cur_="$cur" sfx
+	local cur_="$cur" sfx=" "
 
 	while test $# != 0; do
 		case "$1" in
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d5f4270ee5..41aae0f454 100644
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
2.37.2.351.g9bf691b78c.dirty

