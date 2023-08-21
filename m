Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A60EE49A5
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjHUUV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHUUVz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:21:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048EDE4
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:21:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d665467e134so3922734276.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692649313; x=1693254113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vw45rwI/zC87UjvXDzcR0PKND8+Z8+JuNg+e6RHozoc=;
        b=dEZBoHC5ZNXowAHd+ZqAeEQ1zbxwHu8wTRB6wcGm08YhmPBrcdt9d08CVG5IIuQJ0n
         wyp50UBi2xxW5/Wo6fiWhRMLoVVwaqipmz90iP0L0GGIroQ19WI/XGoDKnRXERH09QMv
         bapuZpVix/1UmYlHp5/QjfmfIQjVNE+Au68lJwr63/B07Hi++6K8ptx5VIKWKFo1R5xZ
         KCiWm+QVRp8hb5n2d234do2sNalteCHNiMYyPjegXgY+ymFR94ZuTgQE6HA9fiItXkju
         DrT4mLJSiyXnCwf9s0CoJZ0hfrJIocGiW+jhSbYB9YrPNnKFP9UN8SYrrGHNPNAJ73Kv
         YHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692649313; x=1693254113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vw45rwI/zC87UjvXDzcR0PKND8+Z8+JuNg+e6RHozoc=;
        b=VBVLMkQSdlshelvKXU6ipwJPouu9NNbHEKBY+4CPosOvAvpoUbloBqDsEHEQU4/nTj
         jmuIvK231mMDaL9y8U+mYnrO9iCPWrmOcIvkMo3aGf78zPqtv8/KWiQUjdh0XdQHEdqU
         heO0/bDxQxBYiKIUiAh4YzN3ijb4F9XnAAADtsMyppxjx7AM68iXAxZw3oCMtJn8R/3N
         X5cLk27eLUiUc/OR8OlZCiQ0CwiXhS2rn0Uo53G1/nKfKQh25jEcT26AaVvuwrbnD2wo
         bkI87RBrVDaJS3RrAz+cjm2EXFYIvO8JT/mtdeNZV2bM1v2NsWAD6clLOGcUILW0IeKB
         XLwQ==
X-Gm-Message-State: AOJu0YzafS7DpzuHa6g6icULf6dhkrKnJylEM/L+00f89bOp3Iep/nfv
        5pbUekTH4FUYpRPlyCTeXao/1A==
X-Google-Smtp-Source: AGHT+IE7u3BNskOzy9KGmCQIJn26xJNR6nZ+d4qBRpmlq8rcJlg7GYkwIWTJZjzLJInf6ps9ZVPWrg==
X-Received: by 2002:a25:ce47:0:b0:c2c:7665:9a57 with SMTP id x68-20020a25ce47000000b00c2c76659a57mr8552252ybe.64.1692649313109;
        Mon, 21 Aug 2023 13:21:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q7-20020a258207000000b00d607f70d762sm1952044ybk.32.2023.08.21.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 13:21:52 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:21:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/6] bloom: annotate filters with hash version
Message-ID: <ZOPHXcTMlB77CsCh@nand.local>
References: <e23a956401c5619bd46e8ec9b0e1df958cbcbfec.1691426160.git.me@ttaylorr.com>
 <20230811214651.3326180-1-jonathantanmy@google.com>
 <ZN57Gsz+wk9n6/Da@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZN57Gsz+wk9n6/Da@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2023 at 03:55:06PM -0400, Taylor Blau wrote:
> > Another thing that we might want to track is whether the Bloom filter is
> > a reference to an existing buffer (and thus does not need to be freed)
> > or a reference to a malloc-ed buffer that we must free. But both before
> > and after this patch set, a malloc-ed buffer is never overridden by a
> > reference-to-existing-buffer, so we should still be fine for now. (This
> > patch set does add a scenario in which a reference-to-existing buffer is
> > overridden by a malloc-ed buffer, but that's the only new scenario.)
>
> Yeah, I think there is some opportunity for clean-up here. I'll take a
> look...

This ended up being pretty reasonable. I'm not sure whether I should
include it here or not, since any leaks in the Bloom subsystem are
definitely not new as of this series.

But the patch is relatively straightforward anyway, so I think throwing
it on the end would be OK:

--- 8< ---
diff --git a/bloom.c b/bloom.c
index 24dd874e46..ff131893cd 100644
--- a/bloom.c
+++ b/bloom.c
@@ -59,6 +59,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 					sizeof(unsigned char) * start_index +
 					BLOOMDATA_CHUNK_HEADER_SIZE);
 	filter->version = g->bloom_filter_settings->hash_version;
+	filter->to_free = NULL;

 	return 1;
 }
@@ -231,6 +232,18 @@ void init_bloom_filters(void)
 	init_bloom_filter_slab(&bloom_filters);
 }

+static void free_one_bloom_filter(struct bloom_filter *filter)
+{
+	if (!filter)
+		return;
+	free(filter->to_free);
+}
+
+void deinit_bloom_filters(void)
+{
+	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
+}
+
 static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 		       const struct hashmap_entry *eptr,
 		       const struct hashmap_entry *entry_or_key,
@@ -247,7 +260,7 @@ static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 static void init_truncated_large_filter(struct bloom_filter *filter,
 					int version)
 {
-	filter->data = xmalloc(1);
+	filter->data = filter->to_free = xmalloc(1);
 	filter->data[0] = 0xFF;
 	filter->len = 1;
 	filter->version = version;
@@ -449,6 +462,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 			filter->len = 1;
 		}
 		CALLOC_ARRAY(filter->data, filter->len);
+		filter->to_free = filter->data;

 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
 			struct bloom_key key;
diff --git a/bloom.h b/bloom.h
index 4462fc3908..c1d74d63e6 100644
--- a/bloom.h
+++ b/bloom.h
@@ -56,6 +56,8 @@ struct bloom_filter {
 	unsigned char *data;
 	size_t len;
 	int version;
+
+	void *to_free;
 };

 /*
@@ -96,6 +98,7 @@ void add_key_to_filter(const struct bloom_key *key,
 		       const struct bloom_filter_settings *settings);

 void init_bloom_filters(void);
+void deinit_bloom_filters(void);

 enum bloom_filter_computed {
 	BLOOM_NOT_COMPUTED = (1 << 0),
diff --git a/commit-graph.c b/commit-graph.c
index 183ed90b6d..f22f2d350d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2532,6 +2532,9 @@ int write_commit_graph(struct object_directory *odb,

 	res = write_commit_graph_file(ctx);

+	if (ctx->changed_paths)
+		deinit_bloom_filters();
+
 	if (ctx->split)
 		mark_commit_graphs(ctx);

--- >8 ---

Thanks,
Taylor
