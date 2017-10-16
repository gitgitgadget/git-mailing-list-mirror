Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D6620437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754282AbdJPRz6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:55:58 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:54339 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbdJPRzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:55:53 -0400
Received: by mail-io0-f179.google.com with SMTP id e89so9284436ioi.11
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8uSRrxEYpUmfYC5OJKpWTC+gyjIJhnbTN3aY7FkC8Gk=;
        b=wN9No7JO4DIyLL13J/LcwxhVclNMxUvkl5t+eIVm5ksOfIDKHR6ANOff1B1ZGYbWJQ
         OXCcxK12s80EtD7E0nhu9ZzDTFS1jHpCEkXH8gkRLhRHuwUHCzFrpY0RuoTruFVmobyG
         GRee0Kmt1MJ3sp3LfbhwGYaygrPOa2OQNQuMWP09dOIUtUbz9/+eBzuoEJMK5ayBiOeS
         aCb+E+2u3GiTbnTZCckyc+9VWdpWoxBHxLPqdyLAeKHUHhsFqVtRdl1g+1QUc+auaX9s
         BVWCnM3eoScVMyL/axRPZLuM8czRZFS+WAvMSDkY97+NZ3+rZ/k8kozPAGgQ/1ZEEwCn
         kgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8uSRrxEYpUmfYC5OJKpWTC+gyjIJhnbTN3aY7FkC8Gk=;
        b=GTBJbH/ekAfey8pWbnutV7T/HhhNhahDUck7+0MPWsveLJp1myOV3qCg9lul/O6Rmg
         EyNPAVD1V/9+M6477LFkn6noM1hQcV6T6MkwhErMe5MP3phLWqGIYm+HHfsDPUHJFpX7
         e96yyoydXVyN2vY9S9A4jNBglT+C1YZWyMpnBwhTP2bk8r3S5GorJZs11D0xw2z6SGwL
         SpXcd3YJXH1w1IbRHqg/vnQkW+RFkJbFs14SOSF5K+TWBklknF+31z45+Qwq/NKCkQQb
         ZtdNFZMSCmKhSbcIiNsBbjpXtjej477n8HfRbfw4rmhp9SrxRvWm0C8teLqMjl99Dg3O
         PX7A==
X-Gm-Message-State: AMCzsaUyVCVsy1AOn+vU8YehfTzxebJdwt5Dmw10ItKDEdV0LAU+Uoy/
        NI0/9IRh8z5SXjKj3TZrLJzNKNMDziU=
X-Google-Smtp-Source: ABhQp+T6oRkk9Z3CWTPz4j2kiIhA2WpfEoKrf9Aq3HGMgin1q7C38heMl1tFLPyuvWo4jYgcYzKqkA==
X-Received: by 10.107.188.199 with SMTP id m190mr12546255iof.255.1508176552669;
        Mon, 16 Oct 2017 10:55:52 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.55.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:55:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 06/11] connect: teach client to recognize v1 server response
Date:   Mon, 16 Oct 2017 10:55:27 -0700
Message-Id: <20171016175532.73459-7-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171016175532.73459-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach a client to recognize that a server understands protocol v1 by
looking at the first pkt-line the server sends in response.  This is
done by looking for the response "version 1" send by upload-pack or
receive-pack.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 8e2e276b6..a5e708a61 100644
--- a/connect.c
+++ b/connect.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "transport.h"
 #include "strbuf.h"
+#include "protocol.h"
 
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
@@ -129,9 +130,23 @@ static int read_remote_ref(int in, char **src_buf, size_t *src_len,
 	return len;
 }
 
-#define EXPECTING_FIRST_REF 0
-#define EXPECTING_REF 1
-#define EXPECTING_SHALLOW 2
+#define EXPECTING_PROTOCOL_VERSION 0
+#define EXPECTING_FIRST_REF 1
+#define EXPECTING_REF 2
+#define EXPECTING_SHALLOW 3
+
+/* Returns 1 if packet_buffer is a protocol version pkt-line, 0 otherwise. */
+static int process_protocol_version(void)
+{
+	switch (determine_protocol_version_client(packet_buffer)) {
+	case protocol_v1:
+		return 1;
+	case protocol_v0:
+		return 0;
+	default:
+		die("server is speaking an unknown protocol");
+	}
+}
 
 static void process_capabilities(int *len)
 {
@@ -224,12 +239,19 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	 */
 	int responded = 0;
 	int len;
-	int state = EXPECTING_FIRST_REF;
+	int state = EXPECTING_PROTOCOL_VERSION;
 
 	*list = NULL;
 
 	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
 		switch (state) {
+		case EXPECTING_PROTOCOL_VERSION:
+			if (process_protocol_version()) {
+				state = EXPECTING_FIRST_REF;
+				break;
+			}
+			state = EXPECTING_FIRST_REF;
+			/* fallthrough */
 		case EXPECTING_FIRST_REF:
 			process_capabilities(&len);
 			if (process_dummy_ref()) {
-- 
2.15.0.rc0.271.g36b669edcc-goog

