Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86742C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0B464DA1
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhBEQnS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 11:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhBEQkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 11:40:55 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599A6C06178C
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 10:22:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c12so8712908wrc.7
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5DIQw4oiFcBFObujiOKsv1mveVboPnS40X7HNxioWC0=;
        b=JpQx6dbsKKEIqSGulCkzC0hACcluFSBmIQ+F/hXTel+breYrzagh6f35pKGA0OKeWM
         hpiU7gK4pGD0Lixnk7UCp3oZ6dopHtqXShTELz+KuU7tBjvkQMQ0b0gSuuftAHGC7Yc6
         pcGFXuhVDanZ1I2KasXCEeo9nP4dhRIj5/gn+8F/AAU87O57iaGp4UVCFW+KVLCkqd0c
         QOKoV2OEdVOAQci5T8/ei5skA2U9bBvRzUbHHjm0y79MOk0f3gFzwKX+HML/zosqNwHS
         gPXU0otXUj/mp6hVk5ZO0/pu3EdP2aoTHysRdbawYFhhJzgCHGVlccEyRDQvnTgrihyH
         VXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5DIQw4oiFcBFObujiOKsv1mveVboPnS40X7HNxioWC0=;
        b=Hhb6FA9LjJvW75Ts0YfqvIwttvouXO9yTXP+zGRr8kKNVUmbHTpbhs9gci+JRC9SrT
         kD5w0CBsXzSu3Mgfzpuc9DqIcUTT2iu9bBKm+Lokv92NYxruY02cO83lsIyZ+n9KcrGh
         ntWzwFh/WaCnLT018aZil4PPr5Vl0wCtSXjVLkee/tBEsqxMziO406ZPELTMCjZn80TS
         HsNnu7QJ+RcZfrXROJe4QJKUwowMNRmpq7e9ox9G/1pniL4PTcpbSerIFcTVBbK5F0CD
         pB3xkib5u771+rOfHgIOVcPZt20Gp/kfsi5zCBCHhvfasQMkKFTSsU08QJ/w50k4/HNv
         VuLg==
X-Gm-Message-State: AOAM533dJYbULdUTHuUTYrOkNVE0nl737VYZyZDg8aOOhogn1BIJnOXu
        8uf/vMaqZX5Xa5I6egW565a3MCbEvMs=
X-Google-Smtp-Source: ABdhPJwH5chv9AK6cJAq24fFDAUAcUyztEarBU7oezb48m9VKBEsVdz8sTs8xpgUDoiPbStf3OhrJA==
X-Received: by 2002:adf:f4c1:: with SMTP id h1mr6495063wrp.102.1612549355995;
        Fri, 05 Feb 2021 10:22:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 35sm14735921wrn.42.2021.02.05.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:22:35 -0800 (PST)
Message-Id: <7a29f06c3f2569188cf73ca6ae55ab93c1dd1893.1612549349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
References: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
        <pull.858.v3.git.1612549349.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 18:22:27 +0000
Subject: [PATCH v3 4/6] doc hash-function-transition: fix incomplete sentence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Thomas Ackermann <th.acker@arcor.de>,
        Thomas Ackermann <th.acker@arcor.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Ackermann <th.acker@arcor.de>

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/technical/hash-function-transition.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 9e13919a0e5b..5ff9ee027cff 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -315,7 +315,7 @@ for all objects in the object store.
 Reading an object's SHA-1 content
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 The SHA-1 content of an object can be read by converting all SHA-256 names
-its SHA-256 content references to SHA-1 names using the translation table.
+of its SHA-256 content references to SHA-1 names using the translation table.
 
 Fetch
 ~~~~~
-- 
gitgitgadget

