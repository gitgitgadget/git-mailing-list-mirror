Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7268EC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 06:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EACF20757
	for <git@archiver.kernel.org>; Sun,  3 May 2020 06:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTU/YCH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgECGkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgECGkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 02:40:16 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857DC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 23:40:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v2so5482633plp.9
        for <git@vger.kernel.org>; Sat, 02 May 2020 23:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lK929CP0XnNCK+D3SDYu86GBzQBL7ZKCFk1ja34dLGU=;
        b=mTU/YCH9EJlYJru53mhw69JebK3mogEk7b5YcG4OWnBNWOMxOv4D0kDRK+2/ssMI+u
         StTevo8TeO6jbd+L9CR4TLGg9k1gEaMYuyN/h4HtDXkhOHTnq33m23bZRoWX4PKkRZaG
         W+4JC5C2r5NypBkhuu1A6+/g6DPlWmcgheEszXHogZLI9WYCjQ9P6nhoPbXmHjXg+tnm
         rIydUJqL9/OU4RfWAg9RoB+OPSpnBGTZBy0tRlhqr/bt6LeZXDLxKIx2YbW8iHPS4Msk
         N1DxHTxh75CgQtZHuGmq7BWu7zsGpmxNO5LNFuj8qtwNPy/Y1J8OivMkAB9VwH5+6F75
         rgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lK929CP0XnNCK+D3SDYu86GBzQBL7ZKCFk1ja34dLGU=;
        b=TAm45Ijkj0qcubvw7XXDDyEVUXAsM+B/SVHL/2/R/kO1YbZiwyOgcvLzEnUOCrthjA
         9HuZ6ALspoAQ4+WbO0NWCd5aDaw8ZmlyFrYYcjaU7jdAzSzq7AINF+3/T31x4ET2+PCC
         x2Zw4B7YTETPSCcIbCy7iAA1/5e2U17GRhsLs8qI5nk754oFEPORtCR1FDlu+qUl3vYj
         GIyC7dQpYECaOljAXKGp7wJ8ZEV5Bc5R948BXVB96+/JXnshojBXrsaSapfJyLt8NHjd
         CWh5T45M1cm2bCPyLtfUKLwBEotCGdN4EnOqQLWJyBCzuUeYegD4TQ9jwT4GHoMQIbs0
         3EOQ==
X-Gm-Message-State: AGi0PubPA5nuvoBsVXXvbxSrTN8OYTXr1JysJFafZezLU/fplnCk2ymH
        mNVcNOQtbpE28uGhNWhVbzxtULRU
X-Google-Smtp-Source: APiQypIEK6QrsiDnCe0A1cVn8uDqVFnLj4gXAfyjP5ti8bL9UKPohgFxXcZgNNhsy2udMk1YRM0XtA==
X-Received: by 2002:a17:90a:30a5:: with SMTP id h34mr9408839pjb.171.1588488015233;
        Sat, 02 May 2020 23:40:15 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e135sm5866547pfh.37.2020.05.02.23.40.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2020 23:40:14 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH] credential: minor documentation fixes
Date:   Sat,  2 May 2020 23:34:23 -0700
Message-Id: <20200503063423.83152-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c44088ecc4 (credential: treat URL without scheme as invalid, 2020-04-18)
changes the implementation for creential_from_url_gently to retun -1 if
protocol is missing, but didn't update this blurb.

the order of parameters used in credential_match was inconsistent
between credential.c and credential.h as well, so update both to
match the current implementation.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 credential.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/credential.h b/credential.h
index d99ec42b2a..c0e17e3554 100644
--- a/credential.h
+++ b/credential.h
@@ -177,8 +177,8 @@ void credential_write(const struct credential *, FILE *);
  * Parse a url into a credential struct, replacing any existing contents.
  *
  * If the url can't be parsed (e.g., a missing "proto://" component), the
- * resulting credential will be empty but we'll still return success from the
- * "gently" form.
+ * resulting credential will be empty and the function will return an
+ * error (even in the "gently" form).
  *
  * If we encounter a component which cannot be represented as a credential
  * value (e.g., because it contains a newline), the "gently" form will return
@@ -189,7 +189,7 @@ void credential_write(const struct credential *, FILE *);
 void credential_from_url(struct credential *, const char *url);
 int credential_from_url_gently(struct credential *, const char *url, int quiet);
 
-int credential_match(const struct credential *have,
-		     const struct credential *want);
+int credential_match(const struct credential *want,
+		     const struct credential *have);
 
 #endif /* CREDENTIAL_H */
-- 
2.26.2.686.gfaf46a9ccd

