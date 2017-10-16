Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1477C20437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754216AbdJPRzw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:55:52 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:46424 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754176AbdJPRzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:55:49 -0400
Received: by mail-it0-f48.google.com with SMTP id f187so2275054itb.1
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cH6zpSSA6F8qlhNVOge2A6AzCxA8Ik1sBTcxpgucoww=;
        b=qbExJM5a80LXUE8Uo/OZXWANUv9g0ERgaXmf2Lzd8kYVZdb/CDOZwjnqQga2zTg0KW
         OTLvSuTtOPJIWLwGL0znRCXQ69bPvBb3rPUKrl8MaSATnt5DHdhyc5Ua37JjD1P1QKuD
         Lx7bp8KqavaAhmXYTHsMVISyb3xcAt1TWJQEVgZN7Xb5DWy2X22NTgk5JIwQgutDzfQI
         gvaste+UWHfP2k5ZqpTvqXpcTDX/8NLnaXZDxzN84L+gYYdt31r9renaH4xO9T0YAaMo
         35Loo9a6r6fhnXBmzJXJsuUfsRhBctwQOIEKLXGLuwjFTAg9qmH1p+baCUSNZDQ2DVQX
         IOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cH6zpSSA6F8qlhNVOge2A6AzCxA8Ik1sBTcxpgucoww=;
        b=O37xvR5GCXX8gWOwpwT+JqYy4VcvX2yJaaYnaggCTtDt89M8ET6ZhEKnnNj/IdUxE5
         94cWP85hiaJNt66+m9u+hQirOWVJwI/Vh09LiuPrNDx+5i5vYLZ288GlSqamN48H5Rs/
         LHsjwvMfgBV4cbp6dZDFRXvWkkPjYhfe4m6LJT5mOa+2wX7YtLiD7y8UMQ5M67Gu1zrY
         L/G0FFGFIcKeaZJ7Yi6SS14CaTxt2MpKJQkgjqCoLvjHhrWsXRoj5Dmqf9NYgd8ZGzD6
         t/vkVyKlbynOxq5Inw1yb/0Vz3spqKQJXC49i2Xi8ucKio2qTQ0C7sut7s0WhS4lxXB8
         fZow==
X-Gm-Message-State: AMCzsaUR89x4hBEALQbhwbUmugMEKp91UlKQwsex/7gzc1wJFWMDVGT/
        BBe5NYK9qA0yNEjyUEMTAYqrAt8xMS8=
X-Google-Smtp-Source: ABhQp+T7UQdc6HFWc6BlYXEDfWLPWwg45z+jP4wr2PtpVca1ytDBnl3TD0sjpiS5azEkLfKRFxhT1Q==
X-Received: by 10.36.227.68 with SMTP id d65mr2019351ith.59.1508176547640;
        Mon, 16 Oct 2017 10:55:47 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:55:46 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 03/11] protocol: introduce protocol extension mechanisms
Date:   Mon, 16 Oct 2017 10:55:24 -0700
Message-Id: <20171016175532.73459-4-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171016175532.73459-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create protocol.{c,h} and provide functions which future servers and
clients can use to determine which protocol to use or is being used.

Also introduce the 'GIT_PROTOCOL' environment variable which will be
used to communicate a colon separated list of keys with optional values
to a server.  Unknown keys and values must be tolerated.  This mechanism
is used to communicate which version of the wire protocol a client would
like to use with a server.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt | 17 +++++++++++
 Documentation/git.txt    |  6 ++++
 Makefile                 |  1 +
 cache.h                  |  8 +++++
 protocol.c               | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 protocol.h               | 33 ++++++++++++++++++++
 6 files changed, 144 insertions(+)
 create mode 100644 protocol.c
 create mode 100644 protocol.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dc4e3f58a..b78747abc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2517,6 +2517,23 @@ The protocol names currently used by git are:
     `hg` to allow the `git-remote-hg` helper)
 --
 
+protocol.version::
+	Experimental. If set, clients will attempt to communicate with a
+	server using the specified protocol version.  If unset, no
+	attempt will be made by the client to communicate using a
+	particular protocol version, this results in protocol version 0
+	being used.
+	Supported versions:
++
+--
+
+* `0` - the original wire protocol.
+
+* `1` - the original wire protocol with the addition of a version string
+  in the initial response from the server.
+
+--
+
 pull.ff::
 	By default, Git does not create an extra merge commit when merging
 	a commit that is a descendant of the current commit. Instead, the
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6e3a6767e..7518ea3af 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -697,6 +697,12 @@ of clones and fetches.
 	which feed potentially-untrusted URLS to git commands.  See
 	linkgit:git-config[1] for more details.
 
+`GIT_PROTOCOL`::
+	For internal use only.  Used in handshaking the wire protocol.
+	Contains a colon ':' separated list of keys with optional values
+	'key[=value]'.  Presence of unknown keys and values must be
+	ignored.
+
 Discussion[[Discussion]]
 ------------------------
 
