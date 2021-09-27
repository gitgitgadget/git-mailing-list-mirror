Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D490FC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93906108E
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhI0M4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhI0M4X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 08:56:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0565DC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i23so51867275wrb.2
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GfzafPhlNYFZmTcdEF+4VqU4JQyL6z7m3d48eIdj/E=;
        b=iPuktoq5y3xw8TewXIHRCA6+lMH288/8OAi/G/Z/eB9eDONt1a93JWB+YwmXLa3aTv
         cbNmml73HHr2b17iaXa9nZMoNnpE3/0r1DVDTBEmjK9mHRUUvcY9pIUkbOQNkUI9B2Qd
         gbtP8osBZwOUusVaxBTXkVYfFXas0IoQ7X9iyxK96BUTKfIXRTUPtccCTr/eEsCILV/e
         cYrNNueG8mwjinGk/3DLQiumPwua6Sep/qZ5kDSgBtu+/fADhcXfpuUOKQqbD/yCWun2
         nDwpt0wayNSyqjQcs9GnHP123DMzZXwxG/u/wH7Q5RJChAO6YYAiGljO+WN3xUWXVVLK
         ctXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GfzafPhlNYFZmTcdEF+4VqU4JQyL6z7m3d48eIdj/E=;
        b=mut6vX5aWU04P8UX4N8Xb0cckbdUmQBr9GW5++is3/f+9zVp5xKF14Z7nXSN6//pIw
         KYrhQ0OtfyrSh0lRpkbkburBC7HjN8LJLp/lc0IM8RxFvJQzCLlh0LENJgfc25Yzof5g
         X0vGmDir0TmXYZlwS3flZ/xSCftO9e1IuQ6hHwH3UnTDMY6szzQxoHayCJTBI79X3gNy
         Kl9+9MtV0HZ1AD5PXiEl8JRwhK4CW/FqGevAOoRTcyxMoO3tsFdCtlByEnsdYjmEciU9
         hgKVsLK14C/9lHjMyCRRzeml9KxZzDE8Xkj3wQDHr0Qkse6E+2gVcdBisojDL+SAdz4U
         fxPA==
X-Gm-Message-State: AOAM531FwTWjbM8TXBZlBVAfyjM85HHzaE3qXxAix7xqKSXTDeRbt0OD
        P6q47tOAO/jIdCp/pd6AkgDiGgk9/K2Pmw==
X-Google-Smtp-Source: ABdhPJzwiCRj7q0limOwb6Lxrbrc3a2+Lek0xPHdC54ErCasFtrhJG3jQmb5HkcvCyb6Z0LdHAdSew==
X-Received: by 2002:a5d:58d0:: with SMTP id o16mr3677915wrf.214.1632747284438;
        Mon, 27 Sep 2021 05:54:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w14sm16460434wro.8.2021.09.27.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:54:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] submodule-config.h: remove unused SUBMODULE_INIT macro
Date:   Mon, 27 Sep 2021 14:54:24 +0200
Message-Id: <patch-v2-1.5-7a7a0141515-20210927T124407Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
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
2.33.0.1316.gb2e9b3ba3ae

