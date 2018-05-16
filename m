Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096611F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeEPW7j (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:39 -0400
Received: from mail-ot0-f202.google.com ([74.125.82.202]:39956 "EHLO
        mail-ot0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbeEPW7f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:35 -0400
Received: by mail-ot0-f202.google.com with SMTP id n3-v6so2028648otk.7
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Rp3FZM0ieIDu6hpAb4JzTrS01h1tUD48+uxqXDfD5LM=;
        b=WfYPrAYW7bt5PrpfwfsStzIXrbO0HTitAfV4Tz2WBU1ckXV0WBQKZHAvvJ07a3zkcX
         BP7Ti1YA8hPQU570M6KQNRO2gAdosQZb99VYmXRJjPB4o9svwXSL3lVl9IZWUKCCkeJZ
         83AwAn+mARdqIi4trj+0nditW/HLySq+XFFQdwO/VerJAnRQaIiiITmDniFDHTz0vrzf
         dxD7LbiymexpjBcucZTTELln9SfPBXQ8vYkIHu82OhIOTc1qqMA+QG6T+WtyWk8R3LXk
         y5/cVMOZn8ZBAaiMrB4MbPcOTSj2GRuKJmOGvGNiiSFRBFehMmxjhLiK8Zi45DWPh3vL
         d+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Rp3FZM0ieIDu6hpAb4JzTrS01h1tUD48+uxqXDfD5LM=;
        b=AMje3ixRk7+5YfsKbJqn1ixVUxdTq32ZbsVKk12diMiZXNO31c/g6MCe7PYLVLCmGx
         ftEvMCz8qFjt8umtiw/bBD6YrO8iHlAbB+6fONf+nYzcLzQrZecIBbO/xk9IGkqINGQp
         Jxr2R2THkxjojsc226P/3jg5NhMZYAYkjfg108TuIAPPQ7UpkS86ICvy5tVuO2gEsjdv
         3CZ8S35D+rOtecSakbnoiZaFTsDsdftJWryOhbeAHa7HX4YtPBCta5vY1ya4SAhxYuvg
         XlzWGSYSEkiep0Yu3I7cSm+10+tF0042WqMJjAKlQZVmbyh2MqznhjXM/EFe+VqdsPIg
         OAgQ==
X-Gm-Message-State: ALKqPweGHJMjUkcxyAoYouTAgVb8duAVKR5YCZU6bfXBgaq7Xrl/smwn
        PzGkvOBzY/JHOcFy4L/ybnj3RAS2Z5xanYJw/2HRdCcMylhGrX+jz/iz8OwcGmqHT5L+v5NKoIf
        4CyDcPw5A6JPyRNyYijoQPh76OhPQ1PJ0BSMKoyAz+2tanYLimxA8Gofvyg==
X-Google-Smtp-Source: AB8JxZqXEHuKx9RoKa76TsfHZQ2oTt5t2VVxuFuOBrvag+0Em7yqXmIjWtGCQyFnTV9KaAHcn2OXzumRfpQ=
MIME-Version: 1.0
X-Received: by 2002:aca:e144:: with SMTP id y65-v6mr2476175oig.30.1526511575001;
 Wed, 16 May 2018 15:59:35 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:11 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-25-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 24/36] remote: convert apply_refspecs to take a struct refspec
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
index 358442e4b..89415a263 100644
--- a/remote.c
+++ b/remote.c
@@ -525,8 +525,7 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push,
 			struct remote *remote = remote_get(remote_name);
 
 			if (remote && remote->push.nr &&
-			    (dst = apply_refspecs(remote->push.items,
-						  remote->push.nr,
+			    (dst = apply_refspecs(&remote->push,
 						  branch->refname))) {
 				if (explicit)
 					*explicit = 1;
@@ -757,15 +756,14 @@ int query_refspecs(struct refspec_item *refs, int ref_count, struct refspec_item
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
@@ -1571,7 +1569,7 @@ static const char *tracking_for_push_dest(struct remote *remote,
 {
 	char *ret;
 
-	ret = apply_refspecs(remote->fetch.items, remote->fetch.nr, refname);
+	ret = apply_refspecs(&remote->fetch, refname);
 	if (!ret)
 		return error_buf(err,
 				 _("push destination '%s' on remote '%s' has no local tracking branch"),
@@ -1593,8 +1591,7 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 		char *dst;
 		const char *ret;
 
-		dst = apply_refspecs(remote->push.items, remote->push.nr,
-				     branch->refname);
+		dst = apply_refspecs(&remote->push, branch->refname);
 		if (!dst)
 			return error_buf(err,
 					 _("push refspecs for '%s' do not include '%s'"),
@@ -2203,7 +2200,7 @@ static int remote_tracking(struct remote *remote, const char *refname,
 {
 	char *dst;
 
-	dst = apply_refspecs(remote->fetch.items, remote->fetch.nr, refname);
+	dst = apply_refspecs(&remote->fetch, refname);
 	if (!dst)
 		return -1; /* no tracking ref for refname at remote */
 	if (read_ref(dst, oid))
diff --git a/remote.h b/remote.h
index 1a45542cd..0b1fcc051 100644
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

