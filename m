Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F91C48BE8
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF1C6120E
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 05:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFLFJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 01:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhFLFJf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 01:09:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C084CC061767
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 22:07:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id go18-20020a17090b03d2b029016e4ae973f7so6031783pjb.0
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDvkqKAP02zdZLedVil9jxXwlpY4r1clMGPusyALi8A=;
        b=rN9YNM2aoAJW8vRSH63h+ZN7DA7jN9JJzIFLwWNtyqN3nzjXiFuamqTWunGBw6QHi5
         DR9XmpU0wR1d48mrBJ3I+7Xid/rl0zhlg0IMkdOBj30/RrSHJ4AFgQp2lLUuJCvmXONK
         2fSK7m93gbiPFm+fMBaqn1ROVRlUXC5aQzNaNcAVZL5oy7LRw0jt3EvSdm4A6CKDQJ8X
         s6y7MG3N4NaHYkNEoiVJRxw0YC2Ak+kTrF30KYrJmibR/Q9EWZV6mCvXmkKvy2t+ZOBM
         3cKGgNd1NSGvKq864W0XvmP4D2lAPOXuI4ap7DG9sTToi4Lz4Ux54M1akNURgJyQiXPS
         7XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDvkqKAP02zdZLedVil9jxXwlpY4r1clMGPusyALi8A=;
        b=ooXWMrtVQut4v4zPpdTLPnE379nE/ABMptaIA3FcOajLPauGixJcIfhgajCuihFXRg
         AYcjZqXzepqUoV0VgNKZRGHlYkA+uBQ3gR2fFO+Y5ARSBBGs4ruP/JS7YfclcDllnvZE
         5a9FzxKzNdWCEHH0z0EDdK67GIOQjsJ2+440FEfLmEfqpQ786gq+sgp9wh1y/67hqmS1
         GyZhQvD3EAslq4bMdYQ9vtvFhz2Y+fB/tniGIpRPGD8oTsq3d9Ztn4AIyvs2SIeHw6iR
         aZYOwL+FpnyEfNhXWh+ef/QRQaz2BTaXmR2fLUpgjyC1/6u4iRpBfYCDZldd1rivs7W1
         5/gw==
X-Gm-Message-State: AOAM530sm3tdCsA9MEYocrZZgImQBUpWVgOJwRotIEeVDRaVJUUnkYLp
        tBOzYBl+IXRC6hrKf0ORXyI=
X-Google-Smtp-Source: ABdhPJx/yXKQjHdejE4nLRHsTXd+wfmKUEya9z1WZrYgfDKJtQINYxaHM7OeSjZnXiLPV54A6MWzBQ==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr7948216pjb.154.1623474438864;
        Fri, 11 Jun 2021 22:07:18 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id n23sm6651745pff.93.2021.06.11.22.07.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 22:07:18 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/4] sideband: append suffix for message whose CR in next pktline
Date:   Sat, 12 Jun 2021 13:07:10 +0800
Message-Id: <20210612050711.4057-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <87im2s5jjm.fsf@evledraar.gmail.com>
References: <87im2s5jjm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When calling "demultiplex_sideband" on a sideband-2 message, will try to
split the message by line breaks, and append a suffix to each nonempty
line to clear the end of the screen line. But in the following example,
there will be no suffix (8 spaces) for "<message-3>":

    PKT-LINE(\2 <message-1> CR <message-2> CR <message-3>)
    PKT-LINE(\2 CR <message-4> CR <message-5> CR)

This is because the line break of "<message-3>" is placed in the next
pktline message.

Without this fix, t5411 must remove trailing spaces of the actual output
of "git-push" command before comparing.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 sideband.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sideband.c b/sideband.c
index 6f9e026732..abf2be98e1 100644
--- a/sideband.c
+++ b/sideband.c
@@ -185,6 +185,10 @@ int demultiplex_sideband(const char *me, int status,
 
 			if (!scratch->len)
 				strbuf_addstr(scratch, DISPLAY_PREFIX);
+			else if (!linelen)
+				/* buf has a leading CR which ends the remaining
+				 * scratch of last round of "demultiplex_sideband" */
+				strbuf_addstr(scratch, suffix);
 			if (linelen > 0) {
 				maybe_colorize_sideband(scratch, b, linelen);
 				strbuf_addstr(scratch, suffix);
-- 
2.32.0.rc0.27.g7b1e85181b

