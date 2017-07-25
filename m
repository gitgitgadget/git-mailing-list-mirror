Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32DF1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 18:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbdGYS3u (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 14:29:50 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33667 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbdGYS3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 14:29:49 -0400
Received: by mail-pf0-f181.google.com with SMTP id s70so61479366pfs.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sHr8ffW9uaKBUvDKiIeO6FCkDVM0tNfalK64DsdCUpk=;
        b=SNXBUoPtAtNv3Bb93APUpIdpK4FQSTyRD7DzeIHWR2p/2vZ56mBJSU8hwh7Q5ZO4nf
         aUhxCZC0qXRoNlr0duddm3QdwD6W4vdlgxHxGPm/DaFiRnhj9c8+URqwbQOWTW51nj5i
         ShrCMpHMkZawiHUWbuuVrZqFPN8+8uZAtRqGSF4fbBBOfeQ6YUJ9LlrmlUFEzu/sEvUH
         jDkoxAMPhebpInrwwXjHkU0hPozM0fZyBImlAEov0qoGKI6ExILwJ7YZfov1Zwbo3XWW
         dwpCYY4OrPxZGRjfC5mvETsvW6w6iNunoTn0OYOHpN7f+8YquZzg9Yeml6sBDOWcgPI6
         6ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sHr8ffW9uaKBUvDKiIeO6FCkDVM0tNfalK64DsdCUpk=;
        b=rX0SRjSMkoRhuTie1WPLxUoFp5DRxvga6bDgo/HPBHT6GO0+4hJeo2VHOX2joAx989
         T9xcwZ1BpkF/5p/3Mmypc/suYu23eqXXA5/utWn15vouQDeoniIyvuqWCnP6WJLuUNCR
         g//w+Zu1JQ7dMuXla2V/HvFGE0WHIfg67+LFBRQaHvYa9SBBZsEAGy0FrDXKeabnfncp
         UwP9gmAuWeXfDazXjyVrdMDaTFW9Ws2PSa92G3u6yoLNwZDiW1lit3SuRMIoiGk8ptcn
         FmEQnUC+HyclDksIYlKhchOWGHrT8XSCEJNoAbiZ41nZqZgaDpnnkKjHxJo8Ro4cZmaf
         Ea5g==
X-Gm-Message-State: AIVw110rhHVgP9rMFvCXqJjpAZxMWLiFunyazALObdsl9LvxVV6hGAzM
        /KOtx4dkiM7UNoGApdO9Mg==
X-Received: by 10.99.123.76 with SMTP id k12mr16887221pgn.277.1501007387866;
        Tue, 25 Jul 2017 11:29:47 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e10sm3354139pgu.16.2017.07.25.11.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 11:29:46 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        peartben@gmail.com
Subject: [PATCH v2 2/2] sub-process: refactor handshake to common function
Date:   Tue, 25 Jul 2017 11:29:38 -0700
Message-Id: <e47344b6e4bce2a038ba62abb158ec720221a96c.1501007300.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <cover.1501007300.git.jonathantanmy@google.com>
References: <cover.1501007300.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501007300.git.jonathantanmy@google.com>
References: <20170724213810.29831-1-jonathantanmy@google.com> <cover.1501007300.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor, into a common function, the version and capability negotiation
done when invoking a long-running process as a clean or smudge filter.
This will be useful for other Git code that needs to interact similarly
with a long-running process.

As you can see in the change to t0021, this commit changes the error
message reported when the long-running process does not introduce itself
with the expected "server"-terminated line. Originally, the error
message reports that the filter "does not support filter protocol
version 2", differentiating between the old single-file filter protocol
and the new multi-file filter protocol - I have updated it to something
more generic and useful.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 convert.c             | 61 ++++-----------------------------
 pkt-line.c            | 19 -----------
 pkt-line.h            |  2 --
 sub-process.c         | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sub-process.h         | 26 ++++++++++++++
 t/t0021-conversion.sh |  2 +-
 6 files changed, 128 insertions(+), 76 deletions(-)

diff --git a/convert.c b/convert.c
index deaf0ba7b..ec8ecc2ea 100644
--- a/convert.c
+++ b/convert.c
@@ -512,62 +512,15 @@ static struct hashmap subprocess_map;
 
 static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
 {
-	int err;
+	static int versions[] = {2, 0};
+	static struct subprocess_capability capabilities[] = {
+		{"clean", CAP_CLEAN}, {"smudge", CAP_SMUDGE}, {NULL, 0}
+	};
 	struct cmd2process *entry = (struct cmd2process *)subprocess;
-	struct string_list cap_list = STRING_LIST_INIT_NODUP;
-	char *cap_buf;
-	const char *cap_name;
-	struct child_process *process = &subprocess->process;
-	const char *cmd = subprocess->cmd;
-
-	sigchain_push(SIGPIPE, SIG_IGN);
-
-	err = packet_writel(process->in, "git-filter-client", "version=2", NULL);
-	if (err)
-		goto done;
-
-	err = strcmp(packet_read_line(process->out, NULL), "git-filter-server");
-	if (err) {
-		error("external filter '%s' does not support filter protocol version 2", cmd);
-		goto done;
-	}
-	err = strcmp(packet_read_line(process->out, NULL), "version=2");
-	if (err)
-		goto done;
-	err = packet_read_line(process->out, NULL) != NULL;
-	if (err)
-		goto done;
-
-	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
-
-	for (;;) {
-		cap_buf = packet_read_line(process->out, NULL);
-		if (!cap_buf)
-			break;
-		string_list_split_in_place(&cap_list, cap_buf, '=', 1);
-
-		if (cap_list.nr != 2 || strcmp(cap_list.items[0].string, "capability"))
-			continue;
-
-		cap_name = cap_list.items[1].string;
-		if (!strcmp(cap_name, "clean")) {
-			entry->supported_capabilities |= CAP_CLEAN;
-		} else if (!strcmp(cap_name, "smudge")) {
-			entry->supported_capabilities |= CAP_SMUDGE;
-		} else {
-			warning(
-				"external filter '%s' requested unsupported filter capability '%s'",
-				cmd, cap_name
-			);
-		}
-
-		string_list_clear(&cap_list, 0);
-	}
-
-done:
-	sigchain_pop(SIGPIPE);
 
-	return err;
+	return subprocess_handshake(subprocess, "git-filter-", versions, NULL,
+				    capabilities,
+				    &entry->supported_capabilities);
 }
 
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
diff --git a/pkt-line.c b/pkt-line.c
index 9d845ecc3..7db911957 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -171,25 +171,6 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 	return status;
 }
 
