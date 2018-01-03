Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774DB1F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeACATI (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:08 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35620 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeACATG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:06 -0500
Received: by mail-io0-f195.google.com with SMTP id 14so480214iou.2
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBdXr5b2/oicuOhH1Kq4kvj0ZMoWo1n6O5WS57xn0mQ=;
        b=ecJhV7W8/1iunwdwPM0lLXvYx8hBn9NP83SWAkGDRAUYWGgwMECyFnl/voenvPsZt/
         CCJl7PhpDPflIjgNVDUxx9qwYMZjbWFry5qD+azPsZhRdj7E93vsYckXjtBEdN394d0m
         YtIkWNzedCUtYGW2LS7c5RFCcoPFlyVfZ6s6r8B0Nmb+cUWtChJE+NSlYv5yxjyYKdNa
         9e6EYIh2z8NbjAGHrND602yYBvGyv+R/rkhaQeN74GWL5C6VwhlNKztRcybeQWhH67KM
         +9V9ZS6ImZAD4m39/pU+m2CbagufPnSkmVvop/O84FYaGzyVtHoLXHrUXz1gbyalbDpM
         MXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBdXr5b2/oicuOhH1Kq4kvj0ZMoWo1n6O5WS57xn0mQ=;
        b=dKHUlsnzG/YnrqbOAmQahhjWZrryXX0/Y2dQFtI+8axwZxvvjZvI+xfoQQE3hoxWz8
         fhYasc19eHVzvOo/FswAm15kzj4gF/RYKiHOlvNGo7xLJ73GTkblmFCXR1t6tdf3v0FP
         /mWOMDGLD0urYe5KSJbYkOJvfs81fu36At4tgKwwIO5OIDX04AkFYcfdE7SnmKA94HCO
         1G0k10XLoytfCzf0pCfhXAyh65eIZY8pg/4wR9bJcjs9HzbnK+nqRaE1en6iFD6yESh3
         xkLKMdbDIuynJZA0sxHPDtv/P9dOGiRXlKAAYqoKtmOq/5dD6K4RF1xTm/dvU3PkaIcl
         jZaA==
X-Gm-Message-State: AKGB3mJ1dk6JERxWT6ZIrq3IyCW097uy1Owq+zlflPOZsmioQa7SzTVq
        XFbTJ5IkEYsQ577XOqnf2G/qMQz3mrA=
X-Google-Smtp-Source: ACJfBosK4FaMpZ2LOfpa4GDYdgWQTHJ1qG5bg6UQ/h/0bQmymtOox5kSvBZkDus9qnxH/M1ejpE98A==
X-Received: by 10.107.30.147 with SMTP id e141mr12312405ioe.119.1514938744721;
        Tue, 02 Jan 2018 16:19:04 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:04 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 16/26] ls-remote: pass ref patterns when requesting a remote's refs
Date:   Tue,  2 Jan 2018 16:18:18 -0800
Message-Id: <20180103001828.205012-17-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
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
 t/t5701-protocol-v2.sh | 8 ++++++++
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
 
diff --git a/t/t5701-protocol-v2.sh b/t/t5701-protocol-v2.sh
index 4bf4d61ac..7d8aeb766 100755
--- a/t/t5701-protocol-v2.sh
+++ b/t/t5701-protocol-v2.sh
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
2.15.1.620.gb9897f4670-goog

