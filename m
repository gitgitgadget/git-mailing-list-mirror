Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6B21F461
	for <e@80x24.org>; Wed, 21 Aug 2019 22:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfHUWUR (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 18:20:17 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:54876 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbfHUWUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 18:20:17 -0400
Received: by mail-qt1-f201.google.com with SMTP id t5so4327074qtd.21
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 15:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=voJ5YlbZ80ykeqUOFPGRPrkTlLG6UGzqlEmIieYtmOw=;
        b=HBFk1vY/NPrLkb7c/eXLPgUXgNeaQy310/6eMBWFASnXmFUrtID6Foy0awJ27Fe4i7
         WRYqLIiGP31Tcb24XqQaBQ6UrT6YuFCLvnUMDLsTnQBZr8rAPtxEwArXQvAWCCr9CdNO
         tMw15yxdTCmnpT3x+/Yi7sGaaj4T2/naDJMwLFZfXo54gWwooMlB3vO2Mon/4i6ISl9P
         +XRzXNsQzjgioy9ah8FnUKQMhkpcakhinxNoDkThYqmGhgq3MPj7CiHxlU4KubHMIjzG
         KT9jfWRNu7DWnCohlyw9FgVx8lir3Xse47Us1PUQvdbxBpTbwXBWQ5ctwNIz6mL7BscD
         V3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=voJ5YlbZ80ykeqUOFPGRPrkTlLG6UGzqlEmIieYtmOw=;
        b=LfJQQ9lz3DzPD9a+Mt9UjEPCuGp/CdLFtCqekKcYt1leiF/jFDsTepXeg2FiukdmHV
         aBrFjYB5V+NbJgs/CBTfXHwHgNccWn887MvFzrvSa3UWYfM7r3qyAT+9zb1mV3Fae7Gn
         oKJaBkv3arbPL8zE2Hd/KgZ4ZcOtR91zT4bPw+MEsiGhq4ULDegMhVI1jlFsEBjssM2X
         GtuC/U66AN3TAk+tALn5Xx2lIfvdtVve7UEAbaTzt52ORdUZHwn+Equ6tCpJTWv9kACL
         nqpnnIS89xSV1Ojf4O/xOjRn0+LZhPhk0WjO851N1McfpFZKMo/y5UzOHpuSCTOfXhch
         dT2A==
X-Gm-Message-State: APjAAAXgFdb9MR0u4ooohKNNBaWPLXnpVSorqxgmbLSXb1ViUDvP+mxU
        WhJRJ7YyV6RQ0VxVvVzonhtKf9AFCN74TJxKFUoqaXza0+0SZuFT0OjcB1ZnzIuBwyqtkLRdDqN
        eh2jNIxNQWR24Ycn6TNh/xChClZhi7xrUdz5ZFWrhA4pzsM9yxemnpyp0IeCymBz4ffRILRu7Bk
        4W
X-Google-Smtp-Source: APXvYqz3ebdpLVrcTgdy70tvWEChFrdPdePFEa2W+S1mxK2gm07YAcq4OLuwqeaaqFHNS9p186Hw066ZKak7t4nFMKzw
X-Received: by 2002:a37:a484:: with SMTP id n126mr33828982qke.73.1566426015545;
 Wed, 21 Aug 2019 15:20:15 -0700 (PDT)
Date:   Wed, 21 Aug 2019 15:20:09 -0700
In-Reply-To: <cover.1566425828.git.jonathantanmy@google.com>
Message-Id: <9e0971d10117651a9a475c3b5c183a09e617a67b.1566425828.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1566425828.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 1/2] transport-helper: skip ls-refs if unnecessary
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e70a3030e7 ("fetch: do not list refs if fetching only hashes",
2018-10-07) and its ancestors taught Git, as an optimization, to skip
the ls-refs step when it is not necessary during a protocol v2 fetch
(for example, when lazy fetching a missing object in a partial clone, or
when running "git fetch --no-tags <remote> <SHA-1>"). But that was only
done for natively supported protocols; in particular, HTTP was not
supported.

Teach Git to skip ls-refs when using remote helpers that support connect
or stateless-connect. To do this, fetch() is made an acceptable entry
point. Because fetch() can now be the first function in the vtable
called, "get_helper(transport);" has to be added to the beginning of
that function to set the transport up (if not yet set up) before
process_connect() is invoked.

