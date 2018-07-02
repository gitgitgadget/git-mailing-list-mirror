Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78161F516
	for <e@80x24.org>; Mon,  2 Jul 2018 22:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeGBWjw (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 18:39:52 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:41621 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeGBWjv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 18:39:51 -0400
Received: by mail-vk0-f73.google.com with SMTP id i67-v6so4067vke.8
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 15:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=zmg//uXPWs+SFJaxpru/Cn3cMqXdOxxQvsIB+wMKma8=;
        b=I5CR1VcWWL8O920broyqCgjiV/jvfuCRiEpX1cnhitvMp51VDl4/grDL9cosW57XUR
         hdnjbmWnsjb95AkbM3TvhjW3rOtaWgIKSPv/eXTaeY3nie+4nr7eRxjyeVygcjQvQN11
         IUDsCjPqGzBlvC6ZWEc/7fXoEf664aCfKd+DWMiA62TGCL62iymwcR4FSZJecyA+UyCB
         M5tjSLJWdP7200WnV+VzY5q+EqvTeqxKKPUy4iyP2n2f6toP6/YErn1t89GtWtUj/qRJ
         zHvtSUMrK/cDQEJ7pCPsC2xVUgGi3fwiGE19qZWTsCx3EXhf+Sp8anpgL+c0fhR1+UIk
         73FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=zmg//uXPWs+SFJaxpru/Cn3cMqXdOxxQvsIB+wMKma8=;
        b=b0jKVMbG7HnuRKPRqR+CpkRrhcOyBe2GKojOfZwpUWZiXkBjzI0GgCXVhMLAzEGgbk
         uUMzdK0k5XZ8JP6ILfI5b1pvx4gttEi5kXEfcEwl+NXCGytCeSfBHu5iRinEPsOO88OY
         Qs/2uyEvD+WIWB96OP5II04x/zy+1i9qsCaQtHBOA1KvwxdEXtfX6FNV3Nli0qmrgQtF
         WgCea8Lcmb4fPmMr0uKn89h5hsjMASbG+wen3EerQv/Cneoszsq1t7XG83bpozdSVVLg
         XSmOyQcYzzn+lqul6VNswGdOYUgkkeZghHiHguVme2oOrEqLVQXwlSalPi80LpiqzsOX
         599w==
X-Gm-Message-State: APt69E0pYZOfOHjQ3erI/V29jjB4zlGcaNG83Z7jshalS9114eJ03g0k
        kQq/oEz1N7iKdJ6QUG8CdwD/ZvLkDfAI0gkGyK5EgqHJkQ7w9+Msu2gCBnhXbOhtUiRFpwZIdV3
        ZkGalKlQ+yZEsVjkkoTZzCZ+2YyPPnpXhVVSbNAy0N9zGVorz6Q6jFOJ5OmWCPKBkPZEke8C7xI
        Hw
X-Google-Smtp-Source: AAOMgpeCFoipD8A2np5gSEXVoT36TfobnO/+vRXLVlaV/xqNqDpMtrH+d/NJfN72xocjDIomfkYVC5q3/pQotOT5C/Xu
MIME-Version: 1.0
X-Received: by 2002:ab0:61c1:: with SMTP id m1-v6mr9394629uan.33.1530571190209;
 Mon, 02 Jul 2018 15:39:50 -0700 (PDT)
Date:   Mon,  2 Jul 2018 15:39:44 -0700
In-Reply-To: <20180625193752.255319-1-jonathantanmy@google.com>
Message-Id: <20180702223944.224755-1-jonathantanmy@google.com>
References: <20180625193752.255319-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4] fetch-pack: support negotiation tip whitelist
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During negotiation, fetch-pack eventually reports as "have" lines all
commits reachable from all refs. Allow the user to restrict the commits
sent in this way by providing a whitelist of tips; only the tips
themselves and their ancestors will be sent.

Both globs and single objects are supported.

This feature is only supported for protocols that support connect or
stateless-connect (such as HTTP with protocol v2).

This will speed up negotiation when the repository has multiple
relatively independent branches (for example, when a repository
interacts with multiple repositories, such as with linux-next [1] and
torvalds/linux [2]), and the user knows which local branch is likely to
have commits in common with the upstream branch they are fetching.

