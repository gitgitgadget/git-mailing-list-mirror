Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C321F803
	for <e@80x24.org>; Thu, 10 Jan 2019 19:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfAJTeY (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 14:34:24 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51502 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAJTeX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 14:34:23 -0500
Received: by mail-pl1-f201.google.com with SMTP id 12so6755233plb.18
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aGfJ78pC8oaTrc2XYhM4yj5669sebfTIeY/InoN6ijQ=;
        b=UdQgusasnr439EYu7PIROuXpm6CT2+HOx1tkIRpKRhD6gBIr7vhsSpF0k5uncBoeK+
         toeXCfhq/Tmm5+eYxdyirN7hEkB0gMaCHNC4HjGI3LFDiaiq1HXhN7aTCDv4ghGebjWS
         tn6VmMYUZ4DgS+rEU8ClxzY8Jgw5fnUPdzBDNq1ULawLLWN3BuC4rohUjLUP7jtlGnB2
         tgl1EJnW4bvYB12GGVIDlQ/scuBUmtEjylVZat9rEAOP0I4rdXffrY6UPJXTu1Hf/j9l
         8zqzVlp1TrZoln8SRgTuWsZ+t6YluVYkGN7wtf7aDF1y0npUn2vfopsvX9tQoPprRtzi
         Hlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aGfJ78pC8oaTrc2XYhM4yj5669sebfTIeY/InoN6ijQ=;
        b=DRUE2v3b3s6QOBI2qsnjtt4B0DlKEnXhZidikejlQ5FZebJxuURV3AcQx3dzIslPzE
         JtY7OHkPq4BC7QM/7p2UvhVc+iHvwE0lxWb6aLBcQMXYbQL1MG9Jp1IeS7SosNLZcTiY
         Z5PXMnX3NdiQezFUsovrV4Pdm4Ib6L2+Nme++NIFT4rShzmiylT2MyhHJPXFUUxolg7o
         pk4FJYZUuJkQZGYk0NogZYq/iDDGjNgW7iX+eEyS90r0QZoDMtxVhX/XCiq4WMwoe35r
         E/BWNg/G4Z0HA0kfHA3yYOLFWBBHMuTtii4gAXBs6+DYzbKmCXcWw7DzuZlfS+yhTHLp
         ej7g==
X-Gm-Message-State: AJcUukdsRKgZJma07JPdtppmydGpLF7U/InxdDHg7oAxyVXG27zvP9xn
        8GApywDWndllYqt8nrV6q91EH8LUON02vqR8Afs=
X-Google-Smtp-Source: ALg8bN64ptiWZts+T7zDhzeLTdI1jsByR8f/134EQTg2gu5FiWopXE0xMFIy2xLRILQRZ11oAnYigVCacmUaxB+rHB8=
X-Received: by 2002:a62:9687:: with SMTP id s7mr3103957pfk.56.1547148863134;
 Thu, 10 Jan 2019 11:34:23 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:33:46 -0800
In-Reply-To: <20190110193350.213327-1-masayasuzuki@google.com>
Message-Id: <20190110193350.213327-2-masayasuzuki@google.com>
Mime-Version: 1.0
References: <20190108024741.62176-1-masayasuzuki@google.com> <20190110193350.213327-1-masayasuzuki@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v4 1/5] http: support file handles for HTTP_KEEP_ERROR
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net,
        sunshine@sunshineco.com, szeder.dev@gmail.com
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
 http.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 0b6807cef9..4eccf4c5d8 100644
--- a/http.c
+++ b/http.c
@@ -1991,16 +1991,26 @@ static int http_request_reauth(const char *url,
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
+			if (fflush(result)) {
+				error_errno("unable to flush a file");
+				return HTTP_START_FAILED;
+			}
+			rewind(result);
+			if (ftruncate(fileno(result), 0) < 0) {
+				error_errno("unable to truncate a file");
+				return HTTP_START_FAILED;
+			}
+			break;
 		default:
-			BUG("HTTP_KEEP_ERROR is only supported with strbufs");
+			BUG("Unknown http_request target");
 		}
 	}
 
-- 
2.20.1.97.g81188d93c3-goog

