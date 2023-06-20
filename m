Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8ACEB64DB
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjFTOWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjFTOWN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:22:13 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34D61716
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:11 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so4803428276.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270931; x=1689862931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpcWF2jAHxAHKQccqpTeP8CuLS7UORpMTKc4CxvmPsM=;
        b=isUgNBVppCqzjHGI1QMCFec4ENDHnhKlI2y4MuOJi2BpC02o7U8eplF6ewTrHHznQ7
         Vnb12SjOWL2SWUqKwUdFjMBZrTRxqbQdMXrqKM5TeIVYcVcK1RW8DFNYbtMW77X36kSI
         wEREIpISBexoFP8jFHdSR2iyBP8iWS29pK5HXYHfKr8LL1FTiZ78JyRCSSKaMHKYf7+6
         Q24vgC/btq27YQTwltwowosmu/qH6t2iizVPVaqT3aQI69moDQ7BvXMvSFLyBcmRZhLZ
         RqQYJQMdsOeBBMK7TKeLmJzE/cVlq4uOxGzUpROL7AfINo48lpRVneIhz9xrEZQ973mi
         vECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270931; x=1689862931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpcWF2jAHxAHKQccqpTeP8CuLS7UORpMTKc4CxvmPsM=;
        b=OlOkc1MTX+Rs/CEBs8JTJ+L4NjQbxd86bPIox59njQaDW0sJkAoSZzZlYvA6MHgj5a
         wYnoFsHoVja96UL4wjbBDCrAgDx0yTqgGbAIlxVTuwRE6tqIumap1HdgSWTcZgH7yOdO
         FxUpvq62lg9mG+EjwhcJTwUsPJCHqUIYZes+eyADSr5ldAhydx34YrTci4w7APglrKbi
         L4c7414PkVuZS5BPTyYY6mcwFRYFs5RPy923SEfMl2e+yMn0iqRhTN7+/SphVizFQX30
         /D//aKst6mTom8Jn6lluxrJhCClGXztLL/8Pht4zZkRaDOh515Wlarlzghdl7XFQwF+P
         a+RQ==
X-Gm-Message-State: AC+VfDwrZHaGbzIwxKl+F8OZurRVRjGcL5DzEJrmGc6frYgVOiZk0gG1
        6pqUss5ty89LwvSQl4e5RFttYDdaJ2Gw5aPh7yE4oXYZ
X-Google-Smtp-Source: ACHHUZ54gIyEpF75erHmmNwei3NWmX/cwNsxKVV+Rn2bcLQS6GOzXpvqYRpLN2lyMxCbJNF7twlvmQ==
X-Received: by 2002:a25:b195:0:b0:bc6:cf90:a286 with SMTP id h21-20020a25b195000000b00bc6cf90a286mr9861479ybj.36.1687270931036;
        Tue, 20 Jun 2023 07:22:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u28-20020a25f81c000000b00ba773472647sm391517ybd.19.2023.06.20.07.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:22:10 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:22:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 13/16] refs.h: let `for_each_namespaced_ref()` take
 excluded patterns
Message-ID: <8d4d7cc22ee5ae8093ff06c127948356dbe6d501.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future commit will want to call `for_each_namespaced_ref()` with
a list of excluded patterns.

We could introduce a variant of that function, say,
`for_each_namespaced_ref_exclude()` which takes the extra parameter, and
reimplement the original function in terms of that. But all but one
caller (in `http-backend.c`) will supply the new parameter, so add the
new parameter to `for_each_namespaced_ref()` itself instead of
introducing a new function.

For now, supply NULL for the list of excluded patterns at all callers to
avoid changing behavior, which we will do in a future change.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 http-backend.c | 2 +-
 refs.c         | 5 +++--
 refs.h         | 3 ++-
 upload-pack.c  | 6 +++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index ac146d85c5..ad500683c8 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -559,7 +559,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 
 	} else {
 		select_getanyfile(hdr);
-		for_each_namespaced_ref(show_text_ref, &buf);
+		for_each_namespaced_ref(NULL, show_text_ref, &buf);
 		send_strbuf(hdr, "text/plain", &buf);
 	}
 	strbuf_release(&buf);
diff --git a/refs.c b/refs.c
index 1f01fdf9e8..8613184703 100644
--- a/refs.c
+++ b/refs.c
@@ -1660,13 +1660,14 @@ int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_dat
 				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+int for_each_namespaced_ref(const char **exclude_patterns,
+			    each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
 	ret = do_for_each_ref(get_main_ref_store(the_repository),
-			      buf.buf, NULL, fn, 0, 0, cb_data);
+			      buf.buf, exclude_patterns, fn, 0, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
diff --git a/refs.h b/refs.h
index f091741bfa..27d341d282 100644
--- a/refs.h
+++ b/refs.h
@@ -378,7 +378,8 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data);
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
+int for_each_namespaced_ref(const char **exclude_patterns,
+			    each_ref_fn fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
diff --git a/upload-pack.c b/upload-pack.c
index 1a213ed775..99d216938c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -855,7 +855,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		 * marked with OUR_REF.
 		 */
 		head_ref_namespaced(check_ref, data);
-		for_each_namespaced_ref(check_ref, data);
+		for_each_namespaced_ref(NULL, check_ref, data);
 
 		get_reachable_list(data, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
@@ -1386,7 +1386,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		if (advertise_refs)
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
-		for_each_namespaced_ref(send_ref, &data);
+		for_each_namespaced_ref(NULL, send_ref, &data);
 		if (!data.sent_capabilities) {
 			const char *refname = "capabilities^{}";
 			write_v0_ref(&data, refname, refname, null_oid());
@@ -1400,7 +1400,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(check_ref, &data);
-		for_each_namespaced_ref(check_ref, &data);
+		for_each_namespaced_ref(NULL, check_ref, &data);
 	}
 
 	if (!advertise_refs) {
-- 
2.41.0.44.gf2359540d2