When fetch() is called, the transport could be taken over (this happens
if "connect" or "stateless-connect" is successfully run without any
"fallback" response), or not. If the transport is taken over, execution
continues like execution for natively supported protocols
(fetch_refs_via_pack() is executed, which will fetch refs using ls-refs
if needed). If not, the remote helper interface will invoke
get_refs_list() if it hasn't been invoked yet, preserving existing
behavior.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5702-protocol-v2.sh | 13 +++++++++++++
 transport-helper.c     | 39 +++++++++++++++++++++++++++++++++------
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 011b81d4fc..61f5080de0 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -631,6 +631,19 @@ test_expect_success 'fetch with http:// using protocol v2' '
 	grep "git< version 2" log
 '
 
+test_expect_success 'fetch with http:// by hash without tag following with protocol v2 does not list refs' '
+	test_when_finished "rm -f log" &&
+
+	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" two_a &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" rev-parse two_a >two_a_hash &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -C http_child -c protocol.version=2 \
+		fetch --no-tags origin $(cat two_a_hash) &&
+
+	grep "fetch< version 2" log &&
+	! grep "fetch> command=ls-refs" log
+'
+
 test_expect_success 'fetch from namespaced repo respects namespaces' '
 	test_when_finished "rm -f log" &&
 
diff --git a/transport-helper.c b/transport-helper.c
index 6b05a88faf..1fb31e1a6e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -33,6 +33,16 @@ struct helper_data {
 		check_connectivity : 1,
 		no_disconnect_req : 1,
 		no_private_update : 1;
+
+	/*
+	 * As an optimization, the transport code may invoke fetch before
+	 * get_refs_list. If this happens, and if the transport helper doesn't
+	 * support connect or stateless_connect, we need to invoke
+	 * get_refs_list ourselves if we haven't already done so. Keep track of
+	 * whether we have invoked get_refs_list.
+	 */
+	unsigned get_refs_list_called : 1;
+
 	char *export_marks;
 	char *import_marks;
 	/* These go from remote name (as in "list") to private name */
@@ -652,17 +662,25 @@ static int connect_helper(struct transport *transport, const char *name,
 	return 0;
 }
 
+static struct ref *get_refs_list_using_list(struct transport *transport,
+					    int for_push);
+
 static int fetch(struct transport *transport,
 		 int nr_heads, struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
 
+	get_helper(transport);
+
 	if (process_connect(transport, 0)) {
 		do_take_over(transport);
 		return transport->vtable->fetch(transport, nr_heads, to_fetch);
 	}
 
+	if (!data->get_refs_list_called)
+		get_refs_list_using_list(transport, 0);
+
 	count = 0;
 	for (i = 0; i < nr_heads; i++)
 		if (!(to_fetch[i]->status & REF_STATUS_UPTODATE))
@@ -1058,6 +1076,19 @@ static int has_attribute(const char *attrs, const char *attr)
 
 static struct ref *get_refs_list(struct transport *transport, int for_push,
 				 const struct argv_array *ref_prefixes)
+{
+	get_helper(transport);
+
+	if (process_connect(transport, for_push)) {
+		do_take_over(transport);
+		return transport->vtable->get_refs_list(transport, for_push, ref_prefixes);
+	}
+
+	return get_refs_list_using_list(transport, for_push);
+}
+
+static struct ref *get_refs_list_using_list(struct transport *transport,
+					    int for_push)
 {
 	struct helper_data *data = transport->data;
 	struct child_process *helper;
@@ -1066,13 +1097,9 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
 
+	data->get_refs_list_called = 1;
 	helper = get_helper(transport);
 
-	if (process_connect(transport, for_push)) {
-		do_take_over(transport);
-		return transport->vtable->get_refs_list(transport, for_push, ref_prefixes);
-	}
-
 	if (data->push && for_push)
 		write_str_in_full(helper->in, "list for-push\n");
 	else
@@ -1119,7 +1146,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 }
 
 static struct transport_vtable vtable = {
-	0,
+	1,
 	set_helper_option,
 	get_refs_list,
 	fetch,
-- 
2.23.0.187.g17f5b7556c-goog

