Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BD5C7EE23
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjFGKmh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239710AbjFGKmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:42:24 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FEF1BF1
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:42:11 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-565bd368e19so76372147b3.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134530; x=1688726530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CfxZiFyK3h2tCysbyRnTB46yuTEa8xu8x3OV/PpqJQk=;
        b=lt7Zr0lSZUh6cveu/cZwXoVmFhNMkyUvjJ7gGNcUGK38MjN2WrOEsLXSnkuJQtyudH
         Vu72yrE/qFmb9NDhv5JUXP7bclDdaj5WkMs4AUN/4W5vpPQI0IkSqZPUHbrcci71wbkk
         Ki/aXpRaq3nEhTzKnN6cA8xujTIJcE+0moPkX1v4iilZmoA92DfRdfNk4Lth2b0kTLo4
         6+VKbsWPtSck9/Xjkx4L2BcC3c8k0IYa88gcv2hF+qwvS1G3OPxIyFOa+4q/GCHkkj9d
         W1p9Azajw3LaBiL0TD99lzN95PmXpN4t3yQsYKRICuY0J5ORrPI2G3HsWuGPjusfCKga
         mnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134530; x=1688726530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfxZiFyK3h2tCysbyRnTB46yuTEa8xu8x3OV/PpqJQk=;
        b=RvH1BLt5Y2z+11L+CZCua4ClyD9WA6AtMaRvMuhgNlDtgbHOBjUR4lFYkEyyWwcXZ8
         wVcRFneXt7Qkk07064dCqHbrqhGO1tkXUNso9VV1jXYw07+rliqkJlKby8jvweuVcvTK
         1re0eQasitkn6wdwNqXpC/LdalbPJesflCw6y4uZxrCAa7YlX/FmyPXE141zDpbpIQc6
         b+Dc6xBZnFH713X3nHDmUxqsv2bkFhzacXebT/Zc+Zk4lRuHQZydGTICEJTXJQWeMQ/j
         +/8CnLMYHyzDbsr9lS/gtstYOIylZ23e7vqhFQOyw+o1P2bp7fjRYRD7iSWAn8r+LiyV
         1fpA==
X-Gm-Message-State: AC+VfDxDFFkLbXmdI4n5wWmuUeVNJXlCMj1MJmhhiODcaoZgAz12YRmn
        6gXgMD2/+RgaAHhAP0GAZ4gpdWmXIh7WuMFyJNDFD+Ft
X-Google-Smtp-Source: ACHHUZ63TmvZ1An+C68lbFE2gfsWOxhUdmAIkfk5RubgCr/57WiwHhHZuBegv5voHLNX5THsqIY/7w==
X-Received: by 2002:a81:6006:0:b0:568:ada0:f9ea with SMTP id u6-20020a816006000000b00568ada0f9eamr5814854ywb.49.1686134530019;
        Wed, 07 Jun 2023 03:42:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x186-20020a817cc3000000b00545a081849esm4753549ywc.46.2023.06.07.03.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:42:09 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:42:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 15/16] upload-pack.c: avoid enumerating hidden refs where
 possible
Message-ID: <014243ebe6586313b38fe0eb2a57941b27131423.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar fashion as a previous commit, teach `upload-pack` to avoid
enumerating hidden references where possible.

Note, however, that there are certain cases where cannot avoid
enumerating even hidden references, in particular when either of:

  - `uploadpack.allowTipSHA1InWant`, or
  - `uploadpack.allowReachableSHA1InWant`

are set, corresponding to `ALLOW_TIP_SHA1` and `ALLOW_REACHABLE_SHA1`,
respectively.

When either of these bits are set, upload-pack's `is_our_ref()` function
needs to consider the `HIDDEN_REF` bit of the referent's object flags.
So we must visit all references, including the hidden ones, in order to
mark their referents with the `HIDDEN_REF` bit.

When neither `ALLOW_TIP_SHA1` nor `ALLOW_REACHABLE_SHA1` are set, the
`is_our_ref()` function considers only the `OUR_REF` bit, and not the
`HIDDEN_REF` one. `OUR_REF` is applied via `mark_our_ref()`, and only
to objects at the tips of non-hidden references, so we do not need to
visit hidden references in this case.

