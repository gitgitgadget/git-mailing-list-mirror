Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564FCC4BA3B
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDD52467D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 04:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcpnb/PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgB0EfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:35:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45119 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgB0EfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 23:35:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id v2so1579005wrp.12
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 20:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nizt8aRM+2ERMtcFmTNEg/faUdfAELRMcF3S6Hexb1s=;
        b=Zcpnb/PNYX3ZFeFDZvEO78q/NMpAuIW2Cf3bfIclyPFIGn2/R6b4hKX2g/HSmKz8dc
         kXp79c4FN2SQijAIOvw+L6wiXui0Z0wdxP91nTYdGMU0vnxHRSr+mNu33hBvw9Jonz9P
         KXavo7v4gMtZethJh78R2kSact9dWNWQCmVUMBAG91xJ6ngfrMupP14I6/NfPHET+kcq
         1tWNLU9IE2MpB5MMC9X9Mleji/3/yVO8fgimiWbA3UTb69TcgIFqdWCDrCXhngwL5g1/
         h4cbebVwKOjnO9fRq7xmOQ2cF6kQfR1eRP3oRxJxlgKkIue1/cLvVrV8NzHm/247o3qG
         4B4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nizt8aRM+2ERMtcFmTNEg/faUdfAELRMcF3S6Hexb1s=;
        b=ahR8BSYCZMj7HiJ+Icl7qvQmO2k6J5ftQ8lhc8z9Q5wLy0RGLx8gukCpQ+UeVi/0IT
         6wCbx9ygnH6ePzGYPehcsxA2NGZQQQ+EgXVRF6C1DzuRVIkwY3HR45zZtmDEZxpEncye
         LWKbwNrCS2wHLTEcT2YR35xspFIP6JFt34sTRMGp5MvYEZDyLew1lvo9DRFP88YlpWo7
         LAz4TFPdOoJkCEHVFhZnj1qjI5LtC26QcOwzXc/J20LMlxNir+9MHVrSqQY/VpTKvCTA
         JsbKhkTZ4lf4A5qL/QIkif3zu5Ctqov1PM1zVfMw7IfBvWbrfTo0sr8h3qVMr/+mmDg3
         U+lg==
X-Gm-Message-State: APjAAAU5YNjgM2CyvQ6VVxG+ZBVHk5BmPxXItxqx1XZF/4xHihQyhD7c
        5n2wjnPwY7W5kELDEo6wM0/TdFAt
X-Google-Smtp-Source: APXvYqyxPSO9MSKIslE4q3JTgM4+f6vzUgF3dGIfWKn2p+xpnYBJzmyqI6XPxQuJMGMriliERTlMaA==
X-Received: by 2002:a5d:5183:: with SMTP id k3mr2334120wrv.414.1582778114929;
        Wed, 26 Feb 2020 20:35:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q9sm6373544wrx.18.2020.02.26.20.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 20:35:14 -0800 (PST)
Message-Id: <828b4aee19d09218beca6ad1d93006012be99a0a.1582778112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
References: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 04:35:09 +0000
Subject: [PATCH v6 2/4] advice: change "setupStreamFailure" to
 "setUpstreamFailure"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

fb6fbffbda (advice: keep config name in camelCase in advice_config[],
2018-05-26) changed the config names to camelCase, but one of the names
wasn't changed correctly. Fix it.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index fd836332dad..258cc9ba7af 100644
--- a/advice.c
+++ b/advice.c
@@ -80,7 +80,7 @@ static struct {
 	{ "sequencerInUse", &advice_sequencer_in_use },
 	{ "implicitIdentity", &advice_implicit_identity },
 	{ "detachedHead", &advice_detached_head },
-	{ "setupStreamFailure", &advice_set_upstream_failure },
+	{ "setUpstreamFailure", &advice_set_upstream_failure },
 	{ "objectNameWarning", &advice_object_name_warning },
 	{ "amWorkDir", &advice_amworkdir },
 	{ "rmHints", &advice_rm_hints },
-- 
gitgitgadget

