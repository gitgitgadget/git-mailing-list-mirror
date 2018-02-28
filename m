Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7B31F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965010AbeB1XYI (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:08 -0500
Received: from mail-yw0-f202.google.com ([209.85.161.202]:50003 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964992AbeB1XXw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:52 -0500
Received: by mail-yw0-f202.google.com with SMTP id n124so2359871ywf.16
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=qQiWnmNvj4QhKW6+yt3usbQ1bZhvAF/GMGkrgG9DAog=;
        b=pw5agDZ2vyzWK4g03azVpF7s8F05WIhFB8qTCaRJxWXKMO9b60TNaeb5WdpBzwtBl9
         wPjSSmCgvlOCltcn1Mt00Cjno/50aO9RdqFEktcPFT9FP/KNcSeF0kq2gMyvvds8WkO9
         82sUn6NAgG9pb0KBAq3MLPPE1W+OcCRgx6wVNcKAAQsapLLQ18pklwpRKcP7Ffjv1Rf3
         5u6E+ZXaJA7Luz/nT981He5BILicwwQy2GfolNi5G+cfoaFzZTAvqUq0gDAWX1Ak6IB0
         YfH4c6n74/Hc8yvCaiRLwavjin44MZykJwoMI+izhu6u8ScV5KrX3NFJPZrB/q2FTZap
         HrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=qQiWnmNvj4QhKW6+yt3usbQ1bZhvAF/GMGkrgG9DAog=;
        b=fJrWiGEz0j1/G1dRkdEOGmcoxFI/uJ7NNwz3Uih+qBCk2hd7p8cMu1gD3jopISE14t
         tF8x6pgtpXexLGzpkWB7/YVd9nBgVhBfPBb2QPvipDe89iWMMWYK3oCy2yq7F7Oa2HFy
         oGhO3fEcFUYVrBGv4nxG4I2JGdGRV6wSded6X/vcwTORxx7M14BidcUcROY46T01Z8Cs
         QMgkOl8L7Ncuj/qLxWTLoq7sQoA+oQtsEGaLrqag0OZVpHPp7CMUHOiDuQBunZlqVLZb
         Dls9aw0zdNnXwpXmr4pgG9xHESIxfbuXHKp9whnLHOm89K/EKtyLEnanL10UtIKIjQtR
         U7gw==
X-Gm-Message-State: APf1xPAcGuM+SnwrVPun75J2tEibDhKo7YU/Uea3exjvCJpCP08kKezw
        jgDhqPI0nHf9F1yl4GWRtInnToVx1L3rnotjD2FxWFfrUQQ2z/GUsxPbUf+ZhUS7/9oFxlg+M6Z
        1V2apF099fU4C+5G17hxJxvR9M5YU0rJtsjYf9yBCNJqsqCZYgiO9XrR0eA==
X-Google-Smtp-Source: AG47ELuEwgi1Mcj4uxLlG2AUINgqVORg1m2bDO2Lrb9TSqxG8KZsLUFRnquSEz76FQ9UuWK6jkVxdFEumzE=
MIME-Version: 1.0
X-Received: by 2002:a25:6d54:: with SMTP id i81-v6mr10140672ybc.64.1519860231375;
 Wed, 28 Feb 2018 15:23:51 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:30 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-14-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 13/35] ls-refs: introduce ls-refs server command
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
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
 Documentation/technical/protocol-v2.txt |  36 ++++++
 Makefile                                |   1 +
 ls-refs.c                               | 144 ++++++++++++++++++++++++
 ls-refs.h                               |   9 ++
 serve.c                                 |   8 ++
 t/t5701-git-serve.sh                    | 115 +++++++++++++++++++
 6 files changed, 313 insertions(+)
 create mode 100644 ls-refs.c
 create mode 100644 ls-refs.h

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index b02eefc21..7f50e6462 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -169,3 +169,39 @@ printable ASCII characters except space (i.e., the byte range 32 < x <
 "git/1.8.3.1"). The agent strings are purely informative for statistics
 and debugging purposes, and MUST NOT be used to programmatically assume
 the presence or absence of particular features.
+
+ ls-refs
+---------
+
+`ls-refs` is the command used to request a reference advertisement in v2.
+Unlike the current reference advertisement, ls-refs takes in arguments
+which can be used to limit the refs sent from the server.
+
+Additional features not supported in the base command will be advertised
+as the value of the command in the capability advertisement in the form
+of a space separated list of features, e.g.  "<command>=<feature 1>
+<feature 2>".
+
+ls-refs takes in the following arguments:
+
+    symrefs
+	In addition to the object pointed by it, show the underlying ref
+	pointed by it when showing a symbolic ref.
+    peel
+	Show peeled tags.
+    ref-pattern <pattern>
+	When specified, only references matching one of the provided
+	patterns are displayed.  A pattern is either a valid refname
+	(e.g.  refs/heads/master), in which a ref must match the pattern
+	exactly, or a prefix of a ref followed by a single '*' wildcard
+	character (e.g. refs/heads/*), in which a ref must have a prefix
+	equal to the pattern up to the wildcard character.
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
index 000000000..91d7deb34
--- /dev/null
+++ b/ls-refs.c
@@ -0,0 +1,144 @@
+#include "cache.h"
+#include "repository.h"
+#include "refs.h"
+#include "remote.h"
+#include "argv-array.h"
+#include "ls-refs.h"
+#include "pkt-line.h"
+
+struct ref_pattern {
+	char *pattern;
+	int wildcard_pos; /* If > 0, indicates the position of the wildcard */
+};
+
+struct pattern_list {
+	struct ref_pattern *patterns;
+	int nr;
+	int alloc;
+};
+
+static void add_pattern(struct pattern_list *patterns, const char *pattern)
+{
+	struct ref_pattern p;
+	const char *wildcard;
+
+	p.pattern = strdup(pattern);
+
+	wildcard = strchr(pattern, '*');
+	if (wildcard) {
+		p.wildcard_pos = wildcard - pattern;
+	} else {
+		p.wildcard_pos = -1;
+	}
+
+	ALLOC_GROW(patterns->patterns,
+		   patterns->nr + 1,
+		   patterns->alloc);
+	patterns->patterns[patterns->nr++] = p;
+}
+
+static void clear_patterns(struct pattern_list *patterns)
+{
+	int i;
+	for (i = 0; i < patterns->nr; i++)
+		free(patterns->patterns[i].pattern);
+	FREE_AND_NULL(patterns->patterns);
+	patterns->nr = 0;
+	patterns->alloc = 0;
+}
+
+/*
+ * Check if one of the patterns matches the tail part of the ref.
+ * If no patterns were provided, all refs match.
+ */
+static int ref_match(const struct pattern_list *patterns, const char *refname)
+{
+	int i;
+
+	if (!patterns->nr)
+		return 1; /* no restriction */
+
+	for (i = 0; i < patterns->nr; i++) {
+		const struct ref_pattern *p = &patterns->patterns[i];
+
+		/* No wildcard, exact match expected */
+		if (p->wildcard_pos < 0) {
+			if (!strcmp(refname, p->pattern))
+				return 1;
+		} else {
+			/* Wildcard, prefix match until the wildcard */
+			if (!strncmp(refname, p->pattern, p->wildcard_pos))
+				return 1;
+		}
+	}
+
+	return 0;
+}
+
+struct ls_refs_data {
+	unsigned peel;
+	unsigned symrefs;
+	struct pattern_list patterns;
+};
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
+	struct ls_refs_data data;
+
+	memset(&data, 0, sizeof(data));
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
+			add_pattern(&data.patterns, out);
+	}
+
+	head_ref_namespaced(send_ref, &data);
+	for_each_namespaced_ref(send_ref, &data);
+	packet_flush(1);
+	clear_patterns(&data.patterns);
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
index cf23179b9..c7925c5c7 100644
--- a/serve.c
+++ b/serve.c
@@ -4,8 +4,15 @@
 #include "pkt-line.h"
 #include "version.h"
 #include "argv-array.h"
+#include "ls-refs.h"
 #include "serve.h"
 
+static int always_advertise(struct repository *r,
+			    struct strbuf *value)
+{
+	return 1;
+}
+
 static int agent_advertise(struct repository *r,
 			   struct strbuf *value)
 {
@@ -44,6 +51,7 @@ struct protocol_capability {
 
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
+	{ "ls-refs", always_advertise, ls_refs },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index affbad097..11aeb0541 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -8,6 +8,7 @@ test_expect_success 'test capability advertisement' '
 	cat >expect <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
+	ls-refs
 	0000
 	EOF
 
@@ -57,4 +58,118 @@ test_expect_success 'request invalid command' '
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
+	ref-pattern refs/heads/master
+	ref-pattern refs/tags/one
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
2.16.2.395.g2e18187dfd-goog

