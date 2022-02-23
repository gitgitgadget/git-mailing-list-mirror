Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80354C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbiBWScd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243921AbiBWScK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:32:10 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799F7C26
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v21so5809094wrv.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=++j/iu4CuQc9wJEV3X8xTUgeXRsJQvZidAJQbcdBemg=;
        b=eumhDHao2zp3ICbEMfzzQ5xfbPiL3u5guJrpUoloTgJ0OxV0J823m+SyhBe6O2T9rq
         rw5McpjKBExPH16/+7y/xj9FZdhz/KtaFlsjZVGDd3Cs7WYVjn6lln7dYcj9bvY1KXk2
         hJMP4qY426KfdkVGRVxBqUKJCFqH8pr+qifZQsrSz7w5rCG7c5U7DZa2A21MuuaUufYD
         GP+7PMX3RNHFdp2ycdjK2VHgdXuGY96ohZbA7A2IF9Hc8sHp+bsXVEDUBEUD/o9rzH3p
         y+73TCwJ+0VgGQVIM+Cn7zAoHLNXEhgIYrhoLH0yThMqUVttndaSaDwtUmTsGDHQEDgK
         L87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=++j/iu4CuQc9wJEV3X8xTUgeXRsJQvZidAJQbcdBemg=;
        b=3QW171J/9tlah5qVMYr6ovvq7hHi12dq/TAbof/XJdYh8fMuCNhXScQJD0zWatBT/I
         uBSINSYi06ZVb1ok+sfzCdibblt/GHo3Nilj8iJnOS43QRERTm9/DYgM7nJqnGx2fjnc
         a3lGqIsD2mEcZr9F183QboKK0i6T+YpsVrQqcuKnSkZpxYtQ9IjwhO6qZbDAOkxwqENw
         8pQ7AXk03qj3Sor1xHRP0LAcEFDfArIbKu9Bs77AVKJq//3s+ITzbZyP8nvLacD7MTFI
         5JEnG7i0nG5wYtEYmoS9yBcxgDcdKIYOjbKp8Pao4y4o9U9t+Gs3wcTQJUJSKjH05iFP
         ou4g==
X-Gm-Message-State: AOAM533GBok6BnGtED74vFttkrZR6kRLTsM+e590YngUxH4cBNzeTS48
        ESksrlQXTCJryDCQTyNvbOY0AXs9CPk=
X-Google-Smtp-Source: ABdhPJyX4WzaCA+VtiJowbxAtb3WeNQ6aCk7BgxWd/UcqTQZQ6MGS+syWcLRK6jyl/TQhFV1Or1tDQ==
X-Received: by 2002:a05:6000:50a:b0:1e3:5af:153e with SMTP id a10-20020a056000050a00b001e305af153emr670292wrf.385.1645641088761;
        Wed, 23 Feb 2022 10:31:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c4f9300b0037c06fe68casm458791wmq.44.2022.02.23.10.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:28 -0800 (PST)
Message-Id: <f327ade8e461689d62088df8fb6fdda749154438.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:31:01 +0000
Subject: [PATCH 23/25] transport: add connections for 'features' capability
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

To allow 'git clone' to check the 'features' capability, we need to fill
in some boilerplate methods that help detect if the capability exists
and then to execute the get_recommended_features() method with the
proper context. This involves jumping through some vtables.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 transport-helper.c   | 14 ++++++++++++++
 transport-internal.h |  9 +++++++++
 transport.c          | 38 ++++++++++++++++++++++++++++++++++++++
 transport.h          |  5 +++++
 4 files changed, 66 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index a0297b0986c..642472e2adb 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1264,11 +1264,25 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	return ret;
 }
 
+static int get_features(struct transport *transport,
+		      struct string_list *list)
+{
+	get_helper(transport);
+
+	if (process_connect(transport, 0)) {
+		do_take_over(transport);
+		return transport->vtable->get_features(transport, list);
+	}
+
+	return -1;
+}
+
 static struct transport_vtable vtable = {
 	.set_option	= set_helper_option,
 	.get_refs_list	= get_refs_list,
 	.fetch_refs	= fetch_refs,
 	.push_refs	= push_refs,
+	.get_features	= get_features,
 	.connect	= connect_helper,
 	.disconnect	= release_helper
 };
diff --git a/transport-internal.h b/transport-internal.h
index c4ca0b733ac..759c79148db 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -5,6 +5,7 @@ struct ref;
 struct transport;
 struct strvec;
 struct transport_ls_refs_options;
+struct string_list;
 
 struct transport_vtable {
 	/**
@@ -51,6 +52,14 @@ struct transport_vtable {
 	 * process involved generating new commits.
 	 **/
 	int (*push_refs)(struct transport *transport, struct ref *refs, int flags);
+
+	/**
+	 * get_features() requests a list of recommended features and
+	 * populates the given string_list with those 'key=value' pairs.
+	 */
+	int (*get_features)(struct transport *transport,
+			    struct string_list *list);
+
 	int (*connect)(struct transport *connection, const char *name,
 		       const char *executable, int fd[2]);
 
diff --git a/transport.c b/transport.c
index 2a3e3241545..99d6b719f35 100644
--- a/transport.c
+++ b/transport.c
@@ -349,6 +349,20 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	return handshake(transport, for_push, options, 1);
 }
 
+static int get_features(struct transport *transport,
+		      struct string_list *list)
+{
+	struct git_transport_data *data = transport->data;
+	struct packet_reader reader;
+
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	return get_recommended_features(data->fd[1], &reader, list,
+					transport->stateless_rpc);
+}
+
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
@@ -890,6 +904,7 @@ static struct transport_vtable taken_over_vtable = {
 	.get_refs_list	= get_refs_via_connect,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
+	.get_features	= get_features,
 	.disconnect	= disconnect_git
 };
 
@@ -1043,6 +1058,7 @@ static struct transport_vtable builtin_smart_vtable = {
 	.get_refs_list	= get_refs_via_connect,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
+	.get_features	= get_features,
 	.connect	= connect_git,
 	.disconnect	= disconnect_git
 };
@@ -1456,6 +1472,28 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }
 
+struct string_list *transport_remote_features(struct transport *transport)
+{
+	const struct transport_vtable *vtable = transport->vtable;
+	struct string_list *list = NULL;
+
+	if (!server_supports_v2("features", 0))
+		return NULL;
+
+	if (!vtable->get_features) {
+		warning(_("'features' not supported by this remote"));
+		return NULL;
+	}
+
+	CALLOC_ARRAY(list, 1);
+	string_list_init_dup(list);
+
+	if (vtable->get_features(transport, list))
+		warning(_("failed to get recommended features from remote"));
+
+	return list;
+}
+
 void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
 	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
diff --git a/transport.h b/transport.h
index 3f16e50c196..bfa2dd48d85 100644
--- a/transport.h
+++ b/transport.h
@@ -272,6 +272,11 @@ struct transport_ls_refs_options {
 const struct ref *transport_get_remote_refs(struct transport *transport,
 					    struct transport_ls_refs_options *transport_options);
 
+/**
+ * Get recommended config from remote.
+ */
+struct string_list *transport_remote_features(struct transport *transport);
+
 /*
  * Fetch the hash algorithm used by a remote.
  *
-- 
gitgitgadget

