Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5025120281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032784AbdIZX46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:56:58 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:46893 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032775AbdIZX4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:56:55 -0400
Received: by mail-pf0-f178.google.com with SMTP id r68so6330016pfj.3
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WZMWmLyV008z5CN9VL+OKROjiZOLHsDto0VhpmSGSfI=;
        b=vMk9RmrcR2oj0aAl5QHZ25UbF+xx7JASAIMSsFD5oFyTggTGoU8rj/TRKaTHZW71gI
         yuEiQo686RQqXo7MU4GqaIbuUs+EuC8ifOtw8r+joyI/A14yIyF+pWg/VDHY3jYjcmey
         jobf/PpLwtyOaaSg2uuFZcQyPOXkDmAtxppuVNErYRJoCC6+hQUKD2GipRBH2Ty1urc8
         uHNPl9mOUVBXTaN/1W+xROziMDEirxEGrfPkWS/E0A22C8BkiqsEJF20MGzRtIS6dKo9
         3SxJ0096T/9hTOHd0OQwTXNPwy7Su3wmSofVgNhVDpNP0CL2zqX1GspdWd6X59vKAPPa
         RXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WZMWmLyV008z5CN9VL+OKROjiZOLHsDto0VhpmSGSfI=;
        b=i4LjbMWkamwRgy8jvjxO6h/w8fM2B8zHUEhbiJkP+uHOZKCmp7/oNSbkvjDtgNsGxP
         CjkcJzJKdVuk8pjjItSYD0sbMpfgq6PoVICAN/VM0p68knHWOJ5lj0iC4Cm0jTSAfWT0
         cjvvct+YCvONJTgTB0LHDGOGE5wnQfZOrKzyZyUB8aEDHIqq82z7XimKG0sj7BNc85Q5
         rIctVY+wdE+NPXenuAlejxMybSchXGOLlD2Rz03cFyKFFMWBwIBN2L5WtHMtHm+NoXSY
         bSi2m//eKPv6VyTl4Om1ZKy8H9FJSDU2DRrzWDFEMSwMYxVimT/yC4vVDDxrCpPYCO1t
         mwoQ==
X-Gm-Message-State: AHPjjUgPKSpZ9KB5P96A5GGxZtuiHnWgT0DQ+fAYtFN5cMSYZdFFimJD
        vzjMzIFDXBBwW+gyKej26KjA/3r0N1g=
X-Google-Smtp-Source: AOwi7QAgSUdFgeb9NLaS6ChWC4nEexDnWfKDc7/splmeOUbtFHT64PwEJW66r4yeG5cfGXPUSM811g==
X-Received: by 10.99.160.65 with SMTP id u1mr12519130pgn.227.1506470214070;
        Tue, 26 Sep 2017 16:56:54 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 5/9] upload-pack, receive-pack: introduce protocol version 1
Date:   Tue, 26 Sep 2017 16:56:23 -0700
Message-Id: <20170926235627.79606-6-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
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
index dd06b3fb4..cb179367b 100644
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
2.14.1.992.g2c7b836f3a-goog

