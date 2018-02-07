Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D1E1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbeBGBOY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:14:24 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:48508 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeBGBOW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:14:22 -0500
Received: by mail-vk0-f74.google.com with SMTP id o64so2159130vka.15
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=PppxHk/x/apyMZlUIvQ30XXfmrq25IXR54pjZT3jDNE=;
        b=u6SaFOU1t7fZIUwwACGMsMGgLWakIy+3ZYKEjrwcD5FnqtoYr5nRinxstvI0LIGL/5
         G6VEUDZ6Q/4dN9guQy8EKrxHSmG4mRauVr/XeqUX8H/O4etuKhycatXWsAZXtbKC9dw+
         P8TOEUu8W8tlCBvhirGU/OydmuEbYcJ3aF0GE3bpRO1tQ+eMSOZUIpEblJ1E3PpcO1PS
         3u8qiK8CkNM4ItIeFCpkmFsWXObSbk0QAam2AjEiY2vrMZ8GGfCN//9MRnHHJxGYLn5q
         782Wyow02H+Mh5Y6AEgGCqCnmlfd19KvmzBOGG69ymaqQtrNKN9FtGcLfb37af2PtY6O
         WxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=PppxHk/x/apyMZlUIvQ30XXfmrq25IXR54pjZT3jDNE=;
        b=ORyrk4GcDTQwtSNbkWhNB5kH5QvG4D2IhJLyo2Qse7cErmCwXKMuP5hpXPRkMtrj8t
         RNSbHTHmbtKAfEXpG4JNQCVz5bDTs8rFsHbsOj3t9Ph1g33yU5g5H70lNQgGYLxlgWgY
         kXF/NyQqZ0kjTUgfmcqTSIrTCzrKBO05wsNhQ1bgjsRFBoY6h+p/XrLFgr4sI3ibmqD3
         hqV50JjTWhox7/xqAOTe7q6Q3wuWpT3oljR4Fur7d6TlDM/oBbCvixpPshs84i3vKEml
         m91KfcsdmkqXEDYkg/b7Zz1fd09smFt3SRTF1Z3fXJn6eWcObMYsKAW9sdCH8iyS6d3C
         xSdw==
X-Gm-Message-State: APf1xPAC9U7YT2bz5pAzxudLEZzbANlsxmqbBjX6bFQD7K+u3zmz42Ob
        IAQKCJZN4MClILNei9Hp2ZTh7zPm+LgETXvGtYEzcRPPO63aoohMly4jqE/UN/cVkIPOpv0zC4d
        lGFhyjZqFuKzDpNtunDoBrQI6HMWsfe+u85X5KVRDmktctKCXVdj4hEgVrA==
X-Google-Smtp-Source: AH8x227jfbhb2be2w8VQdWlKxwqeE8+1yZDlCggCSdaIf2ir6vwhdEOby0f3T01NDNpZwbSzoODNlN/K6zE=
MIME-Version: 1.0
X-Received: by 10.31.3.207 with SMTP id f76mr2071859vki.41.1517966061316; Tue,
 06 Feb 2018 17:14:21 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:13:05 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-29-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 28/35] transport-helper: introduce stateless-connect
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

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport-helper.c | 8 ++++++++
 transport.c        | 1 +
 transport.h        | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index c032a2a87..82eb57c4a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -26,6 +26,7 @@ struct helper_data {
 		option : 1,
 		push : 1,
 		connect : 1,
+		stateless_connect : 1,
 		signed_tags : 1,
 		check_connectivity : 1,
 		no_disconnect_req : 1,
@@ -188,6 +189,8 @@ static struct child_process *get_helper(struct transport *transport)
 			refspecs[refspec_nr++] = xstrdup(arg);
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
+		} else if (!strcmp(capname, "stateless-connect")) {
+			data->stateless_connect = 1;
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags = 1;
 		} else if (skip_prefix(capname, "export-marks ", &arg)) {
@@ -612,6 +615,11 @@ static int process_connect_service(struct transport *transport,
 	if (data->connect) {
 		strbuf_addf(&cmdbuf, "connect %s\n", name);
 		ret = run_connect(transport, &cmdbuf);
+	} else if (data->stateless_connect) {
+		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
+		ret = run_connect(transport, &cmdbuf);
+		if (ret)
+			transport->stateless_rpc = 1;
 	}
 
 	strbuf_release(&cmdbuf);
diff --git a/transport.c b/transport.c
index c275f46ed..9125174f7 100644
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
2.16.0.rc1.238.g530d649a79-goog

