Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18776C7EE26
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjEHWAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjEHWAb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:00:31 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB773903E
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:00:25 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a20a56a01so91312117b3.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583225; x=1686175225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aueWem9Nh6l2gkOjVe2yRUwgpcAYekX6zI5oPbxFPwM=;
        b=no9fTKDqCaD226BI8mbWcFfE3Cuo1sX+ryaTZmBLd6Tn3Wx014lKReTIAWkk0Ar/LI
         Wx3D5qYFa9JVaYJYTKmjAiIwdl90kM4USSHnLr2szMBOWYPohSzyc+gxei6wdMM+Tdim
         XyshWg9mXRjGiXMKEnzHP1TSG0li6LD1y2rTq5Pai+H1Mup2jgQKbICsl646krv+f1Hk
         /qJQV/bwWc8xMMheyTRPZXfo664gR4zziq/Ydb0QamFV3Lqj2JGYYNEcFqQYLCw9YyH4
         F57101M23b0xL8TyMYp9Rkkvv+Enr3tMRDb2swvI4X1wuAh3ac/tUNhl0/t0KxvNQOs2
         R36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583225; x=1686175225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aueWem9Nh6l2gkOjVe2yRUwgpcAYekX6zI5oPbxFPwM=;
        b=Dw5FnXbzMlSzjjFyJPwGRTywj0emfQo0ZW/Etj3tA8gYFLCz6UTtDH+voVXGzgUwEZ
         aWZtCypy62CcxmmdL0h3LiXX03Imxjhs/DhL3/pi7DbzRzACwXkvFHWPd1xApWc8zv6G
         J8JTEAWsN/iCCwimdp55V3Hk+B4wFFnHo9ahtIRwfgqVV6h2CMnrJdgJw37097H4jxME
         273TSu7nnYPAn+NueyoWTe2QBkK3GxwiGWVFtK3iFCa8mH2aXUjd7mn4CLYKVi747gSN
         FeyxEfNv8uBsafq2kagbOyvskc4gnqK3PO6uGgkjYzuaVWReQtiDD/hpHVbd0k5I37p2
         PXmg==
X-Gm-Message-State: AC+VfDwExTwLYgSGPDyKboXnzN0hEFSz/I5LUgblYAxFu8zrUki5ZLi+
        wECyqS2VxODNovPoqLtLB0Us73RUfS7xGmlcRNiSYA==
X-Google-Smtp-Source: ACHHUZ5QX3qRkdIzJ6F8/1SEWE3PF8kksHJBA+nWIoujnIEji53Ck6ZZeUKGJiCqANo+inMYLiXN8Q==
X-Received: by 2002:a81:7d02:0:b0:55a:88f0:a49c with SMTP id y2-20020a817d02000000b0055a88f0a49cmr13911576ywc.33.1683583224734;
        Mon, 08 May 2023 15:00:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d136-20020a0ddb8e000000b0054f6ca85641sm2809226ywe.99.2023.05.08.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:00:24 -0700 (PDT)
Date:   Mon, 8 May 2023 18:00:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/15] refs.h: let `for_each_namespaced_ref()` take excluded
 patterns
Message-ID: <c65b3dea815cee24785a5ec8cf568587a94299ee.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
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
index d77d58bdde..7c646ea5bd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -854,7 +854,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		 * marked with OUR_REF.
 		 */
 		head_ref_namespaced(check_ref, data);
-		for_each_namespaced_ref(check_ref, data);
+		for_each_namespaced_ref(NULL, check_ref, data);
 
 		get_reachable_list(data, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
@@ -1378,7 +1378,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		if (advertise_refs)
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
-		for_each_namespaced_ref(send_ref, &data);
+		for_each_namespaced_ref(NULL, send_ref, &data);
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref
 		 * uses stdio.
@@ -1388,7 +1388,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(check_ref, &data);
-		for_each_namespaced_ref(check_ref, &data);
+		for_each_namespaced_ref(NULL, check_ref, &data);
 	}
 
 	if (!advertise_refs) {
-- 
2.40.1.477.g956c797dfc

