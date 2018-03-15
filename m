Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A321F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeCORcz (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:55 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:42472 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbeCORcw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:52 -0400
Received: by mail-yw0-f201.google.com with SMTP id g1so7681005ywb.9
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=GglT8KRROHYOZCVFN94GSU9k0I6w7M6tdxSWic8vEVU=;
        b=t+j386T8/FQ9fmspgezVfqjtPGwdF4KGO0FATtqUG0ZpbPqU0vyYpoEnpWqmPlJyYP
         oE/uxmY6+nABH5bRclQd3nFGnAwBheLvylPJct1RKx+uLiwBq0akz4cOQJUHqZPIaszc
         KiU7+o+N+SJtEFbVRHd4ExCE85vwPn7xliVWEE7ksMehHdhJ0ZtlJZ5Xo/hNQpW09fhC
         qzj4EcXT6EjROnKKM1DxAkDzwosGxBSOieVdKwlqgxDGyXqwZdVdFFr+JUl8BsCQGKew
         fCVat2intx+MF3/byo342IfyrDEOZVt2ZsdDZ2vxl6HVwj+NSSEaoeLQp7GbEz87SI8N
         D+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=GglT8KRROHYOZCVFN94GSU9k0I6w7M6tdxSWic8vEVU=;
        b=VnvSMWAH0ZBFWlPjc6x/z2Cx62Mux0KdusPpTigLRE5Fu7iMH5k2UStDo8w40j9PBO
         +UrBAu5MXqgo8koczVbkVuUy+TSB/bOATddW+tuW+4xPE6y39yc07xR2q42O7S0YTYSg
         O4INjMzVt+HbdK27HiPg1eSDLOaUdi1pce6oMH/KIH0I1OfvogUbQ6+5UPya4EPKig3I
         VkOol444DPpk3ddLrRu73zDRrOB/vJpc8NK8xWUfau+neBpu3+WZx6b+zZG+wUYn4YHG
         Cvb3JfVlW/RdnjoYDVfPOHPza3s6mHcoPliPwG4V/m3UCnB+V2tZVLwyPLxQnVnDsP5s
         OdCA==
X-Gm-Message-State: AElRT7HF6sAi/ewScjsCBoh6JNVNY0xzy+DSWIrWn1Hmr1M0eR8l6Tud
        qRj1lRoOfCheC/v5PJoe2TbmAenMTUMwbNBzSubp5ltbnoFJ6DE5Gj4Efo/nEQp6hUt+GZQLHxq
        kU732KNpO8DB4PHsGu6WxWa9j+uwo6Z4+k82h4qaL/+2wBClACjzDuxieAw==
X-Google-Smtp-Source: AG47ELuN0LR64RcDCA18DkqhN+hSKHEYKXE5QFNKMHKwL0jCV1o9i5GA0O4VVNsmiRxz4BElEi1DLuE3JOI=
MIME-Version: 1.0
X-Received: by 2002:a25:ba4c:: with SMTP id z12-v6mr4077573ybj.25.1521135171748;
 Thu, 15 Mar 2018 10:32:51 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:34 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-28-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 27/35] transport-helper: introduce stateless-connect
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
index 4a584f3c5d..cd9b34d230 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -102,6 +102,14 @@ Capabilities for Pushing
 +
 Supported commands: 'connect'.
 
+'stateless-connect'::
+	Experimental; for internal use only.
+	Can attempt to connect to a remote server for communication
+	using git's wire-protocol version 2.  See the documentation
+	for the stateless-connect command for more information.
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
+	using git's wire-protocol version 2.  See the documentation
+	for the stateless-connect command for more information.
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
+	git's wire-protocol version 2.  Valid replies to this command
+	are empty line (connection established), 'fallback' (no smart
+	transport support, fall back to dumb transports) and just
+	exiting with error message printed (can't connect, don't bother
+	trying to fall back).  After line feed terminating the positive
+	(empty) response, the output of the service starts.  Messages
+	(both request and response) must consist of zero or more
+	PKT-LINEs, terminating in a flush packet. The client must not
+	expect the server to store any state in between request-response
+	pairs.  After the connection ends, the remote helper exits.
++
+Supported if the helper has the "stateless-connect" capability.
+
 If a fatal error occurs, the program writes the error message to
 stderr and exits. The caller should expect that a suitable error
 message has been printed if the child closes the connection without
diff --git a/transport-helper.c b/transport-helper.c
index 830f21f0a9..aecbc4a845 100644
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
index 9152a45b38..342db492ca 100644
--- a/transport.c
+++ b/transport.c
@@ -252,6 +252,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
+	args.stateless_rpc = transport->stateless_rpc;
 
 	if (!data->got_remote_heads)
 		refs_tmp = get_refs_via_connect(transport, 0, NULL);
diff --git a/transport.h b/transport.h
index 83992a4257..0e602d4d47 100644
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
2.16.2.804.g6dcf76e118-goog

