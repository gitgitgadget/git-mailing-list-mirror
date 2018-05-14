Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8842B1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeENV6D (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:58:03 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:46652 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeENV6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:58:00 -0400
Received: by mail-vk0-f73.google.com with SMTP id 79-v6so17181754vky.13
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Hr+wipMWZ3CmoczVlsXb/beEFftzWyRkIDxEwVmf3AM=;
        b=Q89kroNMiVizwexyGrgiuMgrf+ud4hSwTXEi6fF56uTEcXRuej8C/iEB+MS4HT3DQz
         CNFzp1+2XWpqW48q46PLClr6H6Wu/R/8whGUA8F1ayrgBpkwGaUa+4uxB3t8eDUwZOxI
         UOWRCZ/Ajown9P/DyGTiyN1CP3ycKXpHAGULVmDdtjx/JK3lcahs7CGD35WB2IGyEGHA
         1jIxkS5x74ng2fF+6kNfOc9x08wk65MNSxFBvs0HdOF6pd93YEYWZso824+i1Y4HGbjs
         r4H1T/0iL8tJwLlS0zQrZuSu4oHZ2fNcGwWG1yDbSnUnJyXpsfNmKtknBvYCAzUEQZWb
         eKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Hr+wipMWZ3CmoczVlsXb/beEFftzWyRkIDxEwVmf3AM=;
        b=WZ83pXZMxBARtDU/PJZEMGecNm7mU8FCPc/pUBAHg/AcHPuUxxlkEu8QiDH+nTItNw
         dWsXcf2/qlXYFHJrnTFdyzZac4VhtYXo+E2SJIAUJkvjRYbQ07VuPSq6XgsgNhdbxV8q
         9lDU7d+M9v6KUDDBnjd+IzqjJzbr4CvtiaWEUZg/+RqWCHzcxp1FkeZMYzqkmOrUCoPN
         BpWL7J3TfIH7KuYkcOkN0LsnB5C5WOvncC7xFYiumUy5IKMLeQUIQSjnJeQBKru5+O3h
         1GwcmTcd0qLPmYe4VeyEBKPYjDw24Un2Rmk/kJrt3n7E0QXVcyRuiq0tPFc5kzZ6QxbK
         sP3g==
X-Gm-Message-State: ALKqPweUrz4eekAP23fQO2gAXIduJ1UhuJBpurbEzgAEIJm+NEZaCEaO
        ubVgosMa+zaPAkPGbA0mhBqaUhQ3BwgEJx5sLUqOzgPvnI61exCaR9V2BFlevD5a4q4IkaXv4jd
        wpVtXSwM5HA39/zDEQ7xWDVRImvctaRMqUBGgEmS0bARWEtn0owc+q5Fn5Q==
X-Google-Smtp-Source: AB8JxZoZNi4VCtRG+w1/83jpXk1m58LPrxnEhpHSsC5hZOoq/B0mCH8/uiKXjKoPPEObiO7Mg80tJKF4X0k=
MIME-Version: 1.0
X-Received: by 2002:ab0:5173:: with SMTP id f48-v6mr12666511uaa.98.1526335079588;
 Mon, 14 May 2018 14:57:59 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:24 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-34-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 33/35] remote: convert match_push_refs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'match_push_refs()' to take a 'struct refspec' as a parameter
instead of an array of 'const char *'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/remote.c    |  3 +--
 builtin/send-pack.c |  2 +-
 http-push.c         |  3 +--
 remote.c            | 21 ++++++++-------------
 remote.h            |  2 +-
 transport.c         |  4 +---
 6 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index b8e66589f..b84175cc6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -387,8 +387,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 	local_refs = get_local_heads();
 	push_map = copy_ref_list(remote_refs);
 
