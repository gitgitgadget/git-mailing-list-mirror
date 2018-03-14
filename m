Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7984C1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeCNSc6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:32:58 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:43598 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeCNScs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:48 -0400
Received: by mail-oi0-f74.google.com with SMTP id j68so2146293oih.10
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=qrLawsSmhQapQIrlcZRaWV7MF1rVD4bAQgWpbl7XOyw=;
        b=PStejuWjevjncOQp8IrxGQLhZzaabhsuQtvQEHJtJDZyWcyRZZ0XUjOXwHHwLKMrqz
         38YcmR7Q/3H05hW5zA5wPZti1Xs5lQbft4IJi9Axkt4uxRdoPyVoc7JAabMcskbuyw/d
         rb2IchBqg30iZOoqmRpgAz2WQL69IVH4pyEF2+gGkrIY0bzl0QWxyeAjjab6fQCyAWIH
         65dwJBXriKcjAAl2AWaw2vRIcwnFjjDwr7w7FzSPYllg+f6LL3ncs8WUDt2osH/Nr21I
         M41VMaz9KSqKpvRtsm2+TAv68cYZbiIQYHWTWeEXzFGaM3E9pJBd/HEDd5omnxLbYo4C
         jssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=qrLawsSmhQapQIrlcZRaWV7MF1rVD4bAQgWpbl7XOyw=;
        b=isQPE+TY25Izl9SNtHe+rrz7Ke+84/jdWks2W69n2RcK8eG1VesAOBCmmKbmnDpsIr
         r2XQKgbyYCA3gq3owoloQkgJhD598lgPMTYXCfD6XPTi8zd+xViWkSKyR1wwmSUTKBCj
         Grb94fVj3BV8bmz6Rrdefy1DAYGIKRJPorgpsUxDDQ/qmiqMYGmyUTulYc/N//1QkTq8
         txNHPMb1mGK5KbWxrI4UVXT1m1aFVp834d1HCdV+UDbVEYZUbQ3LanhUUm1EKdYtOosK
         b7bU+6njoUd2hpcssCShnKUiQej1npl6gG4gSX2w09ILM/hrVtpAbntnDuJhjxJJiq+S
         FfLA==
X-Gm-Message-State: AElRT7G5nJ1fiYyEQMh7jeLMGSiKHv9iItoRuqt8VvdWTI3JGASRo8Of
        KG8T8vS93Nk49OeuLhNW94IrDb1cvCdAEuZ12wcVoOUiAdQ7raQ2/WX1KNH7Fwrz1w4aWqp9LkR
        D2MRSK45/W/5IeJF4zhrcd6JBkfb3FElPa5qvFRdAIhz+4xolWm1cX7TewA==
X-Google-Smtp-Source: AG47ELuJzj3ljOu4XzdnIc4m+AkR0ZHs3roAS1g8n3uP2MIA95b7F7r4dRsrqRZ4mTVoULP1KtfriEsjMN8=
MIME-Version: 1.0
X-Received: by 10.202.204.82 with SMTP id c79mr2491891oig.0.1521052367386;
 Wed, 14 Mar 2018 11:32:47 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:50 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-14-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 13/35] ls-refs: introduce ls-refs server command
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
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
advertisement based on provided ref-prefixes.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/protocol-v2.txt |  31 +++++++
 Makefile                                |   1 +
 ls-refs.c                               |  96 ++++++++++++++++++++
 ls-refs.h                               |  10 +++
 serve.c                                 |   8 ++
 t/t5701-git-serve.sh                    | 115 ++++++++++++++++++++++++
 6 files changed, 261 insertions(+)
 create mode 100644 ls-refs.c
 create mode 100644 ls-refs.h

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 3a671497b2..422edf870e 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -172,3 +172,34 @@ printable ASCII characters except space (i.e., the byte range 32 < x <
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
+of a space separated list of features: "<command>=<feature 1> <feature 2>"
+
+ls-refs takes in the following arguments:
+
+    symrefs
+	In addition to the object pointed by it, show the underlying ref
+	pointed by it when showing a symbolic ref.
+    peel
+	Show peeled tags.
+    ref-prefix <prefix>
+	When specified, only references having a prefix matching one of
+	the provided prefixes are displayed.
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
index 18c255428a..e50927cfb3 100644
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
index 0000000000..a06f12eca8
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
+/*
+ * Check if one of the prefixes is a prefix of the ref.
+ * If no prefixes were provided, all refs match.
+ */
+static int ref_match(const struct argv_array *prefixes, const char *refname)
+{
+	int i;
+
+	if (!prefixes->argc)
+		return 1; /* no restriction */
+
+	for (i = 0; i < prefixes->argc; i++) {
+		const char *prefix = prefixes->argv[i];
+
+		if (starts_with(refname, prefix))
+			return 1;
+	}
+
+	return 0;
+}
+
+struct ls_refs_data {
+	unsigned peel;
+	unsigned symrefs;
+	struct argv_array prefixes;
+};
+
+static int send_ref(const char *refname, const struct object_id *oid,
+		    int flag, void *cb_data)
+{
+	struct ls_refs_data *data = cb_data;
+	const char *refname_nons = strip_namespace(refname);
+	struct strbuf refline = STRBUF_INIT;
+
+	if (!ref_match(&data->prefixes, refname))
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
+int ls_refs(struct repository *r, struct argv_array *keys,
+	    struct packet_reader *request)
+{
+	struct ls_refs_data data;
+
+	memset(&data, 0, sizeof(data));
+
+	while (packet_reader_read(request) != PACKET_READ_FLUSH) {
+		const char *arg = request->line;
+		const char *out;
+
+		if (!strcmp("peel", arg))
+			data.peel = 1;
+		else if (!strcmp("symrefs", arg))
+			data.symrefs = 1;
+		else if (skip_prefix(arg, "ref-prefix ", &out))
+			argv_array_push(&data.prefixes, out);
+	}
+
+	head_ref_namespaced(send_ref, &data);
+	for_each_namespaced_ref(send_ref, &data);
+	packet_flush(1);
+	argv_array_clear(&data.prefixes);
+	return 0;
+}
diff --git a/ls-refs.h b/ls-refs.h
new file mode 100644
index 0000000000..b62877e8da
--- /dev/null
+++ b/ls-refs.h
@@ -0,0 +1,10 @@
+#ifndef LS_REFS_H
+#define LS_REFS_H
+
+struct repository;
+struct argv_array;
+struct packet_reader;
+extern int ls_refs(struct repository *r, struct argv_array *keys,
+		   struct packet_reader *request);
+
+#endif /* LS_REFS_H */
diff --git a/serve.c b/serve.c
index 7ddcba9003..1cb5fb9b5b 100644
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
@@ -46,6 +53,7 @@ struct protocol_capability {
 
 static struct protocol_capability capabilities[] = {
 	{ "agent", agent_advertise, NULL },
+	{ "ls-refs", always_advertise, ls_refs },
 };
 
 static void advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index affbad097d..d03e08eebd 100755
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
+test_expect_success 'basic ref-prefixes' '
+	test-pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	0001
+	ref-prefix refs/heads/master
+	ref-prefix refs/tags/one
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
+test_expect_success 'refs/heads prefix' '
+	test-pkt-line pack >in <<-EOF &&
+	command=ls-refs
+	0001
+	ref-prefix refs/heads/
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
+	ref-prefix refs/tags/
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
+	ref-prefix refs/heads/
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
2.16.2.804.g6dcf76e118-goog

