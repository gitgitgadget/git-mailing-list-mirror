Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3AA20281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdI2UMT (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:19 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:47525 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdI2UMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:16 -0400
Received: by mail-pf0-f171.google.com with SMTP id u12so338874pfl.4
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9f0IPTwwI7vOVoCsSjEUbft2MN2lexvyzSpxuzSgDn0=;
        b=K5SMYM3qvOf08b3mPJeeOTRn141botjtio4DPjq/XvVuuSlhtilUFAG7kCXxEP9/oE
         MrdTGCYFc4DYWcFv6tFeRA/5dCL7i9Vf5EP393BAUs8BRMZ0Fq1xsc7M+yYy9xOtEYDC
         W7nVx0/p/KLcW0L11Eayf8YfQOSPhu7BMH7HxyUeKhGBbTW47aQlkZM9V1J1Ztyq1JoV
         tUxXKKvYl7CEpy+d1DTwdmIo0IoScW9PREDgr+nUcTk0Sdqa2Xsv0UKpGMvbg7+FxwLZ
         +ho+83/O3XcDVUL7Ln2Ab6GR5A3vB2r1P+f3P6cit2e/krYV+YT/X07YScktDD7x/cyV
         CrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9f0IPTwwI7vOVoCsSjEUbft2MN2lexvyzSpxuzSgDn0=;
        b=R7IEkhDV3yrjKTglGzLU/iHeF6t+2dINY2BaQvOJPG7OtqvVrNqDOT7Q7uUAB6x7SN
         SsLa1DPV6m7pyXKDXuiHharqLbHw4vRQyb8Ta9G0C7uVx6DMmmKofH2d6+K5Zim7Slzf
         2W4siEo+mEI4juuNcpOn2wb6Qm9yjmxLkFssvnd3/hFlP66T/uiy/HeddKhGoCSj7orb
         QDmOMICCECfZtGmBuYOZSBy5kjT5fTGVFo7uUoKYopKSH59Whgeb7fwZnHnM6Ej3FLca
         b5PNhXECiZx06TKYrvySd2l4KWZCnjdjYnuiebqGa5oOYfDTHvZT8ekQId10qTIHvBDo
         ONEA==
X-Gm-Message-State: AHPjjUgvQWOY2XjPac24OYazclqjExyyWj2wmL7EzopcSr6XvKQyRQ38
        nWtAvN13Hx0iHMadg1nN3YWMn2Hgwb4=
X-Google-Smtp-Source: AOwi7QCRj4AsxBForlRPfvl2MLh/lFi7Nu13CAW8AtYKmIp4R0VNQsTCohciweog3x8tK1TE8asEpw==
X-Received: by 10.98.213.201 with SMTP id d192mr8919620pfg.210.1506715935252;
        Fri, 29 Sep 2017 13:12:15 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:14 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 06/18] introduce fetch-object: fetch one promisor object
Date:   Fri, 29 Sep 2017 13:11:42 -0700
Message-Id: <94b52786a5b652749f1109e2baee482161a8cc28.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce fetch-object, providing the ability to fetch one object from a
promisor remote.

This uses fetch-pack. To do this, the transport mechanism has been
updated with 2 flags, "from-promisor" to indicate that the resulting
pack comes from a promisor remote (and thus should be annotated as such
by index-pack), and "no-haves" to suppress the sending of "have" lines.

This will be tested in a subsequent commit.

NEEDSWORK: update this when we have more information about protocol v2,
which should allow a way to suppress the ref advertisement and
officially allow any object type to be "want"-ed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile             |  1 +
 builtin/fetch-pack.c |  8 ++++++++
 builtin/index-pack.c | 16 +++++++++++++---
 fetch-object.c       | 23 +++++++++++++++++++++++
 fetch-object.h       |  6 ++++++
 fetch-pack.c         |  8 ++++++--
 fetch-pack.h         |  2 ++
 remote-curl.c        | 14 +++++++++++++-
 transport.c          |  8 ++++++++
 transport.h          |  8 ++++++++
 10 files changed, 88 insertions(+), 6 deletions(-)
 create mode 100644 fetch-object.c
 create mode 100644 fetch-object.h

