Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A722C43381
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CC964FB7
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhBETWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 14:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhBETTD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 14:19:03 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6D4C06178A
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 12:48:57 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b81so5824109pfb.21
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 12:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1CZZ7sT8txP4Clz45vTPXG4zpTbdFuBel09Ltu6XMkY=;
        b=S76y/E8o5M7aFV4VnwKc5ivMDwWmdScyC/Dbs1VOOnMGxbydunvKZDhmrovK4EnIAO
         Mr+FFde/7iWOA/y2I1j28H+iLNZ19bIp8rg0A5JqmvkNmX1MTgzua1YEZxyCoJziFWEA
         8771UCLMB0QV0JzuxIExaOjsUByriw6KiM61FBw0dQgQM5LBv44/w8XxFlgjcVFnqH5Y
         t+w9S5j5ksiZWjKyC3aUP0g9IHIT8q/i+jZsehx4EmydgJdC6MhwxrnTjo/hGvd4U03e
         XPK873XhJ6rXYOwlFoTQO9uRS8Mwk6KPA54U2IPbHhgk+JnnbbqygAkGYps+UywTCAk3
         X2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1CZZ7sT8txP4Clz45vTPXG4zpTbdFuBel09Ltu6XMkY=;
        b=Fv9W9ArddyjJGp48EcJ/T9dvrHXu2UjAKys5uaEGcrjSLiPU8LohPInEBRQB0UGJoP
         lFvjLYYjd9gXp+yZLwU/xngQXKGbWpsFAn4K3JZEYbV4MAFM+PHr1iYqZcdJNtQdqGNt
         msKj8ub37PPEQOYMPxDI4LSPiLT2I6N1WMjAhstqHtfGKA2ccDKMy8jiufS9VRKRdOpb
         KnG7xSv9RfkGgA0vAoomHOLVWeHhIE8agukZ4hEYfidZhDYmvlcJLKxTmvMc29iO/ohQ
         XniEACIPwNyqEw0DVMJ7KnYjrrpZlXWs2WUhryWDYXO9/9USoLhCeG15ugNZUcc3nZCx
         41Bw==
X-Gm-Message-State: AOAM532HR8liOaUuVeHDlP7jzM3jmK4p7Hp9kUGzESR337/PwF1I81bV
        9hAXSBXHqeVqaVCk/fAl+lcTneVMDDq3dL+z8yOW8urYCCWpiu+f8vPbJ7XS0qcH1BG9uDPkHkQ
        SeMCZlucWe3uWDVwpvR0CG5+zXlifhJjgZ8UzvCjWbRD86p43DQowpd5zSwN3ZME1OqVIC6h0/6
        xa
X-Google-Smtp-Source: ABdhPJyonNvf/wykAZrjDtEr3dwuEfaoCfQpLn5Rp87UxSG+NLbq58fHqyhYfXeJbhwpEl8rP7hStbRxr7NuQX8Q0z/n
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:644a:: with SMTP id
 y10mr6028915pjm.129.1612558134173; Fri, 05 Feb 2021 12:48:54 -0800 (PST)
Date:   Fri,  5 Feb 2021 12:48:47 -0800
In-Reply-To: <cover.1612557937.git.jonathantanmy@google.com>
Message-Id: <8b0f55b5e49e2a4e7bb2dc0cf3b9a4c96e03af32.1612557937.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com> <cover.1612557937.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v8 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning, we choose the default branch based on the remote HEAD.
But if there is no remote HEAD reported (which could happen if the
target of the remote HEAD is unborn), we'll fall back to using our local
init.defaultBranch. Traditionally this hasn't been a big deal, because
most repos used "master" as the default. But these days it is likely to
cause confusion if the server and client implementations choose
different values (e.g., if the remote started with "main", we may choose
"master" locally, create commits there, and then the user is surprised
when they push to "master" and not "main").

To solve this, the remote needs to communicate the target of the HEAD
symref, even if it is unborn, and "git clone" needs to use this
information.