diff --git a/Makefile b/Makefile
index ed4ca438b..9ce68cded 100644
--- a/Makefile
+++ b/Makefile
@@ -842,6 +842,7 @@ LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
 LIB_OBJS += prompt.o
+LIB_OBJS += protocol.o
 LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
diff --git a/cache.h b/cache.h
index 49b083ee0..c74b73671 100644
--- a/cache.h
+++ b/cache.h
@@ -445,6 +445,14 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
 #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
 
+/*
+ * Environment variable used in handshaking the wire protocol.
+ * Contains a colon ':' separated list of keys with optional values
+ * 'key[=value]'.  Presence of unknown keys and values must be
+ * ignored.
+ */
+#define GIT_PROTOCOL_ENVIRONMENT "GIT_PROTOCOL"
+
 /*
  * This environment variable is expected to contain a boolean indicating
  * whether we should or should not treat:
diff --git a/protocol.c b/protocol.c
new file mode 100644
index 000000000..43012b7eb
--- /dev/null
+++ b/protocol.c
@@ -0,0 +1,79 @@
+#include "cache.h"
+#include "config.h"
+#include "protocol.h"
+
+static enum protocol_version parse_protocol_version(const char *value)
+{
+	if (!strcmp(value, "0"))
+		return protocol_v0;
+	else if (!strcmp(value, "1"))
+		return protocol_v1;
+	else
+		return protocol_unknown_version;
+}
+
+enum protocol_version get_protocol_version_config(void)
+{
+	const char *value;
+	if (!git_config_get_string_const("protocol.version", &value)) {
+		enum protocol_version version = parse_protocol_version(value);
+
+		if (version == protocol_unknown_version)
+			die("unknown value for config 'protocol.version': %s",
+			    value);
+
+		return version;
+	}
+
+	return protocol_v0;
+}
+
+enum protocol_version determine_protocol_version_server(void)
+{
+	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
+	enum protocol_version version = protocol_v0;
+
+	/*
+	 * Determine which protocol version the client has requested.  Since
+	 * multiple 'version' keys can be sent by the client, indicating that
+	 * the client is okay to speak any of them, select the greatest version
+	 * that the client has requested.  This is due to the assumption that
+	 * the most recent protocol version will be the most state-of-the-art.
+	 */
+	if (git_protocol) {
+		struct string_list list = STRING_LIST_INIT_DUP;
+		const struct string_list_item *item;
+		string_list_split(&list, git_protocol, ':', -1);
+
+		for_each_string_list_item(item, &list) {
+			const char *value;
+			enum protocol_version v;
+
+			if (skip_prefix(item->string, "version=", &value)) {
+				v = parse_protocol_version(value);
+				if (v > version)
+					version = v;
+			}
+		}
+
+		string_list_clear(&list, 0);
+	}
+
+	return version;
+}
+
+enum protocol_version determine_protocol_version_client(const char *server_response)
+{
+	enum protocol_version version = protocol_v0;
+
+	if (skip_prefix(server_response, "version ", &server_response)) {
+		version = parse_protocol_version(server_response);
+
+		if (version == protocol_unknown_version)
+			die("server is speaking an unknown protocol");
+		if (version == protocol_v0)
+			die("protocol error: server explicitly said version 0");
+	}
+
+	return version;
+}
diff --git a/protocol.h b/protocol.h
new file mode 100644
index 000000000..1b2bc94a8
--- /dev/null
+++ b/protocol.h
@@ -0,0 +1,33 @@
+#ifndef PROTOCOL_H
+#define PROTOCOL_H
+
+enum protocol_version {
+	protocol_unknown_version = -1,
+	protocol_v0 = 0,
+	protocol_v1 = 1,
+};
+
+/*
+ * Used by a client to determine which protocol version to request be used when
+ * communicating with a server, reflecting the configured value of the
+ * 'protocol.version' config.  If unconfigured, a value of 'protocol_v0' is
+ * returned.
+ */
+extern enum protocol_version get_protocol_version_config(void);
+
+/*
+ * Used by a server to determine which protocol version should be used based on
+ * a client's request, communicated via the 'GIT_PROTOCOL' environment variable
+ * by setting appropriate values for the key 'version'.  If a client doesn't
+ * request a particular protocol version, a default of 'protocol_v0' will be
+ * used.
+ */
+extern enum protocol_version determine_protocol_version_server(void);
+
+/*
+ * Used by a client to determine which protocol version the server is speaking
+ * based on the server's initial response.
+ */
+extern enum protocol_version determine_protocol_version_client(const char *server_response);
+
+#endif /* PROTOCOL_H */
-- 
2.15.0.rc0.271.g36b669edcc-goog

