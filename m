Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12A7C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 00:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0E264F94
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 00:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCLAtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 19:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhCLAsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 19:48:52 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D3C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 16:48:52 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d20so22750126qkc.2
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 16:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GKtp57NUtiNloa2g6AuEulN4dPVTUnQK96rM0HIGdZQ=;
        b=UTF+FXljyp+KXk81qKwNlSjWGvOfH4HPjsTjeUklkDngUZIu+QAUX/LFKCxCMNozjR
         t6EeGXD1HDD1z4gv0UMsX1ZBuI08i77DcAg0H49fREnNZHV0js5Ota9G09ixb+LxLZZ4
         IW40UwH3XMZqend96w7ldodxb6/nEABtaIakD7e4112C6a7okBAYgxxUr5OInU9Lb4z8
         EqT5EgtkCCfETBy9kzzNDzXBYGMhWdGPvfUrG0YsxhQdMT4XJPvdHIg06Aw5A6WBUnn5
         4oak+4ZHw79OlWuyUkhErEycdqegp2jS3H4COBNjIwoR0qePVd7kKJ7KrXvFzi9iLwlz
         j8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GKtp57NUtiNloa2g6AuEulN4dPVTUnQK96rM0HIGdZQ=;
        b=T9ufkyAg6eCwZs4FAaqiTYlipfduu3pf07PoTRilvkTMvz5LjuMCurT4iFv+jAtqOv
         muW04EyA5TduS2lrpNleBpWyDtFXlBDfWopOAITmvEVW/RKnjmGHjljOzj3xTrCsslzv
         J2qo5Dx9G7w0NwLF4PrwDfxprAwvC6M74ZWeKrTdI/WryN04IUuTBCsk/M5yNyqnKN9N
         1XXfLD/e3D0BCbEnBkGYEb3SHAQyw1LOVP9ZQVSJzXruP0l9U22NbAXWRffoR7NhJwpE
         rMuHJpJ1menLFB81miOx/k07sfoPKVfDIDIS38F6fIwKJpD5vMMrcN4Q8aljukND+0q9
         pJ9Q==
X-Gm-Message-State: AOAM5330i+gx+4he83k3eIcVShZlQwT30HLiRJYf6pnjV+xEmENfnfvP
        4gITN5hUcusxPaTRNwbAz9keoJDTWLg=
X-Google-Smtp-Source: ABdhPJzXp69G5RxPd8RzO6goH4XLWw+0orRuAred4mb6GVcRgIVw370TP7KE5dE8HGZP2AiC2B2nxg==
X-Received: by 2002:a37:a408:: with SMTP id n8mr10167692qke.6.1615510131601;
        Thu, 11 Mar 2021 16:48:51 -0800 (PST)
Received: from sidious.home (pool-71-121-201-126.bltmmd.fios.verizon.net. [71.121.201.126])
        by smtp.gmail.com with ESMTPSA id i5sm3297092qkg.32.2021.03.11.16.48.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 16:48:51 -0800 (PST)
Sender: John Szakmeister <jszakmeister@gmail.com>
From:   John Szakmeister <john@szakmeister.net>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     John Szakmeister <john@szakmeister.net>
Subject: [PATCH v2 1/2] http: store credential when PKI auth is used
Date:   Thu, 11 Mar 2021 19:48:41 -0500
Message-Id: <20210312004842.30697-2-john@szakmeister.net>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312004842.30697-1-john@szakmeister.net>
References: <20210312004842.30697-1-john@szakmeister.net>
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
index f8ea28bb2e..12a8aaba48 100644
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
+		credential_reject(&http_auth);
+		return HTTP_NOAUTH;
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
-- 
2.30.1