-int packet_writel(int fd, const char *line, ...)
-{
-	va_list args;
-	int err;
-	va_start(args, line);
-	for (;;) {
-		if (!line)
-			break;
-		if (strlen(line) > LARGE_PACKET_DATA_MAX)
-			return -1;
-		err = packet_write_fmt_gently(fd, "%s\n", line);
-		if (err)
-			return err;
-		line = va_arg(args, const char*);
-	}
-	va_end(args);
-	return packet_flush_gently(fd);
-}
-
 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
 	static char packet_write_buffer[LARGE_PACKET_MAX];
diff --git a/pkt-line.h b/pkt-line.h
index 450183b64..66ef610fc 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,8 +25,6 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-LAST_ARG_MUST_BE_NULL
-int packet_writel(int fd, const char *line, ...);
 int write_packetized_from_fd(int fd_in, int fd_out);
 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 
diff --git a/sub-process.c b/sub-process.c
index a3cfab1a9..1a3f39bdf 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -105,3 +105,97 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	hashmap_add(hashmap, entry);
 	return 0;
 }
+
+int subprocess_handshake(struct subprocess_entry *entry,
+			 const char *welcome_prefix,
+			 int *versions,
+			 int *chosen_version,
+			 struct subprocess_capability *capabilities,
+			 unsigned int *supported_capabilities) {
+	int version_scratch;
+	unsigned int capabilities_scratch;
+	struct child_process *process = &entry->process;
+	int i;
+	char *line;
+	const char *p;
+
+	if (!chosen_version)
+		chosen_version = &version_scratch;
+	if (!supported_capabilities)
+		supported_capabilities = &capabilities_scratch;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	if (packet_write_fmt_gently(process->in, "%sclient\n",
+				    welcome_prefix)) {
+		error("Could not write client identification");
+		goto error;
+	}
+	for (i = 0; versions[i]; i++) {
+		if (packet_write_fmt_gently(process->in, "version=%d\n",
+					    versions[i])) {
+			error("Could not write requested version");
+			goto error;
+		}
+	}
+	if (packet_flush_gently(process->in))
+		goto error;
+
+	if (!(line = packet_read_line(process->out, NULL)) ||
+	    !skip_prefix(line, welcome_prefix, &p) ||
+	    strcmp(p, "server")) {
+		error("Unexpected line '%s', expected %sserver",
+		      line ? line : "<flush packet>", welcome_prefix);
+		goto error;
+	}
+	if (!(line = packet_read_line(process->out, NULL)) ||
+	    !skip_prefix(line, "version=", &p) ||
+	    strtol_i(p, 10, chosen_version)) {
+		error("Unexpected line '%s', expected version",
+		      line ? line : "<flush packet>");
+		goto error;
+	}
+	for (i = 0; versions[i]; i++) {
+		if (versions[i] == *chosen_version)
+			goto version_found;
+	}
+	error("Version %d not supported", *chosen_version);
+	goto error;
+version_found:
+	if ((line = packet_read_line(process->out, NULL))) {
+		error("Unexpected line '%s', expected flush", line);
+		goto error;
+	}
+
+	for (i = 0; capabilities[i].name; i++) {
+		if (packet_write_fmt_gently(process->in, "capability=%s\n",
+					    capabilities[i].name)) {
+			error("Could not write requested capability");
+			goto error;
+		}
+	}
+	if (packet_flush_gently(process->in))
+		goto error;
+
+	while ((line = packet_read_line(process->out, NULL))) {
+		if (!skip_prefix(line, "capability=", &p))
+			continue;
+
+		for (i = 0; capabilities[i].name; i++) {
+			if (!strcmp(p, capabilities[i].name)) {
+				*supported_capabilities |= capabilities[i].flag;
+				goto capability_found;
+			}
+		}
+		warning("external filter requested unsupported filter capability '%s'",
+			p);
+capability_found:
+		;
+	}
+
+	sigchain_pop(SIGPIPE);
+	return 0;
+error:
+	sigchain_pop(SIGPIPE);
+	return 1;
+}
diff --git a/sub-process.h b/sub-process.h
index 9e6975b5e..28863fabc 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -29,6 +29,16 @@ struct subprocess_entry {
 	struct child_process process;
 };
 
