Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AF171F406
	for <e@80x24.org>; Mon, 14 May 2018 21:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeENV7B (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:59:01 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:39322 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbeENV5f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:35 -0400
Received: by mail-ua0-f201.google.com with SMTP id j3-v6so17880307ual.6
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=uRwc2kIBq1lWeYg8KzL32KOncRmWwkHDTee5VTauBvs=;
        b=lL6a5OF6diBT6w5yFnYCkJmeZ7lpNQ63/qgtGy9wH5aDbIzG/coUpm9smZRNuxw8tr
         ssM1UywEOaOmVf67ZzbhvKrnMXN6yimRZdmTzLrPz3/3tqLRRwgOZNG3VFwNyAK5XzAl
         36w96lIyTSCKpvnBudKGqHPJ+5uA4qfTuEYDy6DymQdZytLMrE0d+pKixSN7l+1LIgWM
         2D7hi8w48W8NX+OZWUpK3g7QocPYqGGPvp3f0NEM0Jjfq0hvax0UuS0y4a3+6A2X7nWA
         Lhb/EZ8cipbo50qOZS2T/5W0FrdrNACWbdrRFNom+LaQIs1xuN8qV8R9oZlsIB6p/j+Z
         jkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=uRwc2kIBq1lWeYg8KzL32KOncRmWwkHDTee5VTauBvs=;
        b=XOvxKPGi1Si9+lxJAcTW17eXwTqdAn2GQprR/w9KNzCBnRUobmfslM1Ot/F14GiY9j
         n+/zcb9q5CHAF7axUNcLk8QVF6xnFUMLX4AhHnwjl0nxUqbWFfiEyeEBvhdKBULXq6xl
         q8IZwA5fx1toSk+Q6XsLR1bBdvu8GNvAiI7Az7haB+dZ/orSAiOCVgutPeDpoFoLwEkv
         fyUciEZm3qfOPLh5tH0Gkk45AAXhznDCKCJ9zkGKTajxEw++HFFzqOfo3q2cmTzo6tpm
         NcklIfYB3lViznx+TyBGQNkPUNVX00v2L+Q5N133uW3AB+SgS/HPUljdKpIhPPxdhJK6
         DL0A==
X-Gm-Message-State: ALKqPweXLF/qrc80pylhtFYNGt66KRfWpAMcc2Sf4Ffg/FefC252QHbj
        r+ZAO0vRK5Wx6WcHX4d3RKnCJY0c05pN4VHAZrHlzwxo5nkjz18K2qXf30pxolR2b8R/XoiasUh
        D8GSL4NBZSA+xCVPiqoflpdk2Ubv36xA3NgoTWhiFaB1z59Sx+egRcAFWdQ==
X-Google-Smtp-Source: AB8JxZqxJBkZC7YHfXc9TT8lRjkY1G/aywL6S013jKq8KuUHV5eaVlIMeFX4coCjtyeVLBt/7h9argLOB7s=
MIME-Version: 1.0
X-Received: by 2002:a9f:3bdd:: with SMTP id y29-v6mr13344359uah.53.1526335054653;
 Mon, 14 May 2018 14:57:34 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:14 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-24-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 23/35] remote: convert apply_refspecs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'apply_refspecs()' to take a 'struct refspec' as a parameter instead
