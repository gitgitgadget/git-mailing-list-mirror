Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C501F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935825AbeFMVjg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:39:36 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:47078 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935813AbeFMVjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:39:35 -0400
Received: by mail-qt0-f201.google.com with SMTP id b8-v6so2993340qto.13
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=M16n/vpwyOV8P/IOzPd1QU0E2NdpUSAokf8IgQZB9vw=;
        b=npuP88+UCONrtAeibcb6XpAnWXefkIQ8WjTd25eSm2TffR5Jhvn7esNN5Nmf3NFKjo
         MHeamdLExMdNdVO1PwPexoCXbeio1rY6RyoRbfT4LFdabiQm8LWnl9sZXBfgpTLMZggf
         zCZrsl2NHknsZ6jbokAUB9/oYQaQYtubD5kilQ6g5KILr547k53OTWvNxNiGSG6kUg8f
         81IPZFeYc+bGmC+kiB1zN2uuPxmwLmUHIpsrBIuMUNbKwXVnPNQCw2Dum9LlPpQDUs3Y
         dKE/lqZcDC3a7m/2WUwbGzt9G0RSXY5HoiAhbpDh6mbBUpt+sNsGiYCDSXRdE21JhCfy
         bCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=M16n/vpwyOV8P/IOzPd1QU0E2NdpUSAokf8IgQZB9vw=;
        b=WgmRtx2423YUFtSjG9rJAfFIEcy/+C0l7cCtbh3tuztzk4bOC+C1ZXuyUKwaDZoULQ
         Goa2wlkmw72cbXa+Ay1upv8Lbu+8s+wiK9emfTcnuvRTyduHz5xTCCL3bVolBfIxVgD6
         N4uaGigJjBtFbqkcDgVE0NvtxnmDQ5LWI9kGR6z5uYiYB2AlJ5yIPhhKcXT1zaLaTbfs
         PAk3mkNbnb39WqiZp3g9FxrNm9x1bYb/4p3ZeZ4kLbwFsPcSUbs3AKfp07z8EvYZh9TZ
         1Z0eS7C0mjz+UvfKPRe1E+e2vxTEoZdE2NC5qvmrF9BCU0op89li12OGxuMupCg8X1JX
         5ztA==
X-Gm-Message-State: APt69E3ZnZbmZzsTDspmetKgclW5ZQa7t4PxJkK7xBX0MtntY3ZH+4Z6
        R5iEktResvrbrl10acNkhptqTDxJb04PD/jjhe06MKItzRZ5q/cBRtOkx/lbP3Tlxcyt529I/Vm
        NKV+u5OxUvOlVIFEtHZ98HbFyzhQHuHKTunvus1atdKq3rQbOyegoFMbQSA==
X-Google-Smtp-Source: ADUXVKKR1a9oQLb+bol43uFD/SLltoiV5pGwjRFiEpBL/XwpLXx0Qgy7pOidcltZfJp6JZwReiO6TxlBpEI=
MIME-Version: 1.0
X-Received: by 2002:ac8:4250:: with SMTP id r16-v6mr3378718qtm.27.1528925974127;
 Wed, 13 Jun 2018 14:39:34 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:39:19 -0700
In-Reply-To: <20180613213925.10560-1-bmwill@google.com>
Message-Id: <20180613213925.10560-3-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Subject: [PATCH v2 2/8] upload-pack: implement ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, ramsay@ramsayjones.plus.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, while performing packfile negotiation, clients are only
allowed to specify their desired objects using object ids.  This causes
a vulnerability to failure when an object turns non-existent during
negotiation, which may happen if, for example, the desired repository is
provided by multiple Git servers in a load-balancing arrangement.

