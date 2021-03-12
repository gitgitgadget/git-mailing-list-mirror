Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEE7C43331
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F76664F87
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhCLCkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhCLCki (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 21:40:38 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE5C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 18:40:37 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id u7so2777372qtq.12
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 18:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lskDvGLoFWjqUEP/DLwE04dFCY4oC17ylUkYfpBTwXc=;
        b=OpJoNKCkGel/m4D6Y40nbvxc2yTEPqZCh0VJQwkaweFKPQ5Sh1sNKgPZm85AQ7sZlW
         wS0FXBXbVYtXQ6nlGUCtQptH7zN9UIfmvmVc6FbUbrTrS135qflgBQLNhcwvNNFB/r8e
         gTWe+XAbA+PCxPPWvfyChqCL6XsQsWvIPmFijtQJhrIBCAzhEf0ayvdbdKKsid4KyBUh
         VLy4jRaqHh60sMJ0iA7OiRJAtXAvm72+FNan+wHdX0U/Vus6CUcQk4bJPW2Xe6qJ++HR
         O3ihq4SwHDaGX++8L19JjHdzJSUpkY7ZLsmSrAjZsC3PijjuldqbWC7H621bmSLuokiz
         vK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lskDvGLoFWjqUEP/DLwE04dFCY4oC17ylUkYfpBTwXc=;
        b=PQYZ0rqWGk/+Me0sRrBqHORa+rMiwMyH/tkytVyJx/d5SLGYMPqaRHPaCGmas63uJ5
         0oeSloOcgDwczzxCX/cnw2DtT6dNol/xQtMIIeo5tk5zK+Op+Lcid36kOWbYpUBZ2uSx
         lIYKsQNkrScmgEbP0/7IiQrUivSm0qxUU2A2pLWCSI+lEq3gFSNL842rRhUYbR8XRL8E
         WFOKYhtSLfd4LxRzUjFWRmQ+XO4iyDVAMU1w46I4vjhX4Kgk8qfBOKpdXFbzW8ndEgk4
         0mObeOf8LwojaTkasMiBvjAB0dbMbLCxYR1HPR640+zF/fAjC6q/JFlGUvqPVwhXPAYq
         MEgQ==
X-Gm-Message-State: AOAM530xlV6wd9+KJIx1wfHctLfa75gyr2ECzjwaUekqW/8lZaWvyQkm
        XzfCddYm4gbra+2svOk5bX13GxsGODM=
X-Google-Smtp-Source: ABdhPJyXXBsF/XSEC2/QJtO0x0frfjPr+JRY4VCICGq1lk3Dwp71I1/ux+EFFYOg8zwZurtDNS0pjg==
X-Received: by 2002:ac8:4406:: with SMTP id j6mr10108273qtn.180.1615516836608;
        Thu, 11 Mar 2021 18:40:36 -0800 (PST)
Received: from sidious.home (pool-71-121-201-126.bltmmd.fios.verizon.net. [71.121.201.126])
        by smtp.gmail.com with ESMTPSA id j18sm915339qtl.83.2021.03.11.18.40.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 18:40:36 -0800 (PST)
Sender: John Szakmeister <jszakmeister@gmail.com>
From:   John Szakmeister <john@szakmeister.net>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Junio <gitster@pobox.com>, brian <sandals@crustytoothpaste.net>,
        John Szakmeister <john@szakmeister.net>
Subject: [PATCH v3 2/2] http: drop the check for an empty proxy password before approving
Date:   Thu, 11 Mar 2021 21:40:27 -0500
Message-Id: <20210312024027.33418-3-john@szakmeister.net>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312024027.33418-1-john@szakmeister.net>
References: <20210312024027.33418-1-john@szakmeister.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

credential_approve() already checks for a non-empty password before
saving, so there's no need to do the extra check here.

Signed-off-by: John Szakmeister <john@szakmeister.net>
---
 http.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 60d01c6e83..3aeabf0947 100644
--- a/http.c
+++ b/http.c
@@ -1635,8 +1635,7 @@ static int handle_curl_result(struct slot_results *results)
 
 	if (results->curl_result == CURLE_OK) {
 		credential_approve(&http_auth);
-		if (proxy_auth.password)
-			credential_approve(&proxy_auth);
+		credential_approve(&proxy_auth);
 		credential_approve(&cert_auth);
 		return HTTP_OK;
 	} else if (results->curl_result == CURLE_SSL_CERTPROBLEM) {
-- 
2.30.1

