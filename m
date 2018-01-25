Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2919B1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeAYX7p (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:45 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:56843 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeAYX7k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:40 -0500
Received: by mail-ot0-f201.google.com with SMTP id x4so5932041otx.23
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=VphBVkCf/n6LqM6CjWl+BvTKwHZ0y07DXr/a8zpWJYI=;
        b=DOuwjfz04wdKipGUi3nZ5wuHwWVPjokCEPHhjsz7DqAFMhQgiuCzxYlhJ9owNjIyKe
         7Gxw+ClrmMf1YFLFKhE38lZk2a0mif/RCqH2FSFHf9UQZUI+Z7iHSI2S2J+dNjirxezU
         pAu4ACZlU7UT1S5r92IEk24gdCJjMb6vt07WtCBmLMRCA50jYmnGEezbg1d3AxjHVf9b
         nzwtSRK/9c7C5a7HPWQ9AjTqQ33KZjni+wsoL+WL9ameH9BkFhbN7mRLEl59OJVNqNNe
         tO53MoRfdQw5s1+X7zlW/csO8fEnqvom2xEF5oCmsh9v5b+4MTR/aMh3i0rdt0yMoEcS
         Um2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=VphBVkCf/n6LqM6CjWl+BvTKwHZ0y07DXr/a8zpWJYI=;
        b=QONX4dI5ks2SYHYbf0NZ/DcZprRsDc+C57liHh07s7lzUpsjlosWYCdjEjFvfX10Qi
         jqHpqlFVdmqgFKidkHdP67+LFE/6cbiarw/e/gxRKvK6e9UXPHfZPSAix+V1neGoT1qY
         sICleOZUZReY2BbWfYrmKYWBPxMSpnNRRWk3cLETSENs2sedGsFG4a8Kt/GX+H4gRDjH
         nuqbrWX6hFWQfwvEGE5MiOUkFXSpBK8fne09OL8EEaWkF/u1ZYqVoSY3TGYEn32vurbA
         GwpaUbUMcFeuKlqs4c7PnDDyryet46pGosi2rhE58ZYxbbUc3NYijrPrXBSZ0PgWZ+NN
         kDEw==
X-Gm-Message-State: AKwxytdwgCpU/afxlFsxaWymXSG0qL7rfBvgizF5cpjRtmP0mwgDCbNe
        otRmLzSoXwEx72YNxHjIQRDxS0XH+FQcbSXgYz7gXrnQvM4Fiv2NfdL4wy5XvpqPfLMRGIOWYbG
        D90qYhpAAQj0dybexZ2ewAMRn93DGnmMCKhZkcvEKtyCSrXlBnNYkdL1Cog==
X-Google-Smtp-Source: AH8x227t9Z0mksl12+fxA+cy66IkYUMmAcsbx9NPpVrQiTt5hgsZJkxU0ml1ffXuNwIxUQeCKRAunwbOnuE=
MIME-Version: 1.0
X-Received: by 10.202.226.18 with SMTP id z18mr9681571oig.113.1516924779585;
 Thu, 25 Jan 2018 15:59:39 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:35 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-25-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 24/27] transport-helper: introduce stateless-connect
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
2.16.0.rc1.238.g530d649a79-goog

