Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847262209B
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312194; cv=none; b=S/agv4/7HCe2HULtaOLf3nSh1YAGnnIOklCyZVYUjLM/BHCf1oWSpBGrlGVcqZTpNga5u9p2pH0OpTeKW4q8hOB2N/3GF1bv6smvtEsuDAMffRLI8OEPjm4hmcYmwt7VeUUx4LiMXd246+334+ijXd/yCWGgY43oosnnOXYGMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312194; c=relaxed/simple;
	bh=JI+2lBkvOdkbJ/WBo6KAr60AhaR7ZCB5mJCCUB4DR5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pt4lGSovKQbBIVSZqsX1SNiw8+kVyXF/DD0YqHnmlB+YRCGI6yOq6t0oBH6WVH7Iiew5z09+eURtSY5N8Qgaiu5MWpzeIsijMCki8dA1OiPRUV6NjQOnBEAMO5Yab0Zy9nt7dVhAkc4YUYaro4tBqq5kxyehV2KbO6l+xqzD4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=KPmuY02s; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KPmuY02s"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D43BA5D6D2;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=JI+2lBkvOdkbJ/WBo6KAr60AhaR7ZCB5mJCCUB4DR5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=KPmuY02so47UqVpx2fFQm2TdmH5SKm7FB7PuYcmUlMNgYYTZkuWH3pcp6o7UcoAFX
	 D16mOwWhO0jrsL8NVpMmKsiuCDG/xJMI66gqe8RFM3zE20l+uKNGmug+SGG+TnD73r
	 C4yw6SDxbAQNmuJComCFAC3Vspod06C/Oy/A5KrOwnNcmDjMHy85srpu0qmDEB522H
	 yvBO3fDANCAedIkO41xAnBkUDsWaxPXnLJCRToQ/2OGr8zFKwyMDkzq6cUqJ1C281A
	 MunIImz/R8MEC0vLCGVLpjPE+4qmrBHll9cIWizTKnODtBNQaYuWQIE5sW8JrHwfD/
	 dL4Xbc4Uaa2N4CY0KoOuFrAcdmnOU3TIUMo5V0aV0OiIvmPR6+PWiZRtnbBHFx7XSH
	 skCfOZcMqb8MilE2y4ClLYinWq4MkjZiDj+VP40Szsrd+9J5LLboInejkUv4IkN4pi
	 F9G5T5d92hL3tcbjTStrNxu8gPLajghpQasyLav68wXdbQJy4zI
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 16/16] credential: add method for querying capabilities
Date: Wed, 17 Apr 2024 00:02:40 +0000
Message-ID: <20240417000240.3611948-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240417000240.3611948-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240417000240.3611948-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now, there's no specific way to determine whether a credential
helper or git credential itself supports a given set of capabilities.
It would be helpful to have such a way, so let's let credential helpers
and git credential take an argument, "capability", which has it list the
capabilities and a version number on standard output.

Specifically choose a format that is slightly different from regular
credential output and assume that no capabilities are supported if a
non-zero exit status occurs or the data deviates from the format.  It is
common for users to write small shell scripts as the argument to
credential.helper, which will almost never be designed to emit
capabilities.  We want callers to gracefully handle this case by
assuming that they are not capable of extended support because that is
almost certainly the case, and specifying the error behavior up front
does this and preserves backwards compatibility in a graceful way.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-credential.txt | 28 +++++++++++++++++++++++++++-
 builtin/credential-cache.c       | 10 ++++++++++
 builtin/credential.c             |  6 ++++++
 credential.c                     | 11 +++++++++++
 credential.h                     |  6 ++++++
 5 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 3d3accc273..e41493292f 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -8,7 +8,7 @@ git-credential - Retrieve and store user credentials
 SYNOPSIS
 --------
 ------------------
-'git credential' (fill|approve|reject)
+'git credential' (fill|approve|reject|capability)
 ------------------
 
 DESCRIPTION
@@ -41,6 +41,9 @@ If the action is `reject`, git-credential will send the description to
 any configured credential helpers, which may erase any stored
 credentials matching the description.
 
+If the action is `capability`, git-credential will announce any capabilities
+it supports to standard output.
+
 If the action is `approve` or `reject`, no output should be emitted.
 
 TYPICAL USE OF GIT CREDENTIAL
