Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 566FE2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbdJCUPi (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:15:38 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:46340 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbdJCUPc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:15:32 -0400
Received: by mail-pg0-f49.google.com with SMTP id k7so370349pga.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hP1uqKfQ88xiwjwUIu4DLTC1Fcmab537pp1QVZ49NWQ=;
        b=E9gZW/Wx2mu2Qcpychs4fWblziyIxSxCtDGiiFo2KLZaGWll0WV2LkpPqU8QgIiHq+
         rdBQ92nkM2YdW2O4SLbQOccH5npsYPGJI8XTAkiyOug3bRahF1Wpa70TBCyKCLHNEmUe
         k4w4JGfZGFAjPPqKZF6zoUYaMwHD7pLvTkNjufhTz94QyhJ78c8rDH9xU4aHEDvRCjYb
         0GeOahfxcrEdiG1m+Vo4ymoVq7uiJw/7heWxQd6AxJhqce9M+hgz6bQFAv+EDCSo5M4E
         3O3IS1/HA7YTWON9wL0Hrk1JXjQcwFTTmr1MWVM22trmaHmwcAjnJAggrO8YweqmMhuQ
         8UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hP1uqKfQ88xiwjwUIu4DLTC1Fcmab537pp1QVZ49NWQ=;
        b=Slt3DUnEq1rJnMudTmS4KitM0tcOPcUtiIuP658J5KwMYN6i6FmBIFlIG1JyO3ouF5
         Bog5h/RIA4zlkivvE3xuTbaKuTce8u45QrPnZ0+GSmyTgSG0RpPlm8q+0cPPa5VSD+dX
         GMbiYN5uF70ruLNEUwiIHlOWjCi7f/2sCRjSnKrbYPcnRQlJIgJq5rJReJHg9hKD4E6C
         JCh1TRz9gQVe+ETADEGn4gcMHm4Trcn2LfuCivWxkR4ginToqQSrfsjqutVCjI1f6ckx
         kM8uLmC7559U81sB03iVGwfO+AgUbQoQkHPkqUc8zasf3OByd3qpo4zQLOOxxQfBv+Um
         +lAw==
X-Gm-Message-State: AMCzsaWtmVDBbbEcs2VB/w4/LucS9efR5FHjlYLvcfDSY0cRR7qEtHDI
        LGcx47oa5qYfzJKOjPpfrvP5rixmIFg=
X-Google-Smtp-Source: AOwi7QDkuW3SdjxI5jCf7iTxbdJCg7iOFvQSu38TMYD7qiwJsRrPwKAumGrmgohW6/mYZhYJcInOeA==
X-Received: by 10.101.75.2 with SMTP id r2mr5864984pgq.51.1507061731288;
        Tue, 03 Oct 2017 13:15:31 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 184sm3846262pfd.88.2017.10.03.13.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 13:15:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 05/10] upload-pack, receive-pack: introduce protocol version 1
Date:   Tue,  3 Oct 2017 13:15:02 -0700
Message-Id: <20171003201507.3589-6-bmwill@google.com>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c-goog
In-Reply-To: <20171003201507.3589-1-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
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
 builtin/receive-pack.c | 15 +++++++++++++++
 upload-pack.c          | 18 +++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index dd06b3fb4..94b7d29ea 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -24,6 +24,7 @@
 #include "tmp-objdir.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "protocol.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -1963,6 +1964,20 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
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
+		break;
+	default:
+		BUG("unknown protocol version");
+	}
+
 	if (advertise_refs || !stateless_rpc) {
 		write_head_info();
 	}
diff --git a/upload-pack.c b/upload-pack.c
index 7efff2fbf..ef438e9c2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 #include "argv-array.h"
 #include "prio-queue.h"
+#include "protocol.h"
 
 static const char * const upload_pack_usage[] = {
 	N_("git upload-pack [<options>] <dir>"),
@@ -1067,6 +1068,21 @@ int cmd_main(int argc, const char **argv)
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
+		upload_pack();
+		break;
+	default:
+		BUG("unknown protocol version");
+	}
+
 	return 0;
 }
-- 
2.14.2.920.gcf0c67979c-goog

