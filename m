Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF60AC433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8307264F2A
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCRLYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCRLXu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 07:23:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ABCC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:23:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w8so2744867pjf.4
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x048f/Gq9uLH7xS8jFzPGbGsKU22E/jLA0lveci/I1w=;
        b=KxG9ucfYnprYx02yhcUml1g/L8SbTMW8oBulZUw2UD+5v3pNyjuL9bWokbh2Qa5Xq4
         3i1rV4JoOEu69aHCnb0U3yWKGOlX6pGM0nYEp95R2m7gQy0tEoofBzx6sDo5eS+NMdzT
         EPfaUmGKjhDZZC3fxpgRJVVTVRLxQTgdEZi8/8tBpMbu37gn5LrGAXy4riC/1x4D/bpV
         GBqJ7bcYuVdnmSDfOarw5xMy3RJzlYdi2QrBhiDaOleyUUs4PO5Hwwa0MeFZpAuC7o9e
         U2p8Z8s0MQGxNZwCrHY0prlpOMrtdJGdtclaUvmelst7FrEg9YEiATu4NaFo/+F1qJV2
         JjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x048f/Gq9uLH7xS8jFzPGbGsKU22E/jLA0lveci/I1w=;
        b=PbebrRti3diC3GHda7vCiConDDBXcLn6l9Gv/J5n5aDQt91LKGrStNOeSoO8sNpke4
         BCQpevcMkQs3CK9Om34CgRwi22uU+JxRZC7y7HjUFyTml5aIyvrTwRWTNKM1YcsLIs/+
         jnzKnKfyQCfQkpeR/QYNHyBPbhczcAsZC6EUw6NEc/vixiSWSPBbCLCipGbQ3qRCdp2s
         bqOwDjp3ZVveNs6BdAsohXHOrl5lBFlZb7HnnH7XXtgr6xG4RFITZ/9MrTO5XTApotw2
         Xm50DvL68WixCaTpiBs1WxT2kf6wb512WDpqgkIh2o1sRxr4DYBDS8EIeGmATSxS9Id1
         i7TA==
X-Gm-Message-State: AOAM5327qEq0SLRD7tyBOzuRSZjGHiWvfybejIP0M6Vd/e12U1LTR9Rv
        ytfuOHNzg3rPlpSBeHcnke9I9Zr8cWXWBw==
X-Google-Smtp-Source: ABdhPJx62H7AiiicUl9HHgvrbKq9dAAAqrSzHl1yWykY011ovdM+P+SCGCMxRMKaYeVbcWZrpBN2AA==
X-Received: by 2002:a17:90a:8505:: with SMTP id l5mr3797696pjn.100.1616066629021;
        Thu, 18 Mar 2021 04:23:49 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-92.three.co.id. [180.214.232.92])
        by smtp.gmail.com with ESMTPSA id 25sm2176828pfh.199.2021.03.18.04.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:23:48 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] INSTALL: note on using Asciidoctor to build doc
Date:   Thu, 18 Mar 2021 18:23:39 +0700
Message-Id: <20210318112339.38474-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note on using Asciidoctor to build documentation suite, with example
for build documentation in html format.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 INSTALL | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/INSTALL b/INSTALL
index 8474ad01bf..3a67f335e0 100644
--- a/INSTALL
+++ b/INSTALL
@@ -239,3 +239,9 @@ Issues of note:
          http://www.oasis-open.org/docbook/xml/4.5/xsl/current \
          /usr/share/sgml/docbook/xml-dtd-4.5 \
      /etc/xml/catalog
+
+ - Alternatively, if you have Asciidoctor installed (requires Ruby),
+   you can pass USE_ASCIIDOCTOR=1 to use it to build documentation.
+   For example, to build documentation in html format:
+
+       $ make USE_ASCIIDOCTOR=1 html
-- 
2.25.1