[1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/
[2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is on jt/fetch-pack-negotiator.

I noticed that jt/fetch-nego-tip had a version queued with Brandon's
suggestion (of the closing parenthesis) included, but not any of Junio's
suggestions, so here is one with the suggestions from both.

> "git notes"???
>
> As this is to be used in the context of "git fetch", using glob
> e.g. "refs/heads/*", is sensible and good enough.  I was actually
> wondering if we want the head-match refs/heads/, but as "git fetch
> origin refs/heads/" does not work that way, I think we shouldn't.

OK - the above was not in the commit message, so I think we're fine. In
the commit message and in the user-facing documentation, I describe this
as a "glob".

> This is a tangent, but didn't ref-in-want wanted to use head-match
> refs/heads/ to match everything under refs/heads/?  If the latest
> incarnation wants to do so, we may want to fix that.

I don't recall anything like that - the user still specifies a refspec
(like existing users do), and in the protocol, all wanted refs are
matched by exact name.

> This by itself is not worth a reason to reroll, but please make it a
> habit to have a blank line after the run of decls before the first
> statement, at least while we still forbid decl-after-stmt.  The
> result is easier to read that way.

Thanks - I've done it for add_oid() and all the new functions introduced
in this patch.

> Style: "if test ..."

> broken &&-chaining?

Both done.
---
 Documentation/fetch-options.txt | 16 +++++++
 builtin/fetch.c                 | 43 ++++++++++++++++++
 fetch-pack.c                    | 20 ++++++++-
 fetch-pack.h                    |  7 +++
 t/t5510-fetch.sh                | 78 +++++++++++++++++++++++++++++++++
 transport-helper.c              |  3 ++
 transport.c                     |  1 +
 transport.h                     | 10 +++++
 8 files changed, 176 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 97d3217df..2d09f87b4 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -42,6 +42,22 @@ the current repository has the same history as the source repository.
 	.git/shallow. This option updates .git/shallow and accept such
 	refs.
 
+--negotiation-tip=<commit|glob>::
+	By default, Git will report, to the server, commits reachable
+	from all local refs to find common commits in an attempt to
+	reduce the size of the to-be-received packfile. If specified,
+	Git will only report commits reachable from the given tips.
+	This is useful to speed up fetches when the user knows which
+	local ref is likely to have commits in common with the
+	upstream ref being fetched.
++
+This option may be specified more than once; if so, Git will report
+commits reachable from any of the given commits.
++
+The argument to this option may be a glob on ref names, a ref, or the (possibly
+abbreviated) SHA-1 of a commit. Specifying a glob is equivalent to specifying
+this option multiple times, one for each matching ref name.
+
 ifndef::git-pull[]
 --dry-run::
 	Show what would be done, without making any changes.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669a..49ab6ac06 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -63,6 +63,7 @@ static int shown_url = 0;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
+static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -174,6 +175,8 @@ static struct option builtin_fetch_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
+			N_("report that we have only objects reachable from this object")),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_END()
 };
@@ -1049,6 +1052,40 @@ static void set_option(struct transport *transport, const char *name, const char
 			name, transport->url);
 }
 
+
+static int add_oid(const char *refname, const struct object_id *oid, int flags,
+		   void *cb_data)
+{
+	struct oid_array *oids = cb_data;
+
+	oid_array_append(oids, oid);
+	return 0;
+}
+
+static void add_negotiation_tips(struct git_transport_options *smart_options)
+{
+	struct oid_array *oids = xcalloc(1, sizeof(*oids));
+	int i;
+
+	for (i = 0; i < negotiation_tip.nr; i++) {
+		const char *s = negotiation_tip.items[i].string;
+		int old_nr;
+		if (!has_glob_specials(s)) {
+			struct object_id oid;
+			if (get_oid(s, &oid))
+				die("%s is not a valid object", s);
+			oid_array_append(oids, &oid);
+			continue;
+		}
+		old_nr = oids->nr;
+		for_each_glob_ref(add_oid, s, oids);
+		if (old_nr == oids->nr)
+			warning("Ignoring --negotiation-tip=%s because it does not match any refs",
+				s);
+	}
+	smart_options->negotiation_tips = oids;
+}
+
 static struct transport *prepare_transport(struct remote *remote, int deepen)
 {
 	struct transport *transport;
@@ -1075,6 +1112,12 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 			   filter_options.filter_spec);
 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	}
+	if (negotiation_tip.nr) {
+		if (transport->smart_options)
+			add_negotiation_tips(transport->smart_options);
+		else
+			warning("Ignoring --negotiation-tip because the protocol does not support it.");
+	}
 	return transport;
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index ba12085c4..1e50d9008 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -213,6 +213,22 @@ static int next_flush(int stateless_rpc, int count)
 	return count;
 }
 