In order to eliminate this vulnerability, implement the ref-in-want
feature for the 'fetch' command in protocol version 2.  This feature
enables the 'fetch' command to support requests in the form of ref names
through a new "want-ref <ref>" parameter.  At the conclusion of
negotiation, the server will send a list of all of the wanted references
(as provided by "want-ref" lines) in addition to the generated packfile.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt                |   7 ++
 Documentation/technical/protocol-v2.txt |  29 ++++-
 t/t5703-upload-pack-ref-in-want.sh      | 153 ++++++++++++++++++++++++
 upload-pack.c                           |  64 ++++++++++
 4 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100755 t/t5703-upload-pack-ref-in-want.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a..fb1dd7428 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3479,6 +3479,13 @@ Note that this configuration variable is ignored if it is seen in the
 repository-level config (this is a safety measure against fetching from
 untrusted repositories).
 
+uploadpack.allowRefInWant::
+	If this option is set, `upload-pack` will support the `ref-in-want`
+	feature of the protocol version 2 `fetch` command.  This feature
+	is intended for the benefit of load-balanced servers which may
+	not have the same view of what OIDs their refs point to due to
+	replication delay.
+
 url.<base>.insteadOf::
 	Any URL that starts with this value will be rewritten to
 	start, instead, with <base>. In cases where some site serves a
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 49bda76d2..6020632b4 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -299,12 +299,22 @@ included in the client's request:
 	for use with partial clone and partial fetch operations. See
 	`rev-list` for possible "filter-spec" values.
 
+If the 'ref-in-want' feature is advertised, the following argument can
+be included in the client's request as well as the potential addition of
+the 'wanted-refs' section in the server's response as explained below.
+
+    want-ref <ref>
+	Indicates to the server that the client wants to retrieve a
+	particular ref, where <ref> is the full name of a ref on the
+	server.  A server should ignore any "want-ref <ref>" lines where
+	<ref> doesn't exist on the server.
+
 The response of `fetch` is broken into a number of sections separated by
 delimiter packets (0001), with each section beginning with its section
 header.
 
     output = *section
-    section = (acknowledgments | shallow-info | packfile)
+    section = (acknowledgments | shallow-info | wanted-refs | packfile)
 	      (flush-pkt | delim-pkt)
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
@@ -319,6 +329,10 @@ header.
     shallow = "shallow" SP obj-id
     unshallow = "unshallow" SP obj-id
 
+    wanted-refs = PKT-LINE("wanted-refs" LF)
+		  *PKT-LINE(wanted-ref LF)
+    wanted-ref = obj-id SP refname
+
     packfile = PKT-LINE("packfile" LF)
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
@@ -379,6 +393,19 @@ header.
 	* This section is only included if a packfile section is also
 	  included in the response.
 
