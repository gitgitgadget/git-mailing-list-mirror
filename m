Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E85A20286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdIMVzJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:55:09 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:45943 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdIMVzE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:55:04 -0400
Received: by mail-pf0-f172.google.com with SMTP id q76so2187200pfq.2
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w/+q8E/09DpjNKHHmZA6kk715FaUfELBfUw+A/HrSpo=;
        b=vq1riFVTOr2VrU3yveVvwU63kMJLkQgMqcKG6Hha776FEy5ZJl/lC67M7U2hq2Ietr
         AhKvmEKhIsH8yaFe4dMEHEukJV2Jrh5jneeD5P3I2zm5kthgFZ+RVrT6FCJvPn8npIDL
         uzf2zBGEK6dVf4KhozdwyiWwUPl0W8IaCydMWTdpfbxqs0JBVu7oc9tuPbh6kLRKQ8AA
         Rvjl6h1vtZ07tpurEh9ne+1cEgwVpLRuBsCu496xN3uLHl1endpjnUel6lcCpe4S8jjd
         7K66yq/TifC44HBqgcpQ4yy4lE4PV1SMmyTw+7i0u0t8vgtXb+eBP7d1b+wSylP6pvdN
         NLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w/+q8E/09DpjNKHHmZA6kk715FaUfELBfUw+A/HrSpo=;
        b=PSziAvlT4e3bjKxJ66DdE6yK1yxATWT+V+gG2b1i3CmWdiLoMDhHXktFyy1TbhcWl6
         aX6HIqdh/3y078VAIAq7N3gc6VGVscaKy/qSBpMS+d9ECuK30DXhLkdmEa3tV0qJsq8L
         +ocICx4f0cJxJDRWtTbvZS3f22oTjIyzBXWsHiyXmYFiIXfAUj9B66SNFmzmD24Ho+1O
         zwA5eCEXGdEiJGXG1Dd7zjqyTOdv02+dbbENKd5KUmoFzafcP5KCLoWRZ/qAbMAnSJ+Z
         2EJ2OyzZs40sARxGbqL5W88timjSO/8O3l8sj06QNxOmp2+7VA98skMw5XQBx4ZHA9fm
         oTAw==
X-Gm-Message-State: AHPjjUhnpfvZOm/AFhOuRMvUzVpA4RDjDtRK5WcjIGp6qvVX4mV29uUz
        qaIcjg/yJJOrVbr76NKy5A==
X-Google-Smtp-Source: AOwi7QBfC5zf7yWluA0nEDJmpc1MCHIayKmm7twUR8Xs/SN66Kcdutu7VGSCIlpo+dyQxytHOsg4aA==
X-Received: by 10.84.211.136 with SMTP id c8mr3721079pli.55.1505339703355;
        Wed, 13 Sep 2017 14:55:03 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id q13sm23152639pgt.87.2017.09.13.14.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 14:55:02 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/8] protocol: introduce protocol extention mechanisms
Date:   Wed, 13 Sep 2017 14:54:42 -0700
Message-Id: <20170913215448.84674-3-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.690.gbb1197296e-goog
In-Reply-To: <20170913215448.84674-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
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
 Documentation/config.txt | 16 +++++++++++
 Documentation/git.txt    |  5 ++++
 Makefile                 |  1 +
 cache.h                  |  7 +++++
 protocol.c               | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 protocol.h               | 15 ++++++++++
 6 files changed, 116 insertions(+)
 create mode 100644 protocol.c
 create mode 100644 protocol.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dc4e3f58a..d5b28a32c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2517,6 +2517,22 @@ The protocol names currently used by git are:
     `hg` to allow the `git-remote-hg` helper)
 --
 
+protocol.version::
+	If set, clients will attempt to communicate with a server using
+	the specified protocol version.  If unset, no attempt will be
+	made by the client to communicate using a particular protocol
+	version, this results in protocol version 0 being used.
+	Supported versions:
++
+--
+
+* `0` - the original wire protocol.
+
+* `1` - the original wire protocol with the addition of a version string
+  in the initial respose from the server.
+
+--
+
 pull.ff::
 	By default, Git does not create an extra merge commit when merging
 	a commit that is a descendant of the current commit. Instead, the
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6e3a6767e..299f75c7b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -697,6 +697,11 @@ of clones and fetches.
 	which feed potentially-untrusted URLS to git commands.  See
 	linkgit:git-config[1] for more details.
 
+`GIT_PROTOCOL`::
+	For internal use only.  Used in handshaking the wire protocol.
+	Contains a colon ':' separated list of keys with optional values
+	'key[=value]'.  Presence of unknown keys must be tolerated.
+
 Discussion[[Discussion]]
 ------------------------
 
diff --git a/Makefile b/Makefile
index f2bb7f2f6..1f300bd6b 100644
--- a/Makefile
+++ b/Makefile
@@ -837,6 +837,7 @@ LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
 LIB_OBJS += prompt.o
+LIB_OBJS += protocol.o
 LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
diff --git a/cache.h b/cache.h
index a916bc79e..8839b1ed4 100644
--- a/cache.h
+++ b/cache.h
@@ -444,6 +444,13 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
 #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
 
+/*
+ * Environment variable used in handshaking the wire protocol.
+ * Contains a colon ':' separated list of keys with optional values
+ * 'key[=value]'.  Presence of unknown keys must be tolerated.
+ */
+#define GIT_PROTOCOL_ENVIRONMENT "GIT_PROTOCOL"
+
 /*
  * This environment variable is expected to contain a boolean indicating
  * whether we should or should not treat:
diff --git a/protocol.c b/protocol.c
new file mode 100644
index 000000000..1b16c7b9a
--- /dev/null
+++ b/protocol.c
@@ -0,0 +1,72 @@
+#include "cache.h"
+#include "config.h"
+#include "protocol.h"
+
+enum protocol_version parse_protocol_version(const char *value)
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
index 000000000..2fa6486d0
--- /dev/null
+++ b/protocol.h
@@ -0,0 +1,15 @@
+#ifndef PROTOCOL_H
+#define PROTOCOL_H
+
+enum protocol_version {
+	protocol_unknown_version = -1,
+	protocol_v0 = 0,
+	protocol_v1 = 1,
+};
+
+extern enum protocol_version parse_protocol_version(const char *value);
+extern enum protocol_version get_protocol_version_config(void);
+extern enum protocol_version determine_protocol_version_server(void);
+extern enum protocol_version determine_protocol_version_client(const char *server_response);
+
+#endif /* PROTOCOL_H */
-- 
2.14.1.690.gbb1197296e-goog