+struct subprocess_capability {
+	const char *name;
+
+	/*
+	 * subprocess_handshake will "|=" this value to supported_capabilities
+	 * if the server reports that it supports this capability.
+	 */
+	unsigned int flag;
+};
+
 /* subprocess functions */
 
 /* Function to test two subprocess hashmap entries for equality. */
@@ -62,6 +72,22 @@ static inline struct child_process *subprocess_get_child_process(
 	return &entry->process;
 }
 
+/*
+ * Perform the version and capability negotiation as described in the "Long
+ * Running Filter Process" section of the gitattributes documentation using the
+ * given requested versions and capabilities. The "versions" and "capabilities"
+ * parameters are arrays terminated by a 0 or blank struct.
+ *
+ * This function is typically called when a subprocess is started (as part of
+ * the "startfn" passed to subprocess_start).
+ */
+int subprocess_handshake(struct subprocess_entry *entry,
+			 const char *welcome_prefix,
+			 int *versions,
+			 int *chosen_version,
+			 struct subprocess_capability *capabilities,
+			 unsigned int *supported_capabilities);
+
 /*
  * Helper function that will read packets looking for "status=<foo>"
  * key/value pairs and return the value from the last "status" packet
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 161f56044..d191a7228 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -697,7 +697,7 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
 
 		cp "$TEST_ROOT/test.o" test.r &&
 		test_must_fail git add . 2>git-stderr.log &&
-		grep "does not support filter protocol version" git-stderr.log
+		grep "expected git-filter-server" git-stderr.log
 	)
 '
 
-- 
2.14.0.rc0.400.g1c36432dff-goog

