Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026341F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965031AbeB1XYf (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:35 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:37267 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964933AbeB1XYa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:30 -0500
Received: by mail-yb0-f201.google.com with SMTP id 71-v6so2389556ybe.4
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=N5LLLNysjT5pnEUxLp/lBQNKQXqRn0KjKiH5IWOoKJI=;
        b=UNre0lV+O/bxx2yMyKs58dxkbphvZFEQnjmwR5mdi1vbVBDW/y3BHqlXHCGHQTvYVR
         gEtJ+xtL+rDnC0b9RdWCOoWyjbFWWU5aVmU0k3w28dKubvMyu0w7GcrF/abhsdsMLchv
         V+/eSmBHNI3/1SLd3zDCfGADoMSSAI9Xeneg8kFWBLwwZiy5/SvyqzB3PwDtgMaL1jHa
         M1dvF/nPBAd9PgERgLZXUZ8x4ccR3qu/MWa+RrRQLrejKH04BfBAPOTmclM6tIZhcqpf
         SGkp1QODyzt/2gkZmSIeNmZcbUW6OJuRgwvZ4TUq7Ps8+lEw8tlWtdiVjWrLGUUDV87O
         zIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=N5LLLNysjT5pnEUxLp/lBQNKQXqRn0KjKiH5IWOoKJI=;
        b=KVhnpPfB74iKfL60F5bB4f7/H0Sqbh9clMPyVKYHzY+pLGXRmMjUyDq09oXVJOhll+
         bcEa2N52rrjL5IxzpsB8zEOYa0lhogs9uPSoAqcnl34xp9UTDqPB4kbH+PNafLVqBl8D
         Hn1H+Q5U2eJlEljcqxb9AfanvYpGIt66U+002QUYvOH57fqT7OkGUshgqByzRnzLCAPa
         Uh0bkz9VjYycBPAiPellQXFk9HCWM2ryqwZTIm8Z8B+QJAA/eoBGKifQuq1ojjWGlCQA
         EGGdeW/O5MAqjmjDXnTjQcLK5tuI9GwitLoATelu6eESfUngqeJGDxgaAslwZ3GDON6c
         OJVA==
X-Gm-Message-State: APf1xPByU/yqv1GYlHZfr9MujdT8yGv5gRJO6C6MVGBMu/2ZuR8OTByw
        LMT8/8j40CdKwHlCDpwrMGoTp8rVa6sckJro59toxBD8XCnix33B594+DLsXlqYlP2ICw+Jj4A1
        6vivx78yw0yRTGeZRefJQ5T9wt6XF+bOgbcVQWcx9N5Ng0wu+ZFz10lpDQQ==
X-Google-Smtp-Source: AG47ELt5XAw7S+QVhTpB5lUEuoBViiQ5O1lIC536FHZZRdvnXvoz3Nayka0tIyi9gO/+0BFYln8P+pVj9zg=
MIME-Version: 1.0
X-Received: by 2002:a25:ba4c:: with SMTP id z12-v6mr3440584ybj.25.1519860269846;
 Wed, 28 Feb 2018 15:24:29 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:44 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-28-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 27/35] transport-helper: introduce stateless-connect
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the transport-helper capability 'stateless-connect'.  This
capability indicates that the transport-helper can be requested to run
the 'stateless-connect' command which should attempt to make a
stateless connection with a remote end.  Once established, the
connection can be used by the git client to communicate with
the remote end natively in a stateless-rpc manner as supported by
protocol v2.  This means that the client must send everything the server
needs in a single request as the client must not assume any
state-storing on the part of the server or transport.

If a stateless connection cannot be established then the remote-helper
will respond in the same manner as the 'connect' command indicating that
the client should fallback to using the dumb remote-helper commands.

A future patch will implement the 'stateless-connect' capability in our
http remote-helper (remote-curl) so that protocol v2 can be used using
the http transport.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/gitremote-helpers.txt | 32 +++++++++++++++++++++++++++++
 transport-helper.c                  | 11 ++++++++++
 transport.c                         |  1 +
 transport.h                         |  6 ++++++
 4 files changed, 50 insertions(+)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index 4a584f3c5..a8361ed95 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -102,6 +102,14 @@ Capabilities for Pushing
 +
 Supported commands: 'connect'.
 
