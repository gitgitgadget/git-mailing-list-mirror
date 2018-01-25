Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E7D1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeAYX7Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:25 -0500
Received: from mail-qt0-f201.google.com ([209.85.216.201]:32935 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeAYX7X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:23 -0500
Received: by mail-qt0-f201.google.com with SMTP id l6so13573983qtj.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=7G8kDODiaCeJG/ElgXg3hgO0NuEM+iiYB9sqbP3H03A=;
        b=JNAtXxZz2bIEOgm2XpNO+uou0L5kc1foh6kGBbKr5GcWIFCJqw9OXhcJMNfzNB9TWy
         AhX5M8dPIo4uhJS52+CI4vwU0Gl8S+5JKDgchLPYiqjgo8Bh/4IpczKJcoVy1AbBe9m5
         Qc4rekopVHoxwvRxEzPgMrMa+dZ6eZ74oDZCMdgkNxy8UfbuBTTh9Vzlr2JW4S3yctnj
         gOSpXuMAdH+x9sttYYCszK8FJ+JDAcR4DcAXcPDpz2neRzJZ/xIhu6R+PkaXqcq3Mjej
         CtRAlrHpjCqtYbFfJyDqJfV0C9A8ahAdr9qDjxqcTXNEltySIUgaXoNw3XVpC9or3Wc4
         TP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=7G8kDODiaCeJG/ElgXg3hgO0NuEM+iiYB9sqbP3H03A=;
        b=efWq1KX0ETIg9M4/wiUl7MlkgsyULDbnggr5eZW4wTtH961wYZZQCgKL4rx9R7KhIf
         K8wHriI13CMRkqr3Fnr4DR8gbqucuD3GhMXX4x2JZvT40iVZT2ZQQjhrmLrfh8JcveQt
         FwTNMq5xYcS/GZGexigxwFIqUS9mP703a1o83Y7K3KXiasxz9ARGPpN9cfncwUkCEmtc
         sRGO5SGFD1v/4luQ/z126ZGC4bfHXL0QyjU+JF4/mItAGPJneietndBZ0IeQhARRTA9e
         /iH/KnlLl+IC/Ue2cFttxOCrhF9Koz+XliXGm2/8WXyknlsXumTDSL4LxfpauEkNdi12
         Zg3Q==
X-Gm-Message-State: AKwxyte8xI+NdOGjcPQh9qgtOGgvg4LbgVof7Aiv7jRNHoOaoYQxyOn+
        h7pJw3loE0Mj2IjOKxdWv+McBIE1xcjRsxzX3vnZr14WsACP2v2FRH8JU2j0+hjmyKiNg40TKyZ
        TlDb/7qBacBgUPboeVGjkMgzr+3tNBYIUbRmR6FzyIyapi0vXK+ftsTAHwg==
X-Google-Smtp-Source: AH8x227xitFPYjiNEmG8wi/Goqe+6F99CraTW2J73jG1aEFD+55Vu3F2nEHTXO01iyXcYSjM88tbvh8f6WE=
MIME-Version: 1.0
X-Received: by 10.55.25.37 with SMTP id k37mr7650102qkh.59.1516924762716; Thu,
 25 Jan 2018 15:59:22 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:28 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-18-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 17/27] ls-remote: pass ref patterns when requesting a
 remote's refs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Construct an argv_array of the ref patterns supplied via the command
line and pass them to 'transport_get_remote_refs()' to be used when
communicating protocol v2 so that the server can limit the ref
advertisement based on the supplied patterns.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-remote.c    | 7 +++++--
 t/t5702-protocol-v2.sh | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index c6e9847c5..caf1051f3 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -43,6 +43,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int show_symref_target = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
+	struct argv_array ref_patterns = ARGV_ARRAY_INIT;
 
 	struct remote *remote;
 	struct transport *transport;
@@ -74,8 +75,10 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (argc > 1) {
 		int i;
 		pattern = xcalloc(argc, sizeof(const char *));
-		for (i = 1; i < argc; i++)
+		for (i = 1; i < argc; i++) {
 			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
+			argv_array_push(&ref_patterns, argv[i]);
+		}
 	}
 
 	remote = remote_get(dest);
@@ -96,7 +99,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
-	ref = transport_get_remote_refs(transport, NULL);
+	ref = transport_get_remote_refs(transport, &ref_patterns);
 	if (transport_disconnect(transport))
 		return 1;
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 4bf4d61ac..7d8aeb766 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -25,4 +25,12 @@ test_expect_success 'list refs with file:// using protocol v2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'ref advertisment is filtered with ls-remote using protocol v2' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=2 \
+		ls-remote "file://$(pwd)/file_parent" master 2>log &&
+
+	grep "ref-pattern master" log &&
+	! grep "refs/tags/" log
+'
+
 test_done
-- 
2.16.0.rc1.238.g530d649a79-goog

