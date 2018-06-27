Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9BAA1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965846AbeF0S2M (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:28:12 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:33449 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965822AbeF0S2L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:28:11 -0400
Received: by mail-vk0-f73.google.com with SMTP id s185-v6so1126965vke.0
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=33VcaRDhOMLuu+KwFfVYprZ6Iqr/tphcCWVLprys4Hs=;
        b=PGu81d71AswcWyjcFoOBe2sFOWA6IBDpcGJm9Y18vmyccJ2WUmKrowV7gY2Hw7zaWj
         lEl/gVZZdCM9PcSoEbVBIGfbR9SBkWynGwoyjhg6k7gq8IU6sCu6Qm7Xunw2V0NTkaUp
         BPQAfjGhpyz8vCLBE57ho1Z4UiTZalufc33//jxoZa3WVMbgJ3sFrc3u0F16LiWAOovr
         4+b8d1ueFK/d74hI9sklA/VMMrkr/0bkW3sygIp8dVgDWzMAcNrs6oKOzMfUcG27Uk8Q
         J4OofwXtDhFjBRGGiyJsaBNQ3GGmMDffcZFMfbPDxXaUlwjFvJ79sD9hbJoQ6kkJlprH
         HFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=33VcaRDhOMLuu+KwFfVYprZ6Iqr/tphcCWVLprys4Hs=;
        b=kfnoOUfg9cFnGY15MhMmaYiw74JeF4xU/9aFH/1bIoz3QvP/bqMsS+wyO8sRZWx3Kj
         XN/ItBUiDbqPWrBAHmVZbm50/jFetewCwwH3bvOoLQOJKzksV8x9XGffkIttGTzysx+h
         TB5NqfAY7gpfriP9r9BYpDK75H8BHFwyoDpFQudwfTdRVNRJ4szQ0c4kzhcV69booDfV
         7v8Gt3UEj9cSJ/ZcD1hUSPo6u5D1wVIRZZo6TXL+U4Hm1oOya/Rq/s/jojgGiDackq2j
         H5981igcyWpDY/11+ZpdhfbbM90rFtVMIvIC03bu2znqgRLRKtT4K4xh9NFja9wT41p3
         baQQ==
X-Gm-Message-State: APt69E0cumjrRusYEhK0xB8PRCDB3yF02lgi3UNkKi5Tu8Oy/ONTnvNi
        Ocu/L19m7iYSJfhbho1f/BS9ausotYDqwOWnuv5D2RBEmQBcfLCl+8lmTn0FB58r+3+JgcSJK+L
        DcCSfVhv0fdk48uaQBdVjIsVPK0lVaWUu9bSE7pj4TDDAd4elONTiivDMyy3/2nf4Sg09AUITPN
        zN
X-Google-Smtp-Source: AAOMgpczpZtQOqtScoSA+tg2XK0Tjz725c5MF5kK9vCMYdlyngIb2h2qjTI4Z0Tdoi35qEaeXHbLvJxnUpkl3w00wsp5
MIME-Version: 1.0
X-Received: by 2002:a9f:3cab:: with SMTP id s43-v6mr2970315uai.24.1530124090372;
 Wed, 27 Jun 2018 11:28:10 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:28:02 -0700
In-Reply-To: <20180625193752.255319-1-jonathantanmy@google.com>
Message-Id: <20180627182802.257305-1-jonathantanmy@google.com>
References: <20180625193752.255319-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v2] fetch-pack: support negotiation tip whitelist
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
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
v2 is exactly the same as the original, except with user-facing
documentation in Documentation/fetch-options.txt.

> What's the plan to expose this "feature" to end-users?  There is no
> end-user facing documentation added by this patch, and in-code
> comments only talk about what (mechanical) effect the option has,
> but not when a user may want to use the feature, or how the user
> would best decide the set of commits to pass to this new option.

Jonathan Nieder also mentioned this. Lack of documentation was an
oversight, sorry. I've added it in this version.

> Would something like this
>
>     git fetch $(git for-each-ref \
> 	--format=--nego-tip="%(objectname)" \
> 	refs/remotes/linux-next/) \
> 	linux-next
>
> be an expected typical way to pull from one remote, exposing only
> the tips of refs we got from that remote and not the ones we
> obtained from other places?

Yes, that is one way. Alternatively, if the user is only fetching one
branch, they may also want to specify a single branch.
---
 Documentation/fetch-options.txt | 12 +++++++
 builtin/fetch.c                 | 21 +++++++++++++
 fetch-pack.c                    | 19 ++++++++++--
 fetch-pack.h                    |  7 +++++
 t/t5510-fetch.sh                | 55 +++++++++++++++++++++++++++++++++
 transport-helper.c              |  3 ++
 transport.c                     |  1 +
 transport.h                     | 10 ++++++
 8 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 97d3217df9..80c4c94595 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -42,6 +42,18 @@ the current repository has the same history as the source repository.
 	.git/shallow. This option updates .git/shallow and accept such
 	refs.
 
+--negotiation-tip::
+	By default, Git will report, to the server, commits reachable
+	from all local refs to find common commits in an attempt to
+	reduce the size of the to-be-received packfile. If specified,
+	Git will only report commits reachable from the given commit.
+	This is useful to speed up fetches when the user knows which
+	local ref is likely to have commits in common with the
+	upstream ref being fetched.
++
+This option may be specified more than once; if so, Git will report
+commits reachable from any of the given commits.
+
 ifndef::git-pull[]
 --dry-run::
 	Show what would be done, without making any changes.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669ad..12daec0f3b 100644
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
@@ -1075,6 +1078,24 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 			   filter_options.filter_spec);
 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	}
+	if (negotiation_tip.nr) {
+		struct oid_array *oids;
+		if (transport->smart_options) {
+			int i;
+			oids = xcalloc(1, sizeof(*oids));
+			for (i = 0; i < negotiation_tip.nr; i++) {
+				struct object_id oid;
+				if (get_oid(negotiation_tip.items[i].string,
+					    &oid))
+					die("%s is not a valid object",
+					    negotiation_tip.items[i].string);
+				oid_array_append(oids, &oid);
+			}
+			transport->smart_options->negotiation_tips = oids;
+		} else {
+			warning("Ignoring --negotiation-tip because the protocol does not support it.");
+		}
+	}
 	return transport;
 }
 
diff --git a/fetch-pack.c b/fetch-pack.c
index ba12085c4a..c66bd49bd1 100644
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
index bb45a366a8..1859ee9275 100644
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
index e402aee6a2..ea1b5e53c1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -865,4 +865,59 @@ test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 	test_cmp expect actual
 '
 
+negotiator_tip () {
+	SERVER="$1"
+	URL="$2"
+	USE_PROTOCOL_V2="$3"
+
+	rm -rf "$SERVER" client &&
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
+	git -C "$SERVER" tag -d alpha_1 alpha_2 beta_1 beta_2 &&
+
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 --negotiation-tip=beta_1 \
+		origin alpha_s beta_s &&
+
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
+test_expect_success '--negotiator-tip limits "have" lines sent' '
+	negotiator_tip server server 0
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'fetch with --filter=blob:limit=0 and HTTP' '
+	negotiator_tip "$HTTPD_DOCUMENT_ROOT_PATH/server" \
+		"$HTTPD_URL/smart/server" 1
+'
+
+stop_httpd
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 1f8ff7e942..ad8f7c7726 100644
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
index a32da30dee..9f10f8ad9f 100644
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
index 7792b08582..d31be5be63 100644
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