+'stateless-connect'::
+	Experimental; for internal use only.
+	Can attempt to connect to a remote server for communication
+	using git's wire-protocol version 2.  This establishes a
+	stateless, half-duplex connection.
++
+Supported commands: 'stateless-connect'.
+
 'push'::
 	Can discover remote refs and push local commits and the
 	history leading up to them to new or existing remote refs.
@@ -136,6 +144,14 @@ Capabilities for Fetching
 +
 Supported commands: 'connect'.
 
+'stateless-connect'::
+	Experimental; for internal use only.
+	Can attempt to connect to a remote server for communication
+	using git's wire-protocol version 2.  This establishes a
+	stateless, half-duplex connection.
++
+Supported commands: 'stateless-connect'.
+
 'fetch'::
 	Can discover remote refs and transfer objects reachable from
 	them to the local object store.
@@ -375,6 +391,22 @@ Supported if the helper has the "export" capability.
 +
 Supported if the helper has the "connect" capability.
 
+'stateless-connect' <service>::
+	Experimental; for internal use only.
+	Connects to the given remote service for communication using
+	git's wire-protocol version 2.  This establishes a stateless,
+	half-duplex connection.  Valid replies to this command are empty
+	line (connection established), 'fallback' (no smart transport
+	support, fall back to dumb transports) and just exiting with
+	error message printed (can't connect, don't bother trying to
+	fall back).  After line feed terminating the positive (empty)
+	response, the output of the service starts.  Messages (both
+	request and response) must be terminated with a single flush
+	packet, allowing the remote helper to properly act as a proxy.
+	After the connection ends, the remote helper exits.
++
+Supported if the helper has the "stateless-connect" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
diff --git a/transport-helper.c b/transport-helper.c
index c032a2a87..e20a5076e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -12,6 +12,7 @@
 #include "argv-array.h"
 #include "refs.h"
 #include "transport-internal.h"
+#include "protocol.h"
 
 static int debug;
 
@@ -26,6 +27,7 @@ struct helper_data {
 		option : 1,
 		push : 1,
 		connect : 1,
+		stateless_connect : 1,
 		signed_tags : 1,
 		check_connectivity : 1,
 		no_disconnect_req : 1,
@@ -188,6 +190,8 @@ static struct child_process *get_helper(struct transport *transport)
 			refspecs[refspec_nr++] = xstrdup(arg);
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
+		} else if (!strcmp(capname, "stateless-connect")) {
+			data->stateless_connect = 1;
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags = 1;
 		} else if (skip_prefix(capname, "export-marks ", &arg)) {
@@ -612,6 +616,13 @@ static int process_connect_service(struct transport *transport,
 	if (data->connect) {
 		strbuf_addf(&cmdbuf, "connect %s\n", name);
 		ret = run_connect(transport, &cmdbuf);
+	} else if (data->stateless_connect &&
+		   (get_protocol_version_config() == protocol_v2) &&
+		   !strcmp("git-upload-pack", name)) {
+		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
+		ret = run_connect(transport, &cmdbuf);
+		if (ret)
+			transport->stateless_rpc = 1;
 	}
 
 	strbuf_release(&cmdbuf);
diff --git a/transport.c b/transport.c
index 8e38352c5..2e7b7a715 100644
--- a/transport.c
+++ b/transport.c
@@ -250,6 +250,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
+	args.stateless_rpc = transport->stateless_rpc;
 
 	if (!data->got_remote_heads)
 		refs_tmp = get_refs_via_connect(transport, 0, NULL);
diff --git a/transport.h b/transport.h
index daea4770c..0ef0d1902 100644
--- a/transport.h
+++ b/transport.h
@@ -55,6 +55,12 @@ struct transport {
 	 */
 	unsigned cloning : 1;
 
+	/*
+	 * Indicates that the transport is connected via a half-duplex
+	 * connection and should operate in stateless-rpc mode.
+	 */
+	unsigned stateless_rpc : 1;
+
 	/*
 	 * These strings will be passed to the {pre, post}-receive hook,
 	 * on the remote side, if both sides support the push options capability.
-- 
2.16.2.395.g2e18187dfd-goog

