Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D511F803
	for <e@80x24.org>; Tue,  8 Jan 2019 02:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfAHCsA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 21:48:00 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:53471 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfAHCsA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 21:48:00 -0500
Received: by mail-qk1-f201.google.com with SMTP id r145so2019733qke.20
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 18:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VgVcVU2oULsoKrNzaUQ/l6Ygm952kaZYHyVrUObIIOM=;
        b=EZ16zKBup6kTUZw6KkIhcFQIRRzapPv/EoXbOlFLyiN2JhODUj2LZegpI5hLa8KYhR
         pFnUZ3plc9/3jO0nsjZOtH35kMBp/tV3zXadFBuA3JYDubBR1tKUR3VVFBeHxzbP5NLa
         GE8q+jr9WmNBTQeg8IMLix6h2HyKo0GEZP0nVYmmc1TziuX9U4EfKdtsngEd5gOFK2m7
         PElOfV5/6lfY8+rmoiP7QKEfyCq3/vPh7pSzCy/ZRM74Btx9GMaVZE8sCQxp4RSYsvZM
         maK6THIDdm4h/ARrV/q2gFZfc7VNdctuZeS+zbtLVoPHtvxM6IMd5GOwNPDQiA86+Z6P
         M1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VgVcVU2oULsoKrNzaUQ/l6Ygm952kaZYHyVrUObIIOM=;
        b=nvuaCZR8pkTLWi/1/gTRuDA5yJGFYIPsvA7It+WSekCYGRNz1Ia/sFYXkSQ8eOx6ND
         oFOlUkZPZE17uWmc7Od9HyT46tkltUTI8Mdmj8LMcD4YpL/4aAXYhy1NayjXJzy/C/uo
         Vg9rfrk6fbIWyzvvuP/9xKw7NqMEJ20QY1m7t2stGA4dQrk+1/i8w0WC6C3uXYFzFWzH
         Ki9rb4kMYJlwsiFbESkFX+XN4H1aejGwC0cVLIlcjny/hzIdPc0vrOkWxcqobITFusl3
         M+sf9Al95yIa23hxVtDgOPVir2xLnjlmROxd195+p1gwGHbEf3SUpsQq4FIm934J+6hb
         ba0A==
X-Gm-Message-State: AJcUukcNoRjtlNQTQOtd6rfmiDQMyqUIGBJkr6qQ8AcwflqHLTUUv4Ql
        vS3HtrJfciElkQtnyY+kG2cuypFyqggmJ6sQsN0=
X-Google-Smtp-Source: ALg8bN6iUNuZzqVIGZS3NpokRW3Snmsxv2o2mrXq46hqVEbrzhYxyU2cqKB+a8ZZEKztjQAxNUS4ZooAOY9RHQ8JTmM=
X-Received: by 2002:a0c:98c6:: with SMTP id g6mr2240qvd.46.1546915679313; Mon,
 07 Jan 2019 18:47:59 -0800 (PST)
Date:   Mon,  7 Jan 2019 18:47:37 -0800
In-Reply-To: <20190108024741.62176-1-masayasuzuki@google.com>
Message-Id: <20190108024741.62176-2-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20181229194447.157763-1-masayasuzuki@google.com> <20190108024741.62176-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v3 1/5] http: support file handles for HTTP_KEEP_ERROR
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HTTP_KEEP_ERROR makes it easy to debug HTTP transport errors. In order
to make HTTP_KEEP_ERROR enabled for all requests, file handles need to
be supported.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 http.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 0b6807cef9..06450da96e 100644
--- a/http.c
+++ b/http.c
@@ -1991,16 +1991,19 @@ static int http_request_reauth(const char *url,
 	/*
 	 * If we are using KEEP_ERROR, the previous request may have
 	 * put cruft into our output stream; we should clear it out before
-	 * making our next request. We only know how to do this for
-	 * the strbuf case, but that is enough to satisfy current callers.
+	 * making our next request.
 	 */
 	if (options && options->keep_error) {
 		switch (target) {
 		case HTTP_REQUEST_STRBUF:
 			strbuf_reset(result);
 			break;
+		case HTTP_REQUEST_FILE:
+			fflush(result);
+			ftruncate(fileno(result), 0);
+			break;
 		default:
-			BUG("HTTP_KEEP_ERROR is only supported with strbufs");
+			BUG("Unknown http_request target");
 		}
 	}
 
-- 
2.20.1.97.g81188d93c3-goog

