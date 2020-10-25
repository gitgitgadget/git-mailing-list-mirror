Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CADC55179
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFA320936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq3X1xuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766842AbgJYDOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766837AbgJYDOC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:02 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA651C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:01 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 32so5123640otm.3
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZO6KUkuVfULWoaGZ56IxJadVwdlwGesrdAW4aReFdO4=;
        b=oq3X1xuNVT3tLmtinW6XCxXUvs7W1ewxX0UurKBF011lAOV+kUfZ/ZKg7d1i2Hkxr5
         o+qgYhciHDt02lJwk0aM8D1z/+EC3OUI+TgfSeBIzaw6opG9Bx/YEylHKAFNxJMMlGKF
         9wX0d3Lmvpp5xv/tTN9Hxg5iaDontP5dLxDWOINGZPYt+19SBnOU63j0xubi1kb4tE80
         ASTCS7JpQltmtQ8fE2l2c3flkuZclTs4o9YBDGLFmeGwIHwwl4EECFymCMDvRZ+/kXRU
         8iQuC7jAx//rMWt1/cVah1DAcbG5dfW2P1MNBaRTtlQeMMwBa4CwDiSVlwxObr39Z+Cl
         3geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZO6KUkuVfULWoaGZ56IxJadVwdlwGesrdAW4aReFdO4=;
        b=rcqpyDX9saqHUnE6hHuw1emCaaERnEe3tUBMEiq4kX7bMZeCd+pqnhxdMaC0zFdXF/
         hPXOqaYUbDQjjDH3IuYIxTNr2qhfkTTAjtaTzVSdfrSDnVkNK+2iZ58WFQmfLuqpOxqz
         lbeJpLr05pkVmeNvsuXvsdqHs+lWlJrjngEsrGGi5fOYd9y9mHfy5YCattg9aCsUX6c1
         TeLlm0kGZ58nzIRRrdcHDKYnLVV+KH+I1xprtwq+teURV3URKbpY8zbaME3oiohK+LZC
         gcECw0EoMBSD7AvNPefs8kuFUDoxwDphas6EoKsYKNhp24QT2xspUmyMtOgdJjNmFBcf
         LCNQ==
X-Gm-Message-State: AOAM533ialQq6MSoWSS/FJexXNbFiOuUSSVUrbwrHdugqRvvOHwc+bun
        fIFeT2v2oikUkAi67dtysAkWvXhBX0wG7Q==
X-Google-Smtp-Source: ABdhPJwdzwehgu1L/N/0LhnPvI9jfgMMapUDJ8/mVMbtysv3XfxXX3trW/SGQqaPLIpfINY/fxOMEA==
X-Received: by 2002:a9d:4f15:: with SMTP id d21mr6551959otl.166.1603595640963;
        Sat, 24 Oct 2020 20:14:00 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m65sm1680258otc.36.2020.10.24.20.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/29] completion: bash: remove zsh wrapper
Date:   Sat, 24 Oct 2020 22:13:24 -0500
Message-Id: <20201025031343.346913-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has been deprecated for more than eight years now, it's never up to
date, and it's a hassle to maintain.

It's time to move on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 92 +-------------------------
 1 file changed, 2 insertions(+), 90 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 40affd40e2..26d6ee20b0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3458,96 +3458,8 @@ __gitk_main ()
 	__git_complete_revlist
 }
 
-if [[ -n ${ZSH_VERSION-} ]] &&
-   # Don't define these functions when sourced from 'git-completion.zsh',
-   # it has its own implementations.
-   [[ -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
-	echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
-
-	autoload -U +X compinit && compinit
-
-	__gitcomp ()
-	{
-		emulate -L zsh
-
-		local cur_="${3-$cur}"
-
-		case "$cur_" in
-		--*=)
-			;;
-		*)
-			local c IFS=$' \t\n'
-			local -a array
-			for c in ${=1}; do
-				c="$c${4-}"
-				case $c in
-				--*=*|*.) ;;
-				*) c="$c " ;;
-				esac
-				array[${#array[@]}+1]="$c"
-			done
-			compset -P '*[=:]'
-			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-			;;
-		esac
-	}
-
-	__gitcomp_direct ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -Q -- ${${=1}% } && _ret=0
-	}
-
-	__gitcomp_nl ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
-	}
-
-	__gitcomp_nl_append ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
-	}
-
-	__gitcomp_file_direct ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -f -- ${=1} && _ret=0
-	}
-
-	__gitcomp_file ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -p "${2-}" -f -- ${=1} && _ret=0
-	}
-
-	_git ()
-	{
-		local _ret=1 cur cword prev
-		cur=${words[CURRENT]}
-		prev=${words[CURRENT-1]}
-		let cword=CURRENT-1
-		emulate ksh -c __${service}_main
-		let _ret && _default && _ret=0
-		return _ret
-	}
-
-	compdef _git git gitk
+if [[ -n ${ZSH_VERSION-} && -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
+	echo "ERROR: this script is obsolete, please see git-completion.zsh" 1>&2
 	return
 fi
 
-- 
2.29.0

