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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA4C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DAA60F6C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 07:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350889AbhIHHrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350727AbhIHHrU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 03:47:20 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94286C061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 00:46:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id w78so1594853qkb.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 00:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Es/7N8bt8bTP6WN1xTRAF+mQfXZtkscT+N5XtCt8L8Y=;
        b=g25kJ85LZOVUr5hdq5ZpRu/mWYqcfgSvMoQwCVKHnX/AbNA8ytzGxztZXbMDJ3zjNV
         Ch/mkcZ0PPxI1GDi4Gl2lkYvDmPFPE6t5dGlBgdNqXh3YNVAO08BJioVuF/yARNQd5ox
         j3bTDdSYUJIkiVu5/4rMexrgRqiHMgPOanWPkzftTuDiLy9wC3q/8m2lh0XQV/mPTxuu
         7/lcsq+lMh/ixcQE9VL9EvM/3gkG6lYcsHxG7LewcRtqJD2xgEGex+bMHkXfhrEPuoRB
         Skx9w8J9Dgog/cpJdRdIw/rhiKuBeGBNMvLZ2iGB4d2LP9E4jtu9PO3Mq891osGmtH2p
         VVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Es/7N8bt8bTP6WN1xTRAF+mQfXZtkscT+N5XtCt8L8Y=;
        b=GuE3GUyf7kErOGTwq6dRlE/ZUeKtM4bxXVAK3NAjaJAwZM6yloPNaI2rT0UBSgRVN3
         v9HlLP5TZ+u6gZ4ufc95RAvD89Bcb1A0hN+NjKFcTZ1hd9AXGQlR742Xvssqjry+OS8Y
         mJjKxS4UJqq//0AK+5seT3X+uIhfzmJwRL1923cc8UAcGRYjwkweJAwGxhCVTCqKthKA
         nvV+dLnaxFYq6V2fa7TqsysoCNkbAjFIC1EsOj4wxDPgORB0HQ+ozdTX0Uh3ooyDtSiV
         V3kSZZh1DFuUpc/zQHvAAjVqLmMkOizT6ueAh3FY+h8AmnxrjwUI/42Z3Jt3M0Q13p5O
         vRbg==
X-Gm-Message-State: AOAM531nu4v8KL9bvGiTpv/0N7lFJQf/H6pJukexS54adfJ0A3J1puOG
        yDYchd89ryKsfXImNn/DWAM0Z6uZh0Y=
X-Google-Smtp-Source: ABdhPJwx0PW5k0rw3h2jQTDMDdGsIllOeEtJcVdYCpE1x0xMdQkxDBPf0kYeP0/0JF0S5oELnSOVEQ==
X-Received: by 2002:a05:620a:214a:: with SMTP id m10mr2035943qkm.374.1631087172609;
        Wed, 08 Sep 2021 00:46:12 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v14sm1122935qkb.88.2021.09.08.00.46.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Sep 2021 00:46:12 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/4] fixup! Provide zlib's uncompress2 from compat/zlib-compat.c
Date:   Wed,  8 Sep 2021 00:45:56 -0700
Message-Id: <20210908074557.38141-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210908074557.38141-1-carenas@gmail.com>
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
 <20210908074557.38141-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

while at it, make sure z_conf is defined to null (usually coming
from zconf.h, but optional and otherwise to fail with older zlib
versions)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/zlib-uncompress2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
index 23b72b49c4..722610b971 100644
--- a/compat/zlib-uncompress2.c
+++ b/compat/zlib-uncompress2.c
@@ -8,6 +8,9 @@
 
 */
 
+#include "../reftable/system.h"
+#define z_const
+
 /*
  * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
  * For conditions of distribution and use, see copyright notice in zlib.h
-- 
2.33.0.481.g26d3bed244

