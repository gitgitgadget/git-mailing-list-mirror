Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DD11F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeACATf (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:19:35 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:43565 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeACATQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:19:16 -0500
Received: by mail-io0-f196.google.com with SMTP id w188so455952iod.10
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xrCVsUHw1EeAw9TjTr8OQjlKSCPX4CaUCgEx/mjeTcE=;
        b=YMOMH/4sMFweAhsmYwwA2wX7Ou3Z2ksLyE/1SZKsMmQ0uq7jolV8o8KljUKv4/K1x9
         IfQVYeStdqWchEgEwQIRGxiOqAysQEj7E5i1suJPFa6bKe6MvqC7NpQz7f+MaYaP98AY
         VjkPliYDHwCiwz0663zHLhhWGZukbMqEL15H6V/Orj5eb0oftWOTldlS/G/c6lvRUZuv
         Y/VIPkf/OsDZ0q4wLYp2mfiOp7I6/iKA/UYawEFt4eC7LSqFZnqG6eK0yEhrNouXHm0+
         D9MCpV7CsHZlzsRk/ZApU9MgKI6qU2ko5H4hUzAUg3HRa1Nxo41/teUtOwKFf1PFMZa4
         VlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xrCVsUHw1EeAw9TjTr8OQjlKSCPX4CaUCgEx/mjeTcE=;
        b=kUyvdLbwluR7Hp9rotx3SiV3crMvYM57oJQ5kqwZwFGF31kdW5GuNiWfTYpJ5Jo0um
         va8YhSXOMj94ZTgAhGFusaGuMC/xJcWkHlexGWZnQTaasSBexS0WBIWXJ7kyt7QeJblm
         W3zSCKemDgtsmdKyNibc2uOk4709EndQzf45bAnFl7Ga9gizVdoePrHDvONtgr/yHbyZ
         S4CvtB4h+0Xhl/Av+n09BibGf3GM4fzrrhVsR9DN1pw0Qe+BQfh4HMpfeNyJ9v+nbm+N
         XurhQkA7boF10aL9gCMenZmyOMMVhXOuuYzNaLJsp9snFC6VxVwgykVgmLFkaxUYZ1ye
         ngqw==
X-Gm-Message-State: AKGB3mLXCCT0PCb/bGmah7bz8aa+kKe6z0bL8tyeGlUojmNOjMfF+CpV
        1pZ1Dl/U1TpMqzuCVROm6urxUh1h9Og=
X-Google-Smtp-Source: ACJfBosr2aggY4t29a3hRVnNUw9X+SGJwKpf9tk/Lct5n4vqp4ToovGtyMmukRb6prztdEA4PcM4UA==
X-Received: by 10.107.129.40 with SMTP id c40mr58358061iod.169.1514938755441;
        Tue, 02 Jan 2018 16:19:15 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q2sm12679ite.17.2018.01.02.16.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 16:19:14 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 23/26] transport-helper: introduce connect-half-duplex
Date:   Tue,  2 Jan 2018 16:18:25 -0800
Message-Id: <20180103001828.205012-24-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20180103001828.205012-1-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the transport-helper capability 'connect-half-duplex'.  This
capability indicates that the transport-helper can be requested to run
the 'connect-half-duplex' command which should attempt to make a
half-duplex connection with a remote end.  Once established, the
half-duplex connection can be used by the git client to communicate with
the remote end natively in a stateles-rpc manner as supported by
protocol v2.

If a half-duplex connection cannot be established then the remote-helper
will respond in the same manner as the 'connect' command indicating that
the client should fallback to using the dumb remote-helper commands.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport-helper.c | 8 ++++++++
 transport.c        | 1 +
 transport.h        | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index c032a2a87..d037609bc 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -26,6 +26,7 @@ struct helper_data {
 		option : 1,
 		push : 1,
 		connect : 1,
+		connect_half_duplex : 1,
 		signed_tags : 1,
 		check_connectivity : 1,
 		no_disconnect_req : 1,
@@ -188,6 +189,8 @@ static struct child_process *get_helper(struct transport *transport)
 			refspecs[refspec_nr++] = xstrdup(arg);
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
+		} else if (!strcmp(capname, "connect-half-duplex")) {
+			data->connect_half_duplex = 1;
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags = 1;
 		} else if (skip_prefix(capname, "export-marks ", &arg)) {
@@ -612,6 +615,11 @@ static int process_connect_service(struct transport *transport,
 	if (data->connect) {
 		strbuf_addf(&cmdbuf, "connect %s\n", name);
 		ret = run_connect(transport, &cmdbuf);
+	} else if (data->connect_half_duplex) {
+		strbuf_addf(&cmdbuf, "connect-half-duplex %s\n", name);
+		ret = run_connect(transport, &cmdbuf);
+		if (ret)
+			transport->stateless_rpc = 1;
 	}
 
 	strbuf_release(&cmdbuf);
diff --git a/transport.c b/transport.c
index 4fdbd9adc..aafb8fbb4 100644
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
index 4b656f315..9eac809ee 100644
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
2.15.1.620.gb9897f4670-goog

