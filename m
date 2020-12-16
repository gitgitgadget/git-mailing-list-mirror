Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAE2C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 02:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADD722210
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 02:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgLPCIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 21:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPCIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 21:08:52 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9BCC061794
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 18:08:12 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id gj22so668507pjb.6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 18:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aLkt6+Pi6rElxAtnsAvih88IRQu9L1US/CRiriIXBSA=;
        b=rQaan3jzeiRIs3SNxVB09KzVv6k+DQSkW7/4PGy+Skmz7YoDbBEq5IjxXconVBcAGl
         wUlP90lxSDCB+FvcXfLICqrq4hFVhHyxeAlH3lUIZ5T4OcYaaOKm6SebGoFARSJb2Dav
         So/0A8Z917Te6wyTXUU7PFAlC7S8Mz3lo9xLn3ir3y16D+qwVoD5yVJ9TQkGsDIxcWMS
         RunVWXaxOBy4IIPVmnA5JvVCnc6Yk6nwC49n73rzlXjIDTNg0Xo3t57Fz5kLtGQwaVL/
         41RTMSccuag7fzJbYyBFBBU0qndYlWlfRtqzSyGlImoiO+NKDA5+2MA3VPaoljH5Jfns
         NkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aLkt6+Pi6rElxAtnsAvih88IRQu9L1US/CRiriIXBSA=;
        b=CD6JDnBwiIRvWayqqbgkIu1dJ+gb6lmi3yRXnO3P1YBnvOyrb43ajzct+kQVljcGTU
         ospYzWuqbyUquy0yiGkaeaNfdby/6to6g+ltcQbSvc6UUqdGDO4xbkKGiikI9BDo0I4f
         zkPEH3QdNksTGiNald9UgETATM1iFeZJg57Nm5cvtDHJoVgnkIRb0fVNYLnfP8qm5SAr
         kTcR6n3a/i8jCEM3kA8kaj6cuaB82GXmpAvCDpmjRYrtAR73tRPyLjjLvonuN1Rq8qIb
         9fQoAlQ2IpuzvUxQJ4UjnpKPbyPs4iX1hy9TM6aI7qS6inz76xwJL+NHx3oA/lOHE94N
         A+hQ==
X-Gm-Message-State: AOAM532X5gI1gE8xnnedvn0rUh+MbMkVQ0B2zP68Hn9x6Yr4CMNqewTB
        o+ii+Em4KtDzubRcp2jGxTtfFt2AOdAHA1EFR4wdwGlHdZzX2a+uKDOX8QvexLmBmKBQFRvF0CW
        n/X4Y1rB6kuWCFFegQZ74v0trFSNU4dnNTlI7Z5LRJ6+ng247lHGRLPJJZgoSWepjSl/rFyruZl
        Cb
X-Google-Smtp-Source: ABdhPJxjax6iPFA5Bc4lGPHJG+GilUAC9uGtxDBF/z6lVhiE5447Fh/4/276l8PPl+tIe/FjEZnECXanPU8p+EWBRJHj
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:25c7:0:b029:156:72a3:b0c0 with
 SMTP id l190-20020a6225c70000b029015672a3b0c0mr30132953pfl.59.1608084491724;
 Tue, 15 Dec 2020 18:08:11 -0800 (PST)
Date:   Tue, 15 Dec 2020 18:07:56 -0800
In-Reply-To: <cover.1608084282.git.jonathantanmy@google.com>
Message-Id: <7f5b50c7b284f2630fe5be6455cc5d3e03b1eb70.1608084282.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201211210508.2337494-1-jonathantanmy@google.com> <cover.1608084282.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH v2 1/3] ls-refs: report unborn targets of symrefs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, felipe.contreras@gmail.com, gitster@pobox.com,
        avarab@gmail.com, Jonathan Tan <jonathantanmy@google.com>
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
"unborn" feature in "ls-refs" (guarded by the lsrefs.unborn config).
This feature indicates that "ls-refs" supports the "unborn" argument;
when it is specified, "ls-refs" will send the HEAD symref with the name
of its unborn target.

