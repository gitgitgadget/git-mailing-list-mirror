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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F45C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A63D207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbhAACRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbhAACRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:46 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770D3C0617AA
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:57 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id w124so23456710oia.6
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=llFzOY9Mne78o3PWt7xEH/IIBSkzWHMiq01LZ/rozhc=;
        b=rOfIcmbL8vmBoJ7a6PqWn++sd4rDFejj4KyOM8MyvxYODARBA+zfZX8tlQxGkzyit4
         KfHNJN7oIF48vHw62OrREuKFu7Lvge6iRjNXL3HEihftqmmejHD5I2wwDU8VJW1SVe7K
         vHcLkRbPf9xKgCEhoWhbEGsbXveSk3zvhgp83WCxZmPgXBBvU2/rLDLPz+BIzZsXZY3X
         PkU43zLCPr7wIMR4dOmyKrKB8UC1MMCdH2GD1p1XVKP/h2Q5LqL0qCsln/xQXp90LVog
         nM6Fv9WtZi73eTjrz3eUS1mOpx9YKwG7S34qbzqjo+gRHHUX7fDqofB35vxledIQSSIo
         NicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=llFzOY9Mne78o3PWt7xEH/IIBSkzWHMiq01LZ/rozhc=;
        b=Sii1HKnsjydsojd7pWo3V7RWSuBOhawNoSi7Kwf01RBkqrKQ2ReswIxYGKMczDUiqI
         OyQz1Hs62O/aR/SFN3WJYgMeF9B7L1z6q1mtvagkMlmlywYm28FYR3Mn+s4oFCJ1AfhE
         labvL5a+5LAR6Xc3IxvTZqdfKtoOj+8vxFv4jJtC5FV2ppLXJ2A7QUISX/Mch6qK6O3a
         MCIWo+Rk6NCXk/bU/nqgB3D1PYy27lLnd2EY6aXYKmx5IqsoMukpKZAbsiap5yWF9s6F
         Oq1OJgDUjwVtw3NKQGeOeUVMtfH72rnHEQ/gO2J/HH80byCW1spI4Volx3gkqNF7MXqj
         tO5Q==
X-Gm-Message-State: AOAM530TeNaWJ+128Vd83jGQM1J8oCELRVZZW1Bkff+/T+KayZPNpyMe
        kJURUPWFWi9imBzL6GRStC4umiwBUW7lAw==
X-Google-Smtp-Source: ABdhPJwAAiG+Vp8OUyL2mG0tZq/qMEv+pIi0+kbNJj+SxZP4IEKn9/jeXphhYmLJZDlPrhSpf7zpNg==
X-Received: by 2002:aca:4d8b:: with SMTP id a133mr9777544oib.79.1609467416624;
        Thu, 31 Dec 2020 18:16:56 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z8sm7029229oon.10.2020.12.31.18.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:56 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 20/47] completion: factor out check in __gitcomp
Date:   Thu, 31 Dec 2020 20:15:55 -0600
Message-Id: <20210101021622.798041-21-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way we can reorganize the rest of the function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 6 ++++--
 contrib/completion/git-completion.zsh  | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ec62c11fe5..ff5d29bf36 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -321,9 +321,11 @@ __gitcomp ()
 {
 	local cur_="${3-$cur}"
 
+	if [[ "$cur_" == *= ]]; then
+		return
+	fi
+
 	case "$cur_" in
-	*=)
-		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
 		for c in $1; do
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d754086877..090c644b71 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -55,9 +55,9 @@ __gitcomp ()
 
 	local cur_="${3-$cur}"
 
+	[[ "$cur_" == *= ]] && return
+
 	case "$cur_" in
-	*=)
-		;;
 	--no-*)
 		local c IFS=$' \t\n'
 		local -a array
-- 
2.30.0

