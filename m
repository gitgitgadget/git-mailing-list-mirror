Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8307C1F597
	for <e@80x24.org>; Mon, 25 Jun 2018 18:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965000AbeFYSxt (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:53:49 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:46962 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965009AbeFYSxq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:53:46 -0400
Received: by mail-yw0-f201.google.com with SMTP id v80-v6so11518083ywc.13
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=rLOxeAejN/gP1LVKYA9UGMsw/ue5K5yR3AKLI/xRcIU=;
        b=CbYjFNqnNFNsmX4YW+IQAAFptqeqqCmEEwXBagTjqKSMoCD9zowmX/sn2g7x0H3isL
         bbfjbeUI4xmvYvtUbAMuUTH1pEJMPcYBR6wR8RmaLFLCm+33v9U0Om2LKHGs4rMNacyq
         +zpRPqPAIIt/hW85f3cL9wBxi5jNNyxGJw8uGgNM2u4C6mFmrE11w8gNksW/I9rCE1z7
         Gj0qqKLrf8kwyJw2UeUBhP7FfEdZMIje343I7RxJnJACrOv6+8BhT2dPuj9OeTFCFriZ
         f5Wg8ZybmYbkv/Nw7NkDhBSBekDEAlC9vnS++xjVfdUDK6j1w7aGZWD+kirrKQ5UxbLJ
         NsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=rLOxeAejN/gP1LVKYA9UGMsw/ue5K5yR3AKLI/xRcIU=;
        b=ZypojVP+cgPx6HHqyKVRAQBG6poCAXIIjDOYSKKDi/yXKeUR/gE91didEknPRLdNlF
         RumDYNhyh0K0jlCRpxWnJCIU0RaiJXfx7UhKcDXPaXOaLOtZYFFh+T6RXMrK8MNJrN+k
         awsgiZjDo14ZXhYgW4Ea5S1GcGWVMq5RjwFa0qzzbLb/2RpI04TB6Q2SxXkxoBDtD86G
         4ZYYOFUQzL4bOGXTO5RiNeZPUweZCiKQiGvw3XPSP/HrqFvVInQdpwjoMNG90RtLX6kZ
         J3TSpE49AjDIJm8smZ4cFhQXSID7iirxSbGOYQkB/EaQJgurV+vKMNZMOtEX+DpD7Nt5
         +6Yw==
X-Gm-Message-State: APt69E1rCgDL9piqHg4manZnKLwgX90IyoYzYZ5tYG4HSv/K04M1szOV
        r8naLLXJFI6Dt/mOkJT5DgsES6hV5lJgpXt2SP3luTxRg2GSR3wzNVI+aXntrrOB5sL6AWI+WkS
        m0zuPltzWeLErwhoDDuWVnr0Lq4fy9X33MdhyGJm7f8cEA8gQ0OrYa8Cmtg==
X-Google-Smtp-Source: ADUXVKJgWSrsSySYKP9jQkhRWpkR3mmd5VsGqpMzyhkiePIF+q3PkBNx7szQDC71BhrFjdubIPW70PCey1E=
MIME-Version: 1.0
X-Received: by 2002:a25:abf2:: with SMTP id v105-v6mr3791027ybi.60.1529952826093;
 Mon, 25 Jun 2018 11:53:46 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:53:28 -0700
In-Reply-To: <20180625185332.164142-1-bmwill@google.com>
Message-Id: <20180625185332.164142-5-bmwill@google.com>
References: <20180620213235.10952-1-bmwill@google.com> <20180625185332.164142-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v4 4/8] fetch: refactor the population of peer ref OIDs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Populate peer ref OIDs in get_ref_map instead of do_fetch. Besides
tightening scopes of variables in the code, this also prepares for
get_ref_map being able to be called multiple times within do_fetch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669a..545635448 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -351,6 +351,7 @@ static struct ref *get_ref_map(struct transport *transport,
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
+	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	const struct ref *remote_refs;
 
 	if (rs->nr)
@@ -458,7 +459,23 @@ static struct ref *get_ref_map(struct transport *transport,
 		tail = &rm->next;
 	}
 
-	return ref_remove_duplicates(ref_map);
+	ref_map = ref_remove_duplicates(ref_map);
+
+	for_each_ref(add_existing, &existing_refs);
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref) {
+			struct string_list_item *peer_item =
+				string_list_lookup(&existing_refs,
+						   rm->peer_ref->name);
+			if (peer_item) {
+				struct object_id *old_oid = peer_item->util;
+				oidcpy(&rm->peer_ref->old_oid, old_oid);
+			}
+		}
+	}
+	string_list_clear(&existing_refs, 1);
+
+	return ref_map;
 }
 
 #define STORE_REF_ERROR_OTHER 1
@@ -1110,14 +1127,10 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs)
 {
-	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct ref *ref_map;
-	struct ref *rm;
 	int autotags = (transport->remote->fetch_tags == 1);
 	int retcode = 0;
 
-	for_each_ref(add_existing, &existing_refs);
-
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
 			tags = TAGS_SET;
@@ -1136,18 +1149,6 @@ static int do_fetch(struct transport *transport,
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
-	for (rm = ref_map; rm; rm = rm->next) {
-		if (rm->peer_ref) {
-			struct string_list_item *peer_item =
-				string_list_lookup(&existing_refs,
-						   rm->peer_ref->name);
-			if (peer_item) {
-				struct object_id *old_oid = peer_item->util;
-				oidcpy(&rm->peer_ref->old_oid, old_oid);
-			}
-		}
-	}
-
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (prune) {
@@ -1183,7 +1184,6 @@ static int do_fetch(struct transport *transport,
 	}
 
  cleanup:
-	string_list_clear(&existing_refs, 1);
 	return retcode;
 }
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

