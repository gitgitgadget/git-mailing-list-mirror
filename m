Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B5620281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032778AbdIZX4y (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:56:54 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:52657 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966844AbdIZX4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:56:51 -0400
Received: by mail-pf0-f181.google.com with SMTP id p87so6323281pfj.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xDqpTYmxApsIECPvZsjdLubIeIqM83U5l7+i5lg0nOw=;
        b=byZ8ov6HElfMVyORFyrsHbpzlxRDh898l6zy5X13E7dPpAvVPGctxZjjFTe64QcxR5
         +I3axJbYOoP4m/A45FoICSLFJqZUeeDCpBGMhC1gcAUY9SE55QibZkCN9DwKaPOcuRTI
         dAPRI3kqF6wJCX0/D++8JSggKh+JpVijUOHTfpWBnMgly31TURy/MZXyXjK3thrjfJkf
         4WVZgvN77SLWs4ywfE/8G0U06S4oVRmmfLieIaSR9L+oUVqdan/F6nBslNQaFJYPxsnR
         5prTL//Xkf8Nv4IgGl68ioqSpPYkYQqUPnOtL6ZUKMQKvwwb3IVfmLDym9r8MXQODph6
         xeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xDqpTYmxApsIECPvZsjdLubIeIqM83U5l7+i5lg0nOw=;
        b=gk25RzC9f16hpIlru6hy6Ij357OBmjSTWZfrWaa+Q1TO/NEBDv/nzouCjq2l4aB0Aj
         BZgTJTMxM68/UHQBiD+42BBQy6rrXZGfICTSfRxti3MpWLaq12zqNxxNAzkEYkyF3J7X
         ls5vEbeS/GeCRpE0b2yA+zIaVl7Nalmvb11vw3mM/k8WsJMnEAy+xP2W0DthZCy6MtvR
         X6Ts8uGlpiEW/13ftUk2qdzTSqPqqrj5qrDMYpwAuYqyLgVeVarC9WbX5FgCBVyRTOFE
         iaiMsJ2/R3cZ1faBRmCxK7cyNT0wjBOVSN4GgD46SVeEG33CmaQip4/LFoLcnQYtnDpV
         Ildw==
X-Gm-Message-State: AHPjjUj7w6BJo7HmV0E4RAgf/3GoSQTy9G7nHKw0IgzoSSsb56wZpUDz
        qKxYvEIKXDP91azlzUxkB5wZCNfrpaE=
X-Google-Smtp-Source: AOwi7QCOm6r+WewFDgmw6u5gk4twUGLESN5YLC2s1q/1RnUj97yo+RsH1+Z4uT3o3y3qqjvCTwpcfg==
X-Received: by 10.99.53.206 with SMTP id c197mr12504053pga.440.1506470210824;
        Tue, 26 Sep 2017 16:56:50 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:49 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 3/9] protocol: introduce protocol extention mechanisms
Date:   Tue, 26 Sep 2017 16:56:21 -0700
Message-Id: <20170926235627.79606-4-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
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
 Documentation/config.txt | 17 ++++++++++++
 Documentation/git.txt    |  5 ++++
 Makefile                 |  1 +
 cache.h                  |  7 +++++
 protocol.c               | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 protocol.h               | 14 ++++++++++
 6 files changed, 116 insertions(+)
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
index 49b083ee0..0c792545f 100644
--- a/cache.h
+++ b/cache.h
@@ -445,6 +445,13 @@ static inline enum object_type object_type(unsigned int mode)
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
index 000000000..369503065
--- /dev/null
+++ b/protocol.c
@@ -0,0 +1,72 @@
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
index 000000000..18f9a5235
--- /dev/null
+++ b/protocol.h
@@ -0,0 +1,14 @@
+#ifndef PROTOCOL_H
+#define PROTOCOL_H
+
+enum protocol_version {
+	protocol_unknown_version = -1,
+	protocol_v0 = 0,
+	protocol_v1 = 1,
+};
+
+extern enum protocol_version get_protocol_version_config(void);
+extern enum protocol_version determine_protocol_version_server(void);
+extern enum protocol_version determine_protocol_version_client(const char *server_response);
+
+#endif /* PROTOCOL_H */
-- 
2.14.1.992.g2c7b836f3a-goog

