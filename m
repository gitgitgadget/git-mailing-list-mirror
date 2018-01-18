Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 873291FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756642AbeAROvP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:51:15 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35864 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756629AbeAROvK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:10 -0500
Received: by mail-lf0-f66.google.com with SMTP id t79so11636528lfe.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=TT0JvZVbkWNNm/CQgty5WxorrO/tOVpBaU4hehWQy0s=;
        b=ZSXZeETlC26sD2JqLDwUYDMMB1TC3aaL0hUzC25ooh3M3B+IpmH35mfm3BNCI71WTg
         CxIKnMitSJSPXBAUI8AEbc8vBHbGpHdY/HwzB3dmm6JXcLPo/chBi+uvvReKSkpuBR2d
         DD+MqWdPz8AVdrmifptgte0e3BZuzAAiGoEL9h9WX7IvkMD8SNnvmu/nRs7/we1tN8js
         tuYILOA/F3TKjL2duVX+yqp6RSuBlCt59MmUyIcK8F0PbpCxqFMSqRQ0dtyEKAJsuvVU
         9aMTGa8Qykkmll6djlHAIYpIcsM1W759CrF14C0iPZj7vGu1lcQhrh7pI7fF05cRCrNl
         RagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TT0JvZVbkWNNm/CQgty5WxorrO/tOVpBaU4hehWQy0s=;
        b=H5AH9GBgL36BwXMQ851bHqML2j+yGUt6/ZnEPmLLcg5gYQht6B0oiztV8lViFdp/Cm
         we4eMvlRVBIpoL4ZmNwQgeutQwL5MFPFxCUUAGQExlhtpTsZBGTXnTAd56PSum3fAQM9
         48qUY0urRvrGZjoYHR2Cc+8V1x/d0oacb/6PuQ4csl/XeZj+BVoMFnTXUifKJGFtFgaW
         08lpaj8X1ksblsrMTm9C8DnlxcZHtG5LE5Keho1NNOsUTcYQ6FULu+hrreqPShtdwMow
         o2cSUqKI1cw3cHYP1Wine7lYNYxqnDZkvPo1tipbfrw5Eq+sNvoypU5TI7RjIUr8MAI/
         Qzrw==
X-Gm-Message-State: AKwxytf47LvF64XW9Q79rVxcFBTk6EkUtVFzB+5fR6yD60C+yxNjRRmP
        ilrdCW2KV/8JZOMV7n3CTJoUswacWYU=
X-Google-Smtp-Source: ACJfBotXeCgRrA3blflGJsjVCRNiV00N91Xc+9XGw8eafgFJogYkN3Xv+Qc6v3r8a6suWtuUAqH9NA==
X-Received: by 10.46.54.15 with SMTP id d15mr9231574lja.26.1516287068742;
        Thu, 18 Jan 2018 06:51:08 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:07 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 01/11] http-push: improve error log
Date:   Thu, 18 Jan 2018 15:50:53 +0100
Message-Id: <f42091542082de5ef0a023fc2dff371871f9b67f.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git push fails due to server-side WebDAV error, it's not easy to
point to the main culprit.  Additional information about exact cURL
error and HTTP server response is helpful for debugging purpose.

New error log helped me pinpoint failing test t5540-http-push-webdav
to a missing Apache dependency in Fedora 27:
https://bugzilla.redhat.com/show_bug.cgi?id=1491151

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 http-push.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http-push.c b/http-push.c
index 14435ab65d..0913f8ab86 100644
--- a/http-push.c
+++ b/http-push.c
@@ -915,6 +915,10 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 				lock->timeout = -1;
 			}
 			XML_ParserFree(parser);
+		} else {
+			fprintf(stderr,
+				"error: curl result=%d, HTTP code=%ld\n",
+				results.curl_result, results.http_code);
 		}
 	} else {
 		fprintf(stderr, "Unable to start LOCK request\n");
-- 
2.14.3

