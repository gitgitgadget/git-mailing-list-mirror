Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665211F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEPXAl (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:00:41 -0400
Received: from mail-ot0-f201.google.com ([74.125.82.201]:42263 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeEPW7d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:33 -0400
Received: by mail-ot0-f201.google.com with SMTP id c6-v6so2042797otk.9
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=pidivBZX0WSSHeoiE1ytFA7rQSP/h0XnOxZrLYxpuCo=;
        b=RU0EosZ+7Pnmp3tMHIEAS5Ifqw6vRKCDGzYEZctgyXnZnTRNXyMtSSLEQs7tay60Rn
         Qphbn+YOyRIpwJICov4BqE51NeZcqx641PhbAdEkiW/LNEQ/nXec3ZsAJitqg6fQMUOc
         xvoleXF+sHUwZI0nGPunMYHgCn8A3IDhwJc+yFHLCzf8y5h6p9YsHO+Vke4WEa2gvJgQ
         WhiNIvpVejVYrzWSGUaXzQ0YJN4nT4ThcYPMghxbRXcc6YynBbPmQ2B+yK0H3BoinQRq
         cV7T8dFvWSeql1tQOsjqhHczpiVQ/TaphYGiaHfys2xhfN4WhC5EuawqlGQRv5BWNVoN
         fmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=pidivBZX0WSSHeoiE1ytFA7rQSP/h0XnOxZrLYxpuCo=;
        b=h9YqYEikmLBWJvomldB5vrELHUToupD+rimBdqjnMRRcl55fuC1amJBiIVSrFmXayz
         LA/PQB+nh9935eb7c7+aSHhyqLbe3yeYrkSdRbp4A/jAq5fXW43NQEiq9gIs1V3ntGDz
         80B8RA8KUNArpiMIJzYb1gPIPK0JSUlPgHbtNV0GMEbzPLRaZFB+EWAr8Q6ad37xtvWX
         q51WLOyQJz1Y96brws8m1vuSfijOD/S8qOJOaznSs2o+bUrXBs8XbV0Ejy8V/7p0ligf
         lC5QqPlAAywO/sVMAYjNsKiEFhD6AXasjJFYZDu2eZT2qhIB6npjSllJINH+254NlRh1
         bYTQ==
X-Gm-Message-State: ALKqPwdD2jV/UM50vu/Pb29XZ9NvTcDbonTw5/TtFZPMMvMsny/nH5az
        6v4aPwLShVkcBTosjQnc3eKMZO0H1An6Z6g58XULrlwcAW3rWMR44G/srdj8Hmheh7BYhQFk2ow
        3fRCNHCCuegiVEXt3P09bW6FsOS+EgX8QNNdiKMIDIkQ9IOueGpqqnhNH0g==
X-Google-Smtp-Source: AB8JxZoqGHJ2scKgm47khxEtSGJY7XzD5+Irq2nGr9mPaqpr3+E1XgrvDuvdQCBcXxiBT1FNC0Nh3nYYUQs=
MIME-Version: 1.0
X-Received: by 2002:aca:ec43:: with SMTP id k64-v6mr2338511oih.72.1526511572766;
 Wed, 16 May 2018 15:59:32 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:10 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-24-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 23/36] remote: convert get_stale_heads to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'get_stale_heads()' to take a 'struct refspec' as a parameter instead
of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c  |  2 +-
 builtin/remote.c |  3 +--
 remote.c         | 18 +++++++++---------
 remote.h         |  2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5e46df70c..3fad1f0db 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -963,7 +963,7 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
 		      const char *raw_url)
 {
 	int url_len, i, result = 0;
-	struct ref *ref, *stale_refs = get_stale_heads(rs->items, rs->nr, ref_map);
+	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
 	char *url;
 	int summary_width = transport_summary_width(stale_refs);
 	const char *dangling_msg = dry_run
diff --git a/builtin/remote.c b/builtin/remote.c
index 94dfcb78b..b8e66589f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -347,8 +347,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
 	}
-	stale_refs = get_stale_heads(states->remote->fetch.items,
-				     states->remote->fetch.nr, fetch_map);
+	stale_refs = get_stale_heads(&states->remote->fetch, fetch_map);
 	for (ref = stale_refs; ref; ref = ref->next) {
 		struct string_list_item *item =
 			string_list_append(&states->stale, abbrev_branch(ref->name));
diff --git a/remote.c b/remote.c
index 4a9bddf0d..358442e4b 100644
--- a/remote.c
+++ b/remote.c
@@ -698,7 +698,9 @@ static int match_name_with_pattern(const char *key, const char *name,
 	return ret;
 }
 
-static void query_refspecs_multiple(struct refspec_item *refs, int ref_count, struct refspec_item *query, struct string_list *results)
+static void query_refspecs_multiple(struct refspec *rs,
+				    struct refspec_item *query,
+				    struct string_list *results)
 {
 	int i;
 	int find_src = !query->src;
@@ -706,8 +708,8 @@ static void query_refspecs_multiple(struct refspec_item *refs, int ref_count, st
 	if (find_src && !query->dst)
 		error("query_refspecs_multiple: need either src or dst");
 
-	for (i = 0; i < ref_count; i++) {
-		struct refspec_item *refspec = &refs[i];
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *refspec = &rs->items[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
 		const char *needle = find_src ? query->dst : query->src;
@@ -2068,8 +2070,7 @@ struct ref *guess_remote_head(const struct ref *head,
 struct stale_heads_info {
 	struct string_list *ref_names;
 	struct ref **stale_refs_tail;
-	struct refspec_item *refs;
-	int ref_count;
+	struct refspec *rs;
 };
 
 static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
@@ -2082,7 +2083,7 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.dst = (char *)refname;
 
-	query_refspecs_multiple(info->refs, info->ref_count, &query, &matches);
+	query_refspecs_multiple(info->rs, &query, &matches);
 	if (matches.nr == 0)
 		goto clean_exit; /* No matches */
 
@@ -2110,7 +2111,7 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-struct ref *get_stale_heads(struct refspec_item *refs, int ref_count, struct ref *fetch_map)
+struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map)
 {
 	struct ref *ref, *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
@@ -2118,8 +2119,7 @@ struct ref *get_stale_heads(struct refspec_item *refs, int ref_count, struct ref
 
 	info.ref_names = &ref_names;
 	info.stale_refs_tail = &stale_refs;
-	info.refs = refs;
-	info.ref_count = ref_count;
+	info.rs = rs;
 	for (ref = fetch_map; ref; ref = ref->next)
 		string_list_append(&ref_names, ref->name);
 	string_list_sort(&ref_names);
diff --git a/remote.h b/remote.h
index 4ffbc0082..1a45542cd 100644
--- a/remote.h
+++ b/remote.h
@@ -267,7 +267,7 @@ struct ref *guess_remote_head(const struct ref *head,
 			      int all);
 
 /* Return refs which no longer exist on remote */
-struct ref *get_stale_heads(struct refspec_item *refs, int ref_count, struct ref *fetch_map);
+struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map);
 
 /*
  * Compare-and-swap
-- 
2.17.0.441.gb46fe60e1d-goog

