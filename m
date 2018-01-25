Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467931F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeAYX7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:35 -0500
Received: from mail-ot0-f202.google.com ([74.125.82.202]:52629 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbeAYX7O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:14 -0500
Received: by mail-ot0-f202.google.com with SMTP id n19so6033002ota.19
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=aLPOORX2kMxvOzkW+8v1MeKtbiFCQXCEknEPDOeFYTY=;
        b=nh9NeihrnUNq7UTC+KwE1yZrYpsAOQAGjXE2LE6p+n4EiMvVNasRigVsfxUezts1IT
         Gvh9EWAF/vMBfw052UA1i1h0LgvDNyo3XxuPIn8hraDBmKDuAxE6JsTpRE3/nj1bXyej
         YmuZ2awmhkSp6LNRJpm44LwH+fWD8zjMZA4EX2gMOlclg+o3vPjhKZGnOavn/Ol+NNOh
         8QDCST1zh6lIX4bJSVU4RQofS4tCcLzn12xymGKu2jCV6Lw2gzWiHXsKwU5eBJbcSLS2
         JW8gC98fSAWcMSgntONlVfI5u/7K/8DkP33+gWymrGzAWORsaG5aGfbhcNmtRXymi2Gg
         gBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=aLPOORX2kMxvOzkW+8v1MeKtbiFCQXCEknEPDOeFYTY=;
        b=I4IgtB2d+tHYOuLlkdfIMd+mnG3OAzlO30RBEH5qjXk48VtdwH8fThP+yMnbjOa+RU
         X92xM++Kq5WIa3qvDfy0x5v0WR42uNYU27RNEmlLxFw1CyafdGXLZ7QZTeieMgpFkGaG
         wmW92Ygnsv9P2koEhvqjQdcfuBgmsnGX51R1mq6xJl5y/RTO/vTUKuLdMyt6Hy26O/YU
         v4kJOtFSvIIQM3hw5nLJMjbovucAzRCBaeIKqQLdHGaS3yr8IvUnYcOBEMtRWp+EEhVk
         3flDiiLiLwn8lZvUk+FgOtPxjaJd8C8aCewj8nSeu3Ura7vuNBvpUWQObEFwBg8PvLzq
         Hd4Q==
X-Gm-Message-State: AKwxytc/RALa8BP3ghgP2Yc3djPgumlYAhwtF9O3Yqrz+z04jirfOdr/
        4AsNXSfu/p4zZ176scgFcggAIQDYZkSWT7roF4mS9NVYOM/FR2z5MXyYumonYp5WpgFHLu6I34b
        TNxyFgUXWan+P75x37b9MMk9sDHj3rrR/aN2dRDla8iwWUOuCHNx7g3+Eng==
X-Google-Smtp-Source: AH8x227kBa9wybfMDFv+YC/L3oVQ0ivvg7N0Pwzw7jx0/e1ni0Yp3aOxLKwPmt2J2G06/TwUdNhOvUgH/Vo=
MIME-Version: 1.0
X-Received: by 10.157.37.228 with SMTP id q91mr10575594ota.1.1516924753424;
 Thu, 25 Jan 2018 15:59:13 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:24 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-14-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 13/27] ls-refs: introduce ls-refs server command
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the ls-refs server command.  In protocol v2, the ls-refs
command is used to request the ref advertisement from the server.  Since
it is a command which can be requested (as opposed to mandatory in v1),
a client can sent a number of parameters in its request to limit the ref
advertisement based on provided ref-patterns.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/protocol-v2.txt |  32 +++++++++
 Makefile                                |   1 +
 ls-refs.c                               |  96 ++++++++++++++++++++++++++
 ls-refs.h                               |   9 +++
 serve.c                                 |   2 +
 t/t5701-git-serve.sh                    | 115 ++++++++++++++++++++++++++++++++
 6 files changed, 255 insertions(+)
 create mode 100644 ls-refs.c
 create mode 100644 ls-refs.h

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 7f619a76c..4683d41ac 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -115,3 +115,35 @@ complete it (multiple for negotiation during fetch or no additional
 trips in the case of ls-refs).  If the client sends the `stateless-rpc`
 capability with a value of `true` (in the form `stateless-rpc=true`)
 then the invoked command must only last a single round.
