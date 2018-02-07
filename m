Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B461F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbeBGBOp (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:45 -0500
Received: from mail-ua0-f202.google.com ([209.85.217.202]:52127 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932264AbeBGBO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:29 -0500
Received: by mail-ua0-f202.google.com with SMTP id f5so2358409ual.18
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0OoJ9vPoF2rshRW/ACPT+v+iRpCqOVuNSr9wbmzw6ls=;
        b=eDzYBt4E/VqeSQlAKUZ61X6Ib++J9T5fq1DcWNFGqeQd2B6LYLXlTLF9LWCu+5lcPy
         js8li/FveF5Apd8OIyfbCsood0v4nHJDtpGQRhQMc0HdFCc0WCz7t1TgXgWv2fCPx9r2
         vzlu5YrUpNaMEN2kgtQvDYCizgaEAYQkWWQ5E6oOE0DPWHrryZ7/53urB0EyCInBbp0t
         pQiEMUeHyn3Sua+erSRHjJgf9J0JiRWiVbcaU0CBswOuzPG80Ut7qZ4WsKrvh6tHCkEr
         r0SDIKkv8wpR+i5bO/5wSVCkIM/W+/B19i0ukIh6P+I85ydrODmr8TwLUCDNggGgBUCP
         9UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0OoJ9vPoF2rshRW/ACPT+v+iRpCqOVuNSr9wbmzw6ls=;
        b=Ib5w+g36B717a9VFYp1nwnX7xAENvP/MSJ47SMvBVLYMbKFQ/JsQSd+TR4x65zStdU
         SnrfK/slXGkrkYGhs8HtP5vQr3amuaTFNSq1PTeYlhtEiwsFGcrHrSIas3SG+X2HneWj
         6M+s4KTK6FhJ25dmCVJmbm9/oeRerIljHR6tr6G/L8DVk4r1y6ssD3JmoMwIHT4aa+9q
         A+DPnuWBfiOUkftP2IVwjerg1TH1UPIcjexPBnGwJTFjxG2DoqpSOlj3QF/YZIyTVNcy
         WNuDv1xBNHn6acz2vB9BIa8mqILQ5lHm4CeZvyc+bTIyr/8VbwPkFyNIYKZxp4li1SVp
         MTTw==
X-Gm-Message-State: APf1xPCxyRLELHtAAxC7mVAU6GZ/8O3dxAUKBB99DaTwL8Dx89M48WrH
        vqAs6/yXFzANUBOcp3Qa4tlcIQSamebQRDqQXD/Wai99GC+Nn4GK/KL7yh/87+HNfjIcKxGlAsF
        z9OY/rB9cAEBoqCqoNfvPZIcjQAWBCotOliPoHIod9VteELV1ThXJDLDOFQ==
X-Google-Smtp-Source: AH8x224yjsLYrLVTmIPkaqWaZg5Jllo8K1UJL19b4VwKLUyFFi876GvZb/mOCn1iW4ORcXZxHUiAT/fh1To=
MIME-Version: 1.0
X-Received: by 10.176.90.111 with SMTP id m44mr2155135uad.73.1517966068316;
 Tue, 06 Feb 2018 17:14:28 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:08 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-32-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 31/35] remote-curl: store the protocol version the server
 responded with
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Store the protocol version the server responded with when performing
discovery.  This will be used in a future patch to either change the
'Git-Protocol' header sent in subsequent requests or to determine if a
client needs to fallback to using a different protocol version.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4086aa733..c54035843 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -171,6 +171,7 @@ struct discovery {
 	size_t len;
 	struct ref *refs;
 	struct oid_array shallow;
+	enum protocol_version version;
 	unsigned proto_git : 1;
 };
 static struct discovery *last_discovery;
@@ -184,7 +185,8 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
 
-	switch (discover_version(&reader)) {
+	heads->version = discover_version(&reader);
+	switch (heads->version) {
 	case protocol_v2:
 		die("support for protocol v2 not implemented yet");
 		break;
-- 
2.16.0.rc1.238.g530d649a79-goog

