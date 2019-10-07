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
	by dcvr.yhbt.net (Postfix) with ESMTP id D41771F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 22:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfJGWfY (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 18:35:24 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:33110 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbfJGWfX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 18:35:23 -0400
Received: by mail-pf1-f202.google.com with SMTP id z4so12187994pfn.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=WvOo2F52uAhKVcozWLUcAvKYoVb7FMGGeFTbet/FlBc=;
        b=hROGAJb+jI6za5HsfD5EExh6enri59ktsjWPRTw8OojcGCq7HrlrvxEJYNYilhzruV
         K0OPtmnI8iJGX9yqPcYrELxMGoIEbxiCgBcc3zcj+6GhNn1CQVtseLvn44csvS77Y3AK
         SnkUFbG7PofQad46fd0c3kLDf11VHTYeu73q3ve+XPDgxPT4wk0fWTseqhq/fM8ZA1H2
         RQ7Vd/vSzKLy5/hWv1o4esjoNVAifEFy6n01pSpb50WQAJgUF0dQeEQ+OcA3EcSWAyIE
         bV1uVk2qey6VTjdwJQgMoSsduS9xk5chzEirh/N0r3Yzh4uJPTZPTUgtJ1dETv37gZjD
         lOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=WvOo2F52uAhKVcozWLUcAvKYoVb7FMGGeFTbet/FlBc=;
        b=uFFyguwHgu8C2oFRYr5f1vxmVVEAw8MwGMpPDCmhVt7Cyr5jTvbnfEvZEXJRv8fphT
         YGXJcGJM0wnGghxvczzKHj1egRo+RTvW+vba6Q+6ERmCUsp4GRUsw0zsVVZRMi2Yhu07
         D1fow6ZjWeH0ebk0MKSkltPrfeIFjwK2Ncjj4rX9Fip18bbJ8vPygbmQHLa6LH3P4vdh
         9m6Hb+PO/6eX/OkzZfybQ2K8FpPTpr6PfLI1qAv3MlQ9s7ZIyX8gWBtHgui/J0a4TbcX
         Xyd92I5MAjelvag/bshmmgog8INn6f1e+2ZukKIB0qeT1R/Z59qvoiAjJy9bI/wpLChK
         WwtQ==
X-Gm-Message-State: APjAAAVrGkGmkAxTA9twM2sMBh14glMDNOxs/csbdE4OuQ1SnFOZ5JRY
        TK0Tg2LumvAKUp17gxpcgl6GAeNKugG2jYD+1F58BTsWVpp4YxDAvfo9QNnXCkkIAXU0z0bcVNZ
        4HBb8g9Ow/3cLiKBQ8ilRArUbPwpouW29p3RelJwHCZekpIR1jFHCILAHXWW0Ov8=
X-Google-Smtp-Source: APXvYqwFGTZ8dXkTeqzQ3XjnVkHmdqsitJdmYe3AqiOXfrobn8piOkVzYefzglLYI0mK6JSZn+iJj2KKlZdJHw==
X-Received: by 2002:a63:d058:: with SMTP id s24mr31641685pgi.189.1570487721395;
 Mon, 07 Oct 2019 15:35:21 -0700 (PDT)
Date:   Mon,  7 Oct 2019 15:35:15 -0700
In-Reply-To: <cover.1570487473.git.steadmon@google.com>
Message-Id: <348b99edf3e736f11ea13793610f2e0433875fab.1570487473.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1570059953.git.steadmon@google.com> <cover.1570487473.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v2 1/2] fetch: add trace2 instrumentation
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add trace2 regions to fetch-pack.c and builtins/fetch.c to better track
time spent in the various phases of a fetch:

* listing refs
* negotiation for protocol versions v0-v2
* fetching refs
* consuming refs

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/fetch.c | 22 +++++++++++++++-------
 fetch-pack.c    | 13 ++++++++++++-
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 67c0eb88c6..ee3dc085bb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1071,8 +1071,11 @@ static int check_exist_and_connected(struct ref *ref_map)
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
 	int ret = check_exist_and_connected(ref_map);
-	if (ret)
+	if (ret) {
+		trace2_region_enter("fetch", "fetch_refs", the_repository);
 		ret = transport_fetch_refs(transport, ref_map);
+		trace2_region_leave("fetch", "fetch_refs", the_repository);
+	}
 	if (!ret)
 		/*
 		 * Keep the new pack's ".keep" file around to allow the caller
@@ -1088,11 +1091,14 @@ static int consume_refs(struct transport *transport, struct ref *ref_map)
 {
 	int connectivity_checked = transport->smart_options
 		? transport->smart_options->connectivity_checked : 0;
-	int ret = store_updated_refs(transport->url,
-				     transport->remote->name,
-				     connectivity_checked,
-				     ref_map);
+	int ret;
+	trace2_region_enter("fetch", "consume_refs", the_repository);
+	ret = store_updated_refs(transport->url,
+				 transport->remote->name,
+				 connectivity_checked,
+				 ref_map);
 	transport_unlock_pack(transport);
+	trace2_region_leave("fetch", "consume_refs", the_repository);
 	return ret;
 }
 
@@ -1337,9 +1343,11 @@ static int do_fetch(struct transport *transport,
 			argv_array_push(&ref_prefixes, "refs/tags/");
 	}
 
-	if (must_list_refs)
+	if (must_list_refs) {
+		trace2_region_enter("fetch", "remote_refs", the_repository);
 		remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
-	else
+		trace2_region_leave("fetch", "remote_refs", the_repository);
+	} else
 		remote_refs = NULL;
 
 	argv_array_clear(&ref_prefixes);
diff --git a/fetch-pack.c b/fetch-pack.c
index 6ccc6294ea..c016eeab1d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -382,6 +382,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 		state_len = 0;
 	}
 
+	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
 	flushes = 0;
 	retval = -1;
 	if (args->no_dependents)
@@ -466,6 +467,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 		}
 	}
 done:
+	trace2_region_leave("fetch-pack", "negotiation_v0_v1", the_repository);
 	if (!got_ready || !no_done) {
 		packet_buf_write(&req_buf, "done\n");
 		send_request(args, fd[1], &req_buf);
@@ -1378,7 +1380,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	enum fetch_state state = FETCH_CHECK_LOCAL;
 	struct oidset common = OIDSET_INIT;
 	struct packet_reader reader;
-	int in_vain = 0;
+	int in_vain = 0, negotiation_started = 0;
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator;
 	fetch_negotiator_init(r, &negotiator);
@@ -1421,6 +1423,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			}
 			break;
 		case FETCH_SEND_REQUEST:
+			if (!negotiation_started) {
+				negotiation_started = 1;
+				trace2_region_enter("fetch-pack",
+						    "negotiation_v2",
+						    the_repository);
+			}
 			if (send_fetch_request(&negotiator, fd[1], args, ref,
 					       &common,
 					       &haves_to_send, &in_vain,
@@ -1444,6 +1452,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			}
 			break;
 		case FETCH_GET_PACK:
+			trace2_region_leave("fetch-pack",
+					    "negotiation_v2",
+					    the_repository);
 			/* Check for shallow-info section */
 			if (process_section_header(&reader, "shallow-info", 1))
 				receive_shallow_info(args, &reader, shallows, si);
-- 
2.23.0.581.g78d2f28ef7-goog

