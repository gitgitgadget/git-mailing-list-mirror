Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11C9B1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932232AbeBGBN5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:57 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:33258 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeBGBNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:55 -0500
Received: by mail-ot0-f202.google.com with SMTP id r48so2160650otb.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=REgx5Guhpvfv4sCPoiwjaYHeOX1bAwQm2ihsIIdrhXY=;
        b=qt4dn8IunDUZ8ulXVMg2ZKq3bIezklTeAZAyXRg43jx7hdmeKgdD+aoRXyPx+hjD4n
         JAriLw6L9OZ2apC8evvIiIyFbvrRKPAyK2fol+rFtjag7Tw3SzzaUAInvZ/0HdQajG7G
         SZ8bQPzbLuJCeSLHMkV7k+IoNcHi6QH2toUNt9b02kvhJVVRosCZoYrC9VLALPjLHlez
         HL7y/O4nq2eUmF4aXjIpOKpigs5gYv77IpPBGP9Fiw7QJR3mK9ge1+DS3BuQJ1s84+Z/
         CJnqWyqONx2Izxyti7zY8GGHps9Y1rWx9tUDiyU+98ZyhbUcAVfFZ58GT2WMzXAY7oAM
         4ivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=REgx5Guhpvfv4sCPoiwjaYHeOX1bAwQm2ihsIIdrhXY=;
        b=F2eWhCTiVPH/ARmOKtCO9qmUFqLiUToXA/Wmh8NTZAZv90+j0PQRLn/p6IMaPr05wt
         jBhBbzyVfpnezEvP8P74xjz8Ec1Vzzg1gQSqn/0IYEk1VGo4fB+bBwb1MAoxN/owH+yY
         wJrOdhzaaoWpoWN62KSvWD5ezBxFGPG+/mYFdsOJaB/2eiXr7jpcZXltTLkH9Rfqlp2Y
         GVtO4IwDTVyxwZbxSnS+xdU2hojXGE1iwXzCfqE3qtU62bj6RwOkF9/Vg9eCNWDHQiIE
         ItKzLefDEAiKBvSjQv1b7/NqJ052kHZp8egPmubUyBD1CCHqQgSohe7lgmBmRDFO5IMM
         0BfA==
X-Gm-Message-State: APf1xPDA70Uk4FAX/Uspkp2fBSmRvPCjc+w/kwwEP5/SxLt3eCaJaPU1
        R3+SJNRoQTTikEaZQJdnptjbw8Wr0RyPIWwoB+vprf7BD0z6GTPOK4f0CNMCVuowyNo0lyb1C6E
        jdYoPwq9uDkQ2wthZKtjPDKENH66lb0hZG2NzZ+s2OiMABAygxSWGeWHrZw==
X-Google-Smtp-Source: AH8x2244o8x4uE4MXGINP5fr4/OjMUGKw5NEroQnbE3WO8+to/AjPQfe3axHq7r5MEnfeqLBSrTRyfonkMg=
MIME-Version: 1.0
X-Received: by 10.157.3.196 with SMTP id f62mr2324068otf.54.1517966034979;
 Tue, 06 Feb 2018 17:13:54 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:54 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-18-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 17/35] ls-remote: pass ref patterns when requesting a
 remote's refs
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

Construct an argv_array of the ref patterns supplied via the command
line and pass them to 'transport_get_remote_refs()' to be used when
communicating protocol v2 so that the server can limit the ref
advertisement based on the supplied patterns.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-remote.c    |  7 +++++--
 t/t5702-protocol-v2.sh | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

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
index 1e42b5588..a33ff6597 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -30,6 +30,14 @@ test_expect_success 'list refs with git:// using protocol v2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'ref advertisment is filtered with ls-remote using protocol v2' '
+	GIT_TRACE_PACKET=1 git -c protocol.version=2 \
+		ls-remote "$GIT_DAEMON_URL/parent" master 2>log &&
+
+	grep "ref-pattern master" log &&
+	! grep "refs/tags/" log
+'
+
 stop_git_daemon
 
 # Test protocol v2 with 'file://' transport
@@ -50,4 +58,12 @@ test_expect_success 'list refs with file:// using protocol v2' '
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