Currently, symrefs that have unborn targets (such as in this case) are
not communicated by the protocol. Teach Git to advertise and support the
"unborn" feature in "ls-refs" (by default, this is advertised, but
server administrators may turn this off through the lsrefs.unborn
config). This feature indicates that "ls-refs" supports the "unborn"
argument; when it is specified, "ls-refs" will send the HEAD symref with
the name of its unborn target.

This change is only for protocol v2. A similar change for protocol v0
would require independent protocol design (there being no analogous
position to signal support for "unborn") and client-side plumbing of the
data required, so the scope of this patch set is limited to protocol v2.

The client side will be updated to use this in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt                |  2 +
 Documentation/config/lsrefs.txt         |  9 +++
 Documentation/technical/protocol-v2.txt | 11 +++-
 ls-refs.c                               | 74 ++++++++++++++++++++++++-
 ls-refs.h                               |  1 +
 serve.c                                 |  2 +-
 t/t5701-git-serve.sh                    |  2 +-
 7 files changed, 95 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/config/lsrefs.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6ba50b1104..d08e83a148 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -398,6 +398,8 @@ include::config/interactive.txt[]
 
 include::config/log.txt[]
 
+include::config/lsrefs.txt[]
+
 include::config/mailinfo.txt[]
 
 include::config/mailmap.txt[]
diff --git a/Documentation/config/lsrefs.txt b/Documentation/config/lsrefs.txt
new file mode 100644
index 0000000000..adeda0f24d
--- /dev/null
+++ b/Documentation/config/lsrefs.txt
@@ -0,0 +1,9 @@
+lsrefs.unborn::
+	May be "advertise" (the default), "allow", or "ignore". If "advertise",
+	the server will respond to the client sending "unborn" (as described in
+	protocol-v2.txt) and will advertise support for this feature during the
+	protocol v2 capability advertisement. "allow" is the same as
+	"advertise" except that the server will not advertise support for this
+	feature; this is useful for load-balanced servers that cannot be
+	updated atomically (for example), since the administrator could
+	configure "allow", then after a delay, configure "advertise".
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 85daeb5d9e..f772d90eaf 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -192,11 +192,20 @@ ls-refs takes in the following arguments:
 	When specified, only references having a prefix matching one of
 	the provided prefixes are displayed.
 
+If the 'unborn' feature is advertised the following argument can be
+included in the client's request.
+
+    unborn
+	The server will send information about HEAD even if it is a symref
+	pointing to an unborn branch in the form "unborn HEAD
+	symref-target:<target>".
+
 The output of ls-refs is as follows:
 
     output = *ref
 	     flush-pkt
-    ref = PKT-LINE(obj-id SP refname *(SP ref-attribute) LF)
+    obj-id-or-unborn = (obj-id | "unborn")
+    ref = PKT-LINE(obj-id-or-unborn SP refname *(SP ref-attribute) LF)
     ref-attribute = (symref | peeled)
     symref = "symref-target:" symref-target
     peeled = "peeled:" obj-id
diff --git a/ls-refs.c b/ls-refs.c
index a1e0b473e4..32deb7be44 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -7,6 +7,39 @@
 #include "pkt-line.h"
 #include "config.h"
 
