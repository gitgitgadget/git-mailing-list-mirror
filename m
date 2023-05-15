Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CCEC7EE24
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbjEOTYn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245193AbjEOTYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:24:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8C1493C
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:53 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba1815e12efso11344589276.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178632; x=1686770632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HtU7LeqJ0h33agazXgkUWegoqSRW4Mp/thJTpGp+iiw=;
        b=XUZGnt/lstqU5vwSn5cDnO56IpiylZkxiqotaQGUlq2X30zJ9uNA2Gem0fakLR8ujM
         NTjydJ/i9UgCPRyXd2Mmk0utSR66hEWpHOGI7WLlPvRvyMuoByyhkLpO70mkQgdGZQ9X
         0JGP8LLumQdRD9nIJqc1g5tdA2qUIZOQHb6eWPHxozScx0BgbfD7f9Ka0IFKhbtUFbZA
         bl/rw+t9Jcurik1DHrjtxFtpN++wLs+yXzp3gEs7AEFczVCIB8Wxtut3mFHvbAKstuZ4
         xebgvWQlf3ElmKM68Ag+zC2a7vg0EFTsecmoZcj7Q87RgDHb5RwzhyMWkmy73E6LG8Mq
         Sl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178632; x=1686770632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtU7LeqJ0h33agazXgkUWegoqSRW4Mp/thJTpGp+iiw=;
        b=fEXQwXzWcw+qecmEThd2goASo+Au8rGwyeV3ScfUWNIgbXjTMoVkqtbwmFjnvUxFwh
         u5ke4u8LAT0sR9o4t86WqE4iEI3aU1P7AFhCMwebTHJrgS5EMzX/laMDq69geuDyh26S
         e2V4zcu8kQu3FFWfJgn2C/ZKrRdJziAIExb2iCKB5usaOdpGtAMUFYohuenaxms8RrNg
         bOhn1l9bVwtUxI6ZkMSoE1wjYXcV6r4XIYPgoQxBRBX8OenNyaOu1FowaeLGXx0Edufj
         mbN2YXYkQkCIFSVwQWhx4dlFE6mg4RbpDChRQJUzgQcadjJ8whb+tmksL+D0d3hieDrG
         Ky1g==
X-Gm-Message-State: AC+VfDzacaVACVed575gMF06YKcoDmmgyXNeoTUmdbd+8m/IAF6/nGaG
        psamFmBb5lWUc3CvJgX3JfH6Oi5ivye0uztkHEiBQg==
X-Google-Smtp-Source: ACHHUZ58IFsWur8qhzhcYE+sAwoIJnOBX33bYFdZo+d0WECH0JvCO1rRlXWaFZYf2EMfaIKPpTEn6Q==
X-Received: by 2002:a25:26cc:0:b0:ba1:e7f2:8369 with SMTP id m195-20020a2526cc000000b00ba1e7f28369mr32175974ybm.40.1684178632147;
        Mon, 15 May 2023 12:23:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z1-20020a056902054100b00b9de731247csm8743ybs.54.2023.05.15.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:51 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 15/16] upload-pack.c: avoid enumerating hidden refs where
 possible
Message-ID: <2331fa7a4d0ef0ed2445b25064e2b3270bed5d2b.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
index 7c646ea5bd..6fa667bf25 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -601,11 +601,32 @@ static int get_common_commits(struct upload_pack_data *data,
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
@@ -854,7 +875,7 @@ static void deepen(struct upload_pack_data *data, int depth)
 		 * marked with OUR_REF.
 		 */
 		head_ref_namespaced(check_ref, data);
-		for_each_namespaced_ref(NULL, check_ref, data);
+		for_each_namespaced_ref_1(check_ref, data);
 
 		get_reachable_list(data, &reachable_shallows);
 		result = get_shallow_commits(&reachable_shallows,
@@ -1378,7 +1399,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		if (advertise_refs)
 			data.no_done = 1;
 		head_ref_namespaced(send_ref, &data);
-		for_each_namespaced_ref(NULL, send_ref, &data);
+		for_each_namespaced_ref_1(send_ref, &data);
 		/*
 		 * fflush stdout before calling advertise_shallow_grafts because send_ref
 		 * uses stdio.
@@ -1388,7 +1409,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(check_ref, &data);
-		for_each_namespaced_ref(NULL, check_ref, &data);
+		for_each_namespaced_ref_1(check_ref, &data);
 	}
 
 	if (!advertise_refs) {
-- 
2.40.1.572.g5c4ab523ef

