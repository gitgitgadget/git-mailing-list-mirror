Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D9FEB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjGJVNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjGJVMn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:43 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D01A8
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:39 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b7206f106cso4038653a34.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023558; x=1691615558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MAOE0b48L7RYO+dNddsG8MKfks+ILkcQuQu91zv6YCs=;
        b=10r5ayQrCqfwXjFUlAlkwKgHWrmWHO8xxO93ObnjYgPSH735EdBq5/IQDOkzFyXl/4
         jPESXLV0g4zhjFb+G025Urpt81H5aYvYBIBO/86ISXjwwnvWjdrDRMty27lmgqFZuWIz
         ylx0HaXoPRD2fh7Ctac1rOH0T6BilzVwb3/DNdmqvqPB9JEgfIZKzDODsy/ihOVgpreS
         9FekrJ2MRRuQnzu1V4JYQbJRwMgML9WXhkG0MGR1Fdu6qCbypAykM3kei5HPO1cGw/Bz
         4GMCItmBwHo+e1ibUItow3LaTYSVlSnrOhJV2TvKIjOdH5i1DZLknep5dvDw/7LOHXgd
         b5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023558; x=1691615558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAOE0b48L7RYO+dNddsG8MKfks+ILkcQuQu91zv6YCs=;
        b=OZGKQRWmjyRNoXmTFzUvFk/nsLcTZqhKyZyuHj0mi8672j1SJvuCVdeG9MtmTvKTl3
         Wj9tEj6P+SBCuUBPMyuCwm06wA7ATx6z6pp3OW770hAe9QJm60jriZ3DIl9w9Aam0GMr
         CMUDfMLoB+hTSz9hBpM9yjX5ysksnraI7+HQ6/hSdoj0vg45sgiZ/vFxdnaVqqju1iHZ
         KLeePmGuAKkTs72moG9Tev8OgvptII9Y7uNV+7hfn8dztqN526tBmyILhOljARUSypi+
         O8j8x9Y0RzonYyUYUvgTkQfUZhiBJeFGAdYPi00yWn/RqFjw5yXxRKEQYzVDk8XJTfMX
         nQ/A==
X-Gm-Message-State: ABy/qLZWvdGJTuDHIbtxRSyDnkMR9D88GsSz3FcyX34hNVzE26JaQIHS
        U/PWoJI5fhrPa5g3bSjE6LmJVXZzVdPwqp4ec8R+iA==
X-Google-Smtp-Source: APBJJlGlVEvQj+E/Bbyb/m7KAXoUoekG8y6psxC5jD8XbXmhSm8qbfQG0ZHOwrbzNIIk9Gz8841oDQ==
X-Received: by 2002:a05:6830:2001:b0:6b9:6287:618b with SMTP id e1-20020a056830200100b006b96287618bmr3008107otp.24.1689023558094;
        Mon, 10 Jul 2023 14:12:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j63-20020a25d242000000b00bcf788d09e3sm141931ybg.34.2023.07.10.14.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:37 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 12/16] refs.h: let `for_each_namespaced_ref()` take
 excluded patterns
Message-ID: <7e72c23c8a4e579d324446910e8b680cca560d8a.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
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
 refs.h         | 7 ++++++-
 upload-pack.c  | 6 +++---
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index e1969c05dc6..895fac35f79 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -560,7 +560,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 
 	} else {
 		select_getanyfile(hdr);
-		for_each_namespaced_ref(show_text_ref, &buf);
+		for_each_namespaced_ref(NULL, show_text_ref, &buf);
 		send_strbuf(hdr, "text/plain", &buf);
 	}
 	strbuf_release(&buf);
diff --git a/refs.c b/refs.c
index 64dabc40cae..3065e514fd0 100644
--- a/refs.c
+++ b/refs.c
@@ -1662,13 +1662,14 @@ int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_dat
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
index fa3ce4b0bc1..7871faed632 100644
--- a/refs.h
+++ b/refs.h
@@ -382,7 +382,12 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data);
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data);
+/*
+ * references matching any pattern in "exclude_patterns" are omitted from the
+ * result set on a best-effort basis.
+ */
+int for_each_namespaced_ref(const char **exclude_patterns,
+			    each_ref_fn fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
diff --git a/upload-pack.c b/upload-pack.c
index cfb61ccbb5c..da4f17f64ac 100644
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
@@ -1392,7 +1392,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		if (advertise_refs)
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
-		for_each_namespaced_ref(send_ref, &data);
+		for_each_namespaced_ref(NULL, send_ref, &data);
 		if (!data.sent_capabilities) {
 			const char *refname = "capabilities^{}";
 			write_v0_ref(&data, refname, refname, null_oid());
@@ -1406,7 +1406,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(check_ref, &data);
-		for_each_namespaced_ref(check_ref, &data);
+		for_each_namespaced_ref(NULL, check_ref, &data);
 	}
 
 	if (!advertise_refs) {
-- 
2.41.0.343.gdff068c469f

