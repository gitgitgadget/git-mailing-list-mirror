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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895E3C2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5147B20936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvbIHwTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766879AbgJYDOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766865AbgJYDOR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:17 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4560C0613D0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o14so5097257otj.6
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nmtxj5x0IQy+8iccE7nuiRsvHXQ7wXOYYCu0JAhS/MY=;
        b=cvbIHwTkwPaVtOsAMV9pnuAZE2J5wnAw/NfpdnqEDB8qPrJqSDc2CKSQay8yGnl9y1
         c6+QmFRPPWUGkIfDPFEebDL9eK51OQb/19hCnEHwb2DEqDIUak6nt5Jh73AFLA4Z1pvF
         IwvstGZzi71fcnwUd8sdIz1GNAO5LVKzKsxM62zIjfmUxU5dh4BlMgBRgId4zkW8gLuY
         2BY5HlbATW1dBSSC6XlQwGctyDoWwCadJjOn2k4QaWaVYYjrpmHbApvNIgR3j+wiBgXh
         /AhbX5YOSf9fRjcNC7XiLFOA/gmNzXXZBs0EYrWg7cgqvddCOC6U6HAERLRp3DlRVfNH
         ns9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nmtxj5x0IQy+8iccE7nuiRsvHXQ7wXOYYCu0JAhS/MY=;
        b=WLYubhKmsZR4Ug6c4tMZ7pIu772d99cgTvjh38oY1BFlrUvEDiU+Gh+zPvYzk/vyMZ
         K0VPILArHGnGG2hXxk3V73D3CQw9wm9l3COB/NRWXRl53LzLlb/QdItm7ZxfG5bjVpx+
         IgX/cqHHvpM5hxjkiT9fvbxvHZUpT0D1nWnf9jkO49XKfEflMPrdedQm8egsr9O1hvXv
         0oWFGuRPiwcLUiEBEm+HvJGlMdBEDn5EUOlsjAgYzO0L2iu9xbEdVs4lLkc9+nE3BQss
         1PrXjPN6z/Mll+DDA93P7yiPVmm2Dgy/qu+3KtK7DFKIYjwhVhIxacuVfUfK5+T2v7Vl
         DxJQ==
X-Gm-Message-State: AOAM533HvDWmFba3Q9iJxO+Tg8ZLU2viNEd/xDojfjC1oAHsOiKTDfr9
        LiND3n07IQ7mjk13kBDuuRi/+ZJ3KbEcDQ==
X-Google-Smtp-Source: ABdhPJxs/p8Z92aIQkaMQrKVM1Vf2FDmn0LhBnMqOpbLQR15wTkpaCeT441tU37MT6uaAb8WGVke6g==
X-Received: by 2002:a9d:6758:: with SMTP id w24mr2208229otm.73.1603595655732;
        Sat, 24 Oct 2020 20:14:15 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s186sm719987oih.34.2020.10.24.20.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 20/29] completion: zsh: shuffle functions around
Date:   Sat, 24 Oct 2020 22:13:34 -0500
Message-Id: <20201025031343.346913-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to have a nice order.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index aa484ad9ba..179e8ff07d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -97,11 +97,6 @@ __gitcomp_direct ()
 	compadd -Q -S '' -- ${(f)1} && _ret=0
 }
 
-__gitcomp_direct_append ()
-{
-	__gitcomp_direct "$@"
-}
-
 __gitcomp_nl ()
 {
 	emulate -L zsh
@@ -110,21 +105,26 @@ __gitcomp_nl ()
 	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
-__gitcomp_nl_append ()
+__gitcomp_file ()
 {
-	__gitcomp_nl "$@"
+	emulate -L zsh
+
+	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
-__gitcomp_file_direct ()
+__gitcomp_direct_append ()
 {
-	__gitcomp_file "$1" ''
+	__gitcomp_direct "$@"
 }
 
-__gitcomp_file ()
+__gitcomp_nl_append ()
 {
-	emulate -L zsh
+	__gitcomp_nl "$@"
+}
 
-	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
+__gitcomp_file_direct ()
+{
+	__gitcomp_file "$1" ""
 }
 
 __git_zsh_bash_func ()
-- 
2.29.0