+static int config_read;
+static int advertise_unborn;
+static int allow_unborn;
+
+static void ensure_config_read(void)
+{
+	const char *str = NULL;
+
+	if (config_read)
+		return;
+
+	if (repo_config_get_string_tmp(the_repository, "lsrefs.unborn", &str)) {
+		/*
+		 * If there is no such config, advertise and allow it by
+		 * default.
+		 */
+		advertise_unborn = 1;
+		allow_unborn = 1;
+	} else {
+		if (!strcmp(str, "advertise")) {
+			advertise_unborn = 1;
+			allow_unborn = 1;
+		} else if (!strcmp(str, "allow")) {
+			allow_unborn = 1;
+		} else if (!strcmp(str, "ignore")) {
+			/* do nothing */
+		} else {
+			die(_("invalid value '%s' for lsrefs.unborn"), str);
+		}
+	}
+	config_read = 1;
+}
+
 /*
  * Check if one of the prefixes is a prefix of the ref.
  * If no prefixes were provided, all refs match.
@@ -32,6 +65,7 @@ struct ls_refs_data {
 	unsigned peel;
 	unsigned symrefs;
 	struct strvec prefixes;
+	unsigned unborn : 1;
 };
 
 static int send_ref(const char *refname, const struct object_id *oid,
@@ -47,7 +81,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	if (!ref_match(&data->prefixes, refname_nons))
 		return 0;
 
-	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+	if (oid)
+		strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+	else
+		strbuf_addf(&refline, "unborn %s", refname_nons);
 	if (data->symrefs && flag & REF_ISSYMREF) {
 		struct object_id unused;
 		const char *symref_target = resolve_ref_unsafe(refname, 0,
@@ -61,7 +98,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			    strip_namespace(symref_target));
 	}
 
-	if (data->peel) {
+	if (data->peel && oid) {
 		struct object_id peeled;
 		if (!peel_ref(refname, &peeled))
 			strbuf_addf(&refline, " peeled:%s", oid_to_hex(&peeled));
@@ -74,6 +111,23 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static void send_possibly_unborn_head(struct ls_refs_data *data)
+{
+	struct strbuf namespaced = STRBUF_INIT;
+	struct object_id oid;
+	int flag;
+	int oid_is_null;
+
+	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
+	if (!resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag))
+		return; /* bad ref */
+	oid_is_null = is_null_oid(&oid);
+	if (!oid_is_null ||
+	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
+		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);
+	strbuf_release(&namespaced);
+}
+
 static int ls_refs_config(const char *var, const char *value, void *data)
 {
 	/*
@@ -91,6 +145,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 
 	memset(&data, 0, sizeof(data));
 
+	ensure_config_read();
 	git_config(ls_refs_config, NULL);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
@@ -103,14 +158,27 @@ int ls_refs(struct repository *r, struct strvec *keys,
 			data.symrefs = 1;
 		else if (skip_prefix(arg, "ref-prefix ", &out))
 			strvec_push(&data.prefixes, out);
+		else if (!strcmp("unborn", arg))
+			data.unborn = allow_unborn;
 	}
 
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("expected flush after ls-refs arguments"));
 
-	head_ref_namespaced(send_ref, &data);
+	send_possibly_unborn_head(&data);
 	for_each_namespaced_ref(send_ref, &data);
 	packet_flush(1);
 	strvec_clear(&data.prefixes);
 	return 0;
 }
+
+int ls_refs_advertise(struct repository *r, struct strbuf *value)
+{
+	if (value) {
+		ensure_config_read();
+		if (advertise_unborn)
+			strbuf_addstr(value, "unborn");
+	}
+
+	return 1;
+}
diff --git a/ls-refs.h b/ls-refs.h
index 7b33a7c6b8..a99e4be0bd 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -6,5 +6,6 @@ struct strvec;
 struct packet_reader;
 int ls_refs(struct repository *r, struct strvec *keys,
 	    struct packet_reader *request);
+int ls_refs_advertise(struct repository *r, struct strbuf *value);
 
 #endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index eec2fe6f29..ac20c72763 100644
--- a/serve.c
+++ b/serve.c
@@ -73,7 +73,7 @@ struct protocol_capability {
 
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
-	{ "ls-refs", always_advertise, ls_refs },
+	{ "ls-refs", ls_refs_advertise, ls_refs },
 	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 	{ "server-option", always_advertise, NULL },
 	{ "object-format", object_format_advertise, NULL },
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index a1f5fdc9fd..df29504161 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -12,7 +12,7 @@ test_expect_success 'test capability advertisement' '
 	cat >expect <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
-	ls-refs
+	ls-refs=unborn
 	fetch=shallow
 	server-option
 	object-format=$(test_oid algo)
-- 
2.30.0.365.g02bc693789-goog

