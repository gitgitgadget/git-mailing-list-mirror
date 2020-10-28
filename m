Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F2C56201
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE80224743
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMupN3nW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgJ1Vx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbgJ1VxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:53:25 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0356AC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:53:25 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 67so449972ybt.6
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0H9uZpX0/8EIo7oODNuFjuc/FWLJP7hXtW5dF7KWI3k=;
        b=XMupN3nWh5b2KJ3x8u3H0DFpnsrzazd3kAn/PPLFlQhhPG0ht5AEFExNmGg/z8GsW0
         k87scWrAK/MAXLAogFGaS74e5yaWfdv1FJ+a4hnSNNnza2eaubXXGUwa4QBqNdUr7m82
         7DwA6OxM79m++BVA5ytriXnhlFnrPVm+z+ouNCou8cZgELVSLgZ4jlAMik2e7X//nuW+
         Kx5/vkixlJS0Auk8QNAmE8D5XW4FMU0uvLxbqUVYwTlxKJ8P3owXuUpSJZiqk4H+22gf
         LnFZPcG3Deyac1jT0NlyRhqyA54acJ44GmZVPiwc6bXaZ2h+mbzPbUO3lTOFaq39dowA
         Wtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0H9uZpX0/8EIo7oODNuFjuc/FWLJP7hXtW5dF7KWI3k=;
        b=Jh8TU32vzFQkcVyM1djypfKX27I52KB/i00EqSTmBgjqo6fNt2CDHJqP4ea5GliY+0
         c9SH1le/ObsR+WQe9jg389AoweAnjfhL9sMNOv9bcED/IvIKQMfifQMdKxbCuTqy0AIu
         +QueQT3kZZu/bafCOONxJKWLFdXsQoZPVozm/HEFIktiZDZpoipUaogLFTbKPtLYwliC
         749yP9p2p2vhaN5niIZ6hPVYldUCu6R82tT9mYq1TZMrgmyIoryOdkeVDK08GshVYeyl
         YWbM1fEgaBOdDWLUj334ygNoxz8XJmtJv4tiTFrGE47equ0a+G/gMCUpmGD+7/88Gp5d
         xvOg==
X-Gm-Message-State: AOAM531MYC4lpQw44IvEpg8kXMhqHyr0GZAf1/KT64X8KW4LyGAJR6X+
        bHJQRemLYRqO/NvvavyVqn/hyeaJJN87gA==
X-Google-Smtp-Source: ABdhPJxbyWsJ8TuwZra0Ib9OWKDCt1pPozEk9BcERXAPGvjFLV1Mq0i8swvXze6SSlBEsIO7uJWrgA==
X-Received: by 2002:a9d:600e:: with SMTP id h14mr3535267otj.8.1603850850875;
        Tue, 27 Oct 2020 19:07:30 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q10sm2165869oih.56.2020.10.27.19.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/29] completion: bash: remove zsh wrapper
Date:   Tue, 27 Oct 2020 20:06:53 -0600
Message-Id: <20201028020712.442623-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
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
2.29.1

