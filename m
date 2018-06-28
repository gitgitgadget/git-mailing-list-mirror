Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82D91F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934379AbeF1WP5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:15:57 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:33593 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933153AbeF1WP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:15:56 -0400
Received: by mail-vk0-f73.google.com with SMTP id s185-v6so2657531vke.0
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 15:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=JJAOyieUzc/Iv5uFVTalj+NpihRNlQqo8ffOKWiF54g=;
        b=JC/aywZsZga+EClhOCwLGo9Cqw812btmcADQGREFPJrS51yoS+Ovlbup3zOMYEj+3x
         qb7gaV/4qkmrpOh2GWkZTgnk6zjuR+nmArojgSZ2kZv+lYvcLiiag+ZfH6LNXEvUtgb1
         t1rCByS68MVmdw3HTufg6nfMrA+1J1smcxj5+HM+WBOUAYgoWIV3KQ8UJF4ohLgGyhCx
         Snip4eizNcZzsN44222eC0jGIs0blVQu+Q+SOevyFukE1Dx9LaKLRH/00NBxK3LeJkBd
         JOiGeQ0LBGwg7HbUQSSRNcOX+LfBXCHGCWXBUinewYHRdp3d0J2Qqv7RRnxhHPoD1s4c
         bdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=JJAOyieUzc/Iv5uFVTalj+NpihRNlQqo8ffOKWiF54g=;
        b=pBx8aOjpulcomx95BcviHI2lf3Di0JLN39CQFYexxLWsSEMfy/DI82UKVJs6abb7kj
         yGOF1EHVbgcs1Hp7HWw0qp4Hd1NawStdNOfDpobwDYCpv0O/89IfG6sLpcE73CKEJM77
         dsaoPJBaKN0YAyMr9JCOxCgZm00N676lNAoyV5quHxJ7faDerXVLYOIMot5CUOEYeX6E
         HKe47uKNj3ddda8uxvdDACptK69HE3ltJXxS3yaH7fdNSwsylJBUVTAR58nsOwOmoc5P
         rlBR6U969gBHOJxASu5Cz4AnIt4xRC/OBXVc8RtBK2XJi9ghHXR55EaBCwbiPA3XQyCg
         i26w==
X-Gm-Message-State: APt69E1/a09nGrZwRiMY0muvu1lUaylzn/xBBhJEA6QMoove1cv7ai1v
        rQbu1Kk7TyxsWKa4PoLeFipa+AvlNz7uwgh1HnS3//Lc+AeeV7jUXsQcJ579zKHGxCy5aIkCupl
        +7lGbmUGq68OqwkHrj1HoJx/ZcjfncKHJ/ZxNoTlhPCSxBmCV4KA9G7Fxt+nzG2cy7PlagizdOB
        UJ
X-Google-Smtp-Source: AAOMgpeZQj8ed0cwa7Yvc1gyio3WnOj5HiMYt7//yMWDq332XmbidnCMVu3RMz51cTCvj+mUxRvzfXSSNS28xpIrYGrE
MIME-Version: 1.0
X-Received: by 2002:ab0:3098:: with SMTP id h24-v6mr547506ual.108.1530224155490;
 Thu, 28 Jun 2018 15:15:55 -0700 (PDT)
Date:   Thu, 28 Jun 2018 15:15:51 -0700
In-Reply-To: <20180625193752.255319-1-jonathantanmy@google.com>
Message-Id: <20180628221551.30406-1-jonathantanmy@google.com>
References: <20180625193752.255319-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v3] fetch-pack: support negotiation tip whitelist
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
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

> I don't think that would be strange at all, and no where in git do we
> handle heads/* but we do already handle refs/heads/* as well as DWIM
> master.
>
> > and (2) I can't think of anywhere in Git
> > where you can provide either one - it's either SHA-1 and DWIM name, or
> > SHA-1 and refspec, but not all three.
>
> fetch is a perfect example of supporting all three.  I can do
>
>   git fetch origin SHA1
>   git fetch origin master
>   git fetch origin refs/heads/*:refs/heads/*

OK, Brandon managed to convince me that this is fine. I've included glob
support, supporting the same globs that git notes supports.
---
 Documentation/fetch-options.txt | 16 +++++++
 builtin/fetch.c                 | 41 +++++++++++++++++
 fetch-pack.c                    | 19 +++++++-
 fetch-pack.h                    |  7 +++
 t/t5510-fetch.sh                | 78 +++++++++++++++++++++++++++++++++
 transport-helper.c              |  3 ++
 transport.c                     |  1 +
 transport.h                     | 10 +++++
 8 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 97d3217df..6e4db1738 100644
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
+abbreviated SHA-1 of a commit. Specifying a glob is equivalent to specifying
+this option multiple times, one for each matching ref name.
+
 ifndef::git-pull[]
 --dry-run::
 	Show what would be done, without making any changes.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669a..1a7ef305d 100644
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
@@ -1049,6 +1052,38 @@ static void set_option(struct transport *transport, const char *name, const char
 			name, transport->url);
 }
 
+
+static int add_oid(const char *refname, const struct object_id *oid, int flags,
+		   void *cb_data)
+{
+	struct oid_array *oids = cb_data;
+	oid_array_append(oids, oid);
+	return 0;
+}
+
+static void add_negotiation_tips(struct git_transport_options *smart_options)
+{
+	struct oid_array *oids = xcalloc(1, sizeof(*oids));
+	int i;
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
@@ -1075,6 +1110,12 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
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
index ba12085c4..c66bd49bd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -213,6 +213,21 @@ static int next_flush(int stateless_rpc, int count)
 	return count;
 }
 
+static void mark_tips(struct fetch_negotiator *negotiator,
+		      const struct oid_array *negotiation_tips)
+{
+	int i;
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
@@ -230,7 +245,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
 
-	for_each_ref(rev_list_insert_ref_oid, negotiator);
+	mark_tips(negotiator, args->negotiation_tips);
 	for_each_cached_alternate(negotiator, insert_one_alternate_object);
 
 	fetching = 0;
@@ -1295,7 +1310,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
index e402aee6a..8532a6faf 100755
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
+	if [ "$USE_PROTOCOL_V2" -eq 1 ]
+	then
+		git -C "$SERVER" config protocol.version 2
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
2.18.0.rc2.346.g013aa6912e-goog

