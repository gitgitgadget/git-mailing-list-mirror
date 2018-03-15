Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A7C1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeCORdI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:33:08 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:46398 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeCORdH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:33:07 -0400
Received: by mail-ua0-f201.google.com with SMTP id y43so4736248uac.13
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Z5uSc2Jt2rHpWFVdH7LIveweR90wohnI6Rn8QpYlpkQ=;
        b=O4tdFhTqrsonZRpSVELgq/JkrTbkbFYNtws0SOcFF/05NdFCon6BAXD9ZPIZs6etYB
         IkQZLwc0CT3RngMmYRfgxDVlg5EWqwUz2kF5oGkXozQfGORAPaZ5i1BnHU7IOTzqvg16
         3gzMD5mjGd+GvGCjca0BlcJzz6MFLPeJ5z7lXqC74Pd+imTsRKx+AfbEml9TIR0x09ZH
         EpsalWIWr4GQgN/FYkTE94MBHAzCuH/rnKcXRvYa5i785H7MZY4OInK8q0OuYldVrleh
         RWWJx/fUBIFPq62ULf6HGJYoL+AarjlMk8gASg4W78a/KQsH88DQUH+i4vca2IpncS32
         Sm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Z5uSc2Jt2rHpWFVdH7LIveweR90wohnI6Rn8QpYlpkQ=;
        b=QgMtHe1Fs1lJSQb1NtknwGaytv2ZNlpxAXHLEHNSbRc4EENwB6w6GAyPcLd4hRJkSW
         ljjutkjxS44NOkM4f3mNnTDkhVfJNPhb4fpVzt0g1PqXUfRTIBtcpUkxYbEYMSoJ47OP
         s/KC8CDKY9awCoFOiZSiubuHoTNvxdBDe8h8MHPlE37T61lQyLEwDYC09f1gDaD3ltfY
         hclEGeYn3DxksX+Uj8RfiusbPEaAHDidWF9PXdx+So6BXQgTFevsszbuj7YU2A5a0cMl
         W8symxTLLMNEZzlhffFH0uN4ofiOgm4VNUjHfQns0Oi8o4i3z44CS04Me/2DGHrz+IjQ
         Ebzw==
X-Gm-Message-State: AElRT7HG0PpqlkGwrkyOvGST+eb3wr9UO88vPTs6IjXIIk/RdcGvZdM0
        /GF+KNm+aRlIimFb+yB0OBJUZAlNkgZ6Gg8FlUnPb9MmeWZs15r0V0SJqTXv0x3y60b+Jxi+UGb
        DNc5Fv4dPHmVjIyq1ibnEfoGocxZuzJwsYj1++8tDqkkLdZdGvmxeEHyYfA==
X-Google-Smtp-Source: AG47ELvhy3sBzdsil2FJRgx45bGjKrgVJKaDZuyGio+Hiey44Qhjg2nkNpo7EjiUCf6SADBo1bEPOZr9o84=
MIME-Version: 1.0
X-Received: by 10.176.89.174 with SMTP id g43mr3956544uad.4.1521135186431;
 Thu, 15 Mar 2018 10:33:06 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:40 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-34-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 33/35] http: eliminate "# service" line when using protocol v2
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

When an http info/refs request is made, requesting that protocol v2 be
used, don't send a "# service" line since this line is not part of the
v2 spec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 http-backend.c | 8 ++++++--
 remote-curl.c  | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index f3dc218b2a..5d241e9109 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -10,6 +10,7 @@
 #include "url.h"
 #include "argv-array.h"
 #include "packfile.h"
+#include "protocol.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
@@ -466,8 +467,11 @@ static void get_info_refs(struct strbuf *hdr, char *arg)
 		hdr_str(hdr, content_type, buf.buf);
 		end_headers(hdr);
 
-		packet_write_fmt(1, "# service=git-%s\n", svc->name);
-		packet_flush(1);
+
+		if (determine_protocol_version_server() != protocol_v2) {
+			packet_write_fmt(1, "# service=git-%s\n", svc->name);
+			packet_flush(1);
+		}
 
 		argv[0] = svc->name;
 		run_service(argv, 0);
diff --git a/remote-curl.c b/remote-curl.c
index b4e9db85bb..66a53f74bb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -396,6 +396,9 @@ static struct discovery *discover_refs(const char *service, int for_push)
 			;
 
 		last->proto_git = 1;
+	} else if (maybe_smart &&
+		   last->len > 5 && starts_with(last->buf + 4, "version 2")) {
+		last->proto_git = 1;
 	}
 
 	if (last->proto_git)
-- 
2.16.2.804.g6dcf76e118-goog

