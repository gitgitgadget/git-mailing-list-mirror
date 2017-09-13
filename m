Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D69A20286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbdIMVzR (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:55:17 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:43067 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdIMVzH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:55:07 -0400
Received: by mail-pg0-f52.google.com with SMTP id u18so2828925pgo.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=StWkt/5F8yDIhdIFbYsCimYGWdaA2RJBFHGP5wPwZ3o=;
        b=oYwu5KdPXNTn9GXzOVE+26pvdjYwlpSfYy1kEazJCuggG8yyW7P+Jr0os/vqA1e75Q
         k/fduq+Qiz6DTaujyj1CkO0XLnYl35MvOw9bxtVG5CgzFwijvDbltvet3QBNhOcgwhhq
         qzospdG6I57LJ95Gwdmr0zxLrdR3kuqAKGbppiPShSvmYpGqR0fb2pV/hiE8qn+i5nkI
         zTJOEAZFbH1ZiiJkIzDrWYShhmiJxQReo2elQu2bHBwuv/JZqRBRwAXyhJnz/QT0dgOY
         JHLSqNAPyEnWj9S5mepybdIBLZrxzy1/qBHku3LMqTQ6fyWTb1GMsl3jI5lzuvfeEdVc
         wz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=StWkt/5F8yDIhdIFbYsCimYGWdaA2RJBFHGP5wPwZ3o=;
        b=d/f6XibbCJiC/+7CYrJx8WVL9cmSoDoZcmr3yAo+utCAHjQA1zMe3IqYRQaEEfr4rE
         h92cxOP3MPOdbUmxDgy7e+z4h9jGBiBi/8NnjVvC7uyqvCSZUZQmXJv+hYAzKeyYgWUZ
         t/6AeYVEoFA2queIavTaxu2wgY/+NQdzIKFnuBq8fCVrBDK9PyyQA2D9hHwW7UNah/NB
         FmpttBX1Pb7gVPLqvrr5qayrwJ5OFEEawrPV2x7nwL3743eNTYt+wJetMhzUOYiipfMt
         engrgooOj1yerkJqN8MVQ6uflfxlIVm1r5VXfbpOvhctfVATmKVZzSvRryf3ZiKbJx+9
         d3YQ==
X-Gm-Message-State: AHPjjUiM2XfBjw7Cl6+WWJQZwBsll2/50xbX1iiW6FESNLuZRisMDJQa
        PbW7AbHYzak74hpwVlPcQg==
X-Google-Smtp-Source: ADKCNb45J0Im19tR0pwoCARczdMKEn3Z4ciAa2XHWgVDaxwLzoI1Py6s19B9Qe4e2f7IWkswEvBWyg==
X-Received: by 10.101.77.4 with SMTP id i4mr19511450pgt.119.1505339706111;
        Wed, 13 Sep 2017 14:55:06 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q13sm23152639pgt.87.2017.09.13.14.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:55:05 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 4/8] upload-pack, receive-pack: introduce protocol version 1
Date:   Wed, 13 Sep 2017 14:54:44 -0700
Message-Id: <20170913215448.84674-5-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.690.gbb1197296e-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach upload-pack and receive-pack to understand and respond using
protocol version 1, if requested.

Protocol version 1 is simply the original and current protocol (what I'm
calling version 0) with the addition of a single packet line, which
precedes the ref advertisement, indicating the protocol version being
spoken.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/receive-pack.c | 14 ++++++++++++++
 upload-pack.c          | 17 ++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 52c63ebfd..aebe77cc3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -24,6 +24,7 @@
 #include "tmp-objdir.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "protocol.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -1963,6 +1964,19 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
+	switch (determine_protocol_version_server()) {
+	case protocol_v1:
+		if (advertise_refs || !stateless_rpc)
+			packet_write_fmt(1, "version 1\n");
+		/*
+		 * v1 is just the original protocol with a version string,
+		 * so just fall through after writing the version string.
+		 */
+	case protocol_v0:
+	default:
+		break;
+	}
+
 	if (advertise_refs || !stateless_rpc) {
 		write_head_info();
 	}
diff --git a/upload-pack.c b/upload-pack.c
index 7efff2fbf..5cab39819 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 #include "argv-array.h"
 #include "prio-queue.h"
+#include "protocol.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git upload-pack [<options>] <dir>"),
@@ -1067,6 +1068,20 @@ int cmd_main(int argc, const char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(upload_pack_config, NULL);
-	upload_pack();
+
+	switch (determine_protocol_version_server()) {
+	case protocol_v1:
+		if (advertise_refs || !stateless_rpc)
+			packet_write_fmt(1, "version 1\n");
+		/*
+		 * v1 is just the original protocol with a version string,
+		 * so just fall through after writing the version string.
+		 */
+	case protocol_v0:
+	default:
+		upload_pack();
+		break;
+	}
+
 	return 0;
 }
-- 
2.14.1.690.gbb1197296e-goog

