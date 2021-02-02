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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D79C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F3064EE7
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhBBCPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhBBCPv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:15:51 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF914C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:15:10 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id k126so14868858qkf.8
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Yoynf2SVWwBUlVht9/cvugGlswKZb9RZGvw6Wlw0Ue8=;
        b=QOiQhBDT5mx4OZLzjXZJevAiEQkiJbTg7PZ0ck724zWmdFOZOuYlzj36alDn293O0R
         mn6inQYluG1jL5T/+3XbWXXnfi3Ao4kx6chvnwIKJBZDY5BhBDGeg29DwSC/AKcm9vTd
         fRwIqyT42sq7rqldaC7O0/DrEfhc73oqTf3ZkHDxXH5cbDkTQkIgvE/WolAggnVEDAPJ
         uiTWUG0E/U7DrwLM3W0n2AlaxTYxbPaHBtvDyBAjZhEaGzRf/q4lNKvknZPcogqYsaDx
         9FlG+y7fAe2yDH6d7jvw8tBQeyHTUn35aKipaXsVGts0OyHsCaGebtJhOBgg3C49lAus
         KSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Yoynf2SVWwBUlVht9/cvugGlswKZb9RZGvw6Wlw0Ue8=;
        b=tMUXwbuCokw23HzqsD64tz0jj+ZIDm1PaUEPCR/JKgJaDi4dt8quL1ViD3Hl2l/F/t
         o/Kqz3U78w4XXWP0BZFi2HKlShdASmJQOEHEsGGcRV9pwcPOl1N1dBf+d3X441SQ+wK/
         eJiZh4GjVugjKTEcSeOjtIs2lzLNxIN3PosWd1XOhC6gW3+seKcCrt7bbPtwOW6QC957
         0rNLvyM6hGDdlfOLbpkHbStzEqLOQhB8YVUCFfpyxfRVfGTX+MtxdnvoJBH3MXiGNGT0
         pL+0i3Enp/VBUUXXyoHKPNlGxxWA7DN8/P3Phj9RU24rvUhfPMiQExLYwEgNDtWByyzj
         qv6g==
X-Gm-Message-State: AOAM533WX+MrO66qO3A0cvFZHrq7uQPj0IZLaytCRStK4RtzUIoPMdu4
        8hrmC3kmqXaCvRzZc/q76aIir/EnhJCS8gLfUgtJNdjHk+coqZ9jU8BGPjgAUGl0XwCvaJXonA5
        mlGAzzkUFCp5oNCF46elUaem48ncCTMVFOaPIz5l+3jIiECqxkTf2taMUupIEmOSMJowPN358zC
        t8
X-Google-Smtp-Source: ABdhPJwV012bKbzjawCdZETBedjOZsznqfv7b19/bG8UAMWIdv16MxCmK3yRrSlv2rUKrFmo9PqNjvpLLQ2EMGbmkxYg
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:56e8:: with SMTP id
 cr8mr18101056qvb.6.1612232109764; Mon, 01 Feb 2021 18:15:09 -0800 (PST)
Date:   Mon,  1 Feb 2021 18:14:59 -0800
In-Reply-To: <cover.1612231707.git.jonathantanmy@google.com>
Message-Id: <411bbafe25f60c2ef9d9ab773e5eb046b8549b2d.1612231707.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201208013121.677494-1-jonathantanmy@google.com> <cover.1612231707.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v6 1/3] ls-refs: report unborn targets of symrefs
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
server administrators may turn this off through the lsrefs.allowunborn
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
 Documentation/config/lsrefs.txt         |  3 ++
 Documentation/technical/protocol-v2.txt | 10 ++++-
 ls-refs.c                               | 59 +++++++++++++++++++++++--
 ls-refs.h                               |  1 +
 serve.c                                 |  2 +-
 t/t5701-git-serve.sh                    |  2 +-
 7 files changed, 73 insertions(+), 6 deletions(-)
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
index 0000000000..dcbec11aaa
--- /dev/null
+++ b/Documentation/config/lsrefs.txt
@@ -0,0 +1,3 @@
+lsrefs.allowUnborn::
+	Allow the server to send information about unborn symrefs during the
+	protocol v2 ref advertisement.
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 85daeb5d9e..4707511c10 100644
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
index a1e0b473e4..daf4e77a4a 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -7,6 +7,24 @@
 #include "pkt-line.h"
 #include "config.h"
 
+static int config_read;
+static int allow_unborn;
+
+static void ensure_config_read(void)
+{
+	if (config_read)
+		return;
+
+	if (repo_config_get_bool(the_repository, "lsrefs.allowunborn",
+				 &allow_unborn))
+		/*
+		 * If there is no such config, set it to 1 to allow it by
+		 * default.
+		 */
+		allow_unborn = 1;
+	config_read = 1;
+}
+
 /*
  * Check if one of the prefixes is a prefix of the ref.
  * If no prefixes were provided, all refs match.
@@ -32,6 +50,7 @@ struct ls_refs_data {
 	unsigned peel;
 	unsigned symrefs;
 	struct strvec prefixes;
+	unsigned unborn : 1;
 };
 
 static int send_ref(const char *refname, const struct object_id *oid,
@@ -47,7 +66,10 @@ static int send_ref(const char *refname, const struct object_id *oid,
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
@@ -61,7 +83,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 			    strip_namespace(symref_target));
 	}
 
-	if (data->peel) {
+	if (data->peel && oid) {
 		struct object_id peeled;
 		if (!peel_ref(refname, &peeled))
 			strbuf_addf(&refline, " peeled:%s", oid_to_hex(&peeled));
@@ -74,6 +96,23 @@ static int send_ref(const char *refname, const struct object_id *oid,
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
@@ -91,6 +130,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 
 	memset(&data, 0, sizeof(data));
 
+	ensure_config_read();
 	git_config(ls_refs_config, NULL);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
@@ -103,14 +143,27 @@ int ls_refs(struct repository *r, struct strvec *keys,
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
+		if (allow_unborn)
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

