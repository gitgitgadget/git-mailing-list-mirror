Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D797C43603
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E32764F95
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 02:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhCLCko (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhCLCkh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 21:40:37 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C639BC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 18:40:36 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a9so22900372qkn.13
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 18:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n26sVKGcl8MBVOHPLBMTGmaOg1VRdmAEe2TfBL/4s8M=;
        b=r2u6dUDZnnhC7JBJ37yBtzicrYjXmH2HOaN81W5fEi9Ixz5VYDiGmhkT/Rs6wGe/hI
         QmvLrzj6zs/W37Cbm76abx7v6bIPNcJtkZEdtAqi1dQl+MWcW4TtTSRtHmKK7kg5T5pS
         8Y9dka9/HYR+wVkgLZ0VL3gU2RvcXZ7ZYPZjSR2n4KY/MuKS+ZNGD1CrZ5Ar4zhPh1fG
         +YEydcI+6enKVMsjO4+BakZKyO/tgmyRGFC/bPvaQQbdHrAIZYsCIbLCFU1T/fH+epPR
         beP1jCmUPqqYh7qmi3v1G948X1bVpw0sRJNllM2zQAI+9ihD7ElCJ+PEckO3/wOPUIid
         6CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=n26sVKGcl8MBVOHPLBMTGmaOg1VRdmAEe2TfBL/4s8M=;
        b=XO6XF22lFh/i9rvGYCfUGP5ljCDUxBfABdrrpxWyYXwp54VPkwPGZ95mYNXVIvsmnU
         dBAM63ZFs6q9f3MKbQIa7ELLwOXwPeJ6ojUvu6EgU78RfjvccWs1Us7bAizBuLxLq9fi
         BJ39cLpX8Ulla7LsdA3vH7XGgFkuL595nq0XIzHiHuqZwTg1jV+GC6yEIEGjnBofhK6R
         +C59SpbvI8mCEbrra+Lwr+lHgaP4pcVGX7jtslr4z7xLRUJIt7ZWgGl0m0NAIXps28yq
         xIA8mS/GKqHJeZHz8RtXBdeUbTXERYlrGVE57Zdwo2YEl/MkucI34XKytJxaTsypQ8cP
         73Pw==
X-Gm-Message-State: AOAM532PODS/+u9ze0vqxKnTBhV+imb2mOspKRv2p/mWEvYwXF54lw8F
        ts3gKZ1HAmHuPwrzKMdbH9KcZWP6Hcg=
X-Google-Smtp-Source: ABdhPJzMC/Zv4RR5vRLp8ouxCBqaM47Jx8a1y/yYpUqfKlZL6B6VdfgQbN5015fxnXspq3sk8SZaOQ==
X-Received: by 2002:a37:78b:: with SMTP id 133mr10821677qkh.109.1615516835748;
        Thu, 11 Mar 2021 18:40:35 -0800 (PST)
Received: from sidious.home (pool-71-121-201-126.bltmmd.fios.verizon.net. [71.121.201.126])
        by smtp.gmail.com with ESMTPSA id j18sm915339qtl.83.2021.03.11.18.40.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 18:40:35 -0800 (PST)
Sender: John Szakmeister <jszakmeister@gmail.com>
From:   John Szakmeister <john@szakmeister.net>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Junio <gitster@pobox.com>, brian <sandals@crustytoothpaste.net>,
        John Szakmeister <john@szakmeister.net>
Subject: [PATCH v3 1/2] http: store credential when PKI auth is used
Date:   Thu, 11 Mar 2021 21:40:26 -0500
Message-Id: <20210312024027.33418-2-john@szakmeister.net>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312024027.33418-1-john@szakmeister.net>
References: <20210312024027.33418-1-john@szakmeister.net>
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

Likewise, we also need to reject the credential when there is a failure.
Curl appears to report client-related certificate issues are reported
with the CURLE_SSL_CERTPROBLEM error.  This includes not only a bad
password, but potentially other client certificate related problems.
Since we cannot get more information from curl, we'll go ahead and
reject the credential upon receiving that error, just to be safe and
avoid caching or saving a bad password.

Signed-off-by: John Szakmeister <john@szakmeister.net>
---
 http.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/http.c b/http.c
index f8ea28bb2e..60d01c6e83 100644
--- a/http.c
+++ b/http.c
@@ -1637,7 +1637,17 @@ static int handle_curl_result(struct slot_results *results)
 		credential_approve(&http_auth);
 		if (proxy_auth.password)
 			credential_approve(&proxy_auth);
+		credential_approve(&cert_auth);
 		return HTTP_OK;
+	} else if (results->curl_result == CURLE_SSL_CERTPROBLEM) {
+		/*
+		 * We can't tell from here whether it's a bad path, bad
+		 * certificate, bad password, or something else wrong
+		 * with the certificate.  So we reject the credential to
+		 * avoid caching or saving a bad password.
+		 */
+		credential_reject(&cert_auth);
+		return HTTP_NOAUTH;
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
-- 
2.30.1

