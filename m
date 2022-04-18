Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDA5C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347131AbiDRR2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347021AbiDRR1L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6D33EA7
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r19so3224442wmq.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwkMyqsyXAz/WgfyvfaKaxWRvia/KT/UVTPSk0SDa2Q=;
        b=POySfhlOpB2whjt3ZLUJWiff0FaUSxLvIEtRtA743EgF1At73XlYCSz75vgU3Niu9p
         B0bQz5oEFzM+qUPm//5o7xlSsjlPRv+BNmV/GFSd/tczsBADGsDnCR6LgK+6gDt9WQic
         jHEK8eUM585//AttqrIWggDuSk2RZyIZiZ58ykcCwE3ohlPWEhBChp00dEp1PWtfj5yz
         cR/6dCHRXtHHYdvRMJaOvyFZQxMYOry7HPu4aqL67IDn8dZ8K/FS0ayFastV5HiGv4Fx
         W8G5Krlewfyq/dD/ln6s2FQjRJlnSH24EQKgqqR8MPuhm9oCPYR2diM4wSkKIy7ozHsK
         GWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwkMyqsyXAz/WgfyvfaKaxWRvia/KT/UVTPSk0SDa2Q=;
        b=smMZbCp/Lx+b5w3EZzRekXpsbRrLbbURhTjvW5nOuvQBSmwYye93kKSESt3WfS0Uhv
         65setFf67pa+U1f8XkyApW0zptLzuTRz0fqXcOLqIt2uafmqoSEg2sn9oWmr5gOOtreG
         Osj7J+wOdR5S8gMfBK22Rsop7gc2QR8mnrNSbMthfIyCorQmPkpSfUn/vQybr4u1KYVo
         wtwNA0rLMPoLO35QBQs+VCNaEjvm2xChoNW9cHJB1nIWHNgpxs+DkjXAx0dMhQ/oq0bg
         I//+Vo0zc7iZOPNg2f7v38G73suBKupigtHLsUN0Okm3KUBEXIMm4LBSac5+FapbIXX1
         pAfg==
X-Gm-Message-State: AOAM5310jJgOpbP4ArOa7PRVDknA3YC8XXupgpgkFriR8pzc26ffM2n7
        vGr5q3cH4OGrnKBf0bjcPEGSvvHiKaegEA==
X-Google-Smtp-Source: ABdhPJzihVsipVQ0/KisN+CMS15BxO7AWvHnvpgAsvOfWlLMmv3FVdbTtMjaO0Oagn0kz0kKydeyWg==
X-Received: by 2002:a1c:3bd6:0:b0:38f:4e30:6c2f with SMTP id i205-20020a1c3bd6000000b0038f4e306c2fmr12387377wma.66.1650302669068;
        Mon, 18 Apr 2022 10:24:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
Subject: [RFC PATCH v2 28/36] serve: understand but do not advertise 'features' capability
Date:   Mon, 18 Apr 2022 19:23:45 +0200
Message-Id: <RFC-patch-v2-28.36-145c660ca52-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change implemented cap_features() to return a set of
'key=value' pairs when this capability is run. Add the capability to our
list of understood capabilities.

This change does not advertise the capability. When deploying a new
capability to a distributed fleet of Git servers, it is important to
delay advertising the capability until all nodes understand it. A later
change will advertise it when appropriate, but as a separate change to
simplify this transition.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 serve.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/serve.c b/serve.c
index f3e0203d2c6..3368d16efda 100644
--- a/serve.c
+++ b/serve.c
@@ -19,6 +19,12 @@ static int always_advertise(struct repository *r,
 	return 1;
 }
 
+static int never_advertise(struct repository *r,
+			   struct strbuf *value)
+{
+	return 0;
+}
+
 static int agent_advertise(struct repository *r,
 			   struct strbuf *value)
 {
@@ -113,6 +119,11 @@ static struct protocol_capability capabilities[] = {
 		.advertise = ls_refs_advertise,
 		.command = ls_refs,
 	},
+	{
+		.name = "features",
+		.advertise = never_advertise,
+		.command = cap_features,
+	},
 	{
 		.name = "fetch",
 		.advertise = upload_pack_advertise,
-- 
2.36.0.rc2.902.g60576bbc845

