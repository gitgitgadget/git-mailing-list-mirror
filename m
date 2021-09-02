Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F76C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 06:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60BF610C9
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 06:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhIBGNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 02:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhIBGN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 02:13:29 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FD3C061757
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 23:12:32 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id z7so531035qvi.4
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o/jO9K0z8D79vxcFjLoTri+AFIdlyYEggvtUcsCK1lA=;
        b=DF0DedrDMMTdEg9KlMDhamhXPJ/yWjYWt8kcCXATVM+cVE3vS+Lr7ZO3ZsazRKEjYY
         LPWdu0dPvArh0VlssrtiNKUhYzj9vsQtPET0wpYWwv0zNz9zp8O6JvFNe3IQ8Qg6aND3
         vAgE9t4+P+qvhS1gwGVa63hYhtF++xIOPzTCBDH2hqOUg6+1wczIgvl0ZR1o4iGEpTiS
         T7wWbpQieNwdbZePmCHloEiHQICd3zSu34WrRULDSkFt9Hq7A0rGF/TVMscMUWPUquuB
         E1fCxIY58YzGwXGEOzOM2uUdULMB/ngc8bslHYYLu6jjPAcLN4z5HxtrlqWrRt7Tob8D
         K66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o/jO9K0z8D79vxcFjLoTri+AFIdlyYEggvtUcsCK1lA=;
        b=L+CcsuWZnfOnfdcOugD07hkNk1l/W2CC3wX2fLTWIC31rz9OyfMrEtBtYt1COPPS6T
         EHX/0ok6LiaieTo8DYjNcQeqbgq41Iz+OiQO8ijoXxxhn3HnCN/NSghNd//tbKjLwM1A
         iyqoq2/UQHlopS1CHoxCOELSXl6DLJDzkA59E5skZDq5OqXRQ1iConvk6bfS4B8jE885
         CZoLgDUcXAwZsxXdRu+MKXqB0nN4mPbU4CiNgl4zMRh4+GVpA1rZTQKQe6ZkXRO+Nkra
         o7QIc7K3WLNNlqaxV0l0YFu0VCuy/e9snrGgO8HIZo50ybZAWGT2vHK6y3YHyJaexEo3
         nxhg==
X-Gm-Message-State: AOAM5329HIbzjlXpT39ii+HyqzKbgvruPVDfikdFDt9WX/ZtxaQbjgxo
        kL6PAPwhCCDXLF8Xs+WO16DINv4sSh0=
X-Google-Smtp-Source: ABdhPJzM6UWWmaSbBN+R/Ltb11AI72Q+G07i35NXMnUVbBkPEF/MpYWLpctuqZyVAH5mZ3jtFr9REg==
X-Received: by 2002:ad4:4e86:: with SMTP id dy6mr1658195qvb.30.1630563151012;
        Wed, 01 Sep 2021 23:12:31 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o19sm473624qtv.85.2021.09.01.23.12.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 23:12:30 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
Date:   Wed,  1 Sep 2021 23:12:19 -0700
Message-Id: <20210902061219.44655-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <aa9b8e05dbdd8c6ad5ff687b5a1aefe31d78853b.1630335476.git.gitgitgadget@gmail.com>
References: <aa9b8e05dbdd8c6ad5ff687b5a1aefe31d78853b.1630335476.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OpenBSD 7.0 (currently in beta) comes with zlib 1.2.11 and no longer needs
this compatibility layer.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.uname | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 019c88d5df..e3b7343ed2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -256,7 +256,10 @@ ifeq ($(uname_S),FreeBSD)
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
-	NO_UNCOMPRESS2 = YesPlease
+	# Versions < 7.0 need compatibility layer
+	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
+		NO_UNCOMPRESS2 = UnfortunatelyYes
+	endif
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
-- 
2.33.0.481.g26d3bed244