+
+ ls-refs
+---------
+
+`ls-refs` is the command used to request a reference advertisement in v2.
+Unlike the current reference advertisement, ls-refs takes in parameters
+which can be used to limit the refs sent from the server.
+
+Additional features not supported in the base command will be advertised
+as the value of the command in the capability advertisement in the form
+of a space separated list of features, e.g.  "<command>=<feature 1>
+<feature 2>".
+
+ls-refs takes in the following parameters wrapped in packet-lines:
+
+    symrefs
+	In addition to the object pointed by it, show the underlying ref
+	pointed by it when showing a symbolic ref.
+    peel
+	Show peeled tags.
+    ref-pattern <pattern>
+	When specified, only references matching the one of the provided
+	patterns are displayed.
+
+The output of ls-refs is as follows:
+
+    output = *ref
+	     flush-pkt
+    ref = PKT-LINE(obj-id SP refname *(SP ref-attribute) LF)
+    ref-attribute = (symref | peeled)
+    symref = "symref-target:" symref-target
+    peeled = "peeled:" obj-id
diff --git a/Makefile b/Makefile
index 18c255428..e50927cfb 100644
--- a/Makefile
+++ b/Makefile
@@ -825,6 +825,7 @@ LIB_OBJS += list-objects-filter-options.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
+LIB_OBJS += ls-refs.o
 LIB_OBJS += mailinfo.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
diff --git a/ls-refs.c b/ls-refs.c
new file mode 100644
index 000000000..70682b4f7
--- /dev/null
+++ b/ls-refs.c
@@ -0,0 +1,96 @@
+#include "cache.h"
+#include "repository.h"
+#include "refs.h"
+#include "remote.h"
+#include "argv-array.h"
+#include "ls-refs.h"
+#include "pkt-line.h"
+
+struct ls_refs_data {
+	unsigned peel;
+	unsigned symrefs;
+	struct argv_array patterns;
+};
+
+/*
+ * Check if one of the patterns matches the tail part of the ref.
+ * If no patterns were provided, all refs match.
+ */
+static int ref_match(const struct argv_array *patterns, const char *refname)
+{
+	char *pathbuf;
+	int i;
+
+	if (!patterns->argc)
+		return 1; /* no restriction */
+
+	pathbuf = xstrfmt("/%s", refname);
+	for (i = 0; i < patterns->argc; i++) {
+		if (!wildmatch(patterns->argv[i], pathbuf, 0)) {
+			free(pathbuf);
+			return 1;
+		}
+	}
+	free(pathbuf);
+	return 0;
+}
+
+static int send_ref(const char *refname, const struct object_id *oid,
+		    int flag, void *cb_data)
+{
+	struct ls_refs_data *data = cb_data;
+	const char *refname_nons = strip_namespace(refname);
+	struct strbuf refline = STRBUF_INIT;
+
+	if (!ref_match(&data->patterns, refname))
+		return 0;
+
+	strbuf_addf(&refline, "%s %s", oid_to_hex(oid), refname_nons);
+	if (data->symrefs && flag & REF_ISSYMREF) {
+		struct object_id unused;
+		const char *symref_target = resolve_ref_unsafe(refname, 0,
+							       &unused,
+							       &flag);
+
+		if (!symref_target)
+			die("'%s' is a symref but it is not?", refname);
+
+		strbuf_addf(&refline, " symref-target:%s", symref_target);
+	}
+
+	if (data->peel) {
+		struct object_id peeled;
+		if (!peel_ref(refname, &peeled))
+			strbuf_addf(&refline, " peeled:%s", oid_to_hex(&peeled));
+	}
+
+	strbuf_addch(&refline, '\n');
+	packet_write(1, refline.buf, refline.len);
+
+	strbuf_release(&refline);
+	return 0;
+}
+
+int ls_refs(struct repository *r, struct argv_array *keys, struct argv_array *args)
+{
+	int i;
+	struct ls_refs_data data = { 0, 0, ARGV_ARRAY_INIT };
+
+	for (i = 0; i < args->argc; i++) {
+		const char *arg = args->argv[i];
+		const char *out;
+
+		if (!strcmp("peel", arg))
+			data.peel = 1;
+		else if (!strcmp("symrefs", arg))
+			data.symrefs = 1;
+		else if (skip_prefix(arg, "ref-pattern ", &out))
+			argv_array_pushf(&data.patterns, "*/%s", out);
+	}
+
+	head_ref_namespaced(send_ref, &data);
+	for_each_namespaced_ref(send_ref, &data);
+	packet_flush(1);
+	argv_array_clear(&data.patterns);
+	return 0;
+}
diff --git a/ls-refs.h b/ls-refs.h
new file mode 100644
index 000000000..9e4c57bfe
--- /dev/null
+++ b/ls-refs.h
@@ -0,0 +1,9 @@
+#ifndef LS_REFS_H
+#define LS_REFS_H
+
+struct repository;
+struct argv_array;
+extern int ls_refs(struct repository *r, struct argv_array *keys,
+		   struct argv_array *args);
+
+#endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index 90e3defe8..2f404154a 100644
--- a/serve.c
+++ b/serve.c
@@ -4,6 +4,7 @@
 #include "pkt-line.h"
 #include "version.h"
 #include "argv-array.h"