When neither of those bits are set, `upload-pack` can potentially avoid
enumerating a large number of references. In the same example as a
previous commit (linux.git with one hidden reference per commit,
"refs/pull/N"):

    $ printf 0000 >in
    $ hyperfine --warmup=1 \
      'git -c transfer.hideRefs=refs/pull upload-pack . <in' \
      'git.compile -c transfer.hideRefs=refs/pull -c uploadpack.allowTipSHA1InWant upload-pack . <in' \
      'git.compile -c transfer.hideRefs=refs/pull upload-pack . <in'
    Benchmark 1: git -c transfer.hideRefs=refs/pull upload-pack . <in
      Time (mean ± σ):     406.9 ms ±   1.1 ms    [User: 357.3 ms, System: 49.5 ms]
      Range (min … max):   405.7 ms … 409.2 ms    10 runs

    Benchmark 2: git.compile -c transfer.hideRefs=refs/pull -c uploadpack.allowTipSHA1InWant upload-pack . <in
      Time (mean ± σ):     406.5 ms ±   1.3 ms    [User: 356.5 ms, System: 49.9 ms]
      Range (min … max):   404.6 ms … 408.8 ms    10 runs

    Benchmark 3: git.compile -c transfer.hideRefs=refs/pull upload-pack . <in
      Time (mean ± σ):       4.7 ms ±   0.2 ms    [User: 0.7 ms, System: 3.9 ms]
      Range (min … max):     4.3 ms …   6.1 ms    472 runs

    Summary
      'git.compile -c transfer.hideRefs=refs/pull upload-pack . <in' ran
       86.62 ± 4.33 times faster than 'git.compile -c transfer.hideRefs=refs/pull -c uploadpack.allowTipSHA1InWant upload-pack . <in'
       86.70 ± 4.33 times faster than 'git -c transfer.hideRefs=refs/pull upload-pack . <in'

As above, we must visit every reference when
uploadPack.allowTipSHA1InWant is set. But when it is unset, we can visit
far fewer references.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 upload-pack.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 99d216938c..366a101d8d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -602,11 +602,32 @@ static int get_common_commits(struct upload_pack_data *data,
 	}
 }
 
+static int allow_hidden_refs(enum allow_uor allow_uor)
+{
+	return allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1);
+}
+
+static void for_each_namespaced_ref_1(each_ref_fn fn,
+				      struct upload_pack_data *data)
+{
+	/*
+	 * If `data->allow_uor` allows fetching hidden refs, we need to
+	 * mark all references (including hidden ones), to check in
+	 * `is_our_ref()` below.
+	 *
+	 * Otherwise, we only care about whether each reference's object
+	 * has the OUR_REF bit set or not, so do not need to visit
+	 * hidden references.
+	 */
+	if (allow_hidden_refs(data->allow_uor))
+		for_each_namespaced_ref(NULL, fn, data);
+	else
+		for_each_namespaced_ref(data->hidden_refs.v, fn, data);
+}
+
 static int is_our_ref(struct object *o, enum allow_uor allow_uor)
 {
-	int allow_hidden_ref = (allow_uor &
-				(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
-	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
+	return o->flags & ((allow_hidden_refs(allow_uor) ? HIDDEN_REF : 0) | OUR_REF);
 }
 
 /*
@@ -855,7 +876,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		 * marked with OUR_REF.
 		 */
 		head_ref_namespaced(check_ref, data);
-		for_each_namespaced_ref(NULL, check_ref, data);
+		for_each_namespaced_ref_1(check_ref, data);
 
 		get_reachable_list(data, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
@@ -1386,7 +1407,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		if (advertise_refs)
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
-		for_each_namespaced_ref(NULL, send_ref, &data);
+		for_each_namespaced_ref_1(send_ref, &data);
 		if (!data.sent_capabilities) {
 			const char *refname = "capabilities^{}";
 			write_v0_ref(&data, refname, refname, null_oid());
@@ -1400,7 +1421,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(check_ref, &data);
-		for_each_namespaced_ref(NULL, check_ref, &data);
+		for_each_namespaced_ref_1(check_ref, &data);
 	}
 
 	if (!advertise_refs) {
-- 
2.41.0.16.g26cd413590

