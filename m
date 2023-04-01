Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB083C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjDAIt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjDAIsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:48:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487F2220C
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:25 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso13140038oti.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPXOEaQgKrS28LoKn/VPll64fi6LtXpVb3r9D5ItD38=;
        b=iGBsxUj48i9GOLBK8MpPeiQVOpoPgrATY0RjWqg/cRVazbAELvy073gRjzQU8XoC9z
         oiCAGskhyUownq2Jn4W+YGy+PDRikFAEiXGugiH/9kTORmYaa2imvDXw6fUMIW3t5GS6
         3gRfQyy3OkQ/dd2QO9G0qDAuAFU8lQ9mxkTrNWU8U3oCI7YVwux/c8vTpkjW11GtLqCs
         t3D7CfSBfVOpRstATNCzWDxq4yOuw18PeTP5hQ1K3rdth1WU/zB8HMkEvXCRHK8AjOO2
         pLhyQ0SFMcTbuWZUQZ8ds/1yBGfiRqLtntUXotdncO5Kgj2SSfibuHqaWjrsdz1sNNjN
         aFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPXOEaQgKrS28LoKn/VPll64fi6LtXpVb3r9D5ItD38=;
        b=ufGNOGsjpO4aUoPKmy6xATTCSIRa2IM1MP+zaPPeWpnR4s1jB/rO8mWwJ1+Crrt97X
         ptqlZBUALy2SxXUU8AzuSin1wIsMrTrXFo4fLx8+OVLO9L0oQwrK7ri9HhjFRGpNZlde
         oC0xlnLcY95BX/wdE9GMvvbQ4VftaHE5GPpA+S9kvh6o6+eWVdHI2jgAVEQ6dewPoo9u
         tXvBqiUNFpUDKAVLYeeNfGbLMC5BCt55vs/wFN4C5jDMnltL8jHL2IIg30kGnPIHzUzW
         tGF0X2YRCsuAohQxvV1dK/V2NkBDvOKveHnNOqBlp2LuWOfOtJIaFokShwTMMeYaSo7S
         9Nhg==
X-Gm-Message-State: AAQBX9fDWKaEwW2DTsUPusPKVIQO+1UfMi4HlzvzmYq5sp50tRmLzqhE
        vUCaxfayVkpbh1CnqZNQdjhx98lIn6k=
X-Google-Smtp-Source: AKy350YEEeB/DOZlXbmXoNEvUhyRLuOarnmEwkHti0TfncxkxdqDmPpkb8LOJl9u1g2fuG60VYcpaQ==
X-Received: by 2002:a05:6830:1e73:b0:6a1:4387:3c65 with SMTP id m19-20020a0568301e7300b006a143873c65mr10142446otr.38.1680338845301;
        Sat, 01 Apr 2023 01:47:25 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id m1-20020a9d73c1000000b0069fa35f05aesm2116435otk.28.2023.04.01.01.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 42/49] completion: zsh: add elements individually in __gitcomp_opts
Date:   Sat,  1 Apr 2023 02:46:19 -0600
Message-Id: <20230401084626.304356-43-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
 t/t9904-completion-zsh.sh             | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e2a7f55539..ba7b0a7dbc 100644
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
diff --git a/t/t9904-completion-zsh.sh b/t/t9904-completion-zsh.sh
index 79c1368769..24fb2dda00 100755
--- a/t/t9904-completion-zsh.sh
+++ b/t/t9904-completion-zsh.sh
@@ -124,7 +124,7 @@ test_expect_success '__gitcomp_opts - option parameter' '
 	EOF
 '
 
-test_expect_failure '__gitcomp_opts - prefix' '
+test_expect_success '__gitcomp_opts - prefix' '
 	test_gitcomp_opts "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
@@ -132,7 +132,7 @@ test_expect_failure '__gitcomp_opts - prefix' '
 	EOF
 '
 
-test_expect_failure '__gitcomp_opts - suffix' '
+test_expect_success '__gitcomp_opts - suffix' '
 	test_gitcomp_opts "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
-- 
2.33.0