of a list of 'struct refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fast-export.c |  2 +-
 remote.c              | 15 ++++++---------
 remote.h              |  3 +--
 transport-helper.c    |  6 +++---
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 143999738..41fe49e4d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -831,7 +831,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 
 		if (refspecs.nr) {
 			char *private;
-			private = apply_refspecs(refspecs.items, refspecs.nr, full_name);
+			private = apply_refspecs(&refspecs, full_name);
 			if (private) {
 				free(full_name);
 				full_name = private;
diff --git a/remote.c b/remote.c
index f2e97c545..54297de3d 100644
--- a/remote.c
+++ b/remote.c
@@ -534,8 +534,7 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push,
 			struct remote *remote = remote_get(remote_name);
 
 			if (remote && remote->push.nr &&
-			    (dst = apply_refspecs(remote->push.items,
-						  remote->push.nr,
+			    (dst = apply_refspecs(&remote->push,
 						  branch->refname))) {
 				if (explicit)
 					*explicit = 1;
@@ -766,15 +765,14 @@ int query_refspecs(struct refspec_item *refs, int ref_count, struct refspec_item
 	return -1;
 }
 
-char *apply_refspecs(struct refspec_item *refspecs, int nr_refspec,
-		     const char *name)
+char *apply_refspecs(struct refspec *rs, const char *name)
 {
 	struct refspec_item query;
 
 	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = (char *)name;
 
-	if (query_refspecs(refspecs, nr_refspec, &query))
+	if (query_refspecs(rs->items, rs->nr, &query))
 		return NULL;
 
 	return query.dst;
@@ -1580,7 +1578,7 @@ static const char *tracking_for_push_dest(struct remote *remote,
 {
 	char *ret;
 
-	ret = apply_refspecs(remote->fetch.items, remote->fetch.nr, refname);
+	ret = apply_refspecs(&remote->fetch, refname);
 	if (!ret)
 		return error_buf(err,
 				 _("push destination '%s' on remote '%s' has no local tracking branch"),
@@ -1602,8 +1600,7 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 		char *dst;
 		const char *ret;
 
-		dst = apply_refspecs(remote->push.items, remote->push.nr,
-				     branch->refname);
+		dst = apply_refspecs(&remote->push, branch->refname);
 		if (!dst)
 			return error_buf(err,
 					 _("push refspecs for '%s' do not include '%s'"),
@@ -2212,7 +2209,7 @@ static int remote_tracking(struct remote *remote, const char *refname,
 {
 	char *dst;
 
-	dst = apply_refspecs(remote->fetch.items, remote->fetch.nr, refname);
+	dst = apply_refspecs(&remote->fetch, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
 	if (read_ref(dst, oid))
diff --git a/remote.h b/remote.h
index 5ac7536f5..4e7590b55 100644
--- a/remote.h
+++ b/remote.h
@@ -159,8 +159,7 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
 extern int query_refspecs(struct refspec_item *specs, int nr, struct refspec_item *query);
-char *apply_refspecs(struct refspec_item *refspecs, int nr_refspec,
-		     const char *name);
+char *apply_refspecs(struct refspec *rs, const char *name);
 
 int check_push_refs(struct ref *src, int nr_refspec, const char **refspec);
 int match_push_refs(struct ref *src, struct ref **dst,
diff --git a/transport-helper.c b/transport-helper.c
index 33f51ebfc..1f8ff7e94 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -523,7 +523,7 @@ static int fetch_with_import(struct transport *transport,
 			continue;
 		name = posn->symref ? posn->symref : posn->name;
 		if (data->rs.nr)
-			private = apply_refspecs(data->rs.items, data->rs.nr, name);
+			private = apply_refspecs(&data->rs, name);
 		else
 			private = xstrdup(name);
 		if (private) {
@@ -805,7 +805,7 @@ static int push_update_refs_status(struct helper_data *data,
 			continue;
 
 		/* propagate back the update to the remote namespace */
-		private = apply_refspecs(data->rs.items, data->rs.nr, ref->name);
+		private = apply_refspecs(&data->rs, ref->name);
 		if (!private)
 			continue;
 		update_ref("update by helper", private, &ref->new_oid, NULL,
@@ -942,7 +942,7 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		struct object_id oid;
 
-		private = apply_refspecs(data->rs.items, data->rs.nr, ref->name);
+		private = apply_refspecs(&data->rs, ref->name);
 		if (private && !get_oid(private, &oid)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append_nodup(&revlist_args,
-- 
2.17.0.441.gb46fe60e1d-goog

