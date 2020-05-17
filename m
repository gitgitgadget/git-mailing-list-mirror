Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F61C433E1
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B615E20809
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmWw6Ynw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgEQSwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQSwe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:52:34 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0EBC061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x27so5970385lfg.9
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UDDy15KOhZVRdLG9nEUOXBdRcAWX1wCCsMxIiwnlYog=;
        b=SmWw6YnwulUGZyeDagM4HqCwQEtWRPVfTuv02RfiagaTGSnF2bBHVm1gYOZySE/LWb
         dgad/bm2N3Q5fCwoV1UEEcu5fExXt39x0Vl4vFCgcGsEjacDAAfPcH8brV452xXz8+Vc
         XAo8grMBCfnTyAnnJxQEP+a+MTOkKH6czpHxrMsuMautQbtI+xLJ0V063WFgDue+/Vkq
         zaerNuw09c7Ts7mOd1tGYmbyO2rkalq6F/2rFU8kH/CCA6J4pmoVIMO0eT6AfxKytcru
         2OFMWxCjdJo4GXGRtU0FJcHCPSnPiQbOesQV1Co3M60MJur/GRwwxZpcwrK+Vwy0Z52v
         oUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDDy15KOhZVRdLG9nEUOXBdRcAWX1wCCsMxIiwnlYog=;
        b=EuVJX7jLs4jn3hfQ5ueRNrAwUO9u10MgFrN2n6Orr9vQ9PQrl9kIbdc8wbBXzPFeSq
         nxqGbVlaruuZh9CNgYcCb4qdEIEMikUS8VW30CgOBEa4r+gj3kjchARxIH8dxYGsA0+j
         rUaWIucsGFd9CC4tdUyERCII/fwqfTtE4QyzmTpaUgwLGlNkSJtAbKbWev3jfxYmH+7n
         rX+H5Dh+UJLPPxk7lUZo9f4YnLaEUWfhDHYOc32x610HE9+eY86nxysiEgIFIbzMwse+
         AvUz3NtnHYxnXEtWZ2k6s/ToiYjoGH2vmW9jtskO0wuf2xobvvTrOxYVLTWHgUUNVi3e
         xF2A==
X-Gm-Message-State: AOAM5311JNnJP75SnpQPHZ+aebsaWO7Gpq4tQxmaHyYENQhEbke4Ljmd
        Lw2b1UtExzyJ8iNAsluO75f2/Woo
X-Google-Smtp-Source: ABdhPJxQPwSOh2ishVFYf4nfCVzkNdYZL1eZaZ5NNBhgRC6OqHyo9gQi5uTDX32ma1NdOBH+nvhpXg==
X-Received: by 2002:a19:990:: with SMTP id 138mr4093868lfj.135.1589741552340;
        Sun, 17 May 2020 11:52:32 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a12sm4513938ljj.64.2020.05.17.11.52.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 11:52:31 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/7] date-formats.txt: fix list continuation
Date:   Sun, 17 May 2020 20:52:16 +0200
Message-Id: <63c07d03a471addff3e98bb7ec669f7224cf6e24.1589739920.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <cover.1589739920.git.martin.agren@gmail.com>
References: <cover.1589739920.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The blank line before the lone "+" means it isn't detected as a list
continuation, but instead renders literally, at least with AsciiDoc.
Drop the empty line and, while at it, add a closing period to the
preceding paragraph.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/date-formats.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 7e7eaba643..f1097fac69 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -22,8 +22,7 @@ ISO 8601::
 	`2005-04-07T22:13:13`. The parser accepts a space instead of the
 	`T` character as well. Fractional parts of a second will be ignored,
 	for example `2005-04-07T22:13:13.019` will be treated as
-	`2005-04-07T22:13:13`
-
+	`2005-04-07T22:13:13`.
 +
 NOTE: In addition, the date part is accepted in the following formats:
 `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
-- 
2.27.0.rc0

