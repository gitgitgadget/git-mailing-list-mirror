Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17BF20437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754229AbdJPRz4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:55:56 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:52828 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbdJPRzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:55:52 -0400
Received: by mail-it0-f41.google.com with SMTP id j140so2148075itj.1
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6VKYRTaBUtKGXx+pci/BvFYcjTt0B+pbyojYcaJsXIY=;
        b=N/ksj5sO24XcOa0ICCK2+RmUP9j3XdEOsWshPcPkk2K05S1SefmL8WuNfM5pLyYchw
         IPlDeyS0PRN2BHlzhkBF58eTexDFuk30PE9Nyr/fQjZTgbGbFJbnwfXLGwZPYmoThMXn
         uYbW+2EHNGTvjSTm1H1osN89/nB2RWRhykO5dug9ifOsfZOxeswCkn9TMi0krvpLQL2F
         V0DiZIA8ICYUxn6Ji3wb5qAtJh1w/QrbAyDXBBNJvWlcoaUzPbh9+cI2Bl59Demt0jSh
         MHf9ozldz/f/R5kLYJ73jA2H9QqwAa7o0gycXUrvPhfcXIJeLLrldPeYDxVBkBpLVAxi
         QnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6VKYRTaBUtKGXx+pci/BvFYcjTt0B+pbyojYcaJsXIY=;
        b=V+RH5hFZNWYSP9x7DGz82GTjXS+/HlDdsd9MtDneJktmQgONV+b+zczJWAwK2XWvxf
         wkyIwuwtpULQCSw9zPhxwUeJbvNoaQHGi2et0sKTBmYcSueF8ZWq9uYTkOY+W2Yr8gjM
         JvCf6+LndRlemuZJMgFduGYgbry0a+ho5DVi9/o68WYrf5RJuNFBeblpLxj1wHgpPezZ
         zMihFZagPYAScpuFMQgGGKfafbhWWKgnSoE+0GxKUCxOyd6PSgilhJ7/MxHOeEjkIjC9
         rvCDDGnoWIPdHX3gTiX1pw6ITt0lsqt9lXprqoxrGYcqc8jItgn8JGrBDiKMlyK9L2wo
         mocw==
X-Gm-Message-State: AMCzsaWIaHxY3gf81ovuTc5PgBrAkQoWdiORst0ZNp6JioyeKjYFsHAd
        PXfV3xj7NFCbExsFH6/6G05eC+piKX0=
X-Google-Smtp-Source: ABhQp+RpYXjzsp84KGtQfchWFV4n3IuBKFF3ZZqyBzajDP46nOxEfh4625hWkUKcvdkzmNAzsbXvnA==
X-Received: by 10.36.237.134 with SMTP id r128mr2074208ith.100.1508176551036;
        Mon, 16 Oct 2017 10:55:51 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:55:50 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 05/11] upload-pack, receive-pack: introduce protocol version 1
Date:   Mon, 16 Oct 2017 10:55:26 -0700
Message-Id: <20171016175532.73459-6-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171016175532.73459-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
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
 builtin/receive-pack.c | 17 +++++++++++++++++
 upload-pack.c          | 20 +++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index dd06b3fb4..839c1462d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -24,6 +24,7 @@
 #include "tmp-objdir.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "protocol.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -1963,6 +1964,22 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
+	switch (determine_protocol_version_server()) {
+	case protocol_v1:
+		/*
+		 * v1 is just the original protocol with a version string,
+		 * so just fall through after writing the version string.
+		 */
+		if (advertise_refs || !stateless_rpc)
+			packet_write_fmt(1, "version 1\n");
+
+		/* fallthrough */
+	case protocol_v0:
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
 	if (advertise_refs || !stateless_rpc) {
 		write_head_info();
 	}
diff --git a/upload-pack.c b/upload-pack.c
index 7efff2fbf..ef99a029c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 #include "argv-array.h"
 #include "prio-queue.h"
+#include "protocol.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git upload-pack [<options>] <dir>"),
@@ -1067,6 +1068,23 @@ int cmd_main(int argc, const char **argv)
 		die("'%s' does not appear to be a git repository", dir);
 
 	git_config(upload_pack_config, NULL);
-	upload_pack();
+
+	switch (determine_protocol_version_server()) {
+	case protocol_v1:
+		/*
+		 * v1 is just the original protocol with a version string,
+		 * so just fall through after writing the version string.
+		 */
+		if (advertise_refs || !stateless_rpc)
+			packet_write_fmt(1, "version 1\n");
+
+		/* fallthrough */
+	case protocol_v0:
+		upload_pack();
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
 	return 0;
 }
-- 
2.15.0.rc0.271.g36b669edcc-goog

