Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739BAC433FE
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA416103B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 00:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhI0Alf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 20:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhI0Ale (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 20:41:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39961C061570
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c21so17490374wrb.13
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqjAiBHXMMZsQA+OBW+pkCswdlwnaoLvBkufqB2PEE4=;
        b=QN9LTf8AFmm/cYhewDL7kKSC1mI4rSwSWyqArhA98ku3sjhnVWSqNr7svvB8YoWrY9
         evybp3cPCKcz1WuK1/fiyw/wxgxtl2dwqIARRe4QP0qAy64oJw2F/b3IstRElmkTc6q3
         eHZ73xB3IPcIKevwIQquppWIUkdZCsjOBkZFQE2yVct8ye8ezBZpI4uFmCwef+hUEYBh
         F4eTmkkSSnHW43Huh9eNKQKHlUrTRx8cPhtkcW0iszrcpQrEBvj86pTZOC3k8/yYHiS2
         GYnpma5uAJzrXIlKUvqL2/7V+EPUI8hMb1ZEPUiggDitqMBQEIis8HulxbzozZw/fl2p
         FZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqjAiBHXMMZsQA+OBW+pkCswdlwnaoLvBkufqB2PEE4=;
        b=db7mt45YfHR7gitBAAXB6qezNJhUX+FE4t3hiZDW2LC6/PCp59bkodiVLInTXGVLDt
         2zb5c/LdrvZ/Fn7hImxfSxKYFcwGUSPKanXGD7MogoSdtEtJDNEmNhkB7KPCQZeKpkjB
         T2Ah+xnpNxDnzKTvUGt0/2AA5cycpqITv8sGkH1sVqgIDI1kgc2o0DpZ8VdIEcmma7my
         psonC1swNzO6dqzu/+Iqqahzu37rQYZmsF6Hj/GE6ftGJUm4W2eDWn75D9e6p3JiOLsI
         qUEQ9Sr3l2W+UNdT9paycYOcY83zLqLI0wXeQEKm+G4WPm2qHIDEnPDkeYEajIyOlhGf
         TTbg==
X-Gm-Message-State: AOAM531psNXuKnkPJ+fN+1m0u9ZuWvML5y60rN9srGpAfegIA5J8Roie
        twxc3Bp55/FLZaQROmtQCkIWEMsLKoDz2g==
X-Google-Smtp-Source: ABdhPJzTtd87d2IpzkJuL/oVdgGvN0pJ34nxwXtIRVeYhvRr09X03pfssT/3IRL1iz7ioZQcvQs06g==
X-Received: by 2002:adf:e603:: with SMTP id p3mr24613665wrm.357.1632703195595;
        Sun, 26 Sep 2021 17:39:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l26sm19070162wmi.25.2021.09.26.17.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:39:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] submodule-config.h: remove unused SUBMODULE_INIT macro
Date:   Mon, 27 Sep 2021 02:39:48 +0200
Message-Id: <patch-1.5-7a7a0141515-20210927T003330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This macro was added and used in c68f8375760 (implement fetching of
moved submodules, 2017-10-16) but its last user went away in
be76c212823 (fetch: ensure submodule objects fetched, 2018-12-06).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 submodule-config.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/submodule-config.h b/submodule-config.h
index c11e22cf509..65875b94ea5 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -45,10 +45,6 @@ struct submodule {
 	struct object_id gitmodules_oid;
 	int recommend_shallow;
 };
-
-#define SUBMODULE_INIT { NULL, NULL, NULL, RECURSE_SUBMODULES_NONE, \
-	NULL, NULL, SUBMODULE_UPDATE_STRATEGY_INIT, { { 0 } }, -1 };
-
 struct submodule_cache;
 struct repository;
 
-- 
2.33.0.1294.g2bdf2798764

