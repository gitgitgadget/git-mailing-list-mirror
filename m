Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A799CC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 23:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiCUXQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiCUXQK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 19:16:10 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BFF446A52
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:04:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dr20so32404044ejc.6
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yxo+3mJUbpGNHPh5RaLbis7sEtSHOcPz/daQdB0IjpE=;
        b=nx2K5Z1w2oyuoKsSWn3eu4csuPR/jX5ZGl0jp52v3pX3lT4U73hk1vs8aazbMS8G4C
         kS5TxOtptR68QU0U0Krg+MwIgW3UBBrAUq8oyNMBLgEspXOEKhHwnYW6ca1ki3Oo/lfQ
         jdWjnqgL96alJxyWkSdntm6I4ML8gA2CoXPxqsYaBCysYxM4Tbf8GDRcyMvud2z26nSD
         7IjVoDQBWryFkfeaCWwaH7nuqGY2LQxDWZpnrphCLDEiLxK6aIzFFvC+/p3N3AY9xaBE
         T5LMFlnAdHy1wpqSaZB1RD6AU1/Cd1fFIbb2GjmlQyCrHRFotNQEHWkRFEwb+b/RJ/6A
         JIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yxo+3mJUbpGNHPh5RaLbis7sEtSHOcPz/daQdB0IjpE=;
        b=TeknjtXVcaozgBkQzBpyt3+DHWDLqCQeC4+XBW6qEWspVW9tvLHfd3kwYqdxXbPA7O
         MlS4TDU08j3sBAIAksdFBX4ZuO/4MnzoooX2jGxQTwcAPBpxq9AGHBFcqTLzmPbYR+Bx
         YJbYehlQHdkorH/GmVeZc0EAvlu03gtA5Gvnn8UesncQ6Aq3MP+rgLzvk6uJH27WKq35
         n6Ef/vBweMhY7mWZADSyiaz2wnJt5lKNXMxBxMK0+OJS8v8l7zzrj/ELdGW5y4yz6lac
         YjgQTMOhaoVOKd7TFJEf0AkjVel3xFGFB+2CmBsqrtWyaV5BNGkHe8hFz2MrwLUdDmMQ
         zOiw==
X-Gm-Message-State: AOAM533qzAi2EzJgDnxHvPtQLLbutPvGpYz/JTwHzkPsP7+GhqFqb5N+
        dinS5RfPDmJXqqfeY0BQ42LM3opSKW4=
X-Google-Smtp-Source: ABdhPJx4VAVBXaIWZKznWS6tKJP1lJp0jkzySvhYQaE8fGWlBy+MY6le4E5vqNdXh0WYoVzvT5htig==
X-Received: by 2002:a5d:59a2:0:b0:204:20d9:a5b9 with SMTP id p2-20020a5d59a2000000b0020420d9a5b9mr871281wrr.560.1647903364291;
        Mon, 21 Mar 2022 15:56:04 -0700 (PDT)
Received: from fedora35.example.com ([151.24.239.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm10022910wrq.44.2022.03.21.15.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:56:03 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 25/41] git-credential-wincred.c: use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit status
Date:   Mon, 21 Mar 2022 22:55:07 +0000
Message-Id: <20220321225523.724509-26-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321225523.724509-1-gitter.spiros@gmail.com>
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C standard specifies two constants, EXIT_SUCCESS and  EXIT_FAILURE, that may
be  passed  to exit() to indicate successful or unsuccessful termination,
respectively. The value of status in exit(status) may be EXIT_SUCCESS,
EXIT_FAILURE, or any other value, though only the least significant 8 bits (that
is, status & 0377) shall be available to a waiting parent proces. So exit(-1)
return 255.

Use the C standard EXIT_SUCCESS and EXIT_FAILURE to indicate the program exit
status instead of "0" or "1", respectively. In <stdlib.h> EXIT_FAILURE has the
value "1": use EXIT_FAILURE even if the program uses exit(-1), ie 255, for
consistency.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/credential/wincred/git-credential-wincred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 5091048f9c..25028cd39c 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -20,7 +20,7 @@ static void die(const char *err, ...)
 	vsnprintf(msg, sizeof(msg), err, params);
 	fprintf(stderr, "%s\n", msg);
 	va_end(params);
-	exit(1);
+	exit(EXIT_FAILURE);
 }
 
 static void *xmalloc(size_t size)
-- 
2.35.1

