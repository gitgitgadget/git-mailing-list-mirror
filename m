Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751F5ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiH3Je5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiH3Jdn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:33:43 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95102E396B
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:52 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eb44f520dso11117343fac.10
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=u7c4d2dsQmi2klbljrl3ge854mHL9xVjW+BQ90H26dE=;
        b=ieyo61QrxZ0ceEt5J8gNJ4xEL/tXUhL7QTSSPgYzUFjXk5p7xhek23KShDNvSnc/mj
         dUQfwVATfJHUVCSM3iokXYPN9093jZNxal456VlB5vo9u80vyQzyF2y4A0CWf3hcO1PS
         6ufxYaV7zKzpIqw0BxwdA5Xj052EFzKKdZuy8BuA3WJxrLlzLrErjQY2i5B/t5/x7yS2
         NsfDogCCaEOgqIOQnKmfqRc9+s9UzXv/8xweXcGTLvNI8aH07tUEhg1VFuaZxUxHOQJG
         4gjmUJbgu1oKon/zJb143zZnIukqAYX90jGjmfHdCHL0jL0/sZ7+e4tagiTLh8/kTb4C
         xMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=u7c4d2dsQmi2klbljrl3ge854mHL9xVjW+BQ90H26dE=;
        b=pORf/LKZDcjQZ7c4llGRdM66vTTuis47VnJ2VV6IyfRmqT+PSmCeL9Co0QyOTiiUuE
         Fj6M4PxYcFzAm0WUJn4235tAaryZJjESSqpfX/jx4ZZS+qqanpz+/w3hXunHc0wy8jW1
         6o+NOHijLyC680U2RCdKmvDB8sWQa/P93m8LixHvkhNJK+SodXo9oqubbOG10BimMaSK
         j+/3qzEsUwObTygznwLfvRbvePQBPpghSPOUp7Fvnhj1/pOinyP41FDjVuSSfp7g50E6
         /mSkbldK29SKYeUGTu5tkD/twHhHI/wHem+4IGDWsBMhdVKStMrFbq9Xej/ir6TqQGsX
         U6NQ==
X-Gm-Message-State: ACgBeo1FyfbK4VKFapRQFyG6y0uZrykl28hESY3rEP0wHFJXBCsSjlpt
        nb5tAeMIdX2UUBjV8jgC4WHaBI8mBeA=
X-Google-Smtp-Source: AA6agR7nSfsGdgJftPjEdKk4VI7oFQTsrdXSdLh5mA69lbrBbRPyoMc4fL3GNJ3sBCBhiWQl6xCBPQ==
X-Received: by 2002:a05:6808:8db:b0:344:fb71:2159 with SMTP id k27-20020a05680808db00b00344fb712159mr8989937oij.34.1661851971704;
        Tue, 30 Aug 2022 02:32:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k8-20020a05687015c800b0011bb6582378sm7493008oad.51.2022.08.30.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 42/51] completion: zsh: add elements individually in __gitcomp_opts
Date:   Tue, 30 Aug 2022 04:31:29 -0500
Message-Id: <20220830093138.1581538-43-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful to specify specific suffixes for specific words.

This will be useful later on.

Additionally two tests now pass because we are not using an array
anymore.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 6 ++----
 t/t9904-zsh-completion.sh             | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 27ca6efe89..42bf9b95eb 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -67,11 +67,10 @@ __gitcomp_opts ()
 	[[ "$cur_" == *= ]] && return
 
 	local c IFS=$' \t\n' sfx
-	local -a array
 	for c in ${=1}; do
 		if [[ $c == "--" ]]; then
 			[[ "$cur_" == --no-* ]] && continue
-			array+=("--no-... ")
+			compadd -S " " -- "--no-..." && _ret=0
 			break
 		fi
 
@@ -83,9 +82,8 @@ __gitcomp_opts ()
 		else
 			sfx="$4"
 		fi
-		array+=("$c$sfx")
+		compadd -S "$sfx" -p "${2-}" -- "$c" && _ret=0
 	done
-	compadd -S '' -p "${2-}" -a -- array && _ret=0
 }
 
 __gitcomp_nl ()
diff --git a/t/t9904-zsh-completion.sh b/t/t9904-zsh-completion.sh
index 894f3287f4..dc1578f41d 100755
--- a/t/t9904-zsh-completion.sh
+++ b/t/t9904-zsh-completion.sh
@@ -105,7 +105,7 @@ test_expect_success '__gitcomp_opts - option parameter' '
 	EOF
 '
 
-test_expect_failure '__gitcomp_opts - prefix' '
+test_expect_success '__gitcomp_opts - prefix' '
 	test_gitcomp_opts "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
@@ -113,7 +113,7 @@ test_expect_failure '__gitcomp_opts - prefix' '
 	EOF
 '
 
-test_expect_failure '__gitcomp_opts - suffix' '
+test_expect_success '__gitcomp_opts - suffix' '
 	test_gitcomp_opts "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
-- 
2.37.2.351.g9bf691b78c.dirty

