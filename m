Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C8AC7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239810AbjFGKmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239645AbjFGKmD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:42:03 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBA31BFD
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:42:01 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-565cfe4ece7so80374947b3.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134520; x=1688726520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGbCNYkwoJB1yHBWHL4MDXOa1qaRRZdalmL1mP4pZ18=;
        b=CkI9YeLvoVEeKQO3oqa/1od/xRBszMBtMG4JXrhxD1kicECZyPGjXVKBz+ZX40vWFd
         AK/b/qC7oQtFBlDKVR6WX0lRvdsHvINmGC98nxy77aWUI3VjdlpPlSBJ2tYmmIGCRJUX
         lE+e6KTmbVOGfrqWu6cQhrbrB/eXlOtnzfufMZRYvhJKniga/uJjSBMVUD7sMLi1l0D/
         mP9MExWlgcEAvz7EnmChiqj+KXWyfxiAgHPVRX4UnMcFdB2CD4Vaf8hABNkYYEEjxlPw
         O1NnvKaTWtmOOYH04upINnhLNp3Vx6u2iPuztVXQaUIxvnPVitMxZ5Md/+FKeJwHGPa1
         TBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134520; x=1688726520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGbCNYkwoJB1yHBWHL4MDXOa1qaRRZdalmL1mP4pZ18=;
        b=hObtv1A5mlv7O4mp2gC01nISJS95KAEnmH+ZkZ5+1Io/+xvUPQMg5gQPT4LkyeXem8
         xtd/H2RfWaB5SturQ8YljN4I8341Lv5xmPlLM3y/T1LTH9R+VX6PMz3dYEVv1cYJQkRg
         lC2Ky81NXJyY/CWhSblHxavr800gisPBs6b4xqAqvnzxBKceriRfT0qlysDQjVVJfth8
         LgHQ3+AT+xrUeSsasMOAOi4LNYzwYJKOZbJSLIQ+jz/zkqSS9scK4e4eoHPXinxsBC2v
         21Kym2nQuR3qsFrppO0S1sIIniBxy2McHFV1cJ42kZ6DM3HcIX0yjMKjWm7BA4a6TJOr
         5rcA==
X-Gm-Message-State: AC+VfDzQe8rUX+4j5QCRK3+SUrtUH79gBlwf2VCPkZxsfQg6016NU9ho
        k4PMOyk+6XYry1sLIZm3pGbaJwCkSoAVo9nZouDvGIhq
X-Google-Smtp-Source: ACHHUZ73mwPowwvgH3ZzA1+FfzalGutJ2Ktrz/F8GHO0WRftQmQm0tFi7K1jQi1rXIym+Lp25cc/aQ==
X-Received: by 2002:a81:7245:0:b0:568:8fa1:7a3 with SMTP id n66-20020a817245000000b005688fa107a3mr5597049ywc.5.1686134520270;
        Wed, 07 Jun 2023 03:42:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w11-20020a81a20b000000b0054f9e7fed7asm4711926ywg.137.2023.06.07.03.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:42:00 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:41:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 13/16] refs.h: let `for_each_namespaced_ref()` take
 excluded patterns
Message-ID: <cae703a4253e5c1a7a99fa384ba65bcc3fc613a8.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following commit will want to call `for_each_namespaced_ref()` with
a list of excluded patterns.

We could introduce a variant of that function, say,
`for_each_namespaced_ref_exclude()` which takes the extra parameter, and
reimplement the original function in terms of that. But all but one
caller (in `http-backend.c`) will supply the new parameter, so add the
new parameter to `for_each_namespaced_ref()` itself instead of
introducing a new function.

For now, supply NULL for the list of excluded patterns at all callers to
avoid changing behavior, which we will do in the subsequent commit.

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
index ec4d5b9101..95a7db9563 100644
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
index a7751a1fc9..f23626beca 100644
--- a/refs.h
+++ b/refs.h
@@ -372,7 +372,8 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
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
2.41.0.16.g26cd413590