diff --git a/Makefile b/Makefile
index ed5960e6b..4303ef6f8 100644
--- a/Makefile
+++ b/Makefile
@@ -789,6 +789,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
+LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
 LIB_OBJS += gettext.o
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 366b9d13f..9f303cf98 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -143,6 +143,14 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (!strcmp("--from-promisor", arg)) {
+			args.from_promisor = 1;
+			continue;
+		}
+		if (!strcmp("--no-haves", arg)) {
+			args.no_haves = 1;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 7ad170590..14ebb2f17 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1429,14 +1429,16 @@ static void write_special_file(const char *suffix, const char *msg,
 		if (close(fd) != 0)
 			die_errno(_("cannot close written %s file '%s'"),
 				  suffix, filename);
-		*report = suffix;
+		if (report)
+			*report = suffix;
 	}
 	strbuf_release(&name_buf);
 }
 
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
-		  const char *keep_msg, unsigned char *sha1)
+		  const char *keep_msg, const char *promisor_msg,
+		  unsigned char *sha1)
 {
 	const char *report = "pack";
 	struct strbuf pack_name = STRBUF_INIT;
@@ -1455,6 +1457,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (keep_msg)
 		write_special_file("keep", keep_msg, final_pack_name, sha1,
 				   &report);
+	if (promisor_msg)
+		write_special_file("promisor", promisor_msg, final_pack_name,
+				   sha1, NULL);
 
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name)
@@ -1644,6 +1649,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
 	const char *keep_msg = NULL;
+	const char *promisor_msg = NULL;
 	struct strbuf index_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
@@ -1693,6 +1699,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 				keep_msg = "";
 			} else if (starts_with(arg, "--keep=")) {
 				keep_msg = arg + 7;
+			} else if (!strcmp(arg, "--promisor")) {
+				promisor_msg = "";
+			} else if (starts_with(arg, "--promisor=")) {
+				promisor_msg = arg + strlen("--promisor=");
 			} else if (starts_with(arg, "--threads=")) {
 				char *end;
 				nr_threads = strtoul(arg+10, &end, 0);
@@ -1803,7 +1813,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
-		      keep_msg,
+		      keep_msg, promisor_msg,
 		      pack_sha1);
 	else
 		close(input_fd);
