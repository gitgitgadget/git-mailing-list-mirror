Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2969C55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7040F2080C
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhr7qLsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgJ2A2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgJ2A05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 20:26:57 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E28C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:26:57 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id k65so1497911oih.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQKFHbInSiggBScwIApf2pGGdtnWYZabxgcVQ5pNzT4=;
        b=Mhr7qLsiewJpIT/NxowHsq1JKY2l0cEjsvfLaVGoCEVsdljsJ5dbEskXWK1vv95dT1
         UMRHkA6F2ywaHBluykutUj7HKeJAv130Osejb3K2hpRQb3BthzUXikIR6Ano6S1emfOl
         T47S3WDbIVA3tqLsOzlVgC2F/9PzXAU7akWJ8aMnSQXSvVFqgtOV3so45Q03E+Xlyak8
         5ay/TRZT8+Im9JsBdvwyxHUgN9Qp+GdlR1/gbsI7Oy0tUIB1ZiDs3wHo3g4bUiq0UEIi
         PJPXMQWcHH+hwc50od3tvUIEuiwuP5a0fhgWHeDMg7dKGP14tX/RkGdNShxzYQNL7PSd
         H5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQKFHbInSiggBScwIApf2pGGdtnWYZabxgcVQ5pNzT4=;
        b=KfIQC5iQd4gnSdRNbKvZSawRcx+GeaSUCVIi9S9JHM2GPhxv3bDKzPqhrzuSfukrxc
         ihNG7po1otslND49NgKDNX06+0kXLPg0+HOdSfSxvCJy6McFCgl5Q4a5E913Kf2989zi
         2HA2QMglArAm/BdoTt5MTxblsBnpaVbgzXIjKwa9clC1r3kAqUV4znIOuCmjwNI8iOiw
         Zarw981XJoIIj4DZVT/3Ll3M7DM7MtXeZkBA+oeGCunzZ3oIiLCG7TxqMmuhrDYqdXei
         +gOCkseTuDmKM00HgH5yNLsJ16ViGMYFE5as8gNaP0I7yEzcnuLsKWGQYqyc9v5/M7EH
         GG2w==
X-Gm-Message-State: AOAM530ExPKAtIjBr1tQ6MtGb9EMLmMBayaLp7qM1IS5/p//1FrPhI/s
        BGvMCPWAEGTy69d9LUu8fw2CZW7BdLHeJ/wA
X-Google-Smtp-Source: ABdhPJz89eb+bHGWlzFZYHq7EbrF0SYm9dJuJCLCI2AAejdRq58rTWMhyLifRvMJ0/KRSixzVJHPew==
X-Received: by 2002:aca:750b:: with SMTP id q11mr3643873oic.163.1603850844552;
        Tue, 27 Oct 2020 19:07:24 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h15sm2248982ooe.42.2020.10.27.19.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 06/29] completion: zsh: update slave script locations
Date:   Tue, 27 Oct 2020 20:06:49 -0600
Message-Id: <20201028020712.442623-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
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
 contrib/completion/git-completion.zsh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 5d6740c6ff..ccf384ba35 100644
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
@@ -33,12 +33,16 @@ zstyle -T ':completion:*:*:git:*' tag-order && \
 zstyle -s ":completion:*:*:git:*" script script
 if [ -z "$script" ]; then
 	local -a locations
-	local e
+	local e bash_completion
+
+	bash_completion=$(pkg-config --variable=completionsdir bash-completion 2>/dev/null) ||
+		bash_completion='/usr/share/bash-completion/completions/'
+
 	locations=(
 		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
-		'/etc/bash_completion.d/git' # fedora, old debian
-		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
-		'/usr/share/bash-completion/git' # gentoo
+		"$HOME/.local/share/bash-completion/completions/git"
+		"$bash_completion/git"
+		'/etc/bash_completion.d/git' # old debian
 		)
 	for e in $locations; do
 		test -f $e && script="$e" && break
-- 
2.29.1

