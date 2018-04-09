Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB74B1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754405AbeDIUmf (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:42:35 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40379 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754243AbeDIUmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:25 -0400
Received: by mail-io0-f194.google.com with SMTP id e79so11226232ioi.7
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Id2u60RBsuEAceSbmU9M50ecs2LWbr4AhxXTbCQP4SM=;
        b=AJlohDLEgUqlPzzaz/NfluI0bKXb4ubksbbp8rReWDmZz130ZY2Vt/YL/L0Ura9DfQ
         EARcYVXw6RXQqdRbM8CQ2nPuwPZFbyCC4XIIClDOEh15JnDt9Qq5rysdNdWtTWNU0q4R
         PDaqTwycVjFotWZ5b7A9RN/lyZxBR3/cHTHr3R1GxqRs4S7iaDzv5Fy6VmZq/9U3LSFF
         KHewJT/1Jq8G5aWPwVfUuiBgaLQT+0CFAup/fy/0uiyWULFhNc8VlQlfIRGeH4zH5gSO
         3XmaG4FkLNmZr8Tx24aa/w2QyUv1ZU7sNlCBUJ/gUKCEmcF7PJxsuZ2p4+IImPe30/u9
         eOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Id2u60RBsuEAceSbmU9M50ecs2LWbr4AhxXTbCQP4SM=;
        b=EIKNTAlhqIHVIogfahRvxX8Sdu3cbdh3H1DTgy2fJ1OeaE41WyyUH7lQ/D5LTbdJdJ
         W1qgNy2VaLK5yn3iCyLpJIetD3ntkv5D1vAxmXgegwJJuQ0hXgOnO34oOCVUU/1quaoS
         THwXcqnqpIdBSEcBWueaj5r6YTMV5mrLrMnSl5KN8DcESSsgQoRM9/jIkl1L+7CWHHeQ
         LicwQ1uqeE7WXv98lcq9YTccMv3mtnAGRCfv9wx+fJ7Kh8aXuJIq/TCR5JTBmDrIKuOG
         3LK6NyhQmt5vuBj0uYbJMJWxEoZ+fENSzucjQ0FVWTYNj6GngUZahrY7Fd4oaFB7KOYr
         hDrA==
X-Gm-Message-State: ALQs6tB+syAz81SmlcVP2qM82sMB9Ieg+3AYpoLfIE7ULgfFUJvK3Ept
        HKuHCEO0+Uz/0GntNJURIgoItinY
X-Google-Smtp-Source: AIpwx4/cRZICnPfDwTBtc00N5gR4Tu17frvcdU2kJGAidT6iGYHvmpfEGOMu3R4ZTnq10XsCST2cSw==
X-Received: by 10.107.198.134 with SMTP id w128mr523392iof.50.1523306543099;
        Mon, 09 Apr 2018 13:42:23 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id 134-v6sm98775itl.34.2018.04.09.13.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 13:42:22 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, mastahyeti@gmail.com,
        Ben Toews <btoews@github.com>
Subject: [PATCH 8/8] gpg-interface: handle alternative signature types
Date:   Mon,  9 Apr 2018 14:41:29 -0600
Message-Id: <20180409204129.43537-9-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Toews <btoews@github.com>

Currently you can only sign commits and tags using "gpg".
You can _almost_ plug in a related tool like "gpgsm" (which
uses S/MIME-style signatures instead of PGP) using
gpg.program, as it has command-line compatibility. But there
are a few rough edges:

  1. gpgsm generates a slightly different PEM format than
     gpg. It says:

       -----BEGIN SIGNED MESSAGE-----

     instead of:

       -----BEGIN PGP SIGNATURE-----

     This actually works OK for signed commits, where we
     just dump the gpgsig header to gpg.program regardless.

     But for tags, we actually have to parse out the
     detached signature, and we fail to recognize the gpgsm
     version.

  2. You can't mix the two types of signatures easily, as
     we'd send the output to whatever tool you've
     configured. For verification, we'd ideally dispatch gpg
     signatures to gpg, gpgsm ones to gpgsm, and so on. For
     signing, you'd obviously have to pick a tool to use.

This patch introduces a set of configuration options for
defining a "signing tool", of which gpg may be just one.
With this patch you can:

  - define a new tool "foo" with signingtool.foo.program

  - map PEM strings to it for verification using
    signingtool.foo.pemtype

  - set it as your default tool for creating signatures
    using using signingtool.default

This subsumes the existing gpg config, as we have baked-in
config for signingtool.gpg that works just like the current
hard-coded behavior. And setting gpg.program becomes an
alias for signingtool.gpg.program.

This is enough to plug in gpgsm like:

  [signingtool "gpgsm"]
  program = gpgsm
  pemtype = "SIGNED MESSAGE"

In the future, this config scheme gives us options for
extending to other tools:

  - the tools all have to accept gpg-like options for now,
    but we could add signingtool.interface to meet other
    standards

  - we only match PEM headers now, but we could add other
    config for matching non-PEM types

The implementation is still in gpg-interface.c, and most of
the code internally refers to this as "gpg". I've left it
this way to keep the diff sane, and to make it clear that
we're not breaking anything gpg-related. This is probably OK
for now, as our tools must be gpg-like anyway. But renaming
everything would be an obvious next-step refactoring if we
want to offer support for more exotic tools (e.g., people
have asked before on the list about using OpenBSD signify).
---
 Documentation/config.txt |  40 +++++++++---
 builtin/fmt-merge-msg.c  |   6 +-
 builtin/receive-pack.c   |   7 +-
 builtin/tag.c            |   2 +-
 commit.c                 |   2 +-
 gpg-interface.c          | 165 ++++++++++++++++++++++++++++++++++++++++++-----
 gpg-interface.h          |  24 ++++++-
 log-tree.c               |   7 +-
 ref-filter.c             |   2 +-
 t/lib-gpg.sh             |  26 ++++++++
 t/t7510-signed-commit.sh |  32 ++++++++-
 tag.c                    |   2 +-
 12 files changed, 272 insertions(+), 43 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e0cff87f6..7906123a59 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1727,16 +1727,38 @@ grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
 	is executed outside of a git repository.  Defaults to false.
 
-gpg.program::
-	Use this custom program instead of "`gpg`" found on `$PATH` when
-	making or verifying a PGP signature. The program must support the
-	same command-line interface as GPG, namely, to verify a detached
-	signature, "`gpg --verify $file - <$signature`" is run, and the
-	program is expected to signal a good signature by exiting with
-	code 0, and to generate an ASCII-armored detached signature, the
-	standard input of "`gpg -bsau $key`" is fed with the contents to be
+signingtool.<name>.program::
+	The name of the program on `$PATH` to execute when making or
+	verifying a signature. This program will be used for making
+	signatures if `<name>` is configured as `signingtool.default`.
+	This program will be used for verifying signatures whose PEM
+	block type matches `signingtool.<name>.pemtype` (see below). The
+	program must support the same command-line interface as GPG.
+	To verify a detached signature,
+	"`gpg --verify $file - <$signature`" is run, and the program is
+	expected to signal a good signature by exiting with code 0.
+	To generate an ASCII-armored detached signature, the standard
+	input of "`gpg -bsau $key`" is fed with the contents to be
 	signed, and the program is expected to send the result to its
-	standard output.
+	standard output. By default, `signingtool.gpg.program` is set to
+	`gpg`.
+
+signingtool.<name>.pemtype::
+	The PEM block type associated with the signing tool named
+	`<name>`. For example, the block type of a GPG signature
+	starting with `-----BEGIN PGP SIGNATURE-----` is `PGP
+	SIGNATURE`. When verifying a signature with this PEM block type
+	the program specified in `signingtool.<name>.program` will be
+	used. By default `signingtool.gpg.pemtype` contains `PGP
+	SIGNATURE` and `PGP MESSAGE`.
+
+signingtool.default::
+	The `<name>` of the signing tool to use when creating
+	signatures (e.g., setting it to "foo" will use use the program
+	specified by `signingtool.foo.program`). Defaults to `gpg`.
+
+gpg.program::
+	Historical alias for `signingtool.gpg.program`.
 
 gui.commitMsgWidth::
 	Defines how wide the commit message window is in the
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 8e8a15ea4a..6aa8226308 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -490,14 +490,16 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		unsigned long size, len;
 		char *buf = read_sha1_file(sha1, &type, &size);
 		struct strbuf sig = STRBUF_INIT;
+		const struct signing_tool *tool;
 
 		if (!buf || type != OBJ_TAG)
 			goto next;
-		len = parse_signature(buf, size);
+		len = parse_signature(buf, size, &tool);
 
 		if (size == len)
 			; /* merely annotated */
-		else if (verify_signed_buffer(buf, len, buf + len, size - len, &sig, NULL)) {
+		else if (verify_signed_buffer(buf, len, buf + len, size - len,
+					      &sig, NULL, tool)) {
 			if (!sig.len)
 				strbuf_addstr(&sig, "gpg verification failed.\n");
 		}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 75e7f18ace..be17dcaa78 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -631,6 +631,7 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		struct strbuf gpg_output = STRBUF_INIT;
 		struct strbuf gpg_status = STRBUF_INIT;
 		int bogs /* beginning_of_gpg_sig */;
+		const struct signing_tool *tool;
 
 		already_done = 1;
 		if (write_object_file(push_cert.buf, push_cert.len, "blob",
@@ -640,10 +641,10 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		memset(&sigcheck, '\0', sizeof(sigcheck));
 		sigcheck.result = 'N';
 
-		bogs = parse_signature(push_cert.buf, push_cert.len);
+		bogs = parse_signature(push_cert.buf, push_cert.len, &tool);
 		if (verify_signed_buffer(push_cert.buf, bogs,
 					 push_cert.buf + bogs, push_cert.len - bogs,
-					 &gpg_output, &gpg_status) < 0) {
+					 &gpg_output, &gpg_status, tool) < 0) {
 			; /* error running gpg */
 		} else {
 			sigcheck.payload = push_cert.buf;
@@ -1565,7 +1566,7 @@ static void queue_commands_from_cert(struct command **tail,
 		die("malformed push certificate %.*s", 100, push_cert->buf);
 	else
 		boc += 2;
-	eoc = push_cert->buf + parse_signature(push_cert->buf, push_cert->len);
+	eoc = push_cert->buf + parse_signature(push_cert->buf, push_cert->len, NULL);
 
 	while (boc < eoc) {
 		const char *eol = memchr(boc, '\n', eoc - boc);
diff --git a/builtin/tag.c b/builtin/tag.c
index da186691ed..adc37a28c5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -178,7 +178,7 @@ static void write_tag_body(int fd, const struct object_id *oid)
 		return;
 	}
 	sp += 2; /* skip the 2 LFs */
-	write_or_die(fd, sp, parse_signature(sp, buf + size - sp));
+	write_or_die(fd, sp, parse_signature(sp, buf + size - sp, NULL));
 
 	free(buf);
 }
diff --git a/commit.c b/commit.c
index 00c99c7272..056942df7f 100644
--- a/commit.c
+++ b/commit.c
@@ -1209,7 +1209,7 @@ static void handle_signed_tag(struct commit *parent, struct commit_extra_header
 	buf = read_sha1_file(desc->obj->oid.hash, &type, &size);
 	if (!buf || type != OBJ_TAG)
 		goto free_return;
-	len = parse_signature(buf, size);
+	len = parse_signature(buf, size, NULL);
 	if (size == len)
 		goto free_return;
 	/*
diff --git a/gpg-interface.c b/gpg-interface.c
index 0ba4a8ac3b..0e2a82e8e5 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -7,7 +7,60 @@
 #include "tempfile.h"
 
 static char *configured_signing_key;
-static const char *gpg_program = "gpg";
+static const char *default_signing_tool = "gpg";
+static struct signing_tool *signing_tool_config;
+
+static struct signing_tool *alloc_signing_tool(void)
+{
+	struct signing_tool *ret;
+	ret = xcalloc(1, sizeof(*ret));
+	ret->pemtype.strdup_strings = 1;
+	return ret;
+}
+
+/*
+ * Our default tool config is too complicated to specify as a constant
+ * initializer, so we lazily create it as needed.
+ */
+static void init_signing_tool_defaults(void) {
+	struct signing_tool *tool;
+
+	if (signing_tool_config)
+		return;
+
+	tool = alloc_signing_tool();
+	tool->name = xstrdup("gpg");
+	tool->program = xstrdup("gpg");
+	string_list_append(&tool->pemtype, "PGP SIGNATURE");
+	string_list_append(&tool->pemtype, "PGP MESSAGE");
+
+	tool->next = signing_tool_config;
+	signing_tool_config = tool;
+}
+
+static struct signing_tool *get_signing_tool(const char *name) {
+	struct signing_tool *tool;
+
+	init_signing_tool_defaults();
+
+	for (tool = signing_tool_config; tool; tool = tool->next) {
+		if (!strcmp(name, tool->name))
+			return tool;
+	}
+	return NULL;
+}
+
+static struct signing_tool *get_or_create_signing_tool(const char *name)
+{
+	struct signing_tool *tool = get_signing_tool(name);
+	if (!tool) {
+		tool = alloc_signing_tool();
+		tool->name = xstrdup(name);
+		tool->next = signing_tool_config;
+		signing_tool_config = tool;
+	}
+	return tool;
+}
 
 void signature_check_clear(struct signature_check *sigc)
 {
@@ -71,7 +124,7 @@ int check_signature(const char *payload, size_t plen, const char *signature,
 	sigc->result = 'N';
 
 	status = verify_signed_buffer(payload, plen, signature, slen,
-				      &gpg_output, &gpg_status);
+				      &gpg_output, &gpg_status, NULL);
 	if (status && !gpg_output.len)
 		goto out;
 	sigc->payload = xmemdupz(payload, plen);
@@ -98,32 +151,49 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }
 
-static int is_pem_start(const char *line)
+static int is_pem_start(const char *line, struct signing_tool **out_tool)
 {
+	struct signing_tool *tool;
+
 	if (!skip_prefix(line, "-----BEGIN ", &line))
 		return 0;
-	if (!skip_prefix(line, "PGP SIGNATURE", &line) &&
-	    !skip_prefix(line, "PGP MESSAGE", &line))
-		return 0;
-	if (!starts_with(line, "-----"))
-		return 0;
 
-	return 1;
+	init_signing_tool_defaults();
+
+	for (tool = signing_tool_config; tool; tool = tool->next) {
+		int i;
+		for (i = 0; i < tool->pemtype.nr; i++) {
+			const char *match = tool->pemtype.items[i].string;
+			const char *end;
+			if (skip_prefix(line, match, &end) &&
+			    starts_with(end, "-----")) {
+				*out_tool = tool;
+				return 1;
+			}
+		}
+	}
+	return 0;
 }
 
-size_t parse_signature(const char *buf, size_t size)
+size_t parse_signature(const char *buf, size_t size,
+		       const struct signing_tool **out_tool)
 {
 	size_t len = 0;
 	size_t match = size;
+	struct signing_tool *tool = NULL;
+
 	while (len < size) {
 		const char *eol;
 
-		if (is_pem_start(buf + len))
+		if (is_pem_start(buf + len, &tool))
 			match = len;
 
 		eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
+
+	if (out_tool)
+		*out_tool = tool;
 	return match;
 }
 
@@ -135,6 +205,9 @@ void set_signing_key(const char *key)
 
 int git_gpg_config(const char *var, const char *value, void *cb)
 {
+	const char *key, *name = NULL;
+	int name_len;
+
 	if (!strcmp(var, "user.signingkey")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -143,12 +216,43 @@ int git_gpg_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "gpg.program")) {
+		struct signing_tool *tool = get_or_create_signing_tool("gpg");
+
 		if (!value)
 			return config_error_nonbool(var);
-		gpg_program = xstrdup(value);
+
+		free(tool->program);
+		tool->program = xstrdup(value);
 		return 0;
 	}
 
+	if (!strcmp(var, "signingtool.default"))
+		return git_config_string(&default_signing_tool, var, value);
+
+	if (!parse_config_key(var, "signingtool", &name, &name_len, &key) && name) {
+		char *tmpname = xmemdupz(name, name_len);
+		struct signing_tool *tool = get_or_create_signing_tool(tmpname);
+
+		free(tmpname);
+
+		if (!strcmp(key, "program")) {
+			if (!value)
+				return config_error_nonbool(var);
+
+			free(tool->program);
+			tool->program = xstrdup(value);
+			return 0;
+		}
+
+		if (!strcmp(key, "pemtype")) {
+			if (!value)
+				return config_error_nonbool(var);
+
+			string_list_append(&tool->pemtype, value);
+			return 0;
+		}
+	}
+
 	return 0;
 }
 
@@ -159,7 +263,9 @@ const char *get_signing_key(void)
 	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
 }
 
-int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
+static int sign_buffer_with(struct strbuf *buffer, struct strbuf *signature,
+			    const char *signing_key,
+			    const struct signing_tool *tool)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	int ret;
@@ -167,7 +273,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	struct strbuf gpg_status = STRBUF_INIT;
 
 	argv_array_pushl(&gpg.args,
-			 gpg_program,
+			 tool->program,
 			 "--status-fd=2",
 			 "-bsau", signing_key,
 			 NULL);
@@ -200,15 +306,42 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	return 0;
 }
 
+int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
+{
+	struct signing_tool *tool = get_signing_tool(default_signing_tool);
+	if (!tool || !tool->program)
+		return error(_("default signing tool '%s' has no program configured"),
+			     default_signing_tool);
+	return sign_buffer_with(buffer, signature, signing_key, tool);
+}
+
 int verify_signed_buffer(const char *payload, size_t payload_size,
 			 const char *signature, size_t signature_size,
-			 struct strbuf *gpg_output, struct strbuf *gpg_status)
+			 struct strbuf *gpg_output, struct strbuf *gpg_status,
+			 const struct signing_tool *tool)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
 	struct tempfile *temp;
 	int ret;
 	struct strbuf buf = STRBUF_INIT;
 
+	if (!tool) {
+		parse_signature(signature, signature_size, &tool);
+		if (!tool) {
+			/*
+			 * The caller didn't tell us which tool to use, and we
+			 * didn't recognize the format. Historically we've fed
+			 * these cases to blindly to gpg, so let's continue to
+			 * do so.
+			 */
+			tool = get_signing_tool("gpg");
+		}
+	}
+
+	if (!tool->program)
+		return error(_("signing tool '%s' has no program configured"),
+			     tool->name);
+
 	temp = mks_tempfile_t(".git_vtag_tmpXXXXXX");
 	if (!temp)
 		return error_errno(_("could not create temporary file"));
@@ -221,7 +354,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	}
 
 	argv_array_pushl(&gpg.args,
-			 gpg_program,
+			 tool->program,
 			 "--status-fd=1",
 			 "--keyid-format=long",
 			 "--verify", temp->filename.buf, "-",
diff --git a/gpg-interface.h b/gpg-interface.h
index a5e6517ae6..cee0dfe401 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -23,15 +23,27 @@ struct signature_check {
 	char *key;
 };
 
+struct signing_tool {
+	char *name;
+	char *program;
+	struct string_list pemtype;
+	struct signing_tool *next;
+};
+
 void signature_check_clear(struct signature_check *sigc);
 
 /*
- * Look at GPG signed content (e.g. a signed tag object), whose
+ * Look for signed content (e.g. a signed tag object), whose
  * payload is followed by a detached signature on it.  Return the
  * offset where the embedded detached signature begins, or the end of
  * the data when there is no such signature.
+ *
+ * If out_tool is non-NULL and a signature is found, it will be
+ * pointed at the signing_tool that corresponds to the found
+ * signature type.
  */
-size_t parse_signature(const char *buf, size_t size);
+size_t parse_signature(const char *buf, unsigned long size,
+		       const struct signing_tool **out_tool);
 
 void parse_gpg_output(struct signature_check *);
 
@@ -48,10 +60,16 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
  * Run "gpg" to see if the payload matches the detached signature.
  * gpg_output, when set, receives the diagnostic output from GPG.
  * gpg_status, when set, receives the status output from GPG.
+ *
+ * Typically the "tool" argument should come from a previous call to
+ * parse_signature(). If it's NULL, then verify_signed_buffer() will
+ * try to choose the appropriate tool based on the contents of the
+ * "signature" buffer.
  */
 int verify_signed_buffer(const char *payload, size_t payload_size,
 			 const char *signature, size_t signature_size,
-			 struct strbuf *gpg_output, struct strbuf *gpg_status);
+			 struct strbuf *gpg_output, struct strbuf *gpg_status,
+			 const struct signing_tool *tool);
 
 int git_gpg_config(const char *, const char *, void *);
 void set_signing_key(const char *);
diff --git a/log-tree.c b/log-tree.c
index bdf23c5f7b..f8fdff6e65 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -456,7 +456,7 @@ static void show_signature(struct rev_info *opt, struct commit *commit)
 
 	status = verify_signed_buffer(payload.buf, payload.len,
 				      signature.buf, signature.len,
-				      &gpg_output, NULL);
+				      &gpg_output, NULL, NULL);
 	if (status && !gpg_output.len)
 		strbuf_addstr(&gpg_output, "No signature\n");
 
