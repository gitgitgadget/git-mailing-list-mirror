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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E138EC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B413A6108B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 10:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351502AbhDGKvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351491AbhDGKvF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 06:51:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D89DC061756
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 03:50:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so26857121ejc.10
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMCPsbukkT090+gH9bhjvp0/GeZT/MTrBiY2R2zaVhY=;
        b=vQhtsz20kgFomavAx5UrzzH4Rh88zKVckYCMxdbQeD7NJKEUTZKHR8eR8Gi2B9HM5Y
         5t/4EDmWDv1YxjHAt0+VGu9k8htrrDPmDNKWeuaug3Dn9Ci5jxC/Tn+7MI9wK7wlu8/D
         y3d6oBJSHntvBdGDukpXV7laAs6TZCZczTDx/qZG+Zrg7rmV8p7lZVjbB6SM271EmLtI
         7aw+QvGldy0k9JyUqIcBtgkVTTDfgKKMJQFjAV+Mh2jOXUFsjxyzhfV0b1FdRk/bB0ly
         1tYLbiRls8p9lGIo5u6GInc2Ffrf7Eh26kEbwjZjiYNePpV8v1/WEqsS+7p8N0YzCf2m
         1DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dMCPsbukkT090+gH9bhjvp0/GeZT/MTrBiY2R2zaVhY=;
        b=S9JayjD9OmfHUgEdfNyMBecofj9JAx4VIrUkBXwgYzaRRMJ/ot1Q9vInzZnQljO7QR
         BpzdGzuQLX9ocRQa0xDcWKIJr39ZR98kXrIPuLROZ6edEu6IcmqSIagf35tzsKvK1/ro
         ZxP3apxGT0e8egOtHUGtjxs1wv9I/mLxsa7BH/+QVRCgSd02sXsm+kJeGknGyNUKj7kS
         OFs3SUIMoR15dXEi9sZymVmcvPKWAA/epF5VVyOKfLXgI1q79CaHm9sHTDt7DwI3RsBU
         uR70lNXYdUKUBLt+Lfw/pT+Lr8pGai+n0UFYnz0C0gDMgfzG8jLPx8WoIHGnx15ABERG
         oq+Q==
X-Gm-Message-State: AOAM532CfMar+o0Zr4f/tO/CdM3lI2Kw53Ph8PmLQFrG/S1JuFbgGZeN
        YSFJ0DwaO9bbJWoZ2f9iBDAMgpjJaSvwtg==
X-Google-Smtp-Source: ABdhPJxq7qIplqfc1M2ZUbslrE50T6/+pPMNR05t6VqoPIzTfjogla2VB9oGVt/QVZ0r25z1homvxQ==
X-Received: by 2002:a17:907:2509:: with SMTP id y9mr2921799ejl.170.1617792654547;
        Wed, 07 Apr 2021 03:50:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id cy5sm15730302edb.46.2021.04.07.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 03:50:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] bash completion: complete CHERRY_PICK_HEAD
Date:   Wed,  7 Apr 2021 12:50:51 +0200
Message-Id: <patch-1.1-483669af7fc-20210407T105035Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When e.g. in a failed cherry pick we did not recognize
CHERRY_PICK_HEAD as we do e.g. REBASE_HEAD in a failed rebase let's
rectify that.

When REBASE_HEAD was added in fbd7a232370 (rebase: introduce and use
pseudo-ref REBASE_HEAD, 2018-02-11) a completion was added for it, but
no corresponding completion existed for CHERRY_PICK_HEAD added in
d7e5c0cbfb0 (Introduce CHERRY_PICK_HEAD, 2011-02-19).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e1a66954fe8..dbb290956b6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -744,7 +744,7 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD; do
+			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD; do
 				case "$i" in
 				$match*)
 					if [ -e "$dir/$i" ]; then
-- 
2.31.1.527.g9b8f7de2547