-	match_push_refs(local_refs, &push_map, remote->push.raw_nr,
-			remote->push.raw, MATCH_REFS_NONE);
+	match_push_refs(local_refs, &push_map, &remote->push, MATCH_REFS_NONE);
 
 	states->push.strdup_strings = 1;
 	for (ref = push_map; ref; ref = ref->next) {
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 7c34bf467..4923b1058 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -275,7 +275,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		flags |= MATCH_REFS_MIRROR;
 
 	/* match them up */
-	if (match_push_refs(local_refs, &remote_refs, rs.raw_nr, rs.raw, flags))
+	if (match_push_refs(local_refs, &remote_refs, &rs, flags))
 		return -1;
 
 	if (!is_empty_cas(&cas))
diff --git a/http-push.c b/http-push.c
index a724ef03f..ea5af6227 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1823,8 +1823,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	/* match them up */
-	if (match_push_refs(local_refs, &remote_refs,
-			    rs.raw_nr, rs.raw, push_all)) {
+	if (match_push_refs(local_refs, &remote_refs, &rs, push_all)) {
 		rc = -1;
 		goto cleanup;
 	}
diff --git a/remote.c b/remote.c
index 73d462f24..0e882d812 100644
--- a/remote.c
+++ b/remote.c
@@ -1294,23 +1294,20 @@ int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
  * dst (e.g. pushing to a new branch, done in match_explicit_refs).
  */
 int match_push_refs(struct ref *src, struct ref **dst,
-		    int nr_refspec, const char **refspec, int flags)
+		    struct refspec *rs, int flags)
 {
-	struct refspec rs = REFSPEC_INIT_PUSH;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
 	int send_prune = flags & MATCH_REFS_PRUNE;
 	int errs;
-	static const char *default_refspec[] = { ":", NULL };
 	struct ref *ref, **dst_tail = tail_ref(dst);
 	struct string_list dst_ref_index = STRING_LIST_INIT_NODUP;
 
-	if (!nr_refspec) {
-		nr_refspec = 1;
-		refspec = default_refspec;
-	}
-	refspec_appendn(&rs, refspec, nr_refspec);
-	errs = match_explicit_refs(src, *dst, &dst_tail, &rs);
+	/* If no refspec is provided, use the default ":" */
+	if (!rs->nr)
+		refspec_append(rs, ":");
+
+	errs = match_explicit_refs(src, *dst, &dst_tail, rs);
 
 	/* pick the remainder */
 	for (ref = src; ref; ref = ref->next) {
@@ -1319,7 +1316,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		const struct refspec_item *pat = NULL;
 		char *dst_name;
 
-		dst_name = get_ref_match(&rs, ref, send_mirror, FROM_SRC, &pat);
+		dst_name = get_ref_match(rs, ref, send_mirror, FROM_SRC, &pat);
 		if (!dst_name)
 			continue;
 
@@ -1368,7 +1365,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 				/* We're already sending something to this ref. */
 				continue;
 
-			src_name = get_ref_match(&rs, ref, send_mirror, FROM_DST, NULL);
+			src_name = get_ref_match(rs, ref, send_mirror, FROM_DST, NULL);
 			if (src_name) {
 				if (!src_ref_index.nr)
 					prepare_ref_index(&src_ref_index, src);
@@ -1381,8 +1378,6 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		string_list_clear(&src_ref_index, 0);
 	}
 
-	refspec_clear(&rs);
-
 	if (errs)
 		return -1;
 	return 0;
diff --git a/remote.h b/remote.h
index edcfc3600..d5b5f24ac 100644
--- a/remote.h
+++ b/remote.h
@@ -163,7 +163,7 @@ char *apply_refspecs(struct refspec *rs, const char *name);
 
 int check_push_refs(struct ref *src, int nr_refspec, const char **refspec);
 int match_push_refs(struct ref *src, struct ref **dst,
-		    int nr_refspec, const char **refspec, int all);
+		    struct refspec *rs, int flags);
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	int force_update);
 
diff --git a/transport.c b/transport.c
index fe96c0b80..24a97d9e8 100644
--- a/transport.c
+++ b/transport.c
@@ -1127,10 +1127,8 @@ int transport_push(struct transport *transport,
 		if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
 			match_flags |= MATCH_REFS_FOLLOW_TAGS;
 
-		if (match_push_refs(local_refs, &remote_refs,
-				    rs->raw_nr, rs->raw, match_flags)) {
+		if (match_push_refs(local_refs, &remote_refs, rs, match_flags))
 			return -1;
-		}
 
 		if (transport->smart_options &&
 		    transport->smart_options->cas &&
-- 
2.17.0.441.gb46fe60e1d-goog