+    wanted-refs section
+	* This section is only included if the client has requested a
+	  ref using a 'want-ref' line and if a packfile section is also
+	  included in the response.
+
+	* Always begins with the section header "wanted-refs"
+
+	* The server will send a ref listing ("<oid> <refname>") for
+	  each reference requested using 'want-ref' lines.
+
+	* The server MUST NOT send any refs which were not requested
+	  using 'want-ref' lines.
+
     packfile section
 	* This section is only included if the client has sent 'want'
 	  lines in its request and either requested that no more
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
new file mode 100755
index 000000000..0ef182970
--- /dev/null
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -0,0 +1,153 @@
+#!/bin/sh
+
+test_description='upload-pack ref-in-want'
+
+. ./test-lib.sh
+
+get_actual_refs() {
+	sed -n '/wanted-refs/,/0001/p' <out | sed '1d;$d' | test-pkt-line unpack >actual_refs
+}
+
+get_actual_commits() {
+	sed -n '/packfile/,/0000/p' <out | sed '1d' | test-pkt-line unpack-sideband >o.pack &&
+	git index-pack o.pack &&
+	git verify-pack -v o.idx | grep commit | cut -c-40 | sort >actual_commits
+}
+
+check_output() {
+	get_actual_refs &&
+	test_cmp expected_refs actual_refs &&
+	get_actual_commits &&
+	test_cmp expected_commits actual_commits
+}
+
+# c(o/foo) d(o/bar)
+#        \ /
+#         b   e(baz)  f(master)
+#          \__  |  __/
+#             \ | /
+#               a
+test_expect_success 'setup repository' '
+	test_commit a &&
+	git checkout -b o/foo &&
+	test_commit b &&
+	test_commit c &&
+	git checkout -b o/bar b &&
+	test_commit d &&
+	git checkout -b baz a &&
+	test_commit e &&
+	git checkout master &&
+	test_commit f
+'
+
+test_expect_success 'config controls ref-in-want advertisement' '
+	git serve --advertise-capabilities >out &&
+	! grep -a ref-in-want out &&
+
+	git config uploadpack.allowRefInWant false &&
+	git serve --advertise-capabilities >out &&
+	! grep -a ref-in-want out &&
+
+	git config uploadpack.allowRefInWant true &&
+	git serve --advertise-capabilities >out &&
+	grep -a ref-in-want out
+'
+
+test_expect_success 'invalid want-ref line' '
+	test-pkt-line pack >in <<-EOF &&
+	command=fetch
+	0001
+	no-progress
+	want-ref refs/heads/non-existent
+	done
+	0000
+	EOF
+
+	test_must_fail git serve --stateless-rpc 2>out <in &&
+	grep "unknown ref" out
+'
+
+test_expect_success 'basic want-ref' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse f) refs/heads/master
+	EOF
+	git rev-parse f | sort >expected_commits &&
+
+	test-pkt-line pack >in <<-EOF &&
+	command=fetch
+	0001
+	no-progress
+	want-ref refs/heads/master
+	have $(git rev-parse a)
+	done
+	0000
+	EOF
+
+	git serve --stateless-rpc >out <in &&
+	check_output
+'
+
+test_expect_success 'multiple want-ref lines' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse c) refs/heads/o/foo
+	$(git rev-parse d) refs/heads/o/bar
+	EOF
+	git rev-parse c d | sort >expected_commits &&
+
+	test-pkt-line pack >in <<-EOF &&
+	command=fetch
+	0001
+	no-progress
+	want-ref refs/heads/o/foo
+	want-ref refs/heads/o/bar
+	have $(git rev-parse b)
+	done
+	0000
+	EOF
+
+	git serve --stateless-rpc >out <in &&
+	check_output
+'
+
+test_expect_success 'mix want and want-ref' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse f) refs/heads/master
+	EOF
+	git rev-parse e f | sort >expected_commits &&
+
+	test-pkt-line pack >in <<-EOF &&
+	command=fetch
+	0001
+	no-progress
+	want-ref refs/heads/master
+	want $(git rev-parse e)
+	have $(git rev-parse a)
+	done
+	0000
+	EOF
+
+	git serve --stateless-rpc >out <in &&
+	check_output
+'
+
+test_expect_success 'want-ref with ref we already have commit for' '
+	cat >expected_refs <<-EOF &&
+	$(git rev-parse c) refs/heads/o/foo
+	EOF
+	>expected_commits &&
+
+	test-pkt-line pack >in <<-EOF &&
+	command=fetch
+	0001
+	no-progress
+	want-ref refs/heads/o/foo
+	have $(git rev-parse c)
+	done
+	0000
+	EOF
+
+	git serve --stateless-rpc >out <in &&
+	check_output
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 87c6722ea..94b17c038 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -64,6 +64,7 @@ static const char *pack_objects_hook;
 
 static int filter_capability_requested;
 static int allow_filter;
+static int allow_ref_in_want;
 static struct list_objects_filter_options filter_options;
 
 static void reset_timeout(void)
@@ -1075,6 +1076,8 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 			return git_config_string(&pack_objects_hook, var, value);
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
 		allow_filter = git_config_bool(var, value);
