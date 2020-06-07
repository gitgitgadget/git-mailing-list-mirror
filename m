Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8775DC433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 05:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D6C20663
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 05:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oclEa9g8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFGFtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 01:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgFGFtT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 01:49:19 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E246AC08C5C2
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 22:49:18 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x16so1139566qvr.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2020 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1f/3lgyg+2LJwkBpzzrDjgoEEJnvs+1s0KiSjSfMI/Y=;
        b=oclEa9g8WRRvnoSZJR5BvtT5DMJv5kQHoTWi0jsXBbF3I5LcFr76hGoM2jGOiPDz+Q
         R8PNXuWe1u52UjXtv0WH4sZyTMY+JglG54rkKnvhQvvLeuCOVTckgh/jeRPDunnqvs87
         IvJOcDeWVQrf72ksMzCRVBWK40PSiTxA1JItUtn9DtK6Z7VkFqXBOiHQ0AjRux5NQzLr
         0s1Ri5SUwXAZDs/hShLU5sfbAPjL72uP4ouvbD9zi0BSbLoRwFFrQggqme9QYTqipeTQ
         uUWSVplOfkbUmytU1hfkQqF/XDxzUpN5SDf8tjwneDqeSf18WIb9ugAmS0GNpjKC05aB
         25jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1f/3lgyg+2LJwkBpzzrDjgoEEJnvs+1s0KiSjSfMI/Y=;
        b=JPNLvNIG4noxlfVLnog/hWT8Msl1dOnMQh3JinXN54W7egQAcXErBjNQ448esi+oU9
         Py+rSnR6Lr4ZH9q6DLlUYNZY2rjzrtfNDcGhAiRRxngxJe5UnLuDgubNGIUqxa6j1+fI
         gl176ugaqkAdH3Hayr8XO7vbMYQ+7jUU31abDlgPRP8+K9jVHiALkqnx9mRPaKvYoP1H
         yqvttrNR6YZvr8KPH4Pu/Y/bWaj5AU/GOiViEE6SiHN3t9uEIlL9B5eO3ZoyQfl2Si15
         hnamXVXjE6bWp00O1zF4MKrgtbyhx/2q6a3S1qzdUqrlGcV4GKIFHAc4lSH8sLYbsJoX
         OJdw==
X-Gm-Message-State: AOAM533AxXRA+EZRMDB36XcqTwloIkOhRylxcnu7XFzXbTNLG3aovrku
        7zFjsrinNk8TGjZhiubsvaPGfbfS
X-Google-Smtp-Source: ABdhPJyWca+uGt8iz/wfTtdRSt72Z934/FxFs7uD+tzkOWgDwIhZxDvoc/tgDRmkROUyWliNLloIlg==
X-Received: by 2002:a05:6214:178e:: with SMTP id ct14mr17097241qvb.73.1591508957454;
        Sat, 06 Jun 2020 22:49:17 -0700 (PDT)
Received: from linuxerio.localdomain (ip43-186-15-186.ct.co.cr. [186.15.186.43])
        by smtp.gmail.com with ESMTPSA id q32sm4910860qtf.36.2020.06.06.22.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 22:49:17 -0700 (PDT)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH v1] builtin/checkout.c: replace bit-shift values for macros in call to check_stages
Date:   Sat,  6 Jun 2020 23:48:49 -0600
Message-Id: <20200607054849.1014185-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently a call to check_stages is using bit-shift values to define what will be used
as the first argument. If the reader doesn't know what the values are from heart, they
have to go dig in cache.h what each value is.

This patch is replacing those values for the macros from cache.h so that it's
clear at first sight what they are (CE_ENTRY_REMOVED, CE_ENTRY_ADDED)

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ffa776c6e1..3a644b31f6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -397,7 +397,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 			} else if (opts->writeout_stage) {
 				errs |= check_stage(opts->writeout_stage, ce, pos, opts->overlay_mode);
 			} else if (opts->merge) {
-				errs |= check_stages((1<<2) | (1<<3), ce, pos);
+				errs |= check_stages(CE_ENTRY_REMOVED | CE_ENTRY_ADDED, ce, pos);
 			} else {
 				errs = 1;
 				error(_("path '%s' is unmerged"), ce->name);
-- 
2.26.2

