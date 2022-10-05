Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9CEC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 09:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJEJG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJEJGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 05:06:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821D066133
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 02:06:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y136so15324182pfb.3
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=lEzIdwLibeDVCbyAjyw8fUQkgTC2Dh0ABtqxd7LRTHc=;
        b=YCeO9VRAQPDErQjXJBiOrj/kk9k9cybUuDmk7myB38tiKctxjg9RHEvTHNRp9K2Wc7
         wpv3O2PdoflpQWZJpfE/ZyykdhMoEMmfFMktdJy0bveAuM+ehrJppVICyABdEXkvb9i9
         NncP7BcLyDDlVOnAc7NUN6N04mZeH0PDcHpKNCm6j50M516nrrhOg8kgSV986OkF10FW
         3UYypHwQXbOS3TBghHDuUdHVIEkhTR5QB5JdjFLN1/yGWpRZvG7Oi5PwMRl+S04r2AHA
         z3PwwBDOoiwYOwFTGi0QNniDH/MXBXJPQN2thdWpeUQ2Qev1Gfd/9NU9gdJ5c74iLbr9
         KPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=lEzIdwLibeDVCbyAjyw8fUQkgTC2Dh0ABtqxd7LRTHc=;
        b=fUyysqMBSUwcevML/pYHKjg6mCTFBE9rt5IkMkAJBn2ETVxpPH6nMEZjXaRpzyRyRL
         CTE/1DphmEj0haODTEzeYp5al3B0G40nOp5TaUl01r2L5wd3ukj/I04nJW5WaVLo4cvN
         RwmvOuzGHwX8SZoE7j82nRqX02ISxrLtfGJLDAcmnrO9rfaAIpRI/nRxu8SDt7xRNBKk
         Ttu1hYp0XpTPHFO5SEFYptMTAFAa/kFutCpjTm2shMkZzs4qUYfTAGW1gx0b5B4yCwFK
         fXe6RqVs6a08dz0zTKtKh8pOiUSP7O59tWan/QTVde8Umm4v9rCKhVHkwRhmlfGdruUY
         NjkA==
X-Gm-Message-State: ACrzQf2u95kwEo+0Sj9EugX89wGBlKVeAA5fKaY8kx3VgStYXTi4uLK3
        XpWhCjLV7+uRw28O8XQX5IUiIRjeO0JU/w==
X-Google-Smtp-Source: AMsMyM4Jb8hyFHzZ7auGoltNzubEy6rUApsxoWu/uX+4zApFev18aDlwmg0knDwW8kvFAYPt95X7sA==
X-Received: by 2002:a63:5466:0:b0:43c:bc41:73a with SMTP id e38-20020a635466000000b0043cbc41073amr27899016pgm.77.1664960812578;
        Wed, 05 Oct 2022 02:06:52 -0700 (PDT)
Received: from a9cefb04fe0f.vcn09250126.oraclevcn.com ([150.230.33.217])
        by smtp.gmail.com with ESMTPSA id cc4-20020a17090af10400b001fe2ab750bbsm781755pjb.29.2022.10.05.02.06.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 02:06:52 -0700 (PDT)
From:   Jeremy Lin <jeremy.lin@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] git-compat-util.h: fix build on gcc 4.4.x and earlier
Date:   Wed,  5 Oct 2022 09:06:50 +0000
Message-Id: <20221005090650.3172-1-jeremy.lin@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 9ff7eb8c88 uses the `deprecated` attribute to display a warning
message when something that is supposed to be unused is actually used.
However, `deprecated` only supports messages starting in gcc 4.5.0, so
earlier versions of gcc end up bailing out with a message like

  error: wrong number of arguments specified for ‘deprecated’ attribute

This commit removes the use of the `deprecated` attribute for gcc 4.4.x
and earlier. As this is just a diagnostic feature for developers, and
presumably very few people are developing on such old systems anyway,
this change shouldn't really impact anyone.

Signed-off-by: Jeremy Lin <jeremy.lin@gmail.com>
---
 git-compat-util.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b90b64718e..9e2969edd6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -190,8 +190,13 @@ struct strbuf;
 #define _SGI_SOURCE 1
 
 #if defined(__GNUC__)
-#define UNUSED __attribute__((unused)) \
+/* The `deprecated` attribute only accepts a message starting in gcc 4.5.0. */
+# if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) >= 40500
+#  define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated ("parameter declared as UNUSED")))
+# else
+#  define UNUSED __attribute__((unused))
+# endif
 #else
 #define UNUSED
 #endif
-- 
2.34.1

