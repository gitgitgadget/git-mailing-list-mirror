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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE3BC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480D06108E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 20:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhE1UM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhE1UMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 16:12:10 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3774C06138D
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:34 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id j26-20020a4adf5a0000b029020eac899f76so1209016oou.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6yPRIxMaEmatql/iE0aU5/peL92oJZwDi8tc8QjZkN4=;
        b=dt2RwpJk5Ezeai2yoL4Z+pzWUNjnQdYA8Ar7dPU72cAcG0BLVuyVaBHpOdbzFqRaNh
         SV/+YwtTjSe7nJKLs1iYsExoGVfFh5zN/o8O2hew4cvn4ljSianPDEBgS8YRZMFJS3OR
         BXJAHZro9/Jxb6KereZUEiAB+7OvBqK89V0WMhewz/yAwEoQp/fB7ensfD3qvz/asDX/
         S0ii00VBhxzPgW142D9DLVj1Zph6p6kImwdtuRkH+D6nXRQyv3inNpSYnmb/NpUXkaz4
         njCH5huHRZIVRT9tR0p/XCDWGO1oYN/WYmAqNnsxVaOjzxgUAYwt+eSx8z9YvD40jXgl
         9OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6yPRIxMaEmatql/iE0aU5/peL92oJZwDi8tc8QjZkN4=;
        b=o9Uj1aTF5hCTbW4X6YTubhd2F4MxszsIqki1rlkVsv5J/I+uCSS3SPCHmowyabVQRx
         mhZCkuItAffNBdDgr6QM18C6d893t4ZGstSEa/Hxd4nWVBixQzoRTgKWKOQuXn/026Bf
         1fOzh+AKgGKdyUsaFKlZ6tZ6qySDgolkFwneurZT6QoxEtSVS63HbR63L5Bycc7A6wOI
         S6gWVAJgjQetOgeWjiDtv+O74f4M7zAq5BwVjw+3KXy9Y6QIZJw2fq11V7eVYb70dKib
         OBoQ8QGCvBqLed010Bow9VLh9Rk4SYpTcNafXvTvUBVbPJTi4GYve33krW97ZfJtGeIh
         6P0A==
X-Gm-Message-State: AOAM530IUP0AqEVNhwLxeNJn9K6LjH6HhGAw7oDUD5TEwSwjZIJo47QP
        mx1oZWSAVIoCyw/IEgSlLR01txc5U3yruQ==
X-Google-Smtp-Source: ABdhPJwOIAI7RLmYaIhKVmlMOciNQaZa0y0ChOvFdspR5BNqCwsgE2bDpSVTiOC302dcIxgLTaUHJA==
X-Received: by 2002:a4a:1145:: with SMTP id 66mr3764035ooc.14.1622232633493;
        Fri, 28 May 2021 13:10:33 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id h9sm1307779otn.56.2021.05.28.13.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 13:10:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/11] doc: push: explain default=simple correctly
Date:   Fri, 28 May 2021 15:10:14 -0500
Message-Id: <20210528201014.2175179-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528201014.2175179-1-felipe.contreras@gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the code has been unconvolutized and it's clear what it's
actually doing, update the documentation to reflect that.

Namely; the simple mode only barfs when working on a centralized
workflow, and there's no configured upstream branch with the same name.

Cc: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/push.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index f2667b2689..632033638c 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -24,15 +24,14 @@ push.default::
 
 * `tracking` - This is a deprecated synonym for `upstream`.
 
-* `simple` - in centralized workflow, work like `upstream` with an
-  added safety to refuse to push if the upstream branch's name is
-  different from the local one.
+* `simple` - pushes the current branch with the same name on the remote.
 +
-When pushing to a remote that is different from the remote you normally
-pull from, work as `current`.  This is the safest option and is suited
-for beginners.
+If you are working on a centralized workflow (pushing to the same repository you
+pull from, which is typically `origin`), then you need to configure an upstream
+branch with the same name.
 +
-This mode has become the default in Git 2.0.
+This mode is the default since Git 2.0, and is the safest option suited for
+beginners.
 
 * `matching` - push all branches having the same name on both ends.
   This makes the repository you are pushing to remember the set of
-- 
2.32.0.rc0

