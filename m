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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEDAC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268EB61175
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhGKQdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbhGKQdq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D4C0613E8
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f17so21148560wrt.6
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7oykJRG09Iyb1WUHShrrSrCpgMd8k5HFyoxkgJLjWMA=;
        b=pK30bb9s4TG0sOXpp8Bt2rbVTQesDLoj/Rxe1V8Og1fEiRN+FM91Gf9XFVbusqOfP/
         sYGJjJNesMcu2NVZAtODxZP7K/fy/1U2wp2f+c5DJzycPV/fht3Z7ieW+NGR144An3wx
         2yJSyMeqqntyvGefhYyuTumvLTSqevJhkAbaSeFIW5sWaWyqjKdYTMq9JT28FErkhajH
         2dNtgYCehA6ikxGNzhwPHnMTbO23UaA6GTqIEbLA+zl2aUSNTFRbpSUe7JFbedDWhw+u
         KCcRS3SWQezocTuiZj8s/ceOJYgEL3FTQ8NgD4As9M3HXyvoNN85UzUPueAF/qRnZ8T7
         JhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7oykJRG09Iyb1WUHShrrSrCpgMd8k5HFyoxkgJLjWMA=;
        b=IJ3ZAwxjEheLCS1P3+TJ0zEh8/iarW2zCvPY90e8Te45/mbVSmSjsvmYgtpVcRy64R
         AGq3eN7k7f2stnqIvmV5RLgJzvH9k2d4GLzdOStsv+iIS/1wEcsX2djeUlemxcbSOSxG
         bTg3a+K04jO9sI9uXTQJgUz6s7OvgWvyhiJ3vgBXGS9csiiZoTl9ZgyUQUGsenC354tq
         wdm1hadC1z/NSMoZOZIXitR4XF4BIMosRwjjqGPZhuFpoSKCZSPd02BYqrl9OOeFokxp
         0JIstPnl8xd68kWpdD9BQd5K1HtMafsYX6FsnGTplfrB5D6S6lOT/RqofF8UvuI1xxDj
         O2fQ==
X-Gm-Message-State: AOAM532KOhFe8vCb1IKhh0j6VmD2YyvAmfrf+jgItbdL1EozmKj7MJEQ
        ZHTmVwTwb05cA/9RD1CRuQHpWWR+ACS//Q==
X-Google-Smtp-Source: ABdhPJyNzMWV0ISEMOssndHsC89zbc65/Ry3dugdmdbaoNPy1AV6pWNWE+/Y6vgVkIup8CTLJV1nOw==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr14634563wrq.328.1626021057119;
        Sun, 11 Jul 2021 09:30:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 14/17] refs API: make refs_ref_exists() not set errno
Date:   Sun, 11 Jul 2021 18:30:38 +0200
Message-Id: <patch-14.17-1e9de48d850-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move refs_ref_exists from the legacy refs_resolve_ref_unsafe() to the
new refs_resolve_ref_unsafe_with_errno(). I have read its callers and
determined that they don't care about errno being set, in particular:

    git grep -W -w -e refs_ref_exists -e ref_exists

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 45b51c0a532..0364b68f8fa 100644
--- a/refs.c
+++ b/refs.c
@@ -329,7 +329,10 @@ int read_ref(const char *refname, struct object_id *oid)
 
 int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
-	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
+	int ignore_errno;
+	return !!refs_resolve_ref_unsafe_with_errno(refs, refname,
+						    RESOLVE_REF_READING, NULL,
+						    NULL, &ignore_errno);
 }
 
 int ref_exists(const char *refname)
-- 
2.32.0-dev