+static void mark_tips(struct fetch_negotiator *negotiator,
+		      const struct oid_array *negotiation_tips)
+{
+	int i;
+
+	if (!negotiation_tips) {
+		for_each_ref(rev_list_insert_ref_oid, negotiator);
+		return;
+	}
+
+	for (i = 0; i < negotiation_tips->nr; i++)
+		rev_list_insert_ref(negotiator, NULL,
+				    &negotiation_tips->oid[i]);
+	return;
+}
+
 static int find_common(struct fetch_negotiator *negotiator,
 		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
@@ -230,7 +246,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
 
-	for_each_ref(rev_list_insert_ref_oid, negotiator);
+	mark_tips(negotiator, args->negotiation_tips);
 	for_each_cached_alternate(negotiator, insert_one_alternate_object);
 
 	fetching = 0;
@@ -1295,7 +1311,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			else
 				state = FETCH_SEND_REQUEST;
 
-			for_each_ref(rev_list_insert_ref_oid, &negotiator);
+			mark_tips(&negotiator, args->negotiation_tips);
 			for_each_cached_alternate(&negotiator,
 						  insert_one_alternate_object);
 			break;
diff --git a/fetch-pack.h b/fetch-pack.h
index bb45a366a..1859ee927 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,6 +16,13 @@ struct fetch_pack_args {
 	const struct string_list *deepen_not;
 	struct list_objects_filter_options filter_options;
 	const struct string_list *server_options;
+
+	/*
+	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
+	 * lines only with these tips and their ancestors.
+	 */
+	const struct oid_array *negotiation_tips;
+
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e402aee6a..4e6d049b9 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -865,4 +865,82 @@ test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 	test_cmp expect actual
 '
 
+setup_negotiation_tip () {
+	SERVER="$1"
+	URL="$2"
+	USE_PROTOCOL_V2="$3"
+
+	rm -rf "$SERVER" client trace &&
+	git init "$SERVER" &&
+	test_commit -C "$SERVER" alpha_1 &&
+	test_commit -C "$SERVER" alpha_2 &&
+	git -C "$SERVER" checkout --orphan beta &&
+	test_commit -C "$SERVER" beta_1 &&
+	test_commit -C "$SERVER" beta_2 &&
+
+	git clone "$URL" client &&
+
+	if test "$USE_PROTOCOL_V2" -eq 1
+	then
+		git -C "$SERVER" config protocol.version 2 &&
+		git -C client config protocol.version 2
+	fi &&
+
+	test_commit -C "$SERVER" beta_s &&
+	git -C "$SERVER" checkout master &&
+	test_commit -C "$SERVER" alpha_s &&
+	git -C "$SERVER" tag -d alpha_1 alpha_2 beta_1 beta_2
+}
+
+check_negotiation_tip () {
+	# Ensure that {alpha,beta}_1 are sent as "have", but not {alpha_beta}_2
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	grep "fetch> have $ALPHA_1" trace &&
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	grep "fetch> have $BETA_1" trace &&
+	ALPHA_2=$(git -C client rev-parse alpha_2) &&
+	! grep "fetch> have $ALPHA_2" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	! grep "fetch> have $BETA_2" trace
+}
+
+test_expect_success '--negotiation-tip limits "have" lines sent' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 --negotiation-tip=beta_1 \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
+test_expect_success '--negotiation-tip understands globs' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=*_1 \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
+test_expect_success '--negotiation-tip understands abbreviated SHA-1' '
+	setup_negotiation_tip server server 0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=$(git -C client rev-parse --short alpha_1) \
+		--negotiation-tip=$(git -C client rev-parse --short beta_1) \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success '--negotiation-tip limits "have" lines sent with HTTP protocol v2' '
+	setup_negotiation_tip "$HTTPD_DOCUMENT_ROOT_PATH/server" \
+		"$HTTPD_URL/smart/server" 1 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 --negotiation-tip=beta_1 \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
+stop_httpd
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 1f8ff7e94..ad8f7c772 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -684,6 +684,9 @@ static int fetch(struct transport *transport,
 			transport, "filter",
 			data->transport_options.filter_options.filter_spec);
 
+	if (data->transport_options.negotiation_tips)
+		warning("Ignoring --negotiation-tip because the protocol does not support it.");
+
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
diff --git a/transport.c b/transport.c
index a32da30de..9f10f8ad9 100644
--- a/transport.c
+++ b/transport.c
@@ -318,6 +318,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.filter_options = data->options.filter_options;
 	args.stateless_rpc = transport->stateless_rpc;
 	args.server_options = transport->server_options;
+	args.negotiation_tips = data->options.negotiation_tips;
 
 	if (!data->got_remote_heads)
 		refs_tmp = get_refs_via_connect(transport, 0, NULL);
diff --git a/transport.h b/transport.h
index 7792b0858..d31be5be6 100644
--- a/transport.h
+++ b/transport.h
@@ -25,6 +25,16 @@ struct git_transport_options {
 	const char *receivepack;
 	struct push_cas_option *cas;
 	struct list_objects_filter_options filter_options;
+
+	/*
+	 * This is only used during fetch. See the documentation of
+	 * negotiation_tips in struct fetch_pack_args.
+	 *
+	 * This field is only supported by transports that support connect or
+	 * stateless_connect. Set this field directly instead of using
+	 * transport_set_option().
+	 */
+	struct oid_array *negotiation_tips;
 };
 
 enum transport_family {
-- 
2.18.0.399.gad0ab374a1-goog