+#include "ls-refs.h"
 #include "serve.h"
 
 static int always_advertise(struct repository *r,
@@ -51,6 +52,7 @@ struct protocol_capability {
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
 	{ "stateless-rpc", always_advertise, NULL },
+	{ "ls-refs", always_advertise, ls_refs },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index b5cc049e5..debdc1b8d 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -9,6 +9,7 @@ test_expect_success 'test capability advertisement' '
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	stateless-rpc
+	ls-refs
 	0000
 	EOF
 
@@ -53,4 +54,118 @@ test_expect_success 'request invalid command' '
 	test_i18ngrep "invalid command" err
 '
 
+# Test the basics of ls-refs
+#
+test_expect_success 'setup some refs and tags' '
+	test_commit one &&
+	git branch dev master &&
+	test_commit two &&
+	git symbolic-ref refs/heads/release refs/heads/master &&
+	git tag -a -m "annotated tag" annotated-tag
+'
+
+test_expect_success 'basics of ls-refs' '
+	test-pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) HEAD
+	$(git rev-parse refs/heads/dev) refs/heads/dev
+	$(git rev-parse refs/heads/master) refs/heads/master
+	$(git rev-parse refs/heads/release) refs/heads/release
+	$(git rev-parse refs/tags/annotated-tag) refs/tags/annotated-tag
+	$(git rev-parse refs/tags/one) refs/tags/one
+	$(git rev-parse refs/tags/two) refs/tags/two
+	0000
+	EOF
+
+	git serve --stateless-rpc <in >out &&
+	test-pkt-line unpack <out >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'basic ref-patterns' '
+	test-pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	0001
+	ref-pattern master
+	ref-pattern one
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/master) refs/heads/master
+	$(git rev-parse refs/tags/one) refs/tags/one
+	0000
+	EOF
+
+	git serve --stateless-rpc <in >out &&
+	test-pkt-line unpack <out >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'wildcard ref-patterns' '
+	test-pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	0001
+	ref-pattern refs/heads/*
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/dev) refs/heads/dev
+	$(git rev-parse refs/heads/master) refs/heads/master
+	$(git rev-parse refs/heads/release) refs/heads/release
+	0000
+	EOF
+
+	git serve --stateless-rpc <in >out &&
+	test-pkt-line unpack <out >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'peel parameter' '
+	test-pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	0001
+	peel
+	ref-pattern refs/tags/*
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/tags/annotated-tag) refs/tags/annotated-tag peeled:$(git rev-parse refs/tags/annotated-tag^{})
+	$(git rev-parse refs/tags/one) refs/tags/one
+	$(git rev-parse refs/tags/two) refs/tags/two
+	0000
+	EOF
+
+	git serve --stateless-rpc <in >out &&
+	test-pkt-line unpack <out >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'symrefs parameter' '
+	test-pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	0001
+	symrefs
+	ref-pattern refs/heads/*
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse refs/heads/dev) refs/heads/dev
+	$(git rev-parse refs/heads/master) refs/heads/master
+	$(git rev-parse refs/heads/release) refs/heads/release symref-target:refs/heads/master
+	0000
+	EOF
+
+	git serve --stateless-rpc <in >out &&
+	test-pkt-line unpack <out >actual &&
+	test_cmp actual expect
+'
+
 test_done
-- 
2.16.0.rc1.238.g530d649a79-goog

