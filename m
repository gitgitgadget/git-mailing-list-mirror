Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAD1C4724C
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A326206EB
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW6YSFtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEEBjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgEEBjl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:39:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679AEC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:39:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so90807pfb.10
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1mIXTyxQXGDDIcHxeiomhmFzzers4Cd+5PsN1wDPv4=;
        b=SW6YSFtAhXUE5zxhLK2uaco5gdc6vTJO/8aUhjQIRr/bomq8LYlPQTW4mHweMjPqpC
         je5J2aAJNLqr562CkzSEH0f57wE/KUyEV5M1Wl1syUFGLCagQueVQPbj96TdOqplCQAk
         H5zKyB5xEqttXqvitL+qDhD+9WJTUUHhThBGhyxNEaQL5H5wCYCUiUjfzwGPG6tHwD9B
         KW4xVKXWVpOgc7iTTA9cfZefGYeegxqYIWMxsBXu4UfhpQwMZ0vHxrwcszMZHQPDKBBb
         ctj8eqLeWe6ib6+e6kQcUKkfQWce86d9jdLwZWyICm84no3+wA+aZbnr7CL6hPNErjg5
         59Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1mIXTyxQXGDDIcHxeiomhmFzzers4Cd+5PsN1wDPv4=;
        b=k18bt31tmJrPRip+fWsAw4PEOj9skxZlcIBarETBPhWGkrCLwJfCleY00Y7WPOhHBW
         8b3RiNz4mNtOobrnPFgDhvrX4m96RBte/nDaBgww7VaaiFhMqRFQRNPtNYZv+HHDYf/V
         t0xfImQ5Y0jViNOBMfLvv8rY/h4Lr+I4dKAYvQooKE7Y5zswp68tPw6JQZ+d9gDTlEXq
         P1repLHz19iVcafdH9VWdO51YUk1V4BpPTdEZvXhRf+lc9Lf/uchZzH1I8e9UUdZE9GZ
         TIRTqo+gpeFzomqiHWLKl42Vnvrm+QNX77/qpHj/hEy69W+lND5p6us7YGAsRt3E7Ntr
         CEkw==
X-Gm-Message-State: AGi0PuZS2KkLhB8qNrU4PK9RPE+RaucZtrsfAgC/gAlEMFX/u8Sx6hDx
        e2gSlaeDnEPdHT8d+Et4C1OUV4rW
X-Google-Smtp-Source: APiQypJK2h9y2+mL5KRbykAP3420LZBYkhvIuQLQ2T09l+kOEw62d+6s9i7ofjtrw1renxoukF5omg==
X-Received: by 2002:a62:e418:: with SMTP id r24mr791327pfh.86.1588642780571;
        Mon, 04 May 2020 18:39:40 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e196sm352027pfh.43.2020.05.04.18.39.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 18:39:40 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 1/4] credential: update description for credential_from_url_gently
Date:   Mon,  4 May 2020 18:39:05 -0700
Message-Id: <20200505013908.4596-2-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200505013908.4596-1-carenas@gmail.com>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c44088ecc4 (credential: treat URL without scheme as invalid, 2020-04-18)
changes the implementation for this function to return -1 if protocol is
missing.

Update blurb to match implementation.

Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 credential.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/credential.h b/credential.h
index d99ec42b2a..f51703d9ce 100644
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
-- 
2.26.2.686.gfaf46a9ccd