diff --git a/fetch-object.c b/fetch-object.c
new file mode 100644
index 000000000..f89dbba75
--- /dev/null
+++ b/fetch-object.c
@@ -0,0 +1,23 @@
+#include "cache.h"
+#include "packfile.h"
+#include "pkt-line.h"
+#include "strbuf.h"
+#include "transport.h"
+
+void fetch_object(const char *remote_name, const unsigned char *sha1)
+{
+	struct remote *remote;
+	struct transport *transport;
+	struct ref *ref;
+
+	remote = remote_get(remote_name);
+	if (!remote->url[0])
+		die(_("Remote with no URL"));
+	transport = transport_get(remote, remote->url[0]);
+
+	ref = alloc_ref(sha1_to_hex(sha1));
+	hashcpy(ref->old_oid.hash, sha1);
+	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	transport_set_option(transport, TRANS_OPT_NO_HAVES, "1");
+	transport_fetch_refs(transport, ref);
+}
diff --git a/fetch-object.h b/fetch-object.h
new file mode 100644
index 000000000..f371300c8
--- /dev/null
+++ b/fetch-object.h
@@ -0,0 +1,6 @@
+#ifndef FETCH_OBJECT_H
+#define FETCH_OBJECT_H
+
+extern void fetch_object(const char *remote_name, const unsigned char *sha1);
+
+#endif
diff --git a/fetch-pack.c b/fetch-pack.c
index 105506e9a..d376c4ef1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -450,6 +450,8 @@ static int find_common(struct fetch_pack_args *args,
 
 	flushes = 0;
 	retval = -1;
+	if (args->no_haves)
+		goto done;
 	while ((oid = get_rev())) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
@@ -832,7 +834,7 @@ static int get_pack(struct fetch_pack_args *args,
 		argv_array_push(&cmd.args, alternate_shallow_file);
 	}
 
-	if (do_keep) {
+	if (do_keep || args->from_promisor) {
 		if (pack_lockfile)
 			cmd.out = -1;
 		cmd_name = "index-pack";
@@ -842,7 +844,7 @@ static int get_pack(struct fetch_pack_args *args,
 			argv_array_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			argv_array_push(&cmd.args, "--fix-thin");
-		if (args->lock_pack || unpack_limit) {
+		if (do_keep && (args->lock_pack || unpack_limit)) {
 			char hostname[HOST_NAME_MAX + 1];
 			if (xgethostname(hostname, sizeof(hostname)))
 				xsnprintf(hostname, sizeof(hostname), "localhost");
@@ -852,6 +854,8 @@ static int get_pack(struct fetch_pack_args *args,
 		}
 		if (args->check_self_contained_and_connected)
 			argv_array_push(&cmd.args, "--check-self-contained-and-connected");
+		if (args->from_promisor)
+			argv_array_push(&cmd.args, "--promisor");
 	}
 	else {
 		cmd_name = "unpack-objects";
diff --git a/fetch-pack.h b/fetch-pack.h
index b6aeb43a8..84904c348 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -29,6 +29,8 @@ struct fetch_pack_args {
 	unsigned cloning:1;
 	unsigned update_shallow:1;
 	unsigned deepen:1;
+	unsigned from_promisor:1;
+	unsigned no_haves:1;
 };
 
 /*
diff --git a/remote-curl.c b/remote-curl.c
index 0053b0954..34a81b8d3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -33,7 +33,9 @@ struct options {
 		thin : 1,
 		/* One of the SEND_PACK_PUSH_CERT_* constants. */
 		push_cert : 2,
-		deepen_relative : 1;
+		deepen_relative : 1,
+		from_promisor : 1,
+		no_haves : 1;
 };
 static struct options options;
 static struct string_list cas_options = STRING_LIST_INIT_DUP;
@@ -157,6 +159,12 @@ static int set_option(const char *name, const char *value)
 			return -1;
 		return 0;
 #endif /* LIBCURL_VERSION_NUM >= 0x070a08 */
+	} else if (!strcmp(name, "from-promisor")) {
+		options.from_promisor = 1;
+		return 0;
+	} else if (!strcmp(name, "no-haves")) {
+		options.no_haves = 1;
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -822,6 +830,10 @@ static int fetch_git(struct discovery *heads,
 				 options.deepen_not.items[i].string);
 	if (options.deepen_relative && options.depth)
 		argv_array_push(&args, "--deepen-relative");
+	if (options.from_promisor)
+		argv_array_push(&args, "--from-promisor");
+	if (options.no_haves)
+		argv_array_push(&args, "--no-haves");
 	argv_array_push(&args, url.buf);
 
 	for (i = 0; i < nr_heads; i++) {
diff --git a/transport.c b/transport.c
index d75ff0514..fb46e33bf 100644
--- a/transport.c
+++ b/transport.c
@@ -161,6 +161,12 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
 		opts->deepen_relative = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_FROM_PROMISOR)) {
+		opts->from_promisor = !!value;
+		return 0;
+	} else if (!strcmp(name, TRANS_OPT_NO_HAVES)) {
+		opts->no_haves = !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -229,6 +235,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
 	args.update_shallow = data->options.update_shallow;
+	args.from_promisor = data->options.from_promisor;
+	args.no_haves = data->options.no_haves;
 
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0);
diff --git a/transport.h b/transport.h
index bc5571574..67428f6df 100644
--- a/transport.h
+++ b/transport.h
@@ -15,6 +15,8 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	unsigned deepen_relative : 1;
+	unsigned from_promisor : 1;
+	unsigned no_haves : 1;
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
@@ -210,6 +212,12 @@ void transport_check_allowed(const char *type);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* Indicate that these objects are being fetched by a promisor */
+#define TRANS_OPT_FROM_PROMISOR "from-promisor"
+
+/* Do not send "have" lines */
+#define TRANS_OPT_NO_HAVES "no-haves"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.14.2.822.g60be5d43e6-goog

