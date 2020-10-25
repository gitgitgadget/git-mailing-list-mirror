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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116F2C56201
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20D920882
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC02ACCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766830AbgJYDN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766825AbgJYDN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:13:56 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1980C0613D0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:55 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id k27so6917506oij.11
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HTKkjlsvO7pfRgTUth2glsjU4eVeg5JumsflCIA0x4=;
        b=aC02ACCyzCawAP9smuwLSGKQ9KqtuOCy3b0wiZoJXSsv+rOHrr7MxiZMjJpnQiF44H
         g1VrhpRz67ME/yAnhvYQog8OIpQ/1bCFaIeCTVuFDMYPzF7ud9u5Qi0fp6OCIiHzdsG8
         miduI89IbrxpbrqgVbyCfT2CoQZdnnSVQuk0Le3AIrV57QP93g9VmEWyJkuGwtvkBlMO
         pXIp0NWO5WaCXY/vzJ1MdijZYe8/KPAyp/RVd7+ZJ3pmV+Dh8f46z9e96LdKe+A9hW7q
         Om27krabJA3qU0TNLnwSG8qRXq3s+qL0ey+gPEorHlmzA3AKyqi7R/by7q51qPpkvvdh
         IZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HTKkjlsvO7pfRgTUth2glsjU4eVeg5JumsflCIA0x4=;
        b=VTUP4O+hW9JR2etn2szLStxpa7dxHfAkbUETLVDM8vff5SWb+in0mAF28hArIrjSTx
         r8Jqd54dIbDdxuU8JKNnVOtI5uc68ugirq0viuISgEje6c9WQ1dhJUxhd5jvJK6hjhk0
         Vbr3GVVCOlh7O6iaHvP5l73nYatfVYTnpXf0D+ez9J8h8aCHFCiVUWBoFXTWq0dmg7YF
         Me2XORCvXsNmc0cagevgVxqMA+0rb8U2qBiknfXfRSgexDfpV/61AK+uxXTs7QRHihTG
         uc8zc5EXJW4Ir5sURG5nd0hbcYhL7GjwlZwr51wnM3jqwgQ2lJ6CMJZ/eTjfEaocVfPf
         VyFg==
X-Gm-Message-State: AOAM530PJNodfWjCj8GESEo+IGGduWWnqiQfXnJOTBHYfQi49TOeCkkl
        kIS3Nn2WZ/CjWAg9LqBy54yVMMS7jp9ZKw==
X-Google-Smtp-Source: ABdhPJyLShyG2GVqf3yAOJJ5RrGhMFEuniAVU5apqcJfhOSjuivzPF4NfJD+7494feeWR4Vq+Kpgmg==
X-Received: by 2002:aca:442:: with SMTP id 63mr6370761oie.111.1603595635058;
        Sat, 24 Oct 2020 20:13:55 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h9sm285490otn.74.2020.10.24.20.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/29] completion: zsh: update slave script locations
Date:   Sat, 24 Oct 2020 22:13:20 -0500
Message-Id: <20201025031343.346913-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the default locations of typical system bash-completion,
including the default bash-completion location for user scripts, and the
recommended way to find the system location (with pkg-config).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 5d6740c6ff..ba41525373 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -13,7 +13,7 @@
 #  fpath=(~/.zsh $fpath)
 #
 # You need git's bash completion script installed. By default bash-completion's
-# location will be used (e.g. /usr/share/bash-completion/completions/git).
+# location will be used (e.g. pkg-config --variable=completionsdir bash-completion).
 #
 # If your bash completion script is somewhere else, you can specify the
 # location in your ~/.zshrc:
@@ -36,9 +36,10 @@ if [ -z "$script" ]; then
 	local e
 	locations=(
 		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
-		'/etc/bash_completion.d/git' # fedora, old debian
-		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
-		'/usr/share/bash-completion/git' # gentoo
+		"$HOME/.local/share/bash-completion/completions/git"
+		"$(pkg-config --variable=completionsdir bash-completion)"/git
+		'/usr/share/bash-completion/completions/git'
+		'/etc/bash_completion.d/git' # old debian
 		)
 	for e in $locations; do
 		test -f $e && script="$e" && break
-- 
2.29.0