@@ -498,6 +498,7 @@ static void show_one_mergetag(struct commit *commit,
 	struct strbuf verify_message;
 	int status, nth;
 	size_t payload_size, gpg_message_offset;
+	const struct signing_tool *tool;
 
 	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
 	tag = lookup_tag(&oid);
@@ -520,14 +521,14 @@ static void show_one_mergetag(struct commit *commit,
 			    "parent #%d, tagged '%s'\n", nth + 1, tag->tag);
 	gpg_message_offset = verify_message.len;
 
-	payload_size = parse_signature(extra->value, extra->len);
+	payload_size = parse_signature(extra->value, extra->len, &tool);
 	status = -1;
 	if (extra->len > payload_size) {
 		/* could have a good signature */
 		if (!verify_signed_buffer(extra->value, payload_size,
 					  extra->value + payload_size,
 					  extra->len - payload_size,
-					  &verify_message, NULL))
+					  &verify_message, NULL, tool))
 			status = 0; /* good */
 		else if (verify_message.len <= gpg_message_offset)
 			strbuf_addstr(&verify_message, "No signature\n");
diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216a..6ab66b9a7c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1009,7 +1009,7 @@ static void find_subpos(const char *buf, unsigned long sz,
 		buf++;
 
 	/* parse signature first; we might not even have a subject line */
-	*sig = buf + parse_signature(buf, strlen(buf));
+	*sig = buf + parse_signature(buf, strlen(buf), NULL);
 	*siglen = strlen(*sig);
 
 	/* subject is first non-empty line */
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index a5d3b2cbaa..08d23b0cf5 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -56,3 +56,29 @@ sanitize_pgp() {
 		/^-----BEGIN PGP/ and $in_pgp = 1;
 	'
 }
+
+create_fake_signer () {
+	write_script fake-signer <<-\EOF
+	if [ "$1 $2" = "--status-fd=2 -bsau" ]; then
+		echo >&2 "[GNUPG:] BEGIN_SIGNING"
+		echo >&2 "[GNUPG:] SIG_CREATED D 1 SHA256 0 1513792449 4A7FF9E2330D22B19213A4E9E9C423BE17EFEE70"
+		# avoid "-" in echo arguments
+		printf "%s\n" \
+		  "-----BEGIN FAKE SIGNER SIGNATURE-----" \
+		  "fake-signature" \
+		  "-----END FAKE SIGNER SIGNATURE-----"
+		exit 0
+
+	elif [ "$1 $2 $3" = "--status-fd=1 --keyid-format=long --verify" ]; then
+		echo "[GNUPG:] NEWSIG"
+		echo "[GNUPG:] GOODSIG 4A7FF9E2330D22B19213A4E9E9C423BE17EFEE70 /CN=Some User/EMail=some@user.email"
+		echo "[GNUPG:] TRUST_FULLY 0 shell"
+		echo >&2 "Good signature from /CN=Some User/EMail=some@user.email"
+		exit 0
+
+	else
+		echo "bad arguments" 1>&2
+		exit 1
+	fi
+	EOF
+}
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 762135adea..848a823302 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -5,6 +5,10 @@ test_description='signed commit tests'
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
+test_expect_success 'create fake signing program' '
+	create_fake_signer
+'
+
 test_expect_success GPG 'create signed commits' '
 	test_when_finished "test_unconfig commit.gpgsign" &&
 
@@ -51,13 +55,33 @@ test_expect_success GPG 'create signed commits' '
 	# commit.gpgsign is still on but this must not be signed
 	git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
 	# explicit -S of course must sign.
-	git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
+	git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree}) &&
+
+	git config signingtool.fake.program "$TRASH_DIRECTORY/fake-signer" &&
+	git config signingtool.fake.pemtype "FAKE SIGNER SIGNATURE" &&
+	echo 11 >file && test_tick && git commit -a -m eleventh &&
+	git tag eleventh-pgp-signed &&
+	git cat-file -p eleventh-pgp-signed >actual &&
+	grep "PGP SIGNATURE" actual &&
+
+	git config gpg.program "$TRASH_DIRECTORY/fake-signer" &&
+	echo 12 >file && test_tick && git commit -a -m twelfth && test_unconfig gpg.program &&
+	git tag twelfth-fake-signed &&
+	git cat-file -p twelfth-fake-signed >actual &&
+	grep "FAKE SIGNER SIGNATURE" actual &&
+
+	git config signingtool.default fake &&
+	echo 13 >file && test_tick && git commit -a -m thirteenth && test_unconfig signingtool.default &&
+	git tag thirteenth-fake-signed &&
+	git cat-file -p thirteenth-fake-signed >actual &&
+	grep "FAKE SIGNER SIGNATURE" actual
 '
 
 test_expect_success GPG 'verify and show signatures' '
 	(
 		for commit in initial second merge fourth-signed \
-			fifth-signed sixth-signed seventh-signed tenth-signed
+			fifth-signed sixth-signed seventh-signed tenth-signed \
+			eleventh-pgp-signed twelfth-fake-signed thirteenth-fake-signed
 		do
 			git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
@@ -98,7 +122,9 @@ test_expect_success GPG 'verify-commit exits success on untrusted signature' '
 
 test_expect_success GPG 'verify signatures with --raw' '
 	(
-		for commit in initial second merge fourth-signed fifth-signed sixth-signed seventh-signed
+		for commit in initial second merge fourth-signed fifth-signed sixth-signed \
+			seventh-signed eleventh-pgp-signed twelfth-fake-signed \
+			thirteenth-fake-signed
 		do
 			git verify-commit --raw $commit 2>actual &&
 			grep "GOODSIG" actual &&
diff --git a/tag.c b/tag.c
index 66210fd477..2d557e1f5e 100644
--- a/tag.c
+++ b/tag.c
@@ -15,7 +15,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 
 	memset(&sigc, 0, sizeof(sigc));
 
-	payload_size = parse_signature(buf, size);
+	payload_size = parse_signature(buf, size, NULL);
 
 	if (size == payload_size) {
 		if (flags & GPG_VERIFY_VERBOSE)
-- 
2.15.1 (Apple Git-101)

