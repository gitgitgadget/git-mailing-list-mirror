Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166DEC433E0
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 22:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86F3650CF
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 22:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCFWxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 17:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhCFWxA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 17:53:00 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD864C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 14:52:59 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w1so4821975qto.2
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 14:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRJBYypH3Nw03c9+vH91VmKaNbl28jU0pFrZnE1dOf0=;
        b=j7tA8nEoUzGv7T1XbwumqJZElj12OYYO8WJfJ2oRrW/74aFt/BN4xH4CA7ZIg+VWRD
         nVgkraainJK3THxxi/5sDLhsavTdiyTCjoMCulYMMhlwS5KBX4TR/7vrYUj7R0tviXWV
         koMFqlAKX+ap+Kj0PpnWdelX97pPOGaAT6UcsIR4uOmZ6z+c5RyUeKByUNevlvdWkNiz
         lFaoMHloVngdhRaYU2hmZ+NYRPp91+7r/4mtqmT8ktUvf0uTXqR5DEhUIKruBgjNJZet
         QphKuWbp+/U1bVe4CogA0AC5Lx85L7d6eRPPjw/wgWO2M7gK5VeyOO+RZlj9WAYzUHHR
         P5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XRJBYypH3Nw03c9+vH91VmKaNbl28jU0pFrZnE1dOf0=;
        b=smb5tdILkaKyLApYsYe28mei9lA8PwV5lqmuW7SPUV8rGDYhnjRFK6yHX6559McpM3
         DxG5eS8+twDijbL8nGyYk2YQZr46+DJLstYp4eR4w7GucrhAZ1tdFKV21benW00P2IVv
         LTDPP0UiJCNtIj8ghiNSRS+ncfH+WpUoN+ZRhKfWzuR7yU4alV+zgRSFt1XvCLc3Svjn
         pxvpgBXrF1+hDhU7jKTGKh4D3+enQ2oj7C1/wV8ODhcG2GtYZ4x4VqP08CZOQed310r9
         1DzeAKNSgRe9Q04hXXRTVMu9RZhcRKwUoQZu+RYq8ZF/ZIXZn8k/OTwpkkzTNdKlYUSV
         4fng==
X-Gm-Message-State: AOAM533pYbOTaGrbQq7fLks5tm7+J9dTK81HJm1ySc/kaLld4/7Pd+SC
        NSGAPTe9i7MGCSbbyrSPl7z011aClNStGw==
X-Google-Smtp-Source: ABdhPJybPP/7+dpRRtvw4iVmgKGQcDoG3ZnsrFMoCISM3VF3vJflNhif0f6N07QBOodgZr8isTuuCA==
X-Received: by 2002:a05:622a:2c6:: with SMTP id a6mr14994055qtx.375.1615071178699;
        Sat, 06 Mar 2021 14:52:58 -0800 (PST)
Received: from sidious.home (pool-71-121-201-126.bltmmd.fios.verizon.net. [71.121.201.126])
        by smtp.gmail.com with ESMTPSA id 46sm4776726qte.7.2021.03.06.14.52.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Mar 2021 14:52:58 -0800 (PST)
Sender: John Szakmeister <jszakmeister@gmail.com>
From:   John Szakmeister <john@szakmeister.net>
To:     git@vger.kernel.org
Cc:     John Szakmeister <john@szakmeister.net>
Subject: [PATCH] http: store credential when PKI auth is used
Date:   Sat,  6 Mar 2021 17:52:53 -0500
Message-Id: <20210306225253.87130-1-john@szakmeister.net>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already looked for the PKI credentials in the credential store, but
failed to approve it on success.  Meaning, the PKI certificate password
was never stored and git would request it on every connection to the
remote.  Let's complete the chain by storing the certificate password on
success.

Signed-off-by: John Szakmeister <john@szakmeister.net>
---

I'm not sure if certificate passwords were not stored for some reason, but
searching the archives I didn't see a mention of it.  Hopefully this is
acceptable.  I did try this in an environment where we have client SSL certs and
this made the user experience much better.

 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index f8ea28bb2e..440890695f 100644
--- a/http.c
+++ b/http.c
@@ -1637,6 +1637,8 @@ static int handle_curl_result(struct slot_results *results)
 		credential_approve(&http_auth);
 		if (proxy_auth.password)
 			credential_approve(&proxy_auth);
+		if (cert_auth.password)
+			credential_approve(&cert_auth);
 		return HTTP_OK;
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
-- 
2.30.1