+	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
+		allow_ref_in_want = git_config_bool(var, value);
 	}
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
@@ -1114,6 +1117,7 @@ void upload_pack(struct upload_pack_options *options)
 
 struct upload_pack_data {
 	struct object_array wants;
+	struct string_list wanted_refs;
 	struct oid_array haves;
 
 	struct object_array shallows;
@@ -1135,12 +1139,14 @@ struct upload_pack_data {
 static void upload_pack_data_init(struct upload_pack_data *data)
 {
 	struct object_array wants = OBJECT_ARRAY_INIT;
+	struct string_list wanted_refs = STRING_LIST_INIT_DUP;
 	struct oid_array haves = OID_ARRAY_INIT;
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
 	memset(data, 0, sizeof(*data));
 	data->wants = wants;
+	data->wanted_refs = wanted_refs;
 	data->haves = haves;
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
@@ -1149,6 +1155,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 static void upload_pack_data_clear(struct upload_pack_data *data)
 {
 	object_array_clear(&data->wants);
+	string_list_clear(&data->wanted_refs, 1);
 	oid_array_clear(&data->haves);
 	object_array_clear(&data->shallows);
 	string_list_clear(&data->deepen_not, 0);
@@ -1185,6 +1192,32 @@ static int parse_want(const char *line)
 	return 0;
 }
 
+static int parse_want_ref(const char *line, struct string_list *wanted_refs)
+{
+	const char *arg;
+	if (skip_prefix(line, "want-ref ", &arg)) {
+		struct object_id oid;
+		struct string_list_item *item;
+		struct object *o;
+
+		if (read_ref(arg, &oid))
+			return 1;
+
+		item = string_list_append(wanted_refs, arg);
+		item->util = oiddup(&oid);
+
+		o = parse_object_or_die(&oid, arg);
+		if (!(o->flags & WANTED)) {
+			o->flags |= WANTED;
+			add_object_array(o, NULL, &want_obj);
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
+
 static int parse_have(const char *line, struct oid_array *haves)
 {
 	const char *arg;
@@ -1210,6 +1243,8 @@ static void process_args(struct packet_reader *request,
 		/* process want */
 		if (parse_want(arg))
 			continue;
+		if (allow_ref_in_want && parse_want_ref(arg, &data->wanted_refs))
+			continue;
 		/* process have line */
 		if (parse_have(arg, &data->haves))
 			continue;
@@ -1352,6 +1387,24 @@ static int process_haves_and_send_acks(struct upload_pack_data *data)
 	return ret;
 }
 
+static void send_wanted_ref_info(struct upload_pack_data *data)
+{
+	const struct string_list_item *item;
+
+	if (!data->wanted_refs.nr)
+		return;
+
+	packet_write_fmt(1, "wanted-refs\n");
+
+	for_each_string_list_item(item, &data->wanted_refs) {
+		packet_write_fmt(1, "%s %s\n",
+				 oid_to_hex(item->util),
+				 item->string);
+	}
+
+	packet_delim(1);
+}
+
 static void send_shallow_info(struct upload_pack_data *data)
 {
 	/* No shallow info needs to be sent */
@@ -1418,6 +1471,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 				state = FETCH_DONE;
 			break;
 		case FETCH_SEND_PACK:
+			send_wanted_ref_info(&data);
 			send_shallow_info(&data);
 
 			packet_write_fmt(1, "packfile\n");
@@ -1438,12 +1492,22 @@ int upload_pack_advertise(struct repository *r,
 {
 	if (value) {
 		int allow_filter_value;
+		int allow_ref_in_want;
+
 		strbuf_addstr(value, "shallow");
+
 		if (!repo_config_get_bool(the_repository,
 					 "uploadpack.allowfilter",
 					 &allow_filter_value) &&
 		    allow_filter_value)
 			strbuf_addstr(value, " filter");
+
+		if (!repo_config_get_bool(the_repository,
+					 "uploadpack.allowrefinwant",
+					 &allow_ref_in_want) &&
+		    allow_ref_in_want)
+			strbuf_addstr(value, " ref-in-want");
 	}
+
 	return 1;
 }
-- 
2.18.0.rc1.242.g61856ae69a-goog

