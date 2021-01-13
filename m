Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF2C43603
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89BE235E4
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbhANCFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbhAMW1C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:27:02 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E40C0617BD
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:25:01 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d14so4411837qkc.13
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v/cn6izEdOXRJ7vzBjk5AFjC0JvkuXpqARQkKmAiPQg=;
        b=Aryq8vRIkB2qiZ2nV85lkPZ2E91nY7JH+EQ7yqN+R7+woY71RrYvv27Q12OJLJo0SB
         tfe/4BoXMrj2prOlWPAuXMC/M8Afuys8SrWh8EKPfDUAq36gj4oln9NXrdXhG2TT9QAO
         z/Rtd7TJq3DWlIBFNNL7sRTWZN3duUjD2exQcU5s/vufRY+lYqZZZODQ4P8OCsUwWct2
         zEfqAKOWakkHHy47Qvw8/UoMyAy66IWU4okQedB7QfNhhGs93WCoKUIkvST6+HgDj2Hm
         vYQtsNQA18WcQ1pA3XfYPyAYWPrYsqLPlw7YB9tM2NGOJHCHQ8gkqa95jai2r0PxO902
         FgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v/cn6izEdOXRJ7vzBjk5AFjC0JvkuXpqARQkKmAiPQg=;
        b=K3QQlxR9A7q+8Ucyc2//blQqObbMLICTEeYEqDIY2TN54Rk6eWoPx08KlmpAjlgU0y
         e0QI1AHfW41M1ViZagPyvugkh4fUdAKQLdW4tRxI9A/324jzaSxzR8vcSt+tUqHPmYPk
         JmsZYkTr9hTn4F8rHS3N7uKMPktUd26+NH+A3D8aAqIHpJxbTEOIiFUqdtUlWN0hAKF/
         QtEqAtB8Nf+ah7OiP73nf3pmy9dUxzQQfRQ2nkQw3OEJEDYtlaosXyoj4/ccDP/+bHkf
         yKN4i9UrxW0DmSERWUXzYmXcyHvvcIoz0btYHVyTzJB554beVbJrpKOjEcHIcb0t3WCG
         //WA==
X-Gm-Message-State: AOAM530HxTK/IVUhH0GGu4qhDxjPLny90iokeYVaCI7qiqQJ6qXrxXS1
        86hBFdndcr5dK2oRSUmJjcVMQRlTwX1Hmw==
X-Google-Smtp-Source: ABdhPJzCighb9c2RAMOH7NaZiyUkVpP8ppgQ0U2RDyf6InUFDNtMJrE9DnTUBb8iaDjw+YLUGihWNA==
X-Received: by 2002:a37:7641:: with SMTP id r62mr4456966qkc.227.1610576700795;
        Wed, 13 Jan 2021 14:25:00 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id q32sm1988934qtb.0.2021.01.13.14.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:25:00 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:24:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 17/20] pack-revindex: remove unused 'find_pack_revindex()'
Message-ID: <67d14da04a147e1805807e405cbecf91e831f5cc.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576604.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that no callers of 'find_pack_revindex()' remain, remove the
function's declaration and implementation entirely.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 15 ---------------
 pack-revindex.h |  2 --
 2 files changed, 17 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 0ca3b54b45..16baafb281 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -189,21 +189,6 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
 	return -1;
 }
 
-struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
-{
-	int pos;
-
-	if (load_pack_revindex(p))
-		return NULL;
-
-	pos = find_revindex_position(p, ofs);
-
-	if (pos < 0)
-		return NULL;
-
-	return p->revindex + pos;
-}
-
 int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	int ret;
diff --git a/pack-revindex.h b/pack-revindex.h
index 5a218aaa66..f7094ba9a5 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -30,8 +30,6 @@ struct revindex_entry {
 int load_pack_revindex(struct packed_git *p);
 int find_revindex_position(struct packed_git *p, off_t ofs);
 
-struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
-
 /*
  * offset_to_pack_pos converts an object offset to a pack position. This
  * function returns zero on success, and a negative number otherwise. The
-- 
2.30.0.138.g6d7191ea01

