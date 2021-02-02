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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4CFC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8419E64F70
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 16:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbhBBQZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbhBBQWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 11:22:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC92C0611C0
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 08:19:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a1so21106596wrq.6
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 08:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EZ4RHWZVjAkBYM+91aqMFDJy3L3W3Or4L2fRZltk7IY=;
        b=kdjzhLzPl2XnTs5i7aC2ZPK/sQSda6naW4Dn+9FTjLjU2FGj+u9ANtskaeB9fqdkuN
         dd+jhza1GQsZ54VRg7Cwh0WNC+UWcmhmI39hZvNAc60bMXYOr0k4sW5XDSSIQuN3Wh2d
         K05nML0+PC60vVf8sERt2XShzqnPyKm5ZqBoo8u0WLQZnDa5XNx40Mg4panDPbc/BFNI
         i4hA7IfmzZA8qgNKn6o8h9mawfJUcE2wdVq2MTI+aTN0DL+YFhm/wtfvnJ0pvFk+cdtH
         dqfmlraiSHPPydMnHGnVBgMZQJOY6HuryTYCJuH0fQIthGXpgcebALFehcRez2C7Xasr
         ZS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EZ4RHWZVjAkBYM+91aqMFDJy3L3W3Or4L2fRZltk7IY=;
        b=aJMvPETDPMuhNVJ61KJyQWAOMiEhYO4vSZBxiK7TwDtC6Z2XJBbiZlkpvLfPHVG4HA
         GEye12coOvs0CjzjuhlI/u7OyQUSEKzHzs+aKkQ2MCZEk9uxKjX8QGfyzzggk7myLkCw
         ttoYXVrRziOFOXAa9mVEKMs4UuWpYgSCI3qUm1E2KHl+n0h3a0vjgSGUvxw6CV+QG6pD
         PnJEtL0uZSFSTvjn0avzQp5Uwd7gdS4YMW58un9FdFtfg1CHDFDeIGuDGQ4TOSDfqrZ0
         K63rQbZ4PcmzXNwWDY15lo3ZNHTTNgNABt/E++epNdZS6RXyKN4viztnbGQFYiJqfp1M
         Qmng==
X-Gm-Message-State: AOAM533p/zichuCt1pjxQE/nrlmHbfka171sKV0y3nRtH7VAYl36+SpU
        kaJdgl4jAc+Ji+B3lhERxHWazmS6CzQ=
X-Google-Smtp-Source: ABdhPJyxve+qfdhA/zSkCOkX6r+OYr7r0cps8Wn8OthkXDYTa3/AXCw3NjHYdwys9+mFT6J1aqOI2g==
X-Received: by 2002:a05:6000:1202:: with SMTP id e2mr12802311wrx.328.1612282756849;
        Tue, 02 Feb 2021 08:19:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y24sm3741006wmi.47.2021.02.02.08.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:19:16 -0800 (PST)
Message-Id: <58295cadffe5e91786da45909b87b280e1f15147.1612282749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
References: <pull.858.git.1612093734.gitgitgadget@gmail.com>
        <pull.858.v2.git.1612282749.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 16:19:07 +0000
Subject: [PATCH v2 4/6] doc hash-function-transition: fix incomplete sentence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Thomas Ackermann <th.acker@arcor.de>,
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
index 2eba25cf87c..86b09ea0f21 100644
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

