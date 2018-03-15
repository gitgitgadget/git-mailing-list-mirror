Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F361E1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeCORdH (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:33:07 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:44819 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCORdA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:33:00 -0400
Received: by mail-qk0-f201.google.com with SMTP id t27so4874047qki.11
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HWf7rp9Kd9JsKEnT01jiv+/+t2DwaLTapU2wnygV5V0=;
        b=jktkbo65GkfX4uAVo9M/8OH7XS0Aq0NOrzMYPMy82NDW4/O7lLzp7g++GMwW9xhx3l
         1ejWtVCzhFPYf0Jr5RA0SapuVxA0gGWjBJxJ25q42Yid1iDhzDJS4G/EOCJc29muxGAS
         OF1TN9gWQ2ATUBHOygDKHZtcNlwV6es/eQYPHVevWlUuRmaklNL6eBKWGKbiPxAiWkxS
         LM9Wy1MD9YRK2+RfNPRw1ihFjyFYUdgByWiPyJ+kLruQxtGMYqx9CD7Ic8bTvXIWymiY
         JumQU1joap9ZYCdLX1Lg3IrnQFRVCzrrP/JlcpvGkjVaGyE/lHGnQ9P3o4PWjGBpfpiE
         CqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HWf7rp9Kd9JsKEnT01jiv+/+t2DwaLTapU2wnygV5V0=;
        b=P4sC6MgZL87dcxQvwc+N2hQuaSiIGioN3vIyaF9mZl4zTKIhT7jx1gXfJWt2lDNwQX
         UcIiAhkv7J2S7gIVJMDEK3AZ+gLlLy/Hk/1V8CBKSWjjSrPEkMMfXYT3uapVcNcQlmye
         6oOE8VRl1FB0zAmerVUW3xArwRLjtklPh151SrtFjiIXyccX2HBzmIWRDIogIRiVvCti
         NKID2lUJdE31KfJ5JvZrgbmU3AkzUh2mB1i/6OyRW9S51S3dKRgdiu3CyaIV7sRJiXcv
         5MJjQ3Hw+u2zoGWtN6TGsJKu2L15kuhsw3Xz5D2LWkIQx+/dxGUEiF2EO/EBpEsEiXtF
         T8JA==
X-Gm-Message-State: AElRT7ErJm5ue/zePSqaAPS3l2XcDndg+xfEREWwC7W8TDFy7Vhzu30I
        ZZY8EftMPskpTzkVFX0i3C3nU2Zr5z9/Up0Km1wHt3j929IjhN5VewqWI8DLmvJmBU/vd/4Ru96
        144wEVdt5vqGUHAwN3aJHpKlfJRRXjsU40OoFX/ucqxDWJMcafTYkFxwrXg==
X-Google-Smtp-Source: AG47ELspSdrOicp/thbXuh5u9pJ/eqZI4wbK5utHFXoQmhb/DjXeGo0RO9zy0cLy3AFonvedSXIzvkkSd9s=
MIME-Version: 1.0
X-Received: by 10.200.14.129 with SMTP id v1mr6473785qti.14.1521135179363;
 Thu, 15 Mar 2018 10:32:59 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:37 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-31-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 30/35] remote-curl: store the protocol version the server
 responded with
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
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
index 4086aa733b..c540358438 100644
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
2.16.2.804.g6dcf76e118-goog

