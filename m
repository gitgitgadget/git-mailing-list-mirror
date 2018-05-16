Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E0B1F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeEPXAC (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:00:02 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:36561 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752383AbeEPW77 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:59 -0400
Received: by mail-yb0-f201.google.com with SMTP id 189-v6so1262571ybf.3
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hzJ7V4BmkONfQkG8GFa5i7eqq5+jkHAeyLFNfKQ9Ewg=;
        b=k5Ac8I9TpLZed/bRCpVT3dPo/SXmwuW/JaYxINoPKdG/ILOYMYrceNWYxCu6/5dOyB
         UtXyLEcQ/YBhdRwvPUl+O6EndBSqQqV0jscs6WMQuA7p14VTVacoMU42gwGi+qOK3bKJ
         NB+4YeHLldAx+FGRGHnaxOuRj5aiz37VJYv3rQvgFvziE47ABhx0GynCMC0y5yT2OZow
         zEptMdOglbHGAQw1Mmh0fjasslPlzEemviYVnr8iER88oLqK8oosUa0KOMMuWdJsK8wj
         GDo/fnyLaGIVGsMO87/FhjQ5FGzHoFb4QnqclsmS/wq76xe8B5EAjILfHXtfsL95e/zZ
         L28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hzJ7V4BmkONfQkG8GFa5i7eqq5+jkHAeyLFNfKQ9Ewg=;
        b=mf3VOFaoFc6geXByPlibhZIgBCouW8RJS7+kGoy6GCuIwUrH/Vayb/PRuhB/Rujtun
         QDNb6TsqIsJTmcfQIzFONNT76S5OUnTKyRba9/wJeoCK+yZCkSOHjujXSdkjpAOKFKxO
         kdcXxBmvYsBcBidIX59TKmXC9mhncJ/r+t03Z4A91VhlL5drzbwFTYnJ4N70YIt8PdER
         duGH6b2Ym6jzwoy022PB4OD+vhgoMLAjoxFZpfHdSaTAWhQYsaP9nyWwTmCky2mUGmmF
         od0KEfqFsT5ZUWuCtlF8x0TXJeZCpF284ujLK2u1YhxuCTPE+sIEpxfo/xWBcwX1Q9Fq
         u2EA==
X-Gm-Message-State: ALKqPwdvwalgZKdmiDK0RDo1yQdfUQYyMhZyuQVE452Vp0nKxHlu6Q6r
        VXvY3F+layLfTfEuMyHY2cpv/CpcKVmlg0bSvLqTQGISfkgWtfBPV8Di/J3hwwWeopKSUuJ16dM
        jM7WFZRGl6uu7KgNEJ5ENhWJGSMfMrjonwSDKIsTbWVAGRSwisnuzMOOivg==
X-Google-Smtp-Source: AB8JxZqVHj/MWVYn5qMY2pcns7EJ0QJeF/iheP2TsduPXUCGLCWPn82XiwkXfs9QTEsx1Ac2RPliretsXcY=
MIME-Version: 1.0
X-Received: by 2002:a81:2904:: with SMTP id p4-v6mr902974ywp.25.1526511598736;
 Wed, 16 May 2018 15:59:58 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:21 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-35-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 34/36] remote: convert match_push_refs to take a struct refspec
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
index 84dda3fd0..0046d4e28 100644
--- a/remote.c
+++ b/remote.c
@@ -1285,23 +1285,20 @@ int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
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
@@ -1310,7 +1307,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		const struct refspec_item *pat = NULL;
 		char *dst_name;
 
-		dst_name = get_ref_match(&rs, ref, send_mirror, FROM_SRC, &pat);
+		dst_name = get_ref_match(rs, ref, send_mirror, FROM_SRC, &pat);
 		if (!dst_name)
 			continue;
 
@@ -1359,7 +1356,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 				/* We're already sending something to this ref. */
 				continue;
 
-			src_name = get_ref_match(&rs, ref, send_mirror, FROM_DST, NULL);
+			src_name = get_ref_match(rs, ref, send_mirror, FROM_DST, NULL);
 			if (src_name) {
 				if (!src_ref_index.nr)
 					prepare_ref_index(&src_ref_index, src);
@@ -1372,8 +1369,6 @@ int match_push_refs(struct ref *src, struct ref **dst,
 		string_list_clear(&src_ref_index, 0);
 	}
 
-	refspec_clear(&rs);
-
 	if (errs)
 		return -1;
 	return 0;
diff --git a/remote.h b/remote.h
index 9050ff75a..74c557457 100644
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