This change is only for protocol v2. A similar change for protocol v0
would require independent protocol design (there being no analogous
position to signal support for "unborn") and client-side plumbing of the
data required, so the scope of this patch set is limited to protocol v2.

The client side will be updated to use this in a subsequent commit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/protocol-v2.txt | 10 ++++-
 ls-refs.c                               | 54 +++++++++++++++++++++++--
 ls-refs.h                               |  1 +
 serve.c                                 |  2 +-
 4 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index e597b74da3..dfe03aa114 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -192,11 +192,19 @@ ls-refs takes in the following arguments:
 	When specified, only references having a prefix matching one of
 	the provided prefixes are displayed.
 
+If the 'unborn' feature is advertised the following argument can be
+included in the client's request.
+
+    unborn
+	The server may send symrefs pointing to unborn branches in the form
+	"unborn <refname> symref-target:<target>".
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
index a1e0b473e4..fdb644b482 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -32,6 +32,8 @@ struct ls_refs_data {
 	unsigned peel;
 	unsigned symrefs;
 	struct strvec prefixes;
+	unsigned allow_unborn : 1;
+	unsigned unborn : 1;
 };
 
 static int send_ref(const char *refname, const struct object_id *oid,
@@ -47,7 +49,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
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
@@ -74,8 +79,28 @@ static int send_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int ls_refs_config(const char *var, const char *value, void *data)
+static void send_possibly_unborn_head(struct ls_refs_data *data)
 {
+	struct strbuf namespaced = STRBUF_INIT;
+	struct object_id oid;
+	int flag;
+	int null_oid;
+
+	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
+	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
+	null_oid = is_null_oid(&oid);
+	if (!null_oid || (data->symrefs && (flag & REF_ISSYMREF)))
+		send_ref(namespaced.buf, null_oid ? NULL : &oid, flag, data);
+	strbuf_release(&namespaced);
+}
+
+static int ls_refs_config(const char *var, const char *value, void *cb_data)
+{
+	struct ls_refs_data *data = cb_data;
+
+	if (!strcmp("lsrefs.unborn", var))
+		data->allow_unborn = !strcmp(value, "allow") ||
+			!strcmp(value, "advertise");
 	/*
 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
 	 * config. This may need to eventually be expanded to "receive", but we
@@ -91,7 +116,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 
 	memset(&data, 0, sizeof(data));
 
-	git_config(ls_refs_config, NULL);
+	git_config(ls_refs_config, &data);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
@@ -103,14 +128,35 @@ int ls_refs(struct repository *r, struct strvec *keys,
 			data.symrefs = 1;
 		else if (skip_prefix(arg, "ref-prefix ", &out))
 			strvec_push(&data.prefixes, out);
+		else if (data.allow_unborn && !strcmp("unborn", arg))
+			data.unborn = 1;
 	}
 
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("expected flush after ls-refs arguments"));
 
-	head_ref_namespaced(send_ref, &data);
+	if (data.unborn)
+		send_possibly_unborn_head(&data);
+	else
+		head_ref_namespaced(send_ref, &data);
 	for_each_namespaced_ref(send_ref, &data);
 	packet_flush(1);
 	strvec_clear(&data.prefixes);
 	return 0;
 }
+
+int ls_refs_advertise(struct repository *r, struct strbuf *value)
+{
+	if (value) {
+		char *str = NULL;
+
+		if (!repo_config_get_string(the_repository, "lsrefs.unborn",
+					    &str) &&
+		    !strcmp("advertise", str)) {
+			strbuf_addstr(value, "unborn");
+			free(str);
+		}
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
index f6341206c4..30cb56d507 100644
--- a/serve.c
+++ b/serve.c
@@ -62,7 +62,7 @@ struct protocol_capability {
 
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
-	{ "ls-refs", always_advertise, ls_refs },
+	{ "ls-refs", ls_refs_advertise, ls_refs },
 	{ "fetch", upload_pack_advertise, upload_pack_v2 },
 	{ "server-option", always_advertise, NULL },
 	{ "object-format", object_format_advertise, NULL },
-- 
2.29.2.684.gfbc64c5ab5-goog

