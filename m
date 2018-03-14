Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5CF1FAE3
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeCNSdj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:39 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:51321 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbeCNSde (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:33:34 -0400
Received: by mail-yw0-f202.google.com with SMTP id l125so4738960ywb.18
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Z5uSc2Jt2rHpWFVdH7LIveweR90wohnI6Rn8QpYlpkQ=;
        b=FK53d7prBnXTYJ1VW8JlNJZqHzpH/WOSD6cW9cv7jah5UZJ2Cr/n6LmsRCij0SS7Az
         vLMTrVCbURjcrcJT8sYFo4ROE/DezQJn3z9CymqZ4AgWjUdZ4CiZFCZlWt7fo8r6tAPQ
         Iaz7aCdKx+0/Y3Q8nqdktU3BvrUDdTAHk5oiyTto5qCHVEAP9emliPvA50ibQMlIzayD
         KTqaaM6GrZX25mJvldfEt4aKuaMB5evyewkaPlpESyX0Gqy3i0EK+VYqqxAkXNTnSY8f
         1ibrj/CksjHsP67tNKnY8Bq/b+zpiOD3QVhuX8O2I8xeQhORSB9ATIQQyct92u+MCKO6
         JyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Z5uSc2Jt2rHpWFVdH7LIveweR90wohnI6Rn8QpYlpkQ=;
        b=hxtTeu974FYOMG1IJAPl7BoUbdd1T7hpiIvCfsQkOrlOKs2HGR+TwFLwdBJlYvHJle
         T4soqyXovo4YF8bSJfKZYVAUyrTzHe8e96x2Rcc6FjZbmTfQEFtVpDGemji697wPoZDA
         zztzt/iK57x3k0yJ5+dbbEFEthay1s4pNjZmNSKULEhMOh0uMB/X++cVofCw0ZOGx77E
         XKdTjWIGvWP8IiGrdT+UIMA07LkDwjk9f8Ujse0Dy/+JUFNJRJcaeDMgMDU8HHtdgjNu
         LY/R1xxY+XNNOiZv6wrDD5YKj2a7HBiG7j3HisaW/LHvbBx3nKEwnYNI2JwU5IgTfCA8
         OpBw==
X-Gm-Message-State: AElRT7HoY3dIurqRM/eqCKnNsQdLaCPQ99VxRKtKK5GGMMWQioI4vLuC
        ZJAZQZVmuiVznI4LH6EdosZIVgkVyVxXrWehaxzbTzuXzMK2aw3R9U+2XNssJjzjlIjUyqLDNTm
        2vqEXfOGN7S3M6noiuB0cr9p/LJMWChr+dsbI33u1by6N1ENdKzIuR9+WGw==
X-Google-Smtp-Source: AG47ELs/yhoX8KGr/5nkmymwV4oszg0l6ewGmssm/bgOdNXUku9g1PJ3vytc2X5BKEnWPS0hjCoqKBb3BUg=
MIME-Version: 1.0
X-Received: by 10.13.237.130 with SMTP id w124mr2621652ywe.56.1521052413911;
 Wed, 14 Mar 2018 11:33:33 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:32:10 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-34-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 33/35] http: eliminate "# service" line when using protocol v2
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