@@ -263,6 +266,29 @@ is supported, but they should not be provided without the capability.
 
 Unrecognised attributes and capabilities are silently discarded.
 
+[[CAPA-IOFMT]]
+CAPABILITY INPUT/OUTPUT FORMAT
+------------------------------
+
+For `git credential capability`, the format is slightly different. First, a
+`version 0` announcement is made to indicate the current version of the
+protocol, and then each capability is announced with a line like `capability
+authtype`. Credential helpers may also implement this format, again with the
+`capability` argument. Additional lines may be added in the future; callers
+should ignore lines which they don't understand.
+
+Because this is a new part of the credential helper protocol, older versions of
+Git, as well as some credential helpers, may not support it.  If a non-zero
+exit status is received, or if the first line doesn't start with the word
+`version` and a space, callers should assume that no capabilities are supported.
+
+The intention of this format is to differentiate it from the credential output
+in an unambiguous way.  It is possible to use very simple credential helpers
+(e.g., inline shell scripts) which always produce identical output.  Using a
+distinct format allows users to continue to use this syntax without having to
+worry about correctly implementing capability advertisements or accidentally
+confusing callers querying for capabilities.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index bba96d4ffd..f5c989e2b2 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "credential.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
@@ -127,6 +128,13 @@ static char *get_socket_path(void)
 	return socket;
 }
 
+static void announce_capabilities(void)
+{
+	struct credential c = CREDENTIAL_INIT;
+	c.capa_authtype.request_initial = 1;
+	credential_announce_capabilities(&c, stdout);
+}
+
 int cmd_credential_cache(int argc, const char **argv, const char *prefix)
 {
 	char *socket_path = NULL;
@@ -160,6 +168,8 @@ int cmd_credential_cache(int argc, const char **argv, const char *prefix)
 		do_cache(socket_path, op, timeout, FLAG_RELAY);
 	else if (!strcmp(op, "store"))
 		do_cache(socket_path, op, timeout, FLAG_RELAY|FLAG_SPAWN);
+	else if (!strcmp(op, "capability"))
+		announce_capabilities();
 	else
 		; /* ignore unknown operation */
 
diff --git a/builtin/credential.c b/builtin/credential.c
index 3568e57025..5100d441f2 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -17,6 +17,12 @@ int cmd_credential(int argc, const char **argv, const char *prefix UNUSED)
 		usage(usage_msg);
 	op = argv[1];
 
+	if (!strcmp(op, "capability")) {
+		credential_set_all_capabilities(&c, CREDENTIAL_OP_INITIAL);
+		credential_announce_capabilities(&c, stdout);
+		return 0;
+	}
+
 	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
 		die("unable to read credential from stdin");
 
diff --git a/credential.c b/credential.c
index ffaf31499e..758528b291 100644
--- a/credential.c
+++ b/credential.c
@@ -72,6 +72,17 @@ void credential_set_all_capabilities(struct credential *c,
 	credential_set_capability(&c->capa_state, op_type);
 }
 
+static void announce_one(struct credential_capability *cc, const char *name, FILE *fp) {
+	if (cc->request_initial)
+		fprintf(fp, "capability %s\n", name);
+}
+
+void credential_announce_capabilities(struct credential *c, FILE *fp) {
+	fprintf(fp, "version 0\n");
+	announce_one(&c->capa_authtype, "authtype", fp);
+	announce_one(&c->capa_state, "state", fp);
+}
+
 int credential_match(const struct credential *want,
 		     const struct credential *have, int match_password)
 {
diff --git a/credential.h b/credential.h
index f8df10937c..af8c287ff2 100644
--- a/credential.h
+++ b/credential.h
@@ -253,6 +253,12 @@ void credential_set_all_capabilities(struct credential *c,
  */
 void credential_clear_secrets(struct credential *c);
 
+/**
+ * Print a list of supported capabilities and version numbers to standard
+ * output.
+ */
+void credential_announce_capabilities(struct credential *c, FILE *fp);
+
 /**
  * Prepares the credential for the next iteration of the helper protocol by
  * updating the state headers to send with the ones read by the last iteration
