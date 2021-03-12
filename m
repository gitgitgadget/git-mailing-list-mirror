Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21239C43381
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 00:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0280864F94
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 00:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCLAtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 19:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhCLAsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 19:48:53 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C25C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 16:48:53 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h13so3509861qvu.6
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 16:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0p7/1MWL6NVS2WEBS8f2eyH0zwo6EJc6dEPpoPFCoQ=;
        b=fi2cC3uLya95yK/rHRbL4/m1o6SlACUw+994Ri3BL+Cu/NBb4u+EFubpMaJsTWZxC5
         XdsCRpihSZDcna9kTXRRLeL6K4SBTDw+z05eVCQQql5dEFSZqfkn3TlQguRVyIuRzeVY
         OE/+NK+mJUovRENeRKOHJyeFiNy6Xpg2eWpqZ84buAzRDdLyyQ9VpyIWlE3vIwrthpnG
         1c9UJRi6ZpGkPQG7chEUrIpQI40o0w9GNzGdV7N+QFgHnfmLFiTa8dI8fcsBwpG5htqr
         C+LtCAt8itGFECKVlkKoUrhHx/dUzylaQqQ2Bg8nWxrWKXZ5+aErAHrxMNbb6fcVl10a
         53Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m0p7/1MWL6NVS2WEBS8f2eyH0zwo6EJc6dEPpoPFCoQ=;
        b=PNiyri5wQLgkPcdFAL8GyQq1q7n7ZB+FxO43nyRX2bWF6xDHiWo9jG0SA7JFPfYrUW
         SqjQY5q3X3/rdtVnV0TKw9Fcv8PVNXit8yADdALsGJ4x4cNCSIQLGZzAL4PGBO7gmVKc
         kudutyU7FIG92QFAi1CdfxGZ192q/IYdAg7niempSDG/mxvsVd0JSDqUXtEdmmNXqDXu
         Oe2Ukkz0vtrGOH4+mIf65r5s+W3liW8h9+p6UXh2EhUyLw6u+jIZinSl+Zxul2IOXhBP
         y5iQFUxMZNgrpDMTdN+btdhd2rmTbWaiyLw5f0Q3Jzy5AsQzsdpb7BaHqgfWDM5dmmS6
         fJZg==
X-Gm-Message-State: AOAM532IYyk0ajliVEaZYMVxpoVDyrM+HiBak9DTy508P4DH/vHWg75a
        3f8Shu1utmxveZ6ahvg0RszbZ0lziBo=
X-Google-Smtp-Source: ABdhPJx3Sdf5/jvHRp6OeI7LrcIkD3Pjamoe0Kiy/bMQD70EUppKd7l9oanPEfjhBxPvFy5ldIKSDQ==
X-Received: by 2002:a05:6214:262a:: with SMTP id gv10mr10428610qvb.50.1615510132386;
        Thu, 11 Mar 2021 16:48:52 -0800 (PST)
Received: from sidious.home (pool-71-121-201-126.bltmmd.fios.verizon.net. [71.121.201.126])
        by smtp.gmail.com with ESMTPSA id i5sm3297092qkg.32.2021.03.11.16.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 16:48:51 -0800 (PST)
Sender: John Szakmeister <jszakmeister@gmail.com>
From:   John Szakmeister <john@szakmeister.net>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     John Szakmeister <john@szakmeister.net>
Subject: [PATCH v2 2/2] http: drop the check for an empty proxy password before approving
Date:   Thu, 11 Mar 2021 19:48:42 -0500
Message-Id: <20210312004842.30697-3-john@szakmeister.net>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312004842.30697-1-john@szakmeister.net>
References: <20210312004842.30697-1-john@szakmeister.net>
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
index 12a8aaba48..b0d3ce6c6b 100644
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

